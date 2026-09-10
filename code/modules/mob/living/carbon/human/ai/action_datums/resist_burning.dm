/datum/ai_action/resist_burning
	name = "Resist Burning"
	action_flags = ACTION_USING_HANDS | ACTION_USING_LEGS | ACTION_USING_MOUTH

/datum/ai_action/resist_burning/get_weight(datum/human_ai_brain/brain)
	if(!brain.tied_human.on_fire || iszombie(brain.tied_human))
		return 0

	return 14

/datum/ai_action/resist_burning/trigger_action()
	. = ..()

	var/mob/living/tied_human = brain.tied_human
	if(!tied_human.on_fire)
		return ONGOING_ACTION_COMPLETED

	if(locate(/obj/flamer_fire) in get_turf(brain.tied_human))
		brain.try_cover()
		return ONGOING_ACTION_COMPLETED

	INVOKE_ASYNC(tied_human, TYPE_VERB_REF(/mob/living, resist))
	return ONGOING_ACTION_UNFINISHED
