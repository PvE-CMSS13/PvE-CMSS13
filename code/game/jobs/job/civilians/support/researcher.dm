
//Researcher
/datum/job/civilian/researcher
	title = JOB_RESEARCHER
	total_positions = 2
	spawn_positions = 2
	allow_additional = 1
	scaled = 1
	supervisors = "chief medical officer"
	selection_class = "job_researcher"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/uscm_medical/researcher
	entry_message_body = "You're a commissioned officer of the USCM, though you are not in the ship's chain of command. You are tasked with <a href='"+WIKI_PLACEHOLDER+"'>researching</a> and developing new medical treatments, helping your fellow doctors, and generally learning new things. Your role involves a lot of roleplaying, but you can perform the function of a regular doctor. Do not hand out things to Marines without getting permission from your supervisor."

/datum/job/civilian/researcher/set_spawn_positions(count)
	spawn_positions = rsc_slot_formula(count)

/datum/job/civilian/researcher/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = rsc_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

AddTimelock(/datum/job/civilian/researcher, list(
	JOB_MEDIC_ROLES = 5 HOURS
))


/datum/job/civilian/researcher/uscm_ground
	title = JOB_USCM_GROUND_CIVILIAN
	scaled = FALSE
	supervisors = "greater scientific community"
	gear_preset = /datum/equipment_preset/uscm_ground/civilian
	entry_message_body = null

/datum/job/civilian/researcher/uscm_ground/generate_entry_message()
	entry_message_body =  {"You are a visiting scientific expert, conducting studies around [SSmapping.configs[GROUND_MAP].map_name] outpost.
You have been graciously housed and fed by the USCM for the duration of your visit through a substantial government grant.
You are not a military asset, but you are expected to follow military rules and regulations; you have guest access to the outpost, but it is fairly limited.
Keep your head down, study the local environment as befit your expertise, and further the reaches of science and reason.
While you may defend yourself if needed, the outpost houses marines who are far better trained and equipped to do the fighting for you."}

	return ..()

/datum/job/civilian/researcher/uscm_ground/set_spawn_positions(count)
	return spawn_positions

/datum/job/civilian/researcher/uscm_ground/get_total_positions(latejoin = FALSE)
	return latejoin ? total_positions : spawn_positions

/obj/effect/landmark/start/researcher
	name = JOB_RESEARCHER
	icon_state = "res_spawn"
	job = /datum/job/civilian/researcher

/obj/effect/landmark/start/researcher/uscm_ground
	name = JOB_USCM_GROUND_CIVILIAN
	job = /datum/job/civilian/researcher/uscm_ground
