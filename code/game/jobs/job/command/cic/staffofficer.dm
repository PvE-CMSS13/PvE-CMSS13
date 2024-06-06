
#define SECOND_LT_VARIANT "Second Lieutenant"
#define FIRST_LT_VARIANT "First Lieutenant"

/datum/job/command/bridge
	title = JOB_SO
	total_positions = 4
	spawn_positions = 4
	allow_additional = 1
	scaled = FALSE
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/so
	gear_preset_secondary = /datum/equipment_preset/uscm_ship/so/lesser_rank
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>Your job is to conduct the briefing for the platoon, monitor the operation, and listen to your superior officers.</a> You are in charge of the platoon for the current operation and supported by your Company Command.<br>They will give your orders VIA the telephone in your office once they are ready.<br><b>You remember that you've stored your personal gear are located in your personal quarters.</b><br>Your job involves heavy roleplay and requires you to behave like an officer and to stay in character at all times."

	job_options = list(FIRST_LT_VARIANT = "1stLt", SECOND_LT_VARIANT = "2ndLt")

/datum/job/command/bridge/set_spawn_positions(count)
	spawn_positions = so_slot_formula(count)

/datum/job/command/bridge/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = so_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

/datum/job/command/bridge/generate_entry_message(mob/living/carbon/human/H)
	return ..()

/datum/job/command/bridge/handle_job_options(option)
	if(option != FIRST_LT_VARIANT)
		gear_preset = gear_preset_secondary
	else
		gear_preset = initial(gear_preset)

AddTimelock(/datum/job/command/bridge, list(
	JOB_SQUAD_LEADER = 1 HOURS,
	JOB_HUMAN_ROLES = 15 HOURS
))

/obj/effect/landmark/start/bridge
	name = JOB_SO
	icon_state = "so_spawn"
	job = /datum/job/command/bridge

/datum/job/command/bridge/ai
	total_positions = 1
	spawn_positions = 1
	prime_priority = TRUE

/datum/job/command/bridge/ai/set_spawn_positions(count)
	return spawn_positions

/datum/job/command/bridge/ai/get_total_positions(latejoin = 0)
	return latejoin ? total_positions : spawn_positions

/datum/job/command/bridge/ai/generate_entry_conditions(mob/living/M, whitelist_status)
	. = ..()
	GLOB.marine_leaders[JOB_SO] = M
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_leader_candidate))

/datum/job/command/bridge/ai/proc/cleanup_leader_candidate(mob/M)
	SIGNAL_HANDLER
	GLOB.marine_leaders -= JOB_SO

/datum/job/command/bridge/ai/upp
	title = JOB_SO_UPP
	gear_preset = /datum/equipment_preset/uscm_ship/so/upp
	gear_preset_secondary = /datum/equipment_preset/uscm_ship/so/upp/lesser_rank

/obj/effect/landmark/start/bridge/upp
	name = JOB_SO_UPP
	icon_state = "so_spawn"
	job = /datum/job/command/bridge/ai/upp

/datum/job/command/bridge/ai/pmc
	title = JOB_PMCPLAT_OW
// todo: funny AR goggles perma cyan 	gear_preset =
// todo: above	gear_preset_secondary = /datum/equipment_preset/uscm_ship/so/upp/lesser_rank

	gear_preset = /datum/equipment_preset/uscm_ship/so/pmc
	job_options = list(FIRST_LT_VARIANT = "OVERWATCH", SECOND_LT_VARIANT = "OVERLORD")

/obj/effect/landmark/start/bridge/pmc
	name = JOB_PMCPLAT_OW
	job = /datum/job/command/bridge/ai/pmc

#undef SECOND_LT_VARIANT
#undef FIRST_LT_VARIANT
