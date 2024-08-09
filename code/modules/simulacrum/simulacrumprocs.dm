/proc/slow_everyone()
	for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
		to_chat(human, SPAN_WARNING("You feel your boots stick to the darkness below you, it's a bit harder to move."))
		human.apply_effect(1000000, SLOW)

/client/proc/slow_everyone_verb()
	set name = "Slow Everyone"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	slow_everyone()

/proc/superslow_everyone()
	for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
		to_chat(human, SPAN_WARNING("Your boots are really sinking into the darkness now. It's incredibly hard to move."))
		human.apply_effect(1000000, SUPERSLOW)

/client/proc/superslow_everyone_verb()
	set name = "Superslow Everyone"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	superslow_everyone()

/proc/ko_everyone()
	for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(ko_single_mob), human)

/client/proc/ko_everyone_verb()
	set name = "KO Everyone"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	if(tgui_input_list(src, "Are you sure you want to KO everyone", "KO?", list("yes", "no")) != "yes")
		return

	ko_everyone()

/proc/ko_single_mob(mob/living/carbon/human/human)
	to_chat(human, SPAN_WARNING("A low whirring fills your mind."))
	human.clear_fullscreens()
	var/atom/movable/screen/fullscreen/overlay_screen = human.overlay_fullscreen("simulacrum_ko", /atom/movable/screen/fullscreen/impaired)
	overlay_screen.icon_state = "impairedoverlay1"
	sleep(5 SECONDS)
	to_chat(human, SPAN_WARNING("The whirring grows louder, it's a bit harder to think..."))
	overlay_screen.icon_state = "impairedoverlay3"
	sleep(12 SECONDS)
	to_chat(human, SPAN_WARNING("The drone in your mind grows ever louder. It hurts."))
	overlay_screen.icon_state = "impairedoverlay5"
	sleep(10 SECONDS)
	to_chat(human, SPAN_BOLDWARNING("MAKE IT STOP!"))
	overlay_screen.icon_state = "impairedoverlay6"
	sleep(10 SECONDS)
	to_chat(human, SPAN_BOLDWARNING("You collapse, drifting to unconsciousness as this cacaphony of sound assaults your senses."))
	overlay_screen.icon_state = "impairedoverlay7"
	human.Stun(100000000)
	human.loc = null
	human.SetEyeBlind(100000000)
	save_human(human)
	human.ghost_locked = TRUE
	human.hudswitch_blocked = TRUE
	human.hud_used.show_hud(HUD_STYLE_NOHUD, human)
	message_admins("close inventories now")
	sleep(5 SECONDS)
	if(human.client) // devious shenanigans
		winset(human.client, "mainwindow.split", "splitter=1000")
		winset(human.client, "infowindow", "is-visible=false")
		winset(human.client, "outputwindow", "is-visible=false")
	simulacrum_text_1(human)

/proc/teleport_to_simulation(mob/living/carbon/human/human, roar = TRUE, initial_run = FALSE)
	var/turf/teleport_turf = locate(GLOB.simulation_controller.next_simulation[1], GLOB.simulation_controller.next_simulation[2], GLOB.simulation_controller.next_simulation[3])
	var/turf/picked_turf = pick(block(teleport_turf.x - 1, teleport_turf.y - 1, teleport_turf.z, teleport_turf.x + 1, teleport_turf.y + 1, teleport_turf.z))
	human.forceMove(picked_turf)
	if(!initial_run)
		load_human(human)
	sleep(4 SECONDS) // give time for weeds and me
	to_chat(human, SPAN_NOTICE("You appear from the nothingness."))
	if(human.client)
		winset(human.client, "infowindow", "is-visible=true")
		winset(human.client, "outputwindow", "is-visible=true")
		winset(human.client, "mainwindow.split", "splitter=400")
		human.client.fit_viewport()
		human.client.nuke_chat()
		if(roar)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound_client), human.client, 'sound/voice/alien_distantroar_3.ogg', human.loc, 55, FALSE), 10 SECONDS)
	human.hudswitch_blocked = FALSE
	human.hud_used.show_hud(HUD_STYLE_STANDARD, human)
	human.SetStun(0)
	human.SetEyeBlind(0)
	human.rejuvenate()
	human.clear_fullscreen("simulacrum_ko", TRUE)

/mob/living/carbon/human
	var/ghost_locked = FALSE

/mob/living/carbon/human/do_ghost()
	if(ghost_locked)
		to_chat(src, SPAN_BOLDWARNING("You cannot leave your corpse at this time."))
		return
	return ..()

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

/client/proc/pick_simulation_verb()
	set name = "Pick Next Simulation"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	var/result1 = tgui_input_list(mob, "Pick next category", "Category", GLOB.simulation_controller.non_completed_simulations)
	if(!result1)
		return

	GLOB.simulation_controller.next_simulation = GLOB.simulation_controller.non_completed_simulations[result1][1] // Go in order of simulations
	to_chat(src, SPAN_NOTICE("Category of [result1] selected."))

/client/proc/decay_old_simulation_cutscene_verb()
	set name = "Decay Old Simulation & Cutscene"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	if(GLOB.simulation_controller.next_cutscene)
		GLOB.simulation_controller.non_completed_cutscenes -= GLOB.simulation_controller.next_cutscene
		GLOB.simulation_controller.next_cutscene = ""
		to_chat(src, SPAN_NOTICE("Cutscene decayed."))

	if(GLOB.simulation_controller.next_simulation)
		for(var/mapname in GLOB.simulation_controller.non_completed_simulations)
			//for(var/list/coordset as anything in GLOB.simulation_controller.non_completed_simulations[mapname])
			for(var/i in 1 to length(GLOB.simulation_controller.non_completed_simulations[mapname]))
				if((GLOB.simulation_controller.non_completed_simulations[mapname][i][1] == GLOB.simulation_controller.next_simulation[1]) && (GLOB.simulation_controller.non_completed_simulations[mapname][i][2] == GLOB.simulation_controller.next_simulation[2]) && (GLOB.simulation_controller.non_completed_simulations[mapname][i][3] == GLOB.simulation_controller.next_simulation[3]))
					GLOB.simulation_controller.non_completed_simulations[mapname][i] = null

		var/list/new_simlist = list(
			"desert_dam" = list(),
			"varadero" = list(),
			"ice_colony" = list(),
			"chances_claim" = list(),
			"corsat" = list(),
			"final" = list()
		)
		for(var/entry in GLOB.simulation_controller.non_completed_simulations)
			for(var/list/coordset as anything in GLOB.simulation_controller.non_completed_simulations[entry])
				if(isnull(coordset))
					continue
				new_simlist[entry] += list(coordset)
			if(!length(new_simlist[entry]))
				new_simlist -= entry

		GLOB.simulation_controller.non_completed_simulations = new_simlist
		GLOB.simulation_controller.next_simulation = null
		to_chat(src, SPAN_NOTICE("Simulation decayed."))

/client/proc/toggle_cutscene_verb()
	set name = "Toggle Cutscene"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	if(!length(GLOB.simulation_controller.non_completed_cutscenes))
		to_chat(src, SPAN_BOLDNOTICE("No more cutscenes to play."))
		return

	if(GLOB.simulation_controller.next_cutscene)
		GLOB.simulation_controller.next_cutscene = ""
		to_chat(src, SPAN_BOLDNOTICE("Next loop will no longer trigger a cutscene."))
		return

	GLOB.simulation_controller.next_cutscene = GLOB.simulation_controller.non_completed_cutscenes[1]
	to_chat(src, SPAN_BOLDNOTICE("Next loop will now trigger cutscene [GLOB.simulation_controller.next_cutscene]. After this one, there are [length(GLOB.simulation_controller.non_completed_cutscenes) - 1] cutscenes remaining."))

/client/proc/go_to_next_simulation_verb()
	set name = "Advance Simulation"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	if(!GLOB.simulation_controller.next_simulation)
		to_chat(src, SPAN_NOTICE("Next simulation has not been selected."))
		return

	if(tgui_input_list(src, "Are you sure you want to advance the simulation?", "Advance?", list("yes", "no")) != "yes")
		return

	to_chat(src, SPAN_NOTICE("Advancing simulation. Cutscene [GLOB.simulation_controller.next_cutscene ? "will" : "will not"] play."))
	var/do_roar = TRUE
	if(GLOB.simulation_controller.next_simulation[1] == 19 && GLOB.simulation_controller.next_simulation[2] == 54)
		do_roar = FALSE

	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		if(!save.tied_human)
			message_admins("FUCKFUCKFUCK. A save with ckey [save.tied_ckey] no longer has a tied human!!!! FUCK")
			continue

		save.tied_human.rejuvenate()
		save.tied_human.clear_fullscreens()
		var/atom/movable/screen/fullscreen/overlay_screen = save.tied_human.overlay_fullscreen("simulacrum_ko", /atom/movable/screen/fullscreen/impaired)
		overlay_screen.icon_state = "impairedoverlay7"
		save.tied_human.Stun(100000000)
		save.tied_human.loc = null
		save.tied_human.SetEyeBlind(100000000)
		save.tied_human.hudswitch_blocked = TRUE
		save.tied_human.hud_used.show_hud(HUD_STYLE_NOHUD, save.tied_human)
		if(GLOB.simulation_controller.next_cutscene)
			if(save.tied_human) // devious shenanigans
				winset(save.tied_human, "mainwindow.split", "splitter=1000")
				winset(save.tied_human, "infowindow", "is-visible=false")
				winset(save.tied_human, "outputwindow", "is-visible=false")
			switch(GLOB.simulation_controller.next_cutscene)
				if("2")
					INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_2), save.tied_human, do_roar)
				if("3")
					INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_3), save.tied_human, do_roar)
				if("4")
					INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_4), save.tied_human, do_roar)
				if("5")
					INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_5), save.tied_human, do_roar)
				if("6")
					INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_6), save.tied_human, do_roar)

		else
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(teleport_to_simulation), save.tied_human, do_roar, FALSE)

/client/proc/boss_roar_verb()
	set name = "Boss Roar"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		to_chat(save.tied_human, SPAN_BOLDWARNING("The strange device lets out a low groan as xenomorphs start to appear from nothingness!"))

/client/proc/boss_finish_verb()
	set name = "Boss Finished"
	set category = "Admin.Simulation"
	set waitfor = FALSE

	if(!check_rights(R_EVENT))
		return

	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		to_chat(save.tied_human, SPAN_BOLDWARNING("With the destruction of the monolith, you feel yourself rejuvinate."))
		save.tied_human.rejuvenate()

	message_admins("Finish pt1 executed")

	sleep(6 SECONDS)

	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		to_chat(save.tied_human, SPAN_BOLDWARNING("You now see the faintest sign of light to your south."))

	for(var/turf/T as anything in block(56, 54, 3, 68, 54, 3))
		T.ChangeTurf(/turf/open/floor/void)

	message_admins("Finish pt2 executed")

/client/proc/end_game_good()
	set name = "Game End - Good"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	if(tgui_input_list(src, "Are you sure you want to end the game well?", "End game?", list("yes", "no")) != "yes")
		return

	assemble_fates()
	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		if(!save.tied_human)
			message_admins("FUCKFUCKFUCK. A save with ckey [save.tied_ckey] no longer has a tied human!!!! FUCK2")
			continue

		save.tied_human.Stun(100000000)
		save.tied_human.loc = null
		save.tied_human.SetEyeBlind(100000000)
		save.tied_human.hudswitch_blocked = TRUE
		save.tied_human.hud_used.show_hud(HUD_STYLE_NOHUD, save.tied_human)
		winset(save.tied_human, "mainwindow.split", "splitter=1000")
		winset(save.tied_human, "infowindow", "is-visible=false")
		winset(save.tied_human, "outputwindow", "is-visible=false")

		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_ending_good), save.tied_human)

/client/proc/end_game_bad()
	set name = "Game End - Bad"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	if(tgui_input_list(src, "Are you sure you want to end the game badly?", "End game?", list("yes", "no")) != "yes")
		return

	assemble_fates()
	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		if(!save.tied_human)
			message_admins("FUCKFUCKFUCK. A save with ckey [save.tied_ckey] no longer has a tied human!!!! FUCK3")
			continue

		save.tied_human.Stun(100000000)
		save.tied_human.loc = null
		save.tied_human.SetEyeBlind(100000000)
		save.tied_human.hudswitch_blocked = TRUE
		save.tied_human.hud_used.show_hud(HUD_STYLE_NOHUD, save.tied_human)
		winset(save.tied_human, "mainwindow.split", "splitter=1000")
		winset(save.tied_human, "infowindow", "is-visible=false")
		winset(save.tied_human, "outputwindow", "is-visible=false")

		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(simulacrum_text_ending_bad), save.tied_human)

/proc/assemble_fates()
	var/list/human_names = list()
	var/list/fate_list_pre = list(
		"- Following their harrowing experience, %NAME% quietly left the USCM at the first opportunity. %NAME% retired to the backwater colony of LV-325, living out their days peacefully. They died on August 9th, 2238 of natural causes.",
		"- %NAME% continued their enlistment in the USCM following the incident. They were killed in a USCM raid on a CLF cell on June 14th, 2185.",
		"- %NAME% became far more withdrawn after the incident. Once discharged from the USCM, they moved to Station 949, becoming a private security officer. They passed away from a rapidly-expanding brain tumor on Febuary 14th, 2199.",
		"- After retiring from the USCM %NAME% was employed as a shift manager at LockMart's Leo plant on Mars. Alongside 200 others, %NAME% was killed in the Leo explosion of 2187 on May 1st.",
		"- %NAME% retired to colonial life on LV-522, Chance's Claim. A xenomorph outbreak would see %NAME% meet their fate in the xenomorph hive on August 23rd, 2192.",
		"- Quiet and reserved after the incident, %NAME% retired from the USCM and served as the Chief Engineer on a LockMart & Welsun 3300B colony carrier, ferrying atmospheric processors to budding worlds. They passed on December 1st, 2210 in a vehicular accident.",
		"- %NAME% never fully recovered from the stress experienced during the incident. %NAME% died on July 29th, 2182 of a heart attack.",
	)
	var/list/final_fates = list()
	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		human_names += save.tied_human.real_name

	for(var/name in human_names)
		var/fate_string = pick(fate_list_pre)
		fate_list_pre -= fate_string
		final_fates += replacetext(fate_string, "%NAME%", name)
	//for(var/fate in fate_list_pre)
	//	final_fates += replacetext(fate, "%NAME%", human_names[1])

	GLOB.simulation_controller.fate_list = final_fates


/client/proc/close_all_inventories()
	set name = "Close All Inventories"
	set category = "Admin.Simulation"

	if(!check_rights(R_EVENT))
		return

	for(var/savename in GLOB.simulacrum_playersaves)
		var/datum/simulacrum_humansave/save = GLOB.simulacrum_playersaves[savename]
		for(var/obj/item/storage/SI in get_recursive_contents(save.tied_human))
			SI.storage_close(save.tied_human)

	to_chat(src, SPAN_NOTICE("Inventories closed."))
