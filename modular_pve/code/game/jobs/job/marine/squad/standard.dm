/datum/job/marine/standard/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_MARINE
	total_positions = 8
	spawn_positions = 8
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/pfc/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/pfc/uscm_ground/private
	gear_preset_tertiary = /datum/equipment_preset/uscm/pfc/uscm_ground/lance_corporal
	job_options = list(PVT_VARIANT = "PVT", PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL")

/obj/effect/landmark/start/marine/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_MARINE
	job = /datum/job/marine/standard/ai/uscm_ground

/obj/effect/landmark/start/marine/uscm_ground/copperheads
	icon_state = "marine_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/uscm_ground/rattlesnakes
	icon_state = "marine_spawn_delta"
	squad = SQUAD_MARINE_4
