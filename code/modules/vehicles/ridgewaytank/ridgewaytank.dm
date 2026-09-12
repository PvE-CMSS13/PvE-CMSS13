// Ridgeway Tank
/obj/vehicle/multitile/tank/ridgeway
	name = "M40 Ridgeway Heavy Tank"
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back."
	desc_lore = "The M40 Ridgeway heavy tank is the premier armoured vehicle in use by the United States armed forces. An advanced piece of equipment introduced in the late 2170s, the Ridgeway is the epitome of a modern fighting vehicle; featuring extensive automation and advanced defensive systems including a independent-targeting plasma hard-kill phalanx and cutting edge stealth capabilities making it effectively invisible to most basic ground sensors. Despite being slated to replace the outdated M22 Jackson, it has seen limited deployment among Colonial Marine units."

	icon = 'icons/obj/vehicles/ridgeway.dmi'
	icon_state = "tank_base"
	pixel_x = -65
	pixel_y = -65

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/ridgeway

	passengers_slots = 4
	//this is done in case VCs die inside the tank, so that someone else can come in and take them out.
	revivable_dead_slots = 2
	xenos_slots = 4

	entrances = list(
		"back" = list(0, 2)
	)

	movement_sound = 'sound/vehicles/tank_driving.ogg'
	honk_sound = 'sound/vehicles/honk_3_ambulence.ogg'

	required_skill = SKILL_VEHICLE_LARGE

	vehicle_flags = VEHICLE_CLASS_MEDIUM

	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.6

	light_range = 5

	wall_ram_damage = 350
	vehicle_ram_multiplier = 20 //Big heavy chunk of metal cares not for crunchies

	// Rest (all the guns) is handled by the tank turret hardpoint
	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/ridgeway,
		/obj/item/hardpoint/support/weapons_sensor,
		/obj/item/hardpoint/support/overdrive_enhancer,
		/obj/item/hardpoint/support/artillery_module,
		/obj/item/hardpoint/armor/snowplow,
		/obj/item/hardpoint/locomotion/treads/ridgeway,
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
		"acid" = 3.5,
		"slash" = 0.3,
		"bullet" = 0.4,
		"explosive" = 0.6,
		"blunt" = 0.3,
		"abstract" = 1,
	)

	explosive_resistance = 1000

/obj/vehicle/multitile/tank/ridgeway/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M40 \"[nickname]\" Heavy Tank" //this fluff allows it to be at the start of cams list M40 Ridgeway Heavy Tank
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] M40 Heavy Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/tank/ridgeway/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/ridgeway)

// ** PRESETS SPAWNERS

/obj/effect/vehicle_spawner/ridgeway

	name = "Tank Spawner"
	icon = 'icons/obj/vehicles/ridgeway.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/ridgeway/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: turret, no hardpoints (not the one without turret for convenience, you still expect to have turret when you spawn "no hardpoints tank")
/obj/effect/vehicle_spawner/ridgeway/spawn_vehicle()
	var/obj/vehicle/multitile/tank/ridgeway/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/ridgeway/load_hardpoints(obj/vehicle/multitile/tank/ridgeway/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/ridgeway)

//PRESET: turret, treads installed
/obj/effect/vehicle_spawner/ridgeway/plain/load_hardpoints(obj/vehicle/multitile/tank/ridgeway/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/ridgeway)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/ridgeway/hull/load_hardpoints(obj/vehicle/multitile/tank/ridgeway/vic)
	return

//Just the hull and it's broken TOO, you get the full experience
/obj/effect/vehicle_spawner/ridgeway/hull/broken/spawn_vehicle()
	var/obj/vehicle/multitile/tank/ridgeway/tonk = ..()
	load_damage(tonk)
	tonk.update_icon()

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/ridgeway/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/tank/ridgeway/TANK = new (loc)

	load_misc(TANK)
	handle_direction(TANK)
	load_hardpoints(TANK)
	load_damage(TANK)
	TANK.update_icon()

/obj/effect/vehicle_spawner/ridgeway/decrepit/load_hardpoints(obj/vehicle/multitile/tank/ridgeway/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads/ridgeway)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/ridgeway)
	for(var/obj/item/hardpoint/holder/tank_turret/ridgeway/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon/ridgeway)
		break

//PRESET: default hardpoints
/obj/effect/vehicle_spawner/ridgeway/fixed/load_hardpoints(obj/vehicle/multitile/tank/ridgeway/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads/ridgeway)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/ridgeway)
	for(var/obj/item/hardpoint/holder/tank_turret/ridgeway/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon/ridgeway)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//PRESET: Plasma hardpoints
/obj/effect/vehicle_spawner/ridgeway/plasma/load_hardpoints(obj/vehicle/multitile/tank/ridgeway/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/artillery_module)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads/ridgeway)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/ridgeway)
	for(var/obj/item/hardpoint/holder/tank_turret/ridgeway/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon/plasmacannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/small_flamer)
		break
