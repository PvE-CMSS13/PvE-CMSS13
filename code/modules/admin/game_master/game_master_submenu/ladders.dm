
/// Created by /datum/game_master when middle clicking on a /obj/structure/ladder
/datum/game_master_submenu/ambush/ladders
	tgui_menu_title = "Ladder Control"

/datum/game_master_submenu/ambush/ladders/ready_ambush()
	var/obj/structure/ladder/referenced_ladder = referenced_atom
	if(!istype(referenced_ladder))
		log_debug("Ladder game master submenu has reference atom that is not a ladder. Referenced atom: [referenced_atom]")
		return

	referenced_ladder.unlock_hatch(referenced_ladder.id) //Will only fire if the state is correct.
	referenced_ladder.open_hatch(null) //Followup, to make sure it opens.

/datum/game_master_submenu/ambush/ladders/shake_spawner()
	var/obj/structure/ladder/referenced_ladder = referenced_atom
	if(!istype(referenced_ladder))
		log_debug("Ladder game master submenu has reference atom that is not a ladder. Referenced atom: [referenced_atom]")
		return

	referenced_ladder.animate_crawl()

	return CALLBACK(referenced_ladder, TYPE_PROC_REF(/obj/structure/ladder, animate_crawl_reset))
