/datum/xeno_ai_movement
	var/mob/living/carbon/xenomorph/parent

	// Home turf
	var/next_home_search = 0
	var/home_search_delay = 5 SECONDS
	var/max_distance_from_home = 15
	var/home_locate_range = 15
	var/turf/home_turf

/datum/xeno_ai_movement/New(mob/living/carbon/xenomorph/parent)
	. = ..()
	if(!parent)
		return INITIALIZE_HINT_QDEL

	src.parent = parent

/datum/xeno_ai_movement/Destroy(force, ...)
	parent = null
	return ..()

/// TLDR: Find suitable weeds, go to them. If too close - rest ///
/datum/xeno_ai_movement/proc/ai_move_idle(delta_time)
	SHOULD_NOT_SLEEP(TRUE)
	var/mob/living/carbon/xenomorph/idle_xeno = parent
	if(idle_xeno.throwing)
		return

	if(next_home_search < world.time && (!home_turf || !home_turf.weeds || !IS_SAME_HIVENUMBER(idle_xeno, home_turf.weeds) || get_dist(home_turf, idle_xeno) > max_distance_from_home))
		var/turf/T = get_turf(idle_xeno.loc)
		next_home_search = world.time + home_search_delay
		var/obj/effect/alien/weeds/current_weeds = T.weeds
		if(current_weeds && IS_SAME_HIVENUMBER(idle_xeno, current_weeds))
			home_turf = T
		else
			var/shortest_distance = INFINITY
			for(var/i in RANGE_TURFS(home_locate_range, T))
				var/turf/potential_home = i
				var/obj/effect/alien/weeds/potential_weeds = potential_home.weeds
				if(potential_weeds && IS_SAME_HIVENUMBER(idle_xeno, potential_weeds) && !potential_home.density && get_dist(idle_xeno, potential_home) < shortest_distance)
					home_turf = potential_home
					shortest_distance = get_dist(idle_xeno, potential_home)
			idle_xeno.set_resting(FALSE, FALSE, TRUE)
	if(!home_turf)
		return

	if(idle_xeno.move_to_next_turf(home_turf, home_locate_range))
		if(get_dist(home_turf, idle_xeno) <= 0)
			idle_xeno.set_resting(TRUE, FALSE)
	else
		home_turf = null

/// TLDR: Go to current_target, run around it. If can't - forget about target ///
/datum/xeno_ai_movement/proc/ai_move_target(delta_time)
	SHOULD_NOT_SLEEP(TRUE)
	var/mob/living/carbon/xenomorph/angry_xeno = parent
	if(angry_xeno.throwing)
		return

	var/turf/T = get_turf(angry_xeno.current_target)
	if(get_dist(angry_xeno, angry_xeno.current_target) <= 1)
		var/list/turfs = RANGE_TURFS(1, T)
		while(length(turfs))
			T = pick(turfs)
			turfs -= T
			if(!T.density)
				break

			if(T == get_turf(angry_xeno.current_target))
				break

	if(!angry_xeno.move_to_next_turf(T))
		angry_xeno.current_target = null
		return TRUE

/datum/xeno_ai_movement/proc/ai_move_patrol(delta_time)
	SHOULD_NOT_SLEEP(TRUE)
	var/mob/living/carbon/xenomorph/moving_xeno = parent
	if(moving_xeno.throwing)
		return

	moving_xeno.set_resting(FALSE)

	var/list/patrol_points = moving_xeno.patrol_points
	var/atom/move_target = patrol_points[1]

	if(get_dist(move_target, moving_xeno) <= moving_xeno.min_travel_distance)
		var/patrol_length = length(patrol_points)
		if(patrol_length < 2)
			/// Less than two means it's just a "oneway" move order
			patrol_points -= move_target
			return

		/// Simple sequence of swaps to move our first point to the end of list
		patrol_points.Swap(1, 2)
		patrol_points.Swap(2, patrol_length)

		move_target = patrol_points[1]

	if(moving_xeno.move_to_next_turf(move_target, INFINITY))
		return TRUE

/// TLDR: Find hive and go to it, if near one - ai_strap_host() ///
/datum/xeno_ai_movement/proc/ai_move_hive(delta_time)
	SHOULD_NOT_SLEEP(TRUE)
	var/mob/living/carbon/xenomorph/retreating_xeno = parent
	if(retreating_xeno.throwing)
		return

	var/shortest_distance = INFINITY
	var/hive_radius

	var/turf/closest_hive
	for(var/datum/component/ai_behavior_override/hive/hive_component as anything in GLOB.ai_hives)
		var/turf/potential_hive = hive_component.parent
		hive_radius = hive_component.hive_radius

		if(potential_hive.z != retreating_xeno.z)
			continue

		var/xeno_to_potential_hive_distance = get_dist(retreating_xeno, potential_hive)
		if(xeno_to_potential_hive_distance > shortest_distance)
			continue

		closest_hive = potential_hive
		shortest_distance = xeno_to_potential_hive_distance

	if(!closest_hive)
		return

	if(get_dist(retreating_xeno, closest_hive) <= hive_radius)
		return ai_strap_host(closest_hive, hive_radius, delta_time)

	var/turf/hive_turf = get_turf(closest_hive)
	if(retreating_xeno.move_to_next_turf(hive_turf, INFINITY))
		return TRUE

/// TLDR: Find suitable wall around hive, click on it with grabbed marine ///
/datum/xeno_ai_movement/proc/ai_strap_host(turf/closest_hive, hive_radius, delta_time)
	SHOULD_NOT_SLEEP(TRUE)
	var/mob/living/carbon/xenomorph/capping_xeno = parent
	if(capping_xeno.throwing)
		return

	var/turf/nest_turf
	var/turf/weeded_wall

	var/shortest_distance = INFINITY
	for(var/turf/potential_nest as anything in shuffle(RANGE_TURFS(hive_radius, closest_hive)))
		if(potential_nest.density)
			continue

		if(!potential_nest.weeds)
			continue

		var/mob/living/carbon/xenomorph/xeno = locate() in potential_nest
		if(xeno && xeno != capping_xeno)
			continue

		var/obj/structure/bed/nest/preexisting_nest = locate() in potential_nest
		if(preexisting_nest && preexisting_nest.buckled_mob)
			continue

		var/turf/potential_weeded_wall
		for(var/turf/closed/adjacent_turf in RANGE_TURFS(1, potential_nest) - potential_nest)
			if(get_dir(potential_nest, adjacent_turf) in diagonals)
				continue

			if(istype(adjacent_turf, /turf/closed/shuttle))
				continue

			var/obj/effect/alien/weeds/adjacent_weeds = adjacent_turf.weeds
			if(!adjacent_weeds || !IS_SAME_HIVENUMBER(adjacent_weeds, capping_xeno))
				continue

			potential_weeded_wall = adjacent_turf
			break

		if(!potential_weeded_wall)
			continue

		var/xeno_potential_nest_distance = get_dist(capping_xeno, potential_nest)
		if(xeno_potential_nest_distance > shortest_distance)
			continue

		nest_turf = potential_nest
		weeded_wall = potential_weeded_wall
		shortest_distance = xeno_potential_nest_distance

	if(!nest_turf)
		return

	if(get_dist(capping_xeno, nest_turf) < 1)
		if(capping_xeno.get_inactive_hand())
			capping_xeno.swap_hand()

		INVOKE_ASYNC(capping_xeno, TYPE_PROC_REF(/mob, do_click), weeded_wall, "", list())
		return TRUE

	if(capping_xeno.move_to_next_turf(nest_turf))
		return TRUE
