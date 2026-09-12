/datum/job/civilian/liaison
	title = JOB_CORPORATE_LIAISON
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Wey-Yu corporate office"
	selection_class = "job_cl"
	flags_startup_parameters = ROLE_ADD_TO_DEFAULT
	gear_preset = /datum/equipment_preset/uscm_ship/liaison
	entry_message_body = "As a <a href='"+WIKI_PLACEHOLDER+"'>representative of Weyland-Yutani Corporation</a>, your job requires you to stay in character at all times. You are not required to follow military orders; however, you cannot give military orders. Your primary job is to observe and ensure that the situation does not negatively impact Weyland-Yutani operations and profit margins, as well as your own standing within the company. Assist the detachment where necessary but remember that your primary concern is that of the company."
	var/mob/living/carbon/human/active_liaison

/datum/job/civilian/liaison/generate_entry_conditions(mob/living/liaison, whitelist_status)
	. = ..()
	active_liaison = liaison
	RegisterSignal(liaison, COMSIG_PARENT_QDELETING, PROC_REF(cleanup_active_liaison))

/datum/job/civilian/liaison/proc/cleanup_active_liaison(mob/liaison)
	SIGNAL_HANDLER
	active_liaison = null

/obj/effect/landmark/start/liaison
	name = JOB_CORPORATE_LIAISON
	icon_state = "cl_spawn"
	job = /datum/job/civilian/liaison

/datum/job/civilian/advisor
	title = JOB_ADVISOR
	total_positions = 1
	spawn_positions = 1
	gear_preset = /datum/equipment_preset/uscm_ship/advisor
	supervisors = "the Wey-Yu corporate office"
	selection_class = "job_ca"
	entry_message_body = "You are a witness and survivor to the horrors of the void, having encountered a xenomorphic entity that lead to the deaths of your colleagues. Your current duty, while being a non-combatant, is to provide insight and support to the detachment to which you have been assigned. Do you what you can to safeguard humanity against this grave threat it presents to your species."

/obj/effect/landmark/start/advisor
	name = JOB_ADVISOR
	job = /datum/job/civilian/advisor

/datum/job/civilian/advisor_upp
	title = JOB_UPP_ADVISOR
	total_positions = 1
	spawn_positions = 1
	gear_preset = /datum/equipment_preset/uscm_ship/advisor_upp
	supervisors = "the acting Commanding Officer"
	selection_class = "job_ca"
	entry_message_body = "You are a witness and survivor to the horrors of the void, having encountered a xenogenetic entity that lead to the deaths of your colleagues. Your current duty, while being a non-combatant, is to provide insight and support to the detachment to which you have been assigned. Do you what you can to safeguard humanity against this grave threat it presents to your species."

/obj/effect/landmark/start/advisor_upp
	name = JOB_UPP_ADVISOR
	job = /datum/job/civilian/advisor_upp
