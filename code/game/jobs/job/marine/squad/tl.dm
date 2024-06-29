
#define SGT_VARIANT "Sergeant"

/datum/job/marine/tl
	title = JOB_SQUAD_TEAM_LEADER
	squad_root_title = JOB_SQUAD_TEAM_LEADER
	total_positions = 8
	spawn_positions = 8
	allow_additional = 1
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT|ROLE_ADD_TO_SQUAD
	gear_preset = /datum/equipment_preset/uscm/tl
	entry_message_body = "You are the <a href='"+WIKI_PLACEHOLDER+"'>Squad Leader.</a> Your task is leading the designated squad and utilize available ordnance. If the platoon leader dies, you are expected to lead in their place.<br><b>You remember that you've stored your personal gear and uniform are located in the dorm or locker rooms.</b>"

	job_options = list(SGT_VARIANT = "SGT")

/datum/job/marine/tl/generate_entry_conditions(mob/living/carbon/human/spawning_human)
	. = ..()
	spawning_human.important_radio_channels += JTAC_FREQ

AddTimelock(/datum/job/marine/tl, list(
	JOB_SQUAD_ROLES = 8 HOURS
))

/datum/job/marine/tl/uscm_ground
	title = JOB_USCM_GROUND_SQUAD_TEAM_LEADER
	total_positions = 4
	spawn_positions = 4
	gear_preset = /datum/equipment_preset/uscm/tl/uscm_ground
	entry_message_body = "You were deemed competent enough to lead a squad. Act accordingly. Make sure your squad stays together and accounted for. Report to the platoon leader and help them get the job done."

/obj/effect/landmark/start/marine/tl
	name = JOB_SQUAD_TEAM_LEADER
	icon_state = "tl_spawn"
	job = /datum/job/marine/tl

/obj/effect/landmark/start/marine/tl/alpha
	icon_state = "tl_spawn_alpha"
	squad = SQUAD_MARINE_1

/obj/effect/landmark/start/marine/tl/bravo
	icon_state = "tl_spawn_bravo"
	squad = SQUAD_MARINE_2

/obj/effect/landmark/start/marine/tl/charlie
	icon_state = "tl_spawn_charlie"
	squad = SQUAD_MARINE_3

/obj/effect/landmark/start/marine/tl/delta
	icon_state = "tl_spawn_delta"
	squad = SQUAD_MARINE_4

/obj/effect/landmark/start/marine/tl/uscm_ground
	name = JOB_USCM_GROUND_SQUAD_TEAM_LEADER
	job = /datum/job/marine/tl/uscm_ground

/datum/job/marine/tl/ai
	total_positions = 2
	spawn_positions = 2
	squad_default_path = /datum/squad/marine/alpha

/datum/job/marine/tl/ai/upp
	title = JOB_SQUAD_TEAM_LEADER_UPP
	gear_preset = /datum/equipment_preset/uscm/tl/upp
	squad_default_path = /datum/squad/marine/upp

/datum/job/marine/tl/ai/forecon
	total_positions = 1
	spawn_positions = 1
	title = JOB_SQUAD_TEAM_LEADER_FORECON
	gear_preset = /datum/equipment_preset/uscm/tl/forecon
	squad_default_path = /datum/squad/marine/forecon

/obj/effect/landmark/start/marine/tl/upp
	name = JOB_SQUAD_TEAM_LEADER_UPP
	squad = SQUAD_UPP
	job = /datum/job/marine/tl/ai/upp

/obj/effect/landmark/start/marine/tl/forecon
	name = JOB_SQUAD_TEAM_LEADER_FORECON
	squad = SQUAD_LRRP
	job = /datum/job/marine/tl/ai/forecon

#undef SGT_VARIANT
