#define WO1_VARIANT "Warrant Officer First Class"
#define CMDSGTMJR_VARIANT "Command Sergeant Major"
#define MSSGT_VARIANT "Master Sergeant"
#define SFC_VARIANT "Sergeant First Class"
#define GYSGT_VARIANT "Gunnery Sergeant"
#define SGTMJR_VARIANT "Sergeant Major"
#define SSGT_VARIANT "Staff Sergeant"
#define SRSGT_VARIANT "Senior Sergeant"

/datum/job/marine/leader
	title = JOB_SQUAD_LEADER
	total_positions = 4
	spawn_positions = 4
	supervisors = "the acting commanding officer"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/leader
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/staff_sergeant
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>You are responsible for the men and women of your entire section.</a> Make sure they are on task, working together, and communicating. You are also in charge of communicating with command and letting them know about the situation first hand. Keep out of harm's way.<br><b>You remember that you've stored your personal gear and uniform are located in the dorm or locker rooms.</b>"

	job_options = list(SSGT_VARIANT = "SSGT", GYSGT_VARIANT = "GYSGT")

/datum/job/marine/leader/handle_job_options(option)
	if(option != SSGT_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/datum/job/marine/leader/whiskey
	title = JOB_WO_SQUAD_LEADER
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/sl

OverrideTimelock(/datum/job/marine/leader, list(
	JOB_SQUAD_ROLES = 1 HOURS
))

/obj/effect/landmark/start/marine/leader
	name = JOB_SQUAD_LEADER
	icon_state = "leader_spawn"
	job = /datum/job/marine/leader

/obj/effect/landmark/start/marine/leader/alpha
	icon_state = "leader_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/leader/bravo
	icon_state = "leader_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/leader/charlie
	icon_state = "leader_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/leader/delta
	icon_state = "leader_spawn_delta"
	squad = SQUAD_MARINE_4

/datum/job/marine/leader/ai
	total_positions = 1
	spawn_positions = 1
	prime_priority = TRUE

/datum/job/marine/leader/ai/upp
	title = JOB_SQUAD_LEADER_UPP
	gear_preset = /datum/equipment_preset/uscm/leader/upp
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/upp/senior_sergeant
	job_options = list(SRSGT_VARIANT = "SrSGT", SGTMJR_VARIANT = "SGTMJR")

/datum/job/marine/leader/ai/upp/handle_job_options(option)
	if(option != SRSGT_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/datum/job/marine/leader/ai/forecon
	title = JOB_SQUAD_LEADER_FORECON
	gear_preset = /datum/equipment_preset/uscm/leader/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/forecon/gunnery_sergeant
	job_options = list(GYSGT_VARIANT = "GYSGT", MSSGT_VARIANT = "MSSGT")

/datum/job/marine/leader/ai/forecon/handle_job_options(option)
	if(option != GYSGT_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/leader/upp
	name = JOB_SQUAD_LEADER_UPP
	squad = SQUAD_UPP
	job = /datum/job/marine/leader/ai/upp

/datum/job/marine/leader/ai/pmc
	title = JOB_PMCPLAT_LEADER
	gear_preset = /datum/equipment_preset/uscm/pmc/sl
	job_options = null

/obj/effect/landmark/start/marine/leader/pmc
	name = JOB_PMCPLAT_LEADER
	squad = SQUAD_PMCPLT
	job = /datum/job/marine/leader/ai/pmc

/datum/job/marine/leader/ai/pmc/small
	title = JOB_PMCPLAT_SMALL_LEADER
	gear_preset = /datum/equipment_preset/uscm/pmc/sl
	job_options = null

/obj/effect/landmark/start/marine/leader/pmc/small
	name = JOB_PMCPLAT_SMALL_LEADER
	squad = SQUAD_PMCPLT_SMALL
	job = /datum/job/marine/leader/ai/pmc/small

/obj/effect/landmark/start/marine/leader/forecon
	name = JOB_SQUAD_LEADER_FORECON
	squad = SQUAD_LRRP
	job = /datum/job/marine/leader/ai/forecon

//-- RMC Platoon --//
// Second-in-command under LT, handles the mortar calls //
/datum/job/marine/leader/ai/rmc
	title = JOB_TWE_RMC_TROOPLEADER
	gear_preset = /datum/equipment_preset/uscm/rmc/cs
	job_options = null
	supervisors = "the troop commander"
	entry_message_body = "You are the second in command of the whole Troop, ensuring the orders of the Troop Commander are followed through. Make sure they are on task, working together, and adequately supplied. You are also in charge of communicating with the Bombardment Specialist and coordinating the fire support they provide. Keep out of harm's way. You report to the Troop Commander under normal circumstances, but may be required to take command should they die.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your equipment can be located in the armoury.</b>"

/obj/effect/landmark/start/marine/leader/rmc
	name = JOB_TWE_RMC_TROOPLEADER
	squad = SQUAD_RMC
	job = /datum/job/marine/leader/ai/rmc

/datum/job/marine/leader/ai/uacg
	title = JOB_UACG_SENLEAD
	gear_preset = /datum/equipment_preset/uacg/senleader
	gear_preset_secondary = /datum/equipment_preset/uacg/senleader/greater_rank
	job_options =  list(SFC_VARIANT = "SFC", MSSGT_VARIANT = "MSGT")
	total_positions = 2
	spawn_positions = 2
	supervisors = "the officer"
	entry_message_body = "You are the senior leadership of your Guard squad under the United Americas Colonial Guard. You report directly to the officer in charge of your formation and you fully take responsibility for the actions of those under you. You are the backbone of the Guard.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your equipment can be requisitioned from the armory.</b>"

/datum/job/marine/leader/ai/uacg/handle_job_options(option)
	if(option != SSGT_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/leader/uacg
	name = JOB_UACG_SENLEAD
	job = /datum/job/marine/leader/ai/uacg

/datum/job/marine/leader/ai/uacg/armorer
	title = JOB_UACG_ARMORY
	gear_preset = /datum/equipment_preset/uacg/senleader/armorer
	gear_preset_secondary = /datum/equipment_preset/uacg/senleader/armorer/greater_rank
	gear_preset_tertiary = /datum/equipment_preset/uacg/senleader/armorer/even_greater_rank
	job_options = list(SFC_VARIANT = "SFC", MSSGT_VARIANT = "MSGT", SGTMJR_VARIANT = "SGM")
	total_positions = 1
	spawn_positions = 1
	supervisors = "the officer"
	entry_message_body = "You are the quartermaster for a Colonial Guard unit and are in charge of ensuring all equipment are accounted for and maintained. You understand the ends and outs of every weapon system in your arsenal, and just how woefully underprepared it is for a war with a near peer adversary.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that no one else bar your superior officers and the weapons technician should be in the armory.</b>"

/datum/job/marine/leader/ai/uacg/armorer/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == SGTMJR_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == SFC_VARIANT)
		gear_preset = gear_preset
	if(option == MSSGT_VARIANT)
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/leader/uacg/armorer
	name = JOB_UACG_ARMORY
	squad = SQUAD_MILITIA_5
	job = /datum/job/marine/leader/ai/uacg/armorer

/datum/job/marine/leader/ai/uacg/chaplain
	title = JOB_UACG_CHAPLAIN
	gear_preset = /datum/equipment_preset/uacg/senleader/chaplain
	gear_preset_secondary = /datum/equipment_preset/uacg/senleader/chaplain/greater_rank
	job_options = list(CMDSGTMJR_VARIANT = "CSGM", WO1_VARIANT = "WO1")
	total_positions = 1
	spawn_positions = 1
	supervisors = "the officer"
	entry_message_body = "You are the Chaplain for a Colonial Guard unit and act as a religious grounding for your fellow man. That, and someone needs to make sure the dead get a proper burial and sendoff.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms.</b>"

/datum/job/marine/leader/ai/uacg/chaplain/handle_job_options(option)
	if(option != WO1_VARIANT)
		gear_preset = initial(gear_preset)
	else
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/leader/uacg/chaplain
	name = JOB_UACG_CHAPLAIN
	squad = SQUAD_MILITIA_5
	job = /datum/job/marine/leader/ai/uacg/chaplain

#undef WO1_VARIANT
#undef CMDSGTMJR_VARIANT
#undef MSSGT_VARIANT
#undef GYSGT_VARIANT
#undef SFC_VARIANT
#undef SGTMJR_VARIANT
#undef SSGT_VARIANT
#undef SRSGT_VARIANT
