/*

Just as a note, eventually it may be prudent to convert most of attack_alien() checks into two parts.

attack_alien() gets called as usual by normal sources but then immediately goes into:
Can we do the attack_alien(), probably like can_attack_alien() or some such
And then the usual attack_alien() effect

This way we can keep our obstacle checks up to date with any future attack_alien() changes by calling can_attack_alien()

Future problem for the time being and maybe not worth pursuing :shrug:

As a second note, please god follow the xeno_ai_obstacle chain to atom if possible, things like if(get_turf(src) == target) NEEDING to return 0 most times is very important.
At bare minimum, make sure the relevant checks from parent types gets copied in if you need to snowflake something.

*/// - Morrow

// OBJECTS
/obj/structure/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(!density)
		return 0

	if(unslashable && !climbable)
		return

	return OBJECT_PENALTY

/obj/structure/xeno_ai_act(mob/living/carbon/xenomorph/X)
	if(unslashable || indestructible || (climbable && islurker(X)))
		if(!X.action_busy)
			do_climb(X)
		return

	return ..()

/obj/structure/machinery/xeno_ai_act(mob/living/carbon/xenomorph/X)
	if(stat & TIPPED_OVER)
		return

	return ..()

// MINERAL DOOR
/obj/structure/mineral_door/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	return DOOR_PENALTY

/obj/structure/mineral_door/resin/xeno_ai_obstacle(mob/living/carbon/xenomorph/xeno, direction, turf/target)
	if(xeno.hivenumber != hivenumber)
		return ..()
	return 0

/obj/structure/mineral_door/resin/xeno_ai_act(mob/living/carbon/xenomorph/acting_xeno)
	if(acting_xeno.hivenumber == hivenumber)
		acting_xeno.a_intent = INTENT_HELP
	. = ..()

/// Platforms
/obj/structure/platform/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return DOOR_PENALTY

// Poddoors/shutters
/obj/structure/machinery/door/poddoor/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(!(stat & NOPOWER))
		return

	if(operating)
		return

	if(unacidable)
		return

	return DOOR_PENALTY

// AIRLOCK
/obj/structure/machinery/door/airlock/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	if(locked || welded || isElectrified())
		return INFINITY

	return DOOR_PENALTY

// HUMANS
/mob/living/carbon/human/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	if(status_flags & GODMODE)
		return ..()

	return HUMAN_PENALTY

/mob/living/carbon/human/xeno_ai_act(mob/living/carbon/xenomorph/X)
	if(status_flags & GODMODE)
		return

	. = ..()

// XENOS
/mob/living/carbon/xenomorph/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return XENO_PENALTY

// VEHICLES
/obj/vehicle/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return VEHICLE_PENALTY

// SENTRY
/obj/structure/machinery/defenses/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return VEHICLE_PENALTY

// WINDOW FRAME
/obj/structure/window_frame/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	if(X.claw_type == CLAW_TYPE_VERY_SHARP || (X.claw_type >= CLAW_TYPE_SHARP && !reinforced))
		return ..()
	return WINDOW_FRAME_PENALTY

/obj/structure/barricade/handrail/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return DOOR_PENALTY

// Avoid barricades if possible.
/obj/structure/barricade/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return BARRICADE_PENALTY

// FIRE
/obj/flamer_fire/xeno_ai_obstacle(mob/living/carbon/xenomorph/xeno, direction, turf/target)
	if(xeno.caste?.fire_immunity & (FIRE_IMMUNITY_NO_IGNITE|FIRE_IMMUNITY_NO_DAMAGE))
		return 0

	return FIRE_PENALTY

/// Open turfs, sometimes open turfs are passed back as obstacles due to platforms and such, generally it's fast so very slight penalty mainly for handling subtypes properly
/turf/open/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return OPEN_TURF_PENALTY

/// Space, do NOT path into space.
/turf/open/space/xeno_ai_obstacle(mob/living/carbon/xenomorph/X, direction, turf/target)
	. = ..()
	if(!.)
		return

	return INFINITY
