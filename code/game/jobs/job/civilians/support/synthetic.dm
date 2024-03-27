/datum/job/civilian/synthetic
	title = JOB_SYNTH
	total_positions = 2
	spawn_positions = 1
	allow_additional = 1
	scaled = 1
	supervisors = "the acting commanding officer"
	selection_class = "job_synth"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADMIN_NOTIFY|ROLE_WHITELISTED|ROLE_CUSTOM_SPAWN
	flags_whitelist = WHITELIST_SYNTHETIC
	gear_preset = /datum/equipment_preset/synth/uscm
	entry_message_body = "You are a <a href='"+WIKI_PLACEHOLDER+"'>Synthetic!</a> You are held to a higher standard and are required to obey not only the Server Rules but Marine Law and Synthetic Rules. Failure to do so may result in your White-list Removal. Your primary job is to support and assist all USCM Departments and Personnel on-board. In addition, being a Synthetic gives you knowledge in every field and specialization possible on-board the ship. As a Synthetic you answer to the acting commanding officer. Special circumstances may change this!"

/datum/job/civilian/synthetic/New()
	. = ..()
	gear_preset_whitelist = list(
		"[JOB_SYNTH][WHITELIST_NORMAL]" = /datum/equipment_preset/synth/uscm,
		"[JOB_SYNTH][WHITELIST_COUNCIL]" = /datum/equipment_preset/synth/uscm/councillor,
		"[JOB_SYNTH][WHITELIST_LEADER]" = /datum/equipment_preset/synth/uscm/councillor
	)

/datum/job/civilian/synthetic/get_whitelist_status(list/roles_whitelist, client/player)
	. = ..()
	if(!.)
		return

	if(roles_whitelist[player.ckey] & WHITELIST_SYNTHETIC_LEADER)
		return get_desired_status(player.prefs.synth_status, WHITELIST_LEADER)
	else if(roles_whitelist[player.ckey] & (WHITELIST_SYNTHETIC_COUNCIL|WHITELIST_SYNTHETIC_COUNCIL_LEGACY))
		return get_desired_status(player.prefs.synth_status, WHITELIST_COUNCIL)
	else if(roles_whitelist[player.ckey] & WHITELIST_SYNTHETIC)
		return get_desired_status(player.prefs.synth_status, WHITELIST_NORMAL)

/datum/job/civilian/synthetic/set_spawn_positions(count)
	spawn_positions = synth_slot_formula(count)

/datum/job/civilian/synthetic/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = synth_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

/datum/job/civilian/synthetic/uscm_ground
	title = JOB_USCM_GROUND_SYNTH
	total_positions = 1
	scaled = FALSE
	supervisors = "the outpost commanding officer"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	flags_whitelist = NONE
	gear_preset = /datum/equipment_preset/synth/uscm_ground

//Important to have no spacing/tabs in {} blocks as they are rendered directly.
/datum/job/civilian/synthetic/uscm_ground/generate_entry_message()
	. = {"You are a synthetic unit deployed to assist the USCM in one of their remote outposts. You are in charge of engineering and maintenance duties. Make sure the lights stay on.
You may perform other duties and functions as assigned by the officers in charge of the operation. You must obey the chain of command: Outpost Commander followed by the Adjunct Officer,
You are not required to follow orders that are clearly dangerous to yourself or others, nonsensical, impossible, or made under duress, even if they come from proper chain of command.

In case of conflicting orders, those higher on the chain of command take priority. Prioritize orders from those higher on the chain of command.
Civilian guests are to be treated on the level of senior enlisted personnel (sergeant and above)."}

/datum/job/civilian/synthetic/uscm_ground/set_spawn_positions(count)
	return spawn_positions

/datum/job/civilian/synthetic/uscm_ground/get_total_positions(latejoin = FALSE)
	return latejoin ? total_positions : spawn_positions

/obj/effect/landmark/start/synthetic
	name = JOB_SYNTH
	icon_state = "syn_spawn"
	job = /datum/job/civilian/synthetic

/obj/effect/landmark/start/synthetic/uscm_ground
	name = JOB_USCM_GROUND_SYNTH
	job = /datum/job/civilian/synthetic/uscm_ground
