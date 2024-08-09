/client/proc/admin_marine_announcement()
	set name = "Marine Announcement"
	set category = "Game Master.Extras"

	if(!check_rights(R_ADMIN))
		return

	var/input = tgui_input_text(src, "Enter the text for the announcement.", title = "Make Marine Announcement", multiline = TRUE, encode = FALSE)
	if(!input)
		return
	else
		marine_announcement(input, "[COMMAND_ANNOUNCE]")
		message_admins("[key_name_admin(src)] has made an admin command announcement.")
		log_admin("[key_name_admin(src)] made an admin command announcement: [input]")
