/datum/buildmode_mode/atmos_edit
	key = "atmosedit"
	help = "Left Mouse Button on area = Select area to edit when you RMB on buildmode button\n\
	Right Mouse Button on buildmode button = Edit selected area atmospherics"
	var/area/storedarea
	var/image/areaimage

/datum/buildmode_mode/atmos_edit/New()
	areaimage = image('icons/turf/overlays.dmi', null, "blueOverlay")
	..()

/datum/buildmode_mode/atmos_edit/enter_mode(datum/buildmode/BM)
	BM.holder.images += areaimage

/datum/buildmode_mode/atmos_edit/exit_mode(datum/buildmode/BM)
	areaimage.loc = null // de-color the area
	BM.holder.images -= areaimage
	return ..()

/datum/buildmode_mode/atmos_edit/Destroy()
	QDEL_NULL(areaimage)
	storedarea = null
	return ..()

/datum/buildmode_mode/atmos_edit/change_settings(client/c)
	if(!storedarea)
		to_chat(c, SPAN_WARNING("Select the area you want to edit with right click first!"))
		return
	var/target_path = input(c, "Area path to change atmos of:\n Tip: You can mass modify all the areas on a map by using the parent type. \n For example, /area/almayer instead of /area/almayer/living/bridgebunks or /area/canyon32B/exterior instead of /area/canyon32B/exterior/south/bar", "Typepath", "[storedarea.type]")
	var/areatype = text2path(target_path)
	if(ispath(areatype,/area))
		storedarea = areatype
		areaimage.loc = storedarea
		update_info_text()
		var/new_pressure = input(c, "New Pressure:", "Area Pressure(currently [storedarea.pressure])", storedarea.pressure)
		if(!new_pressure)
			return
		var/new_temp = input(c, "New Temperature(3 for space):", "Area Temperature(currently [storedarea.temperature])", storedarea.temperature)
		if(!new_temp)
			return
		var/new_gas = tgui_input_list(c, "New Gas Type:", "Area Gas(currently [storedarea.gas_type])", AVAILABLE_GASES)
		if(!new_gas)
			return
		to_chat(c, SPAN_NOTICE("[areatype]: [storedarea.pressure]kPa to [new_pressure]kPa. [storedarea.temperature]K to [new_pressure]K, [storedarea.gas_type] to [new_gas] "))
		try
			storedarea.pressure = new_pressure
			storedarea.temperature = new_temp
			storedarea.gas_type = new_gas
		catch()
			var/list/items = get_all_of_type(storedarea.type, TRUE)
			to_chat(c, "Changing [length(items)] areas...", confidential = TRUE)
			var/accepted
			var/rejected
			for(var/area/thing in items)
				areaimage.loc = thing
				if (!thing)
					continue
				var/datum/D = thing
				if (D.vv_edit_var("pressure", new_pressure) != FALSE)
					accepted++
				else
					rejected++
				if (D.vv_edit_var("temperature", new_temp) != FALSE)
					accepted++
				else
					rejected++
				if (D.vv_edit_var("gas_type", new_gas) != FALSE)
					accepted++
				else
					rejected++
				if (rejected)
					to_chat(src, "[rejected] out of [rejected+accepted] areas rejected your edit", confidential = TRUE)
				CHECK_TICK
			to_chat(c, "Completed.", confidential = TRUE)
			update_info_text()

/datum/buildmode_mode/atmos_edit/proc/update_info_text()
	areaimage.loc = storedarea // color our area
	var/atom/movable/info = BM.buttons[1]
	info.maptext_y = -48
	info.maptext_x = 48
	info.maptext_height = 32
	info.maptext_width = 300
	info.maptext = "[storedarea] \n [storedarea.type] \n[storedarea.pressure]kPa [storedarea.temperature]K [storedarea.gas_type]"

/datum/buildmode_mode/atmos_edit/when_clicked(client/c, params, object)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, LEFT_CLICK))
		var/turf/T = get_turf(object)
		storedarea = get_area(T)
		update_info_text()
