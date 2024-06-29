/datum/game_mode/colonialmarines/ai
	name = "Distress Signal: Lowpop"
	config_tag = "Distress Signal: Lowpop"
	required_players = 0
	votable = TRUE

	flags_round_type = MODE_INFESTATION|MODE_NEW_SPAWN|MODE_NO_XENO_EVOLVE|MODE_XENO_AI

	var/initial_objectives = 0
	var/game_started = FALSE

	static_comms_amount = 0
	requires_comms = FALSE
	toggleable_flags = MODE_NO_JOIN_AS_XENO|MODE_HARDCORE_PERMA

/datum/game_mode/colonialmarines/ai/post_setup()
	set_lz_resin_allowed(TRUE)
	return ..()

/datum/game_mode/colonialmarines/ai/announce_bioscans()
	return

/datum/game_mode/colonialmarines/ai/check_queen_status()
	return

/datum/game_mode/colonialmarines/ai/check_win()
	if(!game_started || round_finished || SSticker.current_state != GAME_STATE_PLAYING)
		return

/datum/game_mode/colonialmarines/ai/get_roles_list(default_platoon = FALSE)
	var/possible_platoons = default_platoon || MAIN_SHIP_PLATOON
	switch(possible_platoons)
		if(/datum/squad/marine/alpha)
			return ROLES_AI
		if(/datum/squad/marine/upp)
			return ROLES_AI_UPP
		if(/datum/squad/marine/forecon)
			return ROLES_AI_FORECON
		else
			return ROLES_AI // The default option, in case we need to reference it.
