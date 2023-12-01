
/datum/component/ai_behavior_override/build
	behavior_icon_state = "priority_move_order"

	max_assigned = 1

/datum/component/ai_behavior_override/build/Initialize(...)
	. = ..()

	if(istype(parent, /mob))
		return COMPONENT_INCOMPATIBLE

	var/turf/open/location = get_turf(parent)
	if(location.is_weedable() != FULLY_WEEDABLE)
		return COMPONENT_INCOMPATIBLE

/datum/component/ai_behavior_override/build/Destroy(force, silent, ...)
	var/turf/parent_turf = get_turf(parent)
	if(QDELETED(parent) && parent_turf != parent)
		parent_turf.AddComponent(/datum/component/ai_behavior_override/build)

	return ..()

/datum/component/ai_behavior_override/build/check_behavior_validity(mob/living/carbon/xenomorph/checked_xeno, distance)
	. = ..()
	if(!.)
		return

	var/turf/open/location = get_turf(parent)
	if(!istype(location))
		qdel(src)
		return FALSE

	if(locate(/obj/structure/mineral_door/resin) in location)
		qdel(src)
		return FALSE

	if(distance > 10)
		return FALSE

	if(checked_xeno.current_target)
		return FALSE

	if(!locate(/datum/action/xeno_action/activable/secrete_resin) in checked_xeno.actions)
		return FALSE

	if(checked_xeno.get_plasma_percentage() < PLASMA_RETREAT_PERCENTAGE)
		var/turf/xeno_loc = get_turf(checked_xeno)
		if(xeno_loc.weeds && !checked_xeno.resting)
			currently_assigned -= checked_xeno
			checked_xeno.lay_down()

		return FALSE

	return TRUE

/datum/component/ai_behavior_override/build/process_override_behavior(mob/living/carbon/xenomorph/processing_xeno, delta_time)
	. = ..()
	if(!.)
		return

	processing_xeno.resting = FALSE

	var/turf/xeno_loc = get_turf(processing_xeno)
	if(xeno_loc.density)
		return FALSE // We shouldn't stand in a wall, let's act default

	var/turf/parent_turf = get_turf(parent)

	var/is_diagonal = (get_dir(processing_xeno, parent_turf) in diagonals)
	if(is_diagonal || get_dist(processing_xeno, parent) > 1)
		return processing_xeno.move_to_next_turf(parent_turf)

	for(var/obj/structure/blocker in parent_turf.contents)
		if(!blocker.unslashable && blocker.density || istype(blocker, /obj/structure/bed))
			INVOKE_ASYNC(processing_xeno, TYPE_PROC_REF(/mob, do_click), blocker, "", list())
			return TRUE

	if(!parent_turf.weeds)
		var/datum/action/xeno_action/onclick/plant_weeds/weeds_action = locate() in processing_xeno.actions
		INVOKE_ASYNC(weeds_action, TYPE_PROC_REF(/datum/action/xeno_action/onclick/plant_weeds, use_ability_wrapper))
		return TRUE

	var/list/resin_types = processing_xeno.resin_build_order
	processing_xeno.selected_resin = locate(/datum/resin_construction/resin_turf/wall) in resin_types

	var/wall_nearby
	var/blocked_turfs = 0
	for(var/turf/blocked_turf in orange(1, parent_turf) - parent_turf.AdjacentTurfs())
		if(get_dir(blocked_turf, parent_turf) in diagonals)
			continue

		if(blocked_turf.density)
			wall_nearby = TRUE

		blocked_turfs++

	if(blocked_turfs)
		if(prob(XENO_DOOR_BUILDING_CHANCE) || (wall_nearby && blocked_turfs == 2))
			processing_xeno.selected_resin = locate(/datum/resin_construction/resin_obj/door) in resin_types

	var/datum/action/xeno_action/activable/secrete_resin/build_action = locate() in processing_xeno.actions
	INVOKE_ASYNC(build_action, TYPE_PROC_REF(/datum/action/xeno_action/activable/secrete_resin, use_ability_wrapper), parent_turf)
	return TRUE
