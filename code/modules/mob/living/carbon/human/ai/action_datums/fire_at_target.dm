/datum/ai_action/fire_at_target
	name = "Fire At Target"
	action_flags = ACTION_USING_HANDS
	var/rounds_burst_fired = 0
	var/currently_firing

/datum/ai_action/fire_at_target/get_weight(datum/human_ai_brain/brain)
	if(!brain.in_combat)
		return 0

	if(brain.tried_reload)
		return 0

	if(!brain.primary_weapon)
		return 0

	if(!COOLDOWN_FINISHED(brain, stop_fire_cooldown))
		return 0

	var/should_fire_offscreen = (brain.target_turf && !COOLDOWN_FINISHED(brain, fire_offscreen) && (brain.gun_data.maximum_range > brain.view_distance))

	if(!brain.current_target && !should_fire_offscreen)
		return 0

	if((get_dist(brain.tied_human, brain.target_turf) > brain.view_distance) && !should_fire_offscreen)
		return 0

	if(!firing_line_check(brain, brain.target_turf))
		return 0

	if(brain.should_reload())
		return 0

	return 10

/datum/ai_action/fire_at_target/Destroy(force, ...)
	stop_firing(brain)
	return ..()

/datum/ai_action/fire_at_target/proc/stop_firing(datum/human_ai_brain/brain)
	currently_firing = FALSE
	rounds_burst_fired = 0

	UnregisterSignal(brain.tied_human, COMSIG_MOB_FIRED_GUN)
	brain.primary_weapon?.set_target(null)

/datum/ai_action/fire_at_target/trigger_action()
	. = ..()

	var/obj/item/weapon/gun/primary_weapon = brain.primary_weapon
	if(!primary_weapon || brain.active_grenade_found || !COOLDOWN_FINISHED(brain, stop_fire_cooldown))
		return ONGOING_ACTION_COMPLETED

	var/should_fire_offscreen = (brain.target_turf && !COOLDOWN_FINISHED(brain, fire_offscreen))
	if(!brain.current_target && !should_fire_offscreen)
		return ONGOING_ACTION_COMPLETED

	if(currently_firing || !COOLDOWN_FINISHED(brain, fire_overload_cooldown))
		return ONGOING_ACTION_UNFINISHED

	var/mob/living/carbon/tied_human = brain.tied_human
	brain.unholster_primary()

	var/datum/firearm_appraisal/gun_data = brain.gun_data
	gun_data.before_fire(primary_weapon, tied_human, brain)
	if(brain.should_reload())
		if(gun_data?.disposable)
			tied_human.drop_held_item(primary_weapon)
			brain.set_primary_weapon(null)
		return ONGOING_ACTION_COMPLETED

	var/turf/target_turf = brain.target_turf
	if((get_dist(tied_human, target_turf) > gun_data.maximum_range) && !should_fire_offscreen)
		return ONGOING_ACTION_COMPLETED

	tied_human.face_atom(target_turf)
	tied_human.a_intent_change(INTENT_HARM)

	RegisterSignal(tied_human, COMSIG_MOB_FIRED_GUN, PROC_REF(on_gun_fire), TRUE)

	// Handling point-blank through attack()
	var/atom/movable/current_target = brain.current_target
	if(current_target && (get_dist(tied_human, current_target) <= 1))
		currently_firing = FALSE
		primary_weapon.set_target(null)
		INVOKE_ASYNC(tied_human, TYPE_PROC_REF(/mob, do_click), current_target, "", list())
		return ONGOING_ACTION_UNFINISHED

	primary_weapon?.set_target(target_turf)
	primary_weapon?.start_fire(object = target_turf, bypass_checks = TRUE)
	return ONGOING_ACTION_UNFINISHED

/datum/ai_action/fire_at_target/proc/firing_line_check(datum/human_ai_brain/brain, atom/target)
	var/mob/living/carbon/tied_human = brain.tied_human
	var/list/turf_list = get_line(get_turf(tied_human), get_turf(target))
	for(var/turf/tile in turf_list)
		var/tile_dist = get_dist(tied_human, tile)
		if(tile_dist > brain.view_distance)
			continue

		if(tile.density)
			return FALSE

		for(var/obj/thing in tile)
			if(!thing.unacidable || !thing.density)
				continue

			if((tile_dist <= 3) && (thing.projectile_coverage >= PROJECTILE_COVERAGE_HIGH)) // short range we allow for higher projectile coverage to be shot over
				return FALSE
			else if((tile_dist > 3) && thing.projectile_coverage >= PROJECTILE_COVERAGE_MEDIUM)
				return FALSE

		for(var/mob/living/carbon/human/possible_friendly in tile)
			if(possible_friendly == tied_human)
				continue

			if(possible_friendly.body_position == LYING_DOWN)
				continue

			if(brain.faction_check(possible_friendly))
				return FALSE

	return TRUE

/datum/ai_action/fire_at_target/proc/on_gun_fire(datum/source, obj/item/weapon/gun/fired)
	SIGNAL_HANDLER

	if(!brain)
		qdel(src)
		return

	var/turf/target_turf = brain.target_turf

	var/mob/living/carbon/tied_human = brain.tied_human
	tied_human.a_intent_change(INTENT_HARM)

	brain.shot_at = get_turf(target_turf)
	tied_human.face_atom(target_turf)

	currently_firing = TRUE

	var/datum/firearm_appraisal/gun_data = brain.gun_data
	if(brain.should_reload()) // note that bullet removal comes after comsig is triggered
		if(gun_data?.disposable)
			tied_human.drop_held_item(brain.primary_weapon)
			brain.set_primary_weapon(null)
		stop_firing(brain)
		qdel(src)
		return

	var/should_fire_offscreen = (target_turf && !COOLDOWN_FINISHED(brain, fire_offscreen))
	var/shoot_next = brain.current_target

	if(QDELETED(brain.current_target))
		if(!should_fire_offscreen)
			stop_firing(brain)
			qdel(src)
			return
		shoot_next = target_turf

	else if(ismob(brain.current_target))
		var/mob/mob_target = brain.current_target
		if(mob_target.stat == DEAD)
			stop_firing(brain)
			brain.lose_target()
			qdel(src)
			return

		var/is_unconscious = (mob_target.stat == UNCONSCIOUS || (locate(/datum/effects/crit) in mob_target.effects_list))
		if(!brain.shoot_to_kill && is_unconscious)
			brain.lose_target()
			qdel(src)
			return

	if(rounds_burst_fired >= gun_data.burst_amount_max)
		var/short_action_delay = brain.short_action_delay
		COOLDOWN_START(brain, fire_overload_cooldown, max(short_action_delay, short_action_delay * brain.action_delay_mult))
		stop_firing(brain)
		return

	if((get_dist(tied_human, shoot_next) > gun_data.maximum_range) && !should_fire_offscreen)
		brain.lose_target()
		stop_firing(brain)
		qdel(src)
		return

	if(brain.current_target && (get_dist(tied_human, brain.current_target) <= 1))
		currently_firing = FALSE
		return

	if(!firing_line_check(brain, shoot_next))
		stop_firing(brain)
		return

	if(istype(brain.primary_weapon, /obj/item/weapon/gun/flamer))
		currently_firing = FALSE
		COOLDOWN_START(brain, stop_fire_cooldown, fired.get_fire_delay()*3)
		addtimer(CALLBACK(fired, TYPE_PROC_REF(/obj/item/weapon/gun, start_fire), tied_human), fired.get_fire_delay()*3)
		stop_firing(brain)
		qdel(src)
		return

	if(istype(brain.primary_weapon, /obj/item/weapon/gun/shotgun))
		currently_firing = FALSE
		if(istype(brain.primary_weapon, /obj/item/weapon/gun/shotgun/pump))
			var/obj/item/weapon/gun/shotgun/pump/shotgun = brain.primary_weapon
			addtimer(CALLBACK(shotgun, TYPE_PROC_REF(/obj/item/weapon/gun/shotgun/pump, pump_shotgun), tied_human), shotgun.pump_delay)
			COOLDOWN_START(brain, stop_fire_cooldown, max(shotgun.pump_delay, shotgun.get_fire_delay()) + 1)
			stop_firing(brain)
			qdel(src)
			return
		else
			var/obj/item/weapon/gun/shotgun/autoshotty = brain.primary_weapon
			addtimer(CALLBACK(autoshotty, TYPE_PROC_REF(/obj/item/weapon/gun/shotgun, start_fire), tied_human), autoshotty.get_fire_delay()*3)
			COOLDOWN_START(brain, stop_fire_cooldown, max(autoshotty.get_fire_delay()) + 3)
			stop_firing(brain)
			qdel(src)
			return

	else if(istype(brain.primary_weapon, /obj/item/weapon/gun/rifle/xm51))
		currently_firing = FALSE
		var/obj/item/weapon/gun/rifle/xm51/scattergun = brain.primary_weapon
		addtimer(CALLBACK(scattergun, TYPE_PROC_REF(/obj/item/weapon/gun/rifle/xm51, unique_action), tied_human), scattergun.pump_delay)
		COOLDOWN_START(brain, stop_fire_cooldown, max(scattergun.pump_delay, scattergun.get_fire_delay()) + 1)
		stop_firing(brain)
		qdel(src)
		return

	else if(istype(brain.primary_weapon, /obj/item/weapon/gun/boltaction))
		var/obj/item/weapon/gun/boltaction/bolt = brain.primary_weapon
		currently_firing = FALSE
		addtimer(CALLBACK(bolt, TYPE_PROC_REF(/obj/item/weapon/gun/boltaction, unique_action), tied_human), 1)
		addtimer(CALLBACK(bolt, TYPE_PROC_REF(/obj/item/weapon/gun/boltaction, unique_action), tied_human), bolt.bolt_delay + 1)
		COOLDOWN_START(brain, stop_fire_cooldown, max(bolt.bolt_delay * 2, bolt.get_fire_delay()) + 1)
		stop_firing(brain)
		qdel(src)
		return

	else if(brain.primary_weapon.gun_firemode == GUN_FIREMODE_SEMIAUTO)
		currently_firing = FALSE
		addtimer(CALLBACK(brain.primary_weapon, TYPE_PROC_REF(/obj/item/weapon/gun, start_fire), null, brain.current_target, null, null, null, TRUE), brain.primary_weapon.get_fire_delay())

	else if(brain.primary_weapon.gun_firemode == GUN_FIREMODE_AUTOMATIC)
		rounds_burst_fired++

	else if(brain.primary_weapon.gun_firemode == GUN_FIREMODE_BURSTFIRE)
		currently_firing = FALSE
		addtimer(CALLBACK(brain.primary_weapon, TYPE_PROC_REF(/obj/item/weapon/gun, start_fire), null, brain.current_target, null, null, null, TRUE), brain.primary_weapon.get_burst_fire_delay())

	brain.primary_weapon?.set_target(shoot_next)
