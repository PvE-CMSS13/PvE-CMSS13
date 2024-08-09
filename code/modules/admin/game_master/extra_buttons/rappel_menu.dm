GLOBAL_LIST_EMPTY(game_master_rappels)
GLOBAL_DATUM_INIT(rappel_panel, /datum/rappel_menu, new)
#define RAPPEL_CLICK_INTERCEPT_ACTION "rappel_click_intercept_action"

/client/proc/toggle_rappel_menu()
	set name = "Rappel Menu"
	set category = "Game Master.Extras"
	if(!check_rights(R_ADMIN))
		return

	GLOB.rappel_panel.tgui_interact(mob)

/datum/rappel_menu
	var/rappel_click_intercept = FALSE

/datum/rappel_menu/ui_data(mob/user)
	. = ..()

	var/list/data = list()

	data["game_master_rappels"] = length(GLOB.game_master_rappels) ? GLOB.game_master_rappels : ""
	data["rappel_click_intercept"] = rappel_click_intercept
	return data

/datum/rappel_menu/proc/InterceptClickOn(mob/user, params, atom/object)
	var/list/modifiers = params2list(params)
	if(rappel_click_intercept)
		var/turf/object_turf = get_turf(object)
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			for(var/obj/effect/landmark/rappel/R in object_turf)
				GLOB.game_master_rappels -= R
				QDEL_NULL(R)
			return TRUE

		var/obj/effect/landmark/rappel/rappel = new(object_turf)
		var/rappel_ref = REF(rappel)
		GLOB.game_master_rappels += list(list(
			"rappel" = rappel,
			"rappel_name" = rappel.name,
			"rappel_ref" = rappel_ref,
			))
		return TRUE

/datum/rappel_menu/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "GameMasterRappelMenu", "Rappel Menu")
		ui.open()
/datum/rappel_menu/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE


/datum/rappel_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	switch(action)
		if("remove_rappel")
			if(!params["val"])
				return

			var/list/rappel = params["val"]

			var/atom/rappel_atom = locate(rappel["rappel_ref"])

			if(!rappel_atom)
				return TRUE

			if(tgui_alert(ui.user, "Do you want to remove [rappel_atom] ?", "Confirmation", list("Yes", "No")) != "Yes")
				return TRUE

			remove_rappel(rappel_atom)

		if("jump_to_rappel")
			if(!params["val"])
				return

			var/list/rappel = params["val"]

			var/atom/rappel_atom = locate(rappel["rappel_ref"])

			var/turf/rappel_turf = get_turf(rappel_atom)

			if(!rappel_turf)
				return TRUE

			var/client/jumping_client = ui.user.client
			jumping_client.jump_to_turf(rappel_turf)
			return TRUE

		if("toggle_click_rappel")
			rappel_click_intercept = !rappel_click_intercept

			if(rappel_click_intercept)
				LAZYOR(ui.user.client.click_intercepts, src)
			else
				LAZYREMOVE(ui.user.client.click_intercepts, src)

			return

/datum/rappel_menu/ui_close(mob/user)
	LAZYREMOVE(user.client.click_intercepts, src)

	rappel_click_intercept = FALSE

/datum/rappel_menu/proc/remove_rappel(obj/removing_datum)
	SIGNAL_HANDLER

	for(var/list/cycled_rappel in GLOB.game_master_rappels)
		if(cycled_rappel["rappel"] == removing_datum)
			GLOB.game_master_rappels.Remove(list(cycled_rappel))
			QDEL_NULL(removing_datum)
