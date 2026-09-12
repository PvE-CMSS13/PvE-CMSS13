GLOBAL_LIST_EMPTY(human_ai_brains)

/datum/human_ai_brain
	/// The human that this brain ties into
	var/mob/living/carbon/human/tied_human

	var/micro_action_delay = 0.2 SECONDS
	var/short_action_delay = 0.5 SECONDS
	var/medium_action_delay = 2 SECONDS
	var/long_action_delay = 5 SECONDS
	/// Global multiplier for all AI action delays
	var/action_delay_mult = 2 // Doubled from 1, gives hAI a believable time between actions

	/// If TRUE, shoots until the target is dead. Else, stops when downed
	var/shoot_to_kill = TRUE

	/// Distance for view checks
	var/view_distance = 6

	/// Should we limit our FOV in case view_distance is more than 7
	var/scope_vision = TRUE

	/// List of whitelisted/blacklisted action datums
	var/list/action_whitelist = null
	var/list/action_blacklist = null

	/// List of current action datums
	var/list/ongoing_actions = list()

	/// Semi-permanent "order" datum. Does not expire
	var/datum/ai_order/current_order

	/// A targeted turf that we should quickly approach
	var/turf/quick_approach

	/// Nearby turfs that we're watching for bullets
	var/list/detection_turfs = list()

	/// If TRUE, then we're actively fighting someone or saw a bullet go by or saw someone else go into combat
	var/in_combat = FALSE

	/// The minimum amount of time that can pass before this AI can leave combat
	var/combat_decay_time_min = 15 SECONDS
	/// The maximum amount of time that can pass before this AI can leave combat
	var/combat_decay_time_max = 30 SECONDS

	/// If this AI can seek cover while not possessing a gun
	var/cover_without_gun = FALSE

	/// The chance that the AI will leave cover when exiting combat
	var/peek_cover_chance = 60

	/// Factions that the AI won't engage in hostilities with. Controlled by the AI's faction
	var/list/friendly_factions = list()
	/// Factions that the AI will not become hostile to unless attacked
	var/list/neutral_factions = list()

	/// The last faction that the AI was/is a part of
	var/previous_faction

	/// If FALSE, cannot be assigned to a squad
	var/can_assign_squad = TRUE

	/// Ref to the latest weapon we've drawn as a melee
	var/obj/item/drawn_melee_weapon

	/// If TRUE, the AI will not move at all
	var/hold_position = FALSE

/datum/human_ai_brain/New(mob/living/carbon/human/tied_human)
	. = ..()
	src.tied_human = tied_human
	RegisterSignal(tied_human, COMSIG_PARENT_QDELETING, PROC_REF(on_human_delete))
	RegisterSignal(tied_human, COMSIG_HUMAN_EQUIPPED_ITEM, PROC_REF(on_item_equip))
	RegisterSignal(tied_human, COMSIG_HUMAN_UNEQUIPPED_ITEM, PROC_REF(on_item_unequip))
	RegisterSignal(tied_human, COMSIG_MOB_PICKUP_ITEM, PROC_REF(on_item_pickup))
	RegisterSignal(tied_human, COMSIG_MOB_DROP_ITEM, PROC_REF(on_item_drop))
	RegisterSignal(tied_human, COMSIG_MOB_DEATH, PROC_REF(reset_ai))
	RegisterSignal(tied_human, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	RegisterSignal(tied_human, COMSIG_HUMAN_BULLET_ACT, PROC_REF(on_shot))
	RegisterSignal(tied_human, COMSIG_HUMAN_HANDCUFFED, PROC_REF(on_handcuffed))
	RegisterSignal(tied_human, COMSIG_HUMAN_GET_AI_BRAIN, PROC_REF(get_ai_brain))
	RegisterSignal(tied_human, COMSIG_HUMAN_SET_SPECIES, PROC_REF(on_species_change))
	GLOB.human_ai_brains += src
	setup_detection_radius()
	appraise_inventory()
	tied_human.a_intent_change(INTENT_DISARM)

/datum/human_ai_brain/Destroy(force, ...)
	GLOB.human_ai_brains -= src
	tied_human = null

	reset_ai()

	return ..()

/datum/human_ai_brain/proc/reset_ai()
	end_cover()

	in_combat = FALSE
	target_turf = null
	shot_at = null
	drawn_melee_weapon = null
	primary_weapon = null
	gun_data = null
	lose_target()

	for(var/action in ongoing_actions)
		qdel(action)

	ongoing_actions.Cut()
	to_pickup.Cut()
	lose_injured_ally()

/datum/human_ai_brain/process(delta_time)
	if(tied_human.is_mob_incapacitated())
		for(var/action in ongoing_actions)
			qdel(action)
		ongoing_actions.Cut()
		lose_target()
		return

	if(tied_human.resting)
		tied_human.set_resting(FALSE, TRUE)

	if(tied_human.buckled)
		tied_human.set_buckled(FALSE) // AI never buckle themselves into chairs at the moment, change if this becomes the case

	if(!current_target)
		set_target(get_target())

	if(current_target)
		enter_combat()

	if(!iszombie(tied_human))
		item_search(range(2, tied_human))

	// List all allowed action types for AI to consider
	var/list/allowed_actions = action_whitelist || (GLOB.AI_actions.Copy() - action_blacklist)
	for(var/datum/ongoing_action as anything in ongoing_actions)
		if(is_type_in_list(ongoing_action, allowed_actions))
			allowed_actions -= ongoing_action.type

	// Create assoc list of selected AI actions and their weight
	var/list/possible_actions = list()
	for(var/action_type in shuffle(allowed_actions))
		var/datum/ai_action/glob_ref = GLOB.AI_actions[action_type]
		var/weight = glob_ref.get_weight(src)
		if(weight) // No weight means we shouldn't consider this action at all
			possible_actions[action_type] = weight

	// Sorts all allowed actions by their weight
	var/list/sorted_actions = sortTim(possible_actions, GLOBAL_PROC_REF(cmp_numeric_dsc), TRUE)

	// Choose what actions to start in current process() iteration
	for(var/action_type as anything in sorted_actions)
		var/datum/ai_action/possible_action = GLOB.AI_actions[action_type]

		var/list/conflicting_actions = possible_action.get_conflicts(src)
		for(var/datum/ai_action/ongoing_action as anything in ongoing_actions)
			if(ongoing_action.type in conflicting_actions)
				possible_action = null
				break

		if(!possible_action)
			continue

		ongoing_actions += new action_type(src)
#if defined(TESTING) && defined(HUMAN_AI_TESTING)
		message_admins("action of type [action_type] was added to [tied_human.real_name]")
#endif

	for(var/datum/ai_action/action as anything in ongoing_actions)
		var/retval = action.trigger_action()
		switch(retval)
			if(ONGOING_ACTION_UNFINISHED_BLOCK)
				return
			if(ONGOING_ACTION_COMPLETED)
				qdel(action)

/datum/human_ai_brain/proc/set_target(mob/living/new_target)
	if(!new_target)
		return

	RegisterSignal(new_target, COMSIG_PARENT_QDELETING, PROC_REF(on_target_delete), TRUE)
	RegisterSignal(new_target, COMSIG_MOB_DEATH, PROC_REF(on_target_death), TRUE)
	RegisterSignal(new_target, COMSIG_MOVABLE_MOVED, PROC_REF(on_target_move), TRUE)
	current_target = new_target
	target_turf = get_turf(current_target)

/datum/human_ai_brain/proc/lose_target()
	if(current_target)
		UnregisterSignal(current_target, COMSIG_PARENT_QDELETING)
		UnregisterSignal(current_target, COMSIG_MOB_DEATH)
		UnregisterSignal(current_target, COMSIG_MOVABLE_MOVED)
	current_target = null

/datum/human_ai_brain/proc/update_target_pos()
	if(current_target)
		if(tied_human in viewers(view_distance, current_target))
			target_turf = get_turf(current_target)
		else
			COOLDOWN_START(src, fire_offscreen, 2 SECONDS)
			lose_target()

/datum/human_ai_brain/proc/on_target_delete(datum/source, force)
	SIGNAL_HANDLER
	lose_target()
	target_turf = null

/datum/human_ai_brain/proc/on_target_death(datum/source)
	SIGNAL_HANDLER
	lose_target()
	target_turf = null

/datum/human_ai_brain/proc/on_target_move(atom/oldloc, dir, forced)
	SIGNAL_HANDLER
	update_target_pos()

/datum/human_ai_brain/proc/on_human_delete(datum/source, force)
	SIGNAL_HANDLER
	tied_human = null

/datum/human_ai_brain/proc/on_species_change(datum/source, new_species)
	SIGNAL_HANDLER
	if((new_species == SPECIES_YAUTJA) || (new_species == SPECIES_ZOMBIE))
		ignore_looting = TRUE
	else
		ignore_looting = FALSE

/datum/human_ai_brain/proc/setup_detection_radius()
	if(length(detection_turfs))
		clear_detection_radius()

	for(var/turf/open/floor in range(1, tied_human))
		RegisterSignal(floor, COMSIG_TURF_ENTERED, PROC_REF(on_detection_turf_enter))
		detection_turfs += floor

/datum/human_ai_brain/proc/clear_detection_radius()
	for(var/turf/open/floor as anything in detection_turfs)
		UnregisterSignal(floor, COMSIG_TURF_ENTERED)

	detection_turfs.Cut()

/datum/human_ai_brain/proc/on_detection_turf_enter(datum/source, atom/movable/entering)
	SIGNAL_HANDLER
	if(tied_human.client)
		return

	if(entering == tied_human)
		return

	if(istype(entering, /obj/projectile))
		var/obj/projectile/bullet = entering

		enter_combat()

		if(length(neutral_factions))
			if(ismob(bullet.firer))
				var/mob/mob_firer = bullet.firer
				if(mob_firer.faction in neutral_factions)
					on_neutral_faction_betray(mob_firer.faction)

			else if(isdefenses(bullet.firer))
				var/obj/structure/machinery/defenses/defense_firer = bullet.firer
				for(var/faction in defense_firer.faction_group)
					if(faction in neutral_factions)
						on_neutral_faction_betray(faction)

		if(faction_check(bullet.firer))
			return

		if(get_dist(tied_human, bullet.firer) <= view_distance)
			set_target(bullet.firer)
		else
			COOLDOWN_START(src, fire_offscreen, 4 SECONDS)
			target_turf = get_turf(bullet.firer)

/datum/human_ai_brain/proc/on_move(atom/oldloc, direction, forced)
	setup_detection_radius()

	if(in_cover && (get_dist(tied_human, current_cover) > gun_data?.minimum_range))
		end_cover()

	update_target_pos()

/datum/human_ai_brain/proc/enter_combat()
	SIGNAL_HANDLER
	if(squad_id) // call for help
		var/datum/human_ai_squad/squad = SShuman_ai.squad_id_dict["[squad_id]"]
		for(var/datum/human_ai_brain/squaddie as anything in squad.ai_in_squad)
			if(squaddie.target_turf)
				continue
			if(get_dist(squaddie.tied_human, tied_human) > squaddie.view_distance)
				continue
			if(!squaddie.can_target(current_target))
				continue
			squaddie.target_turf = target_turf

	if(tied_human.client)
		return

	if(!in_combat)
		say_in_combat_line()

	if(isxeno(current_target))
		try_cover(Get_Angle(current_target, tied_human), current_target)

	in_combat = TRUE
	addtimer(CALLBACK(src, PROC_REF(exit_combat)), rand(combat_decay_time_min, combat_decay_time_max), TIMER_UNIQUE | TIMER_NO_HASH_WAIT | TIMER_OVERRIDE)
	SShuman_ai.combat_ever_started = TRUE

/datum/human_ai_brain/proc/exit_combat()
	if(tied_human.client)
		return

	if(in_combat)
		tied_human.a_intent_change(INTENT_DISARM)
		lose_target()
		say_exit_combat_line()
		if(!sniper_home)
			holster_primary()
		holster_melee()

	if(current_cover)
		if(!prob(peek_cover_chance))
			target_turf = null
		end_cover()
	else
		target_turf = null

	in_combat = FALSE

/datum/human_ai_brain/proc/on_shot(datum/source, damage_result, ammo_flags, obj/projectile/bullet)
	SIGNAL_HANDLER
	if(tied_human.client)
		return

	enter_combat()

	if(length(neutral_factions))
		if(ismob(bullet.firer))
			var/mob/mob_firer = bullet.firer
			if(mob_firer.faction in neutral_factions)
				on_neutral_faction_betray(mob_firer.faction)

		else if(isdefenses(bullet.firer))
			var/obj/structure/machinery/defenses/defense_firer = bullet.firer
			for(var/faction in defense_firer.faction_group)
				if(faction in neutral_factions)
					on_neutral_faction_betray(faction)

	if(faction_check(bullet.firer))
		return

	if(get_dist(tied_human, bullet.firer) <= view_distance)
		set_target(bullet.firer)
	else
		COOLDOWN_START(src, fire_offscreen, 4 SECONDS)
		target_turf = get_turf(bullet.firer)

	if(!current_cover)
		try_cover(bullet.angle, bullet.firer)
	else if(in_cover)
		on_shot_inside_cover(bullet.angle, bullet.firer)
