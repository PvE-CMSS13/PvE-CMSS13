/client/proc/send_tip()
	set name = "Send Tip of the Round"
	set category = "Game Master.Extras"

	if(!check_rights(R_ADMIN))
		return

	var/body = tgui_input_text(src, "Enter the text.", title = "Tip of the Round", multiline = FALSE, encode = FALSE)
	if(!body)
		return
	to_chat(world, SPAN_PURPLE("<b>Tidbit of the round: </b>[html_encode(body)]"))
