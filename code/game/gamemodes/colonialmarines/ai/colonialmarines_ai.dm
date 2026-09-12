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
	toggleable_flags = MODE_NO_JOIN_AS_XENO|MODE_HARDCORE_PERMA|MODE_DISABLE_FS_PORTRAIT

/datum/game_mode/colonialmarines/ai/can_start()
	return ..()

/datum/game_mode/colonialmarines/ai/pre_setup()
	RegisterSignal(SSdcs, COMSIG_GLOB_XENO_SPAWN, PROC_REF(handle_xeno_spawn))
	squad_limit.Cut()
	squad_limit += MAIN_SHIP_PLATOON
	for(var/i in squad_limit)
		role_mappings = GLOB.platoon_to_jobs[i]
	GLOB.RoleAuthority.reset_roles()
	for(var/datum/squad/sq in GLOB.RoleAuthority.squads)
		if(sq.type in squad_limit)
			GLOB.main_platoon_name = sq.name
			GLOB.main_platoon_initial_name = sq.name

	squad_limit += USCM_AUXILIARY_PLATOON
	squad_limit += FORECON_AUXILIARY_PLATOON
	squad_limit += UPP_AUXILIARY_PLATOON
	squad_limit += PMC_AUXILIARY_PLATOON
	squad_limit += UACG_MEDICAL_SQUAD
	squad_limit += UACG_MORTAR_SQUAD
	squad_limit += UACG_COMMAND_SQUAD
	squad_limit += UACG_SECOND_SQUAD

	for(var/datum/squad/squad in GLOB.RoleAuthority.squads)
		if(squad.type in squad_limit)
			continue
		GLOB.RoleAuthority.squads -= squad
		GLOB.RoleAuthority.squads_by_type -= squad.type

	GLOB.RoleAuthority.squads += USCM_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads += FORECON_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads += UPP_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads += PMC_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads += UACG_MEDICAL_SQUAD
	GLOB.RoleAuthority.squads += UACG_MORTAR_SQUAD
	GLOB.RoleAuthority.squads += UACG_COMMAND_SQUAD
	GLOB.RoleAuthority.squads += UACG_SECOND_SQUAD
	GLOB.RoleAuthority.squads_by_type += USCM_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads_by_type += FORECON_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads_by_type += UPP_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads_by_type += PMC_AUXILIARY_PLATOON
	GLOB.RoleAuthority.squads_by_type += UACG_MEDICAL_SQUAD
	GLOB.RoleAuthority.squads_by_type += UACG_MORTAR_SQUAD
	GLOB.RoleAuthority.squads_by_type += UACG_COMMAND_SQUAD
	GLOB.RoleAuthority.squads_by_type += UACG_SECOND_SQUAD

	. = ..()

/datum/game_mode/colonialmarines/ai/post_setup()
	set_lz_resin_allowed(TRUE)
	spawn_personal_weapon()
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
		/datum/job/marine/tl/ai = JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/smartgunner/ai = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/standard/ai = JOB_SQUAD_MARINE),\
		/datum/squad/marine/upp = list(/datum/job/command/bridge/ai/upp = JOB_SO,\
		/datum/job/marine/leader/ai/upp = JOB_SQUAD_LEADER,\
		/datum/job/marine/medic/ai/upp = JOB_SQUAD_MEDIC,\
		/datum/job/marine/tl/ai/upp = JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/smartgunner/ai/upp = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/standard/ai/upp = JOB_SQUAD_MARINE),\
		/datum/squad/marine/pmc = list(/datum/job/marine/tl/ai/pmc = JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/standard/ai/pmc =  JOB_SQUAD_MARINE,\
		/datum/job/marine/medic/ai/pmc = JOB_SQUAD_MEDIC,\
		/datum/job/marine/smartgunner/ai/pmc = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/leader/ai/pmc = JOB_SQUAD_LEADER,\
		/datum/job/command/bridge/ai/pmc = JOB_PMCPLAT_OW),\
		/datum/squad/marine/forecon = list(/datum/job/marine/standard/ai/forecon = JOB_SQUAD_MARINE,\
		/datum/job/marine/standard/ai/rto = JOB_SQUAD_RTO,\
		/datum/job/marine/leader/ai/forecon = JOB_SQUAD_LEADER,\
		/datum/job/marine/medic/ai/forecon = JOB_SQUAD_MEDIC,\
		/datum/job/marine/tl/ai/forecon = JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/smartgunner/ai/forecon = JOB_SQUAD_SMARTGUN),\
		/datum/squad/marine/pmc/small = list(/datum/job/marine/tl/ai/pmc/small = JOB_SQUAD_TEAM_LEADER,\
		/datum/job/marine/standard/ai/pmc/small =  JOB_SQUAD_MARINE,\
		/datum/job/marine/medic/ai/pmc/small = JOB_SQUAD_MEDIC,\
		/datum/job/marine/smartgunner/ai/pmc/small = JOB_SQUAD_SMARTGUN,\
		/datum/job/marine/leader/ai/pmc/small = JOB_SQUAD_LEADER),\
		/datum/squad/marine/rmc = list(/datum/job/command/bridge/ai/rmc = JOB_TWE_RMC_LIEUTENANT,\
		/datum/job/marine/leader/ai/rmc = JOB_TWE_RMC_TROOPLEADER,\
		/datum/job/marine/tl/ai/rmc = JOB_TWE_RMC_SECTIONLEADER,\
		/datum/job/marine/tl/ai/rmc2ic = JOB_TWE_RMC_TEAMLEADER,\
		/datum/job/marine/smartgunner/ai/rmc = JOB_TWE_RMC_SMARTGUNNER,\
		/datum/job/marine/medic/ai/rmc = JOB_TWE_RMC_MEDIC,\
		/datum/job/marine/engineer/ai/rmc = JOB_TWE_RMC_ENGI,\
		/datum/job/marine/engineer/ai/rmcmortar = JOB_TWE_RMC_BREACHER,\
		/datum/job/marine/specialist/ai/rmc = JOB_TWE_RMC_MARKSMAN,\
		/datum/job/marine/standard/ai/rmc = JOB_TWE_RMC_RIFLEMAN),\
		/datum/squad/marine/uacg = list(/datum/job/command/bridge/ai/uacg = JOB_UACG_OFFICER,\
		/datum/job/command/bridge/ai/uacg/doctor = JOB_UACG_DOCTOR,\
		/datum/job/marine/leader/ai/uacg = JOB_UACG_SENLEAD,\
		/datum/job/marine/leader/ai/uacg/armorer = JOB_UACG_ARMORY,\
		/datum/job/marine/standard/ai/uacg/armory = JOB_UACG_ARMORY_LACKEY,\
		/datum/job/command/bridge/ai/uacg/mess = JOB_UACG_MESS,\
		/datum/job/marine/leader/ai/uacg/chaplain = JOB_UACG_CHAPLAIN,\
		/datum/job/marine/tl/ai/uacg/fires = JOB_UACG_LEAD_FIRE,\
		/datum/job/marine/engineer/ai/uacg/mortar = JOB_UACG_MORTAR,\
		/datum/job/marine/tl/ai/uacg/triage = JOB_UACG_LEAD_MED,\
		/datum/job/marine/medic/ai/uacg/triage = JOB_UACG_MEDIC_TRIAGE,\
		/datum/job/marine/tl/ai/uacg = JOB_UACG_LEAD,\
		/datum/job/marine/medic/ai/uacg = JOB_UACG_MEDIC,\
		/datum/job/marine/engineer/ai/uacg = JOB_UACG_TECH,\
		/datum/job/marine/specialist/ai/uacg = JOB_UACG_DM,\
		/datum/job/marine/smartgunner/ai/uacg = JOB_UACG_GNR,\
		/datum/job/marine/smartgunner/ai/uacg/security = JOB_UACG_SCR_GNR,\
		/datum/job/marine/standard/ai/uacg/security = JOB_UACG_SCR_RIFLE,\
		/datum/job/marine/standard/ai/uacg = JOB_UACG_RIFLE)))

GLOBAL_LIST_INIT(platoon_to_role_list, list(/datum/squad/marine/alpha = ROLES_AI,\
												/datum/squad/marine/upp = ROLES_AI_UPP,\
												/datum/squad/marine/pmc = ROLES_PMCPLT,\
												/datum/squad/marine/forecon = ROLES_AI_FORECON,\
												/datum/squad/marine/pmc/small = ROLES_PMCPLT_SMALL,\
												/datum/squad/marine/rmc = ROLES_RMCTROOP,\
												/datum/squad/marine/uacg = ROLES_UACG))


GLOBAL_LIST_INIT(personal_weapons_list, list("Ithaca 37 shotgun-stakeout" = /obj/item/storage/large_holster/m37/full/noammo,\
											"Ithaca 37 shotgun-traditional" = /obj/item/weapon/gun/shotgun/pump/stock,\
											"Sawn-off double barrel shotgun" = /obj/item/weapon/gun/shotgun/double/sawn,\
											"M79 grenade launcher" = /obj/item/weapon/gun/launcher/grenade/m81/m79/modified,\
											"Cut down M79 grenade launcher" = /obj/item/weapon/gun/launcher/grenade/m81/m79/modified/sawnoff,\
											"4 M15 grenades" = /obj/effect/essentials_set/m15_4_pack))

/datum/game_mode/colonialmarines/ai/proc/spawn_personal_weapon()
	var/datum/squad/squad = locate() in GLOB.RoleAuthority.squads
	if(!squad || squad.faction != FACTION_MARINE || !squad.marines_list.len > 0)
		return
	if(!GLOB.personal_weapon.len)
		return
	var/mob/living/carbon/human/marine
	var/chosen_weapon
	var/iteration = 0 //10 marines with no personal weapon selected? its more likely than you think!
	var/list/temporary_list = squad.marines_list
	while(!chosen_weapon && iteration < squad.marines_list.len)
		iteration++
		marine = pick(temporary_list)
		if(!squad.marines_list.Find(marine))
			chosen_weapon = "bugged"
			break
		if(marine.job == JOB_SO) //get outta here butter bars
			temporary_list.Remove(marine)
			continue
		if(!marine.client)
			temporary_list.Remove(marine)
			continue
		if(marine.client.prefs.personal_weapon == "None")
			temporary_list.Remove(marine)
			continue
		chosen_weapon = marine.client.prefs.personal_weapon
	if(!isnull(chosen_weapon)) //Probably highly unlikely that all marines have it set to None but uhhhhh you never know.
		if(chosen_weapon == "bugged")
			log_debug("Chosen Weapon selected a bugged marine.")
		else
			var/obj/item/storage/box/personalcase/pcase = new(get_turf(pick(GLOB.personal_weapon)))
			pcase.assign_owner(marine.real_name)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), marine, SPAN_NOTICE("You remember that you've successfully snuck in your <b>heirloom weapon</b> aboard: <b>[marine.client.prefs.personal_weapon]</b>. It's in the armory")), 5 SECONDS)
			var/the_gun = GLOB.personal_weapons_list[chosen_weapon]
			new the_gun(pcase)
			for(var/obj/effect/landmark/personal_weapon/PW in GLOB.personal_weapon)
				qdel(PW)
	temporary_list = null
