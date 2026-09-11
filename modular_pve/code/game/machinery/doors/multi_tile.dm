//USCM GROUND OUTPOST

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground
	tiles_with = list(
		/obj/structure/window/framed/almayer, //Tiles with is here FOR SAFETY PURPOSES
		/obj/structure/machinery/door/airlock,
	)
	icon = 'icons/obj/structures/doors/2x1prepdoor.dmi'
	dir = EAST
	autoname = TRUE

//procs
/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/LateInitialize()
	. = ..()
	relativewall_neighbours()

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/take_damage(taken_damage, mob/damaging_mob)
	var/damage_check = max(0, damage + taken_damage)
	if(damage_check >= damage_cap && damaging_mob && is_mainship_level(z))
		SSclues.create_print(get_turf(damaging_mob), damaging_mob, "The fingerprint contains bits of wire and metal specks.")
	..()
//Procs end

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/general
	req_one_access = list(ACCESS_MARINE_PREP, ACCESS_CIVILIAN_PUBLIC)
	glass = TRUE
	opacity = FALSE

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/general/cafeteria
	icon = 'icons/obj/structures/doors/2x1generic.dmi'
	dir = NORTH
	glass = TRUE
	opacity = FALSE

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/armory
	icon = 'icons/obj/structures/doors/2x1almayerdoor.dmi'
	dir = NORTH
	req_access = list(ACCESS_MARINE_PREP)

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/armory/weapons
	name = "\improper Weapon Storage"
	autoname = FALSE

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/armory/prep
	name = "\improper Specialized Prep"
	autoname = FALSE
	req_access = null
	req_one_access = list(ACCESS_MARINE_SMARTPREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_TL_PREP, ACCESS_MARINE_ENGPREP, ACCESS_MARINE_PREP) //Don't need to be in here if you're not getting prepped.

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/medical
	icon = 'icons/obj/structures/doors/2x1medidoor.dmi'
	dir = NORTH
	req_access = list(ACCESS_MARINE_MEDBAY)
	glass = TRUE
	opacity = FALSE

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/warehouse
	dir = NORTH
	icon = 'icons/obj/structures/doors/2x1engidoor.dmi'
	req_access = list(ACCESS_MARINE_CARGO)

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/warehouse/glass
	icon = 'icons/obj/structures/doors/2x1engidoor_glass.dmi'
	glass = TRUE
	opacity = FALSE

/obj/structure/machinery/door/airlock/multi_tile/uscm_ground/civilian
	icon = 'icons/obj/structures/doors/2x1generic.dmi'
	glass = TRUE
	opacity = FALSE
	req_access = list(ACCESS_CIVILIAN_PUBLIC)
