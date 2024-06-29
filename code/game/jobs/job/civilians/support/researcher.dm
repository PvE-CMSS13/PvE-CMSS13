
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
	category = JOB_CATEGORY_MEDICAL

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
	category = JOB_CATEGORY_OTHER

/datum/job/civilian/researcher/uscm_ground/generate_entry_message()
	entry_message_body =  {"You are a visiting scientific expert, conducting studies around [SSmapping.configs[GROUND_MAP].map_name] outpost.
You have been graciously housed and fed by the USCM for the duration of your visit, through a substantial government grant.
You are not a military asset, but you are expected to follow military rules and regulations; you have guest access to the outpost, but it is fairly limited.
Keep your head down, study the local environment as befit your expertise, and further the reaches of science and reason.
You may defend yourself if directly threatened, but <b>you have zero combat experience</b>.
Let the marines protect you. It's their job, and they are trained and equipped for it.
The rest is up to you. Roleplay, get to know people, make your own fun. You may or may not have more to do depending on the GM."}

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
