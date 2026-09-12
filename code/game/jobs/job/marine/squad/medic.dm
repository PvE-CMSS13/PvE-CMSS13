#define SGT_VARIANT "Sergeant"
#define JSGT_VARIANT "Junior Sergeant"
#define CPL_VARIANT "Corporal"
#define LCPL_VARIANT "Lance Corporal"
#define PFC_VARIANT "Private First Class"
#define SR_PVT_VARIANT "Senior Private"
#define PVT_VARIANT "Private"

/datum/job/marine/medic
	title = JOB_SQUAD_MEDIC
	total_positions = 16
	spawn_positions = 16
	allow_additional = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/medic
	gear_preset_secondary = /datum/equipment_preset/uscm/medic/lance_corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/medic/pfc
	gear_preset_quaternary = /datum/equipment_preset/uscm/medic/private
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>You tend the wounds of your fellow Marines</a> and make sure they are healthy and active. You may not be a fully-fledged doctor, but you stand between life and death when it matters.<br>You might be the same rank as a squad leader, but they have precedence over you for command should the situation call upon it.<br><b>You remember that you've stored your personal gear and uniform are located in your medical office.</b>"

	job_options = list(PVT_VARIANT = "PVT", PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL", CPL_VARIANT = "CPL")

/datum/job/marine/medic/set_spawn_positions(count)
	for(var/datum/squad/sq in GLOB.RoleAuthority.squads)
		if(sq)
			sq.max_medics = medic_slot_formula(count)

/datum/job/marine/medic/get_total_positions(latejoin=0)
	var/slots = medic_slot_formula(get_total_marines())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	if(latejoin)
		for(var/datum/squad/sq in GLOB.RoleAuthority.squads)
			if(sq)
				sq.max_medics = slots

	return (slots*4)

/datum/job/marine/medic/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == PVT_VARIANT)
		gear_preset = gear_preset_quaternary
	if(option == PFC_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == LCPL_VARIANT)
		gear_preset = gear_preset_secondary

/datum/job/marine/medic/whiskey
	title = JOB_WO_SQUAD_MEDIC
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/medic

/obj/effect/landmark/start/marine/medic
	name = JOB_SQUAD_MEDIC
	icon_state = "medic_spawn"
	job = /datum/job/marine/medic

/obj/effect/landmark/start/marine/medic/alpha
	icon_state = "medic_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/medic/bravo
	icon_state = "medic_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/medic/charlie
	icon_state = "medic_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/medic/delta
	icon_state = "medic_spawn_delta"
	squad = SQUAD_MARINE_4

/datum/job/marine/medic/ai
	total_positions = 1
	spawn_positions = 1

/datum/job/marine/medic/ai/set_spawn_positions(count)
	return spawn_positions

/datum/job/marine/medic/ai/get_total_positions(latejoin=0)
	return latejoin ? total_positions : spawn_positions

/datum/job/marine/medic/ai/upp
	title = JOB_SQUAD_MEDIC_UPP
	gear_preset = /datum/equipment_preset/uscm/medic/upp
	gear_preset_secondary = /datum/equipment_preset/uscm/medic/upp/corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/medic/upp/senior_private
	gear_preset_quaternary = /datum/equipment_preset/uscm/medic/upp/private
	job_options = list(PVT_VARIANT = "PVT", SR_PVT_VARIANT = "SrPVT", CPL_VARIANT = "CPL", JSGT_VARIANT = "JrSGT")

/datum/job/marine/medic/ai/upp/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == PVT_VARIANT)
		gear_preset = gear_preset_quaternary
	if(option == SR_PVT_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == CPL_VARIANT)
		gear_preset = gear_preset_secondary

/datum/job/marine/medic/ai/forecon
	title = JOB_SQUAD_MEDIC_FORECON
	gear_preset = /datum/equipment_preset/uscm/medic/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/medic/forecon/corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/medic/forecon/lance_corporal
	gear_preset_quaternary = /datum/equipment_preset/uscm/medic/forecon/pfc
	job_options = list(PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL", CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/datum/job/marine/medic/ai/forecon/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == PFC_VARIANT)
		gear_preset = gear_preset_quaternary
	if(option == LCPL_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == CPL_VARIANT)
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/medic/upp
	name = JOB_SQUAD_MEDIC_UPP
	squad = SQUAD_UPP
	job = /datum/job/marine/medic/ai/upp

/datum/job/marine/medic/ai/upp/forecon
	title = JOB_SQUAD_MEDIC_FORECON_UPP
	gear_preset = /datum/equipment_preset/uscm/medic/upp/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/medic/upp/forecon/junior_sergeant
	gear_preset_tertiary = /datum/equipment_preset/uscm/medic/upp/forecon/corporal
	gear_preset_quaternary = /datum/equipment_preset/uscm/medic/upp/forecon/senior_private
	job_options = list(SR_PVT_VARIANT = "SrPVT", CPL_VARIANT = "CPL", JSGT_VARIANT = "JrSGT", SGT_VARIANT = "SGT")

/obj/effect/landmark/start/marine/medic/upp/forecon
	name = JOB_SQUAD_MEDIC_FORECON_UPP
	squad = SQUAD_SISSI
	job = /datum/job/marine/medic/ai/upp/forecon


/datum/job/marine/medic/ai/pmc
	title = JOB_PMCPLAT_MEDIC
	gear_preset = /datum/equipment_preset/uscm/pmc/med
	job_options = null

/obj/effect/landmark/start/marine/medic/pmc
	name = JOB_PMCPLAT_MEDIC
	squad = SQUAD_PMCPLT
	job = /datum/job/marine/medic/ai/pmc

/datum/job/marine/medic/ai/pmc/small
	title = JOB_PMCPLAT_SMALL_MEDIC
	gear_preset = /datum/equipment_preset/uscm/pmc/med
	job_options = null

/obj/effect/landmark/start/marine/medic/pmc/small
	name = JOB_PMCPLAT_SMALL_MEDIC
	squad = SQUAD_PMCPLT_SMALL
	job = /datum/job/marine/medic/ai/pmc/small

/obj/effect/landmark/start/marine/medic/forecon
	name = JOB_SQUAD_MEDIC_FORECON
	squad = SQUAD_LRRP
	job = /datum/job/marine/medic/ai/forecon

//-- RMC Platoon --//
//Medical Assistant//

/datum/job/marine/medic/ai/rmc
	title = JOB_TWE_RMC_MEDIC
	gear_preset = /datum/equipment_preset/uscm/rmc/med
	job_options = null
	supervisors = "the section leader and troop commander"
	entry_message_body = "You are a commando-trained member of the Royal Navy Medical Service, serving with the Royal Marines Commando forces. You tend the serious wounds of the Royal Marines under your charge and make sure they are healthy and active. Whilst you have the skills to rival doctors, you often lack the full compliment of equipment, but you stand between life and death when it matters.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your equipment can be located in the Sick Bay.</b>"

/obj/effect/landmark/start/marine/medic/rmc
	name = JOB_TWE_RMC_MEDIC
	squad = SQUAD_RMC
	job = /datum/job/marine/medic/ai/rmc

#undef SGT_VARIANT
#undef JSGT_VARIANT
#undef CPL_VARIANT
#undef LCPL_VARIANT
#undef PFC_VARIANT
#undef SR_PVT_VARIANT
#undef PVT_VARIANT
