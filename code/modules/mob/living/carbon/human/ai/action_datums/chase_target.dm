/datum/ai_action/chase_target
	name = "Chase Target"
	action_flags = ACTION_USING_LEGS

/datum/ai_action/chase_target/get_weight(datum/human_ai_brain/brain)
	if(brain.in_cover)
		return 0

	if(!brain.target_turf)
		return 0

	if(brain.current_target)
		return 0

	if(brain.hold_position)
		return 0

	if(get_dist(brain.target_turf, brain.tied_human) > 20)
		return 0

	return ACTION_WEIGHT_CHASE_TARGET

/datum/ai_action/chase_target/get_conflicts(datum/human_ai_brain/brain)
	. = ..()
	. += /datum/ai_action/throw_grenade

/datum/ai_action/chase_target/trigger_action()
	. = ..()

	var/turf/target_turf = brain.target_turf
	if(QDELETED(target_turf) || brain.current_target)
		return ONGOING_ACTION_COMPLETED

	var/mob/tied_human = brain.tied_human
	if(get_dist(target_turf, tied_human) > 0)
		if(!brain.move_to_next_turf(target_turf))
			return ONGOING_ACTION_COMPLETED

		if(get_dist(target_turf, tied_human) > 0)
			return ONGOING_ACTION_COMPLETED

	// Turn around as we're seeking for the lost target
	var/direction = turn(tied_human.dir, pick(90,-90))
	tied_human.face_dir(direction)

	// Scouted, found nothing, discard
	brain.target_turf = null
	return ONGOING_ACTION_COMPLETED
