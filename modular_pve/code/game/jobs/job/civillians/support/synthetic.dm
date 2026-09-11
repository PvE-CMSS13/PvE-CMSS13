/datum/job/civilian/synthetic/uscm_ground
	title = JOB_USCM_GROUND_SYNTH
	total_positions = 1
	scaled = FALSE
	supervisors = "the outpost commanding officer"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	flags_whitelist = NONE
	gear_preset = /datum/equipment_preset/synth/uscm/uscm_ground

//Important to have no spacing/tabs in {} blocks as they are rendered directly.
/datum/job/civilian/synthetic/uscm_ground/generate_entry_message()
	. = "You are a synthetic unit deployed to assist the USCM in one of their remote outposts. You are in charge of engineering and maintenance duties. <br>Aside from that, you may carry out other functions, such as helping out, socializing, and generally roleplaying as you see fit. Just remember to keep the lights on. <br>You must obey the chain of command: Outpost Commander followed by the Outpost Adjutant. Command may assign additional duties for you, so do keep an ear out. <br>You are not required to follow orders that are clearly dangerous to yourself or others, nonsensical, impossible, or made under duress, even if they come from proper chain of command. <br><br>Prioritize orders from those higher on the chain of command. In case of conflicting orders, those higher on the chain of command take priority. <br>Civilian guests are to be treated on the level of senior enlisted personnel (sergeant and above)."

/datum/job/civilian/synthetic/uscm_ground/set_spawn_positions(count)
	return spawn_positions

/datum/job/civilian/synthetic/uscm_ground/get_total_positions(latejoin = FALSE)
	return latejoin ? total_positions : spawn_positions

/obj/effect/landmark/start/synthetic/uscm_ground
	name = JOB_USCM_GROUND_SYNTH
	job = /datum/job/civilian/synthetic/uscm_ground
