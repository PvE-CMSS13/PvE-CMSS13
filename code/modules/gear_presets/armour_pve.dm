// Andro had the right idea, keeping the platoon presets seperate from the general presets

/datum/equipment_preset/uscm/armour
	name = "USCM Armor, Vehicle Driver"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "DRVR"
	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_ARMOUR_DRIVER
	rank = JOB_SQUAD_ARMOUR_DRIVER
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/vehicle_crew
	minimap_icon = "vc"

/datum/equipment_preset/uscm/armour/gunner
	name = "USCM Armor, Vehicle Gunner"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "GNNR"
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_ARMOUR_GUNNER
	rank = JOB_SQUAD_ARMOUR_GUNNER
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/vehicle_crew/gunner

/datum/equipment_preset/uscm/armour/leader
	name = "USCM Armor, Element Sergeant"
	paygrades = list(PAY_SHORT_ME6 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "ElmntSgt"
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_ARMOUR_LEADER
	rank = JOB_SQUAD_ARMOUR_LEADER
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/vehicle_crew/commander

/datum/equipment_preset/uscm/upp/armour
	name = "UPP Armour, Hardware Driver"
	paygrades = list(PAY_SHORT_UE3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "DRVR"
	access = list(ACCESS_UPP_GENERAL)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP
	assignment = JOB_SQUAD_ARMOUR_DRIVER_UPP
	rank = JOB_SQUAD_ARMOUR_DRIVER_UPP
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/vehicle_crew
	minimap_icon = "vc"

/datum/equipment_preset/uscm/upp/armour/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/upp/armour/gunner
	name = "UPP Armour, Hardware Gunner"
	paygrades = list(PAY_SHORT_UE4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "GNNR"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_TLPREP)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_CHINESE)
	assignment = JOB_SQUAD_ARMOUR_GUNNER_UPP
	rank = JOB_SQUAD_ARMOUR_GUNNER_UPP
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/vehicle_crew/gunner

/datum/equipment_preset/uscm/upp/armour/gunner/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"

/datum/equipment_preset/uscm/upp/armour/leader
	name = "UPP Armor, Group Sergeant"
	paygrades = list(PAY_SHORT_UE6 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "GrpSgt"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_LEADERSHIP, ACCESS_UPP_FLIGHT)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH, LANGUAGE_CHINESE)
	assignment = JOB_SQUAD_ARMOUR_LEADER_UPP
	rank = JOB_SQUAD_ARMOUR_LEADER_UPP
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/vehicle_crew/commander

/datum/equipment_preset/uscm/upp/armour/leader/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"
