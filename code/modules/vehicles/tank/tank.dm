/obj/vehicle/multitile/tank
	name = "M34A2 Longstreet Light Tank"
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back."
	desc_lore = "The Longstreet is a more recent addition to the Colonial Marines' arsenal, though it has served with distinction with Army units for over a decade. Designed as a fire-support and reconnaissance vehicle, with overall loaded mass permitting it be be carried in smaller drop-craft. \n The A2 variant was specially modified for USCM use, featuring modular turret packages and enhanced environmental hardening to account for variable AOs. It has proven exceedingly popular thanks to more modern ergonomics and combat-computer systems."

	icon = 'icons/obj/vehicles/tank.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/tank

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

	var/view_boost = 10 //VV as needed to increase or decrease the tank crew's view range

	wall_ram_damage = 350
	vehicle_ram_multiplier = 20 //Big heavy chunk of metal cares not for crunchies

	// Rest (all the guns) is handled by the tank turret hardpoint
	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret,
		/obj/item/hardpoint/holder/tank_turret/desert,
		/obj/item/hardpoint/holder/tank_turret/jungle,
		/obj/item/hardpoint/support/weapons_sensor,
		/obj/item/hardpoint/support/overdrive_enhancer,
		/obj/item/hardpoint/support/artillery_module,
		/obj/item/hardpoint/armor/ballistic,
		/obj/item/hardpoint/armor/caustic,
		/obj/item/hardpoint/armor/concussive,
		/obj/item/hardpoint/armor/paladin,
		/obj/item/hardpoint/armor/snowplow,
		/obj/item/hardpoint/locomotion/treads,
		/obj/item/hardpoint/locomotion/treads/robust,
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

	explosive_resistance = 500

/obj/vehicle/multitile/tank/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M34A2 \"[nickname]\" Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] M34A2 Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/tank/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/tank/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)

/obj/vehicle/multitile/tank/add_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	add_verb(user.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
	))
	user.client.change_view(view_boost, seat)
	user.client.pixel_x = 0
	user.client.pixel_y = 0
	if(seat == VEHICLE_DRIVER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(user.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

/obj/vehicle/multitile/tank/remove_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	remove_verb(user.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
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
	else if(seat == VEHICLE_GUNNER)
		remove_verb(user.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/tank/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/tank_turret/turret = null
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in hardpoints)
		turret = tonkturret
		break
	if(!turret)
		return FALSE

	if(direction == GLOB.reverse_dir[turret.dir] || direction == turret.dir)
		return FALSE

	turret.user_rotation(user, turning_angle(turret.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/tank/MouseDrop_T(mob/dropped, mob/user)
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

	// Now we check to make sure the turf on the other side of the tank isn't dense too
	current_turf = get_step(current_turf, dir_to_go)
	if(current_turf.density)
		to_chat(user, SPAN_XENO("The path over [src] is obstructed!"))
		return

	to_chat(user, SPAN_XENO("We begin to jump over [src]..."))
	if(!do_after(user, 3 SECONDS, INTERRUPT_ALL, BUSY_ICON_HOSTILE))
		to_chat(user, SPAN_XENO("We stop jumping over [src]."))
		return

	user.forceMove(current_turf)
	to_chat(user, SPAN_XENO("We jump to the other side of [src]."))

/*
** CAMO TANKS
*/

/obj/vehicle/multitile/tank/desert
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back. Painted in an arid-environment camo scheme."
	icon_state = "tank_base_d"

/obj/vehicle/multitile/tank/jungle
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back. Painted in a lush-environment camo scheme."
	icon_state = "tank_base_j"

/obj/vehicle/multitile/tank/night
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back. Painted in a dark-environment camo scheme."
	icon_state = "tank_base_n"

/*
** SOLO TANKS
*/
/obj/vehicle/multitile/tank/solo
	interior_map = /datum/map_template/interior/tank_solo

/obj/vehicle/multitile/tank/solo/add_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	add_verb(user.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/toggle_door_lock,
		/obj/vehicle/multitile/proc/activate_horn,
		/obj/vehicle/multitile/proc/cycle_hardpoint,
		/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
	))
	user.client.change_view(view_boost, seat)
	user.client.pixel_x = 0
	user.client.pixel_y = 0

/obj/vehicle/multitile/tank/solo/remove_seated_verbs(mob/living/user, seat)
	if(!user.client)
		return
	remove_verb(user.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/toggle_door_lock,
		/obj/vehicle/multitile/proc/activate_horn,
		/obj/vehicle/multitile/proc/cycle_hardpoint,
		/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
	))
	user.client.change_view(GLOB.world_view_size, seat)
	user.client.pixel_x = 0
	user.client.pixel_y = 0
	SStgui.close_user_uis(user, src)

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/tank/solo/relaymove(mob/user, direction)
	return ..()

/*
** COMMAND TANK
*/
/obj/vehicle/multitile/tank/command
	name = "M34A3 Hampton Light Command Tank"
	desc = "A giant piece of armor with a big gun and enhanced comms equipment, you know what to do. Entrance in the back."
	desc_lore = "Developed and deployed recently, the A3 model of the M34 light tank is a command variant of the Longstreet. The Hampton fields a bigger fighting compartment to facilitate a 'commander' station, and more robust connections to the command & control network compared to the more commonly seen version."

	interior_map = /datum/map_template/interior/tank_command

	passengers_slots = 5
	//this is done in case VCs die inside the tank, so that someone else can come in and take them out.
	revivable_dead_slots = 3
	xenos_slots = 4

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

/obj/vehicle/multitile/tank/command/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] M34A3 \"[nickname]\" Command Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] M34A3 Command Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list

/obj/vehicle/multitile/tank/command/add_seated_verbs(mob/living/user, seat)
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

/obj/vehicle/multitile/tank/command/remove_seated_verbs(mob/living/user, seat)
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

/*
** PRESETS SPAWNERS
*/

/obj/effect/vehicle_spawner/tank
	name = "Tank Spawner"
	icon = 'icons/obj/vehicles/tank.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/tank/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: turret, no hardpoints (not the one without turret for convenience, you still expect to have turret when you spawn "no hardpoints tank")
/obj/effect/vehicle_spawner/tank/spawn_vehicle()
	var/obj/vehicle/multitile/tank/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)

//PRESET: turret, treads installed
/obj/effect/vehicle_spawner/tank/plain/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/tank/hull/load_hardpoints(obj/vehicle/multitile/tank/vic)
	return

//Just the hull and it's broken TOO, you get the full experience
/obj/effect/vehicle_spawner/tank/hull/broken/spawn_vehicle()
	var/obj/vehicle/multitile/tank/tonk = ..()
	load_damage(tonk)
	tonk.update_icon()

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/tank/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/tank/TANK = new (loc)

	load_misc(TANK)
	handle_direction(TANK)
	load_hardpoints(TANK)
	load_damage(TANK)
	TANK.update_icon()

/obj/effect/vehicle_spawner/tank/decrepit/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//PRESET: default hardpoints
/obj/effect/vehicle_spawner/tank/fixed/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//PRESET: minigun kit
/obj/effect/vehicle_spawner/tank/fixed/minigun/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/minigun)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/small_flamer)
		break

//PRESET: dragon flamer kit
/obj/effect/vehicle_spawner/tank/fixed/flamer/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/flamer)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/grenade_launcher)
		break

//PRESET: autocannon kit
/obj/effect/vehicle_spawner/tank/fixed/autocannon/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/autocannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/towlauncher)
		break

//DESERT CAMO PRESET: turret, treads installed
/obj/effect/vehicle_spawner/tank/desert/spawn_vehicle()
	var/obj/vehicle/multitile/tank/desert/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/desert/load_hardpoints(obj/vehicle/multitile/tank/desert/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/desert)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//DESERT CAMO PRESET: default hardpoints
/obj/effect/vehicle_spawner/tank/desert/fixed/load_hardpoints(obj/vehicle/multitile/tank/desert/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/desert)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//DESERT CAMO PRESET: minigun kit
/obj/effect/vehicle_spawner/tank/desert/fixed/minigun/load_hardpoints(obj/vehicle/multitile/tank/desert/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/desert)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/minigun)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/small_flamer)
		break

//DESERT CAMO PRESET: dragon flamer kit
/obj/effect/vehicle_spawner/tank/desert/fixed/flamer/load_hardpoints(obj/vehicle/multitile/tank/desert/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/desert)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/flamer)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/grenade_launcher)
		break

//DESERT CAMO PRESET: autocannon kit
/obj/effect/vehicle_spawner/tank/desert/fixed/autocannon/load_hardpoints(obj/vehicle/multitile/tank/desert/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/desert)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/autocannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/towlauncher)
		break

//JUNGLE CAMO PRESET: turret, treads installed
/obj/effect/vehicle_spawner/tank/jungle/spawn_vehicle()
	var/obj/vehicle/multitile/tank/jungle/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/jungle/load_hardpoints(obj/vehicle/multitile/tank/jungle/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/jungle)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//JUNGLE CAMO PRESET: default hardpoints
/obj/effect/vehicle_spawner/tank/jungle/fixed/load_hardpoints(obj/vehicle/multitile/tank/jungle/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/jungle)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//JUNGLE CAMO PRESET: minigun kit
/obj/effect/vehicle_spawner/tank/jungle/fixed/minigun/load_hardpoints(obj/vehicle/multitile/tank/jungle/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/jungle)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/minigun)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/small_flamer)
		break

//JUNGLE CAMO PRESET: dragon flamer kit
/obj/effect/vehicle_spawner/tank/jungle/fixed/flamer/load_hardpoints(obj/vehicle/multitile/tank/jungle/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/jungle)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/flamer)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/grenade_launcher)
		break

//JUNGLE CAMO PRESET: autocannon kit
/obj/effect/vehicle_spawner/tank/jungle/fixed/autocannon/load_hardpoints(obj/vehicle/multitile/tank/jungle/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/jungle)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/autocannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/towlauncher)
		break

//NIGHT/URBAN CAMO PRESET: turret, treads installed
/obj/effect/vehicle_spawner/tank/night/spawn_vehicle()
	var/obj/vehicle/multitile/tank/night/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/night/load_hardpoints(obj/vehicle/multitile/tank/night/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/night)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//NIGHT/URBAN CAMO PRESET: default hardpoints
/obj/effect/vehicle_spawner/tank/night/fixed/load_hardpoints(obj/vehicle/multitile/tank/night/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/night)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//NIGHT/URBAN CAMO PRESET: minigun kit
/obj/effect/vehicle_spawner/tank/night/fixed/minigun/load_hardpoints(obj/vehicle/multitile/tank/night/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/night)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/minigun)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/small_flamer)
		break

//NIGHT/URBAN CAMO PRESET: dragon flamer kit
/obj/effect/vehicle_spawner/tank/night/fixed/flamer/load_hardpoints(obj/vehicle/multitile/tank/night/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/night)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/flamer)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/grenade_launcher)
		break

//NIGHT/URBAN CAMO PRESET: autocannon kit
/obj/effect/vehicle_spawner/tank/night/fixed/autocannon/load_hardpoints(obj/vehicle/multitile/tank/night/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/night)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/autocannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/towlauncher)
		break

//COMMAND TANK PRESET: no armor, guns or module
/obj/effect/vehicle_spawner/tank/command/spawn_vehicle()
	var/obj/vehicle/multitile/tank/command/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/command/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//COMMAND TANK ARMED PRESET: LTB, cupola gun & artillery module
/obj/effect/vehicle_spawner/tank/command/fixed/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/artillery_module)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola)
		break

//SOLO TANK PRESET: fully armed and ready to rumble
/obj/effect/vehicle_spawner/tank/solo/spawn_vehicle()
	var/obj/vehicle/multitile/tank/solo/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/tank/solo/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/paladin)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/cannon/solo)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/solo)
		break

//PRESET: minigun kit
/obj/effect/vehicle_spawner/tank/solo/minigun/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/minigun/solo)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/small_flamer/solo)
		break

//PRESET: dragon flamer kit
/obj/effect/vehicle_spawner/tank/solo/flamer/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/flamer/solo)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/grenade_launcher/solo)
		break

//PRESET: autocannon kit
/obj/effect/vehicle_spawner/tank/solo/autocannon/load_hardpoints(obj/vehicle/multitile/tank/vic)
	vic.add_hardpoint(new /obj/item/hardpoint/support/weapons_sensor)
	vic.add_hardpoint(new /obj/item/hardpoint/armor/ballistic)
	vic.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	vic.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/tonkturret in vic.hardpoints)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/primary/autocannon/solo)
		tonkturret.add_hardpoint(new /obj/item/hardpoint/secondary/towlauncher/solo)
		break
