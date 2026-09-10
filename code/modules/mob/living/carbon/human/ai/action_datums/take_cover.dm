/datum/ai_action/take_cover
	name = "Take Cover"
	action_flags = ACTION_USING_LEGS

/datum/ai_action/take_cover/get_weight(datum/human_ai_brain/brain)
	if(!brain.current_cover)
		return 0

	if(brain.hold_position)
		return 0

	if(brain.in_cover && !(get_dist(brain.tied_human, brain.current_target) > brain?.gun_data?.minimum_range))
		return 0

	return ACTION_WEIGHT_TAKE_COVER

/datum/ai_action/take_cover/trigger_action()
	. = ..()

	var/turf/current_cover = brain.current_cover
	if(!brain.current_cover)
		return ONGOING_ACTION_COMPLETED

#if defined(TESTING) || defined(HUMAN_AI_TESTING)
	current_cover.color = "#b80505"
	current_cover.maptext = "[brain.tied_human.real_name] | [get_dist(current_cover, brain.tied_human)]"
#endif

	if(get_dist(current_cover, brain.tied_human) > 0)
		if(!brain.move_to_next_turf(current_cover))
			brain.end_cover()
			return ONGOING_ACTION_COMPLETED

		if(get_dist(current_cover, brain.tied_human) > 0)
			return ONGOING_ACTION_UNFINISHED

	brain.in_cover = TRUE
	return ONGOING_ACTION_COMPLETED
