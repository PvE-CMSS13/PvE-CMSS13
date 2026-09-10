#define SGT_VARIANT "Sergeant"
#define JSGT_VARIANT "Junior Sergeant"
#define CPL_VARIANT "Corporal"
#define LCPL_VARIANT "Lance Corporal"
#define PFC_VARIANT "Private First Class"
#define SR_PVT_VARIANT "Senior Private"
#define PVT_VARIANT "Private"

/datum/job/marine/smartgunner
	title = JOB_SQUAD_SMARTGUN
	total_positions = 4
	spawn_positions = 4
	allow_additional = 1
	scaled = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/sg
	gear_preset_secondary = /datum/equipment_preset/uscm/sg/lance_corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/sg/pfc
	gear_preset_quaternary = /datum/equipment_preset/uscm/sg/private
	entry_message_body = "<a href='"+WIKI_PLACEHOLDER+"'>You are a specialized automatic rifleman.</a> Your task is to provide heavy weapons support for your squad.<br>You might be the same rank as a squad leader, but they have precedence over you for command should the situation call upon it.<br><b>You remember that you've stored your personal gear and uniform are located in the dorm or locker rooms.</b>"

	job_options = list(PVT_VARIANT = "PVT", PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL", CPL_VARIANT = "CPL")

/datum/job/marine/smartgunner/set_spawn_positions(count)
	spawn_positions = sg_slot_formula(count)

/datum/job/marine/smartgunner/get_total_positions(latejoin = 0)
	var/positions = spawn_positions
	if(latejoin)
		positions = sg_slot_formula(get_total_marines())
		if(positions <= total_positions_so_far)
			positions = total_positions_so_far
		else
			total_positions_so_far = positions
	else
		total_positions_so_far = positions
	return positions

/datum/job/marine/smartgunner/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == PVT_VARIANT)
		gear_preset = gear_preset_quaternary
	if(option == PFC_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == LCPL_VARIANT)
		gear_preset = gear_preset_secondary

/datum/job/marine/smartgunner/whiskey
	title = JOB_WO_SQUAD_SMARTGUNNER
	flags_startup_parameters = ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/wo/marine/sg

/obj/effect/landmark/start/marine/smartgunner
	name = JOB_SQUAD_SMARTGUN
	icon_state = "smartgunner_spawn"
	job = /datum/job/marine/smartgunner

/obj/effect/landmark/start/marine/smartgunner/alpha
	icon_state = "smartgunner_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/smartgunner/bravo
	icon_state = "smartgunner_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/smartgunner/charlie
	icon_state = "smartgunner_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/smartgunner/delta
	icon_state = "smartgunner_spawn_delta"
	squad = SQUAD_MARINE_4

/datum/job/marine/smartgunner/ai
	total_positions = 2
	spawn_positions = 2

/datum/job/marine/smartgunner/ai/set_spawn_positions(count)
	return spawn_positions

/datum/job/marine/smartgunner/ai/get_total_positions(latejoin = 0)
	return latejoin ? total_positions : spawn_positions

/datum/job/marine/smartgunner/ai/upp
	title = JOB_SQUAD_SMARTGUN_UPP
	gear_preset = /datum/equipment_preset/uscm/sg/upp
	gear_preset_secondary = /datum/equipment_preset/uscm/sg/upp/corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/sg/upp/senior_private
	gear_preset_quaternary = /datum/equipment_preset/uscm/sg/upp/private
	job_options = list(PVT_VARIANT = "PVT", SR_PVT_VARIANT = "SrPVT", CPL_VARIANT = "CPL", JSGT_VARIANT = "JrSGT")

/datum/job/marine/smartgunner/ai/upp/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == PVT_VARIANT)
		gear_preset = gear_preset_quaternary
	if(option == SR_PVT_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == CPL_VARIANT)
		gear_preset = gear_preset_secondary

/datum/job/marine/smartgunner/ai/forecon
	title = JOB_SQUAD_SMARTGUN_FORECON
	total_positions = 1
	spawn_positions = 1
	gear_preset = /datum/equipment_preset/uscm/sg/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/sg/forecon/corporal
	gear_preset_tertiary = /datum/equipment_preset/uscm/sg/forecon/lance_corporal
	gear_preset_quaternary = /datum/equipment_preset/uscm/sg/forecon/pfc
	job_options = list(PFC_VARIANT = "PFC", LCPL_VARIANT = "LCPL", CPL_VARIANT = "CPL", SGT_VARIANT = "SGT")

/datum/job/marine/smartgunner/ai/forecon/handle_job_options(option)
	gear_preset = initial(gear_preset)
	if(option == PFC_VARIANT)
		gear_preset = gear_preset_quaternary
	if(option == LCPL_VARIANT)
		gear_preset = gear_preset_tertiary
	if(option == CPL_VARIANT)
		gear_preset = gear_preset_secondary

/obj/effect/landmark/start/marine/smartgunner/upp
	name = JOB_SQUAD_SMARTGUN_UPP
	job = JOB_SQUAD_SMARTGUN_UPP
	squad = SQUAD_UPP

/datum/job/marine/smartgunner/ai/upp/forecon
	title = JOB_SQUAD_SMARTGUN_FORECON_UPP
	total_positions = 1
	spawn_positions = 1
	gear_preset = /datum/equipment_preset/uscm/sg/upp/forecon
	gear_preset_secondary = /datum/equipment_preset/uscm/sg/upp/forecon/junior_sergeant
	gear_preset_tertiary = /datum/equipment_preset/uscm/sg/upp/forecon/corporal
	gear_preset_quaternary = /datum/equipment_preset/uscm/sg/upp/forecon/senior_private
	job_options = list(SR_PVT_VARIANT = "SrPVT", CPL_VARIANT = "CPL", JSGT_VARIANT = "JrSGT", SGT_VARIANT = "SGT")

/obj/effect/landmark/start/marine/smartgunner/upp/forecon
	name = JOB_SQUAD_SMARTGUN_FORECON_UPP
	job = JOB_SQUAD_SMARTGUN_FORECON_UPP
	squad = SQUAD_SISSI

/datum/job/marine/smartgunner/ai/pmc
	title = JOB_PMCPLAT_SG
	gear_preset = /datum/equipment_preset/uscm/pmc/sg
	job_options = null

/obj/effect/landmark/start/marine/smartgunner/pmc
	name = JOB_PMCPLAT_SG
	squad = SQUAD_PMCPLT

/datum/job/marine/smartgunner/ai/pmc/small
	title = JOB_PMCPLAT_SMALL_SG
	gear_preset = /datum/equipment_preset/uscm/pmc/sg
	job_options = null
	total_positions = 1
	spawn_positions = 1

/obj/effect/landmark/start/marine/smartgunner/pmc/small
	name = JOB_PMCPLAT_SMALL_SG
	squad = SQUAD_PMCPLT_SMALL
	job = /datum/job/marine/smartgunner/ai/pmc/small

/obj/effect/landmark/start/marine/smartgunner/forecon
	name = JOB_SQUAD_SMARTGUN_FORECON
	job = JOB_SQUAD_SMARTGUN_FORECON
	squad = SQUAD_LRRP

//-- RMC Platoon --//
//Smartgunner//

/datum/job/marine/smartgunner/ai/rmc
	title = JOB_TWE_RMC_SMARTGUNNER
	total_positions = 1
	spawn_positions = 1
	gear_preset = /datum/equipment_preset/uscm/rmc/sg
	job_options = null
	supervisors = "the team leader and troop commander"
	entry_message_body = "You are a specialized automatic rifleman in the Royal Marines Commando. Your task is to provide heavy weapons support for the Rifle Section as part of the Fire Support Team.<br><b>You remember that you've stored your personal gear and uniform in the locker rooms, and that your specialist equipment can be located in the armoury.</b>"

/obj/effect/landmark/start/marine/smartgunner/rmc
	name = JOB_TWE_RMC_SMARTGUNNER
	job = JOB_TWE_RMC_SMARTGUNNER
	squad = SQUAD_RMC

#undef SGT_VARIANT
#undef JSGT_VARIANT
#undef CPL_VARIANT
#undef LCPL_VARIANT
#undef PFC_VARIANT
#undef SR_PVT_VARIANT
#undef PVT_VARIANT
