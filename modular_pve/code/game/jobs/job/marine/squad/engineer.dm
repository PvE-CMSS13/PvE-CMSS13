/datum/job/marine/engineer/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_ENGI
	gear_preset = /datum/equipment_preset/uscm/engineer/uscm_ground
	gear_preset_secondary = /datum/equipment_preset/uscm/engineer/uscm_ground/pfc
	job_options = list(PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL")
	entry_message_body = "You are highly-trained to repair battlefield fortifications, power-systems and various other things besides. Your section will rely on you to create field barricades if needed, so make sure to do just that."

/obj/effect/landmark/start/marine/engineer/ai/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_ENGI
	job = /datum/job/marine/engineer/ai/uscm_ground

/obj/effect/landmark/start/marine/engineer/ai/uscm_ground/copperheads
	icon_state = "engi_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/engineer/ai/uscm_ground/rattlesnakes
	icon_state = "engi_spawn_delta"
	squad = SQUAD_MARINE_4
