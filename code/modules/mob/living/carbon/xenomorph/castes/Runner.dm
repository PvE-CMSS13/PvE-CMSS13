/datum/caste_datum/runner
	caste_type = XENO_CASTE_RUNNER
	caste_desc = "A fast, four-legged terror, but weak in sustained combat."
	tier = 1
	melee_damage_lower = XENO_DAMAGE_TIER_1
	melee_damage_upper = XENO_DAMAGE_TIER_2
	melee_vehicle_damage = 0
	plasma_gain = XENO_PLASMA_GAIN_TIER_1
	plasma_max = XENO_NO_PLASMA
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_1
	armor_deflection = XENO_NO_ARMOR
	max_health = XENO_HEALTH_RUNNER
	evasion = XENO_EVASION_NONE
	speed = XENO_SPEED_RUNNER
	attack_delay = -4
	behavior_delegate_type = /datum/behavior_delegate/runner_base
	evolves_to = list(XENO_CASTE_LURKER)
	deevolves_to = list("Larva")

	tackle_min = 4
	tackle_max = 5
	tackle_chance = 40
	tacklestrength_min = 4
	tacklestrength_max = 4

	heal_resting = 1.75

	minimum_evolve_time = 5 MINUTES

	minimap_icon = "runner"

/mob/living/carbon/xenomorph/runner
	caste_type = XENO_CASTE_RUNNER
	name = XENO_CASTE_RUNNER
	desc = "A small red alien that looks like it could run fairly quickly..."
	icon = 'icons/mob/xenos/runner.dmi'
	icon_state = "Runner Walking"
	icon_size = 64
	layer = MOB_LAYER
	plasma_types = list(PLASMA_CATECHOLAMINE)
	tier = 1
	pixel_x = -16  //Needed for 2x2
	old_x = -16
	base_pixel_x = 0
	base_pixel_y = -20
	pull_speed = -0.5
	viewsize = 9

	mob_size = MOB_SIZE_XENO_SMALL

	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/regurgitate,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab,
		/datum/action/xeno_action/onclick/xenohide,
		/datum/action/xeno_action/activable/pounce/runner,
		/datum/action/xeno_action/activable/runner_skillshot,
		/datum/action/xeno_action/onclick/toggle_long_range/runner,
		/datum/action/xeno_action/onclick/tacmap,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	mutation_type = RUNNER_NORMAL

	icon_xeno = 'icons/mob/xenos/runner.dmi'
	icon_xenonid = 'icons/mob/xenonids/runner.dmi'

	var/linger_range = 5
	var/linger_deviation = 1
	var/pull_direction

/mob/living/carbon/xenomorph/runner/initialize_pass_flags(datum/pass_flags_container/pass_flags_container)
	..()
	if (pass_flags_container)
		pass_flags_container.flags_pass |= PASS_FLAGS_CRAWLER

/mob/living/carbon/xenomorph/runner/launch_towards(datum/launch_metadata/LM)
	if(!current_target)
		return ..()

	pull_direction = turn(get_dir(src, current_target), 180)

	if(!(pull_direction in GLOB.cardinals))
		if(abs(x - current_target.x) < abs(y - current_target.y))
			pull_direction &= (NORTH|SOUTH)
		else
			pull_direction &= (EAST|WEST)
	return ..()

/mob/living/carbon/xenomorph/runner/start_pulling(atom/movable/AM, lunge, no_msg)
	. = ..()

	add_temp_negative_pass_flags(PASS_FLAGS_CRAWLER)

/mob/living/carbon/xenomorph/runner/stop_pulling(bumped_movement = FALSE)
	. = ..()

	remove_temp_negative_pass_flags(PASS_FLAGS_CRAWLER)

/mob/living/carbon/xenomorph/runner/init_movement_handler()
	var/datum/xeno_ai_movement/linger/linger_movement = new(src)
	linger_movement.linger_range = linger_range
	linger_movement.linger_deviation = linger_deviation
	return linger_movement

/mob/living/carbon/xenomorph/runner/ai_move_target(delta_time)
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

	if(!istype(current_target, /mob))
		return

	var/mob/current_target_mob = current_target

	if(!current_target_mob.is_mob_incapacitated())
		return

	if(isxeno(current_target.pulledby))
		return

	if(!DT_PROB(RUNNER_GRAB, delta_time))
		return

	INVOKE_ASYNC(src, PROC_REF(start_pulling), current_target)
	swap_hand()

/mob/living/carbon/xenomorph/runner/process_ai(delta_time)
	if(get_active_hand())
		swap_hand()
	return ..()

/datum/behavior_delegate/runner_base
	name = "Base Runner Behavior Delegate"

/datum/behavior_delegate/runner_base/melee_attack_additional_effects_self()
	..()

	var/datum/action/xeno_action/onclick/xenohide/hide = get_xeno_action_by_type(bound_xeno, /datum/action/xeno_action/onclick/xenohide)
	if(hide)
		hide.post_attack()
