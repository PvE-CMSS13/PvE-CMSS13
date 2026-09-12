#define MOBILE_TORCH_ELEVATOR "torchelevator"
#define STAT_TORCH_EMPTY "torch_empty"
#define STAT_TORCH_OCCUPIED "torch_occupied"
#define STAT_TORCH_DECK1 "torch_lz1"
#define STAT_TORCH_DECK2 "torch_lz2"
#define STAT_TORCH_DECK3 "torch_engineering"
#define STAT_TORCH_DECK4 "torch_omega"
#define STAT_TORCH_DECK5 "torch_omega2"
/area/shuttle/torch_elevator/elevator
	requires_power = TRUE
	unlimited_power = FALSE
	powernet_name = "ground"

/area/shuttle/torch_elevator/bridge
	name = "Torch Bridge"

/area/shuttle/torch_elevator/firstdeck
	name = "Trijent First Deck"
/area/shuttle/torch_elevator/seconddeck
	name = "Trijent Second Desk"

/area/shuttle/torch_elevator/thirddeck
	name = "Trijent Third Deck"

/area/shuttle/torch_elevator/fourthdeck
	name = "Trijent Fourth Deck"

/area/shuttle/torch_elevator/fifthdeck
	name = "Trijent Fifth Deck"

/obj/docking_port/mobile/torch_elevator
	name="Elevator"
	id=MOBILE_TORCH_ELEVATOR

	// Map information
	height=5
	width=5
	preferred_direction = NORTH
	port_direction = SOUTH

	area_type = /area/shuttle/torch_elevator/elevator

	// Shuttle timings
	callTime = 30 SECONDS
	rechargeTime = 30 SECONDS
	ignitionTime = 8 SECONDS
	ambience_flight = 'sound/vehicles/tank_driving.ogg'
	ignition_sound = 'sound/mecha/powerup.ogg'

	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)
	var/datum/door_controller/aggregate/door_control
	var/elevator_network

/obj/docking_port/mobile/torch_elevator/Initialize(mapload, ...)
	. = ..()
	door_control = new()
	door_control.label = "elevator"
	for(var/area/shuttle_area in shuttle_areas)
		for(var/obj/structure/machinery/door/door in shuttle_area)
			if(istype(door, /obj/structure/machinery/door/poddoor/filler_object)) //poddoor filler was sneaking in
				continue
			door_control.add_door(door, door.id)

/obj/docking_port/mobile/torch_elevator/Destroy(force, ...)
	. = ..()
	QDEL_NULL(door_control)

/obj/docking_port/mobile/torch_elevator/beforeShuttleMove(turf/newT, rotation, move_mode, obj/docking_port/mobile/moving_dock)
	. = ..()
	door_control.control_doors("force-lock-launch", "all", force=TRUE)

/obj/docking_port/stationary/torch_elevator
	dir=NORTH
	width=5
	height=5
	// shutters to clear the area
	var/airlock_area
	var/airlock_exit
	var/elevator_network = "torch_main"

/obj/docking_port/stationary/torch_elevator/proc/get_doors()
	. = list()
	for(var/area/target_area in world)
		if(istype(target_area, airlock_area))
			for(var/obj/structure/machinery/door/door in target_area)
				. += list(door)

/obj/docking_port/stationary/torch_elevator/on_arrival(obj/docking_port/mobile/arriving_shuttle)
	. = ..()
	// open elevator doors
	if(istype(arriving_shuttle, /obj/docking_port/mobile/torch_elevator))
		var/obj/docking_port/mobile/torch_elevator/elevator = arriving_shuttle
		elevator.door_control.control_doors("unlock", airlock_exit)
		elevator.door_control.control_doors("open", airlock_exit)

	// open dock doors
	var/datum/door_controller/single/door_control = new()
	door_control.doors = get_doors()
	door_control.control_doors("unlock", FALSE, FALSE)
	door_control.control_doors("open", FALSE, FALSE)
	qdel(door_control)

	playsound(src, 'sound/machines/ping.ogg', 25, 1)
	playsound(arriving_shuttle, 'sound/machines/ping.ogg', 25, 1)

/obj/docking_port/stationary/torch_elevator/on_departure(obj/docking_port/mobile/departing_shuttle)
	. = ..()
	var/datum/door_controller/single/door_control = new()
	door_control.doors = get_doors()
	door_control.control_doors("force-lock-launch")
	qdel(door_control)

/obj/docking_port/stationary/torch_elevator/occupied
	name = "occupied"
	id = STAT_TORCH_OCCUPIED
	airlock_exit = "west"
	roundstart_template = /datum/map_template/shuttle/torch_elevator

/obj/docking_port/stationary/torch_elevator/empty
	name = "empty"
	id = STAT_TORCH_EMPTY
	airlock_exit = "west"

/obj/docking_port/stationary/torch_elevator/deck1
	name="Lz1 Elevator"
	id=STAT_TORCH_DECK1
	airlock_area=/area/shuttle/torch_elevator/firstdeck
	airlock_exit="west"
	roundstart_template = /datum/map_template/shuttle/trijent_elevator

/obj/docking_port/stationary/torch_elevator/deck2
	name="Lz2 Elevator"
	id=STAT_TORCH_DECK2
	airlock_area=/area/shuttle/torch_elevator/seconddeck
	airlock_exit="west"

/obj/docking_port/stationary/torch_elevator/deck3
	name="Engineering Elevator"
	id=STAT_TORCH_DECK3
	airlock_area=/area/shuttle/torch_elevator/thirddeck
	airlock_exit="east"

/obj/docking_port/stationary/torch_elevator/deck4
	name="Omega Elevator"
	id=STAT_TORCH_DECK4
	airlock_area=/area/shuttle/torch_elevator/fourthdeck
	airlock_exit="east"

/obj/docking_port/stationary/torch_elevator/deck5
	name="Omega Elevator"
	id=STAT_TORCH_DECK5
	airlock_area=/area/shuttle/torch_elevator/fifthdeck
	airlock_exit="east"

/datum/map_template/shuttle/torch_elevator
	name = "Torch Elevator"
	shuttle_id = MOBILE_TORCH_ELEVATOR
	var/elevator_network = "torch_main"

/datum/map_template/shuttle/torch_elevator/post_load(obj/docking_port/mobile/M)
	. = ..()
	var/datum/map_template/shuttle/torch_elevator/elev = M
	elev.elevator_network = elevator_network
	log_debug("Adding network [elevator_network] to [M.id]")

/area/shuttle/torch_elevator/bridge
	name = "Torch Bridge"

/area/shuttle/torch_elevator/firstdeck
	name = "Trijent First Deck"
/area/shuttle/torch_elevator/seconddeck
	name = "Trijent Second Desk"

/area/shuttle/torch_elevator/thirddeck
	name = "Trijent Third Deck"

/area/shuttle/torch_elevator/fourthdeck
	name = "Trijent Fourth Deck"

/area/shuttle/torch_elevator/fifthdeck
	name = "Trijent Fifth Deck"

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/get_landing_zones()
	. = list()
	var/obj/docking_port/mobile/torch_elevator/shuttle = SSshuttle.getShuttle(shuttleId)

	for(var/obj/docking_port/stationary/torch_elevator/elev in SSshuttle.stationary)
		if(!shuttle.elevator_network)
			. += list(elev)
			continue
		if(shuttle.elevator_network == elev.elevator_network)
			. += list(elev)
			continue

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call
	name = "\improper Elevator Call"
	desc = "Control panel for the elevator"
	shuttleId = MOBILE_TORCH_ELEVATOR
	is_call = TRUE
	var/dockId
	var/datum/elevator/destination/site

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/get_landing_zones()
	return list(SSshuttle.getDock(dockId))

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/occupied
	dockId = STAT_TORCH_OCCUPIED

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/empty
	dockId = STAT_TORCH_EMPTY

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/deck1
	dockId = STAT_TORCH_DECK1

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/deck2
	dockId = STAT_TORCH_DECK2

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/deck3
	dockId = STAT_TORCH_DECK3

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/deck4
	dockId = STAT_TORCH_DECK4

/obj/structure/machinery/computer/shuttle/elevator_controller/torch/elevator_call/torch/deck5
	dockId = STAT_TORCH_DECK5
