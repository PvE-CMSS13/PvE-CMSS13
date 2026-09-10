
/datum/equipment_preset/pmc
	name = "PMC"
	faction = FACTION_PMC
	rank = FACTION_PMC
	idtype = /obj/item/card/id/pmc
	faction = FACTION_PMC
	faction_group = FACTION_LIST_WY
	languages = list(LANGUAGE_ENGLISH)
	var/human_versus_human = FALSE

/datum/equipment_preset/pmc/New()
	. = ..()
	access = get_access(ACCESS_LIST_WY_PMC)

/datum/equipment_preset/pmc/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(75;MALE,25;FEMALE)
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
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/pmc/load_id(mob/living/carbon/human/new_human, client/mob_client)
	if(human_versus_human)
		var/obj/item/clothing/under/uniform = new_human.w_uniform
		if(istype(uniform))
			uniform.has_sensor = UNIFORM_HAS_SENSORS
			uniform.sensor_faction = FACTION_PMC
	return ..()


//*****************************************************************************************************/
/datum/equipment_preset/pmc/standard
	name = "Weyland-Yutani PMC (Standard)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_PMC_STANDARD
	rank = JOB_PMC_STANDARD
	paygrades = list(PAY_SHORT_PMC_OP = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pmc

/datum/equipment_preset/pmc/standard/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/wy, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//head
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_goggles, WEAR_IN_HELMET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava/twohole, WEAR_FACE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/black, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava, WEAR_FACE)
	//uniform
	var/obj/item/clothing/under/marine/veteran/pmc/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/regular, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/heavy, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/heavy, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/wy, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc/black, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate/wy, WEAR_R_STORE)

	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/tactical/ap, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy, WEAR_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/preset, WEAR_ACCESSORY)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/elite, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presettwo, WEAR_ACCESSORY)

//*****************************************************************************************************/
/datum/equipment_preset/pmc/medic
	name = "Weyland-Yutani PMC (Corporate Medic)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_PMC_MEDIC
	rank = JOB_PMC_MEDIC
	paygrades = list(PAY_SHORT_PMC_MS = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pmc/medic

/datum/equipment_preset/pmc/medic/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/wy, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//head
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_platemask, WEAR_IN_HELMET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava, WEAR_FACE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava/twohole, WEAR_FACE)
	//uniform
	var/obj/item/clothing/under/marine/veteran/pmc/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/surgical_case/regular, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/regular, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/heavy/medic, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/heavy/medic, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/wy/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc/black, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/pmc/leader
	name = "Weyland-Yutani PMC (Leader)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_LEADER
	rank = JOB_PMC_LEADER
	paygrades = list(PAY_SHORT_PMC_TL = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SL"
	skills = /datum/skills/pmc/SL

/datum/equipment_preset/pmc/leader/New()
	. = ..()
	access = get_access(ACCESS_LIST_WY_PMC) + list(ACCESS_WY_LEADERSHIP, ACCESS_WY_PMC_TL)

/datum/equipment_preset/pmc/leader/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//head
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_goggles, WEAR_IN_HELMET)
		new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_platemask, WEAR_IN_HELMET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/leader, WEAR_FACE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/pmc, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/leader, WEAR_FACE)
	//uniform
	var/obj/item/clothing/under/marine/veteran/pmc/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/emergency, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/heavy, WEAR_JACKET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presettwo, WEAR_ACCESSORY)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/heavy, WEAR_JACKET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presettwo, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/elite, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/wy, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate/wy, WEAR_R_STORE)

	var/obj/item/device/radio/headset/R = new_human.wear_l_ear
	if(istype(R))
		R.volume = RADIO_VOLUME_IMPORTANT

//*****************************************************************************************************/

/datum/equipment_preset/pmc/gunner
	name = "Weyland-Yutani PMC (Gunner)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_GUNNER
	rank = JOB_PMC_GUNNER
	paygrades = list(PAY_SHORT_PMC_SS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SG"
	skills = /datum/skills/pmc/smartgunner

/datum/equipment_preset/pmc/gunner/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc, WEAR_FACE)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/gunner, WEAR_HEAD)
	//uniform
	var/obj/item/clothing/under/marine/veteran/pmc/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/emergency, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/smartgun/heavy, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/pmc/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc/black, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate/wy, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)

//*****************************************************************************************************/

/datum/equipment_preset/pmc/sniper
	name = "Weyland-Yutani PMC (Sniper)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_SNIPER
	rank = JOB_PMC_SNIPER
	paygrades = list(PAY_SHORT_PMC_WS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Spc"
	skills = /datum/skills/pmc/specialist

/datum/equipment_preset/pmc/sniper/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m42_hms/m42c, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//head
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/sniper, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava/twohole, WEAR_FACE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/black, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava/twohole, WEAR_FACE)
	//uniform
	var/obj/item/clothing/under/marine/veteran/pmc/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/regular, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/heavy, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/sniper/elite, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presetthree, WEAR_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/m39/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy/pmc_sniper, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate/wy, WEAR_R_STORE)
//*****************************************************************************************************/
/datum/equipment_preset/pmc/crewman
	name = "Weyland-Yutani PMC (Crewman)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_PMC_CREWMAN
	rank = JOB_PMC_CREWMAN
	paygrades = list(PAY_SHORT_PMC_VS = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pmc/tank_crew

/datum/equipment_preset/pmc/crewman/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/engineer, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/regular, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/engineer, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/preset, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding/superior, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/ert/pmc, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldpack/minitank, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/largetank, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/guard/crewman, WEAR_HEAD)

	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_HELMET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/wy/vp78, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/full, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy/pmc_m39, WEAR_L_STORE)

	spawn_weapon(/obj/item/weapon/gun/smg/m39/elite/pve, /obj/item/ammo_magazine/smg/m39/ap, new_human, 0, 0)

/*****************************************************************************************************/

/datum/equipment_preset/pmc/xeno_handler
	name = "Weyland-Yutani PMC (Xeno Handler)"
	flags = EQUIPMENT_PRESET_EXTRA

	faction_group = FACTION_LIST_MARINE_WY

	assignment = JOB_PMC_XENO_HANDLER
	rank = JOB_PMC_XENO_HANDLER
	paygrades = list(PAY_SHORT_PMC_XS = JOB_PLAYTIME_TIER_0)
	role_comm_title = "XH"
	skills = /datum/skills/pmc/xeno_handler
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE, LANGUAGE_XENOMORPH)

/datum/equipment_preset/pmc/xeno_handler/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_platemask, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/heavy, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/preset, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc/black, WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/syringe_case/burn, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/emergency, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/pmc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/wy/vp70, WEAR_WAIST)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy/pmc_m39, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate/wy, WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)

/*****************************************************************************************************/

/datum/equipment_preset/pmc/doctor
	name = "Weyland-Yutani PMC (Trauma Surgeon)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_DOCTOR
	rank = JOB_PMC_DOCTOR
	paygrades = list(PAY_SHORT_PMC_DOC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SGN"
	skills = /datum/skills/pmc/doctor

/datum/equipment_preset/pmc/doctor/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_goggles, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/rmc_platemask, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/leader, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/surg_vest/equipped, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/heavy/medic, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/preset, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/wy/full, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)

	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/pmc/backpack, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/surgical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/wy/full_advanced, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pressurized_reagent_canister/oxycodone, WEAR_R_STORE) //surgery

/*****************************************************************************************************/

/datum/equipment_preset/pmc/technician
	name = "Weyland-Yutani PMC (Corporate Technician)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_ENGINEER
	rank = JOB_PMC_ENGINEER
	paygrades = list(PAY_SHORT_PMC_TEC = JOB_PLAYTIME_TIER_0)
	role_comm_title = "TEC"
	skills = /datum/skills/pmc/engineer

/datum/equipment_preset/pmc/technician/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/enclosed/engineer, WEAR_HEAD)

	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, WEAR_IN_HELMET)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/engineer, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/pmc, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/restraint/handcuffs, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/engineer, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presetfour, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/wy/nsg23_pmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding/superior, WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/nsg23/no_lock/pve, WEAR_J_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/ert/pmc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry/wy/mini, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/defenses/handheld/sentry/wy/mini, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/full, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/plasteel/large_stack, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver/tactical, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters/tactical, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wrench, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/largetank, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/cable_coil, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/multitool, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/lightreplacer, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full/wy, WEAR_R_STORE)

/*****************************************************************************************************/

/datum/equipment_preset/pmc/director
	name = "Weyland-Yutani PMC (Corporate Operations Director)"
	flags = EQUIPMENT_PRESET_EXTRA
	languages = ALL_HUMAN_LANGUAGES

	assignment = JOB_PMC_DIRECTOR
	rank = JOB_PMC_DIRECTOR
	paygrades = list(PAY_SHORT_PMC_DIR = JOB_PLAYTIME_TIER_0)
	role_comm_title = "Dir"
	skills = /datum/skills/pmc/director
/datum/equipment_preset/pmc/director/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/pmc/fieldleader, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/lockable, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	var/obj/item/storage/pouch/pistol/command/command_pouch = new(new_human)
	command_pouch.desc = replacetext(command_pouch.desc, "Captains", "corporate PMC directors")
	new_human.equip_to_slot_or_del(command_pouch, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/cotablet/pmc(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large/wy(new_human), WEAR_R_STORE)
	var/obj/item/device/radio/headset/R = new_human.wear_l_ear
	if(istype(R))
		R.volume = RADIO_VOLUME_CRITICAL

//*****************************************************************************************************/

/datum/equipment_preset/pmc/synth
	name = "Weyland-Yutani PMC (Support Synthetic)"
	flags = EQUIPMENT_PRESET_EXTRA

	languages = ALL_SYNTH_LANGUAGES

	skills = /datum/skills/synthetic
	idtype = /obj/item/card/id/pmc
	assignment = JOB_PMC_SYNTH
	rank = JOB_PMC_SYNTH
	paygrades = list(PAY_SHORT_SYN = JOB_PLAYTIME_TIER_0)
	role_comm_title = "WY Syn"

/datum/equipment_preset/pmc/synth/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(50;MALE,50;FEMALE)
	var/datum/preferences/A = new()
	A.randomize_appearance(new_human)
	var/random_name
	if(prob(10))
		random_name = "[capitalize(randomly_generate_japanese_word(rand(2, 3)))]"
	else if(new_human.gender == MALE)
		random_name = "[pick(GLOB.first_names_male_pmc)]"
	else
		random_name = "[pick(GLOB.first_names_female_pmc)]"

	if(new_human.gender == MALE)
		new_human.f_style = "5 O'clock Shadow"

	new_human.change_real_name(new_human, random_name)
	new_human.r_hair = 15
	new_human.g_hair = 15
	new_human.b_hair = 25
	new_human.r_eyes = 139
	new_human.g_eyes = 62
	new_human.b_eyes = 19

/datum/equipment_preset/pmc/synth/load_race(mob/living/carbon/human/new_human)
		new_human.set_species(SYNTH_GEN_THREE)

/datum/equipment_preset/pmc/synth/load_skills(mob/living/carbon/human/new_human)
		new_human.set_skills(/datum/skills/synthetic)
		new_human.allow_gun_usage = FALSE

/datum/equipment_preset/pmc/synth/load_gear(mob/living/carbon/human/new_human)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc, WEAR_BODY)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/surg_vest/equipped, WEAR_ACCESSORY)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/synth/heavy, WEAR_JACKET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/pmc/synth_preset, WEAR_ACCESSORY)

		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/black, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc/platoon/synth, WEAR_L_EAR)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/experimental_mesons, WEAR_EYES)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/leader, WEAR_FACE)

		new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc/black, WEAR_HANDS)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)

		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smartpack/white, WEAR_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/roller, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/roller/surgical, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/tool/crew_monitor/pmc, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul, WEAR_IN_BACK)

		new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/wy/full, WEAR_WAIST)

		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical, WEAR_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver/tactical, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters/tactical, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/wrench, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/stack/cable_coil, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/device/multitool, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/hugetank, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full_barbed_wire/wy, WEAR_R_STORE)

/datum/equipment_preset/pmc/synth/barebones
	name = "Weyland-Yutani PMC (Support Synthetic(Minimally Equipped))"

/datum/equipment_preset/pmc/synth/barebones/load_gear(mob/living/carbon/human/new_human)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc, WEAR_BODY)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/synth, WEAR_JACKET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/experimental_mesons, WEAR_EYES)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc/black, WEAR_HANDS)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smartpack/white, WEAR_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical, WEAR_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/screwdriver/tactical, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters/tactical, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/wrench, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/stack/cable_coil, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/stack/cable_coil, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/device/multitool, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/hugetank, WEAR_IN_L_STORE)

//*****************************************************************************************************/
/datum/equipment_preset/pmc/pmc_detainer
	name = "Weyland-Yutani PMC (Detainer)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_DETAINER
	rank = JOB_PMC_DETAINER
	minimap_icon = "pmc_mp"
	paygrades = list(PAY_SHORT_PMC_EN = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pmc

/datum/equipment_preset/pmc/pmc_detainer/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/guard, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/wy_faction, WEAR_ACCESSORY)
	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/guard, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/light/bulletproof/guard, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/pmc/presetfive, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/guard, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/guard, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/balaclava, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/tactical, WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/pmc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/wy/es4, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert/wy, WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a/corporate/detainer, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy/pmc_m41a, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/zipcuffs/small, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flash, WEAR_IN_BACK)

//*****************************************************************************************************/
/datum/equipment_preset/pmc/pmc_riot_control
	name = "Weyland-Yutani PMC (Crowd Control Specialist)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_CROWD_CONTROL
	rank = JOB_PMC_CROWD_CONTROL
	minimap_icon = "pmc_riot"
	paygrades = list(PAY_SHORT_PMC_EN = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pmc

/datum/equipment_preset/pmc/pmc_riot_control/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/guard, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/wy_faction, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/guard/heavy, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/guard, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/sechud/tactical, WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/pmc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/shotgun/wy, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/slug/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/beanbag/es7, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert/wy, WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/es7/tactical, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/sec/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/zipcuffs/small, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/m15/rubber, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/sebb, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flashbangs, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/telebaton, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/spray/pepper, WEAR_IN_BACK)

//*****************************************************************************************************/
/datum/equipment_preset/pmc/pmc_med_investigator
	name = "Weyland-Yutani PMC (Medical Investigator)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_INVESTIGATOR
	rank = JOB_PMC_INVESTIGATOR
	minimap_icon = "pmc_mi"
	paygrades = list(PAY_SHORT_PMC_MS = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/pmc/medic/chem

/datum/equipment_preset/pmc/pmc_med_investigator/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/guard, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/guard/medic, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/pmc, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/guard, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/wy_faction, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/restraint/handcuffs, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/flashbang, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/m15/rubber, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/pmc, WEAR_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/wy/full, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator, WEAR_IN_BACK)

	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)

	new_human.equip_to_slot_or_del(new /obj/item/device/reagent_scanner, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/elite, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/wy, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy/pmc_m39, WEAR_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/syringe/counteragent, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/sedative, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/advanced/bruise_pack, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/advanced/ointment, WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/roller, WEAR_IN_L_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_BACK)

/datum/equipment_preset/pmc/pmc_med_investigator/get_antag_clothing_equipment()
	return list(
		list("STANDARD EQUIPMENT (TAKE ALL)", 0, null, null, null),
		list("Boots", 0, /obj/item/clothing/shoes/veteran/pmc, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),
		list("Fatigues", 0, /obj/item/clothing/under/marine/veteran/pmc, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Gloves", 0, /obj/item/clothing/gloves/marine/veteran/pmc/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Headset", 0, /obj/item/device/radio/headset/distress/pmc/hvh, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("MRE", 0,  /obj/item/storage/box/mre/pmc, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Combat Pack", 0, /obj/item/storage/backpack/pmc, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("Armored Balaclava", 0, /obj/item/clothing/mask/gas/pmc/balaclava, MARINE_CAN_BUY_MASK, VENDOR_ITEM_MANDATORY),
		list("Tactical Cap", 0, /obj/item/clothing/head/helmet/marine/veteran/pmc, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("Medical HUD Glasses", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_MANDATORY),

		list("ARMOR (CHOOSE 1)", 0, null, null, null),
		list("Standard Armor", 0, /obj/item/clothing/suit/marine/veteran/pmc, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("Light Armor", 0, /obj/item/clothing/suit/marine/veteran/pmc/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("BELT (CHOOSE 1)", 0, null, null, null),
		list("WY-TM402 Pattern Ammo Load Rig", 0, /obj/item/storage/belt/marine/wy, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("WY-TM892 Pattern General Pistol Holster Rig", 0, /obj/item/storage/belt/gun/m4a3/wy, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("WY-TM625 pattern medical bag (Full)", 0, /obj/item/storage/belt/medical/lifesaver/wy/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 M39 Holster Rig", 0, /obj/item/storage/large_holster/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M82F Holster Rig", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 Shotgun Shell Loading Rig", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 M40 Grenade Rig", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Autoinjector Pouch", 0, /obj/item/storage/pouch/autoinjector/full/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Refillable Injectors)", 0, /obj/item/storage/pouch/firstaid/full/black, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", 0, /obj/item/storage/pouch/firstaid/full/alternate/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", 0, /obj/item/storage/pouch/firstaid/full/pills/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch", 0, /obj/item/storage/pouch/first_responder, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large General Pouch", 0, /obj/item/storage/pouch/general/large/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large Magazine Pouch", 0, /obj/item/storage/pouch/magazine/large/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch", 0, /obj/item/storage/pouch/medkit/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Bicaridine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Kelotane)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Revival Mix - Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_tricord, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Revival Mix - Peridaxon)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/revival_peri, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (EMPTY)", 0, /obj/item/storage/pouch/pressurized_reagent_canister, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),

		list("ATTACHMENT (CHOOSE 1)", 0, null, null, null),
		list("Angled Grip", 0, /obj/item/attachable/angledgrip, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Extended Barrel", 0, /obj/item/attachable/extended_barrel, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 0, /obj/item/attachable/lasersight, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Red-Dot Sight", 0, /obj/item/attachable/reddot, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Reflex Sight", 0, /obj/item/attachable/reflex, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Suppressor", 0, /obj/item/attachable/suppressor, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 0, /obj/item/attachable/verticalgrip, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
	)

/datum/equipment_preset/pmc/pmc_med_investigator/get_antag_gear_equipment()
	return list(
		list("MEDIC SET (MANDATORY)", 0, null, null, null),
		list("Essential Medic Set", 0, /obj/effect/essentials_set/medic, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("FIELD SUPPLIES", 0, null, null, null),
		list("Burn Kit", 2, /obj/item/stack/medical/advanced/ointment, null, VENDOR_ITEM_RECOMMENDED),
		list("Trauma Kit", 2, /obj/item/stack/medical/advanced/bruise_pack, null, VENDOR_ITEM_RECOMMENDED),
		list("Medical Splints", 1, /obj/item/stack/medical/splint, null, VENDOR_ITEM_RECOMMENDED),

		list("FIRSTAID KITS", 0, null, null, null),
		list("Advanced Firstaid Kit", 12, /obj/item/storage/firstaid/softpack/adv, null, VENDOR_ITEM_RECOMMENDED),
		list("Firstaid Kit", 5, /obj/item/storage/firstaid/softpack/regular, null, VENDOR_ITEM_REGULAR),
		list("Fire Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/fire, null, VENDOR_ITEM_REGULAR),
		list("Toxin Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/toxin, null, VENDOR_ITEM_REGULAR),
		list("Oxygen Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/o2, null, VENDOR_ITEM_REGULAR),
		list("Radiation Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/rad, null, VENDOR_ITEM_REGULAR),

		list("AUTOINJECTORS", 0, null, null, null),
		list("Autoinjector (Bicaridine)", 1, /obj/item/reagent_container/hypospray/autoinjector/bicaridine, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Dexalin+)", 1, /obj/item/reagent_container/hypospray/autoinjector/dexalinp, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Epinephrine)", 2, /obj/item/reagent_container/hypospray/autoinjector/adrenaline, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Inaprovaline)", 1, /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Kelotane)", 1, /obj/item/reagent_container/hypospray/autoinjector/kelotane, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Oxycodone)", 2, /obj/item/reagent_container/hypospray/autoinjector/oxycodone, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Tramadol)", 1, /obj/item/reagent_container/hypospray/autoinjector/tramadol, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Tricord)", 1, /obj/item/reagent_container/hypospray/autoinjector/tricord, null, VENDOR_ITEM_REGULAR),

		list("PILL BOTTLES", 0, null, null, null),
		list("Pill Bottle (Bicaridine)", 5, /obj/item/storage/pill_bottle/bicaridine, null, VENDOR_ITEM_RECOMMENDED),
		list("Pill Bottle (Dexalin)", 5, /obj/item/storage/pill_bottle/dexalin, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Dylovene)", 5, /obj/item/storage/pill_bottle/antitox, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Inaprovaline)", 5, /obj/item/storage/pill_bottle/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Kelotane)", 5, /obj/item/storage/pill_bottle/kelotane, null, VENDOR_ITEM_RECOMMENDED),
		list("Pill Bottle (Peridaxon)", 5, /obj/item/storage/pill_bottle/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Tramadol)", 5, /obj/item/storage/pill_bottle/tramadol, null, VENDOR_ITEM_RECOMMENDED),

		list("MEDICAL UTILITIES", 0, null, null, null),
		list("Health Diagnostic Equipment", 4, /obj/item/device/healthanalyzer/soul, null, VENDOR_ITEM_REGULAR),
		list("Medical HUD Glasses", 4, /obj/item/clothing/glasses/hud/health, null, VENDOR_ITEM_REGULAR),
		list("Roller Bed", 4, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("Stasis Bag", 6, /obj/item/bodybag/cryobag, null, VENDOR_ITEM_REGULAR),

		list("SPECIAL AMMUNITION", 0, null, null, null), //pmcs can get TWO HEAP magazines, maximum.
		list("M41A HEAP magazine (10x24mm)", 20, /obj/item/ammo_magazine/rifle/heap, null, VENDOR_ITEM_REGULAR),
		list("M39 HEAP magazine (10x20mm)", 20, /obj/item/ammo_magazine/smg/m39/heap, null, VENDOR_ITEM_REGULAR),
		list("NSG23 HEAP magazine (10x24mm)", 20, /obj/item/ammo_magazine/rifle/nsg23/heap, null, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", 0, null, null, null),
		list("Angled Grip", 10, /obj/item/attachable/angledgrip, null, VENDOR_ITEM_REGULAR),
		list("Extended Barrel", 10, /obj/item/attachable/extended_barrel, null, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 10, /obj/item/attachable/lasersight, null, VENDOR_ITEM_REGULAR),
		list("Red-Dot Sight", 10, /obj/item/attachable/reddot, null, VENDOR_ITEM_REGULAR),
		list("Reflex Sight", 10, /obj/item/attachable/reflex, null, VENDOR_ITEM_REGULAR),
		list("Suppressor", 10, /obj/item/attachable/suppressor, null, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 10, /obj/item/attachable/verticalgrip, null, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", 0, null, null, null),
		list("Smoke Grenade", 5, /obj/item/explosive/grenade/smokebomb, null, VENDOR_ITEM_REGULAR),
		list("M12 Blast Grenade", 15, /obj/item/explosive/grenade/high_explosive/pmc, null, VENDOR_ITEM_REGULAR),

		list("UTILITIES", 0, null, null, null),
		list("Small pouch", 10, /obj/item/clothing/accessory/storage/smallpouch/wy, null, VENDOR_ITEM_RECOMMENDED),
		list("Fire Extinguisher (Portable)", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Large General Pouch", 10, /obj/item/storage/pouch/general/large/wy, null, VENDOR_ITEM_REGULAR),
		list("Waist holster", 10, /obj/item/clothing/accessory/storage/holster/waist, null, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", 10, /obj/item/clothing/accessory/storage/droppouch/wy, null, VENDOR_ITEM_REGULAR),
	)

//*****************************************************************************************************/

/datum/equipment_preset/pmc/pmc_lead_investigator
	name = "Weyland-Yutani PMC (Lead Investigator)"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_PMC_LEAD_INVEST
	rank = JOB_PMC_LEAD_INVEST
	paygrades = list(PAY_SHORT_PMC_TL = JOB_PLAYTIME_TIER_0)
	role_comm_title = "SL"
	minimap_icon = "cia_lo"
	skills = /datum/skills/pmc/SL/chem

/datum/equipment_preset/pmc/pmc_lead_investigator/New()
	. = ..()
	access = get_access(ACCESS_LIST_WY_PMC) + list(ACCESS_WY_LEADERSHIP, ACCESS_WY_PMC_TL)

/datum/equipment_preset/pmc/pmc_lead_investigator/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/pmc/guard, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/pmc/leader/guard, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag/pmc/presetsix, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu/guard/lead, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/veteran/pmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc, WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/sensor, WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/wy_faction, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/wy, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/pmc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/plastic, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/pmc, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/wy/vp78, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a/corporate/detainer, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/reagent_scanner, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/wy/pmc_rifle, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/autoinjector/full/wy, WEAR_R_STORE)
