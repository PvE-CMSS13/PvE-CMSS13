
/datum/game_mode/remote_outpost
	name = GAMEMODE_REMOTE_OUTPOST
	config_tag = GAMEMODE_REMOTE_OUTPOST
	votable = TRUE
	flags_round_type = MODE_GROUND_ONLY|MODE_NO_XENO_EVOLVE|MODE_NEW_SPAWN

	taskbar_icon = 'icons/taskbar/gml_wo.png'

	role_mappings = list(
		/datum/job/command/commander/uscm_ground = JOB_USCM_GROUND_CO,
		/datum/job/command/executive/uscm_ground = JOB_USCM_GROUND_AO,
		/datum/job/civilian/researcher/uscm_ground = JOB_USCM_GROUND_CIVILIAN,

		/datum/job/marine/leader/uscm_ground = JOB_USCM_GROUND_SQUAD_LEADER,
		/datum/job/marine/tl/uscm_ground = JOB_USCM_GROUND_SQUAD_TEAM_LEADER,
		/datum/job/marine/specialist/uscm_ground = JOB_USCM_GROUND_SQUAD_SPECIALIST,
		/datum/job/marine/smartgunner/uscm_ground = JOB_USCM_GROUND_SQUAD_SMARTGUNNER,
		/datum/job/marine/medic/uscm_ground = JOB_USCM_GROUND_SQUAD_MEDIC,
		/datum/job/marine/standard/uscm_ground = JOB_USCM_GROUND_SQUAD_MARINE,
		/datum/job/civilian/synthetic/uscm_ground = JOB_USCM_GROUND_SYNTH,
		)

/datum/game_mode/remote_outpost/get_roles_list()
	return ROLES_USCM_GROUND

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

	. = ..()

/datum/game_mode/remote_outpost/announce()
	to_chat_spaced(world, type = MESSAGE_TYPE_SYSTEM, html = SPAN_ROUNDHEADER("This is the story of a remote USCM outpost near [SSmapping.configs[GROUND_MAP].map_name]!"))

/datum/game_mode/remote_outpost/post_setup()
	initialize_post_marine_gear_list()
	. = ..()

/datum/game_mode/remote_outpost/check_finished()
	return round_finished

/datum/game_mode/remote_outpost/declare_completion()
	announce_ending()
	var/musical_track = pick('sound/theme/neutral_hopeful1.ogg','sound/theme/sad_loss2.ogg','sound/theme/neutral_melancholy2.ogg')
	var/sound/S = sound(musical_track, channel = SOUND_CHANNEL_LOBBY)
	S.status = SOUND_STREAM
	sound_to(world, S)
	if(round_statistics)
		round_statistics.game_mode = name
		round_statistics.round_length = world.time
		round_statistics.round_result = round_finished
		round_statistics.end_round_player_population = GLOB.clients.len

		round_statistics.log_round_statistics()

	calculate_end_statistics()
	show_end_statistics("draw")
	//I'll likely add better tracking at a later time. A lot of it can be folded over from colonialmarines.dm and into the game_mode parent.
	declare_completion_announce_fallen_soldiers()
	declare_completion_announce_medal_awards()

	return TRUE

