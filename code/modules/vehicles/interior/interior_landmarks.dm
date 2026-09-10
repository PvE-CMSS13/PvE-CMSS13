/obj/effect/landmark/interior
	name = "interior marker"
	var/datum/interior/parent

/obj/effect/landmark/interior/proc/on_load(datum/interior/I)
	return

/*
	Spawner landmarks
*/

/obj/effect/landmark/interior/spawn
	name = "interior interactable spawner"
// Interiors will call this when they're created
/obj/effect/landmark/interior/spawn/on_load(datum/interior/I)
	qdel(src)

// Entrance & exit spawner
/obj/effect/landmark/interior/spawn/entrance
	name = "entrance marker"
	icon_state = "arrow"

	var/exit_type = /obj/structure/interior_exit

/obj/effect/landmark/interior/spawn/entrance/on_load(datum/interior/I)
	var/exit_path = exit_type
	if(!exit_path)
		return
	var/obj/structure/interior_exit/E = new exit_path(get_turf(src))

	if(name != initial(name))
		E.name = name
	if(desc != initial(desc))
		E.desc = desc
	E.interior = I
	E.entrance_id = tag
	E.setDir(dir)
	E.alpha = alpha
	E.update_icon()
	E.pixel_x = pixel_x
	E.pixel_y = pixel_y
	// Don't qdel this because it's used for entering as well

/obj/effect/landmark/interior/spawn/entrance/step_toward/on_load(datum/interior/I)
	var/exit_path = exit_type
	if(!exit_path)
		return
	var/obj/structure/interior_exit/E = new exit_path(get_step(src, dir))

	E.interior = I
	E.entrance_id = tag
	E.setDir(dir)
	E.alpha = alpha
	E.update_icon()
	E.pixel_x = pixel_x
	E.pixel_y = pixel_y

// Driver's seat spawner
/obj/effect/landmark/interior/spawn/vehicle_driver_seat
	name = "driver's seat spawner"
	icon = 'icons/obj/objects.dmi'
	icon_state = "comfychair"
	color = "red"

/obj/effect/landmark/interior/spawn/vehicle_driver_seat/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/driver/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.layer = layer
	S.vehicle = I.exterior
	S.required_skill = S.vehicle.required_skill
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

// Gunner's seat spawner
/obj/effect/landmark/interior/spawn/vehicle_gunner_seat
	name = "gunner's seat spawner"
	color = "blue"

/obj/effect/landmark/interior/spawn/vehicle_commander_seat
	name = "commander's seat spawner"
	icon = 'icons/obj/objects.dmi'
	icon_state = "comfychair"
	color = "yellow"

/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/gunner/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.layer = layer
	S.vehicle = I.exterior
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_driver_seat/armor
	name = "armor driver's seat spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "armor_chair"
	color = "red"

/obj/effect/landmark/interior/spawn/vehicle_driver_seat/armor/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/driver/armor/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.vehicle = I.exterior
	S.required_skill = S.vehicle.required_skill
	S.setDir(dir)
	S.update_icon()
	S.alpha = alpha
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/armor
	name = "armor gunner's seat spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "armor_chair"
	color = "blue"

/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/armor/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/gunner/armor/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.vehicle = I.exterior
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_commander_seat/armor
	name = "armor commander's seat spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "armor_chair"
	color = "yellow"

/obj/effect/landmark/interior/spawn/vehicle_commander_seat/armor/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/commander/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.vehicle = I.exterior
	S.required_skill = S.vehicle.required_skill
	S.setDir(dir)
	S.update_icon()
	S.alpha = alpha
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_driver_seat/armor/movie
	name = "movie apc seat spawner"
	var/buckling_y = 0

/obj/effect/landmark/interior/spawn/vehicle_driver_seat/armor/movie/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/driver/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.layer = layer
	S.vehicle = I.exterior
	S.required_skill = S.vehicle.required_skill
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y
	S.buckling_y = buckling_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_operator_seat/armor/solo
	name = "armor operator's seat spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "armor_chair"
	color = "yellow"

/obj/effect/landmark/interior/spawn/vehicle_operator_seat/armor/solo/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/solo/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.vehicle = I.exterior
	S.required_skill = S.vehicle.required_skill
	S.setDir(dir)
	S.update_icon()
	S.alpha = alpha
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_support_gunner_seat
	name = "1st support gunner's seat spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "armor_chair"
	color = "#00ad00"

/obj/effect/landmark/interior/spawn/vehicle_support_gunner_seat/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/support_gunner/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.vehicle = I.exterior
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/vehicle_support_gunner_seat/second
	name = "2nd support gunner's seat spawner"
	color = "#b1b100"

/obj/effect/landmark/interior/spawn/vehicle_support_gunner_seat/second/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/support_gunner/second/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.vehicle = I.exterior
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)

/obj/effect/landmark/interior/spawn/interior_camera
	name = "interior camera spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "vehicle_camera"
	color = "#00c5cc"

/obj/effect/landmark/interior/spawn/interior_camera/on_load(datum/interior/I)

	var/obj/structure/machinery/camera/vehicle/CAM = new(loc)

	var/obj/vehicle/multitile/vehicle = I.exterior
	if(!istype(vehicle))
		return

	vehicle.camera_int = CAM
	CAM.setDir(dir)
	CAM.alpha = alpha
	CAM.update_icon()
	CAM.pixel_x = pixel_x
	CAM.pixel_y = pixel_y

	qdel(src)

// Landmark for spawning the reloader
/obj/effect/landmark/interior/spawn/weapons_loader
	name = "vehicle weapons reloader spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "weapons_loader"
	color = "#00920c"

/obj/effect/landmark/interior/spawn/weapons_loader/on_load(datum/interior/I)
	var/obj/structure/weapons_loader/R = new(loc)

	R.icon = icon
	R.icon_state = icon_state
	R.layer = layer
	R.pixel_x = pixel_x
	R.pixel_y = pixel_y
	R.density = density
	R.vehicle = I.exterior
	R.setDir(dir)
	R.update_icon()

	qdel(src)

//This one spawns armored vehicles version of viewport
/obj/effect/landmark/interior/spawn/interior_viewport
	name = "armored vehicle viewport spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "viewport"
	layer = INTERIOR_DOOR_LAYER
	color = "#009cb8"

/obj/effect/landmark/interior/spawn/interior_viewport/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/V = new(loc)

	V.dir = dir
	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.layer = layer
	V.alpha = alpha
	V.layer = layer
	V.update_icon()

	qdel(src)

//Landmark for spawning windows
/obj/effect/landmark/interior/spawn/interior_viewport/simple
	name = "simple vehicle viewport spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "viewport_simple"
	layer = INTERIOR_DOOR_LAYER
	color = "#009cb8"

/obj/effect/landmark/interior/spawn/interior_viewport/simple/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/simple/V = new(loc)

	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.layer = layer
	V.alpha = alpha

	qdel(src)

//Landmark for van's windshield
/obj/effect/landmark/interior/spawn/interior_viewport/simple/windshield
	name = "windshield viewport spawner"
	icon = 'icons/obj/vehicles/interiors/van.dmi'
	icon_state = "windshield_viewport_top"
	layer = INTERIOR_DOOR_LAYER
	color = "#009cb8"
	alpha = 80

/obj/effect/landmark/interior/spawn/interior_viewport/simple/windshield/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/simple/windshield/V = new(loc)

	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.alpha = alpha
	V.icon = icon

	qdel(src)

//AA APC fancy viewport spawner
/obj/effect/landmark/interior/spawn/interior_viewport/terminal
	name = "ADS-C viewport console spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "viewport_terminal"
	layer = INTERIOR_DOOR_LAYER
	color = "#009cb8"

/obj/effect/landmark/interior/spawn/interior_viewport/terminal/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/terminal/V = new(loc)

	V.dir = dir
	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.layer = layer
	V.alpha = alpha
	V.layer = layer
	V.update_icon()

	qdel(src)

//Tank commander fancy viewport spawner
/obj/effect/landmark/interior/spawn/interior_viewport/terminal/tank_commander
	name = "Tank-commander viewport console spawner"
	layer = BELOW_MOB_LAYER

/obj/effect/landmark/interior/spawn/interior_viewport/terminal/tank_commander/on_load(datum/interior/I)
	var/obj/structure/interior_viewport/terminal/tank/V = new(loc)

	V.dir = dir
	V.vehicle = I.exterior
	V.pixel_x = pixel_x
	V.pixel_y = pixel_y
	V.layer = layer
	V.alpha = alpha
	V.layer = layer
	V.update_icon()

	qdel(src)

// UPP VAN Gunner without skill
/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/armor/van
	name = "armor gunner's seat spawner"
	icon = 'icons/obj/vehicles/interiors/general.dmi'
	icon_state = "armor_chair"
	color = "yellow"

/obj/effect/landmark/interior/spawn/vehicle_gunner_seat/armor/van/on_load(datum/interior/I)
	var/obj/structure/bed/chair/comfy/vehicle/van_gunner/S = new(loc)

	S.icon = icon
	S.icon_state = icon_state
	S.layer = layer
	S.vehicle = I.exterior
	S.setDir(dir)
	S.alpha = alpha
	S.update_icon()
	S.handle_rotation()
	S.pixel_x = pixel_x
	S.pixel_y = pixel_y

	qdel(src)
