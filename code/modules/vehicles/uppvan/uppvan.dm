
//Trucks
//Read the documentation in multitile.dm before trying to decipher this stuff

/obj/vehicle/multitile/uppvan
	name = "Kheshig-1M"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union. Lightly armored and relatively compact, most variants are unarmed."
	layer = ABOVE_XENO_LAYER

	icon = 'icons/obj/vehicles/uppvan.dmi'
	icon_state = "uppvan_base"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/uppvan

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0),
		"back_left" = list(1, 2),
		"back_right" = list(0, 2)
	)

	vehicle_flags = VEHICLE_CLASS_WEAK

	passengers_slots = 14
	xenos_slots = 2

	misc_multipliers = list(
		"move" = 0.5, // fucking annoying how this is the only way to modify speed
		"accuracy" = 1,
		"cooldown" = 1
	)

	movement_sound = 'sound/vehicles/tank_driving.ogg'
	honk_sound = 'sound/vehicles/honk_2_truck.ogg'

	light_range = 3
	vehicle_light_range = 6

	move_max_momentum = 3

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 4,
		"slash" = 3,
		"bullet" = 1.9,
		"explosive" = 1.6,
		"blunt" = 1.6,
		"abstract" = 1,
	)

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/van_wheels/upp,
	)

	move_turn_momentum_loss_factor = 1

	req_access = list()
	req_one_access = list()

	door_locked = FALSE

	var/overdrive_next = 0
	var/overdrive_cooldown = 15 SECONDS
	var/overdrive_duration = 3 SECONDS
	var/overdrive_speed_mult = 0.3 // Additive (30% more speed, adds to 80% more speed)

	var/momentum_loss_on_weeds_factor = 0.2

	move_on_turn = TRUE

	var/list/mobs_under = list()
	var/image/under_image
	var/image/normal_image

	var/next_push = 0
	var/push_delay = 0.5 SECONDS

/obj/vehicle/multitile/uppvantank/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/uppvan/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppvanturret)

/obj/vehicle/multitile/uppvan/add_seated_verbs(mob/living/M, seat)
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
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))


/obj/vehicle/multitile/uppvan/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
		/obj/vehicle/multitile/proc/name_vehicle,
		/obj/vehicle/multitile/proc/switch_hardpoint,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

/obj/vehicle/multitile/uppvan/Initialize()
	. = ..()
	under_image = image(icon, src, icon_state, layer = BELOW_MOB_LAYER)
	under_image.alpha = 127

	normal_image = image(icon, src, icon_state, layer = layer)

	icon_state = null

	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(add_default_image))

	for(var/I in GLOB.player_list)
		add_default_image(SSdcs, I)

/obj/vehicle/multitile/uppvan/BlockedPassDirs(atom/movable/mover, target_dir)
	if(mover in mobs_under) //can't collide with the thing you're buckled to
		return NO_BLOCKED_MOVEMENT

	if(isliving(mover))
		var/mob/living/M = mover
		if(M.mob_flags & SQUEEZE_UNDER_VEHICLES)
			add_under_van(M)
			return NO_BLOCKED_MOVEMENT

		if(M.body_position == LYING_DOWN)
			return NO_BLOCKED_MOVEMENT

		if(M.mob_size >= MOB_SIZE_IMMOBILE && next_push < world.time)
			if(try_move(target_dir, force=TRUE))
				next_push = world.time + push_delay
				return NO_BLOCKED_MOVEMENT

	return ..()

/*
** PRESETS
*/
/obj/vehicle/multitile/uppvan/pre_movement()
	if(locate(/obj/effect/alien/weeds) in loc)
		move_momentum *= momentum_loss_on_weeds_factor

	. = ..()

	for(var/I in mobs_under)
		var/mob/M = I
		if(!(M.loc in locs))
			remove_under_van(M)

/obj/vehicle/multitile/uppvan/proc/add_under_van(mob/living/L)
	if(L in mobs_under)
		return

	mobs_under += L
	RegisterSignal(L, COMSIG_PARENT_QDELETING, PROC_REF(remove_under_van))
	RegisterSignal(L, COMSIG_MOB_LOGGED_IN, PROC_REF(add_client))
	RegisterSignal(L, COMSIG_MOVABLE_MOVED, PROC_REF(check_under_van))

	if(L.client)
		add_client(L)

/obj/vehicle/multitile/uppvan/proc/remove_under_van(mob/living/L)
	SIGNAL_HANDLER
	mobs_under -= L

	if(L.client)
		L.client.images -= under_image
		add_default_image(SSdcs, L)

	UnregisterSignal(L, list(
		COMSIG_PARENT_QDELETING,
		COMSIG_MOB_LOGGED_IN,
		COMSIG_MOVABLE_MOVED,
	))

/obj/vehicle/multitile/uppvan/proc/check_under_van(mob/M, turf/oldloc, direction)
	SIGNAL_HANDLER
	if(!(M.loc in locs))
		remove_under_van(M)

/obj/vehicle/multitile/uppvan/proc/add_client(mob/living/L)
	SIGNAL_HANDLER
	L.client.images += under_image
	L.client.images -= normal_image

/obj/vehicle/multitile/uppvan/proc/add_default_image(subsystem, mob/M)
	SIGNAL_HANDLER
	M.client.images += normal_image

/obj/vehicle/multitile/uppvan/Destroy()
	for(var/I in mobs_under)
		remove_under_van(I)

	for(var/I in GLOB.player_list)
		var/mob/M = I
		M.client.images -= normal_image

	QDEL_NULL(light_holder)

	return ..()

/obj/vehicle/multitile/uppvan/attackby(obj/item/O, mob/user)
	if(user.z != z)
		return ..()

	if(iswelder(O) && health >= initial(health))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("You need a stronger blowtorch!"))
			return
		var/obj/item/hardpoint/H
		for(var/obj/item/hardpoint/potential_hardpoint in hardpoints)
			if(potential_hardpoint.health < initial(potential_hardpoint.health))
				H = potential_hardpoint
				break

		if(H)
			H.handle_repair(O, user)
			update_icon()
			return

	. = ..()


/obj/vehicle/multitile/uppvan/handle_click(mob/living/user, atom/A, list/mods)
	if(mods["shift"] && !mods["alt"])
		if(overdrive_next > world.time)
			to_chat(user, SPAN_WARNING("You can't activate overdrive yet! Wait [round((overdrive_next - world.time) / 10, 0.1)] seconds."))
			return

		misc_multipliers["move"] -= overdrive_speed_mult
		addtimer(CALLBACK(src, PROC_REF(reset_overdrive)), overdrive_duration)

		overdrive_next = world.time + overdrive_cooldown
		to_chat(user, SPAN_NOTICE("You activate overdrive."))
		playsound(src, 'sound/vehicles/overdrive_activate.ogg', 75, FALSE)
		return

	return ..()

/obj/vehicle/multitile/uppvan/proc/reset_overdrive()
	misc_multipliers["move"] += overdrive_speed_mult

/obj/vehicle/multitile/uppvan/get_projectile_hit_boolean(obj/projectile/P)
	if(src == P.original) //clicking on the van itself will hit it.
		var/hitchance = P.get_effective_accuracy()
		if(prob(hitchance))
			return TRUE
	return FALSE

/obj/vehicle/multitile/uppvan/Collide(atom/A)
	if(!seats[VEHICLE_DRIVER])
		return FALSE

	if(istype(A, /obj/structure/barricade/plasteel))
		return ..()

	if(istype(A, /turf/closed/wall) || \
	   istype(A, /obj/structure/barricade/sandbags) || \
	   istype(A, /obj/structure/barricade/metal) || \
	   istype(A, /obj/structure/barricade/deployable) || \
	   istype(A, /obj/structure/machinery/cryopod)) //Can no longer runover cryopods

		return FALSE

	return ..()

/*
** PRESETS SPAWNERS
*/

/obj/effect/vehicle_spawner/uppvan
	name = "Van Spawner"
	icon = 'icons/obj/vehicles/uppvan.dmi'
	icon_state = "uppvan_base"
	pixel_x = -16
	pixel_y = -16

/obj/effect/vehicle_spawner/uppvan/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/uppvan/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/VAN = new (loc)

	load_misc(VAN)
	handle_direction(VAN)
	VAN.update_icon()

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uppvan/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	load_damage(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/decrepit/load_hardpoints(obj/vehicle/multitile/uppvan/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uppvan/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/fixed/load_hardpoints(obj/vehicle/multitile/uppvan/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

/obj/vehicle/multitile/uppvan/uppvant
	name = "Kheshig-1M-T"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union. Lightly armored and relatively compact, most variants are unarmed, though the mounting dock for a machine gun turret is on almost every model."
	layer = ABOVE_XENO_LAYER

	icon = 'icons/obj/vehicles/uppvan.dmi'
	icon_state = "uppvant_base"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/uppvant

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-1, 0),
		"back_left" = list(1, 2),
		"back_right" = list(0, 2)
	)

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/van_wheels/upp,
		/obj/item/hardpoint/holder/tank_turret/uppvanturret,
	)

	seats = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

	active_hp = list(
		VEHICLE_DRIVER = null,
		VEHICLE_GUNNER = null,
	)

/obj/vehicle/multitile/uppvan/uppvant/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppvanturret)

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/uppvan/uppvant/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/tank_turret/uppvanturret/T = null
	for(var/obj/item/hardpoint/holder/tank_turret/uppvanturret/TT in hardpoints)
		T = TT
		break
	if(!T)
		return FALSE

	if(direction == GLOB.reverse_dir[T.dir] || direction == T.dir)
		return FALSE

	T.user_rotation(user, turning_angle(T.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/uppvan/uppvant/MouseDrop_T(mob/dropped, mob/user)
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

/obj/effect/vehicle_spawner/uppvant
	name = "Van Spawner"
	icon = 'icons/obj/vehicles/uppvan.dmi'
	icon_state = "uppvant_base"
	pixel_x = -16
	pixel_y = -16

/obj/effect/vehicle_spawner/uppvant/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/uppvant/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/uppvant/VAN = new (loc)

	load_misc(VAN)
	handle_direction(VAN)
	VAN.update_icon()

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uppvant/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/uppvant/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	load_damage(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvant/decrepit/load_hardpoints(obj/vehicle/multitile/uppvan/uppvant/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uppvant/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/uppvant/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvant/fixed/load_hardpoints(obj/vehicle/multitile/uppvan/uppvant/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/uppvanturret)
	for(var/obj/item/hardpoint/holder/tank_turret/uppvanturret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/secondary/t60p3m)
		break

// Van UPP Medical

/obj/vehicle/multitile/uppvan/medical
	name = "Kheshig-1M-Medical"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union. Lightly armored and relatively compact, most variants are unarmed, The cross on the top marks this vehicle as a medical evacuation vehicle."
	layer = ABOVE_XENO_LAYER

	icon = 'icons/obj/vehicles/uppvan.dmi'
	icon_state = "uppvan_medical"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/uppvan/medical

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uppvan/medical/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/medical/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	load_damage(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/medical/decrepit/load_hardpoints(obj/vehicle/multitile/uppvan/medical/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uppvan/medical/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/medical/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/medical/fixed/load_hardpoints(obj/vehicle/multitile/uppvan/medical/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

// UPP Van logistics

/obj/vehicle/multitile/uppvan/logistics
	name = "Kheshig-1M-logistics"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union. Lightly armored and relatively compact, most variants are unarmed, The orange stripe across the side marks this vehicle as a logistics transport."
	layer = ABOVE_XENO_LAYER

	icon = 'icons/obj/vehicles/uppvan_logistics.dmi'
	icon_state = "uppvan_base"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/uppvan/logistics

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uppvan/logistics/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/logistics/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	load_damage(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/logistics/decrepit/load_hardpoints(obj/vehicle/multitile/uppvan/logistics/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uppvan/logistics/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/logistics/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/logistics/fixed/load_hardpoints(obj/vehicle/multitile/uppvan/logistics/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

// UPP Van prisoner

/obj/vehicle/multitile/uppvan/prisoner
	name = "Kheshig-1M-Prisoner"
	desc = "The Kheshig-1M is a result of a modernization program to try and make a common heavy utility vehicle for the Union. Lightly armored and relatively compact, most variants are unarmed, The red stripe across the side marks this vehicle as a prisoner transport."
	layer = ABOVE_XENO_LAYER

	icon = 'icons/obj/vehicles/uppvan.dmi'
	icon_state = "uppvan_prisoner"
	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	interior_map = /datum/map_template/interior/uppvan/prisoner

//PRESET: wheels installed, destroyed
/obj/effect/vehicle_spawner/uppvan/prisoner/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/prisoner/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	load_damage(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/prisoner/decrepit/load_hardpoints(obj/vehicle/multitile/uppvan/prisoner/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)

//PRESET: wheels installed
/obj/effect/vehicle_spawner/uppvan/prisoner/fixed/spawn_vehicle()
	var/obj/vehicle/multitile/uppvan/prisoner/VAN = new (loc)

	load_misc(VAN)
	load_hardpoints(VAN)
	handle_direction(VAN)
	VAN.update_icon()

/obj/effect/vehicle_spawner/uppvan/prisoner/fixed/load_hardpoints(obj/vehicle/multitile/uppvan/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels/upp)
