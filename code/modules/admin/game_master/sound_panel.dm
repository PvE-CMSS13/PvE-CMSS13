/client/proc/open_sound_panel()
	set name = "Sound Panel"
	set category = "Admin.Panels"

	if(!check_rights(R_SOUNDS))
		return

	new /datum/sound_panel(usr)

/datum/sound_panel
	var/static/list/sound_list
	var/static/list/category_list
	var/static/list/category_lookup
	var/static/list/zlevel_list
	var/static/list/zlevel_lookup
	var/static/list/group_list
	var/client/holder
	var/sound_path = ""
	var/sound_category
	var/sound_volume = 50
	var/sound_pitch = 1
	var/sound_duration = 1
	var/mob/target_player
	var/turf/target_loc
	var/loc_click_intercept = FALSE
	var/loc_click_play = FALSE
	var/target_zlevel
	var/target_group

/datum/sound_panel/New(user)
	if(isnull(sound_list)) //first run, init statics
		sound_list = get_sounds()

		category_list = list("Sound FX", "Ambience", "Admin")
		category_lookup = list("Sound FX" = VOLUME_SFX, "Ambience" = VOLUME_AMB, "Admin" = VOLUME_ADM)

		zlevel_list = list()
		zlevel_lookup = list()
		for(var/datum/space_level/level as anything in SSmapping.z_list)
			zlevel_list += level.name
			zlevel_lookup[level.name] = level.z_value

		group_list = list("Global", "Humans", "Xenos", "Ghosts")

	sound_category = category_list[1]
	target_zlevel = zlevel_list[1]
	target_group = group_list[1]

	if(isclient(user))
		holder = user
	else
		var/mob/mob = user
		holder = mob.client

	tgui_interact(holder.mob)

/datum/sound_panel/proc/get_sounds()
	var/static/list/extensions = list("mid", "midi", "mod", "it", "s3m", "xm", "oxm", "wav", "ogg", "mp3", "raw", "wma", "aiff")
	var/static/regex/ext_rgx = new("\\.(?:[jointext(extensions, "|")])$", "i")

	var/list/dirs = list("sound/")
	var/list/file_paths = list()
	for(var/i = 1, i <= length(dirs), i++)
		var/path = dirs[i]

		var/list/filenames = flist(path)
		for(var/filename as anything in filenames)
			if(findtext(filename, "/", -1)) //found directory, add to search
				dirs += "[path][filename]"
				continue
			if(!findtext(filename, ext_rgx)) //extension check
				continue
			file_paths += "[path][filename]"

	return file_paths

/datum/sound_panel/ui_static_data(mob/user)
	var/list/data = list()

	data["sound_list"] = sound_list
	data["category_list"] = category_list
	data["zlevel_list"] = zlevel_list
	data["group_list"] = group_list

	return data

/datum/sound_panel/ui_data(mob/user)
	var/list/data = list()

	data["sound_path"] = sound_path
	data["sound_category"] = sound_category
	data["sound_volume"] = sound_volume
	data["sound_pitch"] = sound_pitch
	data["sound_duration"] = sound_duration
	data["target_player_desc"] = target_player?.name
	data["target_loc_desc"] = target_loc ? "[target_loc.name]: [target_loc.x],[target_loc.y],[target_loc.z]" : null
	data["loc_click_intercept"] = loc_click_intercept
	data["loc_click_play"] = loc_click_play
	data["target_zlevel"] = target_zlevel
	data["target_group"] = target_group

	return data

/datum/sound_panel/ui_close(mob/user)
	holder = null
	target_loc = null
	target_player = null
	LAZYREMOVE(user.client.click_intercepts, src)
	qdel(src)

/datum/sound_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/sound_panel/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE

/datum/sound_panel/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SoundPanel", "Sound Panel")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/sound_panel/proc/InterceptClickOn(mob/user, params, atom/object)
	if(loc_click_intercept)
		var/turf/chosen_loc = get_turf(object)
		if(QDELETED(chosen_loc))
			return

		target_loc = chosen_loc
		SStgui.update_uis(src)

		if(loc_click_play)
			if(!sound_path)
				return

			var/sound/sound_datum = sound(sound_path)
			sound_datum.frequency = 1 / sound_duration
			sound_datum.pitch = sound_pitch * sound_duration

			playsound(target_loc, sound_datum, sound_volume, vol_cat = category_lookup[sound_category])

		return TRUE

/datum/sound_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!check_rights(R_SOUNDS))
		return

	switch(action)
		if("set_sound_path")
			var/sound = params["sound_path"]
			if(!(sound in sound_list))
				return
			sound_path = sound
			return TRUE
		if("set_sound_category")
			var/category = params["sound_category"]
			if(isnull(category_lookup[category]))
				return
			sound_category = category
			return TRUE
		if("set_sound_volume")
			sound_volume = clamp(params["sound_volume"], 0, 100)
			return TRUE
		if("set_sound_pitch")
			sound_pitch = clamp(params["sound_pitch"], 0.5, 2)
			return TRUE
		if("set_sound_duration")
			sound_duration = clamp(params["sound_duration"], 0.5, 2)
			return TRUE
		if("set_target_zlevel")
			var/target_z = params["target_zlevel"]
			if(isnull(zlevel_lookup[target_z]))
				return
			target_zlevel = target_z
			return TRUE
		if("set_target_group")
			var/group = params["target_group"]
			if(!(group in group_list))
				return
			target_group = group
			return TRUE
		if("play_preview")
			if(!sound_path)
				return

			var/sound/sound_datum = sound(sound_path)
			sound_datum.frequency = 1 / sound_duration
			sound_datum.pitch = sound_pitch * sound_duration

			playsound_client(holder, sound_datum, vol = sound_volume, vol_cat = category_lookup[sound_category], channel = SOUND_CHANNEL_TEST)
			return TRUE
		if("stop_preview")
			var/sound/sound_datum = sound()
			sound_datum.channel = SOUND_CHANNEL_TEST
			sound_datum.status = SOUND_MUTE|SOUND_UPDATE
			sound_to(holder, sound_datum)
			return TRUE
		if("select_client")
			var/mob/chosen_player = tgui_input_list(holder.mob, "Who should hear the sound?", "Player Select", GLOB.player_list)
			if(QDELETED(chosen_player))
				return

			target_player = chosen_player
			return TRUE
		if("play_client")
			if(!sound_path)
				return
			if(QDELETED(target_player))
				return

			var/sound/sound_datum = sound(sound_path)
			sound_datum.frequency = 1 / sound_duration
			sound_datum.pitch = sound_pitch * sound_duration

			playsound_client(target_player.client, sound_datum, vol = sound_volume, vol_cat = category_lookup[sound_category])
			return TRUE
		if("toggle_loc_click_intercept")
			loc_click_intercept = !loc_click_intercept

			if(loc_click_intercept)
				LAZYOR(ui.user.client.click_intercepts, src)
			else
				LAZYREMOVE(ui.user.client.click_intercepts, src)

			return TRUE
		if("toggle_loc_click_play")
			loc_click_play = !loc_click_play
			return TRUE
		if("play_local")
			if(!sound_path)
				return
			if(QDELETED(target_loc))
				return

			var/sound/sound_datum = sound(sound_path)
			sound_datum.frequency = 1 / sound_duration
			sound_datum.pitch = sound_pitch * sound_duration

			playsound(target_loc, sound_datum, sound_volume, vol_cat = category_lookup[sound_category])
			return TRUE
		if("play_zlevel")
			if(!sound_path)
				return

			var/sound/sound_datum = sound(sound_path)
			sound_datum.frequency = 1 / sound_duration
			sound_datum.pitch = sound_pitch * sound_duration

			playsound_z(list(zlevel_lookup[target_zlevel]), sound_datum, sound_volume, vol_cat = category_lookup[sound_category])
			return TRUE
		if("play_group")
			if(!sound_path)
				return

			var/sound/sound_datum = sound(sound_path)
			sound_datum.frequency = 1 / sound_duration
			sound_datum.pitch = sound_pitch * sound_duration

			var/list/targets = list()
			switch(target_group)
				if("Global")
					targets = GLOB.mob_list
				if("Humans")
					targets = GLOB.human_mob_list + GLOB.dead_mob_list
				if("Xenos")
					targets = GLOB.xeno_mob_list + GLOB.dead_mob_list
				if("Ghosts")
					targets = GLOB.observer_list + GLOB.dead_mob_list

			for(var/mob/target as anything in targets)
				playsound_client(target.client, sound_datum, vol = sound_volume, vol_cat = category_lookup[sound_category])
			return TRUE
