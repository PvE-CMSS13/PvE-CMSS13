//Executive Officer
/datum/job/command/executive
	title = JOB_XO
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADMIN_NOTIFY
	gear_preset = /datum/equipment_preset/uscm_ship/xo

/datum/job/command/executive/generate_entry_message(mob/living/carbon/human/H)
	switch(title)
		if(JOB_XO)
			entry_message_body = "<a href='[generate_wiki_link()]'>You are second in command aboard the [MAIN_SHIP_NAME],</a> and are in next in the chain of command after the Commanding Officer. Where applicable, you must abide by the <a href='[CONFIG_GET(string/wikiarticleurl)][URL_WIKI_CO_RULES]'>Commanding Officer Code of Conduct</a>. You may need to fill in for other duties if areas are understaffed, and you are given access to do so. Make the USCM proud!"
		if(JOB_USCM_GROUND_AO)
			entry_message_body = {"You are the right hand of the Commander, a lieutenant, and an officer tasked with supporting the marines in their duties. You are also a highly-skilled medical professional.
While the Outpost Commander handles general logistics and mission control, you are in charge of supply lines, medical affairs, and day-to-day operations.
Tend to the needs of the men and women in the outpost, make sure they are healthy and able to perform their duties, and are supplied with the equipment they need.
The Outpost Commander may assign additional duties for you. You are second in command, should anything happen to the senior officer.

Civilian guests have to follow military regulations, but they are not military personnel. Protect them."}

	return ..()

/datum/job/command/executive/generate_entry_conditions(mob/living/M, whitelist_status)
	. = ..()
	GLOB.marine_leaders[title] = M
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_leader_candidate))

/datum/job/command/executive/proc/cleanup_leader_candidate(mob/M)
	SIGNAL_HANDLER
	GLOB.marine_leaders -= title

AddTimelock(/datum/job/command/executive, list(
	JOB_COMMAND_ROLES = 5 HOURS,
))

/datum/job/command/executive/uscm_ground
	title = JOB_USCM_GROUND_AO
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ground/ao
	prime_priority = TRUE

/obj/effect/landmark/start/executive
	name = JOB_XO
	icon_state = "xo_spawn"
	job = /datum/job/command/executive

/obj/effect/landmark/start/executive/uscm_ground
	name = JOB_USCM_GROUND_AO
	job = /datum/job/command/executive/uscm_ground
