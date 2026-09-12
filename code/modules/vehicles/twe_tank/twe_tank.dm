/obj/vehicle/multitile/tank/twe_tank
	name = "FV150 ‘Hobelar’ Light Cavalry Tank"
	desc = "The FV150 ‘Hobelar’ Light Cavalry Tank is a 6m long, 6m wide, 8m tall support vehicle for the RMC. Originally procured for the Special Air Service operations as an Airborne tank, this model has been made into a support vehicle for the Royal Marines thanks to a change of symbol and technological design. Entrance at the back."
	desc_lore = "An unwieldy pillar of the TWE's arsenal, the FV150 initially began it's lifespan in the late 2170s as Weyland-Yutani subsidiary Southfield Motors' entry into the Light Fighting Vehicle Programme, a competition held by the Empire's Special Air Service (SAS) in search of a lightweight vehicle to support and supplement the firepower of the otherwise lightly-equipped paratroopers. \n Despite facing incredibly stiff competition from other entries at the programme's final stages, most notable of which was the Lockmart Industries FV580 (a tankette variant of the M577A3) and the Alphatech Industries XV40 (a up-armored version of the XT-37 fast-attack vehicle), it was the FV150 that was ultimately chosen to be procured by the SAS. \n Such a choice did not come without it's fair share of consequences, however. Accusations of corruption and favoritism almost immediately sprang up on account of the TWE's inexplicable connections (and dependence) on the Weyland-Yutani Corproation. The resulting string of committee hearings, political resignations, and media backlash would be remembered as one of the most devastating political scandals that the Empire has ever faced. \n The FV150's reputation in the field was just as equally mixed. With the initial production run concluded just before the official conclusion of the Australia Wars, SAS FV150s quickly found themselves muddled in everything from para-drop raids to insurgent ambushes. \n Although the fighting vehicle was initially appreciated as a light tank (with no thanks to it's 75mm autocannon), it's complete inability to resist any attack more powerful than common rifle fire compelled SAS command into a more reserved doctrine in the face of mounting casualties. During the last months of the war, it was no uncommon sight to see burned-out wrecks of FV150s on major roadways and particularly volatile areas of the Australian Outback as a sign of recent SAS activity, and FV-150 crews were have said to be more prone to mental disorders related to paranoia than any other deployed member of the Imperial Armed Forces. \n Shortly after the conclusion of the Australia Wars, the FV150 was also picked to become a supplementary fire support/reconnaissance vehicle in the Royal Marines Commando (RMC) after a rather brisk set of field trials. The final production run of the FV150 concluded in late 2181, with most of the surviving vehicles having been fitted with the 'B' model upgrade."

	icon = 'icons/obj/vehicles/twe_tank.dmi'
	icon_state = "tank_base"

	pixel_x = -16
	pixel_y = -16

	bound_width = 64
	bound_height = 64

	bound_x = 0
	bound_y = 0

	health = 1400

	interior_map = /datum/map_template/interior/twe_tank

	passengers_slots = 3
	revivable_dead_slots = 1
	xenos_slots = 1

	entrances = list(
		"rear" = list(0, 2),

	)

	entrance_speed = 0.5 SECONDS

	required_skill = SKILL_VEHICLE_LARGE

	movement_sound = 'sound/vehicles/tank_driving.ogg'

	light_range = 7

	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/twe_tank_turret,
		/obj/item/hardpoint/locomotion/treads,
		/obj/item/hardpoint/locomotion/treads/robust,
		/obj/item/hardpoint/secondary/m56cupola/twe_tank,
		/obj/item/hardpoint/support/smoke_launcher/twe_tank
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
		"acid" = 1.8,
		"slash" = 0.8,
		"bullet" = 0.5,
		"explosive" = 0.6,
		"blunt" = 0.5,
		"abstract" = 1,
	)

	explosive_resistance = 300
	wall_ram_damage = 150
	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION

	misc_multipliers = list(
		"move" = 0.8,
		"accuracy" = 1,
		"cooldown" = 1
	)

	move_max_momentum = 2.5 //Very light
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

/obj/vehicle/multitile/tank/twe_tank/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] FV150 \"[nickname]\" Tank" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] FV150 Tank"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior" //this fluff allows it to be at the start of cams list


/obj/vehicle/multitile/tank/twe_tank/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/tank/twe_tank/load_hardpoints()
	add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/twe_tank_turret)

/obj/vehicle/multitile/tank/twe_tank/add_seated_verbs(mob/living/M, seat)
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
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

/obj/vehicle/multitile/tank/twe_tank/remove_seated_verbs(mob/living/M, seat)
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
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
		))

//Called when players try to move vehicle
//Another wrapper for try_move()
/obj/vehicle/multitile/tank/twe_tank/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/tank_turret/twe_tank_turret/A = null
	for(var/obj/item/hardpoint/holder/tank_turret/twe_tank_turret/AT in hardpoints)
		A = AT
		break
	if(!A)
		return FALSE

	if(direction == GLOB.reverse_dir[A.dir] || direction == A.dir)
		return FALSE

	A.user_rotation(user, turning_angle(A.dir, direction))
	update_icon()

	return TRUE

/obj/vehicle/multitile/tank/twe_tank/MouseDrop_T(mob/dropped, mob/user)
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
/obj/effect/vehicle_spawner/twe_tank
	name = "Tank Spawner"
	icon = 'icons/obj/vehicles/twe_tank.dmi'
	icon_state = "tank_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/twe_tank/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

//PRESET: turret, no hardpoints
/obj/effect/vehicle_spawner/twe_tank/spawn_vehicle()
	var/obj/vehicle/multitile/tank/twe_tank/TANK = new (loc)

	load_misc(TANK)
	load_hardpoints(TANK)
	handle_direction(TANK)
	TANK.update_icon()

	return TANK

/obj/effect/vehicle_spawner/twe_tank/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/twe_tank_turret)

//PRESET: turret, treads installed
/obj/effect/vehicle_spawner/twe_tank/plain/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/twe_tank_turret)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)

//PRESET: no hardpoints
/obj/effect/vehicle_spawner/twe_tank/hull/load_hardpoints(obj/vehicle/multitile/tank/V)
	return

//Just the hull and it's broken TOO, you get the full experience
/obj/effect/vehicle_spawner/twe_tank/hull/broken/spawn_vehicle()
	var/obj/vehicle/multitile/tank/tonk = ..()
	load_damage(tonk)
	tonk.update_icon()

//PRESET: default hardpoints, destroyed
/obj/effect/vehicle_spawner/twe_tank/decrepit/spawn_vehicle()
	var/obj/vehicle/multitile/tank/twe_tank/TANK = new (loc)

	load_misc(TANK)
	handle_direction(TANK)
	load_hardpoints(TANK)
	load_damage(TANK)
	TANK.update_icon()

/obj/effect/vehicle_spawner/twe_tank/decrepit/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/smoke_launcher/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/twe_tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/twe_tank_turret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/autocannon/twe_tank)
		break

//PRESET: default hardpoints
/obj/effect/vehicle_spawner/twe_tank/fixed/armed/load_hardpoints(obj/vehicle/multitile/tank/V)
	V.add_hardpoint(new /obj/item/hardpoint/support/smoke_launcher/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/secondary/m56cupola/twe_tank)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/treads)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/twe_tank_turret)
	for(var/obj/item/hardpoint/holder/tank_turret/twe_tank_turret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/autocannon/twe_tank)
		break
