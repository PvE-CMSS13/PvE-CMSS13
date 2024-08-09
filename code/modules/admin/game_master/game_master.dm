
/// Holds our active game_masters
GLOBAL_LIST_EMPTY(game_masters)

/// List of assoc lists that hold "object_name", "objective_info", and "object_ref". Name of the objective, any info typed about the objective, and then a reference to be resolved of the object for passing through TGUI
GLOBAL_LIST_EMPTY(game_master_objectives)

/// Percentage of characters end up clear when sent via radio message
GLOBAL_VAR_INIT(radio_communication_clarity, 100)

/proc/open_game_master_panel(client/using_client)
	set name = "Game Master Panel"
	set category = "Game Master"

	if(using_client.game_master_menu)
		using_client.game_master_menu.tgui_interact(using_client.mob)
		return

	using_client.game_master_menu = new /datum/game_master(using_client)

/client/proc/toggle_game_master()
	set name = "Game Master Panel"
	set category = "Game Master"
	if(!check_rights(R_ADMIN))
		return

	if(src)
		open_game_master_panel(src)

// Spawn stuff
#define DEFAULT_SPAWN_XENO_STRING XENO_CASTE_DRONE
#define GAME_MASTER_AI_XENOS list(XENO_CASTE_DRONE, XENO_CASTE_RUNNER, XENO_CASTE_LURKER, XENO_CASTE_CRUSHER, XENO_CASTE_FACEHUGGER)
#define DEFAULT_SPAWN_HIVE_STRING XENO_HIVE_NORMAL

#define DEFAULT_XENO_AMOUNT_TO_SPAWN 1

// Behavior stuff
#define DEFAULT_BEHAVIOR_STRING "Attack"
#define SELECTABLE_XENO_BEHAVIORS list("Attack", "Capture", "Hive", "Build")
#define SELECTABLE_XENO_BEHAVIORS_ASSOC list("Attack" = /datum/component/ai_behavior_override/attack, "Capture" = /datum/component/ai_behavior_override/capture, "Hive" = /datum/component/ai_behavior_override/hive, "Build" = /datum/component/ai_behavior_override/build)

#define DEFAULT_BEHAVIOR_LIFE_SPAN 0

// Objective stuff
#define OBJECTIVE_NUMBER_OPTIONS list("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
#define OBJECTIVE_COLOR_OPTIONS list("red", "purple", "blue")
#define OBJECTIVE_COLOR_OPTIONS_ASSOC list("red" = COLOR_RED, "purple" = COLOR_PURPLE, "blue" = COLOR_BLUE)

/// Types of click intercepts used by /datum/game_master variable current_click_intercept_action
#define SPAWN_CLICK_INTERCEPT_ACTION "spawn_click_intercept_action"
#define BEHAVIOR_CLICK_INTERCEPT_ACTION "behavior_click_intercept_action"
#define OBJECTIVE_CLICK_INTERCEPT_ACTION "objective_click_intercept_action"


/datum/game_master

	var/client/game_master_client

	/// Associated list of game master submenus organized by object_type = game_master_submenu
	var/list/submenu_types = list(
		/obj/structure/pipes/vents = /datum/game_master_submenu/ambush/vents,
		/obj/structure/tunnel = /datum/game_master_submenu/ambush/tunnels,
		/mob/living/carbon/human = /datum/game_master_submenu/infest,
	)

	/// List of current submenus
	var/list/current_submenus

	/// Holds what type of click intercept we are using
	var/current_click_intercept_action


	// Spawn stuff

	/// The xeno selected to be spawned in the spawn section
	var/selected_xeno = DEFAULT_SPAWN_XENO_STRING

	/// The hive selected to be spawned in the spawn section
	var/selected_hive = DEFAULT_SPAWN_HIVE_STRING

	/// The amount of xenos to spawn in the spawn section
	var/xeno_spawn_count = DEFAULT_XENO_AMOUNT_TO_SPAWN

	/// If the spawned xeno is an AI in the spawn section
	var/spawn_ai = TRUE

	/// If we are currently using the click intercept for the spawn section
	var/spawn_click_intercept = FALSE


	// Behavior stuff

	/// The current behavior to add when clicking with behavior_click_intercept on
	var/selected_behavior = DEFAULT_BEHAVIOR_STRING

	/// The amount of xenos to spawn in the spawn section
	var/behavior_lifespan = DEFAULT_BEHAVIOR_LIFE_SPAN

	/// If we are currently using click intercept for the behavior section
	var/behavior_click_intercept = FALSE

	/// List of xenoids currently selected by GM for manual control
	var/list/controlled_xenos = list()


	// Objective stuff

	/// If we are currently using the click intercept for the objective section
	var/objective_click_intercept = FALSE


	// Communication stuff

	/// The holder for the game master's virtual phone
	var/atom/movable/game_master_phone


/datum/game_master/New(client/using_client)
	. = ..()

	game_master_client = using_client

	tgui_interact(game_master_client.mob)

	current_submenus = list()

	game_master_phone = new(null)
	game_master_phone.AddComponent(/datum/component/phone/virtual, "Game Master", "white", "Company Command", null, PHONE_DND_ON, list(FACTION_MARINE, FACTION_COLONIST, FACTION_WY), list(FACTION_MARINE, FACTION_COLONIST, FACTION_WY), null, using_client)

	game_master_client.click_intercept = src

	for(var/datum/component/ai_behavior_override/override in GLOB.all_ai_behavior_overrides)
		game_master_client.images += override.behavior_image

	GLOB.game_masters |= game_master_client

/datum/game_master/Destroy(force, ...)
	. = ..()
	submenu_types = null
	current_submenus = null
	QDEL_NULL(game_master_phone)

	for(var/datum/component/ai_behavior_override/override in GLOB.all_ai_behavior_overrides)
		game_master_client.images -= override.behavior_image

	for(var/controlled_xeno in controlled_xenos)
		deselect_xeno(controlled_xeno)

	GLOB.game_masters -= game_master_client

/datum/game_master/ui_data(mob/user)
	. = ..()

	var/list/data = list()

	// Spawn stuff
	data["selected_xeno"] = selected_xeno
	data["selected_hive"] = selected_hive
	data["spawn_ai"] = spawn_ai
	data["spawn_click_intercept"] = spawn_click_intercept
	data["xeno_spawn_count"] = xeno_spawn_count

	// Behavior stuff
	data["selected_behavior"] = selected_behavior
	data["behavior_click_intercept"] = behavior_click_intercept
	data["behavior_lifespan"] = behavior_lifespan / 10

	// Objective stuff
	data["objective_click_intercept"] = objective_click_intercept
	data["game_master_objectives"] = length(GLOB.game_master_objectives) ? GLOB.game_master_objectives : ""

	// Communication stuff
	data["radio_clarity"] = GLOB.radio_communication_clarity
	data["radio_clarity_example"] = stars("The quick brown fox jumped over the lazy dog.", GLOB.radio_communication_clarity)

	return data

/datum/game_master/ui_static_data(mob/user)
	. = ..()

	var/list/data = list()

	data["spawnable_xenos"] = GAME_MASTER_AI_XENOS

	data["spawnable_hives"] = ALL_XENO_HIVES

	data["selectable_behaviors"] = SELECTABLE_XENO_BEHAVIORS

	return data

/datum/game_master/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)

		//Spawn Section
		if("set_xeno_spawns")
			var/new_number = text2num(params["value"])
			if(!new_number)
				return

			xeno_spawn_count = clamp(new_number, 1, 10)
			return

		if("set_selected_xeno")
			selected_xeno = params["new_xeno"]
			xeno_spawn_count = DEFAULT_XENO_AMOUNT_TO_SPAWN
			return

		if("set_selected_hive")
			selected_hive = params["new_hive"]
			xeno_spawn_count = DEFAULT_XENO_AMOUNT_TO_SPAWN
			return

		if("xeno_spawn_ai_toggle")
			spawn_ai = !spawn_ai
			return

		if("toggle_click_spawn")
			if(spawn_click_intercept)
				reset_click_overrides()
				return

			reset_click_overrides()
			spawn_click_intercept = TRUE
			current_click_intercept_action = SPAWN_CLICK_INTERCEPT_ACTION
			return

		if("delete_all_xenos")
			if(tgui_alert(ui.user, "Do you want to delete all xenos?", "Confirmation", list("Yes", "No")) != "Yes")
				return

			for(var/mob/living/carbon/xenomorph/cycled_xeno in GLOB.alive_mob_list)
				qdel(cycled_xeno)

			return

		if("delete_xenos_in_view")
			if(tgui_alert(ui.user, "Do you want to delete all xenos within your view range?", "Confirmation", list("Yes", "No")) != "Yes")
				return

			for(var/mob/living/carbon/xenomorph/viewed_xeno in view(ui.user.client))
				qdel(viewed_xeno)

			return

		//Behavior Section
		if("set_behavior_lifespan")
			var/new_number = text2num(params["lifespan_value"])
			behavior_lifespan = clamp(new_number, -1, 600) SECONDS
			return

		if("set_selected_behavior")
			selected_behavior = params["new_behavior"]
			return

		if("toggle_click_behavior")
			if(behavior_click_intercept)
				reset_click_overrides()
				return

			reset_click_overrides()
			behavior_click_intercept = TRUE
			current_click_intercept_action = BEHAVIOR_CLICK_INTERCEPT_ACTION
			game_master_client.show_popup_menus = FALSE
			return

		//Objective Section
		if("toggle_click_objective")
			if(objective_click_intercept)
				reset_click_overrides()
				return

			reset_click_overrides()
			objective_click_intercept = TRUE
			current_click_intercept_action = OBJECTIVE_CLICK_INTERCEPT_ACTION
			return

		if("jump_to")
			if(!params["val"])
				return

			var/list/objective = params["val"]

			var/atom/objective_atom = locate(objective["object_ref"])

			var/turf/objective_turf = get_turf(objective_atom)

			if(!objective_turf)
				return TRUE

			var/client/jumping_client = ui.user.client
			jumping_client.jump_to_turf(objective_turf)
			return TRUE

		if("remove_objective")
			if(!params["val"])
				return

			var/list/objective = params["val"]

			var/atom/objective_atom = locate(objective["object_ref"])

			if(!objective_atom)
				return TRUE

			if(tgui_alert(ui.user, "Do you want to remove [objective_atom] as an objective?", "Confirmation", list("Yes", "No")) != "Yes")
				return TRUE

			remove_objective(objective_atom)

		//Communication Section
		if("use_game_master_phone")
			game_master_phone.attack_hand(ui.user)

		if("set_radio_clarity")
			var/new_clarity = text2num(params["clarity"])
			if(!isnum(new_clarity))
				return

			GLOB.radio_communication_clarity = clamp(new_clarity, 0, 100)

/datum/game_master/ui_close(mob/user)
	. = ..()

	var/client/user_client = user.client
	if(user_client?.click_intercept == src)
		user_client.click_intercept = null

	game_master_client.show_popup_menus = TRUE

	spawn_click_intercept = FALSE
	objective_click_intercept = FALSE
	behavior_click_intercept = FALSE
	current_click_intercept_action = null

	for(var/datum/component/ai_behavior_override/override in GLOB.all_ai_behavior_overrides)
		game_master_client.images -= override.behavior_image

	for(var/controlled_xeno in controlled_xenos)
		deselect_xeno(controlled_xeno)

/datum/game_master/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE

/datum/game_master/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "GameMaster", "Game Master Menu")
		ui.open()

	user.client?.click_intercept = src

	for(var/datum/component/ai_behavior_override/override in GLOB.all_ai_behavior_overrides)
		game_master_client.images |= override.behavior_image

/datum/game_master/proc/InterceptClickOn(mob/user, params, atom/object)

	var/list/modifiers = params2list(params)

	switch(current_click_intercept_action)
		if(SPAWN_CLICK_INTERCEPT_ACTION)
			if(LAZYACCESS(modifiers, MIDDLE_CLICK))
				if(isxeno(object))
					qdel(object)
				return TRUE

			var/spawning_xeno_type = RoleAuthority.get_caste_by_text(selected_xeno)

			if(!spawning_xeno_type)
				to_chat(user, SPAN_NOTICE(SPAN_BOLD("Unable to find xeno type by name: [selected_xeno]")))
				return

			var/turf/spawn_turf = get_turf(object)

			for(var/i = 1 to xeno_spawn_count)
				new spawning_xeno_type(spawn_turf, null, selected_hive, !spawn_ai)

			return TRUE

		if(BEHAVIOR_CLICK_INTERCEPT_ACTION)
			var/behavior_type = SELECTABLE_XENO_BEHAVIORS_ASSOC[selected_behavior]

			if(LAZYACCESS(modifiers, MIDDLE_CLICK))
				if(object.datum_components?[behavior_type])
					var/component_to_remove = object.datum_components[behavior_type]
					qdel(component_to_remove)
				return TRUE

			if(LAZYACCESS(modifiers, RIGHT_CLICK))
				if(LAZYACCESS(modifiers, CTRL_CLICK))
					object.AddComponent(behavior_type, behavior_lifespan)
					if(!LAZYLEN(controlled_xenos))
						return TRUE

					var/datum/component/ai_behavior_override/behavior = object.datum_components?[behavior_type]
					if(!behavior)
						return TRUE

					behavior.search_assign = FALSE
					var/list/currently_assigned = behavior.currently_assigned
					for(var/mob/living/carbon/xenomorph/assigned_xeno as anything in controlled_xenos)
						if(length(currently_assigned) >= behavior.max_assigned)
							break

						deselect_xeno(assigned_xeno)
						currently_assigned |= assigned_xeno
						assigned_xeno.patrol_points = list(object)

				else if(LAZYACCESS(modifiers, SHIFT_CLICK))
					for(var/mob/living/carbon/xenomorph/patrolling_xeno as anything in controlled_xenos)
						patrolling_xeno.patrol_points |= object

				else
					for(var/mob/living/carbon/xenomorph/moving_xeno as anything in controlled_xenos)
						moving_xeno.patrol_points = list(object)

				return TRUE

			if(LAZYACCESS(modifiers, ALT_CLICK))
				for(var/atom/selected_xeno as anything in GLOB.xeno_mob_list)
					if(selected_xeno.z != game_master_client.mob.z)
						continue
					select_xeno(selected_xeno)
				return TRUE

			if(!LAZYACCESS(modifiers, SHIFT_CLICK))
				for(var/deselected_xeno in controlled_xenos)
					deselect_xeno(deselected_xeno)

			if(isxeno(object))
				if(object in controlled_xenos)
					deselect_xeno(object)
				else
					select_xeno(object)
			return TRUE

		if(OBJECTIVE_CLICK_INTERCEPT_ACTION)
			var/turf/object_turf = get_turf(object)

			if(!object_turf)
				return TRUE

			if(SSminimaps.has_marker(object) || is_objective(object))
				if(tgui_alert(user, "Do you want to remove [object] as an objective?", "Confirmation", list("Yes", "No")) != "Yes")
					return TRUE

				remove_objective(object)
				return TRUE

			if(tgui_alert(user, "Do you want to make [object] an objective?", "Confirmation", list("Yes", "No")) != "Yes")
				return TRUE

			var/number_option = tgui_input_list(user, "Number on tacmap marker?", "Marker Number", OBJECTIVE_NUMBER_OPTIONS)
			if(!number_option)
				return TRUE

			var/color_option = tgui_input_list(user, "Color of tacmap marker?", "Marker Color", OBJECTIVE_COLOR_OPTIONS)
			if(!color_option)
				return TRUE

			color_option = OBJECTIVE_COLOR_OPTIONS_ASSOC[color_option]

			var/image/background = mutable_appearance('icons/ui_icons/map_blips.dmi', "background")
			background.color = color_option

			var/mutable_appearance/icon = image('icons/ui_icons/map_blips.dmi', icon_state = number_option)
			icon.appearance_flags = RESET_COLOR

			background.overlays += icon

			var/z_level = object_turf?.z

			if(!object || !z_level)
				return

			SSminimaps.add_marker(object, z_level, MINIMAP_FLAG_ALL, given_image = background)

			var/objective_info = tgui_input_text(user, "Objective info?", "Objective Info")

			var/object_ref = REF(object)

			RegisterSignal(object, COMSIG_PARENT_QDELETING, PROC_REF(remove_objective))

			GLOB.game_master_objectives += list(list(
				"object" = object,
				"object_name" = object.name,
				"objective_info" = (objective_info || ""),
				"object_ref" = object_ref,
				))
			return TRUE

		else
			if(LAZYACCESS(modifiers, MIDDLE_CLICK))
				for(var/datum/game_master_submenu/submenu in current_submenus)
					if(submenu.referenced_atom == object)
						submenu.tgui_interact(user)
						return TRUE

				for(var/submenu_type in submenu_types)
					if(istype(object, submenu_type))
						var/new_submenu_type = submenu_types[submenu_type]
						current_submenus += new new_submenu_type(user, object)
						return TRUE

				return TRUE

/datum/game_master/proc/reset_click_overrides()
	game_master_client.show_popup_menus = TRUE
	spawn_click_intercept = FALSE
	objective_click_intercept = FALSE
	behavior_click_intercept = FALSE
	current_click_intercept_action = null

/client/proc/select_box_wrapper(atom/first_corner, atom/second_corner)
	if(game_master_menu && game_master_menu.current_click_intercept_action == BEHAVIOR_CLICK_INTERCEPT_ACTION)
		game_master_menu.select_box(first_corner, second_corner)

/datum/game_master/proc/select_box(atom/first_corner, atom/second_corner)
	if(!("Shift" in game_master_client.keys_held))
		for(var/controlled_xeno in controlled_xenos)
			deselect_xeno(controlled_xeno)

	var/turf/start = get_turf(first_corner)
	var/turf/end = get_turf(second_corner)

	var/list/selection_box = block(start, end)
	for(var/mob/living/carbon/xenomorph/cycled_xeno as anything in GLOB.living_xeno_list)
		if(cycled_xeno.loc in selection_box)
			select_xeno(cycled_xeno)

/datum/game_master/proc/select_xeno(selected_xeno)
	RegisterSignal(selected_xeno, COMSIG_PARENT_QDELETING, PROC_REF(deselect_xeno), TRUE)
	controlled_xenos |= selected_xeno
	if(controlled_xenos[selected_xeno])
		return

	var/image/selection_image = new('icons/effects/game_master_xeno_behaviors.dmi', selected_xeno, "selected", layer = ABOVE_FLY_LAYER)

	controlled_xenos[selected_xeno] = selection_image
	game_master_client.images |= selection_image

/datum/game_master/proc/deselect_xeno(deselected_xeno)
	UnregisterSignal(deselected_xeno, COMSIG_PARENT_QDELETING)
	game_master_client.images -= controlled_xenos[deselected_xeno]
	controlled_xenos -= deselected_xeno

/datum/game_master/proc/is_objective(atom/checked_object)
	for(var/list/cycled_objective in GLOB.game_master_objectives)
		if(cycled_objective["object"] == checked_object)
			return TRUE

	return FALSE

/datum/game_master/proc/remove_objective(datum/removing_datum)
	SIGNAL_HANDLER

	for(var/list/cycled_objective in GLOB.game_master_objectives)
		if(cycled_objective["object"] == removing_datum)
			GLOB.game_master_objectives.Remove(list(cycled_objective))
			UnregisterSignal(removing_datum, COMSIG_PARENT_QDELETING)

	SSminimaps.remove_marker(removing_datum)


#undef DEFAULT_SPAWN_XENO_STRING
#undef GAME_MASTER_AI_XENOS
#undef DEFAULT_SPAWN_HIVE_STRING
#undef DEFAULT_XENO_AMOUNT_TO_SPAWN

#undef OBJECTIVE_NUMBER_OPTIONS
#undef OBJECTIVE_COLOR_OPTIONS
#undef OBJECTIVE_COLOR_OPTIONS_ASSOC

#undef DEFAULT_BEHAVIOR_STRING
#undef SELECTABLE_XENO_BEHAVIORS
#undef SELECTABLE_XENO_BEHAVIORS_ASSOC

#undef DEFAULT_BEHAVIOR_LIFE_SPAN

#undef SPAWN_CLICK_INTERCEPT_ACTION
#undef OBJECTIVE_CLICK_INTERCEPT_ACTION
