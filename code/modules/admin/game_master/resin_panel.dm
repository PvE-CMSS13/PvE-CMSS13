#define RESIN_PANEL_STRUCTURES \
list( \
	/datum/resin_construction/resin_turf/wall, \
	/datum/resin_construction/resin_turf/wall/thick, \
	/datum/resin_construction/resin_turf/wall/reflective, \
	/datum/resin_construction/resin_turf/membrane, \
	/datum/resin_construction/resin_turf/membrane/thick, \
	/datum/resin_construction/resin_obj/door, \
	/datum/resin_construction/resin_obj/door/thick, \
	/datum/resin_construction/resin_obj/resin_node, \
	/datum/resin_construction/resin_obj/sticky_resin, \
	/datum/resin_construction/resin_obj/fast_resin, \
	/datum/resin_construction/resin_obj/resin_spike, \
	/datum/resin_construction/resin_obj/acid_pillar, \
	/turf/closed/wall/mineral/bone_resin \
)

/client/proc/open_resin_panel()
	set name = "Resin Panel"
	set category = "Game Master"

	if(!check_rights(R_ADMIN))
		return

	new /datum/resin_panel(usr)

/datum/resin_panel
	var/static/list/structure_list
	var/static/list/removal_allowlist
	var/selected_structure
	var/selected_hive = XENO_HIVE_NORMAL
	var/client/holder
	var/build_click_intercept = FALSE

/datum/resin_panel/New(user)
	if(isnull(structure_list)) //first run, init statics
		structure_list = get_structures()

		removal_allowlist = list()
		for(var/structure as anything in RESIN_PANEL_STRUCTURES)
			if(structure in GLOB.resin_constructions_list)
				var/datum/resin_construction/construct = structure
				removal_allowlist += construct.build_path
			else
				removal_allowlist += structure

	if(isclient(user))
		holder = user
	else
		var/mob/mob = user
		holder = mob.client

	tgui_interact(holder.mob)

/datum/resin_panel/proc/get_structures()
	var/list/structures = list()
	for(var/structure as anything in RESIN_PANEL_STRUCTURES)
		var/list/entry = list()

		if(structure in GLOB.resin_constructions_list)
			var/datum/resin_construction/construct = structure
			entry["name"] = construct.name
			entry["image"] = replacetext(construct.construction_name, " ", "-")
			entry["id"] = "[construct]"
		else if(structure in typesof(/turf))
			var/turf/turf = structure
			entry["name"] = turf.name
			switch(turf)
				if(/turf/closed/wall/mineral/bone_resin)
					entry["image"] = "reflective-resin-wall" //looks just like it, saves on making new spritesheet for one image
				else
					entry["image"] = turf.icon_state
			entry["id"] = "[turf]"

		structures += list(entry)

	return structures

/datum/resin_panel/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/choose_resin),
	)

/datum/resin_panel/ui_static_data(mob/user)
	var/list/data = list()

	data["structure_list"] = structure_list
	data["hives_list"] = ALL_XENO_HIVES

	return data

/datum/resin_panel/ui_data(mob/user)
	var/list/data = list()

	data["selected_structure"] = selected_structure
	data["selected_hive"] = selected_hive
	data["build_click_intercept"] = build_click_intercept

	return data

/datum/resin_panel/ui_close(mob/user)
	holder = null
	LAZYREMOVE(user.client.click_intercepts, src)
	qdel(src)

/datum/resin_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/resin_panel/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE

/datum/resin_panel/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ResinPanel", "Resin Panel")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/resin_panel/proc/InterceptClickOn(mob/user, params, atom/object)
	if(!build_click_intercept)
		return

	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, MIDDLE_CLICK)) //remove
		if(!(object.type in removal_allowlist))
			return

		if(isturf(object))
			var/turf/turf = object
			turf.ScrapeAway()
		else
			qdel(object)
	else //add
		if(!selected_structure)
			return

		var/turf/current_turf = get_turf(object)

		var/atom/new_structure
		if(selected_structure in GLOB.resin_constructions_list)
			var/datum/resin_construction/construct = GLOB.resin_constructions_list[selected_structure]
			new_structure = construct.build(current_turf, selected_hive)
		else if(selected_structure in typesof(/turf))
			var/turf/turf = selected_structure
			new_structure = current_turf.PlaceOnTop(turf)
		new_structure?.add_hiddenprint(user) //so admins know who placed it

	return TRUE

/datum/resin_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!check_rights(R_ADMIN))
		return

	switch(action)
		if("set_selected_structure")
			var/selected_type = text2path(params["type"])
			if(!(selected_type in RESIN_PANEL_STRUCTURES))
				return
			selected_structure = selected_type
			return TRUE
		if("set_selected_hive")
			var/hive = params["selected_hive"]
			if(!(hive in ALL_XENO_HIVES))
				return
			selected_hive = hive
			return TRUE
		if("toggle_build_click_intercept")
			build_click_intercept = !build_click_intercept
			if(build_click_intercept)
				LAZYOR(ui.user.client.click_intercepts, src)
			else
				LAZYREMOVE(ui.user.client.click_intercepts, src)
			return TRUE

#undef RESIN_PANEL_STRUCTURES
