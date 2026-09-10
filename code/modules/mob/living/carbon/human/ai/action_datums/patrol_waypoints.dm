/datum/ai_action/patrol_waypoints
	name = "Patrol Waypoints"
	action_flags = ACTION_USING_LEGS

/datum/ai_action/patrol_waypoints/get_weight(datum/human_ai_brain/brain)
	if(brain.in_combat)
		return 0

	var/datum/ai_order/patrol/current_order = brain.current_order
	if(!istype(brain.current_order))
		return 0

	if(length(brain.to_pickup))
		return 0

	if(current_order.waiting)
		return 0

	if(!brain.is_squad_leader)
		if(get_dist(brain.tied_human, current_order.current_waypoint) <= 1)
			return 0

	return ACTION_WEIGHT_PATROL_WAYPOINTS

/datum/ai_action/patrol_waypoints/trigger_action()
	. = ..()

	var/datum/ai_order/patrol/current_order = brain.current_order
	if(current_order.waiting || QDELETED(current_order) || !istype(current_order) || length(brain.to_pickup) || brain.in_combat)
		return ONGOING_ACTION_COMPLETED

	var/turf/current_waypoint = current_order.current_waypoint
	if(QDELETED(current_waypoint))
		var/datum/human_ai_squad/squad = SShuman_ai.squad_id_dict["[brain.squad_id]"]
		if(squad)
			squad.remove_current_order() // Our brain is included
		else
			brain.remove_current_order()
		return ONGOING_ACTION_COMPLETED

	var/mob/tied_human = brain.tied_human
	if(get_dist(current_waypoint, tied_human) > 1)
		if(!brain.move_to_next_turf(current_waypoint))
			return ONGOING_ACTION_COMPLETED

		if(get_dist(current_waypoint, tied_human) > 1)
			return ONGOING_ACTION_UNFINISHED

	if(brain.is_squad_leader)
		current_order.waiting = TRUE
		addtimer(CALLBACK(current_order, TYPE_PROC_REF(/datum/ai_order/patrol, set_next_waypoint)), current_order.time_at_waypoint)

	return ONGOING_ACTION_COMPLETED
