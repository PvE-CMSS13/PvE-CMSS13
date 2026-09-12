// This is in no means my own code, thank you to Zonespace who wrote it all up for me to take later!

GLOBAL_DATUM_INIT(simulation_controller, /datum/simulation_controller, new)

/datum/simulation_controller
	var/list/non_completed_simulations = list(
		"desert_dam" = list(list(61, 194, 3), list(98, 194, 3), list(135, 194, 3)),
		"varadero" = list(list(24, 162, 3), list(58, 162, 3), list(92, 162, 3)),
		"ice_colony" = list(list(19, 128, 3), list(55, 128, 3), list(91, 128, 3)),
		"chances_claim" = list(list(23, 86, 3), list(61, 86, 3), list(99, 86, 3)),
		"corsat" = list(list(58, 13, 3), list(119, 13, 3), list(152, 52, 3)),
		"final" = list(list(19, 54, 3)),
	)
	var/list/next_simulation = list(24, 194, 3)
	var/list/non_completed_cutscenes = list("2", "3", "4", "5", "6")
	var/next_cutscene = ""
	var/current_cutscene_completed = FALSE
	var/everyone_already_koed
	var/list/fate_list = list()
	var/list/dead_list = list()

/proc/ko_everyone()
	for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(ko_single_mob), human)

/client/proc/ko_everyone_verb()
	set name = "Blow Up The Rover"
	set category = "Game Master.Extras"

	if(!check_rights(R_EVENT))
		return

	if(tgui_input_list(src, "Are you sure you want to kill everyone", "KO?", list("yes", "no")) != "yes")
		return

	ko_everyone()

/proc/ko_single_mob(mob/living/carbon/human/human)
	human.clear_fullscreens()
	human.hud_used.show_hud(HUD_STYLE_NOHUD, human)
	to_chat(human, SPAN_BOLDWARNING("The Rover writhes beneath your feet..."))
	var/atom/movable/screen/fullscreen/overlay_screen = human.overlay_fullscreen("simulacrum_ko", /atom/movable/screen/fullscreen/impaired)
	overlay_screen.icon_state = "passage9"
	sleep(1 SECONDS)
	to_chat(human, SPAN_BOLDWARNING("Something detonates. You're not sure what. It doesn't matter."))
	overlay_screen.icon_state = "impaired_overlay8"
	human.Stun(100000000)
	human.loc = null
	human.SetEyeBlind(100000000)
	//human.ghost_locked = TRUE
	human.hudswitch_blocked = TRUE
	message_admins("Cutscene initialized")
	sleep(5 SECONDS)
	if(human.client) // devious shenanigans
		winset(human.client, "mainwindow.split", "splitter=1000")
		winset(human.client, "infowindow", "is-visible=false")
		winset(human.client, "outputwindow", "is-visible=false")
	simulacrum_text_ending_bad(human)

/mob/living/carbon/human
	var/ghost_locked = FALSE

/mob/living/carbon/human/do_ghost()
	if(ghost_locked)
		to_chat(src, SPAN_BOLDWARNING("You cannot leave your corpse at this time."))
		return
	return ..()

/client/proc/end_game_bad()
	set name = "Game End"
	set category = "Admin.Simulation"

	if(!check_rights(R_ADMIN))
		return

	if(tgui_input_list(src, "Are you sure you want to end the game badly?", "End game?", list("yes", "no")) != "yes")
		return

	for(var/savename in GLOB.simulacrum_playersaves	)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		save.tied_human.rejuvenate()
		save.tied_human.clear_fullscreens()
		var/atom/movable/screen/fullscreen/overlay_screen = save.tied_human.overlay_fullscreen("simulacrum_ko", /atom/movable/screen/fullscreen/impaired)
		overlay_screen.icon_state = "impairedoverlay7"
		save.tied_human.Stun(100000000)
		save.tied_human.loc = null
		save.tied_human.SetEyeBlind(100000000)
		save.tied_human.hudswitch_blocked = TRUE
		save.tied_human.hud_used.show_hud(HUD_STYLE_NOHUD, save.tied_human)

		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_ending_bad), save.tied_human)

/client/proc/close_all_inventories()
	set name = "Close All Inventories"
	set category = "Game Master.Extras"

	if(!check_rights(R_EVENT))
		return

	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		for(var/obj/item/storage/SI in get_recursive_contents(save.tied_human))
			SI.storage_close(save.tied_human)

	to_chat(src, SPAN_NOTICE("Inventories closed."))

/proc/cutscene_all_one() // see I *could* automate this by skipping to the second call after the first one's played, or I can just copy-paste like an asshole
	for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(cutscene_single_mob_one), human)

/client/proc/cutscene_all_verb_one()
	set name = "Play Cutscene One"
	set category = "Game Master.Extras"

	if(!check_rights(R_EVENT))
		return

	if(tgui_input_list(src, "Play?", "KO?", list("yes", "no")) != "yes")
		return

	cutscene_all_one()

/proc/cutscene_all_two()
	for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(cutscene_single_mob_two), human)

/client/proc/cutscene_all_verb_two()
	set name = "Play Cutscene Two"
	set category = "Game Master.Extras"

	if(!check_rights(R_EVENT))
		return

	if(tgui_input_list(src, "Play?", "KO?", list("yes", "no")) != "yes")
		return

	cutscene_all_two()

/proc/cutscene_single_mob_one(mob/living/carbon/human/human)
	human.clear_fullscreens()
	human.hud_used.show_hud(HUD_STYLE_NOHUD, human)
	var/atom/movable/screen/fullscreen/overlay_screen = human.overlay_fullscreen("simulacrum_ko", /atom/movable/screen/fullscreen/impaired)
	overlay_screen.icon_state = "black"
	human.Stun(100000000)
	human.SetEyeBlind(100000000)
	human.ghost_locked = TRUE
	human.hudswitch_blocked = TRUE
	message_admins("Cutscene initialized")
	sleep(5 SECONDS)
	if(human.client) // devious shenanigans
		winset(human.client, "mainwindow.split", "splitter=1000")
		winset(human.client, "infowindow", "is-visible=false")
		winset(human.client, "outputwindow", "is-visible=false")
	cutsceneone(human)

/proc/cutscene_single_mob_two(mob/living/carbon/human/human)
	human.clear_fullscreens()
	human.hud_used.show_hud(HUD_STYLE_NOHUD, human)
	var/atom/movable/screen/fullscreen/overlay_screen = human.overlay_fullscreen("simulacrum_ko", /atom/movable/screen/fullscreen/impaired)
	overlay_screen.icon_state = "black"
	human.Stun(100000000)
	human.SetEyeBlind(100000000)
	human.ghost_locked = TRUE
	human.hudswitch_blocked = TRUE
	message_admins("Cutscene initialized")
	if(human.client) // devious shenanigans
		winset(human.client, "mainwindow.split", "splitter=1000")
		winset(human.client, "infowindow", "is-visible=false")
		winset(human.client, "outputwindow", "is-visible=false")
	cutscenetwo(human)
