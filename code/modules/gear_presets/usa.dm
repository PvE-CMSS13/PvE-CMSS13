/datum/equipment_preset/usa
	name = "US Army"
	faction = FACTION_ARMY
	faction_group = FACTION_LIST_UA
	minimum_age = 20
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH)
	///Gives the soldiers their radios
	var/headset_type = /obj/item/device/radio/headset/distress/army
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/usa/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(60;MALE,40;FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
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
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut", "Crewcut", "Shaved Head", "Buzzcut", "Pvt. Joker", "Marine Fade", "Low Fade", "Medium Fade", "High Fade",)
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right", "Bun", "Ponytail 1", "Ponytail 2", "Ponytail 3", "Ponytail 4", "Pvt. Clarison", "Cpl. Dietrich", "Pvt. Vasquez", "Marine Bun", "Marine Bun 2", "Marine Flat Top",)
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/usa/proc/spawn_army_mask_items(mob/living/carbon/human/new_human)
	var/list/possible_masks = subtypesof(/obj/item/clothing/mask/rebreather) + subtypesof(/obj/item/clothing/mask/tornscarf)
	if(prob(20))
		var/obj/item/clothing/mask/new_mask = pick(possible_masks)
		new_human.equip_to_slot_or_del(new new_mask, WEAR_FACE)

/datum/equipment_preset/proc/spawn_army_fluff_items(mob/living/carbon/human/new_human)
	var/obj/item/helmet_accessory = pick(GLOB.allowed_helmet_items)
	new_human.equip_to_slot_or_del(new helmet_accessory, WEAR_IN_HELMET)
	if(prob(50))
		var/obj/item/helmet_accessory_two = pick(GLOB.allowed_helmet_items)
		new_human.equip_to_slot_or_del(new helmet_accessory_two, WEAR_IN_HELMET)
	var/list/possible_masks = subtypesof(/obj/item/clothing/mask/rebreather) + subtypesof(/obj/item/clothing/mask/tornscarf)
	if(prob(50))
		var/obj/item/clothing/mask/new_mask = pick(possible_masks)
		new_human.equip_to_slot_or_del(new new_mask, WEAR_FACE)

//*****************************************************************************************************/

/datum/equipment_preset/usa/trooper
	name = "Army Trooper"
	assignment = JOB_ARMY_TROOPER
	rank = JOB_ARMY_TROOPER
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "TRPR"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/trooper

/datum/equipment_preset/usa/trooper/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/grenadier
	name = "Army Grenadier"
	assignment = JOB_ARMY_PROPIPE
	rank = JOB_ARMY_PROPIPE
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA
	role_comm_title = "GRDR"
	skills = /datum/skills/trooper

/datum/equipment_preset/usa/grenadier/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/grenade/army(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/incendiary(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)


/datum/equipment_preset/usa/marksman
	name = "Army Designated Marksman"
	assignment = JOB_ARMY_MARKSMAN
	rank = JOB_ARMY_MARKSMAN
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "DM"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/trooper	//Trooper but with a scoped rifle

/datum/equipment_preset/usa/marksman/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/poncho/green/army(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m49a/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/army(new_human), WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/ap(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/ap(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/ap(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/incendiary(new_human), WEAR_IN_R_STORE)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/marksman/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/gunner
	name = "Army Gunner"
	assignment = JOB_ARMY_GUNNER
	rank = JOB_ARMY_GUNNER
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "L-Gnr"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/trooper	//trooper with a big gun, no fancy skills

/datum/equipment_preset/usa/gunner/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lmg/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/army(new_human), WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/folding_barricade/three(new_human), WEAR_BACK)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/gunner/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/heavygunner
	name = "Army Heavy Gunner"
	assignment = JOB_ARMY_SMARTGUNNER
	rank = JOB_ARMY_SMARTGUNNER
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "H-Gnr"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/heavygunner

/datum/equipment_preset/usa/heavygunner/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/smartgunner/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/army/full(new_human), WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/heavygunner/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/ATgunner
	name = "Army Anti-Tank Gunner"
	assignment = JOB_ARMY_ATFIRE
	rank = JOB_ARMY_ATFIRE
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "AT-Gnr"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/trooper	//Trooper with a toob, nothing fancy needed

/datum/equipment_preset/usa/ATgunner/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/rocket/marine/army(new_human), WEAR_BACK)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/ATgunner/loader
	name = "Army Anti-Tank Loader"
	assignment = JOB_ARMY_ATLOAD
	rank = JOB_ARMY_ATLOAD
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "AT-Ldr"

/datum/equipment_preset/usa/ATgunner/loader/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/rocketpack/army(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/wp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/ap(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/ap(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)
	..()


/datum/equipment_preset/usa/sapper
	name = "Army Combat Engineering Technician"
	assignment = JOB_ARMY_ENGI
	rank = JOB_ARMY_ENGI
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CET"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/sapper

/datum/equipment_preset/usa/sapper/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/tool_webbing/equipped(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army/alt(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/welder_chestrig(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/toolkit/full(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)


/datum/equipment_preset/usa/mainttech
	name = "Army Technical Engineer"
	assignment = JOB_ARMY_MT
	rank = JOB_ARMY_MT
	paygrades = list(PAY_SHORT_AE5 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "TechEng"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/mainttech

/datum/equipment_preset/usa/mainttech/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/engine(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/tool_webbing/equipped(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/black(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/welder_chestrig(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/toolkit/full(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool(new_human), WEAR_IN_BACK)


/datum/equipment_preset/usa/cargotech
	name = "Army Logistics Supply Specialist"
	assignment = JOB_ARMY_CT
	rank = JOB_ARMY_CT
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "LogiSpc"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/cargotech

/datum/equipment_preset/usa/cargotech/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/cargo(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/fingerless(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/yellow(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/army(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)


/datum/equipment_preset/usa/medic
	name = "Army Combat Medical Technician"
	assignment = JOB_ARMY_MEDIC
	rank = JOB_ARMY_MEDIC
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CMT"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/medic

/datum/equipment_preset/usa/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/medgreen(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/md/army(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon/mk1(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/autoinjector/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full/army(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/medic/army(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/tank
	name = "Army Vehicle Crewman"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_ARMY_TANK_CREW
	rank = JOB_ARMY_TANK_CREW
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "VeCr"
	skills = /datum/skills/mainttech

/datum/equipment_preset/usa/tank/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/armor(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army/alt(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tank(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/welder_chestrig(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/nco
	name = "Army Fireteam Leader"
	assignment = JOB_ARMY_NCO
	rank = JOB_ARMY_NCO
	paygrades = list(PAY_SHORT_AE5 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "FTL"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/nco

/datum/equipment_preset/usa/nco/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/heavy(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army/leader(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army/masterkey(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/shotgun/large/buckshot(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/twohanded/breacher(new_human), WEAR_BACK)
	spawn_army_mask_items(new_human)


/datum/equipment_preset/usa/snco
	name = "Army Squad Leader"
	assignment = JOB_ARMY_SNCO
	rank = JOB_ARMY_SNCO
	paygrades = list(PAY_SHORT_AE7 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SL"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/snco

/datum/equipment_preset/usa/snco/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/army/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto/army(new_human), WEAR_HEAD)
	add_army_helmet_accessory(new_human)
	add_army_helmet_eyewear(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/army/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army/leader(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/autoinjector/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/first_responder/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto/army(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare/signal(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/high_explosive(new_human), WEAR_IN_BACK)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/snco/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AE6 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/lt
	name = "Army Platoon Officer"
	assignment = JOB_ARMY_LT
	rank = JOB_ARMY_LT
	paygrades = list(PAY_SHORT_AO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PltOff"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/lt

/datum/equipment_preset/usa/lt/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/army/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/standard/army(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/infantry(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/md/army(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army/leader(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/army(new_human), WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	spawn_army_mask_items(new_human)

/datum/equipment_preset/usa/lt/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/intelofficer
	name = "Army Intelligence Officer"
	assignment = JOB_ARMY_INTEL
	rank = JOB_ARMY_INTEL
	paygrades = list(PAY_SHORT_AO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "IntelOff"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/lt

/datum/equipment_preset/usa/intelofficer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/army/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/fountain(new_human), WEAR_R_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	add_combat_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army/spook(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/medium/rto/md/army(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small/army/leader(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/army(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/m1911/socom(new_human), WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/intel/chestrig/army(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/notepad(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)

/datum/equipment_preset/usa/intelofficer/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/researcher
	name = "Army Science Officer"
	assignment = JOB_ARMY_RESEARCHER
	rank = JOB_ARMY_RESEARCHER
	paygrades = list(PAY_SHORT_AO3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SciOff"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/lt
	idtype = /obj/item/card/id/silver

/datum/equipment_preset/usa/researcher/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/army/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/researcher(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/army(new_human), WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)

/datum/equipment_preset/usa/researcher/lesser_rank
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_AO2 = JOB_PLAYTIME_TIER_0)


/datum/equipment_preset/usa/cargoofficer
	name = "Army Logistics Supply Officer"
	assignment = JOB_ARMY_QM
	rank = JOB_ARMY_QM
	paygrades = list(PAY_SHORT_AO2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "LogiOff"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/cargoofficer

/datum/equipment_preset/usa/cargoofficer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new headset_type(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/qm_suit(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/fingerless(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/army(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing(new_human), WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/hazardvest/blue(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/army(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
