
#define DEFAULT_SPAWN_XENO_STRING XENO_CASTE_DRONE
#define GAME_MASTER_AMBUSH_AI_XENOS list(XENO_CASTE_DRONE, XENO_CASTE_WARRIOR_DRONE, XENO_CASTE_SOLDIER, XENO_CASTE_RUNNER, XENO_CASTE_LURKER, XENO_CASTE_FACEHUGGER, XENO_CASTE_SENTINEL, XENO_CASTE_SPITTER)
#define DEFAULT_SPAWN_HIVE_STRING XENO_HIVE_NORMAL

#define DEFAULT_XENO_AMOUNT_TO_SPAWN 1


/// This is a base type for other usable menus, should not be seen in game usually
/datum/game_master_submenu/ambush
	tgui_menu_name = "GameMasterSubmenuAmbush"
	tgui_menu_title = "Ambush Control"

	/// Amount of xenos we want to spawn when we hit spawn
	var/xeno_spawn_count = DEFAULT_XENO_AMOUNT_TO_SPAWN

	/// Current selected xeno string to spawn when we hit spawn
	var/selected_xeno = DEFAULT_SPAWN_XENO_STRING

	/// Current selected hive string to spawn when we hit spawn
	var/selected_hive = DEFAULT_SPAWN_HIVE_STRING

	/// Current xenos to spawn in an ambush, organized as xeno_type = number_to_spawn
	var/list/current_ambush = list()

	/// Current hive to spawn in an ambush
	var/current_ambushing_hive = DEFAULT_SPAWN_HIVE_STRING

	/// Current info on the ambush passed to the menu
	var/ambush_info = "No Current Ambush"

	/// Are we currently ambushing?
	var/ambushing = FALSE

	/// Are we the primary spawner for all menus looking at this vent?
	var/primary = FALSE

	/// Specific sounds we would like for ambushes
	var/list/ambush_sounds = list('sound/effects/tunnel_collapse.ogg')

/datum/game_master_submenu/ambush/New(client/using_client)
	. = ..()

	var/turf/reference_turf = get_turf(referenced_atom)

	var/list/ambush_turfs = block(locate(max(reference_turf.x - 4, 1), max(reference_turf.y - 4, 1), reference_turf.z), locate(reference_turf.x + 4, reference_turf.y + 4, reference_turf.z))

	for(var/turf/cycled_turf as anything in ambush_turfs)
		RegisterSignal(cycled_turf, COMSIG_TURF_ENTERED, PROC_REF(ambush_turf_movement))

	RegisterSignal(referenced_atom, COMSIG_GAME_MASTER_AMBUSH_SET, PROC_REF(other_ambush_set))

/datum/game_master_submenu/ambush/Destroy(force, ...)
	. = ..()

	current_ambush = null

/datum/game_master_submenu/ambush/ui_data(mob/user)
	. = ..()

	var/list/data = list()

	data["xeno_spawn_count"] = xeno_spawn_count
	data["selected_xeno"] = selected_xeno
	data["selected_hive"] = selected_hive
	data["ambush_info"] = ambush_info

	return data

/datum/game_master_submenu/ambush/ui_static_data(mob/user)
	. = ..()

	var/list/data = list()

	data["spawnable_xenos"] = GAME_MASTER_AMBUSH_AI_XENOS

	data["spawnable_hives"] = ALL_XENO_HIVES

	return data

/datum/game_master_submenu/ambush/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)
		if("set_xeno_spawns")
			var/new_number = text2num(params["value"])
			if(!new_number)
				return TRUE

			xeno_spawn_count = clamp(new_number, 1, 10)
			return TRUE

		if("set_selected_xeno")
			selected_xeno = params["new_xeno"]
			xeno_spawn_count = DEFAULT_XENO_AMOUNT_TO_SPAWN
			return TRUE

		if("set_selected_hive")
			selected_hive = params["new_hive"]
			xeno_spawn_count = DEFAULT_XENO_AMOUNT_TO_SPAWN
			return TRUE

		if("ambush")
			setup_ambush()
			return TRUE

		if("spawn")
			handle_ambush_spawn()
			return TRUE

		if("clear_ambush")
			current_ambush = list()
			ambush_info = initial(ambush_info)
			return TRUE

		if("shake_spawner")
			playsound(referenced_atom, pick(ambush_sounds), 40, 1)

			var/datum/callback/stop_animating = shake_spawner()

			if(istype(stop_animating))
				addtimer(stop_animating, (0.5 SECONDS))

			return TRUE

/// Callback for when one of our registered turfs has something move across it, tells the ambush to start if set up
/datum/game_master_submenu/ambush/proc/ambush_turf_movement(turf/crossed_turf, atom/movable/entering_movable)
	SIGNAL_HANDLER

	if(length(current_ambush) && !ambushing && primary && ishuman(entering_movable))
		ambushing = TRUE
		handle_ambush_spawn(TRUE)

/// Sets current ambush data for a potential ambush
/datum/game_master_submenu/ambush/proc/setup_ambush()
	current_ambush[selected_xeno] = xeno_spawn_count

	var/temp_string = "Current Ambush: "
	for(var/ambusher_type in current_ambush)
		temp_string += "[current_ambush[ambusher_type]] [ambusher_type], "

	temp_string = copytext(temp_string, 1, -2)

	temp_string += " of [selected_hive]"

	ambush_info = temp_string

	SEND_SIGNAL(referenced_atom, COMSIG_GAME_MASTER_AMBUSH_SET, current_ambush.Copy(), selected_hive, ambush_info)

	primary = TRUE

/datum/game_master_submenu/ambush/proc/other_ambush_set(atom/movable/other_parent, new_ambush, new_hive, new_ambush_info)
	SIGNAL_HANDLER

	primary = FALSE

	current_ambush = new_ambush
	current_ambushing_hive = new_hive
	ambush_info = new_ambush_info

#define AMBUSH_ESCAPE_INCREMENT_TIME (1 SECONDS)

/// Shakes the vent and creates timers to spawn multiple xenos in succession
/datum/game_master_submenu/ambush/proc/handle_ambush_spawn(ambush)

	var/datum/callback/stop_animating = shake_spawner()

	playsound(referenced_atom, pick(ambush_sounds), 40, 1)
	var/timer_increment = AMBUSH_ESCAPE_INCREMENT_TIME
	referenced_atom.visible_message(SPAN_NOTICE("Something begins climbing out of [referenced_atom]!"))

	if(ambush)
		for(var/ambusher_type in current_ambush)
			for(var/i = 1 to current_ambush[ambusher_type])
				addtimer(CALLBACK(src, PROC_REF(spawn_xeno), ambusher_type), timer_increment)
				timer_increment += AMBUSH_ESCAPE_INCREMENT_TIME

		addtimer(stop_animating, timer_increment)
		current_ambush = list()
		ambush_info = initial(ambush_info)
		ambushing = FALSE
		return

	for(var/i = 1 to xeno_spawn_count)
		addtimer(CALLBACK(src, PROC_REF(spawn_xeno), selected_xeno), timer_increment)
		timer_increment += AMBUSH_ESCAPE_INCREMENT_TIME

	addtimer(stop_animating, timer_increment)

#undef AMBUSH_ESCAPE_INCREMENT_TIME

/// Actually spawns the xeno at the vent
/datum/game_master_submenu/ambush/proc/spawn_xeno(spawning_xeno_name)
	var/turf/spawn_turf = get_turf(referenced_atom)

	if(!spawn_turf)
		log_debug("Ambush game master submenu unable to find turf of referenced atom. Referenced atom: [referenced_atom]")
		return

	var/xeno_type = GLOB.RoleAuthority.get_caste_by_text(spawning_xeno_name)

	if(!xeno_type)
		log_debug("Ambush game master submenu unable to find xeno type. Xeno type name: [spawning_xeno_name]")
		return

	playsound(referenced_atom, pick(ambush_sounds), 25, 1)

	new xeno_type(spawn_turf, null, selected_hive)

/// Shakes the spawner via animation and returns a callback to reset the animation
/datum/game_master_submenu/ambush/proc/shake_spawner()
	return

#undef DEFAULT_SPAWN_XENO_STRING
#undef GAME_MASTER_AMBUSH_AI_XENOS
#undef DEFAULT_SPAWN_HIVE_STRING
#undef DEFAULT_XENO_AMOUNT_TO_SPAWN
