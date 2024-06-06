/datum/game_mode/colonialmarines/ai
	name = "Distress Signal: Lowpop"
	config_tag = "Distress Signal: Lowpop"
	required_players = 0
	votable = TRUE

	flags_round_type = MODE_INFESTATION|MODE_NEW_SPAWN|MODE_NO_XENO_EVOLVE

	var/list/squad_limit = list(
		/datum/squad/marine/alpha
	)

	var/list/objectives = list()
	var/initial_objectives = 0

	var/game_started = FALSE

	role_mappings = list(
		/datum/job/command/bridge/ai = JOB_SO,
		/datum/job/marine/leader/ai = JOB_SQUAD_LEADER,
		/datum/job/marine/medic/ai = JOB_SQUAD_MEDIC,
		/datum/job/marine/tl/ai = JOB_SQUAD_TEAM_LEADER,
		/datum/job/marine/smartgunner/ai = JOB_SQUAD_SMARTGUN,
		/datum/job/marine/standard/ai = JOB_SQUAD_MARINE,
	)

	static_comms_amount = 0
	requires_comms = FALSE
	toggleable_flags = MODE_NO_JOIN_AS_XENO|MODE_HARDCORE_PERMA

/datum/game_mode/colonialmarines/ai/can_start()
	return ..()

/datum/game_mode/colonialmarines/ai/pre_setup()
	RegisterSignal(SSdcs, COMSIG_GLOB_XENO_SPAWN, PROC_REF(handle_xeno_spawn))
	squad_limit.Cut()
	squad_limit += MAIN_SHIP_PLATOON
	for(var/i in squad_limit)
		role_mappings = GLOB.platoon_to_jobs[i]
	RoleAuthority.reset_roles()
	for(var/datum/squad/sq in RoleAuthority.squads)
		if(sq.type in squad_limit)
			GLOB.main_platoon_name = sq.name
			GLOB.main_platoon_initial_name = sq.name


	for(var/datum/squad/squad in RoleAuthority.squads)
		if(squad.type in squad_limit)
			continue
		RoleAuthority.squads -= squad
		RoleAuthority.squads_by_type -= squad.type


	. = ..()

/datum/game_mode/colonialmarines/ai/post_setup()
	set_lz_resin_allowed(TRUE)
	return ..()

/datum/game_mode/colonialmarines/ai/announce_bioscans()
	return

/datum/game_mode/colonialmarines/ai/end_round_message()
	return ..()

/datum/game_mode/colonialmarines/ai/proc/handle_xeno_spawn(datum/source, mob/living/carbon/xenomorph/spawning_xeno, ai_hard_off = FALSE)
	SIGNAL_HANDLER
	if(ai_hard_off)
		return

	spawning_xeno.make_ai()

/datum/game_mode/colonialmarines/ai/check_win()
	if(!game_started || round_finished || SSticker.current_state != GAME_STATE_PLAYING)
		return

/datum/game_mode/colonialmarines/ai/get_roles_list()
	return GLOB.platoon_to_role_list[MAIN_SHIP_PLATOON]

/datum/game_mode/colonialmarines/ai/check_queen_status()
	return

GLOBAL_LIST_INIT(platoon_to_jobs, list(/datum/squad/marine/alpha = list(/datum/job/command/bridge/ai = JOB_SO,\
		/datum/job/marine/leader/ai = JOB_SQUAD_LEADER,\
		/datum/job/marine/medic/ai = JOB_SQUAD_MEDIC,\
		/datum/job/marine/tl/ai = JOB_SQUAD_TEAM_LEADER,
		/datum/job/marine/smartgunner/ai = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/standard/ai = JOB_SQUAD_MARINE),\
		/datum/squad/marine/upp = list(/datum/job/command/bridge/ai/upp = JOB_SO,\
		/datum/job/marine/leader/ai/upp = JOB_SQUAD_LEADER,\
		/datum/job/marine/medic/ai/upp = JOB_SQUAD_MEDIC,\
		/datum/job/marine/tl/ai/upp = JOB_SQUAD_TEAM_LEADER,
		/datum/job/marine/smartgunner/ai/upp = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/standard/ai/upp = JOB_SQUAD_MARINE),
		/datum/squad/marine/pmc = list(/datum/job/marine/tl/ai/pmc = JOB_SQUAD_MARINE,\
		/datum/job/marine/standard/ai/pmc =  JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/medic/ai/pmc = JOB_SQUAD_MEDIC,\
		/datum/job/marine/smartgunner/ai/pmc = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/leader/ai/pmc = JOB_SQUAD_LEADER,\
		/datum/job/command/bridge/ai/pmc = JOB_PMCPLAT_OW),\
		/datum/squad/marine/forecon = list(/datum/job/marine/standard/ai/forecon = JOB_SQUAD_MARINE,\
		/datum/job/marine/standard/ai/rto = JOB_SQUAD_RTO,\
		/datum/job/marine/leader/ai/forecon = JOB_SQUAD_LEADER,\
		/datum/job/marine/medic/ai/forecon = JOB_SQUAD_MEDIC,\
		/datum/job/marine/tl/ai/forecon = JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/smartgunner/ai/forecon = JOB_SQUAD_SMARTGUN)))

GLOBAL_LIST_INIT(platoon_to_role_list, list(/datum/squad/marine/alpha = ROLES_AI,\
												/datum/squad/marine/upp = ROLES_AI_UPP,\
												/datum/squad/marine/pmc = ROLES_PMCPLT,\
												/datum/squad/marine/forecon = ROLES_AI_FORECON))

