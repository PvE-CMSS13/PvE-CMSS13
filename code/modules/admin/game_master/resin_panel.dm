#define RESIN_PANEL_CONSTRUCTIONS \
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
	/datum/resin_construction/resin_obj/acid_pillar \
)

/client/proc/open_resin_panel()
	set name = "Resin Panel"
	set category = "Game Master"

	if(!check_rights(R_ADMIN))
		return

	new /datum/resin_panel(usr)

/datum/resin_panel
	var/static/list/constructions_list
	var/selected_hive = XENO_HIVE_NORMAL
	var/selected_resin
	var/client/holder
	var/build_click_intercept = FALSE

/datum/resin_panel/New(user)
	if(isnull(constructions_list)) //first run, init statics
		constructions_list = get_constructions()

	if(isclient(user))
		holder = user
	else
		var/mob/mob = user
		holder = mob.client

	holder.click_intercept = src
	tgui_interact(holder.mob)

/datum/resin_panel/proc/get_constructions()
	var/list/constructions = list()
	for(var/datum/resin_construction/RC as anything in RESIN_PANEL_CONSTRUCTIONS)
		var/list/entry = list()

		entry["name"] = RC.name
		entry["desc"] = RC.desc
		entry["image"] = replacetext(RC.construction_name, " ", "-")
		entry["plasma_cost"] = RC.cost
		entry["max_per_xeno"] = RC.max_per_xeno
		entry["id"] = "[RC]"

		constructions += list(entry)

	return constructions

/datum/resin_panel/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/choose_resin),
	)

/datum/resin_panel/ui_static_data(mob/user)
	var/list/data = list()

	data["constructions_list"] = constructions_list
	data["hives_list"] = ALL_XENO_HIVES

	return data

/datum/resin_panel/ui_data(mob/user)
	var/list/data = list()

	data["selected_resin"] = selected_resin
	data["selected_hive"] = selected_hive
	data["build_click_intercept"] = build_click_intercept

	return data

/datum/resin_panel/ui_close(mob/user)
	holder = null
	build_click_intercept = FALSE
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

	var/turf/current_turf = get_turf(object)

	/*
	if(SSinterior.in_interior(current_turf))
		to_chat(user, SPAN_XENOWARNING("It's too tight in here to build."))
		return
	*/

	var/datum/resin_construction/construction = GLOB.resin_constructions_list[selected_resin]

	/*
	if(!construction.can_build_here(current_turf, user))
		return
	*/

	/*
	var/obj/effect/alien/weeds/alien_weeds = current_turf.weeds
	if(!alien_weeds || alien_weeds.secreting)
		return
	*/

	var/atom/new_resin = construction.build(current_turf, selected_hive)
	new_resin.add_hiddenprint(user) //so admins know who placed it

	return TRUE

/datum/resin_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!check_rights(R_ADMIN))
		return

	switch(action)
		if("set_selected_resin")
			var/selected_type = text2path(params["type"])
			if(!(selected_type in RESIN_PANEL_CONSTRUCTIONS))
				return
			selected_resin = selected_type
			return TRUE
		if("set_selected_hive")
			var/hive = params["selected_hive"]
			if(!(hive in ALL_XENO_HIVES))
				return
			selected_hive = hive
			return TRUE
		if("toggle_build_click_intercept")
			build_click_intercept = !build_click_intercept
			return TRUE

#undef RESIN_PANEL_CONSTRUCTIONS
