/datum/job/command/commander/uscm_ground
	title = JOB_USCM_GROUND_CO
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	flags_whitelist = NONE
	gear_preset = /datum/equipment_preset/uscm_ground/oco
	prime_priority = TRUE
	entry_message_body = null

/obj/effect/landmark/start/captain/uscm_ground
	name = JOB_USCM_GROUND_CO
	job = /datum/job/command/commander/uscm_ground
