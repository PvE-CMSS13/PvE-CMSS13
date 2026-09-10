/datum/ai_action/throw_grenade
	name = "Throw Grenade"
	action_flags = ACTION_USING_HANDS
	var/obj/item/explosive/grenade/throwing
	var/mid_throw

/datum/ai_action/throw_grenade/get_weight(datum/human_ai_brain/brain)
	if(!brain.grenading_allowed)
		return 0

	if(!brain.in_combat)
		return 0

	var/turf/target_turf = brain.target_turf
	if(!target_turf)
		return 0

	if(!length(brain.equipment_map[HUMAN_AI_GRENADES]))
		return 0

	if(!brain.primary_weapon)
		return ACTION_WEIGHT_THROW_GRENADE

	if(locate(/turf/closed) in get_line(brain.tied_human, target_turf))
		return ACTION_WEIGHT_THROW_GRENADE

	return 0

/datum/ai_action/throw_grenade/get_conflicts(datum/human_ai_brain/brain)
	. = ..()
	. += /datum/ai_action/chase_target
	. += /datum/ai_action/sniper_nest

/datum/ai_action/throw_grenade/Added()
	throwing = locate() in brain.equipment_map[HUMAN_AI_GRENADES]

/datum/ai_action/throw_grenade/Destroy(force, ...)
	throwing = null
	return ..()

/datum/ai_action/throw_grenade/trigger_action()
	. = ..()

	var/turf/target_turf = brain.target_turf
	if(QDELETED(throwing) || !target_turf)
		return ONGOING_ACTION_COMPLETED

	if(mid_throw)
		return ONGOING_ACTION_UNFINISHED

	var/mob/living/carbon/human/tied_human = brain.tied_human
	if(brain.primary_weapon)
		brain.primary_weapon.unwield(tied_human)
		if(tied_human.get_active_hand() == brain.primary_weapon)
			tied_human.swap_hand()

	mid_throw = TRUE
	brain.equip_item_from_equipment_map(HUMAN_AI_GRENADES, throwing)

	if(QDELETED(throwing) || (throwing.loc != tied_human))
		return ONGOING_ACTION_COMPLETED

	var/distance = get_dist(tied_human, target_turf)
	if(distance <= 2) // basic precautions
		return ONGOING_ACTION_COMPLETED

	if(distance > brain.view_distance)
		return ONGOING_ACTION_COMPLETED

	var/list/turf_line = get_line(tied_human, target_turf)

	for(var/turf/turf as anything in turf_line)
		if(turf.density)
			return ONGOING_ACTION_COMPLETED

		for(var/obj/object in turf)
			if(object.density)
				return ONGOING_ACTION_COMPLETED


	// below code is disabled because it leads to a lot of grenade FF and grenade walltosses.
	// The below code is better for making AI realistic, but shouldn't be uncommented until it's fixed.
	// Until then, we're using the above code where AI perfectly throw their nades.
	/*turf_loop:
		for(var/turf/turf in shuffle(RANGE_TURFS(2, target_turf)))
			var/distance = get_dist(tied_human, turf)
			if(distance <= 2) // basic precautions
				continue

			if(distance > brain.view_distance)
				continue

			var/list/turf_line = get_line(tied_human, turf)

			for(var/turf/turf2 as anything in turf_line)
				if(turf2.density)
					continue turf_loop

				for(var/obj/object in turf2)
					if(object.density)
						continue turf_loop

			throw_target = turf
			break*/

	tied_human.face_atom(target_turf)
	INVOKE_ASYNC(throwing, TYPE_PROC_REF(/obj/item, ai_use), tied_human, brain, target_turf)
	return ONGOING_ACTION_UNFINISHED
