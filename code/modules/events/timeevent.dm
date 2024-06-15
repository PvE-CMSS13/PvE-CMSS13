GLOBAL_LIST_EMPTY_TYPED(timeloop_saves, /datum/timeloop_save)
GLOBAL_VAR_INIT(timeloop_power, 1)
GLOBAL_VAR_INIT(nuketimer_started, 0)
GLOBAL_VAR(timeloop_nuke)
GLOBAL_VAR(tdd_cell)
GLOBAL_VAR_INIT(map_iteration, 1)
GLOBAL_VAR(midway_dockingport)

// <p>Your squad has been tasked with investigating a distress signal from an abandoned USCM outpost designated "Whiskey". The cause of the distress signal is unknown, considering the base was decommissioned years ago. Additionally, strange readings inconsistent with anything seen before have been reported emitting from the outpost. RADAR suggests the existence of an unknown shuttle west of the main outpost's defensive pads. <br><br>Investigate the outpost, find out what's happened, and extract any survivors if needed. To that end, ARES will be piloting the Midway for this operation.</p>

/obj/docking_port/mobile/marine_dropship/midway/Initialize(mapload)
	. = ..()
	GLOB.midway_dockingport = src

/obj/docking_port/mobile/marine_dropship/midway/Destroy(force)
	GLOB.midway_dockingport = null
	return ..()

/datum/timeloop_save
	var/mob/living/carbon/human/relevant_mob

	var/x
	var/y
	var/z

/datum/timeloop_save/Destroy(force, ...)
	relevant_mob = null
	return ..()

/proc/init_timeloop()
	for(var/mob/living/carbon/human/marine in GLOB.alive_human_list)
		var/area/marine_area = get_area(marine)
		if(istype(marine_area, /area/shuttle/midway))
			marine.timeloop_start()

	SStimeloop.start_timeloop()
	crash_midway()

/mob/living/carbon/human/proc/timeloop_start()
	var/datum/timeloop_save/save = new()
	var/turf/marine_turf = get_turf(src)
	save.relevant_mob = src
	// There'll only be one shuttle, so the coordinates will always be the same as long as the shuttle's in the air
	save.x = marine_turf.x
	save.y = marine_turf.y
	save.z = marine_turf.z
	GLOB.timeloop_saves += save
	to_chat(src, SPAN_NOTICE("<i>You feel a shiver go down your spine.</i>"))

/mob/living/carbon/human/proc/timeloop_revert_overlay()
	set waitfor = FALSE

	var/atom/movable/screen/fullscreen/screen = overlay_fullscreen("timeloop", /atom/movable/screen/fullscreen/timeloop)
	sleep(1.1 SECONDS)
	screen.icon_state = "timeloop_perm"

/proc/start_nuketimer()
	//addtimer(CALLBACK(bomb, TYPE_PROC_REF(/obj/structure/machinery/nuclearbomb, explode)), SStimeloop.nukepostloop)
	GLOB.nuketimer_started = TRUE
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(message_admins), "TIME IS UP. DETONATE THE BOMB."), SStimeloop.nukepostloop)

/proc/revert_timeloop()
	if(!GLOB.timeloop_power)
		if(!GLOB.nuketimer_started)
			start_nuketimer()
		return

	GLOB.map_iteration++
	var/obj/docking_port/mobile/marine_dropship/midway/midway_port = GLOB.midway_dockingport
	var/area/shuttle/midway/midway_area = get_area(midway_port)
	midway_area.base_lighting_alpha = 255
	midway_area.update_base_lighting()

	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		revert_timeloop_singleton(save)

	crash_midway()

/proc/revert_timeloop_singleton(datum/timeloop_save/save)
	set waitfor = FALSE

	save.relevant_mob.Stun(100)
	save.relevant_mob.timeloop_revert_overlay()
	sleep(1.5 SECONDS)
	playsound_client(save.relevant_mob.client, 'sound/misc/wand_teleport.ogg')
	save.relevant_mob.forceMove(locate(save.x, save.y, save.z))
	to_chat(save.relevant_mob, SPAN_NOTICE("You suddenly feel yourself pulled to somewhere unknown!"))
	sleep(1.5 SECONDS)
	save.relevant_mob.SetStun(0)
	save.relevant_mob.clear_fullscreen("timeloop", TRUE)

/proc/crash_midway()
	set waitfor = FALSE

	sleep(10 SECONDS)
	var/obj/docking_port/mobile/marine_dropship/midway/midway_port = GLOB.midway_dockingport
	var/area/shuttle/midway/midway_area = get_area(midway_port)
	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		shake_camera(save.relevant_mob, 2, 3)
		playsound_client(save.relevant_mob.client, 'sound/effects/powerloss.ogg', vol = 75)
	sleep(5 SECONDS)
	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		to_chat(save.relevant_mob, SPAN_WARNING("You feel the dropship's speed decrease as the engines go quieter."))
	sleep(3 SECONDS)
	midway_area.base_lighting_alpha = 0
	midway_area.update_base_lighting()
	announcement_helper("ALERT:\n Unknown energy pulse has hit Dropship Midway, engine power lost. Crash landing likely.", MAIN_AI_SYSTEM, GLOB.human_mob_list, sound('sound/misc/interference.ogg'))
	sleep(2 SECONDS)
	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		to_chat(save.relevant_mob, SPAN_WARNING("You feel the dropship's nose begin to pitch downwards as it enters freefall."))
	sleep(6 SECONDS)
	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		playsound_client(save.relevant_mob.client, 'sound/effects/dropship_incoming.ogg', vol = 75)
	sleep(7 SECONDS)
	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		playsound_client(save.relevant_mob.client, 'sound/effects/metal_crash.ogg', vol = 75)
	sleep(0.1 SECONDS)
	var/turf/T = get_turf(midway_port)

	var/turf/T3 = locate(115, 54, 1 + GLOB.map_iteration) //hardcoded because fuck you

	for(var/datum/timeloop_save/save as anything in GLOB.timeloop_saves)
		var/turf/T2 = get_turf(save.relevant_mob)
		save.relevant_mob.forceMove(locate(T3.x + (T2.x - T.x), T3.y + (T2.y - T.y), 1 + GLOB.map_iteration))
		shake_camera(save.relevant_mob, 8, 8)
		save.relevant_mob.Stun(3)

/obj/structure/tdd
	name = "strange device"
	icon = 'icons/obj/structures/machinery/timeloop.dmi'
	bound_height = 64
	bound_width = 64
	icon_state = "tdd_on"
	desc = "A strange device that looks unlike anything you've seen before."
	light_color = "#0ab42f"
	light_power = 4
	light_range = 3
	indestructible = TRUE
	unacidable = TRUE

/obj/structure/tdd/get_examine_text(mob/user)
	. = ..()
	if(GLOB.timeloop_power && !GLOB.nuketimer_started)
		. += SPAN_NOTICE("A timer on the device reads \"[timeleft(SStimeloop.mainloop_timer_id) / 10] SECONDS UNTIL CYCLE\".")

	if(GLOB.timeloop_power)
		. += SPAN_NOTICE("There seems to be a strange, alien-looking powercell powering it... maybe it could be removed with a <b>wrench</b>?")

/obj/structure/tdd/attackby(obj/item/W, mob/user)
	. = ..()
	if(HAS_TRAIT(W, TRAIT_TOOL_WRENCH))
		if(!GLOB.timeloop_power)
			to_chat(user, SPAN_WARNING("There's nothing to remove!"))
			return

		to_chat(user, SPAN_WARNING("You start to unwrench [src]'s power source. You hope you know what you're doing..."))
		playsound(src, 'sound/items/Ratchet.ogg', 25, 1)
		if(!do_after(user, 10 SECONDS, show_busy_icon = BUSY_ICON_GENERIC))
			to_chat(user, SPAN_WARNING("You stop trying to remove [src]'s power source."))
			return

		remove_power_source(user)

/obj/structure/tdd/proc/remove_power_source(mob/user)
	var/obj/O = new /obj/item/tdd_powersource(get_turf(src))
	user.put_in_hands(O, TRUE)
	icon_state = "tdd_off"
	light_power = 0
	light_range = 0
	update_light()
	visible_message(SPAN_WARNING("As the power source is extracted from [src], its glowing and humming fades away. You feel a sense of great dread."))
	GLOB.timeloop_power = FALSE

/obj/structure/machinery/nuclearbomb/emplaced
	desc = "An armed nuclear self-destruct warhead, securely bolted, mounted, and welded onto the floor. Looks entirely undisarmable. Oh fuck."
	icon = 'icons/obj/structures/machinery/nuke.dmi'
	icon_state = "nuke"
	safety = FALSE
	light_color = "#c51818"
	light_power = 4
	light_range = 3
	indestructible = TRUE
	anchored = TRUE

/obj/structure/machinery/nuclearbomb/emplaced/get_examine_text(mob/user)
	. = ..()
	. += "A timer on [src] reads \"DETONATION IN [(timeleft(SStimeloop.mainloop_timer_id) / 10) + 120] SECONDS\"." //roughly

/obj/structure/machinery/nuclearbomb/emplaced/update_icon()
	return

/obj/structure/machinery/nuclearbomb/emplaced/attack_alien(mob/living/carbon/xenomorph/M)
	return

/obj/structure/machinery/nuclearbomb/emplaced/attackby(obj/item/O, mob/user)
	return

/obj/structure/machinery/nuclearbomb/emplaced/attack_hand(mob/user)
	return

/obj/structure/machinery/nuclearbomb/emplaced/process()
	return

/obj/structure/machinery/nuclearbomb/emplaced/tgui_interact(mob/user, datum/tgui/ui)
	return

/obj/item/tdd_powersource
	name = "strange cell"
	desc = "An alien-looking powercell, formerly used to power a device capable of reversing time."
	icon = 'icons/obj/items/tdd_item.dmi'
	icon_state = "cell"
	light_power = 1
	light_range = 1
	light_color = "#c217b9"

/obj/structure/machinery/computer/shuttle/ert/tdd
	name = "electronic dropship navigation computer"
	desc = "A navigation computer for flying the USCSS Wilhelm, a small dropship powered with electrical engines instead of liquid-fuel thrusters."
	var/charged = FALSE

/obj/structure/machinery/computer/shuttle/ert/tdd/attack_hand(mob/user)
	if(!charged)
		to_chat(user, SPAN_WARNING("The dropship isn't powered, you can't hope to fly this thing yet!"))
		return

	to_chat(user, SPAN_NOTICE("You start preparations to make the USCSS Wilhelm take off..."))
	playsound(src, "keyboard", 15, 1)
	if(!do_after(user, 5 SECONDS, show_busy_icon = BUSY_ICON_GENERIC))
		return

	to_chat(user, SPAN_BOLDNOTICE("You start the USCSS Wilhelm's engines as the ship hums to life."))

	var/obj/docking_port/mobile/emergency_response/ert2/wilhelm_port = locate() in locate(x - 3, y - 11, z):contents //gross i know

	wilhelm_port.destination = null
	wilhelm_port.set_mode(SHUTTLE_IGNITING)
	wilhelm_port.on_ignition()
	wilhelm_port.setTimer(wilhelm_port.ignitionTime)

/obj/structure/machinery/computer/shuttle/ert/tdd/get_examine_text(mob/user)
	. = ..()
	if(!charged)
		. += SPAN_BOLDNOTICE("You see a socket for a power cell, though not of the shape you'd usually see.")

/obj/structure/machinery/computer/shuttle/ert/tdd/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/tdd_powersource))
		to_chat(user, SPAN_NOTICE("You insert [I] into [src]'s power socket, and the dropship controls hum to life."))
		charged = TRUE
		qdel(I)
		set_light(7, 4, "#ffffff")
		return

	else if(istype(I, /obj/item/cell))
		to_chat(user, SPAN_NOTICE("You can already tell this cell won't fit in the socket. You can't remember seeing a regular cell of this kind of shape, nevermind one with enough charge to power a dropship."))
		return

/obj/docking_port/stationary/wilhelm
	name = "USCSS Wilhelm Landing Pad"
	dir = NORTH
	id = "tdd_wilhelm_pad"
	roundstart_template = /datum/map_template/shuttle/pmc_ert/wilhelm

/datum/map_template/shuttle/pmc_ert/wilhelm
	name = "USCSS Wilhelm"
	shuttle_id = "dropship_wilhelm"

/obj/flamer_fire/inf
	do_process = FALSE

/obj/docking_port/mobile/emergency_response/wilhelm
	name = "USCSS Wilhelm"
	id = "tdd_wilhelm_pad"
	preferred_direction = SOUTH
	port_direction = NORTH
