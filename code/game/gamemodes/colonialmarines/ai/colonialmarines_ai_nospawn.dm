/datum/game_mode/colonialmarines/ai/no_spawn
	name = "Distress Signal: Lowpop (No Spawn)"
	config_tag = "Distress Signal: Lowpop (No Spawn)"
	flags_round_type = MODE_INFESTATION|MODE_NO_LATEJOIN|MODE_NO_SPAWN|MODE_NO_XENO_EVOLVE|MODE_XENO_AI
	votable = FALSE

/datum/game_mode/colonialmarines/ai/no_spawn/post_setup()
	for(var/mob/new_player/np in GLOB.new_player_list)
		np.new_player_panel_proc()
	round_time_lobby = world.time
	return ..()
