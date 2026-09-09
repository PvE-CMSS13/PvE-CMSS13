/client/proc/gm_lighting()
	set name = "Change Daytime"
	set category = "Game Master.Extras"

	if(!check_rights(R_ADMIN))
		return

	var/list/lightturfs
	var/light_str = tgui_input_number(usr, "Set the light power.", "Daytime Brightness", 0.3, timeout=10 MINUTES, integer_only=FALSE)
	var/daytime_color = input(usr, "Please select the color to use.", "Daytime Color") as color|null
	var/z_to_affect = tgui_input_number(usr, "What Z to affect? (3 is usually ship)", "Daytime Brightness", 2, world.maxz, 1, 10 MINUTES, integer_only=TRUE)
	var/is_shipmap = is_mainship_level(z_to_affect)
	var/confirmation_msg = is_shipmap ? "Are you sure you wish to change daytime on the shipmap to this settings? This should probably only be used on shipmaps that are ostensibly ground maps." : "Are you sure you wish to change daytime on the map to this settings?"
	var/confirm = tgui_alert(usr, confirmation_msg, "Confirm", list("Yes", "No"), 10 MINUTES)
	if(confirm != "Yes" || !z_to_affect)
		return

	message_admins("[key_name(usr)] started operation to change lighting on map z [z_to_affect] to [daytime_color] color with [light_str].")
	lightturfs = block(locate(world.maxx, world.maxy, z_to_affect), locate(1, 1, z_to_affect))
	for(var/turf/current_turf as anything in lightturfs)
		var/area/current_area = current_turf.loc
		if(!current_area.daytime_affected)
			continue
		current_turf.set_light(1, light_str, l_color=daytime_color)
		CHECK_TICK
	message_admins("Operation to change lighting on map z [z_to_affect] is complete!")

/client/proc/gm_base_lighting()
	set name = "Change Daytime Base Lighting"
	set category = "Game Master.Extras"

	if(!check_rights(R_ADMIN))
		return

	var/light_alpha = tgui_input_number(usr, "Set the light alpha.", "Daytime Brightness", 85, 255, 0, timeout=10 MINUTES, integer_only=FALSE)
	var/daytime_color = input(usr, "Please select the color to use.", "Daytime Color") as color|null
	var/z_to_affect = tgui_input_number(usr, "What Z to affect? (3 is usually ship)", "Daytime Brightness", 2, world.maxz, 1, 10 MINUTES, integer_only=TRUE)
	var/is_shipmap = is_mainship_level(z_to_affect)
	var/confirmation_msg = is_shipmap ? "Are you sure you wish to change daytime on the shipmap to this settings? This should probably only be used on shipmaps that are ostensibly ground maps." : "Are you sure you wish to change daytime on the map to this settings?"
	var/confirm = tgui_alert(usr, confirmation_msg, "Confirm", list("Yes", "No"), 10 MINUTES)
	if(confirm != "Yes" || !z_to_affect)
		return

	message_admins("[key_name(usr)] started operation to change base lighting on map z [z_to_affect] to [daytime_color] color with [light_alpha] alpha.")
	for(var/area/current_area as anything in GLOB.all_areas)
		if(!current_area.daytime_affected)
			continue
		if(initial(current_area.base_lighting_alpha)) // Skip areas that already are defined with base lighting
			continue
		message_admins(current_area.z)
		if(current_area.z != z_to_affect) // This is kinda undocumented behavior and an area could technically span multiple Zs I think
			continue
		current_area.base_lighting_alpha = light_alpha
		current_area.base_lighting_color = daytime_color
		current_area.update_base_lighting()
		CHECK_TICK
	message_admins("Operation to change base lighting on map z [z_to_affect] is complete!")
