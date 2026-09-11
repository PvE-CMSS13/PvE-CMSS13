/datum/job/civilian/researcher/uscm_ground
	title = JOB_USCM_GROUND_CIVILIAN
	scaled = FALSE
	supervisors = "greater scientific community"
	gear_preset = /datum/equipment_preset/uscm_ground/civilian
	entry_message_body = null

/datum/job/civilian/researcher/uscm_ground/generate_entry_message()
	entry_message_body =  "You are a visiting scientific expert, conducting studies around [SSmapping.configs[GROUND_MAP].map_name] outpost. <br>You have been graciously housed and fed by the USCM for the duration of your visit, through a substantial government grant. <br>You are not a military asset, but you are expected to follow military rules and regulations; you have guest access to the outpost, but it is fairly limited. Keep your head down, study the local environment as befit your expertise, and further the reaches of science and reason. <br>You may defend yourself if directly threatened, but <b>you have zero combat experience</b>. <br>Let the marines protect you. It's their job, and they are trained and equipped for it. <br>The rest is up to you. Roleplay, get to know people, make your own fun. You may or may not have more to do depending on the GM."

	return ..()

/datum/job/civilian/researcher/uscm_ground/set_spawn_positions(count)
	return spawn_positions

/datum/job/civilian/researcher/uscm_ground/get_total_positions(latejoin = FALSE)
	return latejoin ? total_positions : spawn_positions

/obj/effect/landmark/start/researcher/uscm_ground
	name = JOB_USCM_GROUND_CIVILIAN
	job = /datum/job/civilian/researcher/uscm_ground

