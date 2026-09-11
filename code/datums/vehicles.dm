/datum/map_template/interior
	name = "Base Interior Template"
	var/prefix = "maps/interiors/"
	var/interior_id = "SHOULD NEVER EXIST"


/datum/map_template/interior/New()
	if(interior_id == "SHOULD NEVER EXIST")
		stack_trace("invalid interior datum")
	mappath = "[prefix][interior_id].dmm"
	return ..()

/datum/map_template/interior/apc
	name = "APC"
	interior_id = "apc"

/datum/map_template/interior/apc_command
	name = "Command APC"
	interior_id = "apc_command"

/datum/map_template/interior/apc_med
	name = "Med APC"
	interior_id = "apc_med"

/datum/map_template/interior/apc_no_fpw
	name = "APC - No FPW"
	interior_id = "apc_no_fpw"

/datum/map_template/interior/apc_movie
	name = "Movie APC"
	interior_id = "apc_movie"

/datum/map_template/interior/apc_wolfpack
	name = "Wolfpack APC"
	interior_id = "apc_wolfpack"

/datum/map_template/interior/apc_aa
	name = "Anti-Air APC"
	interior_id = "apc_aa"

/datum/map_template/interior/apc_moviemed
	name = "Medical Treatment APC"
	interior_id = "apc_moviemed"

/datum/map_template/interior/arc
	name = "ARC"
	interior_id = "arc"

/datum/map_template/interior/tank
	name = "Tank"
	interior_id = "tank"

/datum/map_template/interior/tank_command
	name = "Command Tank"
	interior_id = "tank_command"

/datum/map_template/interior/upptank
	name = "UPP Tank"
	interior_id = "upptank"

/datum/map_template/interior/upptank_command
	name = "UPP Command Tank"
	interior_id = "upptank_command"

/datum/map_template/interior/aev
	name = "AEV"
	interior_id = "aev"

/datum/map_template/interior/van
	name = "Van"
	interior_id = "van"

/datum/map_template/interior/uppvan
	name = "UPP Van"
	interior_id = "uppvan"

/datum/map_template/interior/uppvan/medical
	name = "UPP Van Medical"
	interior_id = "uppvan_medical"

/datum/map_template/interior/uppvan/logistics
	name = "UPP Van Supply"
	interior_id = "uppvan_logistics"

/datum/map_template/interior/uppvan/prisoner
	name = "UPP Van Prisoner"
	interior_id = "uppvan_prisoner"

/datum/map_template/interior/uppvant
	name = "UPP Van Turret"
	interior_id = "uppvant"

/datum/map_template/interior/box_van
	name = "Box Van"
	interior_id = "box_van"

/datum/map_template/interior/pizza_van
	name = "Pizza-Galaxy Van"
	interior_id = "pizza_van"

/datum/map_template/interior/ambulance
	name = "Ambulance"
	interior_id = "ambulance"

/datum/map_template/interior/cop_car
	name = "Cop Car"
	interior_id = "cop_car"

/datum/map_template/interior/arc
	name = "ARC"
	interior_id = "arc"

/datum/map_template/interior/van_armored
	name = "Armored Van"
	interior_id = "van_armored"

/datum/map_template/interior/uppapc
	name = "ZSL-68"
	interior_id = "uppapc"
