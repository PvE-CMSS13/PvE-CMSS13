/obj/structure/machinery/door/airlock/almayer/maint/sealed
	req_access = null //No access requirements
	req_one_access = null

/obj/structure/machinery/door/airlock/almayer/maint/sealed/LateInitialize() //Has a chance to start bolted, welded, or both.
	. = ..()
	break_or_seal(15) //15% chance it starts out deconstructed.


	req_one_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_COMMAND)
	req_access = list(ACCESS_MARINE_COMMAND)
	req_one_access = list(ACCESS_MARINE_COMMAND, ACCESS_MARINE_ENGINEERING)
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_CHARLIE)

//==========================================

//USCM GROUND OUTPOST DOORS

/obj/structure/machinery/door/airlock/uscm_ground
	icon = 'icons/obj/structures/doors/prepdoor.dmi'
	dir = NORTH
	autoname = TRUE
	openspeed = 4

/obj/structure/machinery/door/airlock/uscm_ground/general
	req_one_access = list(ACCESS_MARINE_PREP, ACCESS_CIVILIAN_PUBLIC)
	glass = TRUE
	opacity = FALSE

/obj/structure/machinery/door/airlock/uscm_ground/general/bathroom
	name = "\improper Bathroom"
	icon = 'icons/obj/structures/doors/personaldoor.dmi'
	dir = EAST
	autoname = FALSE
	glass = FALSE
	opacity = TRUE

/obj/structure/machinery/door/airlock/uscm_ground/general/bathroom/shower
	name = "\improper Shower"
	icon = 'icons/obj/structures/doors/personaldoor.dmi'
	dir = EAST
	autoname = FALSE
	glass = FALSE
	opacity = TRUE

/obj/structure/machinery/door/airlock/uscm_ground/maintenance
	icon = 'icons/obj/structures/doors/maintdoor.dmi'
	dir = EAST
	req_access = list(ACCESS_MARINE_MAINT)

/obj/structure/machinery/door/airlock/uscm_ground/maintenance/synth
	icon = 'icons/obj/structures/doors/securedoor.dmi'
	dir = NORTH
	req_one_access = list(ACCESS_MARINE_SYNTH, ACCESS_MARINE_COMMAND)

/obj/structure/machinery/door/airlock/uscm_ground/checkpoint
	icon = 'icons/obj/structures/doors/secdoor_glass.dmi'
	dir = EAST
	glass = TRUE
	opacity = FALSE
	req_access = list(ACCESS_MARINE_PREP)

/obj/structure/machinery/door/airlock/uscm_ground/platoon_sarge_office
	icon = 'icons/obj/structures/doors/secdoor_glass.dmi'
	dir = EAST
	glass = TRUE
	opacity = FALSE
	req_one_access = list(ACCESS_MARINE_COMMAND, ACCESS_MARINE_LEADER)
	var/squad_name = SQUAD_MARINE_3

/obj/structure/machinery/door/airlock/uscm_ground/platoon_sarge_office/two
	squad_name = SQUAD_MARINE_4

/obj/structure/machinery/door/airlock/uscm_ground/platoon_sarge_office/Initialize()
	. = ..()
	name = "[name] - [uppertext(squad_name)]"
	desc = "[desc] [uppertext(squad_name)] section."

/obj/structure/machinery/door/airlock/uscm_ground/command
	icon = 'icons/obj/structures/doors/secdoor.dmi'
	req_access = list(ACCESS_MARINE_COMMAND)

/obj/structure/machinery/door/airlock/uscm_ground/command/cic
	req_access = null
	req_one_access = list(ACCESS_MARINE_COMMAND, ACCESS_MARINE_LEADER)

/obj/structure/machinery/door/airlock/uscm_ground/command/cic/glass
	icon = 'icons/obj/structures/doors/secdoor_glass.dmi'
	dir = EAST
	glass = TRUE
	opacity = FALSE

/obj/structure/machinery/door/airlock/uscm_ground/command/commander_office
	icon = 'icons/obj/structures/doors/comdoor.dmi'
	dir = EAST
	req_access = list(ACCESS_MARINE_CO)

/obj/structure/machinery/door/airlock/uscm_ground/command/commander_quarters
	icon = 'icons/obj/structures/doors/personaldoor.dmi'
	req_access = list(ACCESS_MARINE_CO)

/obj/structure/machinery/door/airlock/uscm_ground/command/lieutenant_office
	icon = 'icons/obj/structures/doors/comdoor.dmi'
	dir = EAST
	req_access = list(ACCESS_MARINE_COMMAND)

/obj/structure/machinery/door/airlock/uscm_ground/command/lieutenant_office
	icon = 'icons/obj/structures/doors/comdoor.dmi'
	dir = EAST
	req_access = list(ACCESS_MARINE_COMMAND)

/obj/structure/machinery/door/airlock/uscm_ground/civilian
	icon = 'icons/obj/structures/doors/personaldoor.dmi'
	dir = EAST
	req_access = list(ACCESS_CIVILIAN_PUBLIC)

/obj/structure/machinery/door/airlock/uscm_ground/warehouse
	icon = 'icons/obj/structures/doors/engidoor_glass.dmi'
	glass = TRUE
	opacity = FALSE
	req_access = list(ACCESS_MARINE_CARGO)

//==========================================

//UNDERGROUND BUNKER PARENT

/obj/structure/machinery/door/airlock/bunker
	dir = NORTH
	openspeed = 4

