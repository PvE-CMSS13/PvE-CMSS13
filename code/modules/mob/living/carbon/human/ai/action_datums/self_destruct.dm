/datum/ai_action/self_destruct
	name = "Self Destruct"
	action_flags = ACTION_USING_HANDS
	var/obj/item/explosive/grenade/grenade

/datum/ai_action/self_destruct/get_weight(datum/human_ai_brain/brain)
	if(!brain.last_stand)
		return 0

	if(!brain.grenading_allowed)
		return 0

	if(!brain.in_combat)
		return 0

	var/turf/target_turf = brain.target_turf
	if(!target_turf)
		return 0

	if(!length(brain.equipment_map[HUMAN_AI_GRENADES]))
		return 0

	if((brain.tied_human.health / brain.tied_human.maxHealth) <= 0.25)
		return ACTION_WEIGHT_HIGHEST_PRIORITY

	return 0

/datum/ai_action/self_destruct/get_conflicts(datum/human_ai_brain/brain)
	. = ..()
	. += /datum/ai_action/chase_target
	. += /datum/ai_action/sniper_nest

/datum/ai_action/self_destruct/Added()
	grenade = locate() in brain.equipment_map[HUMAN_AI_GRENADES]

/datum/ai_action/self_destruct/Destroy(force, ...)
	grenade = null
	return ..()

/datum/ai_action/self_destruct/trigger_action()
	. = ..()

	var/turf/target_turf = brain.target_turf
	if(QDELETED(grenade) || !target_turf)
		return ONGOING_ACTION_COMPLETED

	var/mob/living/carbon/human/tied_human = brain.tied_human
	if(brain.primary_weapon)
		brain.primary_weapon.unwield(tied_human)
		if(tied_human.get_active_hand() == brain.primary_weapon)
			tied_human.swap_hand()

	brain.equip_item_from_equipment_map(HUMAN_AI_GRENADES, grenade)

	if(QDELETED(grenade) || (grenade.loc != tied_human))
		return ONGOING_ACTION_COMPLETED

	var/distance = get_dist(tied_human, target_turf)
	if(distance <= 5 && !grenade.active) // basic precautions
		var/list/turf_line = get_line(tied_human, target_turf)
		var/line_of_sight = TRUE
		for(var/turf/turf as anything in turf_line)
			if(turf.density)
				line_of_sight = FALSE

			for(var/obj/object in turf)
				if(object.density)
					line_of_sight = TRUE
		if(line_of_sight)
			prime_grenade()

	if(distance > brain.view_distance)
		return ONGOING_ACTION_COMPLETED

	if(distance > 0)
		if(!brain.move_to_next_turf(target_turf))
			return ONGOING_ACTION_UNFINISHED_BLOCK

		if(get_dist(target_turf, tied_human) > 0)
			return ONGOING_ACTION_UNFINISHED_BLOCK

	tied_human.face_atom(target_turf)

	return ONGOING_ACTION_UNFINISHED

/datum/ai_action/self_destruct/proc/prime_grenade()
	INVOKE_ASYNC(grenade, TYPE_PROC_REF(/obj/item/explosive/grenade, attack_self), brain.tied_human)
	brain.tied_human.toggle_throw_mode(THROW_MODE_NORMAL)
	brain.ensure_primary_hand(src)
	brain.tied_human.face_atom(brain.target_turf)

	//brain.say_grenade_thrown_line()
