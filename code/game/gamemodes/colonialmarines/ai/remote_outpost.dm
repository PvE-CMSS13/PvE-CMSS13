/datum/game_mode/remote_outpost
	name = GAMEMODE_REMOTE_OUTPOST
	config_tag = GAMEMODE_REMOTE_OUTPOST
	votable = TRUE
	flags_round_type = MODE_GROUND_ONLY|MODE_NO_XENO_EVOLVE|MODE_NEW_SPAWN|MODE_INFESTATION
	taskbar_icon = 'icons/taskbar/gml_wo.png'
	var/game_started = FALSE

	var/list/squad_limit = list(
		/datum/squad/marine/charlie,
		/datum/squad/marine/delta,
	)

	role_mappings = list(
		JOB_USCM_GROUND_CO,
		JOB_USCM_GROUND_AO,
		JOB_USCM_GROUND_SYNTH,
		JOB_USCM_GROUND_SQUAD_LEADER,
		JOB_USCM_GROUND_SQUAD_TEAM_LEADER,
		JOB_USCM_GROUND_SQUAD_MEDIC,
		JOB_USCM_GROUND_SQUAD_ENGI,
		JOB_USCM_GROUND_SQUAD_SPECIALIST,
		JOB_USCM_GROUND_SQUAD_SMARTGUNNER,
		JOB_USCM_GROUND_SQUAD_MARINE,
		JOB_USCM_GROUND_CIVILIAN,
	)

	static_comms_amount = 0
	requires_comms = FALSE
	toggleable_flags = MODE_NO_JOIN_AS_XENO|MODE_HARDCORE_PERMA|MODE_DISABLE_FS_PORTRAIT

/datum/game_mode/remote_outpost/pre_setup()
	if(SSmapping.configs[GROUND_MAP].map_item_type)
		var/type_to_spawn = SSmapping.configs[GROUND_MAP].map_item_type
		for(var/i in GLOB.map_items)
			var/turf/T = get_turf(i)
			qdel(i)
			new type_to_spawn(T)

	for(var/obj/effect/landmark/late_join/I in GLOB.landmarks_list)
		if(!(I.z in SSmapping.levels_by_trait(ZTRAIT_GROUND)))
			qdel(I) //We don't want people to late-join somewhere they shouldn't.

	for(var/obj/I in GLOB.observer_starts)
		if(!(I.z in SSmapping.levels_by_trait(ZTRAIT_GROUND)))
			qdel(I) //So ghosts spawn in near the action, but not strictly necessary.

	RegisterSignal(SSdcs, COMSIG_GLOB_XENO_SPAWN, PROC_REF(handle_xeno_spawn))
	squad_limit.Cut()
	squad_limit += OUTPOST_FIRST_PLATOON
	squad_limit += OUTPOST_SECOND_PLATOON
	for(var/i in squad_limit)
		role_mappings = GLOB.outpost_jobs[i]
	GLOB.RoleAuthority.reset_roles()
	for(var/datum/squad/squad in GLOB.RoleAuthority.squads)
		if(squad.type in squad_limit)
			continue
		GLOB.RoleAuthority.squads -= squad
		GLOB.RoleAuthority.squads_by_type -= squad.type

	GLOB.RoleAuthority.squads += OUTPOST_FIRST_PLATOON
	GLOB.RoleAuthority.squads += OUTPOST_SECOND_PLATOON
	GLOB.RoleAuthority.squads_by_type += OUTPOST_FIRST_PLATOON
	GLOB.RoleAuthority.squads_by_type += OUTPOST_SECOND_PLATOON
//Brute force, but the migraine compels me to finish this quicker

	. = ..()

GLOBAL_LIST_INIT(outpost_jobs, list(/datum/squad/marine/charlie = list(/datum/job/command/commander/uscm_ground = JOB_USCM_GROUND_CO,\
		/datum/job/command/executive/uscm_ground = JOB_USCM_GROUND_AO,\
		/datum/job/civilian/synthetic/uscm_ground = JOB_USCM_GROUND_SYNTH,\
		/datum/job/civilian/researcher/uscm_ground = JOB_USCM_GROUND_CIVILIAN,\
		/datum/job/marine/leader/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_LEADER,\
		/datum/job/marine/tl/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_TEAM_LEADER,\
		/datum/job/marine/medic/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_MEDIC,\
		/datum/job/marine/engineer/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_ENGI,\
		/datum/job/marine/specialist/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_SPECIALIST,\
		/datum/job/marine/smartgunner/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_SMARTGUNNER,\
		/datum/job/marine/standard/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_MARINE),\
		/datum/squad/marine/delta = list(/datum/job/command/commander/uscm_ground = JOB_USCM_GROUND_CO,\
		/datum/job/command/executive/uscm_ground = JOB_USCM_GROUND_AO,\
		/datum/job/civilian/synthetic/uscm_ground = JOB_USCM_GROUND_SYNTH,\
		/datum/job/civilian/researcher/uscm_ground = JOB_USCM_GROUND_CIVILIAN,\
		/datum/job/marine/leader/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_LEADER,\
		/datum/job/marine/tl/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_TEAM_LEADER,\
		/datum/job/marine/medic/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_MEDIC,\
		/datum/job/marine/engineer/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_ENGI,\
		/datum/job/marine/specialist/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_SPECIALIST,\
		/datum/job/marine/smartgunner/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_SMARTGUNNER,\
		/datum/job/marine/standard/ai/uscm_ground = JOB_USCM_GROUND_SQUAD_MARINE)))


/datum/game_mode/remote_outpost/announce()
	to_chat_spaced(world, type = MESSAGE_TYPE_SYSTEM, html = SPAN_ROUNDHEADER("This is the story of a remote USCM outpost near [SSmapping.configs[GROUND_MAP].map_name]!"))

/datum/game_mode/remote_outpost/check_finished()
	return round_finished

/datum/game_mode/remote_outpost/declare_completion()
	announce_ending()
	var/musical_track = pick('sound/theme/neutral_hopeful1.ogg','sound/theme/sad_loss2.ogg','sound/theme/neutral_melancholy2.ogg')
	var/sound/S = sound(musical_track, channel = SOUND_CHANNEL_LOBBY)
	S.status = SOUND_STREAM
	sound_to(world, S)
	if(GLOB.round_statistics)
		GLOB.round_statistics.game_mode = name
		GLOB.round_statistics.round_length = world.time
		GLOB.round_statistics.round_result = round_finished
		GLOB.round_statistics.end_round_player_population = length(GLOB.clients)

		GLOB.round_statistics.log_round_statistics()

	calculate_end_statistics()
	show_end_statistics()

	declare_completion_announce_fallen_soldiers()
	declare_completion_announce_medal_awards()
	declare_fun_facts()


	return TRUE


/datum/game_mode/remote_outpost/post_setup()
	set_lz_resin_allowed(TRUE)
	update_RO_controllers()
	return ..()

/datum/game_mode/remote_outpost/announce_bioscans()
	return

/datum/game_mode/remote_outpost/end_round_message()
	return ..()

/datum/game_mode/remote_outpost/proc/handle_xeno_spawn(datum/source, mob/living/carbon/xenomorph/spawning_xeno, ai_hard_off = FALSE)
	SIGNAL_HANDLER
	if(ai_hard_off)
		return

	spawning_xeno.make_ai()

/datum/game_mode/remote_outpost/check_win()
	if(!game_started || round_finished || SSticker.current_state != GAME_STATE_PLAYING)
		return

/datum/game_mode/remote_outpost/get_roles_list()
	return GLOB.ROLES_BLACKSTONE

//this calls  self-setting headsets for marines AFTER they are assigned squads
/datum/game_mode/remote_outpost/proc/self_set_outpost_headset(mob/living/carbon/human/H)
	if(!istype(H))
		return
	if(SSticker.mode == GAMEMODE_REMOTE_OUTPOST || GLOB.master_mode == GAMEMODE_REMOTE_OUTPOST)
		var/obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground/outpost_headset = H.get_type_in_ears(/obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground)
		if(outpost_headset)
			outpost_headset.self_set()

/datum/game_mode/remote_outpost/proc/update_RO_controllers()
	//Update controllers while we're on this mode
	if(SSitem_cleanup)
		//Cleaning stuff more aggressively
		SSitem_cleanup.start_processing_time = 0
		SSitem_cleanup.percentage_of_garbage_to_delete = 1
		SSitem_cleanup.wait = 1 MINUTES
		SSitem_cleanup.next_fire = 1 MINUTES
		spawn(0)
			//Deleting shipmap, for performance!
			SSitem_cleanup.delete_almayer()
