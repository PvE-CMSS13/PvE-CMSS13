/datum/equipment_preset/uacg
	name = "UACG"
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH)
	///Gives the soldiers their radios
	var/headset_type = /obj/item/device/radio/headset/almayer/marine/solardevils/uacg
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/load_name(mob/living/carbon/human/new_human, randomise)
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
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right", "Bun")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/uacg/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_VERYLOW

/datum/equipment_preset/uacg/load_gear(mob/living/carbon/human/new_human)

	new_human.undershirt = "undershirt"
	//head
	var/maybecap = rand(1,4)
	switch(maybecap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki, WEAR_HEAD)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/khaki/snow, WEAR_HEAD)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/royal_marine/uacg, WEAR_HEAD)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/uacg, WEAR_HEAD)
	//uniform
	var/maybearmor = rand(1,2)
	switch(maybearmor)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/white, WEAR_BODY)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usa, WEAR_ACCESSORY)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/knife, WEAR_FEET)
	add_worker_gloves(new_human)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/rifle
	name = "US Colonial Guardsman"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guardsman"
	rank = JOB_UACG_RIFLE
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/trooper
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/rifle/corporal
	name = parent_type::name + " (E4E Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_AE1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/security
	name = "Rear Line US Colonial Guardsman"
	rank = JOB_UACG_SCR_RIFLE
	assignment = "Rear Line Colonial Guardsman"

/datum/equipment_preset/uacg/rifle/security/corporal
	name = parent_type::name + " (E4E Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/security/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/security/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_AE1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/armory
	name = "US Colonial Guard Weapons Technincian"
	rank = JOB_UACG_ARMORY_LACKEY
	assignment = "Colonial Guard Weapons Technincian"

/datum/equipment_preset/uacg/rifle/armory/corporal
	name = parent_type::name + " (E4E Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/armory/lance_corporal
	name = parent_type::name + " (E3 Rank)"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/rifle/armory/private
	name = parent_type::name + " (E1 Rank)"
	paygrades = list(PAY_SHORT_AE1 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/marksman
	name = "US Colonial Guards (Marksman)"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guards Marksman"
	rank = JOB_UACG_DM
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/trooper
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/marksman/lance_corporal
	name = parent_type::name + " (E4E Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/marksman/private
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/gunner
	name = "US Colonial Guardsman (Machine Gunner)"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guard Machine Gunner"
	rank = JOB_UACG_GNR
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/trooper
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/gunner/lance_corporal
	name = parent_type::name + " (E4E Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/gunner/private
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/gunner/security
	name = "Rear Line US Colonial Guardsman (Machine Gunner)"
	rank = JOB_UACG_SCR_GNR

/datum/equipment_preset/uacg/gunner/security/lance_corporal
	name = parent_type::name + " (E4E Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/gunner/security/private
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE1 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/tech
	name = "US Colonial Guardsman Technician"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guardsman Technician"
	rank = JOB_UACG_TECH
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/mainttech
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/tech/greater_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/tech/lesser_rank
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/tech/mortar
	name = "US Colonial Guard Mortarman"
	assignment = "Colonial Guard Mortarman"
	rank = JOB_UACG_MORTAR
	skills = /datum/skills/combat_engineer
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/tech/mortar/greater_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/tech/mortar/lesser_rank
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/medic
	name = "US Colonial Guardsman Medic"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guardsman Medic"
	rank = JOB_UACG_MEDIC
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/medic
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/medic/greater_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/medic/lesser_rank
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/medic/triage
	name = "US Colonial Guardsman Triage Medic"
	assignment = "Colonial Guardsman Triage Medic"
	rank = JOB_UACG_MEDIC_TRIAGE
	skills = /datum/skills/medic
	paygrades = list(PAY_SHORT_AE3 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/medic/triage/greater_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4E = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/medic/triage/lesser_rank
	name = parent_type::name + " (E2 Rank)"
	paygrades = list(PAY_SHORT_AE2 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/leader
	name = "US Colonial Guard Unit Leader"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guardsman Unit Leader"
	rank = JOB_UACG_LEAD
	role_comm_title = "UACG-L"
	paygrades = list(PAY_SHORT_AE5 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/nco
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/leader/lesser_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/leader/triage
	name = "US Colonial Guard Triage Leader"
	assignment = "Colonial Guardsman Triage Leader"
	rank = JOB_UACG_LEAD_MED

/datum/equipment_preset/uacg/leader/triage/lesser_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/leader/fires
	name = "US Colonial Guard Fires Leader"
	assignment = "Colonial Guardsman Fires Leader"
	rank = JOB_UACG_LEAD_FIRE

/datum/equipment_preset/uacg/leader/fires/lesser_rank
	name = parent_type::name + " (E4 Rank)"
	paygrades = list(PAY_SHORT_AE4 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/senleader
	name = "US Colonial Guard Senior Leader"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guardsman Senior Leader"
	rank = JOB_UACG_SENLEAD
	role_comm_title = "UACG-SL"
	paygrades = list(PAY_SHORT_AE7 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/snco
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/senleader/greater_rank
	name = parent_type::name + " (E8 Rank)"
	paygrades = list(PAY_SHORT_AE8 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/senleader/armorer
	name = "US Colonial Guard Armorer"
	assignment = "Colonial Guardsman Armorer"
	rank = JOB_UACG_ARMORY
	paygrades = list(PAY_SHORT_AE7 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/senleader/armorer/greater_rank
	name = parent_type::name + " (E8 Rank)"
	paygrades = list(PAY_SHORT_AE8 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/senleader/armorer/even_greater_rank
	name = parent_type::name + " (E9 Rank)"
	paygrades = list(PAY_SHORT_AE9 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/senleader/chaplain
	name = "US Colonial Guard Chaplain"
	assignment = "Colonial Guardsman Chaplain"
	rank = JOB_UACG_CHAPLAIN
	paygrades = list(PAY_SHORT_AE9C = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/senleader/chaplain/greater_rank
	name = parent_type::name + " (WO1 Rank)"
	paygrades = list(PAY_SHORT_AW1 = JOB_PLAYTIME_TIER_0)

//*****************************************************************************************************/

/datum/equipment_preset/uacg/officer
	name = "US Colonial Guard Officer"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UACG
	faction_group = FACTION_LIST_UA_COLONY
	assignment = "Colonial Guardsman Officer"
	rank = JOB_UACG_OFFICER
	role_comm_title = "UACG"
	paygrades = list(PAY_SHORT_AO2 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/lt
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_UACG, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_COMMAND, ACCESS_MARINE_PREP)
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/officer/lesser_rank
	name = parent_type::name + " (O1 Rank)"
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/uacg/officer/doctor
	name = "US Colonial Guard Doctor"
	assignment = "Colonial Guardsman Doctor"
	rank = JOB_UACG_DOCTOR
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/doctor
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/officer/messofficer
	name = "US Colonial Guard Mess Officer"
	assignment = "Colonial Guardsman Mess Officer"
	rank = JOB_UACG_MESS
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)
	skills = /datum/skills/lt
	idtype = /obj/item/card/id/dogtag

/datum/equipment_preset/uacg/messofficer/lesser_rank
	name = parent_type::name + " (O1 Rank)"
	paygrades = list(PAY_SHORT_AO1 = JOB_PLAYTIME_TIER_0)
