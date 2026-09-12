/atom/movable/screen/text/screen_text/chapter_title
	maptext_height = 480
	maptext_width = 480
	maptext_x = 0
	maptext_y = 0
	screen_loc = "LEFT+0.5,BOTTOM+0.75"
	plane = ABOVE_HUD_PLANE
	layer = ABOVE_HUD_LAYER + 0.2

	///Time taken before fade in
	var/fade_in_delay = 2 SECONDS
	///Time taken to fade in as we start printing text
	fade_in_time = 2 SECONDS
	///Time before fade out after printing is finished
	fade_out_delay = 8 SECONDS
	///Time taken when fading out after fade_out_delay
	fade_out_time = 1 SECONDS
	///delay between playing each letter. in general use 1 for fluff and 0.5 for time sensitive messsages
	play_delay = 1
	///letters to update by per text to per play_delay
	letters_per_update = 1

/mob/proc/display_chapter_title(text, alert_type = /atom/movable/screen/text/screen_text, override_color = "#FFFFFF")
	var/atom/movable/screen/text/screen_text/text_box = isatom(alert_type) ? alert_type : new alert_type()
	text_box.text_to_play = text
	text_box.player = client
	if(override_color)
		text_box.color = override_color

	LAZYADD(client.screen_texts, text_box)
	if(LAZYLEN(client.screen_texts) == 1) //lets only play one at a time, for thematic effect and prevent overlap
		INVOKE_ASYNC(text_box, TYPE_PROC_REF(/atom/movable/screen/text/screen_text/chapter_title, play_to_client))

/atom/movable/screen/text/screen_text/chapter_title/play_to_client()
	player?.add_to_screen(src)
	addtimer(CALLBACK(src, PROC_REF(fade_in)), fade_in_delay)

	addtimer(CALLBACK(src, PROC_REF(after_play)), fade_out_delay)

/atom/movable/screen/text/screen_text/chapter_title/proc/fade_in()
	alpha = 0
	animate(src, fade_in_time, alpha = 255)
	maptext = text_to_play


///handles post-play effects like fade out after the fade out delay
/atom/movable/screen/text/screen_text/chapter_title/after_play()
	if(!fade_out_time)
		end_play()
		return

	animate(src, alpha = 0, time = fade_out_time)
	addtimer(CALLBACK(src, PROC_REF(end_play)), fade_out_time)

/atom/movable/screen/fullscreen/chapter_title
	name = "chapter title"
	icon = 'icons/mob/hud/screen2_full.dmi'
	icon_state = "title_card"
	severity = null
	plane = ABOVE_HUD_PLANE
	layer = ABOVE_HUD_LAYER + 0.1

/client/proc/play_chapter_title()
	set name = "Play Chapter Title"
	set category = "Game Master.Extras"
	if(!check_rights(R_ADMIN))
		return

	var/chapter_title = tgui_input_text(src, "Enter the chapter title.", title = "Chapter Title", multiline = FALSE, encode = TRUE)
	if(!chapter_title)
		return
	message_admins("[src] has displayed a chapter title; '[chapter_title]'")
	notify_ghosts(message = "<span style='font-weight: bold;'>The chapter title '[chapter_title]' has been played.\n</span>")
	for(var/mob/living/carbon/human/human as anything in GLOB.human_mob_list)
		if(human.client)
			human.display_chapter_title("<span class='maptext' style=font-size:10pt;font-family:Verdana;text-align:left valign='bottom'>[chapter_title]", /atom/movable/screen/text/screen_text/chapter_title)
			human.overlay_fullscreen("chapter_title", /atom/movable/screen/fullscreen/chapter_title)
			addtimer(CALLBACK(src, PROC_REF(clear_chapter_title), human), 8 SECONDS)

/client/proc/clear_chapter_title(mob/living/carbon/human/human)
	human.clear_fullscreen("chapter_title", 1 SECONDS)
