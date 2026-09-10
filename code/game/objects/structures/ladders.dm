#define LADDER_LOCKED 0
#define LADDER_UNLOCKED 1
#define LADDER_OPEN 2
#define WATCHING_NOTHING 0
#define WATCHING_BELOW 1
#define WATCHING_ABOVE 2

/obj/structure/ladder
	name = "ladder"
	desc = "A sturdy metal ladder."
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "ladder11"
	var/id = null
	var/height = 0 //The 'height' of the ladder. higher numbers are considered physically higher
	var/obj/structure/ladder/down = null //The ladder below this one
	var/obj/structure/ladder/up = null //The ladder above this one
	anchored = TRUE
	unslashable = TRUE
	unacidable = TRUE
	layer = LADDER_LAYER
	var/state = LADDER_OPEN //For hatch ladders. Other ladders are always open.
	var/is_watching = WATCHING_NOTHING
	var/obj/structure/machinery/camera/cam
	var/busy = FALSE //Ladders are wonderful creatures, only one person can use it at a time
	var/climb_time = 2 SECONDS
	var/climb_sound = null

/obj/structure/ladder/Initialize(mapload, ...)
	. = ..()
	cam = new /obj/structure/machinery/camera(src)
	cam.network = list(CAMERA_NET_LADDER)
	cam.c_tag = name

	GLOB.ladder_list += src
	return INITIALIZE_HINT_LATELOAD

//If we drop ladders down, only need to run the proc on the middle ladder to connect three. Or any of two ladders.
/obj/structure/ladder/LateInitialize()
	. = ..()

	if(id) //Don't need to run this if there is no ID.
		for(var/obj/structure/ladder/other_ladder as anything in GLOB.ladder_list)
			if(up && down)
				break //If both our connections are filled; we are done.

			if(other_ladder.id == id)
				switch(other_ladder.height - height)
					if(-1)
						if(!down)
							down = other_ladder //Only if the connection isn't established yet.
						if(!other_ladder.up)
							other_ladder.up = src
							other_ladder.update_icon()
					if(1)
						if(!up)
							up = other_ladder
						if(!other_ladder.down)
							other_ladder.down = src
							other_ladder.update_icon()
	update_icon() //Update the icon regardless.

/obj/structure/ladder/Destroy()
	if(down)
		if(istype(down))
			down.up = null
			down.update_icon()
		down = null
	if(up)
		if(istype(up))
			up.down = null
			up.update_icon()
		up = null
	QDEL_NULL(cam)
	GLOB.ladder_list -= src
	. = ..()

/obj/structure/ladder/update_icon()
	icon_state = "ladder[up ? 1 : 0][down ? 1 : 0]"

/obj/structure/ladder/attack_hand(mob/living/user)
	if(user.stat || get_dist(user, src) > 1 || user.blinded || user.body_position == LYING_DOWN || user.buckled || user.anchored) return
	if(busy)
		to_chat(user, SPAN_WARNING("Someone else is currently using [src]."))
		return
	if(state == LADDER_LOCKED) //Can't descend if it's locked.
		to_chat(user, SPAN_WARNING("It appears to be locked and bolted!"))
		return

	if(open_hatch(user))
		return //If it's closed and unlocked, we need to first pop it open, then we can climb in.
	var/ladder_dir_name
	var/obj/structure/ladder/ladder_dest
	if(up && down)
		ladder_dir_name = alert("Go up or down the ladder?", "Ladder", "Up", "Down", "Cancel")
		if(ladder_dir_name == "Cancel")
			return
		ladder_dir_name = lowertext(ladder_dir_name)
		if(ladder_dir_name == "up") ladder_dest = up
		else ladder_dest = down
	else if(up)
		ladder_dir_name = "up"
		ladder_dest = up
	else if(down)
		ladder_dir_name = "down"
		ladder_dest = down
	else return //just in case

	step(user, get_dir(user, src))
	if(climb_sound)
		playsound_client(user.client, climb_sound, src, 10)
		user.Root(climb_time) // You aren't getting off Mr Bones Wild Ride, bucko
		user.visible_message(SPAN_NOTICE("[user] starts climbing [ladder_dir_name] [src], focussing wholly on the climb ahead. Pulling them off the ladder would be a bad idea..."), //Different message with hint for others to not grab & bring them up
		SPAN_NOTICE("You start climbing [ladder_dir_name] [src]. Wow, that's a long way to go..."))
	else
		user.visible_message(SPAN_NOTICE("[user] starts climbing [ladder_dir_name] [src]."),
		SPAN_NOTICE("You start climbing [ladder_dir_name] [src]."))
	busy = TRUE
	if(do_after(user, climb_time, INTERRUPT_INCAPACITATED|INTERRUPT_OUT_OF_RANGE|INTERRUPT_RESIST, BUSY_ICON_GENERIC, src, INTERRUPT_NONE))
		if(ladder_dest.state == LADDER_LOCKED) //The ladder they are climbing to is a hatch and is locked.
			to_chat(user, SPAN_WARNING("There is a bolted hatch blocking your progress!"))
		else if(state <= LADDER_UNLOCKED) //The ladder hatch somehow closed while they were climbing. Shouldn't happen, but can happen.
			to_chat(user, SPAN_WARNING("The hatch suddenly closed before you could climb it!"))
		else if(!user.is_mob_incapacitated() && get_dist(user, src) <= 1 && !user.blinded && user.body_position != LYING_DOWN && !user.buckled && !user.anchored)
			visible_message(SPAN_NOTICE("[user] climbs [ladder_dir_name] [src].")) //Hack to give a visible message to the people here without duplicating user message
			user.visible_message(SPAN_NOTICE("[user] climbs [ladder_dir_name] [src]."),
			SPAN_NOTICE("You climb [ladder_dir_name] [src]."))
			user.trainteleport(ladder_dest.loc)
			if(!ladder_dest.open_hatch(user))
				ladder_dest.add_fingerprint(user) //Fingerprints are added by the open proc, elsewise we add them here.
			user.SetRoot(0) //Unstick the poor sod
	busy = FALSE
	add_fingerprint(user)

/obj/structure/ladder/check_eye(mob/living/user)
	//Are we capable of looking?
	if(user.is_mob_incapacitated() || get_dist(user, src) > 1 || user.blinded || user.body_position == LYING_DOWN || !user.client)
		user.unset_interaction()

	//Are ladder cameras ok?
	switch(is_watching)
		if(WATCHING_BELOW)
			if(state < LADDER_OPEN || !down || !down.cam || !down.cam.can_use()) //Watching below but we don't have a ladder, the ladder is not open, etc.
				user.unset_interaction()

		if(WATCHING_ABOVE)
			if(!up || up.state < LADDER_OPEN || !up.cam || !up.cam.can_use()) //Watching above but either it's a closed hatch or cams are gone, etc.
				user.unset_interaction()



/obj/structure/ladder/on_set_interaction(mob/user)
	switch(is_watching)
		if(WATCHING_BELOW)
			if(istype(down) && down.cam && down.cam.can_use()) //Camera works
				user.reset_view(down.cam)
				return
		if(WATCHING_ABOVE)
			if (istype(up) && up.cam && up.cam.can_use())
				user.reset_view(up.cam)
				return

	user.unset_interaction() //No usable cam, we stop interacting right away



/obj/structure/ladder/on_unset_interaction(mob/user)
	..()
	is_watching = WATCHING_NOTHING
	user.reset_view(null)

//Peeking up/down
/obj/structure/ladder/MouseDrop(over_object, src_location, over_location)
	if((over_object == usr && (in_range(src, usr))))
		if(islarva(usr) || isobserver(usr) || usr.is_mob_incapacitated() || usr.blinded)
			to_chat(usr, "You can't do that in your current state.")
			return
		if(is_watching)
			to_chat(usr, "Someone's already looking through [src].")
			return
		if(up && down)
			switch( alert("Look up or down the ladder?", "Ladder", "Up", "Down", "Cancel") )
				if("Up")
					if(up.state < LADDER_OPEN)
						to_chat(usr, SPAN_WARNING("You try to peer up, but the hatch above is closed."))
					else
						usr.visible_message(SPAN_NOTICE("[usr] looks up [src]!"),
						SPAN_NOTICE("You look up [src]!"))
						is_watching = WATCHING_ABOVE
						usr.set_interaction(src)

				if("Down")
					usr.visible_message(SPAN_NOTICE("[usr] looks down [src]!"),
					SPAN_NOTICE("You look down [src]!"))
					is_watching = WATCHING_BELOW
					usr.set_interaction(src)

				if("Cancel")
					return

		else if(up)
			if(up.state < LADDER_OPEN)
				to_chat(usr, SPAN_WARNING("You try to peer up, but the hatch above is closed."))
			else
				usr.visible_message(SPAN_NOTICE("[usr] looks up [src]!"),
				SPAN_NOTICE("You look up [src]!"))
				is_watching = WATCHING_ABOVE
				usr.set_interaction(src)


		else if(down)
			usr.visible_message(SPAN_NOTICE("[usr] looks down [src]!"),
			SPAN_NOTICE("You look down [src]!"))
			is_watching = WATCHING_BELOW
			usr.set_interaction(src)

	add_fingerprint(usr)

/obj/structure/ladder/ex_act(severity)
	return

//Throwing Shiet
/obj/structure/ladder/attackby(obj/item/W, mob/user)
	if(state < LADDER_OPEN)
		return //Can't drop anything if it's closed. Maybe this will change if grate hatches are added.
	//Throwing Grenades
	if(istype(W,/obj/item/explosive/grenade))
		var/obj/item/explosive/grenade/G = W
		var/ladder_dir_name
		var/obj/structure/ladder/ladder_dest
		if(up && down)
			ladder_dir_name = alert("Throw up or down?", "Ladder", "Up", "Down", "Cancel")
			if(ladder_dir_name == "Cancel")
				return
			ladder_dir_name = lowertext(ladder_dir_name)
			if(ladder_dir_name == "up") ladder_dest = up
			else ladder_dest = down
		else if(up)
			ladder_dir_name = "up"
			ladder_dest = up
		else if(down)
			ladder_dir_name = "down"
			ladder_dest = down
		else return //just in case

		if(G.antigrief_protection && user.faction == FACTION_MARINE && explosive_antigrief_check(G, user))
			to_chat(user, SPAN_WARNING("\The [G.name]'s safe-area accident inhibitor prevents you from priming the grenade!"))
			// Let staff know, in case someone's actually about to try to grief
			msg_admin_niche("[key_name(user)] attempted to prime \a [G.name] in [get_area(src)] [ADMIN_JMP(src.loc)]")
			return

		user.visible_message(SPAN_WARNING("[user] takes position to throw [G] [ladder_dir_name] [src]."),
		SPAN_WARNING("You take position to throw [G] [ladder_dir_name] [src]."))
		if(do_after(user, 10, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
			user.visible_message(SPAN_WARNING("[user] throws [G] [ladder_dir_name] [src]!"),
			SPAN_WARNING("You throw [G] [ladder_dir_name] [src]"))
			user.drop_held_item()
			G.forceMove(ladder_dest.loc)
			G.setDir(pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
			step_away(G, src, rand(1, 5))
			if(!G.active)
				G.activate(user)

	//Throwing Flares and flashlights
	else if(istype(W,/obj/item/device/flashlight))
		var/obj/item/device/flashlight/F = W
		var/ladder_dir_name
		var/obj/structure/ladder/ladder_dest
		if(up && down)
			ladder_dir_name = alert("Throw up or down?", "Ladder", "Up", "Down", "Cancel")
			if(ladder_dir_name == "Cancel")
				return
			ladder_dir_name = lowertext(ladder_dir_name)
			if(ladder_dir_name == "up") ladder_dest = up
			else ladder_dest = down
		else if(up)
			ladder_dir_name = "up"
			ladder_dest = up
		else if(down)
			ladder_dir_name = "down"
			ladder_dest = down
		else return //just in case

		user.visible_message(SPAN_WARNING("[user] takes position to throw [F] [ladder_dir_name] [src]."),
		SPAN_WARNING("You take position to throw [F] [ladder_dir_name] [src]."))
		if(do_after(user, 10, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
			user.visible_message(SPAN_WARNING("[user] throws [F] [ladder_dir_name] [src]!"),
			SPAN_WARNING("You throw [F] [ladder_dir_name] [src]"))
			user.drop_held_item()
			F.forceMove(ladder_dest.loc)
			F.setDir(pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
			step_away(F,src,rand(1, 5))
	else
		return attack_hand(user)

//======== hatch-style ladder ===============
//These can be used in the future for grates and sewer entrances and such. Might need a few slight adjustments if that happens.

/obj/structure/ladder/hatch
	name = "locked hatch"
	desc = "A tightly closed hatch. It is currently locked and bolted, and cannot be opened."
	icon_state = "ladder_hatch0"
	state = LADDER_LOCKED
	pixel_y = 10 //Offset it up more.

/obj/structure/ladder/hatch/update_icon()
	icon_state = "ladder_hatch[state]"

/*
The following procs are made general as to cut down on type checking, since it's not really needed. Could make them children specific to hatch, but it should never come up.
If that changes, may need a slight refactor.
*/
/obj/structure/ladder/proc/toggle_lock(trigger_signal)
	if(!unlock_hatch(trigger_signal))
		lock_hatch(trigger_signal) //If it doesn't match the first one, we will do the second.

/obj/structure/ladder/proc/unlock_hatch(trigger_signal)
	if(state == LADDER_LOCKED && trigger_signal == id)
		name = "unlocked hatch"
		desc = "A tightly closed hatch. It has been unlocked and can now be opened."
		state = LADDER_UNLOCKED
		playsound(src, 'sound/effects/industrial_buzzer.ogg', 25, FALSE)
		update_icon()
		return TRUE

/obj/structure/ladder/proc/lock_hatch(trigger_signal)
	if(state > LADDER_LOCKED && trigger_signal == id)
		if(state == LADDER_OPEN)
			visible_message(SPAN_NOTICE("[src] closes!"), SPAN_NOTICE("Something closes nearby!"))
			playsound(src, 'sound/effects/hydraulic_close.ogg', 25, FALSE)
		name = initial(name)
		desc = initial(desc)
		state = LADDER_LOCKED
		playsound(src, 'sound/effects/industrial_buzzer.ogg', 25, FALSE)
		update_icon()
		return TRUE

/obj/structure/ladder/proc/open_hatch(mob/living/user)
	if(state == LADDER_UNLOCKED)
		if(user)
			user.visible_message(SPAN_NOTICE("[user] opens [src]."), SPAN_NOTICE("Something swings open nearby,"))
			add_fingerprint(user)
		else
			visible_message(SPAN_NOTICE("[src].swings open."), SPAN_NOTICE("Something swings open nearby,"))

		playsound(src, 'sound/effects/metal_open.ogg', 25, FALSE)
		name = "ladder hatch"
		desc = "A hatch with a metal ladder leading somewhere below."
		state = LADDER_OPEN
		update_icon()
		return TRUE

/obj/structure/ladder/proc/close_hatch()
	if(state == LADDER_OPEN)
		visible_message(SPAN_NOTICE("[src] closes!"), SPAN_NOTICE("Something closes nearby!"))
		playsound(src, 'sound/effects/hydraulic_close.ogg', 25, FALSE)
		name = "unlocked hatch"
		desc = "A tightly closed hatch. It has been unlocked and can now be opened."
		state = LADDER_UNLOCKED
		update_icon()
		return TRUE

//==============================================

/obj/structure/ladder/fragile_almayer //goes away on hijack
	name = "rickety ladder"
	desc = "A slightly less stable-looking ladder, installed out of dry dock by some enterprising maintenance tech. Looks like it could collapse at any moment."

/obj/structure/ladder/fragile_almayer/Initialize()
	. = ..()
	if(is_mainship_level(z))
		RegisterSignal(SSdcs, COMSIG_GLOB_HIJACK_IMPACTED, PROC_REF(deconstruct))

/obj/structure/ladder/fragile_almayer/deconstruct()
	new /obj/structure/prop/broken_ladder(loc)
	return ..()

/obj/structure/prop/broken_ladder
	name = "rickety ladder"
	desc = "Well, it was only a matter of time."
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "ladder00"
	anchored = TRUE
	unslashable = TRUE
	unacidable = TRUE
	layer = LADDER_LAYER

/obj/structure/ladder/rope
	name = "rope"
	desc = "A sturdy rope."
	icon = 'icons/obj/structures/props/almayer_props.dmi'
	icon_state = "rope"

/obj/structure/ladder/rope/update_icon()
	return

/obj/structure/ladder/maintenance
	name = "maintenance ladder"
	desc = "The hatch itself is the door to the underground. Though it looks like it the hatch itself is light enough to not be an issue!"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "hatchclosed"
	color = "#666633"
	pixel_y = 7

/obj/structure/ladder/maintenance/update_icon()
	return

/obj/structure/ladder/multiz/LateInitialize()
	. = ..()

	up = locate(/obj/structure/ladder) in SSmapping.get_turf_above(get_turf(src))
	down = locate(/obj/structure/ladder) in SSmapping.get_turf_below(get_turf(src))

	update_icon()

// Ladder props

/obj/structure/prop/ladder_props
	name = "ladder"
	icon = 'icons/obj/structures/ladders.dmi'
	desc = "A sturdy metal ladder."
	icon_state = "alt_ladder2"
	density = FALSE
	anchored = TRUE
	unslashable = TRUE
	unacidable = TRUE
	layer = LADDER_LAYER

/obj/structure/prop/ladder_props/ladder_1
	icon_state = "alt_ladder"
/obj/structure/prop/ladder_props/ladder_2
	icon_state = "alt_ladder1"
/obj/structure/prop/ladder_props/ladder_3
	icon_state = "alt_ladder2"
/obj/structure/prop/ladder_props/ladder_4
	icon_state = "alt_ladder3"
/obj/structure/prop/ladder_props/ladder_up
	icon_state = "alt_ladderup"
/obj/structure/prop/ladder_props/ladder_down
	icon_state = "alt_ladderdown"
/obj/structure/prop/ladder_props/ladder_step
	icon_state = "step_ladder"
/obj/structure/prop/ladder_props/ladder_pool
	icon_state = "alt_ladderpool"

/obj/structure/ladder/yautja
	name = "ladder"
	desc = "A sturdy metal ladder, made from an unknown metal, adorned with glowing runes."
	icon = 'icons/obj/structures/machinery/yautja_machines.dmi'

/obj/structure/ladder/tall
	name = "exceptionally long ladder"
	desc = "A very long metal ladder. Looks like it would take a while to climb."
	climb_time = 30 SECONDS
	climb_sound = 'sound/machines/long_ladder.ogg'

#undef LADDER_LOCKED
#undef LADDER_UNLOCKED
#undef LADDER_OPEN
#undef WATCHING_NOTHING
#undef WATCHING_BELOW
#undef WATCHING_ABOVE
