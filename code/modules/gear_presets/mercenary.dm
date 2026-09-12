/datum/equipment_preset/mercenary
	name = "Black Dragoons Mercenary Company"
	faction = FACTION_MERCENARY
	rank = JOB_MERCENARY
	faction = FACTION_MERCENARY
	faction_group = list(FACTION_MERCENARY)
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	idtype = /obj/item/card/id/data
	var/headset_type = /obj/item/device/radio/headset/distress/merc

/datum/equipment_preset/mercenary/New()
	. = ..()
	access = get_access(ACCESS_LIST_EMERGENCY_RESPONSE, ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND)


/datum/equipment_preset/mercenary/load_name(mob/living/carbon/human/new_human)
	new_human.gender = pick(60;MALE,40;FEMALE)
	var/datum/preferences/A = new()
	A.randomize_appearance(new_human)
	var/random_name
	random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
	new_human.change_real_name(new_human, random_name)
	new_human.name = new_human.real_name
	new_human.age = rand(22,45)

	var/static/list/colors = list("BLACK" = list(15, 15, 25), "BROWN" = list(102, 51, 0), "AUBURN" = list(139, 62, 19))
	var/static/list/hair_colors = colors.Copy() + list("BLONDE" = list(197, 164, 30), "CARROT" = list(174, 69, 42))
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
	idtype = /obj/item/card/id/data
	if(new_human.gender == MALE)
		new_human.h_style = pick("Crewcut", "Shaved Head", "Buzzcut", "Undercut", "Side Undercut", "Pvt. Joker", "Marine Fade", "Low Fade", "Medium Fade", "High Fade", "No Fade", "Coffee House Cut", "Flat Top",)
		new_human.f_style = pick("5 O'clock Shadow", "Shaved", "Full Beard", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Ponytail 1", "Ponytail 2", "Ponytail 3", "Ponytail 4", "Pvt. Redding", "Pvt. Clarison", "Cpl. Dietrich", "Pvt. Vasquez", "Marine Bun", "Marine Bun 2", "Marine Flat Top",)
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,45)
	new_human.r_hair = rand(15,35)
	new_human.g_hair = rand(15,35)
	new_human.b_hair = rand(25,45)

//*****************************************************************************************************/
/datum/equipment_preset/mercenary/grunt
	name = "Black Dragoons Grunt (Generic)"
	paygrades = list(PAY_SHORT_BD_PC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "GRNT"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Grunt"
	rank = JOB_MERCENARY
	skills = /datum/skills/cargotech
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/grunt/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/grunt/technician
	name = "Black Dragoons Grunt (Technician)"
	paygrades = list(PAY_SHORT_BD_C = JOB_PLAYTIME_TIER_0)
	role_comm_title = "GRNT-T"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Technician Grunt"
	rank = JOB_MERCENARY
	skills = /datum/skills/mainttech
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/grunt/technician/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/blue(new_human), WEAR_JACKET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/white, WEAR_HEAD)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/grunt/doctor
	name = "Black Dragoons Grunt (Doctor)"
	paygrades = list(PAY_SHORT_BD_C = JOB_PLAYTIME_TIER_0)
	role_comm_title = "GRNT-D"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Doctor Grunt"
	rank = JOB_MERCENARY
	skills = /datum/skills/doctor
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/grunt/doctor/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/surgical_case/regular, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/med, WEAR_ACCESSORY)
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat (new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full, WEAR_WAIST)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/pilot
	name = "Black Dragoons Pilot"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PILOT"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Pilot"
	rank = JOB_MERCENARY_PILOT
	skills = /datum/skills/crew_chief
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/pilot/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/light(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot/merc, WEAR_HEAD)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/pilot/driver
	name = "Black Dragoons Driver"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "DRVR"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Driver"
	rank = JOB_MERCENARY_PILOT
	skills = /datum/skills/mainttech
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/pilot/driver/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/light(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/pfc, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel
	name = "Black Dragoons Sentinel (Rifle/Carbine/SMG)"
	paygrades = list(PAY_SHORT_BD_C = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SNTL"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/trooper
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	if(prob(20))
		new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	var/merc_gun = rand(1,3)
	switch(merc_gun)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a/m1c, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/fp9000/tactical, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
			new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel/lead
	name = "Black Dragoons Sentinel Lead (Rifle)"
	paygrades = list(PAY_SHORT_BD_SC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SNTL-L"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel Lead"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/trooper
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/lead/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//weapon
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel/mg
	name = "Black Dragoons Sentinel Machinegunner (SAW)"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SNTL-MG"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel Machinegunner"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/trooper
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/mg/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_JACKET)
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a/m1d, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1/drum, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1/drum, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1/drum, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel/marksman
	name = "Black Dragoons Sentinel Marksman (Marksman Rifle)"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "STNL-M"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel Marksman"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/trooper
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/marksman/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a/m1b, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel/at
	name = "Black Dragoons Sentinel AT Specialist (Anti-Tank + Carbine)"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SNTL-AT"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel AT Specialist"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/trooper
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/at/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	if(prob(20))
		new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/prop/folded_anti_tank_sadar, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/prop/folded_anti_tank_sadar, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/M3T, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/raincover, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a/m1c, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable, WEAR_L_HAND)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel/medic
	name = "Black Dragoons Sentinel Medic (Medic)"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SNTL-MD"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel Medic"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/combat_medic
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/surgical_case/regular, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/light(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/fp9000/tactical, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/medgreen, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/blood/OMinus, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/blood/saline, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/sentinel/tech
	name = "Black Dragoons Sentinel Technician (Technician)"
	paygrades = list(PAY_SHORT_BD_CS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SNTL-T"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Sentinel Technician"
	rank = JOB_MERCENARY_SENTINEL
	skills = /datum/skills/mainttech
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/sentinel/tech/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/light(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/fp9000/tactical, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/low_grade_full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/fp9000, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/supervisor
	name = "Black Dragoons Supervisor (Unequipped)"
	paygrades = list(PAY_SHORT_BD_SV = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Supervisor"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Supervisor"
	rank = JOB_MERCENARY_SUPERVISOR
	skills = /datum/skills/nco
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/supervisor/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber/grey(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/sec/alt, WEAR_HEAD)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m44/standard, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead/black/hollowpoint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead/hollowpoint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead/hollowpoint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead/hollowpoint, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/supervisor/equipped
	name = "Black Dragoons Supervisor (Equipped, Carbine)"
	paygrades = list(PAY_SHORT_BD_SV = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Supervisor"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Supervisor"
	rank = JOB_MERCENARY_SUPERVISOR
	skills = /datum/skills/nco
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/supervisor/equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	if(prob(20))
		new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/combat, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/sec/alt, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a/m1c, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs/modded, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/synth
	name = "Black Dragoons Synthetic (Support)"
	paygrades = list(PAY_SHORT_BD_SY = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Synthetic"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Synthetic"
	rank = JOB_MERCENARY_SYNTH
	skills = /datum/skills/synthetic
	faction = FACTION_MERCENARY
	languages = ALL_SYNTH_LANGUAGES

/datum/equipment_preset/mercenary/synth/load_skills(mob/living/carbon/human/new_human)
	new_human.set_skills(/datum/skills/synthetic)
	new_human.allow_gun_usage = FALSE

/datum/equipment_preset/mercenary/synth/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(50;MALE,50;FEMALE)
	var/datum/preferences/A = new()
	A.randomize_appearance(new_human)
	var/random_name
	if(new_human.gender == MALE)
		random_name = "[pick(GLOB.first_names_male)]"
	else
		random_name = "[pick(GLOB.first_names_female)]"

	if(new_human.gender == MALE)
		new_human.f_style = pick("3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache")


	new_human.change_real_name(new_human, random_name)
	new_human.h_style = pick("Crewcut", "Shaved Head", "Buzzcut", "Undercut", "Side Undercut")
	var/static/list/colors = list("BLACK" = list(15, 15, 25), "BROWN" = list(102, 51, 0), "AUBURN" = list(139, 62, 19))
	var/static/list/hair_colors = colors.Copy() + list("BLONDE" = list(197, 164, 30), "CARROT" = list(174, 69, 42))
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
	idtype = /obj/item/card/id/data

/datum/equipment_preset/mercenary/synth/load_race(mob/living/carbon/human/new_human)
	new_human.set_species(SYNTH_GEN_TWO)

/datum/equipment_preset/mercenary/synth/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/balaclava, WEAR_FACE)
	//body
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//póckets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/first_responder/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/synth, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/bulwark
	name = "Black Dragoons Bulwark (Heavy Response Rifleman)"
	paygrades = list(PAY_SHORT_BD_SC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "BLWK"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Bulwark"
	rank = JOB_MERCENARY_BULWARK
	skills = /datum/skills/heavygunner
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/bulwark/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/big, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/merc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/health/ceramic_plate, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/r81m1a/modded, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1/ap, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1/ap, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/r81m1, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs/modded, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/bulwark/breacher
	name = "Black Dragoons Bulwark (Heavy Response Breacher)"
	paygrades = list(PAY_SHORT_BD_SC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "BLWK"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Bulwark"
	rank = JOB_MERCENARY_BULWARK
	skills = /datum/skills/heavygunner
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/bulwark/breacher/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/big, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic/breaching_charge, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/merc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/health/ceramic_plate, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/p79s/slug, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/shotgun, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium/slugs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium/slugs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium/slugs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium/slugs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium/slugs, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/medium, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs/modded, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/bulwark/guardian
	name = "Black Dragoons Bulwark (Heavy Response Guardian)"
	paygrades = list(PAY_SHORT_BD_SC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "BLWK"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Bulwark"
	rank = JOB_MERCENARY_BULWARK
	skills = /datum/skills/heavygunner
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/bulwark/guardian/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/weapon/shield/riot/metal, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/merc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/health/ceramic_plate, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/mp47a2, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/ointment, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs/modded, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/mercenary/coordinator
	name = "Black Dragoons Operations Coordinator"
	paygrades = list(PAY_SHORT_BD_OC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "OPCO"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Operations Coordinator"
	rank = JOB_MERCENARY_OFFICER
	skills = /datum/skills/officer
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/coordinator/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black,, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/combat, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/field(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/bomber/grey(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/holobadge/cord, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/cm/red, WEAR_HEAD)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m44, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead/black/hollowpoint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead/hollowpoint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead/hollowpoint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead/hollowpoint, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)

//*****************************************************************************************************/

/datum/equipment_preset/mercenary/infiltrator
	name = "Black Dragoons Infiltrator"
	paygrades = list(PAY_SHORT_BD_SC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "INFL"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Black Dragoons Infiltrator"
	rank = JOB_MERCENARY_INFILTRATOR
	skills = /datum/skills/specialist
	faction = FACTION_MERCENARY

/datum/equipment_preset/mercenary/infiltrator/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Undershirt (Black, Long Sleeved)"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/big, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre,WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/merc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/merc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/ghillie_goggles, WEAR_EYES)
	//uniform + armour
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/merc(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/merc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/raincover, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/mp47a2/tactical, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/poncho/blue, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/b92fs/modded, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/b92fs, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2/extended, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2/extended, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/mp47a2/extended, WEAR_IN_R_STORE)

	var/obj/item/device/internal_implant/agility/implant = new()
	implant.on_implanted(new_human)
