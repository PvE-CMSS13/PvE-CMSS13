// nightvision goggles

/obj/item/clothing/glasses/night
	name = "\improper TV1 night vision goggles"
	gender = PLURAL
	desc = "A neat looking pair of civilian grade night vision goggles."
	icon = 'icons/obj/items/clothing/glasses.dmi' //Why wasn't this on the parent item before?
	icon_state = "night"
	item_state = "night"
	deactive_state = "night_off"
	toggle_on_sound = 'sound/handling/toggle_nv1.ogg'
	toggle_off_sound = 'sound/handling/toggle_nv2.ogg'
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 12
	vision_flags = 0
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	fullscreen_vision = null
	eye_protection = EYE_PROTECTION_NEGATIVE
	var/headcam = FALSE
	var/obj/structure/machinery/camera/camera

/obj/item/clothing/glasses/night/Initialize()
	. = ..()
	camera = new /obj/structure/machinery/camera/overwatch(src)

/obj/item/clothing/glasses/night/equipped(mob/living/carbon/human/mob, slot)
	if(headcam && camera)
		camera.c_tag = mob.name
	..()

/obj/item/clothing/glasses/night/Destroy()
	QDEL_NULL(camera)
	return ..()

/obj/item/clothing/glasses/night/helmet //for the integrated NVGs that are in helmetgarb code
	name = "\improper M2 night vision goggles"
	desc = "The actual goggle part of the M2 night vision system."
	icon_state = "stub" //our actual icon is a part of our helmet.
	item_state = null
	flags_item = NODROP|DELONDROP|ITEM_ABSTRACT
	flags_inventory = CANTSTRIP

/obj/item/clothing/glasses/night/M49A
	name = "\improper M49A Battle sight"
	gender = NEUTER
	desc = "A headset and night vision system for the M49A Battle Rifle. Allows highlighted imaging of surroundings, the ability to view the biofunction monitor readouts of other marines, and linking to the Command & Control network. Click it to toggle."
	icon_state = "m49a_goggles"
	deactive_state = "m49a_goggles_0"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_MEDICAL_BASIC)
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)
	headcam = TRUE

/obj/item/clothing/glasses/night/medhud
	name = "\improper Mark 4 Battle Medic sight"
	gender = NEUTER
	desc = "A headset, night vision optic and biomonitor readout system. Allows highlighted imaging of surroundings, the ability to view the biofunction monitor readouts of other marines, and linking to the Command & Control network. Click it to toggle."
	icon_state = "m4_goggles"
	deactive_state = "m4_goggles_0"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_MEDICAL_ADVANCED)
	toggleable = TRUE
	fullscreen_vision = null
	req_skill = SKILL_MEDICAL
	req_skill_level = SKILL_MEDICAL_MEDIC
	actions_types = list(/datum/action/item_action/toggle)
	headcam = TRUE

/obj/item/clothing/glasses/night/medhud/no_nvg
	name = "\improper Mark 2 Battle Medic sight"
	desc = "A headset and biomonitor readout system. Allows the ability to view the biofunction monitor readouts of other marines and linking to the Command & Control network. Click it to toggle."
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_MEDICAL_ADVANCED) // Need to redefine or it won't work
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = 255

/obj/item/clothing/glasses/night/ghillie_goggles
	name = "\improper BiMex M3 day/night goggles"
	desc = "A set of enhanced-vision goggles often issued to the marksman of USCM scout-sniper teams. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "ghillie_goggles"
	deactive_state = "ghillie_goggles_0"
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/m42_hms
	name = "\improper M42 head mounted sight"
	gender = NEUTER
	desc = "A standalone version of the HMS commonly seen attached to the M56 weapon system. Allows highlighted imaging of surroundings and connects the wearer to the Command & Control network whilst also providing a HUD display. Click it to toggle."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY)
	toggleable = TRUE
	fullscreen_vision = null
	actions_types = list(/datum/action/item_action/toggle)
	headcam = TRUE

/obj/item/clothing/glasses/night/m42_hms/rmc
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
	hud_type = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)

/obj/item/clothing/glasses/night/m42_hms/no_nvg
	name = "\improper M42 head-mounted sight"
	desc = "A standalone version of the HMS commonly seen attached to the M56 weapon system. Allows connection to the Command & Control network whilst also providing a HUD display. Click it to toggle."
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = 255

/obj/item/clothing/glasses/night/m42_hms/m42c
	name = "\improper M42C special operations sight"
	desc = "A specialized variation of the M42 scout sight system, intended for use with the high-power M42C anti-tank sniper rifle. Allows for highlighted imaging of surroundings, as well as detection of thermal signatures even from a great distance. Click it to toggle."
	vision_flags = SEE_TURFS|SEE_MOBS
	hud_type = list(MOB_HUD_FACTION_PMC, MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)

/obj/item/clothing/glasses/night/m42_hms/upp
	name = "\improper Type 9 commando goggles"
	gender = PLURAL
	desc = "A headset and night vision goggles system used by UPP forces. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "upp_goggles"
	deactive_state = "upp_goggles_0"
	req_skill = null
	req_skill_level = null
	hud_type = list(MOB_HUD_FACTION_UPP)

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper M56 head mounted sight"
	gender = NEUTER
	desc = "A headset and optic system for the M56 Smartgun weapon system. Has a low-res short-range imager, allowing for view of terrain."
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle, /datum/action/item_action/m56_goggles/far_sight)
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY)
	flags_inventory = SMARTGUN_OPTIC
	fullscreen_vision = null
	eye_protection = EYE_PROTECTION_FLAVOR
	req_skill = SKILL_SPEC_WEAPONS
	req_skill_level = SKILL_SPEC_SMARTGUN
	headcam = TRUE
	var/far_sight = FALSE
	var/obj/item/weapon/gun/smartgun/linked_smartgun = null

/obj/item/clothing/glasses/night/m56_goggles/Destroy()
	QDEL_NULL(camera)
	linked_smartgun = null
	disable_far_sight()
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
		disable_far_sight(user)
	if(camera)
		camera.c_tag = user.name
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/dropped(mob/living/carbon/human/user)
	linked_smartgun = null
	disable_far_sight(user)
	return ..()

/obj/item/clothing/glasses/night/m56_goggles/proc/set_far_sight(mob/living/carbon/human/user, set_to_state = TRUE)
	if(set_to_state)
		if(user.glasses != src)
			to_chat(user, SPAN_WARNING("You can't activate far sight without wearing \the [src]!"))
			return
		if(!link_smartgun(user))
			to_chat(user, SPAN_WARNING("You can't use this without a smartgun!"))
			return
		far_sight = TRUE
		if(user)
			if(user.client)
				user.client.change_view(8, src)
		START_PROCESSING(SSobj, src)
	else
		linked_smartgun = null
		far_sight = FALSE
		if(user)
			if(user.client)
				user.client.change_view(GLOB.world_view_size, src)
		STOP_PROCESSING(SSobj, src)

	var/datum/action/item_action/m56_goggles/far_sight/FT = locate(/datum/action/item_action/m56_goggles/far_sight) in actions
	if(FT)
		FT.update_button_icon()

/obj/item/clothing/glasses/night/m56_goggles/proc/disable_far_sight(mob/living/carbon/human/user)
	if(!istype(user))
		user = loc
		if(!istype(user))
			user = null
	set_far_sight(user, FALSE)

/obj/item/clothing/glasses/night/m56_goggles/process(delta_time)
	var/mob/living/carbon/human/user = loc
	if(!istype(user))
		set_far_sight(null, FALSE)
		return PROCESS_KILL
	if(!link_smartgun(user))
		set_far_sight(user, FALSE)
		return PROCESS_KILL
	if(!linked_smartgun.drain_battery(25 * delta_time))
		set_far_sight(user, FALSE)

/datum/action/item_action/m56_goggles/far_sight/New()
	. = ..()
	name = "Toggle Far Sight"
	action_icon_state = "far_sight"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/m56_goggles/far_sight/action_activate()
	. = ..()
	if(target)
		var/obj/item/clothing/glasses/night/m56_goggles/G = target
		G.set_far_sight(owner, !G.far_sight)
		to_chat(owner, SPAN_NOTICE("You [G.far_sight ? "enable" : "disable"] \the [G]'s far sight system."))

/datum/action/item_action/m56_goggles/far_sight/update_button_icon()
	if(!target)
		return
	var/obj/item/clothing/glasses/night/m56_goggles/G = target
	if(G.far_sight)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"

/obj/item/clothing/glasses/night/m56_goggles/no_nightvision
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = 255

/obj/item/clothing/glasses/night/m56_goggles/rmc
	name = "\improper L58A3 head mounted gunsight interface"
	desc = "A headset and optic system for the L58A3 Smartgun weapon system. Has a low-res short-range imager, allowing for view of terrain."
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
	hud_type = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)

/obj/item/clothing/glasses/night/m56_goggles/pmc
	name = "\improper M56A3 head mounted sight"
	desc = "A tweaked headset and optic system for the M56A3 Smartgun weapon system. Has a low-res short-range imager, allowing for view of terrain."
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = LIGHTING_PLANE_ALPHA_VISIBLE
	hud_type = list(MOB_HUD_FACTION_PMC, MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)

/obj/item/clothing/glasses/night/m56_goggles/whiteout
	name = "\improper M56T head mounted sight"
	desc = "A headset and goggles system for the M56T 'Terminator' Smartgun. Has a low-light vision processor as well as a system allowing detection of thermal signatures though solid surfaces."
	vision_flags = SEE_TURFS|SEE_MOBS
	hud_type = list(MOB_HUD_FACTION_PMC, MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)

/obj/item/clothing/glasses/night/m56_goggles/upp
	name = "\improper RADIO head rig"
	desc = "Developed for use with the RFVS-37, the Integrated Auto-Rifleman Optronic Device enables the riflemen of the UPP SOF to visually search for targets in low-visibility conditions, while also enabling safe use of the weapon itself."
	icon_state = "radio_head_rig"
	deactive_state = "radio_head_rig_0"
	hud_type = list(MOB_HUD_FACTION_UPP)

/obj/item/clothing/glasses/night/m56_goggles/upp/no_nightvision
	actions_types = list(/datum/action/item_action/toggle)
	darkness_view = 0
	vision_flags = 0
	lighting_alpha = 255

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
