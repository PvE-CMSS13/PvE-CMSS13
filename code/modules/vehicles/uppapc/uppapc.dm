/obj/vehicle/multitile/apc/uppapc
	name = "ZSL-68 'Pilgrim'"
	desc = "The ZSL-68 'Pilgrim APC designed in a joint project Ukraine and China, as part of the 'New Arms Cooperative' initiative of 2165. Despite its' rough appearance and age, it is still respected by the many branches it serves. Entrances on the rear and sides"

	icon = 'icons/obj/vehicles/uppapc.dmi'
	icon_state = "uppapc_base"
	pixel_x = -65
	pixel_y = -65

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/uppapc

	passengers_slots = 20
	revivable_dead_slots = 3
	xenos_slots = 8

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-2, 0),
		"rear center" = list(0, 2),

	)

	entrance_speed = 0.5 SECONDS

	required_skill = SKILL_VEHICLE_LARGE

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	light_range = 7

	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/apc_turret,
		/obj/item/hardpoint/locomotion/apc_wheels/zsl_wheels,
		/obj/item/hardpoint/support/flare_launcher/upp,
	)


	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	vehicle_flags = VEHICLE_CLASS_LIGHT

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 2.9,
		"slash" = 0.6,
		"bullet" = 0.6,
		"explosive" = 0.6,
		"blunt" = 0.6,
		"abstract" = 1,
	)

	explosive_resistance = 150
	wall_ram_damage = 150
	vehicle_ram_multiplier = 12

	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

/obj/vehicle/multitile/apc/uppapc/initialize_cameras(change_tag = FALSE)
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


/obj/vehicle/multitile/apc/uppapc/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/apc/uppapc/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/apc_turret)

/obj/vehicle/multitile/apc/uppapc/add_seated_verbs(mob/living/M, seat)
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
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_apc_gyrostabilizer,
		))

/obj/vehicle/multitile/apc/uppapc/remove_seated_verbs(mob/living/M, seat)
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
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_apc_gyrostabilizer,
		))

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/apc/uppapc/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/apc_turret/A = null
	for(var/obj/item/hardpoint/holder/apc_turret/AT in hardpoints)
		A = AT
		break
	if(!A)
		return FALSE

	if(direction == GLOB.reverse_dir[A.dir] || direction == A.dir)
		return FALSE

	A.user_rotation(user, turning_angle(A.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/apc/uppapc/MouseDrop_T(mob/dropped, mob/user)
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

/obj/vehicle/multitile/apc/uppapc/solo
	interior_map = /datum/map_template/interior/uppapc_solo

/obj/vehicle/multitile/apc/uppapc/solo/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/toggle_door_lock,
		/obj/vehicle/multitile/proc/activate_horn,
		/obj/vehicle/multitile/proc/cycle_hardpoint,
		/obj/vehicle/multitile/proc/toggle_apc_gyrostabilizer,
	))

/obj/vehicle/multitile/apc/uppapc/solo/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/switch_hardpoint,
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/toggle_door_lock,
		/obj/vehicle/multitile/proc/activate_horn,
		/obj/vehicle/multitile/proc/cycle_hardpoint,
		/obj/vehicle/multitile/proc/toggle_apc_gyrostabilizer,
	))
	SStgui.close_user_uis(M, src)

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/apc/uppapc/solo/relaymove(mob/user, direction)
	return ..()

/*
** PRESETS SPAWNERS
*/
/obj/effect/vehicle_spawner/uppapc
	name = "UPP XSL Spawner"
	icon = 'icons/obj/vehicles/apc.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/uppapc/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/apc/uppapc/spawn_vehicle()
	var/obj/vehicle/multitile/apc/uppapc/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

//PRESET: only wheels installed
/obj/effect/vehicle_spawner/apc/uppapc/plain/load_hardpoints(obj/vehicle/multitile/apc/uppapc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels)

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/apc/uppapc/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/apc/uppapc/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	load_damage(APC)
	APC.update_icon()

/obj/effect/vehicle_spawner/apc/uppapc/decrepit/load_hardpoints(obj/vehicle/multitile/apc/uppapc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/zsl_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/apc_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upp)
	for(var/obj/item/hardpoint/holder/apc_turret/AT in V.hardpoints)
		AT.add_hardpoint(new /obj/item/hardpoint/primary/gshk_minigun)
		break

//PRESET: default hardpoints, installed minigun
/obj/effect/vehicle_spawner/apc/uppapc/minigun/load_hardpoints(obj/vehicle/multitile/apc/uppapc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/zsl_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/apc_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upp)
	for(var/obj/item/hardpoint/holder/apc_turret/AT in V.hardpoints)
		AT.add_hardpoint(new /obj/item/hardpoint/primary/gshk_minigun)
		break

//PRESET: default hardpoints, installed minigun, hj-35
/obj/effect/vehicle_spawner/apc/uppapc/minigunhj35/load_hardpoints(obj/vehicle/multitile/apc/uppapc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/zsl_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/apc_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upp)
	for(var/obj/item/hardpoint/holder/apc_turret/AT in V.hardpoints)
		AT.add_hardpoint(new /obj/item/hardpoint/primary/gshk_minigun)
		AT.add_hardpoint(new /obj/item/hardpoint/secondary/hj35launcher)
		break

//SOLO APC PRESET: fully armed and ready to rumble
/obj/effect/vehicle_spawner/apc/uppapc/solo/spawn_vehicle()
	var/obj/vehicle/multitile/apc/uppapc/solo/APC = new (loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

//PRESET: default hardpoints, installed minigun
/obj/effect/vehicle_spawner/apc/uppapc/solo/load_hardpoints(obj/vehicle/multitile/apc/uppapc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/zsl_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/apc_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upp)
	for(var/obj/item/hardpoint/holder/apc_turret/AT in V.hardpoints)
		AT.add_hardpoint(new /obj/item/hardpoint/primary/gshk_minigun/solo)
		break

//PRESET: default hardpoints, installed minigun, hj-35
/obj/effect/vehicle_spawner/apc/uppapc/solo/minigunhj35/load_hardpoints(obj/vehicle/multitile/apc/uppapc/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/zsl_wheels)
	V.add_hardpoint(new /obj/item/hardpoint/holder/apc_turret)
	V.add_hardpoint(new /obj/item/hardpoint/support/flare_launcher/upp)
	for(var/obj/item/hardpoint/holder/apc_turret/AT in V.hardpoints)
		AT.add_hardpoint(new /obj/item/hardpoint/primary/gshk_minigun/solo)
		AT.add_hardpoint(new /obj/item/hardpoint/secondary/hj35launcher/solo)
		break
