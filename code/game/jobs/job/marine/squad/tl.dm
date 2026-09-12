#define SSGT_VARIANT "Staff Sergeant"
#define SGT_VARIANT "Sergeant"
#define CPL_VARIANT "Corporal"
#define JSGT_VARIANT "Junior Sergeant"

/datum/job/marine/tl
	title = JOB_SQUAD_TEAM_LEADER
	total_positions = 8
	spawn_positions = 8
	allow_additional = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/tl
	gear_preset_secondary = /datum/equipment_preset/uscm/tl/corporal
	entry_message_body = "You are the <a href='"+WIKI_PLACEHOLDER+"'>Squad Leader.</a> Your task is leading the designated squad and utilize available ordnance. If the section sergeant dies, you are expected to lead in their place.<br><b>You remember that you've stored your personal gear and uniform are located in the dorm or locker rooms.</b>"

	job_options = list(CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/datum/job/marine/tl/generate_entry_conditions(mob/living/carbon/human/spawning_human)
	. = ..()
	spawning_human.important_radio_channels += JTAC_FREQ

/datum/job/marine/tl/handle_job_options(option)
	if(option != CPL_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/tl
	name = JOB_SQUAD_TEAM_LEADER
	icon_state = "tl_spawn"
	job = /datum/job/marine/tl

/obj/effect/landmark/start/marine/tl/alpha
	icon_state = "tl_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/tl/bravo
	icon_state = "tl_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/tl/charlie
	icon_state = "tl_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/tl/delta
	icon_state = "tl_spawn_delta"
	squad = SQUAD_MARINE_4

/datum/job/marine/tl/ai
	total_positions = 2
	spawn_positions = 2

/datum/job/marine/tl/ai/upp
	title = JOB_SQUAD_TEAM_LEADER_UPP
	gear_preset = /datum/equipment_preset/uscm/tl/upp
	gear_preset_secondary = /datum/equipment_preset/uscm/tl/upp/junior_sergeant
	job_options = list(JSGT_VARIANT = "JrSGT", SGT_VARIANT = "SGT")

/datum/job/marine/tl/ai/upp/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == JSGT_VARIANT)
		gear_preset = gear_preset_secondary

/datum/job/marine/tl/ai/forecon
	total_positions = 1
	spawn_positions = 1
	title = JOB_SQUAD_TEAM_LEADER_FORECON
	gear_preset = /datum/equipment_preset/uscm/tl/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/tl/forecon/sergeant
	job_options = list(SGT_VARIANT = "SGT", SSGT_VARIANT = "SSGT")

/datum/job/marine/tl/ai/forecon/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == SGT_VARIANT)
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/tl/upp
	name = JOB_SQUAD_TEAM_LEADER_UPP
	squad = SQUAD_UPP
	job = /datum/job/marine/tl/ai/upp


/datum/job/marine/tl/ai/pmc
	title = JOB_PMCPLAT_FTL
	gear_preset = /datum/equipment_preset/uscm/pmc/tl
	job_options = null

/obj/effect/landmark/start/marine/tl/pmc
	name = JOB_PMCPLAT_FTL
	squad = SQUAD_PMCPLT
	job = /datum/job/marine/tl/ai/pmc

/datum/job/marine/tl/ai/pmc/small
	title = JOB_PMCPLAT_SMALL_FTL
	gear_preset = /datum/equipment_preset/uscm/pmc/tl
	job_options = null
	total_positions = 1
	spawn_positions = 1

/obj/effect/landmark/start/marine/tl/pmc/small
	name = JOB_PMCPLAT_SMALL_FTL
	squad = SQUAD_PMCPLT_SMALL
	job = /datum/job/marine/tl/ai/pmc/small

/obj/effect/landmark/start/marine/tl/forecon
	name = JOB_SQUAD_TEAM_LEADER_FORECON
	squad = SQUAD_LRRP
	job = /datum/job/marine/tl/ai/forecon

//-- RMC Platoon --//
//Section/squad leader & team leader//

/datum/job/marine/tl/ai/rmc
	total_positions = 1
	spawn_positions = 1
	title = JOB_TWE_RMC_SECTIONLEADER
	gear_preset = /datum/equipment_preset/uscm/rmc/sl
	job_options = null
	supervisors = "the troop commander and troop sergeant"
	entry_message_body = "You are the Section Leader for a Rifle Section of Royal Marines Commando. Your task is leading the Rifle Section, utilize available ordnance and detach the Fire-Support Team of your Section as needed.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your equipment can be located in the armoury.</b>"

/obj/effect/landmark/start/marine/tl/rmc
	name = JOB_TWE_RMC_SECTIONLEADER
	squad = SQUAD_RMC
	job = /datum/job/marine/tl/ai/rmc

/datum/job/marine/tl/ai/rmc2ic
	total_positions = 1
	spawn_positions = 1
	title = JOB_TWE_RMC_TEAMLEADER
	gear_preset = /datum/equipment_preset/uscm/rmc/tl
	job_options = null
	supervisors = "the section leader and troop commander"
	entry_message_body = "You are the Team Leader for a Fire Support Team of Royal Marines Commando weapons specialists. Your task is coordinating the available ordnance your team is able to bring to bear. You may be expected to lead the Rifle Section should the Section Leader die.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms.</b>"

/obj/effect/landmark/start/marine/tl/rmc2ic
	name = JOB_TWE_RMC_TEAMLEADER
	squad = SQUAD_RMC
	job = /datum/job/marine/tl/ai/rmc2ic

/datum/job/marine/tl/ai/uacg
	total_positions = 8
	spawn_positions = 8
	title = JOB_UACG_LEAD
	gear_preset = /datum/equipment_preset/uacg/leader/lesser_rank
	gear_preset_secondary = /datum/equipment_preset/uacg/leader
	job_options = null
	supervisors = "the officer and senior leader"
	entry_message_body = "You are a unit leader of the United Americas Colonial Guard and are the equivocal to a squad leader in the active forces. You are expected to coordinate the maneuver and weapons elements of your unit, even if most deployments never involve having an OpFor and are just disaster recovery.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your lethal equipment can be requisitioned from the armory.</b>"
	job_options = list(CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/datum/job/marine/tl/ai/uacg/handle_job_options(option)
	if(option != CPL_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/tl/uacg
	name = JOB_UACG_LEAD
	job = /datum/job/marine/tl/ai/uacg

/datum/job/marine/tl/ai/uacg/fires
	total_positions = 1
	spawn_positions = 1
	title = JOB_UACG_LEAD_FIRE
	gear_preset = /datum/equipment_preset/uacg/leader/fires/lesser_rank
	gear_preset_secondary = /datum/equipment_preset/uacg/leader/fires
	supervisors = "the officer"
	entry_message_body = "You are a unit leader of the United Americas Colonial Guard and are the equivocal to a squad leader in the active forces. You are expected to coordinate the fires unit you have been charged to lead, even if most deployments never involve having an OpFor and are just disaster recovery.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your lethal equipment can be requisitioned from the armory.</b>"
	job_options = list(CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/datum/job/marine/tl/ai/uacg/fires/handle_job_options(option)
	if(option != CPL_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/tl/uacg/fires
	name = JOB_UACG_LEAD_FIRE
	squad = SQUAD_MILITIA_3
	job = /datum/job/marine/tl/ai/uacg/fires

/datum/job/marine/tl/ai/uacg/triage
	total_positions = 1
	spawn_positions = 1
	title = JOB_UACG_LEAD_MED
	gear_preset = /datum/equipment_preset/uacg/leader/triage/lesser_rank
	gear_preset_secondary = /datum/equipment_preset/uacg/leader/triage
	supervisors = "the doctor and unit commander"
	entry_message_body = "You are a unit leader of the United Americas Colonial Guard and are the equivocal to a squad leader in the active forces. You are expected to coordinate the medical unit you have been charged to lead, even if most deployments never involve having an OpFor and are just disaster recovery.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your equipment can be requisitioned from the armory.</b>"
	job_options = list(CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/datum/job/marine/tl/ai/uacg/triage/handle_job_options(option)
	if(option != CPL_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/tl/uacg/triage
	name = JOB_UACG_LEAD_MED
	squad = SQUAD_MILITIA_4
	job = /datum/job/marine/tl/ai/uacg/triage

#undef SSGT_VARIANT
#undef SGT_VARIANT
#undef CPL_VARIANT
#undef JSGT_VARIANT
