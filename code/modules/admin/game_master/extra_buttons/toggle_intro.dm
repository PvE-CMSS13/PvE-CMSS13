/client/proc/toggle_intro()
	set name = "Toggle Intro Blurb"
	set category = "Game Master.Flags"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	if(!SSticker.mode)
		to_chat(usr, SPAN_WARNING("A mode hasn't been selected yet!"))
		return

	SSticker.mode.toggleable_flags ^= MODE_DISABLE_INTRO_BLURB
	message_admins("[src] has [MODE_HAS_TOGGLEABLE_FLAG(MODE_DISABLE_INTRO_BLURB) ? "turned off" : "turned on"] intro blurb.")

/client/proc/toggle_slot_preferences()
	set name = "Toggle Slot Preferences"
	set category = "Game Master.Flags"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	GLOB.toggle_slot_preferences = !GLOB.toggle_slot_preferences
	message_admins("[src] has [GLOB.toggle_slot_preferences ? "enabled" : "disabled"] slot preferences.")
