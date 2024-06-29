// Impenetrable and invincible barriers
/obj/structure/blocker
	name = "blocker"
	density = TRUE
	anchored = TRUE
	unacidable = TRUE
	unslashable = TRUE
	icon = 'icons/landmarks.dmi'
	icon_state = "map_blocker"

/obj/structure/blocker/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE

/obj/structure/blocker/ex_act(severity)
	return

/obj/structure/blocker/invisible_wall
	name = "invisible wall"
	desc = "You cannot go this way."
	icon_state = "invisible_wall"
	opacity = FALSE
	layer = ABOVE_FLY_LAYER + 0.1 //to make it visible in the map editor
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/blocker/invisible_wall/Collided(atom/movable/AM)
	var/msg = desc
	if(!msg)
		msg = "You cannot go this way."
	to_chat(AM, SPAN_WARNING(msg))

/obj/structure/blocker/invisible_wall/New()
	..()
	icon_state = null

/obj/structure/blocker/invisible_wall/water
	desc = "You cannot wade out any further"
	icon_state = "map_blocker"

/obj/structure/blocker/fog
	name = "dense fog"
	desc = "It looks way too dangerous to traverse. Best wait until it has cleared up."
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	opacity = TRUE

/obj/structure/blocker/fog/Initialize(mapload, time_to_dispel)
	. = ..()

	if(!time_to_dispel)
		return INITIALIZE_HINT_QDEL

	dir = pick(CARDINAL_DIRS)
	QDEL_IN(src, time_to_dispel + rand(-5 SECONDS, 5 SECONDS))

/obj/structure/blocker/fog/attack_hand(mob/M)
	to_chat(M, SPAN_NOTICE("You peer through the fog, but it's impossible to tell what's on the other side..."))

/obj/structure/blocker/fog/attack_alien(M)
	attack_hand(M)
	return XENO_NONCOMBAT_ACTION


/obj/structure/blocker/forcefield
	name = "forcefield"

	icon = 'icons/landmarks.dmi'
	icon_state = "map_blocker"
	anchored = TRUE
	unacidable = TRUE
	density = FALSE

	var/is_whitelist = FALSE
	var/strict_types = FALSE

	var/list/types = list()
	var/visible = FALSE

/obj/structure/blocker/forcefield/get_projectile_hit_boolean(obj/projectile/P)
	if(!is_whitelist)
		return FALSE
	. = ..()

/obj/structure/blocker/forcefield/BlockedPassDirs(atom/movable/AM, target_dir)
	var/whitelist_no_block = is_whitelist? NO_BLOCKED_MOVEMENT : BLOCKED_MOVEMENT

	if(strict_types)
		if(AM.type in types)
			return whitelist_no_block
	else
		for(var/type in types)
			if(istype(AM, type))
				return whitelist_no_block

	return !whitelist_no_block

/obj/structure/blocker/forcefield/Initialize(mapload, ...)
	. = ..()

	if(!visible)
		invisibility = 101

GLOBAL_VAR_INIT(vehicle_blockers, TRUE)

/obj/structure/blocker/forcefield/vehicles
	types = list(/obj/vehicle/)


/obj/structure/blocker/forcefield/vehicles/handle_vehicle_bump(obj/vehicle/multitile/multitile_vehicle)
	if(!GLOB.vehicle_blockers)
		return TRUE
	if(multitile_vehicle.vehicle_flags & VEHICLE_BYPASS_BLOCKERS)
		return TRUE
	return FALSE

/obj/structure/blocker/forcefield/multitile_vehicles
	types = list(/obj/vehicle/multitile/)


/obj/structure/blocker/forcefield/multitile_vehicles/handle_vehicle_bump(obj/vehicle/multitile/multitile_vehicle)
	if(!GLOB.vehicle_blockers)
		return TRUE
	if(multitile_vehicle.vehicle_flags & VEHICLE_BYPASS_BLOCKERS)
		return TRUE
	return FALSE

/obj/structure/blocker/forcefield/human
	types = list(/mob/living/carbon/human)
	icon_state = "purple_line"

	visible = TRUE

/obj/structure/blocker/rock_debris
	name = "rock debris"
	desc = "A pile of rock debris from a cavein or something similar."
	icon = 'icons/obj/structures/props/mining.dmi'
	icon_state = "cavein"
	color = "#9b7e7e"
	opacity = TRUE
	layer = BELOW_WEATHER_LAYER //We want it to overlay mobs if it crushes them.
	var/id //Used to pick out the proper rocks to toggle.
	var/animating = FALSE

//Makes it block movement or hide it instead.
/obj/structure/blocker/rock_debris/proc/toggle_blocker(trigger_signal, play_sound = TRUE)
	if(trigger_signal == id && !animating)
		animating = TRUE //We are animating, so this doesn't get activated again until the animation is done and variables are set.
		if(invisibility) //It is invisible.
			invisibility = 0 //Immediately make it visible.
			if(play_sound)
				playsound(src, 'sound/effects/rocks_falling.ogg', 70, FALSE)
				visible_message(SPAN_LARGE(SPAN_WARNING("Rocks fall, stones tremble, as a dense pile of debris forms nearby!")), SPAN_WARNING("You hear something collapse and crumble nearby!"))
			animate(src, alpha = 255, 1.5 SECONDS) //15 deciseconds, make it opaque.
		else
			animate(src, alpha = 0, 1.5 SECONDS) //15 deciseconds.
			addtimer(VARSET_CALLBACK(src, invisibility, INVISIBILITY_MAXIMUM), 1.5 SECONDS) //Max invisbility.

		density = !density
		opacity = !opacity
		//I could add effects of actually being caught in the rocks, but that doesn't seem very useful. Maybe later.
		addtimer(VARSET_CALLBACK(src, animating, FALSE), 1.5 SECONDS) //Resets our status.



