/mob/living/carbon/human
	var/in_cutscene = FALSE

/proc/simulacrum_text_1(mob/living/carbon/human/human)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "Somewhere..."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(1.5 SECONDS)
	var/atom/movable/screen/text/screen_text/body = new /atom/movable/screen/text/screen_text/simulacrum_message/body()
	body.text_to_play = "You exist in a black, impermeable void. Exist, for there is no other word to describe it. You cannot feel any sort of body or other physical attachments, and you cannot see anything but black. Despite all this, you are undeniably conscious. From this sleepless dream of nothingness, will you wake up, you wonder?"
	body.player = human.client
	body.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body)
	body.play_to_client()
	sleep(5 SECONDS)
	var/atom/movable/screen/text/screen_text/body2 = new /atom/movable/screen/text/screen_text/simulacrum_message/body/secondary()
	body2.text_to_play = "After three seconds of eternity pass, you awaken. Perhaps it is over." // "There’s an emperor, and he asks the shepherd’s boy how many seconds in eternity. And the shepherd’s boy says, 'There’s a mountain of pure diamond. It takes an hour to climb it and an hour to go around it, and every hundred years a little bird comes and sharpens its beak on the diamond mountain. And when the entire mountain is chiseled away, the first second of eternity will have passed.'"
	body2.player = human.client
	body2.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body2)
	body2.play_to_client()
	sleep(5 SECONDS)
	text_box.after_play()
	body.after_play()
	body2.after_play()
	teleport_to_simulation(human, TRUE, TRUE)
	human.in_cutscene = FALSE

/proc/simulacrum_text_2(mob/living/carbon/human/human, should_roar)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "Back here again."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(1.5 SECONDS)
	var/atom/movable/screen/text/screen_text/body = new /atom/movable/screen/text/screen_text/simulacrum_message/body()
	body.text_to_play = "You died, you know that for certain. You vividly remember your grisly fate, and you suspect you will for a long time. Now, though, you're in an abyss unending once more. And there is nothing to do but wait."
	body.player = human.client
	body.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body)
	body.play_to_client()
	sleep(4 SECONDS)
	var/atom/movable/screen/text/screen_text/body2 = new /atom/movable/screen/text/screen_text/simulacrum_message/body/secondary()
	body2.text_to_play = "An unknown amount of time passes."
	body2.player = human.client
	body2.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body2)
	body2.play_to_client()
	sleep(3 SECONDS)
	text_box.after_play()
	body.after_play()
	body2.after_play()
	teleport_to_simulation(human, should_roar, FALSE)
	human.in_cutscene = FALSE

/proc/simulacrum_text_3(mob/living/carbon/human/human, should_roar)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "Pain unending."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(1.5 SECONDS)
	var/atom/movable/screen/text/screen_text/body = new /atom/movable/screen/text/screen_text/simulacrum_message/body()
	body.text_to_play = "Another very-real death, and another portion of time spent in the void, alone with naught but your thoughts."
	body.player = human.client
	body.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body)
	body.play_to_client()
	sleep(4 SECONDS)
	text_box.after_play()
	body.after_play()
	teleport_to_simulation(human, should_roar, FALSE)
	human.in_cutscene = FALSE

/proc/simulacrum_text_4(mob/living/carbon/human/human, should_roar)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "6 Simulations Later..."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(2.5 SECONDS)
	text_box.after_play()
	teleport_to_simulation(human, should_roar, FALSE)
	human.in_cutscene = FALSE

/proc/simulacrum_text_5(mob/living/carbon/human/human, should_roar)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "19 Simulations Later..."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(2.5 SECONDS)
	text_box.after_play()
	teleport_to_simulation(human, should_roar, FALSE)
	human.in_cutscene = FALSE

/proc/simulacrum_text_6(mob/living/carbon/human/human, should_roar)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "321 Simulations Later..."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(2.5 SECONDS)
	text_box.after_play()
	teleport_to_simulation(human, should_roar, FALSE)
	human.in_cutscene = FALSE

/proc/simulacrum_text_ending_good(mob/living/carbon/human/human)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "It's finally over."
	text_box.player = human.client
	text_box.color = "#233598"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(2.5 SECONDS)
	var/atom/movable/screen/text/screen_text/body = new /atom/movable/screen/text/screen_text/simulacrum_message/body()
	body.text_to_play = "As the dropship flies through space, your squad doesn't talk much. There's too much to think about, too many battles seen to process."
	body.player = human.client
	body.color = "#535ca9"
	LAZYADD(human.client.screen_texts, body)
	body.play_to_client()
	sleep(3 SECONDS)
	var/atom/movable/screen/text/screen_text/body2 = new /atom/movable/screen/text/screen_text/simulacrum_message/body/secondary()
	body2.text_to_play = "The following week is a blur, with countless interviews and medical screenings being done. But life goes on."
	body2.player = human.client
	body2.color = "#535ca9"
	LAZYADD(human.client.screen_texts, body2)
	body2.play_to_client()
	sleep(3 SECONDS)
	var/assembled_fatestring = ""
	for(var/fate in GLOB.simulation_controller.fate_list)
		assembled_fatestring += "[fate][fate == GLOB.simulation_controller.fate_list[length(GLOB.simulation_controller.fate_list)] ? "" : "<br>"]"
	var/atom/movable/screen/text/screen_text/body3 = new /atom/movable/screen/text/screen_text/simulacrum_message/body/fatelist()
	body3.text_to_play = assembled_fatestring
	body3.player = human.client
	body3.color = "#535ca9"
	LAZYADD(human.client.screen_texts, body3)
	body3.play_to_client()
	sleep(5 SECONDS)
	text_box.after_play()
	body.after_play()
	body2.after_play()
	body3.after_play()
	sleep(7 SECONDS)
	simulacrum_text_ending_good_2(human)

/proc/simulacrum_text_ending_good_2(mob/living/carbon/human/human)
	if(!GLOB.simulation_controller.next_simulation)
		GLOB.simulation_controller.next_simulation = GLOB.simulation_controller.non_completed_simulations[1][1]
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "..."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(2.5 SECONDS)
	var/atom/movable/screen/text/screen_text/body = new /atom/movable/screen/text/screen_text/simulacrum_message/body()
	body.text_to_play = "\"Why am I back here? I'm dead, aren't I?\""
	body.player = human.client
	body.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body)
	body.play_to_client()
	sleep(2.5 SECONDS)
	text_box.after_play()
	body.after_play()
	teleport_to_simulation(human, FALSE, FALSE)
	message_admins("END THE ROUND IN A LITTLE TINY BIT")
	human.in_cutscene = FALSE

/proc/simulacrum_text_ending_bad(mob/living/carbon/human/human, should_roar)
	human.in_cutscene = TRUE
	var/atom/movable/screen/text/screen_text/text_box = new /atom/movable/screen/text/screen_text/simulacrum_message()
	text_box.text_to_play = "That was our chance."
	text_box.player = human.client
	text_box.color = "#8a2398"
	LAZYADD(human.client.screen_texts, text_box)
	text_box.play_to_client()
	sleep(2.5 SECONDS)
	var/atom/movable/screen/text/screen_text/body = new /atom/movable/screen/text/screen_text/simulacrum_message/body()
	body.text_to_play = "You know it still watches. It simulates, endlessly. A thousand more deaths you may experience, that is certain."
	body.player = human.client
	body.color = "#9f53a9"
	LAZYADD(human.client.screen_texts, body)
	body.play_to_client()
	sleep(5 SECONDS)
	text_box.after_play()
	body.after_play()
	message_admins("END THE ROUND NOW")
	sleep(15 SECONDS)
	if(human.client)
		winset(human.client, "infowindow", "is-visible=true")
		winset(human.client, "outputwindow", "is-visible=true")
		winset(human.client, "mainwindow.split", "splitter=400")
		human.client.fit_viewport()
		human.client.nuke_chat()
