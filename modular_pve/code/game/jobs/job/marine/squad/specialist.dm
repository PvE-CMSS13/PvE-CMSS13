/datum/job/marine/specialist/ai/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_SPECIALIST
	total_positions = 2
	spawn_positions = 2
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/specialist/uscm_ground
	entry_message_body = "You have received specialized training to field test unique, experimental loadouts. You can serve a variety of roles, so decide accordingly."

/obj/effect/landmark/start/marine/specialist/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_SMARTGUNNER
	job = /datum/job/marine/specialist/ai/uscm_ground

/obj/effect/landmark/start/marine/specialist/uscm_ground/copperheads
	icon_state = "spec_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/specialist/uscm_ground/rattlesnakes
	icon_state = "spec_spawn_delta"
	squad = SQUAD_MARINE_4
