/datum/xeno_ai_movement/linger/facehugger/ai_move_target(delta_time)
	var/mob/living/carbon/xenomorph/moving_xeno = parent

	if(moving_xeno.action_busy)
		return

	return ..()

#define REENGAGE_COOLDOWN (7 SECONDS)
#define FIND_NEW_TRAVEL_TURF_LIMIT 5
#define FIND_NEW_TRAVEL_RADIUS_MAX 10

/datum/xeno_ai_movement/linger/facehugger/check_for_travelling_turf_change(mob/living/carbon/xenomorph/moving_xeno)
	if(!(moving_xeno in view(FIND_NEW_TRAVEL_RADIUS_MAX, moving_xeno.current_target)) && COOLDOWN_FINISHED(src, reengage_cooldown))
		travelling_turf = get_turf(moving_xeno.current_target)
		COOLDOWN_START(src, reengage_cooldown, REENGAGE_COOLDOWN)
		moving_xeno.emote("growl")
		return

	if(!travelling_turf || get_dist(travelling_turf, moving_xeno) <= 0)
		for(var/i = 0 to FIND_NEW_TRAVEL_TURF_LIMIT)
			travelling_turf = get_random_turf_in_range_unblocked(moving_xeno.current_target, linger_range + linger_deviation, linger_range - linger_deviation)

			if(!travelling_turf)
				continue

			if(get_dist(travelling_turf, moving_xeno.current_target) <= 4)
				continue

			var/travelling_turf_dir = get_dir(moving_xeno, travelling_turf)
			var/current_target_dir = get_dir(moving_xeno, moving_xeno.current_target)

			if(current_target_dir != travelling_turf_dir && current_target_dir != turn(travelling_turf_dir, 45) && current_target_dir != turn(travelling_turf_dir, -45))
				break

	if(!travelling_turf)
		travelling_turf = get_turf(moving_xeno.current_target)
		return

#undef REENGAGE_COOLDOWN
#undef FIND_NEW_TRAVEL_TURF_LIMIT
#undef FIND_NEW_TRAVEL_RADIUS_MAX

/mob/living/carbon/xenomorph/facehugger/check_mob_target(mob/living/carbon/human/checked_human)
	if(checked_human.status_flags & XENO_HOST)
		return FALSE

	return ..()
