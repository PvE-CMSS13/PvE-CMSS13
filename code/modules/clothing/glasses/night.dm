// nightvision goggles

/obj/item/clothing/glasses/night
	name = "\improper TV1 night vision goggles"
	gender = PLURAL
	desc = "A neat looking pair of civilian grade night vision goggles."
	icon_state = "night"
	item_state = "night"
	deactive_state = "night_off"
	toggle_on_sound = 'sound/handling/toggle_nv1.ogg'
	toggle_off_sound = 'sound/handling/toggle_nv2.ogg'
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 12
	vision_flags = SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	fullscreen_vision = null
	eye_protection = EYE_PROTECTION_NEGATIVE

/obj/item/clothing/glasses/night/helmet //for the integrated NVGs that are in helmetgarb code
	name = "\improper M2 night vision goggles"
	desc = "The actual goggle part of the M2 night vision system."
	icon_state = "stub" //our actual icon is a part of our helmet.
	item_state = null
	vision_flags = SEE_TURFS
	flags_item = NODROP|DELONDROP|ITEM_ABSTRACT
	flags_inventory = CANTSTRIP

/obj/item/clothing/glasses/night/M4RA
	name = "\improper M4RA Battle sight"
	gender = NEUTER
	desc = "A headset and night vision goggles system for the M4RA Battle Rifle. Allows highlighted imaging of surroundings, as well as the ability to view the suit sensor health status readouts of other marines. Click it to toggle."
	icon = 'icons/obj/items/clothing/glasses.dmi'
	icon_state = "m4ra_goggles"
	deactive_state = "m4ra_goggles_0"
	vision_flags = SEE_TURFS
	hud_type = MOB_HUD_MEDICAL_BASIC
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE

/obj/item/clothing/glasses/night/medhud
	name = "\improper Mark 4 Battle Medic sight"
	gender = NEUTER
	desc = "A headset and night vision goggles system for the M4RA Battle Rifle. Allows highlighted imaging of surroundings, as well as the ability to view the health statuses of others. Click it to toggle."
	icon = 'icons/obj/items/clothing/glasses.dmi'
	icon_state = "m4_goggles"
	deactive_state = "m4_goggles_0"
	vision_flags = SEE_TURFS
	hud_type = MOB_HUD_MEDICAL_ADVANCED
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/m42_night_goggles
	name = "\improper M42 scout sight"
	gender = NEUTER
	desc = "A headset and night vision goggles system for the M42 Scout Rifle. Allows highlighted imaging of surroundings. Click it to toggle."
	icon = 'icons/obj/items/clothing/glasses.dmi'
	icon_state = "m42_goggles"
	deactive_state = "m42_goggles_0"
	vision_flags = SEE_TURFS
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE

/obj/item/clothing/glasses/night/m42_night_goggles/spotter
	name = "\improper M42 spotter sight"
	desc = "A companion headset and night vision goggles system for USCM spotters. Allows highlighted imaging of surroundings. Click it to toggle."

/obj/item/clothing/glasses/night/m42_night_goggles/m42c
	name = "\improper M42C special operations sight"
	desc = "A specialized variation of the M42 scout sight system, intended for use with the high-power M42C anti-tank sniper rifle. Allows for highlighted imaging of surroundings, as well as detection of thermal signatures even from a great distance. Click it to toggle."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	vision_flags = SEE_TURFS|SEE_MOBS

/obj/item/clothing/glasses/night/m42_night_goggles/upp
	name = "\improper Type 9 commando goggles"
	gender = PLURAL
	desc = "A headset and night vision goggles system used by UPP forces. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "upp_goggles"
	deactive_state = "upp_goggles_0"
	req_skill = null
	req_skill_level = null

/obj/effect/target_mark
	icon = 'icons/obj/items/marine-items.dmi'
	icon_state = "tracker_blip"
	layer = BELOW_FULLSCREEN_LAYER
	plane = FULLSCREEN_PLANE

/obj/effect/target_mark/proc/update_marker_pos(mob/user, atom/target)
	var/c_view = user.client.view
	var/view_x_offset = 0
	var/view_y_offset = 0
	if(c_view > 7)
		if(user.client.pixel_x >= 0)
			view_x_offset = round(user.client.pixel_x/32)
		else
			view_x_offset = Ceiling(user.client.pixel_x/32)

		if(user.client.pixel_y >= 0)
			view_y_offset = round(user.client.pixel_y/32)
		else
			view_y_offset = Ceiling(user.client.pixel_y/32)

	screen_loc = "[Clamp(c_view + 1 - view_x_offset + (target.x - user.x), 1, 2*c_view+1)],[Clamp(c_view + 1 - view_y_offset + (target.y - user.y), 1, 2*c_view+1)]"

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper M56 head mounted sight"
	gender = NEUTER
	desc = "A headset and goggles system for the M56 Smartgun."
	icon = 'icons/obj/items/clothing/glasses.dmi'
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles"
	active = FALSE
	toggleable = FALSE
	vision_flags = FALSE
	clothing_traits_active = FALSE
	actions_types = list(/datum/action/item_action/m56_goggles/target_highlighting)
	fullscreen_vision = null
	req_skill = SKILL_SPEC_WEAPONS
	req_skill_level = SKILL_SPEC_SMARTGUN

	var/target_highlighting = FALSE
	var/obj/item/weapon/gun/smartgun/linked_smartgun = null

	var/list/blip_pool = list()
	var/iff_signal = FACTION_MARINE

/obj/item/clothing/glasses/night/m56_goggles/Destroy()
	linked_smartgun = null
	disable_target_highlighting()
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/proc/link_smartgun(mob/user)
	if(!QDELETED(user))
		linked_smartgun = locate() in user
		if(linked_smartgun)
			return TRUE
	return FALSE

/obj/item/clothing/glasses/night/m56_goggles/mob_can_equip(mob/user, slot)
	if(slot == WEAR_EYES)
		if(!link_smartgun(user))
			to_chat(user, SPAN_NOTICE("You must have your smartgun equipped to wear these."))
			return FALSE
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/equipped(mob/user, slot)
	if(slot != SLOT_EYES)
		disable_target_highlighting(user)
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/dropped(mob/living/carbon/human/user)
	linked_smartgun = null
	disable_target_highlighting(user)
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/proc/set_target_highlighting(mob/living/carbon/human/user, set_to_state = TRUE)
	if(set_to_state)
		if(user.glasses != src)
			to_chat(user, SPAN_WARNING("You can't activate target highlighting without wearing \the [src]!"))
			return
		if(!link_smartgun(user))
			to_chat(user, SPAN_WARNING("You can't use this without a smartgun!"))
			return
		target_highlighting = TRUE
		START_PROCESSING(SSfastobj, src)
	else
		linked_smartgun = null
		target_highlighting = FALSE
		for(var/target in blip_pool)
			remove_marker(user, target, blip_pool[target])
		STOP_PROCESSING(SSfastobj, src)

	var/datum/action/item_action/m56_goggles/target_highlighting/action = locate(/datum/action/item_action/m56_goggles/target_highlighting) in actions
	if(action)
		action.update_button_icon()

/obj/item/clothing/glasses/night/m56_goggles/proc/disable_target_highlighting(mob/living/carbon/human/user)
	if(!istype(user))
		user = loc
		if(!istype(user))
			user = null
	set_target_highlighting(user, FALSE)

/obj/item/clothing/glasses/night/m56_goggles/process(delta_time)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		set_target_highlighting(null, FALSE)
		return PROCESS_KILL
	if(!link_smartgun(user))
		set_target_highlighting(user, FALSE)
		return PROCESS_KILL
	if(!linked_smartgun.drain_battery(15 * delta_time))
		set_target_highlighting(user, FALSE)
		return PROCESS_KILL

	scan()

/obj/item/clothing/glasses/night/m56_goggles/proc/scan()
	set waitfor = 0
	var/mob/living/carbon/human/human_user = loc
	if(!human_user.client)
		return

	var/got_target = FALSE
	var/list/viewed = view(human_user.client.view, human_user)
	for(var/mob/living/target in viewed)
		if(target.stat)
			continue

		if(isrobot(target))
			continue

		if(blip_pool[target])
			continue

		if(target == human_user)
			continue //device user isn't detected

		if(target.get_target_lock(iff_signal))
			continue

		if(world.time > target.l_move_time + 10 SECONDS)
			continue //hasn't moved for quite a while

		got_target = TRUE
		show_marker(human_user, target)

	if(got_target)
		playsound_client(human_user.client, 'sound/items/tick.ogg')

	for(var/target in blip_pool)
		var/obj/effect/target_mark/mark = blip_pool[target]
		if(target in viewed)
			mark.update_marker_pos(human_user, target)
			continue

		remove_marker(human_user, target, mark)

/obj/item/clothing/glasses/night/m56_goggles/proc/show_marker(mob/user, atom/target)
	blip_pool[target] = new /obj/effect/target_mark

	var/obj/effect/target_mark/TM = blip_pool[target]
	user.client.add_to_screen(TM)

	RegisterSignal(target, list(COMSIG_MOB_DEATH, COMSIG_XENO_HANDLE_CRIT), PROC_REF(handle_removing))

/obj/item/clothing/glasses/night/m56_goggles/proc/handle_removing(atom/target)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/human_user = loc
	if(!istype(human_user))
		return

	remove_marker(human_user, target, blip_pool[target])

/obj/item/clothing/glasses/night/m56_goggles/proc/remove_marker(mob/user, atom/target, obj/effect/target_mark/mark)
	if(!user.client)
		return

	user.client.remove_from_screen(mark)
	blip_pool -= target
	qdel(mark)

/datum/action/item_action/m56_goggles/target_highlighting/New()
	. = ..()
	name = "Toggle Target Highlighting"
	action_icon_state = "far_sight"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/m56_goggles/target_highlighting/action_activate()
	if(target)
		var/obj/item/clothing/glasses/night/m56_goggles/G = target
		G.set_target_highlighting(owner, !G.target_highlighting)
		to_chat(owner, SPAN_NOTICE("You [G.target_highlighting ? "enable" : "disable"] \the [G]'s target highlighting system."))

/datum/action/item_action/m56_goggles/target_highlighting/update_button_icon()
	if(!target)
		return
	var/obj/item/clothing/glasses/night/m56_goggles/G = target
	if(G.target_highlighting)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"

/obj/item/clothing/glasses/night/m56_goggles/whiteout
	name = "\improper M56T head mounted sight"
	desc = "A headset and goggles system for the M56T 'Terminator' Smartgun. Has a low-light vision processor as well as a system allowing detection of thermal signatures though solid surfaces."
	vision_flags = SEE_TURFS|SEE_MOBS
	clothing_traits_active = TRUE
	active = TRUE

/obj/item/clothing/glasses/night/yautja
	name = "bio-mask nightvision"
	gender = NEUTER
	desc = "A vision overlay generated by the Bio-Mask. Used for low-light conditions."
	icon = 'icons/obj/items/hunter/pred_gear.dmi'
	icon_state = "visor_nvg"
	item_state = "securityhud"
	flags_inventory = COVEREYES
	flags_item = NODROP|DELONDROP
	fullscreen_vision = null
	actions_types = null

/obj/item/clothing/glasses/night/cultist
	name = "\improper unusual thermal imaging goggles"
	desc = "Seems to be thermal imaging goggles, except they have an unusual design. Looking at it makes you nauseous."
	icon_state = "thermal"
	item_state = "thermal"
	w_class = SIZE_SMALL
	vision_flags = SEE_MOBS
	fullscreen_vision = null

/obj/item/clothing/glasses/night/cultist/mob_can_equip(mob/user, slot)
	if(slot == WEAR_EYES)
		if(iscarbon(user))
			var/mob/living/carbon/H = user
			if(!H.hivenumber)
				to_chat(user, SPAN_WARNING("You do not want to put these on, they're making you nauseous."))
				return FALSE
	return ..()

/obj/item/clothing/glasses/night/experimental_mesons
	name = "\improper Experimental Meson Goggles"
	desc = "An improved but experimental version of the standard issue meson goggles, due to increased complexity these can only be worn by synthetics. Allows for full night vision and viewing of the surroundings. Click it to toggle."
	icon = 'icons/obj/items/clothing/glasses.dmi'
	icon_state = "refurb_meson"
	deactive_state = "degoggles"
	vision_flags = SEE_TURFS
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/experimental_mesons/mob_can_equip(mob/user, slot)
	if(slot == WEAR_EYES)
		if(!issynth(user))
			to_chat(user, "The experimental meson goggles start probing at your eyes, searching for an attachment point, and you immediately take them off.")
			return FALSE
	return ..()
