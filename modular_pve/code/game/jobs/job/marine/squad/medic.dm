/datum/job/marine/medic/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_MEDIC
	total_positions = 2
	spawn_positions = 2
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/medic/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/medic/uscm_ground/lance_corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/medic/uscm_ground/pfc
	gear_preset_quaternary = /datum/equipment_preset/uscm/medic/uscm_ground/private
	entry_message_body = "You are uniquely qualified to treat battlefield injuries, so make sure to do just that. Stick close to your allies, and pull them out of harm's way when they need it."

	job_options = list(PVT_VARIANT = "PVT", PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL", CPL_VARIANT = "CPL")

/obj/effect/landmark/start/marine/medic/ai/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_MEDIC
	job = /datum/job/marine/medic/ai/uscm_ground

/obj/effect/landmark/start/marine/medic/ai/uscm_ground/copperheads
	icon_state = "medic_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/medic/ai/uscm_ground/rattlesnakes
	icon_state = "medic_spawn_delta"
	squad = SQUAD_MARINE_4
