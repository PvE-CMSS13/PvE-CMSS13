/datum/ai_action/treat_self
	name = "Treat Self"
	action_flags = ACTION_USING_HANDS

/datum/ai_action/treat_self/get_weight(datum/human_ai_brain/brain)
	if(iszombie(brain.tied_human))
		return 0

	if(brain.healing_someone)
		return 0

	var/should_fire_offscreen = (brain.target_turf && !COOLDOWN_FINISHED(brain, fire_offscreen))
	if(brain.current_target || should_fire_offscreen)
		return 0

	if(length(brain.to_pickup))
		return 0

	if(!length(brain.equipment_map[HUMAN_AI_HEALTHITEMS]))
		return 0

	if(brain.cant_be_treated_stacks >= brain.treatment_stack_threshold)
		return 0

	if(!brain.healing_start_check(brain.tied_human))
		return 0

	return 4

/datum/ai_action/treat_self/Destroy(force, ...)
	brain.healing_someone = FALSE
	return ..()

/datum/ai_action/treat_self/trigger_action()
	. = ..()

	if(brain.current_target)
		return ONGOING_ACTION_COMPLETED

	if(!length(brain.equipment_map[HUMAN_AI_HEALTHITEMS]))
		return ONGOING_ACTION_COMPLETED

	var/mob/living/tied_human = brain.tied_human
	if(tied_human.on_fire)
		return ONGOING_ACTION_COMPLETED

	if(brain.healing_someone)
		return ONGOING_ACTION_UNFINISHED

	if(brain.healing_start_check(tied_human))
		if(!brain.start_healing(tied_human))
			brain.cant_be_treated_stacks++
		return ONGOING_ACTION_UNFINISHED

	return ONGOING_ACTION_COMPLETED
