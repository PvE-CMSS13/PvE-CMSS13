GLOBAL_LIST_EMPTY(all_ai_behavior_overrides)

/datum/component/ai_behavior_override

	/// Icon file for the behavior attached to parent as game masters will see it
	var/behavior_icon = 'icons/effects/game_master_xeno_behaviors.dmi'

	/// Specific icon state for the behavior attached to parent as game masters will see it
	var/behavior_icon_state = "should_not_see_this"

	/// The actual image holder that sits on parent for game masters
	var/image/behavior_image

	/// The xenos currently handling this task
	var/list/currently_assigned = list()

	/// How many xenos we want assigned to this task at max
	var/max_assigned = 3

	/// Should we try and find new xenos for this override, or stick to currently assigned
	var/search_assign = TRUE

/datum/component/ai_behavior_override/Initialize(delete_timer = 0)
	. = ..()

	GLOB.all_ai_behavior_overrides += src

	behavior_image = new(behavior_icon, parent, behavior_icon_state, layer = ABOVE_FLY_LAYER)
	behavior_image.alpha = 150

	for(var/client/game_master in GLOB.game_masters)
		game_master.images |= behavior_image

	if(delete_timer > 0)
		QDEL_IN(src, delete_timer)

/datum/component/ai_behavior_override/Destroy(force, silent, ...)
	GLOB.all_ai_behavior_overrides -= src

	for(var/client/game_master in GLOB.game_masters)
		game_master.images -= behavior_image

	QDEL_NULL(behavior_image)

	for(var/assigned_xeno in currently_assigned)
		UnregisterSignal(assigned_xeno, COMSIG_PARENT_QDELETING)
	currently_assigned = null

	. = ..()

/// Override this to check if we want our behavior to be valid for the checked_xeno, passes the common factor of "distance" which is the distance between the checked_xeno and src parent
/datum/component/ai_behavior_override/proc/check_behavior_validity(mob/living/carbon/xenomorph/checked_xeno, distance)
	if(!search_assign || length(currently_assigned) >= max_assigned && !(checked_xeno in currently_assigned))
		remove_from_queue(checked_xeno)
		return FALSE

	if(checked_xeno.stat != CONSCIOUS)
		remove_from_queue(checked_xeno)
		return FALSE

	return TRUE

/// Processes what we want this behavior to do, return FALSE if we want to continue in the process_ai() proc or TRUE if we want to handle everything and have process_ai() return
/datum/component/ai_behavior_override/proc/process_override_behavior(mob/living/carbon/xenomorph/processing_xeno, delta_time)
	SHOULD_NOT_SLEEP(TRUE)

	if(search_assign)
		RegisterSignal(processing_xeno, COMSIG_PARENT_QDELETING, PROC_REF(remove_from_queue), TRUE)
		currently_assigned |= processing_xeno

	return TRUE

/datum/component/ai_behavior_override/proc/remove_from_queue(mob/removed_xeno)
	SIGNAL_HANDLER
	currently_assigned -= removed_xeno
	UnregisterSignal(removed_xeno, COMSIG_PARENT_QDELETING)

	if(!search_assign && !length(currently_assigned))
		qdel(src)
