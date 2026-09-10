/client/proc/gm_shipmap_lighting()
	set name = "Change Daytime (Shipmap)"
	set category = "Game Master.Extras"

	if(!check_rights(R_ADMIN))
		return
	var/list/lightturfs
	var/light_str = input(usr, "Set the light power.", "Shipmap Daytime Brightness", "0.3") as null|num
	var/daytime_color = input(usr, "Please select the color to use.", "Daytime Color") as color|null
	var/confirm = tgui_alert(usr, "Are you sure you wish to change daytime on the shipmap to this settings? This should only be used on shipmaps that are ostensibly ground maps.", "Confirm", list("Yes", "No"), 1 HOURS)
	var/z_level = 3
	if(confirm != "Yes")
		return FALSE
	message_admins("[key_name(usr)] changed lighting on shipmap to [daytime_color] color with [light_str].")
	lightturfs = block(locate(world.maxx, world.maxy, z_level), locate(1, 1, 3))
	for(var/atom/A as anything in lightturfs)
		if(istype(A.loc,/area/))
			var/area/targeted = A.loc
			if(!targeted.daytime_affected)
				lightturfs -= A
	for(var/turf/T as anything in lightturfs)
		T.set_light(1, light_str, l_color = daytime_color)
