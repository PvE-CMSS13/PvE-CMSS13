
/obj/vehicle/multitile/apc/wolfpack
	name = "M577A3E2 Mobile Gun System"
	desc = "An M577A3E2 Mobile Gun System complete with a tactical operations center. Entrance on the right."

	icon = 'icons/obj/vehicles/apc_wolfpack.dmi'
	icon_state = "apc_base_wolfpack"
	pixel_x = -64
	pixel_y = -64

	bound_width = 96
	bound_height = 96

	interior_map = /datum/map_template/interior/apc_wolfpack


	passengers_slots = 20

	entrances = list(
		"right rear" = list(-2, 1),
		"right front" = list(-2, 0)
	)

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)
	dmg_multipliers = list(
		"all" = 1,
		"acid" = 2.6,
		"slash" = 0.5,
		"bullet" = 0.7,
		"explosive" = 0.9,
		"blunt" = 0.5,
		"abstract" = 1,
	)

	wall_ram_damage = 100
	vehicle_ram_multiplier = 10
	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/wolfpack,
		/obj/item/hardpoint/secondary/frontalcannon,
		/obj/item/hardpoint/support/artillery_module,
		/obj/item/hardpoint/locomotion/apc_wheels,
	)

	move_max_momentum = 2.3
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.7

/obj/vehicle/multitile/apc/wolfpack/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
			/obj/vehicle/multitile/proc/switch_hardpoint,
		))

/obj/vehicle/multitile/apc/wolfpack/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(,.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
			/obj/vehicle/multitile/proc/switch_hardpoint,
		))

/obj/vehicle/multitile/apc/wolfpack/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/tank_turret/wolfpack/turret = null
	for(var/obj/item/hardpoint/holder/tank_turret/wolfpack/tonkturret in hardpoints)
		turret = tonkturret
		break
	if(!turret)
		return FALSE

	if(direction == GLOB.reverse_dir[turret.dir] || direction == turret.dir)
		return FALSE

	turret.user_rotation(user, turning_angle(turret.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/apc/wolfpack/MouseDrop_T(mob/dropped, mob/user)
	. = ..()
	if((dropped != user) || !isxeno(user))
		return

	if(health > 0)
		to_chat(user, SPAN_XENO("We can't jump over [src] until it is destroyed!"))
		return

	var/turf/current_turf = get_turf(user)
	var/dir_to_go = get_dir(current_turf, src)
	for(var/i in 1 to 3)
		current_turf = get_step(current_turf, dir_to_go)
		if(!(current_turf in locs))
			break

		if(current_turf.density)
			to_chat(user, SPAN_XENO("The path over [src] is obstructed!"))
			return

/obj/vehicle/multitile/apc/wolfpack/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M577A3 \"[nickname]\" APC"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"
	else
		camera.c_tag = "#[rand(1,100)] M577A3 APC"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"

/obj/vehicle/multitile/apc/wolfpack/set_muzzle_offsets(obj/item/hardpoint/HP)
	//sets muzzle flash offsets for APC weapons as appropriate for the movie APC
	switch(HP.slot)
		if(HDPT_PRIMARY) //dualcannon
			HP.muzzle_flash_pos = list(
				"1" = list(8, -12),
				"2" = list(25, 24),
				"4" = list(0, 27),
				"8" = list(30, 9)
			)
		if(HDPT_SECONDARY) //frontalcannon
			HP.muzzle_flash_pos = list(
				"1" = list(34, 76),
				"2" = list(-1, -76),
				"4" = list(94, -7),
				"8" = list(-62, 12)
			)
		if(HDPT_SUPPORT) //flare
			HP.muzzle_flash_pos = list(
				"1" = list(22, -13),
				"2" = list(11, 22),
				"4" = list(2, 10),
				"8" = list(30, 24)
			)
	return ..()

/obj/effect/vehicle_spawner/apc_wolfpack
	name = "Wolfpack APC Spawner"
	icon = 'icons/obj/vehicles/apc_wolfpack.dmi'
	icon_state = "apc_base_wolfpack"
	pixel_x = -64
	pixel_y = -64

/obj/effect/vehicle_spawner/apc_wolfpack/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

/obj/effect/vehicle_spawner/apc_wolfpack/spawn_vehicle()
	var/obj/vehicle/multitile/apc/wolfpack/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

//PRESET: only wheels installed
/obj/effect/vehicle_spawner/apc_wolfpack/plain/load_hardpoints(obj/vehicle/multitile/apc/movie/V)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/wolfpack)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/frontalcannon)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/support/artillery_module)
	for(var/obj/item/hardpoint/holder/tank_turret/wolfpack/tonkturret in V.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon/wolfpack)
