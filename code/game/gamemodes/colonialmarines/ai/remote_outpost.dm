
/datum/game_mode/remote_outpost
	name = GAMEMODE_REMOTE_OUTPOST
	config_tag = GAMEMODE_REMOTE_OUTPOST
	votable = TRUE
	flags_round_type = MODE_GROUND_ONLY|MODE_NO_XENO_EVOLVE|MODE_NEW_SPAWN|MODE_XENO_AI
	toggleable_flags = MODE_NO_JOIN_AS_XENO|MODE_HARDCORE_PERMA

	taskbar_icon = 'icons/taskbar/gml_wo.png'

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

	for(var/obj/I in GLOB.observer_starts)
		if(!(I.z in SSmapping.levels_by_trait(ZTRAIT_GROUND)))
			qdel(I) //So ghosts spawn in near the action, but not strictly necessary.

	for(var/obj/effect/landmark/defense_sentry/I in GLOB.landmarks_list) //Spawns some stronger than normal static sentries, but only when the round is set to Outpost.
		if(I.z in SSmapping.levels_by_trait(ZTRAIT_GROUND))
			new /obj/structure/machinery/defenses/sentry/premade/strong(I.loc)
			qdel(I)

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
