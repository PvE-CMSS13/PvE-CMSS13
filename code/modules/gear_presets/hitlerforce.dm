/datum/equipment_preset/hitlerforce

	name = "German Heer"// we are RETURNING TO CASTLE WOLFENSTEIN
	faction = FACTION_WW2_GERMAN
	faction_group = list(
		FACTION_WW2_GERMAN,
	)
	rank = JOB_HEER_GRUNT
	languages = list(
		LANGUAGE_GERMAN,
	)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/hitlerforce/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) //TODO: tell scotty to configure the security on the map for CLF access..

/datum/equipment_preset/mercenary/load_name(mob/living/carbon/human/new_human)
	new_human.gender = MALE //rip to whoever it was.
	var/datum/preferences/A = new()
	A.randomize_appearance(new_human)

	var/random_name
	var/first_name
	var/last_name
	//idk im just cribbing
	first_name = "[pick(GLOB.first_names_male_upp)]"
	if(prob(20))
		new_human.f_style = pick("3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache")
	else
		new_human.f_style = "Shaved"
	//finish naming
	random_name = "[first_name] [last_name]"

	new_human.change_real_name(new_human, random_name)
	new_human.age - rand(17, 45)
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
	new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")

/datum/equipment_preset/hitlerforce/regulars
	name = "Heer Rifleman"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "German Heer"
	role_comm_title = null
	paygrades = list(
		PAY_SHORT_UE1 = JOB_PLAYTIME_TIER_0
	)
	skills = /datum/skills/pfc
	faction = FACTION_WW2_GERMAN

/datum/equipment_preset/hitlerforce/regulars/load_gear(mob/living/carbon/human/new_human)
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
