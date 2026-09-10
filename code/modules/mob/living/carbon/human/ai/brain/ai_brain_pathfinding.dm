/datum/human_ai_brain
	/// Delay timer for when the AI can next move, based on the tied_human's move delay
	var/ai_move_delay = 0
	/// The list of turfs that the AI is trying to move through
	var/list/current_path
	/// The next turf in current_path that the AI is moving to
	var/turf/current_path_target
	/// How long to wait if the AI can't find a path
	var/path_update_period = (0.5 SECONDS)
	/// If TRUE, pathfinding has failed to find a path and a cooldown will soon begin.
	var/no_path_found = FALSE
	/// The farthest that the AI will try to pathfind
	var/max_travel_distance = HUMAN_AI_MAX_PATHFINDING_RANGE
	/// Time storage for the next time a pathfinding path can try to be generated
	var/next_path_generation = 0
	/// Amount of times no path found has occured
	var/no_path_found_amount = 0
	///
	var/ai_timeout_time = 0
	var/target_deviations = 0

	/// The time interval between calculating new paths if we cannot find a path
	var/no_path_found_period = (2.5 SECONDS)

	/// Cooldown declaration for delaying finding a new path if no path was found
	COOLDOWN_DECLARE(no_path_found_cooldown)

/datum/human_ai_brain/proc/can_move_and_apply_move_delay()
	// Unable to move, try next time.
	if(ai_move_delay > world.time || !(tied_human.mobility_flags & MOBILITY_MOVE) || tied_human.is_mob_incapacitated(TRUE) || (tied_human.body_position != STANDING_UP && !tied_human.can_crawl) || tied_human.anchored)
		return FALSE

	ai_move_delay = world.time + tied_human.move_delay
	if(tied_human.recalculate_move_delay)
		ai_move_delay = world.time + tied_human.movement_delay()
	if(tied_human.next_move_slowdown)
		ai_move_delay += tied_human.next_move_slowdown
		tied_human.next_move_slowdown = 0
	return TRUE

/datum/human_ai_brain/proc/move_to_next_turf(turf/T, max_range = max_travel_distance)
	if(!T)
		return FALSE

	if(no_path_found)
		if(no_path_found_amount > 0)
			COOLDOWN_START(src, no_path_found_cooldown, no_path_found_period * min(3, no_path_found_amount))
		no_path_found = FALSE
		no_path_found_amount++
		return FALSE

	if((!current_path || (next_path_generation < world.time && current_path_target != T)) && COOLDOWN_FINISHED(src, no_path_found_cooldown))
		if(!CALCULATING_PATH(tied_human) || current_path_target != T)
			SSpathfinding.calculate_path(tied_human, T, max_range, tied_human, CALLBACK(src, PROC_REF(set_path)), list(tied_human, current_target))
			current_path_target = T
		next_path_generation = world.time + path_update_period

	if(CALCULATING_PATH(tied_human))
		return TRUE

	// No possible path to target.
	if(!current_path && get_dist(T, tied_human) > 0)
		return FALSE

	// We've reached our destination
	if(!length(current_path) || get_dist(T, tied_human) <= 0)
		current_path = null
		return TRUE

	var/turf/next_turf = current_path[length(current_path)]
	// We've somehow deviated from our current path. Generate next path whenever possible.
	if(get_dist(next_turf, tied_human) > 1)
		current_path = null
		return TRUE

	// Unable to move, try next time.
	if(!can_move_and_apply_move_delay())
		return TRUE

	var/list/L = LinkBlocked(tied_human, tied_human.loc, next_turf, list(tied_human), TRUE)
	L += SSpathfinding.check_special_blockers(tied_human, next_turf)
	for(var/a in L)
		var/atom/A = a
		if(ishuman_strict(A) && A.density)
			return FALSE
		if(A.human_ai_obstacle(tied_human, src, get_dir(tied_human.loc, next_turf)) == INFINITY)
			return FALSE
		INVOKE_ASYNC(A, TYPE_PROC_REF(/atom, human_ai_act), tied_human, src)
	var/successful_move = tied_human.Move(next_turf, get_dir(tied_human, next_turf))
	if(successful_move)
		ai_timeout_time = world.time
		current_path.len--

	return TRUE

/datum/human_ai_brain/proc/update_path_to_target(turf/updated_target_turf)
	if(!updated_target_turf)	// the missile doesnt know where it is
		return FALSE

	if(CALCULATING_PATH(tied_human))	// the missile is thinking...
		return

	if(!current_path && next_path_generation < world.time && !CALCULATING_PATH(tied_human))
		SSpathfinding.calculate_path(tied_human, updated_target_turf, max_travel_distance, tied_human, CALLBACK(src, PROC_REF(set_path)), list(tied_human, current_target))
		current_path_target = updated_target_turf
		next_path_generation = world.time + path_update_period
		return TRUE

	if(!current_path)
		return TRUE

	for(var/index in 1 to min(length(current_path), 5))	// is the turf where the missile isnt, somewhere it will be
		if(current_path[index] == updated_target_turf)
			current_path.Cut(1, index)
			current_path_target = updated_target_turf
			return TRUE

	var/distance = length(current_path)
	var/pathed_distance = distance - target_deviations
	if(distance <= 3)	// pitbull!!
		current_path.Insert(1, updated_target_turf)
		current_path_target = updated_target_turf
		target_deviations++
		return TRUE
	if(pathed_distance <= 7 || (pathed_distance > 7 && pathed_distance < target_deviations))	// fox 3!!
		var/turf/anchor_point = listgetindex(current_path, 2)
		SSpathfinding.calculate_path(anchor_point, updated_target_turf, max_travel_distance, tied_human, CALLBACK(src, PROC_REF(append_path)), list(tied_human, current_target))
		current_path.Cut(1, distance - 1)
		target_deviations = 0
		return TRUE

/datum/human_ai_brain/proc/set_path(list/path)
	current_path = path
	if(!path)
		no_path_found = TRUE
		return
	no_path_found_amount = 0

/datum/human_ai_brain/proc/append_path(list/path)
	current_path.Insert(1, path)
	current_path_target = current_path[1]
	if(!path)
		no_path_found = TRUE
