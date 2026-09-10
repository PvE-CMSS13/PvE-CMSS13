/datum/human_ai_brain
	/// A nearby found active grenade which AI will try and toss back
	var/obj/item/explosive/grenade/active_grenade_found

/datum/ai_action/throw_back_nade
	name = "Throw Back Grenade"
	action_flags = ACTION_USING_HANDS | ACTION_USING_LEGS

/datum/ai_action/throw_back_nade/get_weight(datum/human_ai_brain/brain)
	if(QDELETED(brain.active_grenade_found))
		return 0

	if(get_dist(brain.tied_human, brain.active_grenade_found) > 4)
		return 0

	return ACTION_WEIGHT_THROW_BACK_GRENADE

/datum/ai_action/throw_back_nade/Destroy(force, ...)
	brain.active_grenade_found = null // Mr. Grenade is not our friend now
	return ..()

/datum/ai_action/throw_back_nade/trigger_action()
	. = ..()

	var/atom/active_grenade_found = brain.active_grenade_found
	if(QDELETED(active_grenade_found) || !isturf(active_grenade_found.loc))
		return ONGOING_ACTION_COMPLETED

	var/mob/living/carbon/human/tied_human = brain.tied_human
	if(get_dist(active_grenade_found, tied_human) > 1)
		if(!brain.move_to_next_turf(get_turf(active_grenade_found)))
			return ONGOING_ACTION_COMPLETED

		if(get_dist(active_grenade_found, tied_human) > 1)
			return ONGOING_ACTION_UNFINISHED

	var/view_distance = brain.view_distance
	var/list/possible_targets = list()

	for(var/mob/living/carbon/target in range(view_distance, tied_human))
		if(brain.can_target(target))
			possible_targets += target

	var/turf/place_to_throw
	if(length(possible_targets))
		var/mob/living/carbon/chosen_target = pick(possible_targets)
		var/list/turf_pathfind_list = AStar(get_turf(tied_human), get_turf(chosen_target), /turf/proc/AdjacentTurfs, /turf/proc/Distance, view_distance)
		for(var/i = length(turf_pathfind_list); i >= 4; i--) // We cut it off at 4 because we want to avoid most of the nade blast
			var/turf/target_turf = turf_pathfind_list[i]
			if(tied_human in viewers(view_distance, target_turf))
				place_to_throw = target_turf
				break

		if(!place_to_throw)
			place_to_throw = turf_pathfind_list[4]

	else // We haven't found an enemy in range that we can throw to, so we'll just throw in a direction that doesn't have friendlies
		var/list/directions = list(
			locate(tied_human.x, tied_human.y + 4, tied_human.z),
			locate(tied_human.x + 4, tied_human.y, tied_human.z),
			locate(tied_human.x, tied_human.y - 4, tied_human.z),
			locate(tied_human.x - 4, tied_human.y, tied_human.z),
		)
		dir_loop:
			for(var/turf/location as anything in directions)
				if(location)
					var/list/turf/path = get_line(tied_human, location, include_start_atom = FALSE)
					for(var/turf/possible_blocker as anything in path)
						if(possible_blocker.density)
							continue dir_loop

						for(var/obj/possible_object_blocker in path)
							if(possible_object_blocker.density)
								continue dir_loop

					var/has_friendly = FALSE
					for(var/mob/possible_friendly in range(3, location))
						if(!brain.can_target(possible_friendly))
							has_friendly = TRUE
							break

					if(!has_friendly)
						place_to_throw = location
						break

		if(!place_to_throw)
			// There's friendlies all around us, apparently. Just uh. Die ig.
			return ONGOING_ACTION_COMPLETED

	brain.clear_main_hand()
	tied_human.put_in_active_hand(active_grenade_found)

	tied_human.toggle_throw_mode(THROW_MODE_NORMAL)
	INVOKE_ASYNC(tied_human, TYPE_PROC_REF(/mob, throw_item), place_to_throw)

	tied_human.face_atom(place_to_throw)
	brain.to_pickup -= active_grenade_found // Do NOT play fetch. Please.
	return ONGOING_ACTION_COMPLETED
