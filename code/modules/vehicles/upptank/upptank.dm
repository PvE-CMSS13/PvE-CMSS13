/obj/vehicle/multitile/tank/upptank
	name = "Cheetah 2A Light Tank"
	desc = "A giant piece of state-approved armor with a big gun, you know what to do. Entrance in the back."
	desc_lore = "The Cheetah 2A is an assault tank designed to be rapidly deployed from light dropcraft in daring raids and first strike operations. The Cheetah 2A is relatively new in comparison to most UPP vehicles seen on the Frontier, but has already earned a fair reputation as a reliable workhorse, that is able to bring some cutting edge technology to the fight. While the project was based in Germany, the Cheetah 2A has a truly progressive development history, seeing influences from nearly all UPP member states."

	icon = 'icons/obj/vehicles/upptank.dmi'
	icon_state = "tank_base"

	interior_map = /datum/map_template/interior/upptank

	light_range = 4

	// Rest (all the guns) is handled by the tank turret hardpoint
	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/uppturret,
		/obj/item/hardpoint/support/weapons_sensor,
		/obj/item/hardpoint/support/overdrive_enhancer,
		/obj/item/hardpoint/support/artillery_module,
		/obj/item/hardpoint/armor/reactive,
		/obj/item/hardpoint/locomotion/treads,
		/obj/item/hardpoint/locomotion/treads/robust,
	)

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 4,
		"slash" = 0.35,
		"bullet" = 0.45,
		"explosive" = 0.65,
		"blunt" = 0.4,
		"abstract" = 1
	)

/obj/vehicle/multitile/tank/upptank/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] Cheetah 2A \"[nickname]\" Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] Cheetah 2A Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/tank/upptank/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)

/obj/vehicle/multitile/tank/upptank/command
	name = "Cheetah 2B Light Command Tank"
	desc = "A giant piece of state-approved armor with a big gun and enhanced comms equipment, you know what to do. Entrance in the back."

	icon = 'icons/obj/vehicles/upptank.dmi'
	icon_state = "tank_base"

	interior_map = /datum/map_template/interior/upptank_command

	light_range = 5

	passengers_slots = 5
	//this is done in case VCs die inside the tank, so that someone else can come in and take them out.
	revivable_dead_slots = 3
	xenos_slots = 4

	// Rest (all the guns) is handled by the tank turret hardpoint
	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/uppturret,
		/obj/item/hardpoint/support/weapons_sensor,
		/obj/item/hardpoint/support/overdrive_enhancer,
		/obj/item/hardpoint/support/artillery_module,
		/obj/item/hardpoint/armor/reactive,
		/obj/item/hardpoint/locomotion/treads,
		/obj/item/hardpoint/locomotion/treads/robust,
	)

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 4,
		"slash" = 0.35,
		"bullet" = 0.45,
		"explosive" = 0.65,
		"blunt" = 0.4,
		"abstract" = 1
	)

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
		VEHICLE_COMMANDER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
		VEHICLE_COMMANDER = null,
	)

/obj/vehicle/multitile/tank/upptank/command/add_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	add_verb(user.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
	))
	user.client.change_view(view_boost, seat)
	user.client.pixel_x = 0
	user.client.pixel_y = 0
	if(seat == VEHICLE_DRIVER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	if(seat == VEHICLE_GUNNER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))
	else if(seat == VEHICLE_COMMANDER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/name_vehicle,
		))

/obj/vehicle/multitile/tank/upptank/command/remove_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	remove_verb(user.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/switch_hardpoint,
	))
	user.client.change_view(GLOB.world_view_size, seat)
	user.client.pixel_x = 0
	user.client.pixel_y = 0
	SStgui.close_user_uis(user, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	if(seat == VEHICLE_GUNNER)
		remove_verb(user.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))
	else if(seat == VEHICLE_COMMANDER)
		remove_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/name_vehicle,
		))

/obj/vehicle/multitile/tank/upptank/command/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] Cheetah 2B \"[nickname]\" Command Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] Cheetah 2B Command Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/upptank
	name = "Tank Spawner"
	icon = 'icons/obj/vehicles/upptank.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/upptank/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: turret, no hardpoints (not the one without turret for convenience, you still expect to have turret when you spawn "no hardpoints tank")
/obj/effect/vehicle_spawner/upptank/spawn_vehicle()
	var/obj/vehicle/multitile/tank/upptank/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/upptank/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)

//PRESET: turret, treads installed
/obj/effect/vehicle_spawner/upptank/plain/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/upptank/hull/load_hardpoints(obj/vehicle/multitile/tank/V)
	return

//Just the hull and it's broken TOO, you get the full experience
/obj/effect/vehicle_spawner/upptank/hull/broken/spawn_vehicle()
	var/obj/vehicle/multitile/tank/tonk = ..()
	load_damage(tonk)
	tonk.update_icon()

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/upptank/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/tank/upptank/TANK = new (loc)

	load_misc(TANK)
	handle_direction(TANK)
	load_hardpoints(TANK)
	load_damage(TANK)
	TANK.update_icon()

/obj/effect/vehicle_spawner/upptank/decrepit/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break

//PRESET: default hardpoints, No Armor
/obj/effect/vehicle_spawner/upptank/fixed/non_armor/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		break


//PRESET: default hardpoints, MG secondaries
/obj/effect/vehicle_spawner/upptank/fixed/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break

//PRESET: TOW hardpoints, TOW launcher secondaries
/obj/effect/vehicle_spawner/upptank/fixed/tow/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/hj35launcher/upptank)
		break

//PRESET: Anti-Armored hardpoints, MG secondaries, Railgun
/obj/effect/vehicle_spawner/upptank/fixed/railgun/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/railgun)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break


//PRESET: Anti-Armored Sniper hardpoints, MG secondaries, Railgun
/obj/effect/vehicle_spawner/upptank/fixed/sniper_railgun/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/artillery_module)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/railgun)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break

/*
** UPP COMMAND TANK PRESET
*/
/obj/effect/vehicle_spawner/upptank/Command
	name = "Command Tank Spawner"
	icon = 'icons/obj/vehicles/upptank.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

//PRESET: turret, no hardpoints (not the one without turret for convenience, you still expect to have turret when you spawn "no hardpoints tank")
/obj/effect/vehicle_spawner/upptank/command/spawn_vehicle()
	var/obj/vehicle/multitile/tank/upptank/command/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

//PRESET: default hardpoints, MG secondaries, arty module
/obj/effect/vehicle_spawner/upptank/command/fixed/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/artillery_module)
	V.add_hardpoint(new /obj/item/hardpoint/armor/reactive)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/p17702)
		TT.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upptank)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break
