/atom/proc/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	if(get_turf(src) == target)
		return 0
	return INFINITY

/atom/proc/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(!mouse_opacity || (level < 2))
		return FALSE

	if(!brain.unholster_any_weapon())
		ai_human.a_intent_change(INTENT_HARM)

	ai_human.do_click(src, "", list())
	ai_human.face_atom(src)
	return TRUE


/////////////////////////////
//         OBJECTS         //
/////////////////////////////
/obj/structure/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(!density)
		return 0

	return OBJECT_PENALTY

/obj/structure/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(climbable)
		if(!ai_human.action_busy)
			do_climb(ai_human)
		return TRUE

	return ..()

/////////////////////////////
//       MINERAL DOOR      //
/////////////////////////////
/obj/structure/mineral_door/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	if(!brain.primary_weapon)
		return INFINITY

	return DOOR_PENALTY

/obj/structure/mineral_door/resin/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	var/obj/item/weapon/gun/primary_weapon = brain.primary_weapon
	if(!primary_weapon)
		return TRUE

	brain.unholster_primary()
	brain.ensure_primary_hand(primary_weapon)

	return ..()


/////////////////////////////
//        PLATFORMS        //
/////////////////////////////
/obj/structure/platform/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return DOOR_PENALTY


/////////////////////////////
//         PODDDOORS       //
/////////////////////////////
/obj/structure/machinery/door/poddoor/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(!(stat & NOPOWER))
		return INFINITY

	if(density && !operating && !unacidable && brain.get_tool_from_equipment_map(TRAIT_TOOL_CROWBAR))
		return DOOR_PENALTY

	return INFINITY

/obj/structure/machinery/door/poddoor/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(!(stat & NOPOWER) || !brain.get_tool_from_equipment_map(TRAIT_TOOL_CROWBAR))
		return

	brain.holster_primary()
	var/obj/item/crowbar = brain.get_tool_from_equipment_map(TRAIT_TOOL_CROWBAR)
	brain.equip_item_from_equipment_map(HUMAN_AI_TOOLS, crowbar)
	ai_human.do_click(src, "", list())
	brain.store_item(crowbar, brain.storage_has_room(crowbar), HUMAN_AI_TOOLS)

/////////////////////////////
//         AIRLOCK         //
/////////////////////////////
/obj/structure/machinery/door/airlock/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(locked || welded || (isElectrified() && !iszombie(ai_human)) || !arePowerSystemsOn() || panel_open)
		return LOCKED_DOOR_PENALTY

	if(!check_access(ai_human.get_active_hand()) && !check_access(ai_human.wear_id) && !iszombie(ai_human))
		return LOCKED_DOOR_PENALTY

	return DOOR_PENALTY

/obj/structure/machinery/door/airlock/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if((welded || locked || isElectrified()) && !iszombie(ai_human))
		return ..()

	if(!(arePowerSystemsOn() || !panel_open))
		return

	if(layer == DOOR_OPEN_LAYER)
		return

	if(iszombie(ai_human))
		ai_human.a_intent_change(INTENT_DISARM)
		ai_human.do_click(src, "", list())
		return

	brain.holster_primary()
	var/obj/item/crowbar = brain.get_tool_from_equipment_map(TRAIT_TOOL_CROWBAR)
	brain.equip_item_from_equipment_map(HUMAN_AI_TOOLS, crowbar)
	ai_human.do_click(src, "", list())
	brain.store_item(crowbar, brain.storage_has_room(crowbar), HUMAN_AI_TOOLS)

/////////////////////////////
//         HUMANS         //
/////////////////////////////
/mob/living/carbon/human/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return HUMAN_PENALTY

/mob/living/carbon/human/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(stat == DEAD)
		return TRUE

	if(brain.faction_check(src))
		if(!iszombie(ai_human))
			var/random_intent = pick(INTENT_DISARM, INTENT_HARM, INTENT_HELP, INTENT_DISARM, INTENT_HARM) // lower chance of help intent
			ai_human.a_intent = random_intent
			if(get_ai_brain())
				a_intent = random_intent
		return TRUE

	if((body_position == LYING_DOWN) && (brain.current_target != src))
		return TRUE

	return ..()

/////////////////////////////
//          XENOS          //
/////////////////////////////
/mob/living/carbon/xenomorph/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return XENO_PENALTY

/mob/living/carbon/xenomorph/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(brain.faction_check(src))
		return TRUE

	return ..()

/////////////////////////////
//         VEHICLES        //
/////////////////////////////
/obj/vehicle/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return VEHICLE_PENALTY


/////////////////////////////
//         SENTRY          //
/////////////////////////////
/obj/structure/machinery/defenses/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return SENTRY_PENALTY

/////////////////////////////
//       BARRICADES        //
/////////////////////////////
/obj/structure/barricade/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(!is_wired)
		if(!ai_human.action_busy)
			do_climb(ai_human)
		return TRUE

	return ..()

/obj/structure/barricade/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return BARRICADE_PENALTY

/obj/structure/barricade/plasteel/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	if(iszombie(ai_human))
		return ..()
	if(!closed) // this means it's closed
		ai_human.do_click(src, "", list())
	else
		. = ..()
	if(!closed)
		close(src)

/obj/structure/barricade/handrail/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return DOOR_PENALTY


/////////////////////////////
//          FIRE           //
/////////////////////////////
/obj/flamer_fire/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/braineno, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(iszombie(ai_human))
		return OPEN_TURF_PENALTY

	if(ai_human.on_fire)
		return FIRE_PENALTY

	return INFINITY // STOP. TOUCHING. THE FLAMES!

/////////////////////////////
//          WALLS          //
/////////////////////////////
/turf/closed/wall/resin/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/braineno, direction, turf/target)
	. = ..()
	if(!.)
		return

	return WALL_PENALTY


/////////////////////////////
//          FLOOR          //
/////////////////////////////
/*
	Sometimes open turfs are passed back as obstacles due to platforms and such,
	generally it's fast so very slight penalty mainly for handling subtypes properly
*/
/turf/open/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return OPEN_TURF_PENALTY

/turf/open/human_ai_act(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain)
	return FALSE

/turf/open/space/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(!.)
		return

	return INFINITY


/////////////////////////////
//          RIVER          //
/////////////////////////////
/turf/open/gm/river/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	. = ..()
	if(. && !covered)
		. += base_river_slowdown

/turf/open/gm/river/desert/human_ai_obstacle(mob/living/carbon/human/ai_human, datum/human_ai_brain/brain, direction, turf/target)
	if(toxic && !covered)
		return FIRE_PENALTY

	return ..()
