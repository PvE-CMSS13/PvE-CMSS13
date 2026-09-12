#define FULL_CAMOUFLAGE_ALPHA 5
#define VISIBLE_CAMOUFLAGE_ALPHA 60

#define FULL_PVE_CAMOUFLAGE_ALPHA 20
#define VISIBLE_PVE_CAMOUFLAGE_ALPHA 75

/obj/item/clothing/suit/storage/marine/ghillie
	name = "\improper M45 pattern ghillie armor"
	desc = "A lightweight ghillie camouflage suit, used by USCM scout-snipers on recon missions. Very lightweight, but doesn't protect much."
	icon_state = "ghillie_armor"
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_VERY_LIGHT
	flags_marine_armor = ARMOR_LAMP_OVERLAY
	specialty = "M45 pattern ghillie"
	valid_accessory_slots = list(ACCESSORY_SLOT_ARMBAND, ACCESSORY_SLOT_DECOR, ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_PONCHO)
	restricted_accessory_slots = list(ACCESSORY_SLOT_ARMBAND)
	unacidable = TRUE

	var/camo_active = FALSE
	var/hide_in_progress = FALSE
	var/full_camo_alpha = FULL_PVE_CAMOUFLAGE_ALPHA
	var/incremental_shooting_camo_penalty = 20
	var/current_camo = FULL_PVE_CAMOUFLAGE_ALPHA
	var/visible_camo_alpha = VISIBLE_PVE_CAMOUFLAGE_ALPHA
	var/camouflage_break = 5 SECONDS
	var/camouflage_enter_delay = 2 SECONDS
	var/can_camo = TRUE
	var/camouflage_break_message = 2 SECONDS

	actions_types = list(/datum/action/item_action/toggle, /datum/action/item_action/specialist/prepare_position)

/obj/item/clothing/suit/storage/marine/ghillie/dropped(mob/user)
	if(ishuman(user) && !issynth(user))
		deactivate_camouflage(user, FALSE)

	. = ..()

/obj/item/clothing/suit/storage/marine/ghillie/select_gamemode_skin()
	. = ..()
	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("urban")
			name = "\improper M3-LS pattern sniper armor"
			desc = "A lightweight version of M3 pattern armor, with an integrated thermal signature dampering device, used by USCM snipers on urban recon missions. Very lightweight, but doesn't protect much."

/obj/item/clothing/suit/storage/marine/ghillie/verb/camouflage()
	set name = "Camoflage Self"
	set desc = "Use the ghillie suit and the nearby environment to become near invisible."
	set category = "Object"
	set src in usr
	if(!usr || usr.is_mob_incapacitated(TRUE))
		return

	if(!ishuman(usr) || hide_in_progress || !can_camo)
		return
	var/mob/living/carbon/human/H = usr
	if(H.wear_suit != src)
		to_chat(H, SPAN_WARNING("You must be wearing the ghillie suit to activate it!"))
		return

	if(camo_active)
		deactivate_camouflage(H)
		return

	H.visible_message(SPAN_DANGER("[H] begins adjusting \his ghillie suit, blending in with the environment!"), SPAN_NOTICE("You begin adjusting your ghillie suit."), max_distance = 4)
	hide_in_progress = TRUE
	H.unset_interaction() // If we're sticking to a machine gun or what not.
	if(!do_after(H, camouflage_enter_delay, INTERRUPT_NO_NEEDHAND|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		hide_in_progress = FALSE
		return
	hide_in_progress = FALSE
	RegisterSignal(H,  list(
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_FIRED_GUN_ATTACHMENT)
		, PROC_REF(fade_in))
	RegisterSignal(H, list(
		COMSIG_MOB_DEATH,
		COMSIG_HUMAN_EXTINGUISH
	), PROC_REF(deactivate_camouflage))
	camo_active = TRUE
	ADD_TRAIT(H, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_JACKET))
	H.alpha = full_camo_alpha
	H.FF_hit_evade = 1000


	var/datum/mob_hud/security/advanced/SA = GLOB.huds[MOB_HUD_SECURITY_ADVANCED]
	SA.remove_from_hud(H)
	var/datum/mob_hud/xeno_infection/XI = GLOB.huds[MOB_HUD_XENO_INFECTION]
	XI.remove_from_hud(H)

	playsound(H.loc, 'sound/effects/cloak_scout_on.ogg', 15, TRUE)
	anim(H.loc, H, 'icons/mob/mob.dmi', null, "cloak", null, H.dir)
	slowdown = SLOWDOWN_ARMOR_CLOAKED_GHILLIE //No super speed whilst invis, you're moving slow to ensure you stay hidden

/obj/item/clothing/suit/storage/marine/ghillie/proc/deactivate_camouflage(mob/user)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return FALSE

	if(!camo_active)
		return

	UnregisterSignal(H, list(
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_FIRED_GUN_ATTACHMENT,
		COMSIG_MOB_DEATH,
		COMSIG_HUMAN_EXTINGUISH
	))

	camo_active = FALSE
	playsound(H.loc, 'sound/effects/cloak_scout_off.ogg', 15, TRUE)
	anim(H.loc, H,'icons/mob/mob.dmi', null, "uncloak", null, H.dir)
	REMOVE_TRAIT(H, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_JACKET))
	H.alpha = 255
	H.FF_hit_evade = initial(H.FF_hit_evade)
	slowdown = initial(slowdown) //Back to schmoving quick

	var/datum/mob_hud/security/advanced/SA = GLOB.huds[MOB_HUD_SECURITY_ADVANCED]
	SA.add_to_hud(H)
	var/datum/mob_hud/xeno_infection/XI = GLOB.huds[MOB_HUD_XENO_INFECTION]
	XI.add_to_hud(H)

	H.visible_message(SPAN_DANGER("[H]'s camouflage fails!"), SPAN_WARNING("Your camouflage fails!"), max_distance = 4)

/obj/item/clothing/suit/storage/marine/ghillie/proc/fade_in(mob/user)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/H = user
	if(camo_active)
		if(current_camo < full_camo_alpha)
			current_camo = full_camo_alpha
		current_camo = clamp(current_camo + incremental_shooting_camo_penalty, full_camo_alpha, 255)
		H.alpha = current_camo
		if(current_camo > visible_camo_alpha)
			REMOVE_TRAIT(H, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_JACKET))
			to_chat(H, SPAN_BOLDNOTICE("Your ghillie suit can't keep you perfectly hidden anymore!"))
		addtimer(CALLBACK(src, PROC_REF(fade_out_finish), H), camouflage_break, TIMER_OVERRIDE|TIMER_UNIQUE)
		animate(H, alpha = full_camo_alpha + 5, time = camouflage_break, easing = LINEAR_EASING, flags = ANIMATION_END_NOW)

/obj/item/clothing/suit/storage/marine/ghillie/proc/fade_out_finish(mob/living/carbon/human/H)
	if(camo_active && H.wear_suit == src)
		ADD_TRAIT(H, TRAIT_CLOAKED, TRAIT_SOURCE_EQUIPMENT(WEAR_JACKET))
		to_chat(H, SPAN_BOLDNOTICE("The smoke clears and your once again hidden completely by your ghillie suit!"))
		animate(H, alpha = full_camo_alpha)
		current_camo = full_camo_alpha

/datum/action/item_action/specialist/prepare_position
	ability_primacy = SPEC_PRIMARY_ACTION_1

/datum/action/item_action/specialist/prepare_position/New(mob/living/user, obj/item/holder)
	..()
	name = "Camoflage Self"
	button.name = name
	button.overlays.Cut()
	var/image/IMG = image('icons/mob/hud/actions.dmi', button, "prepare_position")
	button.overlays += IMG

/datum/action/item_action/specialist/prepare_position/can_use_action()
	var/mob/living/carbon/human/H = owner
	if(istype(H) && !H.is_mob_incapacitated() && H.body_position == STANDING_UP && holder_item == H.wear_suit)
		return TRUE

/datum/action/item_action/specialist/prepare_position/action_activate()
	. = ..()
	var/obj/item/clothing/suit/storage/marine/ghillie/GS = holder_item
	GS.camouflage()

/obj/item/clothing/suit/storage/marine/ghillie/invis
	full_camo_alpha = FULL_CAMOUFLAGE_ALPHA
	current_camo = FULL_CAMOUFLAGE_ALPHA
	visible_camo_alpha = VISIBLE_CAMOUFLAGE_ALPHA

/obj/item/clothing/suit/storage/marine/ghillie/forecon
	name = "UDEP Thermal Poncho"
	desc = "UDEP or the Ultra Diffusive Environmental Poncho is a camouflaged rain-cover worn to protect against the elements and chemical spills. It's commonly treated with an infrared absorbing coating, making a marine almost invisible in the rain. Favoured by USCM specialists for it's comfort and practicality."
	icon_state = "mercenary_miner_armor"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/ghillie/forecon/invis
	full_camo_alpha = FULL_CAMOUFLAGE_ALPHA
	current_camo = FULL_CAMOUFLAGE_ALPHA
	visible_camo_alpha = VISIBLE_CAMOUFLAGE_ALPHA

#undef FULL_CAMOUFLAGE_ALPHA
#undef VISIBLE_CAMOUFLAGE_ALPHA
#undef FULL_PVE_CAMOUFLAGE_ALPHA
#undef VISIBLE_PVE_CAMOUFLAGE_ALPHA
