// new file - don't wanna cram this in with other pmc's, feels bloaty

// riflemen
/datum/equipment_preset/uscm/pmc
	name = "Tactical Unit"
	paygrade = "PMC"
	access = list(ACCESS_WY_GENERAL)
	languages = list(LANGUAGE_JAPANESE, LANGUAGE_ENGLISH)
	faction_group = list(FACTION_LIST_WY)
	faction = FACTION_PMC
	idtype = /obj/item/card/id/pmc
	assignment = JOB_PMC_STANDARD
	rank = JOB_SQUAD_MARINE
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/pfc

/datum/equipment_preset/uscm/pmc/sl
	name = "Operation Leader"
	paygrade = "PMC-TL"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_SENIOR_LEAD, ACCESS_WY_ARMORY)
	assignment = JOB_PMC_LEADER
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_LEADER
	skills = /datum/skills/general

/datum/equipment_preset/uscm/pmc/tl
	name = "Team Leader"
	paygrade = "PMC-OP"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_ARMORY)
	assignment = JOB_PMC_LEADER
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_TEAM_LEADER
	skills = /datum/skills/pmc/specialist

/datum/equipment_preset/uscm/pmc/sg
	name = "Heavy Weapons Specialist"
	paygrade = "PMC-WS"
	access = list(ACCESS_WY_GENERAL,ACCESS_WY_ENGINEERING)
	assignment = JOB_PMC_GUNNER
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_SMARTGUN
	skills = /datum/skills/smartgunner

/datum/equipment_preset/uscm/pmc/med
	name = "Medical Specialist"
	paygrade = "PMC-MS"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_MEDICAL)
	assignment = JOB_PMCPLAT_MEDIC
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_MEDIC
	skills = /datum/skills/combat_medic
