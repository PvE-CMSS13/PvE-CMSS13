/datum/job/marine/smartgunner/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_SMARTGUNNER
	total_positions = 4
	spawn_positions = 4
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/sg/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/sg/uscm_ground/lance_corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/sg/uscm_ground/pfc
	gear_preset_quaternary = /datum/equipment_preset/uscm/sg/uscm_ground/private
	entry_message_body = "You got the big, mean killin' machine of a gun. But don't get too crazy, you're still human."
	job_options = list(PVT_VARIANT = "PVT", PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL", CPL_VARIANT = "CPL")

/obj/effect/landmark/start/marine/smartgunner/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_SMARTGUNNER
	job = /datum/job/marine/smartgunner/ai/uscm_ground

/obj/effect/landmark/start/marine/smartgunner/uscm_ground/copperheads
	icon_state = "smartgunner_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/smartgunner/uscm_ground/rattlesnakes
	icon_state = "smartgunner_spawn_delta"
	squad = SQUAD_MARINE_4
