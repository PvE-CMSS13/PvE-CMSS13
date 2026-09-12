// Andro had the right idea, keeping the platoon presets seperate from the general presets

// riflemen
/datum/equipment_preset/uscm/rmc
	name = "Royal Marine Commando, Rifleman"
	paygrades = list(PAY_SHORT_RMC1 = JOB_PLAYTIME_TIER_0)
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)
	role_comm_title = "RM"
	access = list(ACCESS_WY_GENERAL, ACCESS_TWE_COMMANDO)
	faction_group = FACTION_LIST_TWE
	faction = FACTION_TWE
	idtype = /obj/item/card/id/dogtag
	assignment = JOB_TWE_RMC_RIFLEMAN
	rank = JOB_TWE_RMC_RIFLEMAN
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/rmc

/datum/equipment_preset/uscm/rmc/cs
	name = "Royal Marine Commando, Troop Sergeant"
	paygrades = list(PAY_SHORT_RMC4 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM TS"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_FLIGHT, ACCESS_TWE_COMMANDO, ACCESS_TWE_LEADERSHIP, ACCESS_TWE_TLPREP, ACCESS_TWE_ARMORY)
	assignment = JOB_TWE_RMC_TROOPLEADER
	rank = JOB_TWE_RMC_TROOPLEADER
	skills = /datum/skills/rmc/officer

/datum/equipment_preset/uscm/rmc/sl
	name = "Royal Marine Commando, Section Leader"
	paygrades = list(PAY_SHORT_RMC3 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM STL"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_FLIGHT, ACCESS_TWE_COMMANDO, ACCESS_TWE_LEADERSHIP, ACCESS_TWE_TLPREP, ACCESS_TWE_SQUAD_ONE)
	assignment = JOB_TWE_RMC_SECTIONLEADER
	rank = JOB_TWE_RMC_SECTIONLEADER
	skills = /datum/skills/rmc/leader

/datum/equipment_preset/uscm/rmc/tl
	name = "Royal Marine Commando, Team Leader"
	paygrades = list(PAY_SHORT_RMC2 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM TL"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_FLIGHT, ACCESS_TWE_COMMANDO, ACCESS_TWE_LEADERSHIP, ACCESS_TWE_TLPREP, ACCESS_TWE_SQUAD_TWO)
	assignment = JOB_TWE_RMC_TEAMLEADER
	rank = JOB_TWE_RMC_TEAMLEADER
	skills = /datum/skills/rmc/leader

/datum/equipment_preset/uscm/rmc/sg
	name = "Royal Marine Commando, GPMG Gunner"
	paygrades = list(PAY_SHORT_RMC1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM HW(GPMG)"
	access = list(ACCESS_WY_GENERAL, ACCESS_TWE_COMMANDO, ACCESS_TWE_HEVWEAPPREP)
	assignment = JOB_TWE_RMC_SMARTGUNNER
	rank = JOB_TWE_RMC_SMARTGUNNER
	skills = /datum/skills/rmc/smartgun

/datum/equipment_preset/uscm/rmc/med
	name = "Royal Marine Commando, Medical Assistant"
	paygrades = list(PAY_SHORT_RMC2N = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM MA"
	access = list(ACCESS_WY_GENERAL, ACCESS_TWE_MEDICAL, ACCESS_TWE_COMMANDO, ACCESS_TWE_MEDPREP)
	assignment = JOB_TWE_RMC_MEDIC
	rank = JOB_TWE_RMC_MEDIC
	skills = /datum/skills/rmc/medic

/datum/equipment_preset/uscm/rmc/eng
	name = "Royal Marine Commando, Assault Engineer"
	paygrades = list(PAY_SHORT_RMC2E = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM AE"
	access = list(ACCESS_WY_GENERAL, ACCESS_TWE_ENGINEERING, ACCESS_TWE_COMMANDO, ACCESS_TWE_ENGPREP)
	assignment = JOB_TWE_RMC_ENGI
	rank = JOB_TWE_RMC_ENGI
	skills = /datum/skills/rmc/engi

/datum/equipment_preset/uscm/rmc/snp
	name = "Royal Marine Commando, Scout Sniper"
	paygrades = list(PAY_SHORT_RMC1 = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM ScS"
	access = list(ACCESS_WY_GENERAL, ACCESS_TWE_COMMANDO, ACCESS_TWE_SNIPERPREP)
	assignment = JOB_TWE_RMC_MARKSMAN
	rank = JOB_TWE_RMC_MARKSMAN

/datum/equipment_preset/uscm/rmc/mor
	name = "Royal Marine Commando, Bombardment Specialist"
	paygrades = list(PAY_SHORT_RMC2G = JOB_PLAYTIME_TIER_0)
	role_comm_title = "RM HW(BMBRD)"
	access = list(ACCESS_WY_GENERAL, ACCESS_TWE_COMMANDO, ACCESS_TWE_HEVWEAPPREP)
	assignment = JOB_TWE_RMC_BREACHER
	rank = JOB_TWE_RMC_BREACHER
