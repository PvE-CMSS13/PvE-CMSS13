
/obj/vehicle/multitile/apc/movie
	name = "M577A3 Armored Personnel Carrier"
	desc = "An M577A3 Armored Personnel Carrier complete with a tactical operations center. Entrance on the right."

	icon = 'icons/obj/vehicles/movieapc.dmi'
	icon_state = "apc_base_movie"
	pixel_x = -64
	pixel_y = -64

	bound_width = 96
	bound_height = 96

	interior_map = /datum/map_template/interior/apc_movie


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

/obj/vehicle/multitile/apc/movie/add_seated_verbs(mob/living/M, seat)
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
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_shift_click,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_shift_click,
		))

/obj/vehicle/multitile/apc/movie/remove_seated_verbs(mob/living/M, seat)
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
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_shift_click,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_shift_click,
		))

/obj/vehicle/multitile/apc/movie/initialize_cameras(change_tag = FALSE)
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

/obj/vehicle/multitile/apc/movie/set_muzzle_offsets(obj/item/hardpoint/HP)
	//sets muzzle flash offsets for APC weapons as appropriate for the movie APC
	switch(HP.slot)
		if(HDPT_PRIMARY) //dualcannon
			HP.muzzle_flash_pos = list(
				"1" = list(8, -20),
				"2" = list(25, 31),
				"4" = list(-7, 27),
				"8" = list(37, 9)
			)
		if(HDPT_SECONDARY) //frontalcannon
			HP.muzzle_flash_pos = list(
				"1" = list(34, 70),
				"2" = list(-1, -70),
				"4" = list(88, -7),
				"8" = list(-56, 12)
			)
		if(HDPT_SUPPORT) //flare
			HP.muzzle_flash_pos = list(
				"1" = list(22, -20),
				"2" = list(11, 32),
				"4" = list(-5, 10),
				"8" = list(37, 24)
			)
	return ..()

/obj/vehicle/multitile/apc/movie/custom
	icon_state = "apc_base_custom"
	nickname = "Pit Stop"
	interior_map = /datum/map_template/interior/apc_custom
	honk_sound = 'sound/vehicles/horn_custom.ogg'
/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/apc_movie
	name = "Movie APC Spawner"
	icon = 'icons/obj/vehicles/movieapc.dmi'
	icon_state = "apc_base_movie"
	pixel_x = -64
	pixel_y = -64

/obj/effect/vehicle_spawner/apc_movie/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/apc_movie/spawn_vehicle()
	var/obj/vehicle/multitile/apc/movie/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

//PRESET: only wheels installed
/obj/effect/vehicle_spawner/apc_movie/plain/load_hardpoints(obj/vehicle/multitile/apc/movie/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels)

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/apc_movie/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/apc/movie/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	load_damage(APC)
	APC.update_icon()

/obj/effect/vehicle_spawner/apc_movie/decrepit/load_hardpoints(obj/vehicle/multitile/apc/movie/V)
	V.add_hardpoint(new /obj/item/hardpoint/primary/dualcannon)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/frontalcannon)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels)

//PRESET: default hardpoints
/obj/effect/vehicle_spawner/apc_movie/fixed/load_hardpoints(obj/vehicle/multitile/apc/movie/V)
	V.add_hardpoint(new /obj/item/hardpoint/primary/dualcannon)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/frontalcannon)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels)

/obj/effect/vehicle_spawner/apc_movie/fixed/custom/spawn_vehicle()
	var/obj/vehicle/multitile/apc/movie/custom/APC = new (loc)
	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()
