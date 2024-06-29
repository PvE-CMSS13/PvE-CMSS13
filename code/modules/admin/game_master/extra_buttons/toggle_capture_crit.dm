GLOBAL_VAR(ai_capture_crit)

/// As long as this toggled - xenos will try and steal crit marines to nearest hive
/client/proc/toggle_xeno_kidnapping()
	set name = "Toggle Xeno Kidnapping"
	set category = "Game Master.Flags"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	if(!GLOB.ai_capture_crit && !length(GLOB.ai_hives))
		to_chat(src, SPAN_NOTICE("Xeno kidnapping requires at least one valid hive placed to be enabled."))
		return

	GLOB.ai_capture_crit = !GLOB.ai_capture_crit
	message_admins("[key_name(src)] has [GLOB.ai_capture_crit ? "enabled" : "disabled"] AI kidnapping feature.")
