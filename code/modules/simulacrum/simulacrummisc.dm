/atom/movable/screen/text/screen_text/simulacrum_message
	maptext_height = 64
	maptext_width = 480
	maptext_x = 0
	maptext_y = 0
	screen_loc = "LEFT,TOP-3"

	letters_per_update = 1
	fade_out_delay = 4.5 SECONDS
	style_open = "<span class='langchat' style=font-size:16pt;valign='top';padding-left:40px>"
	style_close = "</span>"

/atom/movable/screen/text/screen_text/simulacrum_message/body
	maptext_height = 128
	screen_loc = "LEFT,TOP-4.5"
	style_open = "<span class='langchat' style=font-size:16pt;valign='top';padding-left:40px>"

/atom/movable/screen/text/screen_text/simulacrum_message/body/secondary
	screen_loc = "LEFT,TOP-5"

/atom/movable/screen/text/screen_text/simulacrum_message/body/fatelist
	maptext_height = 256
	screen_loc = "LEFT,TOP-12"


/atom/movable/screen/text/screen_text/simulacrum_message/play_to_client()
	player?.add_to_screen(src)
	if(fade_in_time)
		animate(src, alpha = 255)
	var/list/lines_to_skip = list()
	var/static/html_locate_regex = regex("<.*>")
	var/tag_position = findtext(text_to_play, html_locate_regex)
	var/reading_tag = TRUE
	while(tag_position)
		if(reading_tag)
			if(text_to_play[tag_position] == ">")
				reading_tag = FALSE
			lines_to_skip += tag_position
			tag_position++
		else
			tag_position = findtext(text_to_play, html_locate_regex, tag_position)
			reading_tag = TRUE

	for(var/letter = 2 to length(text_to_play) + letters_per_update step letters_per_update)
		if(letter in lines_to_skip)
			continue
		maptext = "[style_open][copytext_char(text_to_play, 1, letter)][style_close]"
		sleep(play_delay)

/atom/movable/screen/text/screen_text/simulacrum_message/after_play()
	if(!fade_out_time)
		end_play()
		return

	animate(src, alpha = 0, time = fade_out_time)
	addtimer(CALLBACK(src, PROC_REF(end_play)), fade_out_time)

/atom/movable/screen/text/screen_text/simulacrum_message/end_play()
	if(!player)
		qdel(src)
		return

	player.remove_from_screen(src)
	LAZYREMOVE(player.screen_texts, src)
	qdel(src)

	if(QDELETED(player))
		QDEL_NULL_LIST(player.screen_texts)
		return
