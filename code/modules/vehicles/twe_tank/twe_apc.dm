/obj/vehicle/multitile/twe_apc
	name = "Type 200/FCV ‘Senshi’ Light APC"
	desc = "The Type 200/FCV ‘Senshi’ Light APC is a 6m long, 6m wide, 8m tall support vehicle for the RMC. Based off the original FV150 Light Cavalry Tank design, it's interior space has been expanded thanks to the lack of turret basket & autoloader systems. Entrance on the back."

	icon = 'icons/obj/vehicles/twe_tank.dmi'
	icon_state = "apc_base"

	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	health = 1400

	interior_map = /datum/map_template/interior/twe_apc

	passengers_slots = 6
	revivable_dead_slots = 3
	xenos_slots = 2

	entrances = list(
		"rear" = list(0, 2),

	)

	entrance_speed = 0.5 SECONDS

	required_skill = SKILL_VEHICLE_LARGE

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	light_range = 7

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/treads,
		/obj/item/hardpoint/locomotion/treads/robust,
		/obj/item/hardpoint/secondary/m56cupola/twe_tank,
		/obj/item/hardpoint/support/smoke_launcher/twe_tank
	)


	seats = list(
		VEHICLE_DRIVER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
	)

	vehicle_flags = VEHICLE_CLASS_LIGHT

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.8,
		"slash" = 1.1,
		"bullet" = 0.6,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1,
	)

	explosive_resistance = 150
	wall_ram_damage = 150
	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION

	misc_multipliers = list(
		"move" = 0.6,
		"accuracy" = 1,
		"cooldown" = 1
	)

	move_max_momentum = 2.5 //Very light
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

/obj/vehicle/multitile/twe_apc/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] FV150-C \"[nickname]\" APC" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] FV150-C APC"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list


/obj/vehicle/multitile/twe_apc/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/twe_apc/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/twe_tank_turret)

/obj/vehicle/multitile/twe_apc/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
		))

/obj/vehicle/multitile/twe_apc/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/name_vehicle,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
		))

/obj/vehicle/multitile/twe_apc/MouseDrop_T(mob/dropped, mob/user)
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

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/twe_apc
	name = "APC Spawner"
	icon = 'icons/obj/vehicles/twe_tank.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/twe_apc/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: No hardpoints
/obj/effect/vehicle_spawner/twe_apc/spawn_vehicle()
	var/obj/vehicle/multitile/twe_apc/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

	return APC

//PRESET: turret, treads installed
/obj/effect/vehicle_spawner/twe_apc/plain/load_hardpoints(obj/vehicle/multitile/twe_apc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/twe_apc/hull/load_hardpoints(obj/vehicle/multitile/twe_apc/V)
	return

//Just the hull and it's broken TOO, you get the full experience
/obj/effect/vehicle_spawner/twe_apc/hull/broken/spawn_vehicle()
	var/obj/vehicle/multitile/twe_apc/dead = ..()
	load_damage(dead)
	dead.update_icon()

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/twe_apc/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/twe_apc/APC = new (loc)

	load_misc(APC)
	handle_direction(APC)
	load_hardpoints(APC)
	load_damage(APC)
	APC.update_icon()

/obj/effect/vehicle_spawner/twe_apc/decrepit/load_hardpoints(obj/vehicle/multitile/twe_apc/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/smoke_launcher/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)


//PRESET: default hardpoints
/obj/effect/vehicle_spawner/twe_apc/fixed/armed/load_hardpoints(obj/vehicle/multitile/twe_apc/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/smoke_launcher/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

// Command variant

/obj/vehicle/multitile/twe_apc/command
	name = "Type 200/FCV-C ‘Senshi’ Command Light APC"
	desc = "The Type 200/FCV ‘Senshi’ Light APC is a 6m long, 6m wide, 8m tall support vehicle for the RMC. Based off the original FV150 Light Cavalry Tank design, it's interior space has been expanded thanks to the lack of turret basket & autoloader systems. Entrance on the back."

	icon = 'icons/obj/vehicles/twe_tank.dmi'
	icon_state = "apc_command_base"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/twe_apc/command

	passengers_slots = 3
	revivable_dead_slots = 1
	xenos_slots = 1

//PRESET: destroyed
/obj/effect/vehicle_spawner/twe_apc/command/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/twe_apc/command/APC = new (loc)

	load_misc(APC)
	handle_direction(APC)
	load_hardpoints(APC)
	load_damage(APC)
	APC.update_icon()

/obj/effect/vehicle_spawner/twe_apc/command/decrepit/load_hardpoints(obj/vehicle/multitile/twe_apc/command/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/smoke_launcher/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)


//PRESET: wheels installed
/obj/effect/vehicle_spawner/twe_apc/command/fixed/armed/spawn_vehicle()
	var/obj/vehicle/multitile/twe_apc/command/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

/obj/effect/vehicle_spawner/twe_apc/command/fixed/armed/load_hardpoints(obj/vehicle/multitile/twe_apc/command/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/smoke_launcher/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
