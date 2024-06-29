/client/proc/toggle_map_manipulation_menu()
	set name = "Map Manipulation Menu"
	set category = "Game Master.Extras"
	if(!check_rights(R_ADMIN))
		return

	if(src)
		var/datum/map_manipulation_menu/map_menu = new //Instance it, it doesn't need need to be persistent.
		map_menu.tgui_interact(mob)

#define TAB_DESTRUCTION 1
#define TAB_CUSTOMIZATION 2
#define TAB_NIGHTMARE 3

/datum/map_manipulation_menu
	/// What main menu tab we're currently looking at.
	var/main_tab = TAB_DESTRUCTION
//	var/selected_area //Unused at the moment. Could be implemented to only affect a particular area on the map. // Turns out this is pretty bad performance wise.
	/// Ground by default. Used to determine which z-level it affected for destruction.
	var/selected_z_level = 2
	/// By default we want to break at least 25% of all objects affected.
	var/percentage_to_break = 25
	/// Boolean, so they're not constantly getting spammed with the alert, shows up only once per window.
	var/confirmed_break = FALSE
	/// What we feed to the system if we have some custom options.
	var/selected_map = GROUND_MAP

/datum/map_manipulation_menu/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MapManipulation", "Map Manipulation")
		ui.open()

/datum/map_manipulation_menu/ui_data(mob/user)
	. = ..()

	var/data[0]
	data["main_tab"] = main_tab

	if(SSticker.current_state > GAME_STATE_STARTUP) //Don't want to load the tab until pre-game is set up.
		data["map_specific_options"] = TRUE //Declare this true to enable the tab.

	if(SSticker.current_state == GAME_STATE_PREGAME && SSnightmare.stat == NIGHTMARE_STATUS_STANDBY) //Nightmare is only available before the game is getting started/playing and when it's not actively doing something.
		data["nightmare_options"] = TRUE

	switch(main_tab) //We don't want to send data to tabs we're not looking at.
		if(TAB_DESTRUCTION)
			data["selected_z_level"] = selected_z_level
			data["percentage_to_break"] = percentage_to_break

		if(TAB_CUSTOMIZATION)
			data["selected_map"] = selected_map
			//The map name may or may not exist, and there are two possible map types.
			var/datum/map_config/map_to_manipulate = SSmapping.configs[selected_map]
			data["map_name"] = map_to_manipulate ? map_to_manipulate.map_name : null // Did it actually load in? If so, we send the name to the menu. Otherwise nothing.

		if(TAB_NIGHTMARE)
			data["nightmare_ground"] = SSnightmare.get_directory(NIGHTMARE_CTX_GROUND) //The directory gives us all of the available keys and their values, list(choice = list(value1,value2,...)...)
			data["nightmare_ground_scenario"] = SSnightmare.get_scenario_list(NIGHTMARE_CTX_GROUND) //What is currently set in the config to appear in the round.
			data["nightmare_ship"] = SSnightmare.get_directory(NIGHTMARE_CTX_SHIP)
			data["nightmare_ship_scenario"] = SSnightmare.get_scenario_list(NIGHTMARE_CTX_SHIP)

	return data

#undef TAB_DESTRUCTION
#undef TAB_CUSTOMIZATION
#undef TAB_NIGHTMARE

/datum/map_manipulation_menu/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE

/datum/map_manipulation_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	var/dest_actions[] //Staggered list of actions to take for map breaking.
	var/possible_maps[] = SSmapping.levels_by_trait(selected_map == GROUND_MAP ? ZTRAIT_GROUND : ZTRAIT_MARINE_MAIN_SHIP) //If we're actually changing something on the map.

	//MAIN ACTION
	switch(action)
		//OPTIONS
		if("switch_main_tab")
			main_tab = params["new_main_tab"]

		if("selected_z_level")
			var/new_z_level = text2num(params["z_value"])
			if(!isnum(new_z_level))
				return FALSE
			selected_z_level = clamp(new_z_level, 0, 10)	//Shouldn't need to be higher than that.

		if("percentage_to_break")
			var/new_percentage = text2num(params["dest_ratio"])
			if(!isnum(new_percentage))
				return FALSE
			percentage_to_break = clamp(new_percentage, 0, 100)

		if("selected_map")
			selected_map = params["chosen_map"] //GROUND_MAP or SHIP_MAP.

		//PRESETS
		if("preset_light_damage") //Parameters for presets are set through params with the tgui menu.
			dest_actions = list(
				"break_all_machines", 10,
				"break_gear_vendors", 20,
				"break_normal_vendors", 15,
				"break_computers", 20,
				"break_apcs", 5,
				"break_cameras", 10,
				"break_gun_racks", 15,
				"break_grilles", 15,
				"break_windows", 10,
				"break_large_crates", 20,
				"break_racks", 10,
				"break_reagent_tanks", 15,
				"damage_walls", 5,
				"damage_floors", 5,
				"destroy_guns", 20,
				"destroy_devices", 20,
				"destroy_item_storage", 15,
				"destroy_clothing", 20,
				"destroy_food", 20,)

		if("preset_moderate_damage")
			dest_actions = list(
				"break_all_machines", 35,
				"break_gear_vendors", 45,
				"break_normal_vendors", 30,
				"break_computers", 50,
				"break_apcs", 35,
				"break_lights", 40,
				"break_cameras", 30,
				"break_comm_towers", 50,
				"break_airlocks", 35,
				"break_gun_racks", 35,
				"break_mirrors", 30,
				"break_grilles", 45,
				"break_fences", 30,
				"damage_barricades", 45,
				"break_windows", 30,
				"break_window_frames", 15,
				"break_chairs_and_beds", 35,
				"break_tables", 30,
				"break_lockers", 20,
				"break_large_crates", 50,
				"break_racks", 30,
				"break_reagent_tanks", 35,
				"break_powerloaders", 40,
				"damage_walls", 20,
				"damage_floors", 20,
				"destroy_all_items", 30,
				"destroy_guns", 50,
				"destroy_ammo", 60,
				"destroy_weapons", 35,
				"destroy_devices", 40,
				"destroy_item_storage", 30,
				"destroy_clothing", 30,
				"destroy_reagent_containers", 40,
				"destroy_food", 60,)

		if("preset_heavy_damage")
			dest_actions = list(
				"break_all_machines", 60,
				"break_gear_vendors", 80,
				"break_normal_vendors", 70,
				"break_computers", 80,
				"break_apcs", 55,
				"break_lights", 70,
				"break_cameras", 60,
				"break_comm_towers", 100,
				"break_airlocks", 65,
				"break_gun_racks", 80,
				"break_mirrors", 95,
				"break_grilles", 75,
				"break_fences", 75,
				"damage_barricades", 85,
				"break_windows", 55,
				"break_window_frames", 30,
				"break_chairs_and_beds", 65,
				"break_tables", 60,
				"break_lockers", 40,
				"break_large_crates", 70,
				"break_racks", 55,
				"break_reagent_tanks", 70,
				"break_powerloaders", 90,
				"damage_walls", 45,
				"damage_floors", 50,
				"destroy_all_items", 55,
				"destroy_guns", 80,
				"destroy_ammo", 90,
				"destroy_weapons", 60,
				"destroy_devices", 80,
				"destroy_item_storage", 90,
				"destroy_clothing", 90,
				"destroy_reagent_containers", 80,
				"destroy_food", 90,)

		//NIGHTMARE

		if("nightmare_update_scenario", "nightmare_prepare_game")
			if(SSticker.current_state != GAME_STATE_PREGAME || SSnightmare.stat != NIGHTMARE_STATUS_STANDBY) //Extra safety in case they click on something while the game is setting up or something.
				to_chat(ui.user, SPAN_WARNING("Nightmare configuration is only available in the pre-game lobby and when Nightmare is available to run."))
				return FALSE

			if(action == "nightmare_update_scenario")
				SSnightmare.set_scenario_value(params["nightmare_name"], params["nightmare_value"], params["nightmare_context"])
			else
				if(tgui_alert(ui.user, "Are you sure you want to start the Nightmare system before round start? This cannot be undone.", "Confirmation", list("Yes", "No")) != "Yes")
					return FALSE
				SSnightmare.prepare_game() //Fire it early. Everything else is handled by the system. If it ran once successfully, it won't run again. Could potentially remove this limitation to maybe restore default map states.

		//SPECIFIC MAP MANIPULATION
		/*
		* If the map has unique things it can do, it still needs individual cases here.
		* The functions themselves are applicable to other maps, so long as the frontend tgui is configured in MapManipulation.js.
		* To keep in mind: If area pathing changes, things are going to break with no compiler error. This will only come up when
		* using the appropriate menu. Absolute pathing is kind an issue because of that, but hopefully this will be reworked by, or if,
		* that ever comes up. "toggle_blocker" and "flicker_light" both use absolute pathing right now and should probably switch over
		* to some kind of list in the future. I originally had a unique list for map manipulations, but several atoms
		* were in other lists as well, so I cut it. /N
		*/

		if("toggle_blocker")
			var/obj/structure/blocker/rock_debris/blocker_object
			var/signal_id = params["signal_id"]
			var/signal_area = locate(text2path(params["signal_area"])) // Faster than searching through world. Full pathing.
			for(blocker_object in signal_area)
				if(blocker_object.z in possible_maps) // Don't care about the .z level. Leaving it in for future reference if this is refactored, and these fold into a global list.
					blocker_object.toggle_blocker(signal_id)

		if("toggle_hatch")
			var/obj/structure/ladder/hatch/ladder_hatch
			var/signal_id = params["hatch_to_unlock"]
			for(ladder_hatch in GLOB.ladder_list)
				if(ladder_hatch.z in possible_maps)
					switch(signal_id)
						if("toggle_all")
							ladder_hatch.toggle_lock(ladder_hatch.id)
						if("unlock_all")
							ladder_hatch.unlock_hatch(ladder_hatch.id)
						if("lock_all")
							ladder_hatch.lock_hatch(ladder_hatch.id)
						else
							ladder_hatch.toggle_lock(signal_id)

		if("flicker_light")
			var/areas_to_flicker[]
			switch(params["area_to_flicker"])
				if("all_blackstone_areas")
					areas_to_flicker = typesof(/area/whiskey_outpost/blackstone/underground/maintenance)
				else
					areas_to_flicker = list(text2path(params["area_to_flicker"]))

			// The list should always have a length, and at least one thing in it, even if it's null.
			var/area/whiskey_outpost/blackstone/underground/maintenance/maint_area
			var/obj/structure/machinery/light/area_light_bulb

			for(var/i in areas_to_flicker)
				maint_area = locate(i)
				if(maint_area) //Could be that we can't find it.
					for(area_light_bulb in maint_area)
						if(prob(70))
							area_light_bulb.flicker(rand(5,10))

		if("toggle_poddoor")
			var/obj/structure/machinery/door/poddoor/pod_door
			var/signal_id = params["signal_id"]
			for(pod_door in machines)
				if(pod_door.z in possible_maps)
					pod_door.toggle_pod_door(signal_id)

		if("toggle_airlock")
			var/obj/structure/machinery/door/airlock/airlock_door
			var/signal_id = params["signal_id"]
			for(airlock_door in machines)
				if( (airlock_door.z in possible_maps) && signal_id == airlock_door.id) //Very important to have the in statement enclosed, otherwise it will interpret it incorrectly.
					if(airlock_door.density)
						airlock_door.open(TRUE) //Forced.
					else
						airlock_door.close(TRUE)

		if("toggle_door_control")//Nothing fancy here, changes the button's id so it cannot be used, or changes it back.
			var/obj/structure/machinery/door_control/door_controller
			var/signal_id = params["signal_id"]
			var/toggle = "disabled" //Not strictly accurate, but should be fine.
			for(door_controller in machines)
				if(door_controller.z in possible_maps)
					if(door_controller.id == signal_id + "_disabled")
						door_controller.id = signal_id
						toggle = "enabled"
						continue
					else if(door_controller.id == signal_id)
						door_controller.id += "_disabled"
			message_admins("[key_name_admin(ui.user)] has [toggle] door controls with ID: [signal_id].") //Could be important to know.

		if("spawn_ambush")
			var/obj/effect/landmark/tunnel_ambush/ambush_landmark
			var/turf/current_turf
			var/obj/structure/tunnel/tunnel_to_create
			var/turf/closed/wall/walls_in_range
			var/spawned_sites = 0//We use this to count how many were actually spawned and report on it.
			for(ambush_landmark in GLOB.landmarks_list)
				if(ambush_landmark.z in possible_maps)
					if(prob(20)) //We don't want to spam too many of these.
						current_turf = get_turf(ambush_landmark)
						current_turf = current_turf.ChangeTurf(/turf/open/gm/dirt2) //Looks better with a tunnel attached.
						for(walls_in_range in orange(1, current_turf)) //We want to tile this properly with everything around it.
							walls_in_range.update_connections(FALSE)
							walls_in_range.update_icon()
						tunnel_to_create = new(current_turf)
						tunnel_to_create.id = length(GLOB.landmarks_list)
						qdel(ambush_landmark) //This will remove it from landmarks.
						spawned_sites++
			message_admins("[key_name_admin(ui.user)] has spawned [spawned_sites] ambush sites.") //Possibly important to know this. Plus it gives a message that it was successful.

		else
			dest_actions = list(action, percentage_to_break) //Everything else falls into here.

	//BREAKING STUFF

	if(dest_actions) //We are taking some actions to break stuff, it's a non-empty list.
		if(SSticker.current_state == GAME_STATE_STARTUP)
			to_chat(ui.user, SPAN_WARNING("The game is still setting up; please wait until initial setup is complete."))
			return FALSE
		if(!confirmed_break)
			if(tgui_alert(ui.user, "Are you sure you want to break stuff? This cannot be undone.", "Confirmation", list("Yes", "No")) != "Yes")
				return FALSE
			confirmed_break = TRUE //Triggered only once per menu.
		message_admins("[key_name_admin(ui.user)] is breaking something: Z-Level [selected_z_level] | [action]" + ( copytext(action, 1, 8) == "preset_" ? null : " | [percentage_to_break]%") )

		var/specified_percentage_to_break //Temporary so that we can override it for a preset batch.

		// Replace length() with a local variable.
		while(length(dest_actions))
			specified_percentage_to_break = dest_actions[2] //Always position 2.

			/*
			* Common issue here is that there is no global 'proc/break_this_thing()'.
			* Everything requires snowflake handling. Very annoying.
			*/

			switch(dest_actions[1]) //The action is in position 1.
				//MACHINES
				if("break_all_machines")
					var/obj/structure/machinery/any_machine
					for(any_machine as anything in machines)
						if(any_machine.z == selected_z_level && prob(specified_percentage_to_break))
							any_machine.ex_act(EXPLOSION_THRESHOLD_MEDIUM)

				if("break_gear_vendors")
					var/obj/structure/machinery/cm_vending/gear_vendor
					for(gear_vendor in machines)
						if(gear_vendor.z == selected_z_level && prob(specified_percentage_to_break))
							if(prob(25))
								gear_vendor.tip_over()
							gear_vendor.malfunction()

				if("break_normal_vendors")
					var/obj/structure/machinery/vending/regular_vendor
					for(regular_vendor in machines)
						if(regular_vendor.z == selected_z_level && prob(specified_percentage_to_break))
							if(prob(25))
								regular_vendor.tip_over() //This calls malfunction()
							else regular_vendor.malfunction()

				if("break_computers")
					var/obj/structure/machinery/computer/computer_terminal
					for(computer_terminal in machines)
						if(computer_terminal.z == selected_z_level && prob(specified_percentage_to_break))
							computer_terminal.set_broken()

				if("break_apcs")
					var/obj/structure/machinery/power/apc/power_controller
					for(power_controller in machines)
						if(power_controller.z == selected_z_level && prob(specified_percentage_to_break))
							//Copypasted from alien attacks. Exposes the wires and cuts each one.
							for(var/wire = 1; wire <= length(power_controller.get_wire_descriptions()); wire++)
								if(!power_controller.isWireCut(wire))
									power_controller.cut(wire, null, FALSE) //User is nulled. FALSE means there is no message.
							power_controller.wiresexposed = TRUE
							if(prob(50))
								power_controller.set_broken() //This destroys it.
							else
								power_controller.update_icon()

				if("break_lights")
					var/obj/structure/machinery/light/light_bulb
					for(light_bulb in machines)
						if(light_bulb.z == selected_z_level && prob(specified_percentage_to_break))
							light_bulb.broken(TRUE) //TRUE so that it doesn't play sparks and the sound.

				if("break_cameras")
					var/obj/structure/machinery/camera/overhead_camera
					for(overhead_camera in machines)
						if(overhead_camera.z == selected_z_level && prob(specified_percentage_to_break))
							overhead_camera.wires = 0 //wires all cut
							overhead_camera.light_disabled = 0
							overhead_camera.toggle_cam_status(null, TRUE) //TRUE means there is no message. So the user is also passed as null.

				if("break_comm_towers")
					var/obj/structure/machinery/telecomms/relay/preset/tower/comm_tower
					for(comm_tower in machines)
						if(comm_tower.z == selected_z_level && prob(specified_percentage_to_break))
							comm_tower.update_health(comm_tower.health / rand(1,4)) //Gives it a random amount of damage based on max health.

				if("break_airlocks")
					var/obj/structure/machinery/door/airlock/airlock_door
					for(airlock_door in machines)
						if(airlock_door.z == selected_z_level && prob(specified_percentage_to_break))
							airlock_door.break_or_seal()

				if("break_window_doors")
					var/obj/structure/machinery/door/window/window_door
					for(window_door in machines)
						if(window_door.z == selected_z_level && prob(specified_percentage_to_break))
							window_door.take_damage(window_door.health)


				//STRUCTURES
				//Can't get too descriptive with these variable names.
				if("break_all_structures")
					var/obj/structure/any_structure
					for(any_structure in world)
						if(any_structure.z == selected_z_level && prob(specified_percentage_to_break))
							any_structure.ex_act(EXPLOSION_THRESHOLD_MEDIUM)

				if("break_gun_racks")
					var/obj/structure/gun_rack/gun_rack
					for(gun_rack in world)
						if(gun_rack.z == selected_z_level && prob(specified_percentage_to_break))
							//Could use floor(), but I am not sure if we have access to it yet.
							gun_rack.empty_out(round(gun_rack.max_stored * pick(200;1, 60;0.8, 30;0.6)))

				if("break_mirrors")
					var/obj/structure/mirror/mirror
					for(mirror in world)
						if(mirror.z == selected_z_level && prob(specified_percentage_to_break))
							mirror.shatter()

				if("break_grilles")
					var/obj/structure/grille/grille
					for(grille in world)
						if(grille.z == selected_z_level && prob(specified_percentage_to_break))
							grille.health = 0
							grille.healthcheck()

				if("break_fences")
					var/obj/structure/fence/fence
					for(fence in world)
						if(fence.z == selected_z_level && prob(specified_percentage_to_break))
							fence.health = 0
							fence.healthcheck()

				if("damage_barricades")
					var/obj/structure/barricade/barricade
					for(barricade in world)
						if(barricade.z == selected_z_level && prob(specified_percentage_to_break))
							barricade.update_health( (barricade.health / rand(1,4)) , TRUE) //TRUE so that it hides the message.

				if("break_windows")
					var/obj/structure/window/window
					for(window in world)
						if(window.z == selected_z_level && !window.not_damageable && prob(specified_percentage_to_break))
							window.shatter_window(TRUE) //TRUE to create debris.

				if("break_window_frames")
					var/obj/structure/window_frame/window_frame
					for(window_frame in world)
						if(window_frame.z == selected_z_level && prob(specified_percentage_to_break))
							window_frame.deconstruct(TRUE) //As though it was disassembled, so it creates metal.

				if("break_chairs_and_beds")
					var/obj/structure/bed/bed
					for(bed in world)
						if(bed.z == selected_z_level && prob(specified_percentage_to_break))
							bed.deconstruct(FALSE)

				if("break_tables")
					var/obj/structure/surface/table/table
					for(table in world)
						if(table.z == selected_z_level && prob(specified_percentage_to_break))
							if(prob(35) && table.flip(pick(1,2,4,8), skip_straight_check=FALSE, batch_flip=TRUE))
								continue//We'll try to flip it normally. Hide the message so it doesn't spam us.
							else
								table.deconstruct(FALSE) //If that doesn't work, we deconstruct it instead.

				if("break_lockers")
					var/obj/structure/closet/closet
					for(closet in world)
						if(closet.z == selected_z_level && prob(specified_percentage_to_break))
							closet.deconstruct(FALSE)

				if("break_large_crates")
					var/obj/structure/largecrate/large_crate
					for(large_crate in world)
						if(large_crate.z == selected_z_level && prob(specified_percentage_to_break))
							large_crate.unpack()

				if("break_racks")
					var/obj/structure/surface/rack/regular_rack
					for(regular_rack in world)
						if(regular_rack.z == selected_z_level && prob(specified_percentage_to_break))
							regular_rack.deconstruct(prob(30)) //Smaller chance to have them deconstructed into parts.

				if("break_reagent_tanks")
					var/obj/structure/reagent_dispensers/I
					for(I in world)
						if(I.z == selected_z_level && prob(specified_percentage_to_break))
							I.health -= I.health / rand(1,3)
							I.healthcheck()

				if("break_powerloaders") //Not really structures, but they leave structures upon destruction.
					var/obj/vehicle/powerloader/loader_vehicle
					for(loader_vehicle in world)
						if(loader_vehicle.z == selected_z_level && prob(specified_percentage_to_break))
							loader_vehicle.health -= loader_vehicle.health / rand(1,3)
							if(loader_vehicle.health <= 0)
								loader_vehicle.explode()

				//TURFS
				if("damage_walls")
					var/turf/closed/wall/closed_wall
					var/batch_damage = params["batch_damage"]
					var/enable_bullet_holes = params["bullet_holes"]
					for(closed_wall in world)
						if(closed_wall.z == selected_z_level && prob(specified_percentage_to_break))
							switch(batch_damage) //For batch processing.
								if(2)
									if(prob(20))
										closed_wall.current_bulletholes = TRUE
								if(3)
									if(prob(40))
										closed_wall.current_bulletholes = TRUE
								else //For not-batch processing, like if it's null.
									if(enable_bullet_holes)
										closed_wall.current_bulletholes = TRUE
							closed_wall.take_damage(closed_wall.damage_cap / rand(1,6), null)

				if("damage_floors")
					var/turf/open/floor/open_floor
					var/obj/structure/pipes/pipe
					var/obj/structure/disposalpipe/junction/disposal_junction
					var/break_pipes = params["break_pipes"]
					var/batch_damage = params["batch_damage"]
					var/add_dirt = params["add_dirt"]
					var/enable_pipe_break //Do we want to break pipes while we're breaking floors?
					for(open_floor in world)
						if(open_floor.z == selected_z_level && prob(specified_percentage_to_break))

							switch(batch_damage)
								if(2)
									if(prob(35))
										new /obj/effect/decal/cleanable/dirt(open_floor)
								if(3)
									if(prob(65))
										new /obj/effect/decal/cleanable/dirt(open_floor)
								else
									if(add_dirt)
										new /obj/effect/decal/cleanable/dirt(open_floor)
										continue //Only adds dirt, doesn't destroy or damage.

							if(prob(65))
								open_floor.break_tile()//More damaged, fewer are turned into plating.
							else
								open_floor.break_tile_to_plating()

							enable_pipe_break = FALSE
							switch(batch_damage)
								if(2)
									if(prob(20))
										enable_pipe_break = TRUE
								if(3)
									if(prob(50))
										enable_pipe_break = TRUE
								else
									if(break_pipes)
										enable_pipe_break = TRUE

							if(enable_pipe_break)
								for(pipe in open_floor)
									if(prob(55))
										new /obj/item/pipe(open_floor, null, null, pipe)
									qdel(pipe)
								for(disposal_junction in open_floor)
									disposal_junction.deconstruct(prob(40))

				//ITEMS //These are qdeleted. They don't have damage states.
				if("destroy_all_items")
					var/obj/item/any_item
					for(any_item in world)
						if(any_item.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(any_item)

				if("destroy_guns")
					var/obj/item/weapon/gun/gun_weapon
					for(gun_weapon in world)
						if(gun_weapon.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(gun_weapon)

				if("destroy_ammo")
					var/obj/item/ammo_magazine/ammunition_magazine
					for(ammunition_magazine in world)
						if(ammunition_magazine.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(ammunition_magazine)

				if("destroy_weapons")
					var/obj/item/weapon/any_weapon
					for(any_weapon in world)
						if(any_weapon.z == selected_z_level && !istype(any_weapon, /obj/item/weapon/gun) && prob(specified_percentage_to_break)) //Don't want guns here. A little messy, but it should be fine.
							qdel(any_weapon)

				if("destroy_devices")
					var/obj/item/device/any_device
					for(any_device in world)
						if(any_device.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(any_device)

				if("destroy_item_storage")
					var/obj/item/storage/storage_item // Adding item after everything, the true and only way to name your variables.
					for(storage_item in world)
						if(storage_item.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(storage_item)

				if("destroy_clothing")
					var/obj/item/clothing/clothing_item
					for(clothing_item in world)
						if(clothing_item.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(clothing_item)

				if("destroy_reagent_containers")
					var/obj/item/reagent_container/reagent_container
					for(reagent_container in world)
						if(reagent_container.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(reagent_container)

				if("destroy_food")
					var/obj/item/reagent_container/food/food_item
					for(food_item in world)
						if(food_item.z == selected_z_level && prob(specified_percentage_to_break))
							qdel(food_item)

			dest_actions.Cut(1,3) //Removes the first two entries.
