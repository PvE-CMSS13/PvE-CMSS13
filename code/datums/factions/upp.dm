/datum/faction/upp
	name = "Union of Progressive Peoples"
	faction_tag = FACTION_UPP
	access_all = ACCESS_LIST_UPP_ALL
	access_main = ACCESS_LIST_UPP_PLATOON
	access_regions = ACCESS_LIST_UPP_REGIONS

/datum/faction/upp/get_faction_departments(faction_to_check)
	return DEPARTMENT_UPP_ALL

/datum/faction/upp/modify_hud_holder(image/holder, mob/living/carbon/human/H)
	var/hud_icon_state
	var/obj/item/card/id/ID = H.get_idcard()
	var/_role
	if(H.mind)
		_role = H.job
	else if(ID)
		_role = ID.rank
	switch(_role)
		if(JOB_UPP_MEDIC)
			hud_icon_state = "med"
		if(JOB_UPP_ENGI)
			hud_icon_state = "sapper"
		if(JOB_UPP_SPECIALIST)
			hud_icon_state = "spec"
		if(JOB_UPP_LEADER)
			hud_icon_state = "sl"
		if(JOB_UPP_POLICE)
			hud_icon_state = "mp"
		if(JOB_UPP_LT_OFFICER, JOB_SO)
			hud_icon_state = "lt"
		if(JOB_UPP_SRLT_OFFICER)
			hud_icon_state = "slt"
		if(JOB_UPP_KPT_OFFICER)
			hud_icon_state = "xo"
		if(JOB_UPP_MAY_OFFICER)
			hud_icon_state = "co"
		if(JOB_UPP_LTKOL_OFFICER)
			hud_icon_state = "co"
		if(JOB_UPP_KOL_OFFICER)
			hud_icon_state = "co"
		if(JOB_UPP_MAY_GENERAL)
			hud_icon_state = "co"
		if(JOB_UPP_LT_GENERAL)
			hud_icon_state = "co"
		if(JOB_UPP_GENERAL)
			hud_icon_state = "co"
		if(JOB_UPP_COMBAT_SYNTH)
			hud_icon_state = "synth"
		if(JOB_UPP_SUPPORT_SYNTH)
			hud_icon_state = "synth"
		if(JOB_UPP_COMMANDO)
			hud_icon_state = "com"
		if(JOB_UPP_COMMANDO_MEDIC)
			hud_icon_state = "commed"
		if(JOB_UPP_COMMANDO_LEADER)
			hud_icon_state = "comsl"
		if(JOB_UPP_CREWMAN)
			hud_icon_state = "vc"
		if(JOB_UPP_LT_DOKTOR)
			hud_icon_state = "doc"
	if(hud_icon_state)
		holder.overlays += image('icons/mob/hud/marine_hud.dmi', H, "upp_[hud_icon_state]")

//UPP PVE PLATOON
	var/datum/squad/squad = H.assigned_squad
	if(istype(squad, /datum/squad/marine/upp))
		var/squad_clr = H.assigned_squad.equipment_color
		switch(GET_SQUAD_ROLE_MAP(_role))
			if(JOB_SQUAD_MEDIC) hud_icon_state = "med"
			if(JOB_SQUAD_SMARTGUN) hud_icon_state = "gun"
			if(JOB_SQUAD_TEAM_LEADER) hud_icon_state = "tl"
			if(JOB_SQUAD_LEADER) hud_icon_state = "leader_a"
		if(squad.fireteam_leaders["SQ1"] == H || squad.fireteam_leaders["SQ2"] == H)
			H.langchat_styles = "langchat_smaller_bolded"
		else
			H.langchat_styles = initial(H.langchat_styles)
		H.langchat_color = H.assigned_squad.chat_color

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

/datum/faction/upp/get_antag_guns_snowflake_equipment()
	return list(
		list("PRIMARY FIREARMS", 0, null, null, null),
		list("Type 64 Submachinegun", 20, /obj/item/weapon/gun/smg/bizon/upp, null, VENDOR_ITEM_REGULAR),
		list("Type 71 Pulse Rifle", 30, /obj/item/weapon/gun/rifle/type71, null, VENDOR_ITEM_REGULAR),
		list("Type 71 Pulse Rifle Carbine", 30, /obj/item/weapon/gun/rifle/type71/carbine, null, VENDOR_ITEM_REGULAR),

		list("PRIMARY AMMUNITION", 0, null, null, null),
		list("Type 64 Helical Magazine (7.62x19mm)", 5, /obj/item/ammo_magazine/smg/bizon, null, VENDOR_ITEM_REGULAR),
		list("Type 71 AP Magazine (5.45x39mm)", 15, /obj/item/ammo_magazine/rifle/type71/ap, null, VENDOR_ITEM_REGULAR),
		list("Type 71 Magazine (5.45x39mm)", 5, /obj/item/ammo_magazine/rifle/type71, null, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", 0, null, null, null),
		list("Type 73 Pistol", 25, /obj/item/weapon/gun/pistol/t73, null, VENDOR_ITEM_REGULAR),
		list("NP92 Pistol", 15, /obj/item/weapon/gun/pistol/np92, null, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 Revolver", 15, /obj/item/weapon/gun/revolver/upp, null, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", 0, null, null, null),
		list("Type 73 Magazine (7.62x25mm Tokarev)", 5, /obj/item/ammo_magazine/pistol/t73, null, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 Speed Loader (7.62x38mmR)", 5, /obj/item/ammo_magazine/revolver/upp, null, VENDOR_ITEM_REGULAR),
		list("NP92 Magazine (9x18mm Makarov)", 40, /obj/item/ammo_magazine/pistol/np92, null, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", 0, null, null, null),
		list("Angled Grip", 15, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("Burst Fire Assembly", 15, /obj/item/attachable/burstfire_assembly, null, VENDOR_ITEM_REGULAR),
		list("Extended Barrel", 15, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 15, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", 5, /obj/item/attachable/flashlight, null, VENDOR_ITEM_REGULAR),
		list("Red-Dot Sight", 15, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("Reflex Sight", 15, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),
		list("Suppressor", 15, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 15, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),

		list("UTILITIES", 0, null, null, null),
		list("M94 Marking Flare Pack", 3, /obj/item/storage/box/m94, null, VENDOR_ITEM_RECOMMENDED),
		list("Smoke Grenade", 7, /obj/item/explosive/grenade/smokebomb, null, VENDOR_ITEM_REGULAR),
		list("Type 80 Bayonet", 3, /obj/item/attachable/bayonet/upp, null, VENDOR_ITEM_REGULAR),
	)

/datum/faction/upp/get_antag_guns_sorted_equipment()
	return list(
		list("PRIMARY FIREARMS", -1, null, null),
		list("Type 64 Submachinegun", 20, /obj/item/weapon/gun/smg/bizon/upp, VENDOR_ITEM_REGULAR),
		list("Type 71 Pulse Rifle", 20, /obj/item/weapon/gun/rifle/type71, VENDOR_ITEM_REGULAR),
		list("Type 71 Pulse Rifle Carbine", 20, /obj/item/weapon/gun/rifle/type71/carbine, VENDOR_ITEM_REGULAR),

		list("PRIMARY AMMUNITION", -1, null, null),
		list("Type 64 Helical Magazine (7.62x19mm)", 60, /obj/item/ammo_magazine/smg/bizon, VENDOR_ITEM_REGULAR),
		list("Type 71 AP Magazine (5.45x39mm)", 60, /obj/item/ammo_magazine/rifle/type71/ap, VENDOR_ITEM_REGULAR),
		list("Type 71 Magazine (5.45x39mm)", 60, /obj/item/ammo_magazine/rifle/type71, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("Type 73 Pistol", 20, /obj/item/weapon/gun/pistol/t73, VENDOR_ITEM_REGULAR),
		list("NP02 Pistol", 20, /obj/item/weapon/gun/pistol/np92, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 Revolver", 20, /obj/item/weapon/gun/revolver/upp, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("Type 73 Magazine (7.62x25mm Tokarev)", 40, /obj/item/ammo_magazine/pistol/t73, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 Speed Loader (7.62x38mmR)", 40, /obj/item/ammo_magazine/revolver/upp, VENDOR_ITEM_REGULAR),
		list("NP92 Magazine (9x18mm Makarov)", 40, /obj/item/ammo_magazine/pistol/np92, VENDOR_ITEM_REGULAR),

		list("UTILITIES", -1, null, null),
		list("M94 Marking Flare Pack", 20, /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED),
		list("Smoke Grenade", 5, /obj/item/explosive/grenade/smokebomb, VENDOR_ITEM_REGULAR),
		list("Type 80 Bayonet", 40, /obj/item/attachable/bayonet/upp, VENDOR_ITEM_REGULAR),
	)
