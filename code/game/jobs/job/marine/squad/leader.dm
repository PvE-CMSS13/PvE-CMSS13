
#define SSGT_VARIANT "Staff Sergeant"
#define GYSGT_VARIANT "Gunnery Sergeant"

/datum/job/marine/leader
	title = JOB_SQUAD_LEADER
	squad_root_title = JOB_SQUAD_LEADER
	total_positions = 4
	spawn_positions = 4
	supervisors = "the acting commanding officer"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/leader
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/lesser_rank
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>You are responsible for the men and women of your entire platoon.</a> Make sure they are on task, working together, and communicating. You are also in charge of communicating with command and letting them know about the situation first hand. Keep out of harm's way.<br><b>You remember that you've stored your personal gear and uniform are located in the dorm or locker rooms.</b>"

	job_options = list(GYSGT_VARIANT = "GYSGT", SSGT_VARIANT = "SSGT")

/datum/job/marine/leader/handle_job_options(option)
	if(option != GYSGT_VARIANT)
		gear_preset = gear_preset_secondary
	else
		gear_preset = initial(gear_preset)

/datum/job/marine/leader/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_LEADER
	supervisors = "outpost officers"
	gear_preset = /datum/equipment_preset/uscm/leader/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/uscm_ground/lesser_rank
	total_positions = 2
	spawn_positions = 2
	prime_priority = TRUE
	entry_message_body = "You were deemed competent enough to lead a platoon, act accordingly. Make sure your platoon is at task, and correct them if they are not. Delegate to your squad leaders, but let them breathe. Communicate with officers in charge of the outpost and follow their instructions."

/datum/job/marine/leader/whiskey
	title = JOB_WO_SQUAD_LEADER
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/sl

AddTimelock(/datum/job/marine/leader, list(
	JOB_SQUAD_ROLES = 10 HOURS
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

/obj/effect/landmark/start/marine/leader/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_LEADER
	job = /datum/job/marine/leader/uscm_ground

/obj/effect/landmark/start/marine/leader/uscm_ground/one
	squad = SQUAD_USCM_GROUND_1

/obj/effect/landmark/start/marine/leader/uscm_ground/two
	squad = SQUAD_USCM_GROUND_2

/datum/job/marine/leader/ai
	total_positions = 1
	spawn_positions = 1
	prime_priority = TRUE
	squad_default_path = /datum/squad/marine/alpha

/datum/job/marine/leader/ai/upp
	title = JOB_SQUAD_LEADER_UPP
	gear_preset = /datum/equipment_preset/uscm/leader/upp
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/upp/lesser_rank
	squad_default_path = /datum/squad/marine/upp

/datum/job/marine/leader/ai/forecon
	title = JOB_SQUAD_LEADER_FORECON
	gear_preset = /datum/equipment_preset/uscm/leader/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/forecon/lesser_rank
	squad_default_path = /datum/squad/marine/forecon

/obj/effect/landmark/start/marine/leader/upp
	name = JOB_SQUAD_LEADER_UPP
	squad = SQUAD_UPP
	job = /datum/job/marine/leader/ai/upp

/obj/effect/landmark/start/marine/leader/forecon
	name = JOB_SQUAD_LEADER_FORECON
	squad = SQUAD_LRRP
	job = /datum/job/marine/leader/ai/forecon

#undef SSGT_VARIANT
#undef GYSGT_VARIANT
