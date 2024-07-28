/datum/equipment_preset/twe
	name = "Three World Empire"
	faction = FACTION_TWE
	faction_group = list(FACTION_TWE, FACTION_USCM)
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)

/datum/equipment_preset/twe/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE, FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? first_names_male : first_names_female)) + " " + capitalize(pick(last_names))
	var/static/list/colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
	var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
	var/hair_color = pick(hair_colors)
	new_human.r_hair = hair_colors[hair_color][1]
	new_human.g_hair = hair_colors[hair_color][2]
	new_human.b_hair = hair_colors[hair_color][3]
	new_human.r_facial = hair_colors[hair_color][1]
	new_human.g_facial = hair_colors[hair_color][2]
	new_human.b_facial = hair_colors[hair_color][3]
	var/eye_color = pick(colors)
	new_human.r_eyes = colors[eye_color][1]
	new_human.g_eyes = colors[eye_color][2]
	new_human.b_eyes = colors[eye_color][3]
	if(new_human.gender == MALE)
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "CIA","Mulder", "Pixie Cut Left", "Pixie Cut Right", "Bun")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)
/datum/equipment_preset/twe/royal_marine/load_id(mob/living/carbon/human/new_human, client/mob_client)
	idtype = /obj/item/card/id/dogtag
	return ..()


//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine
	name = "RMC Rifleman"
	paygrade = "RMC E1"
	role_comm_title = "RMC-RFN"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Rifleman"
	rank = JOB_TWE_RMC_RIFLEMAN
	skills = /datum/skills/rmc

/datum/equipment_preset/twe/royal_marine/standard/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/royal_marine, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/opfor/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/nsg23/stripped, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc/, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

/datum/equipment_preset/twe/royal_marine/standard/mre_pack
	name = "TWE Royal Marine Commando (MRE Rifleman)"

/datum/equipment_preset/twe/royal_marine/standard/mre_pack/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/frame, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_box/magazine/misc/mre, WEAR_IN_BACK)
	..()

//*****************************************************************************************************/
/datum/equipment_preset/twe/royal_marine/spec/machinegun
	name = "RMC Smartgunner"
	role_comm_title = "RMC-SG"
	assignment = "Smartgunner"
	rank = JOB_TWE_RMC_SMARTGUNNER
	skills = /datum/skills/rmc/smartgun

/datum/equipment_preset/twe/royal_marine/spec/machinegun/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/royal_marine, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/opfor/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc, WEAR_FEET)
	new_human.equip_to_slot(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/smartgun, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun/rmc, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot(new /obj/item/smartgun_battery(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun/holo_targetting, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun/holo_targetting, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full, WEAR_R_STORE)

//*****************************************************************************************************/
/datum/equipment_preset/twe/royal_marine/team_leader
	name = "TWE Royal Marine Commando (Teamleader)"
	paygrade = "RMC E4"
	role_comm_title = "RMC-TL"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Team Leader"
	rank = JOB_TWE_RMC_TEAMLEADER
	skills = /datum/skills/rmc/leader

/datum/equipment_preset/twe/royal_marine/team_leader/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/royal_marine, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/opfor/royal_marine/tl, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90/a_grip, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular/response, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/surgical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/twe/royal_marine/lieuteant //they better say it Lef-tenant or they should be banned for LRP. More importantly this guy doesn't spawn in the ERT
	name = "TWE Royal Marine Commando (Officer)"
	paygrade = "RMC O1"
	role_comm_title = "RMC-LT"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Team Commander"
	rank = JOB_TWE_RMC_LIEUTENANT
	skills = /datum/skills/rmc/leader

/datum/equipment_preset/twe/royal_marine/lieuteant/load_gear(mob/living/carbon/human/new_human)


	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/royal_marine, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/royal_marine/team_leader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/opfor/royal_marine/lt, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/team_leader, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90/a_grip, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/l905/full, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular/response, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/surgical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator/compact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/incin, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/rmc/he, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full, WEAR_R_STORE)

