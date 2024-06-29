/datum/action/xeno_action/activable/pounce/crusher_charge
	name = "Charge"
	action_icon_state = "ready_charge"
	ability_name = "charge"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_charge
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_1
	xeno_cooldown = 140
	plasma_cost = 20
	// Config options
	distance = 9
	knockdown = TRUE
	knockdown_duration = 2
	slash = FALSE
	freeze_self = FALSE
	windup = TRUE
	windup_duration = 12
	windup_interruptable = FALSE
	should_destroy_objects = TRUE
	throw_speed = SPEED_FAST
	tracks_target = FALSE

	default_ai_action = FALSE

	var/direct_hit_damage = 60
	var/frontal_armor = 15
	// Object types that dont reduce cooldown when hit
	var/list/not_reducing_objects = list()


/datum/action/xeno_action/activable/pounce/crusher_charge/New()
	. = ..()
	not_reducing_objects = typesof(/obj/structure/barricade) + typesof(/obj/structure/machinery/defenses)

/datum/action/xeno_action/activable/pounce/crusher_charge/initialize_pounce_pass_flags()
	pounce_pass_flags = PASS_CRUSHER_CHARGE

/datum/action/xeno_action/onclick/crusher_stomp
	name = "Stomp"
	action_icon_state = "stomp"
	ability_name = "stomp"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_stomp
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_2
	xeno_cooldown = 180
	plasma_cost = 30

	var/damage = 65

	var/distance = 4
	var/windup_duration = 1.5 SECONDS

	default_ai_action = TRUE

/datum/action/xeno_action/onclick/crusher_stomp/process_ai(mob/living/carbon/xenomorph/X, delta_time)
	if(!DT_PROB(ai_prob_chance, delta_time) || get_dist(X, X.current_target) >= distance - 1 || HAS_TRAIT(X, TRAIT_CHARGING) || X.action_busy)
		return

	use_ability_async()

/datum/action/xeno_action/onclick/crusher_shield
	name = "Defensive Shield"
	action_icon_state = "empower"
	ability_name = "defensive shield"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_charge
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_3
	plasma_cost = 50
	xeno_cooldown = 26 SECONDS
	var/shield_amount = 200

/datum/action/xeno_action/activable/fling/charger
	name = "Headbutt"
	action_icon_state = "ram"
	ability_name = "Headbutt"
	macro_path = /datum/action/xeno_action/verb/verb_fling
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_4
	xeno_cooldown = 10 SECONDS
	plasma_cost = 10
	// Configurables
	fling_distance = 3
	stun_power = 0
	weaken_power = 0
	slowdown = 8

	default_ai_action = TRUE
	ai_prob_chance = 60

/datum/action/xeno_action/activable/fling/charger/process_ai(mob/living/carbon/xenomorph/X, delta_time)
	if(!DT_PROB(ai_prob_chance, delta_time) || get_dist(X, X.current_target) > 1 || HAS_TRAIT(X, TRAIT_CHARGING) || X.action_busy)
		return

	use_ability_async(X.current_target)

/datum/action/xeno_action/onclick/charger_charge
	name = "Toggle Charging"
	action_icon_state = "ready_charge"
	plasma_cost = 0 // manually applied in the proc
	macro_path = /datum/action/xeno_action/verb/verb_crusher_toggle_charging
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_1

	default_ai_action = TRUE
	ai_prob_chance = 80

	// Config vars
	var/max_momentum = 8
	var/steps_to_charge = 3
	var/speed_per_momentum = XENO_SPEED_FASTMOD_TIER_5 // 2.2
	var/plasma_per_step = 0

	// State vars
	var/activated = FALSE
	var/steps_taken = 0
	var/charge_dir
	var/noise_timer = 0

	//How much shield you gain on max momentum
	var/shield_amount = 100
	// How long the max momentum shield lasts
	var/shield_timeout = 4
	// If the shield is active or not
	var/shield_active = FALSE

	/// The last time the crusher moved while charging
	var/last_charge_move
	/// Dictates speed and damage dealt via collision, increased with movement
	var/momentum = 0

#define MIN_TARGETS_TO_CHARGE 2
#define FLOCK_SCAN_RADIUS 3
#define MINIMUM_CHARGE_DISTANCE 3
#define MAXIMUM_TARGET_DISTANCE 12

/datum/action/xeno_action/onclick/charger_charge/proc/handle_position_change(mob/living/carbon/xenomorph/xeno, body_position)
	SIGNAL_HANDLER
	if(body_position == LYING_DOWN)
		handle_movement(xeno)

/datum/action/xeno_action/onclick/charger_charge/process_ai(mob/living/carbon/xenomorph/processing_xeno, delta_time)
	if(!DT_PROB(ai_prob_chance, delta_time) || !isnull(charge_dir) || processing_xeno.action_busy)
		return

	var/turf/xeno_turf = get_turf(processing_xeno)

	if(!xeno_turf)
		return

	var/list/possible_charge_dirs = list()

	for(var/mob/living/carbon/base_checked_carbon as anything in GLOB.alive_mob_list)
		var/distance_between_base_carbon_and_xeno = get_dist(processing_xeno, base_checked_carbon)

		if(distance_between_base_carbon_and_xeno > MAXIMUM_TARGET_DISTANCE)
			continue

		if(distance_between_base_carbon_and_xeno < MINIMUM_CHARGE_DISTANCE)
			continue

		if(!base_checked_carbon.ai_can_target(processing_xeno))
			continue

		var/secondary_count = 0
		var/secondary_x_sum = 0
		var/secondary_y_sum = 0

		for(var/mob/living/carbon/secondary_checked_carbon in range(FLOCK_SCAN_RADIUS, base_checked_carbon))
			if(!secondary_checked_carbon.ai_can_target(processing_xeno))
				continue

			secondary_count++
			secondary_x_sum += secondary_checked_carbon.x
			secondary_y_sum += secondary_checked_carbon.y

		if(secondary_count < MIN_TARGETS_TO_CHARGE)
			continue

		var/x_middle = round(secondary_x_sum / secondary_count)
		var/y_middle = round(secondary_y_sum / secondary_count)

		if((abs(x_middle - processing_xeno.x) > 1) && (abs(y_middle - processing_xeno.y) > 1))
			continue

		var/turf/potential_charge_turf = locate(x_middle, y_middle, processing_xeno.z)

		var/distance_between_potential_charge_turf_and_xeno = get_dist(potential_charge_turf, processing_xeno)

		if(distance_between_potential_charge_turf_and_xeno < MINIMUM_CHARGE_DISTANCE)
			continue

		var/cardinal_dir_to_potential_charge_turf = get_cardinal_dir(processing_xeno, potential_charge_turf)

		var/list/turf/turfs_to_check = getline2(xeno_turf, get_angle_target_turf(xeno_turf, cardinal_dir_to_potential_charge_turf, MINIMUM_CHARGE_DISTANCE), FALSE)

		var/blocked = FALSE
		var/turf/previous_turf = xeno_turf

		for(var/turf/checked_turf in turfs_to_check)
			var/list/ignore = list()

			for(var/mob/mob_blocker in checked_turf)
				ignore += mob_blocker

			if(LinkBlocked(processing_xeno, previous_turf, checked_turf, ignore))
				blocked = TRUE
				break

			previous_turf = checked_turf

		if(blocked)
			continue

		possible_charge_dirs += cardinal_dir_to_potential_charge_turf

	if(!length(possible_charge_dirs))
		return

	charge_dir = pick(possible_charge_dirs)

	last_charge_move = world.time
	use_ability_async()

#undef MIN_TARGETS_TO_CHARGE
#undef FLOCK_SCAN_RADIUS
#undef MINIMUM_CHARGE_DISTANCE
#undef MAXIMUM_TARGET_DISTANCE

/datum/action/xeno_action/onclick/charger_charge/proc/handle_movement(mob/living/carbon/xenomorph/xeno, atom/oldloc, dir, forced)
	SIGNAL_HANDLER
	if(xeno.pulling)
		if(!momentum)
			steps_taken = 0
			return
		else
			xeno.stop_pulling()

	if(xeno.is_mob_incapacitated())
		if(!momentum)
			return
		var/lol = get_ranged_target_turf(xeno, charge_dir, momentum/2)
		INVOKE_ASYNC(xeno, TYPE_PROC_REF(/atom/movable, throw_atom), lol, momentum/2, SPEED_FAST, null, TRUE)
		stop_momentum()
		return
	if(!isturf(xeno.loc))
		stop_momentum()
		return
	// Don't build up charge if you move via getting propelled by something
	if(xeno.throwing)
		stop_momentum()
		return

	var/do_stop_momentum = FALSE

	// Need to be constantly moving in order to maintain charge
	if(world.time > last_charge_move + 0.5 SECONDS)
		do_stop_momentum = TRUE
	if(dir != charge_dir)
		charge_dir = dir
		do_stop_momentum = TRUE

	if(do_stop_momentum)
		stop_momentum()
	if(xeno.plasma_stored <= plasma_per_step)
		stop_momentum()
		return
	last_charge_move = world.time
	steps_taken++
	if(steps_taken < steps_to_charge)
		return
	if(momentum < max_momentum)
		momentum++
		ADD_TRAIT(xeno, TRAIT_CHARGING, TRAIT_SOURCE_XENO_ACTION_CHARGE)
		xeno.update_icons()
		if(momentum == max_momentum)
			xeno.emote("roar")
	//X.use_plasma(plasma_per_step) // take if you are in toggle charge mode
	if(momentum > 0)
		xeno.use_plasma(plasma_per_step) // take plasma when you have momentum

	noise_timer = noise_timer ? --noise_timer : 4
	if(noise_timer == 4)
		playsound(xeno, 'sound/effects/alien_footstep_charge1.ogg', 100)

		for(var/mob/living/carbon/human/Mob in range(14, xeno))
			shake_camera(Mob, 2, 2)

	for(var/mob/living/carbon/human/Mob in xeno.loc)
		if(Mob.body_position == LYING_DOWN && Mob.stat != DEAD)
			xeno.visible_message(SPAN_DANGER("[xeno] runs [Mob] over!"),
				SPAN_DANGER("You run [Mob] over!")
			)
			var/ram_dir = pick(get_perpen_dir(xeno.dir))
			var/dist = 1
			if(momentum == max_momentum)
				dist = momentum * 0.25
			step(Mob, ram_dir, dist)
			Mob.take_overall_armored_damage(momentum * 8)
			INVOKE_ASYNC(Mob, TYPE_PROC_REF(/mob/living/carbon, emote), "pain")
			shake_camera(Mob, 7, 3)
			animation_flash_color(Mob)

	if(momentum >= 5)
		for(var/mob/living/carbon/hit_carbon in orange(1, xeno))
			if(hit_carbon.body_position == LYING_DOWN)
				continue

			if(xeno.can_not_harm(hit_carbon))
				continue

			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(xeno_throw_human), hit_carbon, xeno, get_dir(xeno, hit_carbon), 1, FALSE)
			to_chat(hit_carbon, SPAN_XENOHIGHDANGER("You fall backwards as [xeno] gives you a glancing blow!"))
			shake_camera(hit_carbon, 4, 2)

			var/total_damage = momentum * 8
			if(ishuman(hit_carbon))
				var/mob/living/carbon/human/hit_human = hit_carbon
				hit_human.take_overall_armored_damage(total_damage)

			else if(isxeno(hit_carbon))
				var/mob/living/carbon/xenomorph/hit_xeno = hit_carbon
				hit_xeno.apply_armoured_damage(total_damage)

			hit_carbon.apply_effect(0.5, WEAKEN)
			animation_flash_color(hit_carbon)

	xeno.recalculate_speed()

/datum/action/xeno_action/onclick/charger_charge/proc/handle_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	if(new_dir != charge_dir)
		charge_dir = new_dir
		if(momentum)
			stop_momentum()

/datum/action/xeno_action/onclick/charger_charge/proc/handle_river(datum/source, covered)
	SIGNAL_HANDLER
	if(!covered)
		stop_momentum()

/datum/action/xeno_action/onclick/charger_charge/proc/update_speed(mob/living/carbon/xenomorph/Xeno)
	SIGNAL_HANDLER
	Xeno.speed += momentum * speed_per_momentum

/datum/action/xeno_action/onclick/charger_charge/proc/stop_momentum(datum/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/Xeno = owner
	if(momentum == max_momentum)
		Xeno.visible_message(SPAN_DANGER("[Xeno] skids to a halt!"))

	REMOVE_TRAIT(Xeno, TRAIT_CHARGING, TRAIT_SOURCE_XENO_ACTION_CHARGE)
	SEND_SIGNAL(Xeno, COMSIG_XENO_STOPPED_CHARGING)
	charge_dir = null
	steps_taken = 0
	momentum = 0
	Xeno.recalculate_speed()
	Xeno.update_icons()

/datum/action/xeno_action/onclick/charger_charge/proc/lose_momentum(amount)
	if(amount >= momentum)
		stop_momentum()
	else
		momentum -= amount
		var/mob/living/carbon/xenomorph/Xeno = owner
		Xeno.recalculate_speed()

/datum/action/xeno_action/onclick/charger_charge/proc/handle_collision(mob/living/carbon/xenomorph/Xeno, atom/tar)
	SIGNAL_HANDLER
	if(!momentum)
		stop_momentum()
		return

	var/result = tar.handle_charge_collision(Xeno, src)
	switch(result)
		if(XENO_CHARGE_TRY_MOVE)
			if(step(Xeno, charge_dir))
				return COMPONENT_LIVING_COLLIDE_HANDLED

/datum/action/xeno_action/onclick/charger_charge/proc/start_charging(datum/source)
	SIGNAL_HANDLER
	steps_taken = steps_to_charge


/datum/action/xeno_action/activable/tumble
	name = "Tumble"
	ability_name = "tumble"
	action_icon_state = "tumble"
	macro_path = /datum/action/xeno_action/verb/verb_crusher_tumble
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_2

	plasma_cost = 25
	xeno_cooldown = 10 SECONDS

/datum/action/xeno_action/activable/tumble/proc/on_end_throw(start_charging)
	var/mob/living/carbon/xenomorph/Xeno = owner
	Xeno.flags_atom &= ~DIRLOCK
	if(start_charging)
		SEND_SIGNAL(Xeno, COMSIG_XENO_START_CHARGING)


/datum/action/xeno_action/activable/tumble/proc/handle_mob_collision(mob/living/carbon/Mob)
	var/mob/living/carbon/xenomorph/Xeno = owner
	Xeno.visible_message(SPAN_XENODANGER("[Xeno] Sweeps to the side, knocking down [Mob]!"), SPAN_XENODANGER("You knock over [Mob] as you sweep to the side!"))
	var/turf/target_turf = get_turf(Mob)
	playsound(Mob,'sound/weapons/alien_claw_block.ogg', 50, 1)
	Mob.apply_damage(15,BRUTE)
	if(ishuman(Mob))
		var/mob/living/carbon/human/Human = Mob
		xeno_throw_human(Human, Xeno, get_dir(Xeno, Human), 1)
		Human.apply_effect(1, WEAKEN)
	else
		Mob.apply_effect(1, WEAKEN)
	if(!LinkBlocked(Xeno, get_turf(Xeno), target_turf))
		Xeno.forceMove(target_turf)

