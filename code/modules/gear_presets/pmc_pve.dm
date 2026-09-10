// new file - don't wanna cram this in with other pmc's, feels bloaty

// riflemen
/datum/equipment_preset/uscm/pmc
	name = "Tactical Unit"
	paygrades = list("PMC-OP" = JOB_PLAYTIME_TIER_0)
	role_comm_title = "TU"
	access = list(ACCESS_WY_GENERAL)
	faction_group = FACTION_LIST_WY
	faction = FACTION_PMC
	idtype = /obj/item/card/id/pmc
	assignment = JOB_PMCPLAT_STANDARD
	rank = JOB_SQUAD_MARINE
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/pfc

/datum/equipment_preset/uscm/pmc/sl
	name = "Field Operation Leader"
	paygrades = list("PMC-FOL" = JOB_PLAYTIME_TIER_0)
	role_comm_title = "FOL"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_SENIOR_LEAD, ACCESS_WY_ARMORY)
	assignment = JOB_PMCPLAT_LEADER
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_LEADER
	skills = /datum/skills/pmc/director

/datum/equipment_preset/uscm/pmc/tl
	name = "Team Leader"
	paygrades = list("PMC-TL" = JOB_PLAYTIME_TIER_0)
	role_comm_title = "TL"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_PMC_TL)
	assignment = JOB_PMCPLAT_FTL
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_TEAM_LEADER
	skills = /datum/skills/pmc/SL

/datum/equipment_preset/uscm/pmc/sg
	name = "Heavy Weapons Specialist"
	paygrades = list("PMC-WS" = JOB_PLAYTIME_TIER_0)
	role_comm_title = "HWS"
	access = list(ACCESS_WY_GENERAL, ACCESS_PMC_GUNNER)
	assignment = JOB_PMCPLAT_SG
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_SMARTGUN
	skills = /datum/skills/smartgunner

/datum/equipment_preset/uscm/pmc/med
	name = "Medical Specialist"
	paygrades = list("PMC-MS" = JOB_PLAYTIME_TIER_0)
	role_comm_title = "MS"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_MEDICAL)
	assignment = JOB_PMCPLAT_MEDIC
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_MEDIC
	skills = /datum/skills/combat_medic_pve
