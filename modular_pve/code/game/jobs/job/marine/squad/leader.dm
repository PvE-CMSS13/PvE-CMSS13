/datum/job/marine/leader/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_LEADER
	total_positions = 2
	spawn_positions = 2
	supervisors = "outpost officers"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/leader/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/leader/uscm_ground/staff_sergeant
	entry_message_body = "You were deemed competent enough to lead a section, act accordingly. Make sure your section is at task, and correct them if they are not. Delegate to your squad leaders, but let them breathe. Communicate with officers in charge of the outpost and follow their instructions."

	job_options = list(SSGT_VARIANT = "SSGT", GYSGT_VARIANT = "GYSGT")

/obj/effect/landmark/start/marine/leader/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_LEADER
	job = /datum/job/marine/leader/ai/uscm_ground

/obj/effect/landmark/start/marine/leader/uscm_ground/copperheads
	icon_state = "leader_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/leader/uscm_ground/rattlesnakes
	icon_state = "leader_spawn_delta"
	squad = SQUAD_MARINE_4
