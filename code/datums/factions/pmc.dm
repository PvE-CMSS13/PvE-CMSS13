/datum/faction/pmc
	name = "Private Military Company"
	faction_tag = FACTION_PMC

/datum/faction/pmc/modify_hud_holder(image/holder, mob/living/carbon/human/H)
	var/hud_icon_state
	var/obj/item/card/id/ID = H.get_idcard()
	var/_role
	if(H.mind)
		_role = H.job
	else if(ID)
		_role = ID.rank
	switch(_role)
		if(JOB_PMC_DIRECTOR, JOB_SO)
			hud_icon_state = "sd"
		if(JOB_PMC_LEADER, JOB_PMC_LEAD_INVEST)
			hud_icon_state = "ld"
		if(JOB_PMC_DOCTOR)
			hud_icon_state = "td"
		if(JOB_PMC_ENGINEER)
			hud_icon_state = "ct"
		if(JOB_PMC_MEDIC, JOB_PMC_INVESTIGATOR)
			hud_icon_state = "md"
		if(JOB_PMC_SYNTH)
			hud_icon_state = "syn"
	if(hud_icon_state)
		holder.overlays += image('icons/mob/hud/marine_hud.dmi', H, "pmc_[hud_icon_state]")


	var/datum/squad/squad = H.assigned_squad
	if(istype(squad, /datum/squad/marine/pmc))
		var/squad_clr = H.assigned_squad.equipment_color
		switch(GET_DEFAULT_ROLE(_role))
			if(JOB_SQUAD_MEDIC) hud_icon_state = "med"
			if(JOB_SQUAD_SMARTGUN) hud_icon_state = "gun"
			if(JOB_SQUAD_TEAM_LEADER) hud_icon_state = "tl"
			if(JOB_SQUAD_LEADER) hud_icon_state = "leader_a"
		if(squad.fireteam_leaders["SQ1"] == H || squad.fireteam_leaders["SQ2"] == H)
			H.langchat_styles = "langchat_smaller_bolded"
		else
			H.langchat_styles = initial(H.langchat_styles)
		H.langchat_color = H.assigned_squad.chat_color

		if(!hud_icon_state) hud_icon_state = H.rank_fallback
		if(hud_icon_state)
			var/image/IMG = image('icons/mob/hud/marine_hud.dmi', H, "hudsquad")
			if(squad_clr)
				IMG.color = squad_clr
			else
				IMG.color = "#5A934A"
			holder.overlays += IMG
			holder.overlays += image('icons/mob/hud/marine_hud.dmi', H, "hudsquad_[hud_icon_state]")
		if(H.assigned_squad && H.assigned_fireteam)
			var/image/IMG2 = image('icons/mob/hud/marine_hud.dmi', H, "hudsquad_[H.assigned_fireteam]")
			IMG2.color = squad_clr
			holder.overlays += IMG2
			if(H.assigned_squad.fireteam_leaders[H.assigned_fireteam] == H)
				var/image/IMG3 = image('icons/mob/hud/marine_hud.dmi', H, "hudsquad_ftl")
				IMG3.color = squad_clr
				holder.overlays += IMG3

/datum/faction/pmc/get_antag_guns_snowflake_equipment()
	return list(
		list("PRIMARY FIREARMS", 0, null, null, null),
		list("M41A/2 Pulse Rifle", 30, /obj/item/weapon/gun/rifle/m41a/elite, null, VENDOR_ITEM_REGULAR),
		list("M39B/2 submachinegun", 30, /obj/item/weapon/gun/smg/m39/elite, null, VENDOR_ITEM_REGULAR),
		list("NSG23 assault rifle", 20, /obj/item/weapon/gun/rifle/nsg23, null, VENDOR_ITEM_REGULAR),

		list("PRIMARY AMMUNITION", 0, null, null, null),
		list("M41A AP magazine (10x24mm)", 10, /obj/item/ammo_magazine/rifle/ap, null, VENDOR_ITEM_REGULAR),
		list("M41A extended magazine (10x24mm)", 5, /obj/item/ammo_magazine/rifle/extended, null, VENDOR_ITEM_REGULAR),
		list("M39 AP magazine (10x20mm)", 10, /obj/item/ammo_magazine/smg/m39/ap, null, VENDOR_ITEM_REGULAR),
		list("M39 HV extended magazine (10x20mm)", 5, /obj/item/ammo_magazine/smg/m39/extended, null, VENDOR_ITEM_REGULAR),
		list("NSG 23 armor-piercing magazine (10x24mm)", 10, /obj/item/ammo_magazine/rifle/nsg23/ap, null, VENDOR_ITEM_REGULAR),
		list("NSG 23 extended magazine (10x24mm)", 5, /obj/item/ammo_magazine/rifle/nsg23/extended, null, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", 0, null, null, null),
		list("VP78 pistol", 20, /obj/item/weapon/gun/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("88 Mod 4 Combat Pistol", 15, /obj/item/weapon/gun/pistol/mod88, null, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", 0, null, null, null),
		list("VP78 magazine (9mm)", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("88M4 AP Magazine (9mm)", 5, /obj/item/ammo_magazine/pistol/mod88, null, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", 0, null, null, null),
		list("Angled Grip", 15, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("Burst Fire Assembly", 15, /obj/item/attachable/burstfire_assembly, null, VENDOR_ITEM_REGULAR),
		list("Extended Barrel", 15, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("Advanced Underbarrel Flamethrower", 15, /obj/item/attachable/attached_gun/flamer/advanced, null, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 15, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", 5, /obj/item/attachable/flashlight, null, VENDOR_ITEM_REGULAR),
		list("Red-Dot Sight", 15, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("Reflex Sight", 15, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),
		list("Suppressor", 15, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 15, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),

		list("UTILITIES", 0, null, null, null),
		list("M94 Marking Flare Pack", 3, /obj/item/storage/box/m94, null, VENDOR_ITEM_RECOMMENDED),
		list("Smoke Grenade", 7, /obj/item/explosive/grenade/smokebomb, null, VENDOR_ITEM_REGULAR)
	)

/datum/faction/pmc/get_antag_guns_sorted_equipment()
	return list(
		list("PRIMARY FIREARMS", 0, null, null, null),
		list("M41A/2 Pulse Rifle", 30, /obj/item/weapon/gun/rifle/m41a/elite, null, VENDOR_ITEM_REGULAR),
		list("M39B/2 submachinegun", 30, /obj/item/weapon/gun/smg/m39/elite, null, VENDOR_ITEM_REGULAR),
		list("NSG23 assault rifle", 30, /obj/item/weapon/gun/rifle/nsg23, null, VENDOR_ITEM_REGULAR),

		list("PRIMARY AMMUNITION", 0, null, null, null),
		list("M41A AP magazine (10x24mm)", 30, /obj/item/ammo_magazine/rifle/ap, null, VENDOR_ITEM_REGULAR),
		list("M41A extended magazine (10x24mm)", 50, /obj/item/ammo_magazine/rifle/extended, null, VENDOR_ITEM_REGULAR),
		list("M39 AP magazine (10x20mm)", 30, /obj/item/ammo_magazine/smg/m39/ap, null, VENDOR_ITEM_REGULAR),
		list("M39 HV extended magazine (10x20mm)", 50, /obj/item/ammo_magazine/smg/m39/extended, null, VENDOR_ITEM_REGULAR),
		list("NSG 23 armor-piercing magazine (10x24mm)", 30, /obj/item/ammo_magazine/rifle/nsg23/ap, null, VENDOR_ITEM_REGULAR),
		list("NSG 23 extended magazine (10x24mm)", 50, /obj/item/ammo_magazine/rifle/nsg23/extended, null, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", 0, null, null, null),
		list("VP78 pistol", 20, /obj/item/weapon/gun/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("88 Mod 4 Combat Pistol", 30, /obj/item/weapon/gun/pistol/mod88, null, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", 0, null, null, null),
		list("VP78 magazine (9mm)", 50, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("88M4 AP Magazine (9mm)", 50, /obj/item/ammo_magazine/pistol/mod88, null, VENDOR_ITEM_REGULAR),

		list("UTILITIES", 0, null, null, null),
		list("M94 Marking Flare Pack", 30, /obj/item/storage/box/m94, null, VENDOR_ITEM_RECOMMENDED),
		list("Smoke Grenade", 30, /obj/item/explosive/grenade/smokebomb, null, VENDOR_ITEM_REGULAR)
	)
