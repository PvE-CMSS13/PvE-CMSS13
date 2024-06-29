/*
 * Platforms
 */
/obj/structure/platform
	name = "platform"
	desc = "A square metal surface resting on four legs."
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "platform"
	climbable = TRUE
	anchored = TRUE
	density = TRUE
	throwpass = TRUE //You can throw objects over this, despite its density.
	layer = OBJ_LAYER
	breakable = FALSE
	flags_atom = ON_BORDER
	unacidable = TRUE
	unslashable = TRUE
	climb_delay = CLIMB_DELAY_SHORT
	projectile_coverage = PROJECTILE_COVERAGE_NONE

/obj/structure/platform/stair_cut
	icon_state = "platform_stair"//icon will be honked in all dirs except (1), that's because the behavior breaks if it ain't (1)
	dir = 1
/obj/structure/platform/stair_cut/alt
	icon_state = "platform_stair_alt"
	dir = 1

/obj/structure/platform/Initialize()
	. = ..()
	var/image/overlay_image = image(icon, src, "platform_overlay", LADDER_LAYER, dir)//ladder layer puts us just above weeds.
	switch(dir)
		if(SOUTH)
			layer = PLATFORM_LAYER // Fixed the climbing animation problem to some degree, but still looks very strange under some circumstances.
			overlay_image.pixel_y = -16
		if(NORTH)
			overlay_image.pixel_y = 16
		if(EAST)
			overlay_image.pixel_x = 16
			layer = PLATFORM_LAYER
		if(WEST)
			overlay_image.pixel_x = -16
			layer = PLATFORM_LAYER
	overlays += overlay_image

/obj/structure/platform/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER

/obj/structure/platform/Collided(atom/movable/AM)
	if(ismob(AM))
		do_climb(AM)
	..()
/*
/obj/structure/platform/BlockedExitDirs(obj/vehicle/multitile/V, target_dir)
	to_world(SPAN_DEBUG("Vehicle exit detected."))
	if(istype(V))
		//if(REVERSE_DIR(dir) == target_dir)
		if(dir == target_dir)
			to_world(SPAN_DEBUG("Directions match, colliding."))
			return BLOCKED_MOVEMENT
		else return NO_BLOCKED_MOVEMENT

	return ..()
*/
/obj/structure/platform/BlockedPassDirs(atom/movable/mover, target_dir)
//	if(istype(V))
//		if()

	var/obj/vehicle/multitile/V = mover
	if(istype(V) && dir == target_dir)
		return


	var/obj/structure/S = locate(/obj/structure) in get_turf(mover)
	if(S && S.climbable && !(S.flags_atom & ON_BORDER) && climbable && isliving(mover)) //Climbable objects allow you to universally climb over others
		return NO_BLOCKED_MOVEMENT

	return ..()

/obj/structure/platform/ex_act()
	return

/obj/structure/platform/attackby(obj/item/W, mob/user)
	. = ..()
	if(user.pulling)
		if(!can_climb(user))
			return
		user.visible_message(SPAN_WARNING("[user] starts dragging \the [user.pulling] onto \the [src]"),\
		SPAN_WARNING("You start dragging \the [user.pulling] onto \the [src]."))
		if(!do_after(user, 3 SECONDS * user.get_skill_duration_multiplier(SKILL_FIREMAN), INTERRUPT_ALL, BUSY_ICON_HOSTILE, user.pulling, INTERRUPT_MOVED, BUSY_ICON_HOSTILE))
			return
		if(user.pulling)
			if(!can_climb(user))
				return
			var/turf/move_to_turf = get_step(get_turf(src), dir)
			user.visible_message(SPAN_WARNING("[user] finishes dragging \the [user.pulling] onto \the [src]"),\
			SPAN_WARNING("You finish dragging \the [user.pulling] onto \the [src]."))
			user.pulling.forceMove(move_to_turf)

/obj/structure/platform_decoration
	name = "platform"
	desc = "A square metal surface resting on four legs."
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "platform_deco"
	anchored = TRUE
	density = FALSE
	throwpass = TRUE
	layer = OBJ_LAYER
	breakable = FALSE
	flags_atom = ON_BORDER
	unacidable = TRUE
	unslashable = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT /// Don't need to interact with them. They don't do anything.

/obj/structure/platform_decoration/Initialize()
	. = ..()
	switch(dir)
		if(NORTH, SOUTH, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)
			layer = PLATFORM_DECORATION_LAYER

/obj/structure/platform_decoration/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_OVER

/obj/structure/platform_decoration/ex_act()
	return

//Map variants//

//Strata purple ice//
/obj/structure/platform_decoration/strata
	name = "ice rock corner"
	desc = "A solid chunk of desolate rocks and ice."
	icon_state = "strata_platform_deco"

/obj/structure/platform/strata
	name = "ice rock edge"
	desc = "A solid chunk of desolate rocks and ice. Looks like you could climb it with some difficulty."
	icon_state = "strata_platform"

//Strata wall metal platforms
/obj/structure/platform_decoration/strata/metal
	name = "raised metal corner"
	desc = "A raised level of metal, often used to elevate areas above others. This is the corner."
	icon_state = "strata_metalplatform_deco"

/obj/structure/platform/strata/metal
	name = "raised metal edge"
	desc = "A raised level of metal, often used to elevate areas above others. You could probably climb it."
	icon_state = "strata_metalplatform"

//Kutjevo metal platforms

/obj/structure/platform/kutjevo
	icon_state = "kutjevo_platform"
	name = "raised metal edge"
	desc =  "A raised level of metal, often used to elevate areas above others, or construct bridges. You could probably climb it."
	climb_delay = 10

/obj/structure/platform_decoration/kutjevo
	name = "raised metal corner"
	desc = "The corner of what appears to be raised piece of metal, often used to imply the illusion of elevation in non-Euclidean 2d spaces. But you don't know that, you're just a spaceman with a rifle."
	icon_state = "kutjevo_platform_deco"


/obj/structure/platform/kutjevo/smooth
	icon_state = "kutjevo_platform_sm"
	name = "raised metal edge"
	desc =  "A raised level of metal, often used to elevate areas above others, or construct bridges. You could probably climb it."

/obj/structure/platform/kutjevo/smooth/stair_plate
	icon_state = "kutjevo_stair_plate"

/obj/structure/platform_decoration/kutjevo/smooth
	name = "raised metal corner"
	desc = "The corner of what appears to be raised piece of metal, often used to imply the illusion of elevation in non-Euclidean 2d spaces. But you don't know that, you're just a spaceman with a rifle."
	icon_state = "kutjevo_platform_sm_deco"

/obj/structure/platform/kutjevo/rock
	icon_state = "kutjevo_rock"
	name = "raised rock edges"
	desc = "A collection of stones and rocks that provide ample grappling and vaulting opportunity. Indicates a change in elevation. You could probably climb it."

/obj/structure/platform_decoration/kutjevo/rock
	name = "raised rock corner"
	desc = "A collection of stones and rocks that cap the edge of some conveniently 1-meter-long lengths of perfectly climbable chest high walls."
	icon_state = "kutjevo_rock_deco"


/obj/structure/platform/mineral
	icon_state = "stone"
/obj/structure/platform_decoration/mineral
	icon_state = "stone_deco"

/obj/structure/platform/mineral/sandstone
	name = "sandstone platform"
	desc = "A platform supporting elevated ground, made of sandstone. Has what seem to be ancient hieroglyphs on its side."
	color = "#c6a480"

/obj/structure/platform/mineral/sandstone/runed
	name = "sandstone temple platform"
	color = "#b29082"



/obj/structure/platform_decoration/mineral/sandstone
	name = "sandstone platform corner"
	desc = "A platform corner supporting elevated ground, made of sandstone. Has what seem to be ancient hieroglyphs on its side."
	color = "#c6a480"

/obj/structure/platform/shiva/catwalk
	icon_state = "shiva"
	name = "raised rubber cord platform"
	desc = "Reliable steel and a polymer rubber substitute. Doesn't crack under cold weather."

/obj/structure/platform_decoration/shiva/catwalk
	icon_state = "shiva_deco"
	name = "raised rubber cord platform"
	desc = "Reliable steel and a polymer rubber substitute. Doesn't crack under cold weather."

/obj/structure/platform_decoration/mineral/sandstone/runed
	name = "sandstone temple platform corner"
	color = "#b29082"
