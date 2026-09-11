/datum/job/marine/tl/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_TEAM_LEADER
	total_positions = 4
	spawn_positions = 4
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/tl/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/tl/uscm_ground/corporal
	entry_message_body = "You were deemed competent enough to lead a squad. Act accordingly. Make sure your squad stays together and accounted for. Report to the section leader and help them get the job done."
	job_options = list(CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/obj/effect/landmark/start/marine/tl/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_TEAM_LEADER
	job = /datum/job/marine/tl/ai/uscm_ground

/obj/effect/landmark/start/marine/tl/uscm_ground/copperheads
	icon_state = "tl_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/tl/uscm_ground/rattlesnakes
	icon_state = "tl_spawn_delta"
	squad = SQUAD_MARINE_4
