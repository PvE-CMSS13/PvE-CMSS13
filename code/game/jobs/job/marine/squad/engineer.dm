#define LCPL_VARIANT "Lance Corporal"
#define PFC_VARIANT "Private First Class"

/datum/job/marine/engineer
	title = JOB_SQUAD_ENGI
	total_positions = 12
	spawn_positions = 12
	allow_additional = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/engineer
	entry_message_body = "You have the <a href='"+WIKI_PLACEHOLDER+"'>equipment and skill</a> to build fortifications, reroute power lines, and bunker down. Your squaddies will look to you when it comes to construction in the field of battle."

/datum/job/marine/engineer/set_spawn_positions(count)
	for(var/datum/squad/sq in GLOB.RoleAuthority.squads)
		if(sq)
			sq.max_engineers = engi_slot_formula(count)

/datum/job/marine/engineer/get_total_positions(latejoin=0)
	var/slots = engi_slot_formula(get_total_marines())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	if(latejoin)
		for(var/datum/squad/sq in GLOB.RoleAuthority.squads)
			if(sq)
				sq.max_engineers = slots

	return (slots*4)

/datum/job/marine/engineer/whiskey
	title = JOB_WO_SQUAD_ENGINEER
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/engineer

/obj/effect/landmark/start/marine/engineer
	name = JOB_SQUAD_ENGI
	icon_state = "engi_spawn"
	job = /datum/job/marine/engineer

/obj/effect/landmark/start/marine/engineer/alpha
	icon_state = "engi_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/engineer/bravo
	icon_state = "engi_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/engineer/charlie
	icon_state = "engi_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/engineer/delta
	icon_state = "engi_spawn_delta"
	squad = SQUAD_MARINE_4

//Having to add a /ai subtype before the /rmc one, might as well make it viable for use
/datum/job/marine/engineer/ai
	total_positions = 2
	spawn_positions = 2
	gear_preset = /datum/equipment_preset/uscm/engineer
	gear_preset_secondary = /datum/equipment_preset/uscm/engineer/pfc
	job_options = list(PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL")

/obj/effect/landmark/start/marine/engineer/ai
	job = /datum/job/marine/engineer/ai

/datum/job/marine/engineer/ai/set_spawn_positions(count)
	return spawn_positions

/datum/job/marine/engineer/ai/get_total_positions(latejoin=0)
	return latejoin ? total_positions : spawn_positions

/datum/job/marine/engineer/ai/pmc/small
	total_positions = 1
	spawn_positions = 1
	title = JOB_PMCPLAT_SMALL_ENGI
	gear_preset = /datum/equipment_preset/uscm/pmc/eng
	job_options = null

/obj/effect/landmark/start/marine/engineer/ai/pmc/small
	name = JOB_PMCPLAT_SMALL_ENGI
	squad = SQUAD_PMCPLT_SMALL
	job = /datum/job/marine/engineer/ai/pmc/small

/datum/job/marine/engineer/ai/rmc
	total_positions = 1
	spawn_positions = 1
	title = JOB_TWE_RMC_ENGI
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/rmc/eng
	job_options = null
	supervisors = "the section leader and troop commander"
	entry_message_body = "You are a commando-trained member of the Royal Engineers serving with the Royal Marines Commando forces. You're given the equipment and responsibility amongst the Rifle Section to build fortifications, reroute power lines, and handle all things engineering related in the field of battle. <br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your specialist equipment can be located in the armoury.</b>"

/obj/effect/landmark/start/marine/engineer/rmc
	name = JOB_TWE_RMC_ENGI
	squad = SQUAD_RMC
	job = /datum/job/marine/engineer/ai/rmc

/datum/job/marine/engineer/ai/rmcmortar
	total_positions = 1
	spawn_positions = 1
	title = JOB_TWE_RMC_BREACHER
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/rmc/mor
	job_options = null
	supervisors = "the troop commander and troop sergeant"
	entry_message_body = "You are a commando-trained member of the Royal Artillery serving with the Royal Marines Commando forces. You're responsible for offering light fire support to the Troop via either a mortar or multiple-grenade-launcher weapon system. You will be working closely with the Troop Sergeant, who should be carrying your spare support-weapon ammo, and the Troop Commander as part of the Headquarters Section.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your specialist equipment can be located in the armoury.</b>"

/obj/effect/landmark/start/marine/engineer/rmcmortar
	name = JOB_TWE_RMC_BREACHER
	squad = SQUAD_RMC
	job = /datum/job/marine/engineer/ai/rmcmortar

#undef LCPL_VARIANT
#undef PFC_VARIANT
