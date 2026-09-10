/datum/ai_action/follow_leader
	name = "Follow Leader"
	action_flags = ACTION_USING_LEGS
	var/follow_distance = 1

/datum/ai_action/follow_leader/get_weight(datum/human_ai_brain/brain)
	if(brain.in_cover)
		return 0

	if(brain.is_squad_leader)
		return 0

	if(brain.hold_position)
		return 0

	if(length(brain.to_pickup))
		return 0

	var/datum/human_ai_squad/squad = SShuman_ai.squad_id_dict["[brain.squad_id]"]
	if(!squad)
		return 0

	var/mob/squad_leader = squad.squad_leader?.tied_human
	if(!squad_leader)
		return 0

	if(get_dist(brain.tied_human, squad_leader) <= (1 + length(squad.ai_in_squad) / 2))
		return 0

	return ACTION_WEIGHT_FOLLOW_LEADER

/datum/ai_action/follow_leader/Added()
	if(!brain.squad_id)
		return

	var/datum/human_ai_squad/squad = SShuman_ai.squad_id_dict["[brain.squad_id]"]
	follow_distance = 1 + length(squad.ai_in_squad) / 2

/datum/ai_action/follow_leader/trigger_action()
	. = ..()

	if(brain.in_combat || length(brain.to_pickup))
		return ONGOING_ACTION_COMPLETED

	var/datum/human_ai_squad/squad = SShuman_ai.squad_id_dict["[brain.squad_id]"]
	var/mob/squad_leader = squad.squad_leader?.tied_human

	var/mob/tied_human = brain.tied_human
	if(get_dist(tied_human, squad_leader) > follow_distance)
		if(!brain.move_to_next_turf(get_turf(squad_leader)))
			return ONGOING_ACTION_COMPLETED

		if(get_dist(tied_human, squad_leader) > follow_distance)
			return ONGOING_ACTION_UNFINISHED

	return ONGOING_ACTION_COMPLETED
