
/// Created by /datum/game_master when middle clicking on a /obj/structure/pipes/vents
/datum/game_master_submenu/ambush/vents
	tgui_menu_title = "Vent Control"

	ambush_sounds = list('sound/effects/alien_ventcrawl1.ogg', 'sound/effects/alien_ventcrawl2.ogg')

/datum/game_master_submenu/ambush/vents/shake_spawner()
	var/obj/structure/pipes/vents/referenced_vent = referenced_atom
	if(!istype(referenced_vent))
		log_debug("Vent game master submenu has reference atom that is not a vent. Referenced atom: [referenced_atom]")
		return

	referenced_vent.animate_crawl()

	return CALLBACK(referenced_vent, TYPE_PROC_REF(/obj/structure/pipes/vents, animate_crawl_reset))
