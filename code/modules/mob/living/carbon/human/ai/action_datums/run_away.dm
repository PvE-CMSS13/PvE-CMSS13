/datum/ai_action/run_away
	name = "Run Away"
	action_flags = ACTION_USING_LEGS
	incom

/datum/ai_action/run_away/get_weight(datum/human_ai_brain/brain)
	if(!brain.retreat_turf)
		return 0

	return ACTION_WEIGHT_RUN_AWAY

/datum/ai_action/run_away/get_conflicts()
	. = ..()
	. += /datum/ai_action/chase_target
	. += /datum/ai_action/sniper_nest
	. += /datum/ai_action/treat_self
	. += /datum/ai_action/reload
	. += /datum/ai_action/patrol_waypoints
	. += /datum/ai_action/throw_grenade

/datum/ai_action/run_away/trigger_action()
	. = ..()

	var/mob/living/tied_human = brain.tied_human
	if(!brain.retreat_turf)
		return ONGOING_ACTION_COMPLETED

	if(QDELETED(brain.retreat_turf))
		brain.retreat_turf = null
		return ONGOING_ACTION_COMPLETED

	if(get_dist(brain.retreat_turf, tied_human) > 0)
		if(!brain.move_to_next_turf(brain.retreat_turf))
			return ONGOING_ACTION_UNFINISHED

		if(get_dist(brain.retreat_turf, tied_human) > 0)
			return ONGOING_ACTION_UNFINISHED

	brain.retreat_turf = null
	return ONGOING_ACTION_COMPLETED

/datum/human_ai_brain
	var/turf/retreat_turf

/datum/human_ai_brain/proc/run_away(turf/running_from)
	var/running_range = 12
	if(!running_from)
		if(!current_target)
			return
		running_from = get_turf(current_target)
	var/turf/origin_turf = get_turf(tied_human)
	var/run_dir = make_dir_cardinal(get_dir(running_from, origin_turf))
	var/turf/hor_dir = get_step(origin_turf, run_dir)
	var/turf/left_corner = locate(origin_turf.x - running_range, origin_turf.y - running_range, origin_turf.z)
	var/list/run_turfs = CORNER_OUTLINE(left_corner, 2 * running_range + 1, 2 * running_range + 1)
	var/x_sign = sign(hor_dir.x - origin_turf.x)
	var/y_sign = sign(hor_dir.y - origin_turf.y)
	if(x_sign)
		for(var/turf/run_turf as anything in run_turfs)
			if(sign(run_turf.x - origin_turf.x) == x_sign)
				continue
			run_turfs -= run_turf
	if(y_sign)
		for(var/turf/run_turf as anything in run_turfs)
			if(sign(run_turf.y - origin_turf.y) == y_sign)
				continue
			run_turfs -= run_turf
#ifdef TESTING
	for(var/turf/highlight as anything in run_turfs)
		highlight.color = COLOR_RED
#endif
	var/search_interations = 0
	while(search_interations <= 10)
		var/turf/checking_turf = pick(run_turfs)
#ifdef TESTING
		checking_turf.color = COLOR_ORANGE
#endif
		if(checking_turf.density || istype(checking_turf, /turf/open/space))
			run_turfs -= checking_turf
			search_interations++
			continue
		for(var/obj/obstruction as anything in checking_turf.contents)
			if(obstruction.density)
				run_turfs -= checking_turf
				search_interations++
				continue
		if(move_to_next_turf(checking_turf))
			retreat_turf = checking_turf
			exit_combat()
#ifdef TESTING
			checking_turf.color = COLOR_GREEN
#endif
			return TRUE
		else
			run_turfs -= checking_turf
			search_interations++
			continue

	return
