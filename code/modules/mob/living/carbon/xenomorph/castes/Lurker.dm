/datum/caste_datum/lurker
	caste_type = XENO_CASTE_LURKER
	tier = 2

	melee_damage_lower = XENO_DAMAGE_TIER_4
	melee_damage_upper = XENO_DAMAGE_TIER_4
	melee_vehicle_damage = XENO_DAMAGE_TIER_4
	max_health = XENO_HEALTH_TIER_5
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_4
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_2
	armor_deflection = XENO_NO_ARMOR
	evasion = XENO_EVASION_NONE
	speed = XENO_SPEED_TIER_8

	attack_delay = 2 // VERY high slash damage, but attacks relatively slowly

	behavior_delegate_type = /datum/behavior_delegate/lurker_base

	deevolves_to = list(XENO_CASTE_RUNNER)
	caste_desc = "A fast, powerful backline combatant."
	evolves_to = list(XENO_CASTE_RAVAGER)

	heal_resting = 1.5

	minimum_evolve_time = 9 MINUTES

	minimap_icon = "lurker"

/mob/living/carbon/xenomorph/lurker
	caste_type = XENO_CASTE_LURKER
	name = XENO_CASTE_LURKER
	desc = "A beefy, fast alien with sharp claws."
	icon_size = 48
	icon_state = "Lurker Walking"
	plasma_types = list(PLASMA_CATECHOLAMINE)
	pixel_x = -12
	old_x = -12
	tier = 2
	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/regurgitate,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab,
		/datum/action/xeno_action/activable/pounce/lurker,
		/datum/action/xeno_action/onclick/lurker_invisibility,
		/datum/action/xeno_action/onclick/lurker_assassinate,
		/datum/action/xeno_action/onclick/tacmap,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	mutation_type = LURKER_NORMAL
	claw_type = CLAW_TYPE_SHARP

	tackle_min = 2
	tackle_max = 6

	icon_xeno = 'icons/mob/xenos/lurker.dmi'
	icon_xenonid = 'icons/mob/xenonids/lurker.dmi'

	var/pull_direction

/mob/living/carbon/xenomorph/lurker/launch_towards(datum/launch_metadata/LM)
	if(!current_target)
		return ..()

	pull_direction = turn(get_dir(src, current_target), 180)

	if(!(pull_direction in GLOB.cardinals))
		if(abs(x - current_target.x) < abs(y - current_target.y))
			pull_direction &= (NORTH|SOUTH)
		else
			pull_direction &= (EAST|WEST)
	return ..()

/mob/living/carbon/xenomorph/lurker/init_movement_handler()
	return new /datum/xeno_ai_movement/linger/lurking(src)

/mob/living/carbon/xenomorph/lurker/handle_ai_shot(obj/projectile/P)
	if(P.firer)
		if(prob(LURKING_IGNORE_SHOT_CHANCE))
			return

		var/datum/xeno_ai_movement/linger/lurking/lurker_ai = ai_movement_handler
		if(lurker_ai && istype(lurker_ai))
			lurker_ai.stop_lurking()

		SSxeno_pathfinding.calculate_path(src, P.firer, ai_range, src, CALLBACK(src, PROC_REF(set_path)), list(src, P.firer))

/mob/living/carbon/xenomorph/lurker/ai_move_target(delta_time)
	if(throwing)
		return

	if(pulling)
		if(!current_target || get_dist(src, current_target) > 10)
			INVOKE_ASYNC(src, PROC_REF(stop_pulling))
			return ..()
		if(can_move_and_apply_move_delay())
			if(!Move(get_step(loc, pull_direction), pull_direction))
				pull_direction = turn(pull_direction, pick(45, -45))
		current_path = null
		return

	..()

	if(get_dist(current_target, src) > 1)
		return

	if(!current_target.is_mob_incapacitated())
		return

	if(isxeno(current_target.pulledby))
		return

	if(!DT_PROB(RUNNER_GRAB, delta_time))
		return

	INVOKE_ASYNC(src, PROC_REF(start_pulling), current_target)
	swap_hand()

/mob/living/carbon/xenomorph/lurker/process_ai(delta_time)
	if(get_active_hand())
		swap_hand()
	zone_selected = pick(GLOB.ai_target_limbs)
	return ..()

/datum/behavior_delegate/lurker_base
	name = "Base Lurker Behavior Delegate"

	// Config
	var/invis_recharge_time = 150   // 15 seconds to recharge invisibility.
	var/invis_start_time = -1 // Special value for when we're not invisible
	var/invis_duration = 300  // so we can display how long the lurker is invisible to it
	var/buffed_slash_damage_ratio = 1.2
	var/slash_slow_duration = 35

	// State
	var/next_slash_buffed = FALSE
	var/can_go_invisible = TRUE

/datum/behavior_delegate/lurker_base/melee_attack_modify_damage(original_damage, mob/living/carbon/target_carbon)
	if (!isxeno_human(target_carbon))
		return original_damage

	if (next_slash_buffed)
		to_chat(bound_xeno, SPAN_XENOHIGHDANGER("You significantly strengthen your attack, slowing [target_carbon]!"))
		to_chat(target_carbon, SPAN_XENOHIGHDANGER("You feel a sharp pain as [bound_xeno] slashes you, slowing you down!"))
		original_damage *= buffed_slash_damage_ratio
		target_carbon.set_effect(get_xeno_stun_duration(target_carbon, 3), SUPERSLOW)
		next_slash_buffed = FALSE
		var/datum/action/xeno_action/onclick/lurker_assassinate/ability = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/onclick/lurker_assassinate)
		if (ability && istype(ability))
			ability.button.icon_state = "template"

	return original_damage

/datum/behavior_delegate/lurker_base/override_intent(mob/living/carbon/target_carbon)
	. = ..()

	if(!isxeno_human(target_carbon))
		return

	if(next_slash_buffed)
		return INTENT_HARM

/datum/behavior_delegate/lurker_base/melee_attack_additional_effects_target(mob/living/carbon/target_carbon)
	if (!isxeno_human(target_carbon))
		return

	if (target_carbon.knocked_down)
		new /datum/effects/xeno_slow(target_carbon, bound_xeno, null, null, get_xeno_stun_duration(target_carbon, slash_slow_duration))

	return

/datum/behavior_delegate/lurker_base/melee_attack_additional_effects_self()
	..()

	var/datum/action/xeno_action/onclick/lurker_invisibility/LIA = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
	if (LIA && istype(LIA))
		LIA.invisibility_off()

// What to do when we go invisible
/datum/behavior_delegate/lurker_base/proc/on_invisibility()
	var/datum/action/xeno_action/activable/pounce/lurker/LPA = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/activable/pounce/lurker)
	if (LPA && istype(LPA))
		LPA.knockdown = TRUE // pounce knocks down
		LPA.freeze_self = TRUE
	ADD_TRAIT(bound_xeno, TRAIT_CLOAKED, TRAIT_SOURCE_ABILITY("cloak"))
	bound_xeno.stealth = TRUE
	can_go_invisible = FALSE
	invis_start_time = world.time

/datum/behavior_delegate/lurker_base/proc/on_invisibility_off()
	var/datum/action/xeno_action/activable/pounce/lurker/LPA = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/activable/pounce/lurker)
	if (LPA && istype(LPA))
		LPA.knockdown = FALSE // pounce no longer knocks down
		LPA.freeze_self = FALSE
	bound_xeno.stealth = FALSE
	REMOVE_TRAIT(bound_xeno, TRAIT_CLOAKED, TRAIT_SOURCE_ABILITY("cloak"))

	// SLIGHTLY hacky because we need to maintain lots of other state on the lurker
	// whenever invisibility is on/off CD and when it's active.
	addtimer(CALLBACK(src, PROC_REF(regen_invisibility)), invis_recharge_time)

	invis_start_time = -1

/datum/behavior_delegate/lurker_base/proc/regen_invisibility()
	if (can_go_invisible)
		return

	can_go_invisible = TRUE
	if(bound_xeno)
		var/datum/action/xeno_action/onclick/lurker_invisibility/LIA = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
		if(LIA && istype(LIA))
			LIA.end_cooldown()

/datum/behavior_delegate/lurker_base/append_to_stat()
	. = list()
	var/invis_message = (invis_start_time == -1) ? "N/A" : "[(invis_duration-(world.time - invis_start_time))/10] seconds."
	. += "Invisibility Time Left: [invis_message]"

/datum/behavior_delegate/lurker_base/on_collide(atom/movable/movable_atom)
	. = ..()

	if(!ishuman(movable_atom))
		return

	if(!bound_xeno || !bound_xeno.stealth)
		return

	var/datum/action/xeno_action/onclick/lurker_invisibility/lurker_invisibility_action = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
	if(!lurker_invisibility_action)
		return

	var/mob/living/carbon/human/bumped_into = movable_atom
	if(HAS_TRAIT(bumped_into, TRAIT_CLOAKED)) //ignore invisible scouts and preds
		return

	to_chat(bound_xeno, SPAN_XENOHIGHDANGER("You bumped into someone and lost your invisibility!"))
	lurker_invisibility_action.invisibility_off()
