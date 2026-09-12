
/datum/equipment_preset/corpse
	name = "Corpse"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_COLONIST
	rank = JOB_COLONIST
	faction = FACTION_COLONIST
	languages = list()
	access = list(ACCESS_CIVILIAN_PUBLIC)
	skills = /datum/skills/civilian
	idtype = /obj/item/card/id/lanyard
	var/xenovictim = FALSE //Set to true to make the corpse spawn as a victim of a xeno burst

/datum/equipment_preset/corpse/load_languages(mob/living/carbon/human/new_human)
	return

/datum/equipment_preset/corpse/load_status(mob/living/carbon/human/new_human)
	. = ..(new_human)

	// These two values matter because they are checked on death for weed_food
	new_human.undefibbable = TRUE
	if(xenovictim)
		new_human.chestburst = 2

	new_human.death(create_cause_data("existing"), TRUE) //Kills the new mob
	new_human.apply_damage(100, BRUTE)
	new_human.apply_damage(100, BRUTE)
	new_human.apply_damage(100, BRUTE)
	if(xenovictim)
		var/datum/internal_organ/organ
		var/i
		for(i in list("heart","lungs"))
			organ = new_human.internal_organs_by_name[i]
			new_human.internal_organs_by_name -= i
			new_human.internal_organs -= organ
		new_human.update_burst()
		//buckle to nest
		var/obj/structure/bed/nest/nest = locate() in get_turf(src)
		if(nest)
			new_human.buckled = nest
			new_human.setDir(nest.dir)
			nest.buckled_mob = new_human
			nest.afterbuckle(new_human)
	new_human.spawned_corpse = TRUE
	new_human.updatehealth()
	new_human.pulse = PULSE_NONE

/datum/equipment_preset/corpse/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(50;MALE,50;FEMALE)
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
		new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Undercut, Top", "CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right", "Scully", "Pvt. Redding", "Bun", "Short Bangs")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,40)

//*****************************************************************************************************/
// Civilians

/datum/equipment_preset/corpse/bluecollar
	name = "Corpse - Blue-Collar"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/corpse/bluecollar/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Class D Inhabitant"

	return "Class C Inhabitant"

/datum/equipment_preset/corpse/bluecollar/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	add_civilian_jacket(new_human)
	//limbs
	add_civilian_shoe(new_human)

/datum/equipment_preset/corpse/bluecollar/burst
	name = "Corpse - Blue-Collar (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/whitecollar
	name = "Corpse - White-Collar"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian
	access = list(ACCESS_CIVILIAN_PUBLIC)

/datum/equipment_preset/corpse/whitecollar/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Class B Inhabitant"

	return "Class A Inhabitant"

/datum/equipment_preset/corpse/whitecollar/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//back
	add_random_satchel(new_human)
	//outfit
	add_business_outfit(new_human)
	var/random_tie = rand(1,2)
	switch(random_tie)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)

/datum/equipment_preset/corpse/whitecollar/burst
	name = "Corpse - White-Collar (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/researcher
	name = "Corpse - Researcher"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Research Associate"
	paygrades = list(PAY_SHORT_CCMO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/researcher
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_WY_GENERAL, ACCESS_WY_COLONIAL, ACCESS_WY_RESEARCH)

/datum/equipment_preset/corpse/researcher/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_professionalwear(new_human)
	var/random_tie= rand(1,5)
	switch(random_tie)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/green(new_human), WEAR_ACCESSORY)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/purple(new_human), WEAR_ACCESSORY)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/red(new_human), WEAR_ACCESSORY)
	//jacket
	var/random_researcher_suit = rand(1,5)
	switch(random_researcher_suit)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat(new_human), WEAR_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/tan(new_human), WEAR_JACKET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest(new_human), WEAR_JACKET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/grey(new_human), WEAR_JACKET)
	//limb
	add_dress_shoes(new_human)

/datum/equipment_preset/corpse/researcher/burst
	name = "Corpse - Researcher (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/doctor
	name = "Corpse - Doctor"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Medical Doctor"
	paygrades = list(PAY_SHORT_CDOC = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/doctor
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_MEDBAY)

/datum/equipment_preset/corpse/doctor/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_professionalwear(new_human)
	add_tie(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat(new_human), WEAR_JACKET)
	//limb
	add_dress_shoes(new_human)

/datum/equipment_preset/corpse/doctor/burst
	name = "Corpse - Doctor (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/doctor/scrubs
	name = "Corpse - Doctor, Scrubs"

/datum/equipment_preset/corpse/doctor/scrubs/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/blue(new_human), WEAR_BACK)
	//uniform
	var/random_scrubs= rand(1,4)
	switch(random_scrubs)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/green(new_human), WEAR_BODY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/blue(new_human), WEAR_BODY)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/purple(new_human), WEAR_BODY)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/medical/lightblue(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/stethoscope(new_human), WEAR_ACCESSORY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)

/datum/equipment_preset/corpse/doctor/scrubs/burst
	name = "Corpse - Doctor, Scrubs (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/prisoner
	name = "Corpse - Prisoner"
	faction = FACTION_COLONIST
	assignment = "Inmate"
	access = list(null)
	idtype = /obj/item/card/id

/datum/equipment_preset/corpse/prisoner/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/prison_boiler(new_human), WEAR_BODY)
	//limb
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)

/datum/equipment_preset/corpse/prisoner/burst
	name = "Corpse - Prisoner (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/guard
	name = "Corpse - Security Guard, Prison"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Corrections Officer"
	paygrades = list(PAY_SHORT_CPO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/marshal
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND)

/datum/equipment_preset/corpse/guard/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/darkblue, WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3, WEAR_IN_R_STORE)

/datum/equipment_preset/corpse/guard/burst
	name = "Corpse - Security Guard, Prison (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/riot
	name = "Corpse - Security Guard, UA Colonial Guard"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Colonial Militiaman"
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/marshal
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/corpse/riot/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//head
	var/maybecap = rand(1,3)
	switch(maybecap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_IN_BACK)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e2, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	add_worker_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3, WEAR_IN_R_STORE)

/datum/equipment_preset/corpse/riot/burst
	name = "Corpse - Security Guard, UA Colonial Guard (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/security
	name = "Corpse - Security Guard, Wey-Yu"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_COLONIST
	assignment = "Weyland-Yutani Corporate Security Officer"
	paygrades = list(PAY_SHORT_CPO = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/civilian/survivor/marshal
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_WY_SECURITY)

/datum/equipment_preset/corpse/security/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70, WEAR_IN_R_STORE)

/datum/equipment_preset/corpse/security/burst
	name = "Corpse - Security Guard, Wey-Yu (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/cmb
	name = "Corpse - Colonial Marshals Deputy"
	paygrades = list(PAY_SHORT_CMBD = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CMB DEP"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Office of Colonial Marshals Deputy"
	rank = JOB_CMB
	skills = /datum/skills/cmb

/datum/equipment_preset/corpse/cmb/load_gear(mob/living/carbon/human/new_human)

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full/revolver, WEAR_WAIST)

/datum/equipment_preset/corpse/cmb/burst
	name = "Corpse - Colonial Marshals Deputy (Burst)"
	xenovictim = TRUE

//*****************************************************************************************************/
//UPP

/datum/equipment_preset/corpse/upp/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(60;MALE,40;FEMALE)
	var/datum/preferences/A = new()
	A.randomize_appearance(new_human)
	var/random_name
	var/first_name
	var/last_name
	//gender checks
	if(new_human.gender == MALE)
		if(prob(40))
			first_name = "[capitalize(randomly_generate_chinese_word(1))]"
		else
			first_name = "[pick(GLOB.first_names_male_upp)]"
		new_human.f_style = pick("3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache")
	else
		if(prob(40))
			first_name = "[capitalize(randomly_generate_chinese_word(1))]"
		else
			first_name = "[pick(GLOB.first_names_female_upp)]"
	//surname
	if(prob(35))
		last_name = "[capitalize(randomly_generate_chinese_word(pick(20;1, 80;2)))]"
	else
		last_name = "[pick(GLOB.last_names_upp)]"
	//put them together
	random_name = "[first_name] [last_name]"

	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(17,35)
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
		new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Undercut, Top", "CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right", "Scully", "Pvt. Redding", "Bun", "Short Bangs")

/datum/equipment_preset/corpse/upp
	name = "Corpse - UPP Squad Rifleman"
	faction = FACTION_UPP
	assignment = JOB_SQUAD_MARINE
	role_comm_title = "RFN"
	rank = JOB_SQUAD_MARINE
	paygrades = list(PAY_SHORT_UE1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_UE2 = JOB_PLAYTIME_TIER_1)
	skills = /datum/skills/pfc
	access = list(ACCESS_UPP_GENERAL)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/corpse/upp/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP, WEAR_L_EAR)
	//head
	var/maybeberet = rand(1,3)
	switch(maybeberet)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp, WEAR_HEAD)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/alt, WEAR_HEAD)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/beret/naval, WEAR_HEAD)
	//uniform
	var/obj/item/clothing/under/marine/veteran/UPP/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp/naval, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid, WEAR_L_STORE)

/datum/equipment_preset/corpse/upp/burst
	name = "Corpse - UPP Squad Rifleman (Burst)"
	xenovictim = TRUE

//*****************************************************************************************************/
//TWE

/datum/equipment_preset/corpse/royal_marine
	name = "Corpse - TWE Squad Rifleman"
	paygrades = list(PAY_SHORT_RMC1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RMC"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Royal Marines Rifleman"
	rank = JOB_TWE_RMC_RIFLEMAN
	skills = /datum/skills/rmc

/datum/equipment_preset/corpse/royal_marine/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/royal_marine, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/royal_marine, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/royal_marine, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/royal_marine, WEAR_IN_ACCESSORY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/royal_marine, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc/nsg, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/rmc/light, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

/datum/equipment_preset/corpse/royal_marine/burst
	name = "Corpse - TWE Squad Rifleman (Burst)"
	xenovictim = TRUE

//*****************************************************************************************************/
//USCM

/datum/equipment_preset/corpse/uscm
	name = "Corpse - USCM Squad Rifleman"
	flags = EQUIPMENT_PRESET_EXTRA
	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrades = list(PAY_SHORT_ME1 = JOB_PLAYTIME_TIER_0, PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_1, PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_3)
	role_comm_title = "RFN"
	skills = /datum/skills/pfc
	minimap_icon = "private"

/datum/equipment_preset/corpse/uscm/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/corpse/uscm/burst
	name = "Corpse - USCM Squad Rifleman (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/uscm_dp
	name = "Corpse - USCM Dropship Pilot"
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_EXTRA
	access = list(ACCESS_MARINE_COMMAND, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PREP)
	assignment = JOB_DROPSHIP_PILOT
	rank = JOB_DROPSHIP_PILOT
	paygrades = list(PAY_SHORT_MO1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "PLT"
	skills = /datum/skills/pilot
	minimap_icon = "pilot"

/datum/equipment_preset/corpse/uscm_dp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp/marinepilot(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/boiler(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/pilot(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp70(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

/datum/equipment_preset/corpse/uscm_dp/burst
	name = "Corpse - USCM Dropship Pilot (Burst)"
	xenovictim = TRUE

/datum/equipment_preset/corpse/uscm_unequipped	//Used for POWs
	name = "USCM Squad Rifleman"
	idtype = /obj/item/card/id/dogtag
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrades = list(PAY_SHORT_ME2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"
	dress_under = list(/obj/item/clothing/under/marine/dress/blues)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues)

/datum/equipment_preset/corpse/uscm_unequipped/burst
	name = "Corpse - Unequipped USCM Squad Rifleman (Burst)"
	xenovictim = TRUE


//*****************************************************************************************************/
//Freelancer

/datum/equipment_preset/corpse/freelancer
	name = "Corpse - Freelancer"
	paygrades = list(PAY_SHORT_FL_S = JOB_PLAYTIME_TIER_0)
	rank = FACTION_FREELANCER
	idtype = /obj/item/card/id/data
	faction = FACTION_FREELANCER

/datum/equipment_preset/corpse/freelancer/New()
	. = ..()
	access = get_access(ACCESS_LIST_EMERGENCY_RESPONSE) + get_access(ACCESS_LIST_COLONIAL_ALL)

/datum/equipment_preset/corpse/freelancer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/freelancer, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/faction/freelancer, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_L_STORE)
	add_merc_helmet(new_human)

/datum/equipment_preset/corpse/freelancer/burst
	name = "Corpse - Freelancer (Burst)"
	xenovictim = TRUE

//*****************************************************************************************************/
//FORECON

/datum/equipment_preset/corpse/forecon_spotter
	name = "Corpse - USCM Reconnaissance Spotter"
	assignment = "Reconnaissance Spotter"
	xenovictim = FALSE
	paygrades = list(PAY_SHORT_ME5 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag
	role_comm_title = "FORECON"
	faction_group = list(FACTION_MARINE, FACTION_SURVIVOR)
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
	)

/datum/equipment_preset/corpse/forecon_spotter/load_gear(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/reconnaissance/uniform = new()
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	var/obj/item/clothing/accessory/ranks/marine/e5/pin = new()
	var/obj/item/clothing/accessory/patch/patch_uscm = new()
	var/obj/item/clothing/accessory/patch/forecon/patch_forecon = new()
	uniform.attach_accessory(new_human,pouch)
	uniform.attach_accessory(new_human,patch_uscm)
	uniform.attach_accessory(new_human,pin)
	uniform.attach_accessory(new_human,patch_forecon)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/webbing(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/facepaint/sniper(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio(new_human), WEAR_IN_BACK)
