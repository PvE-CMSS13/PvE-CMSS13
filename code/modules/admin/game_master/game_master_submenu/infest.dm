#define DEFAULT_SPAWN_HIVE_STRING XENO_HIVE_NORMAL

/datum/game_master_submenu/infest
	tgui_menu_name = "GameMasterSubmenuInfest"
	tgui_menu_title = "Infest Control"

	/// Current selected hive for the embryo
	var/selected_hive = DEFAULT_SPAWN_HIVE_STRING

	/// Target growth stage for the embryo
	var/embryo_stage = 0

/datum/game_master_submenu/infest/ui_data(mob/user)
	. = ..()

	var/list/data = list()

	data["selected_hive"] = selected_hive
	data["embryo_stage"] = embryo_stage

	return data

/datum/game_master_submenu/infest/ui_static_data(mob/user)
	. = ..()

	var/list/data = list()

	data["selectable_hives"] = ALL_XENO_HIVES

	return data

/datum/game_master_submenu/infest/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)
		if("set_selected_hive")
			selected_hive = params["new_hive"]
			return TRUE

		if("set_embryo_stage")
			embryo_stage = params["stage"]
			return TRUE

		if("infest")
			setup_embryo()
			return TRUE

		if("clear_infest")
			remove_embryo()
			return TRUE

		if("burst")
			force_burst()
			return TRUE

/datum/game_master_submenu/infest/proc/setup_embryo()
	var/obj/item/alien_embryo/bodyburster/infesting_embryo
	for(var/obj/item/alien_embryo/bodyburster/embryo in referenced_atom) //if this hive's embryo already exists, convert to larva and use it
		if(embryo.hivenumber == selected_hive)
			infesting_embryo = embryo
		else
			qdel(embryo)

	if(!infesting_embryo) //else, make a new one
		infesting_embryo = new /obj/item/alien_embryo/bodyburster(referenced_atom)
		infesting_embryo.hivenumber = selected_hive

		var/mob/living/carbon/human/infested_host = referenced_atom
		infested_host.species?.larva_impregnated(infesting_embryo) //Yautja handling

	infesting_embryo.stage = embryo_stage

/datum/game_master_submenu/infest/proc/remove_embryo()
	for(var/obj/item/alien_embryo/bodyburster/embryo in referenced_atom)
		qdel(embryo)

/datum/game_master_submenu/infest/proc/force_burst()
	var/mob/living/carbon/xenomorph/bodyburster/infesting_larva = locate() in referenced_atom //if a larva already exists, use it
	if(infesting_larva)
		infesting_larva.chest_burst(referenced_atom)
		return

	for(var/obj/item/alien_embryo/bodyburster/embryo in referenced_atom) //else if this hive's embryo already exists, convert to larva and use it
		if(embryo.hivenumber == selected_hive)
			embryo.become_larva()
			infesting_larva = locate() in referenced_atom
			break
	if(infesting_larva)
		infesting_larva.chest_burst(referenced_atom)
		return

	infesting_larva = new /mob/living/carbon/xenomorph/bodyburster(referenced_atom, null, selected_hive) //else, make a new larva
	var/mob/living/carbon/human/infested_host = referenced_atom
	infesting_larva.ckey = infested_host.ckey
	infesting_larva.chest_burst(referenced_atom)

#undef DEFAULT_SPAWN_HIVE_STRING
