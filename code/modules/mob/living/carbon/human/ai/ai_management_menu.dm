/datum/human_ai_management_menu

/datum/human_ai_management_menu/New()

/datum/human_ai_management_menu/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HumanAIManager")
		ui.open()

/datum/human_ai_management_menu/ui_state(mob/user)
	return GLOB.admin_state

/datum/human_ai_management_menu/ui_data(mob/user)
	var/list/data = list()

	data["orders"] = list()
	for(var/datum/ai_order/order as anything in SShuman_ai.existing_orders)
		data["orders"] += list(list(
			"name" = order.name,
			"type" = order.type,
			"data" = order.tgui_data(),
			"ref" = REF(order),
		)
	)

	data["ai_humans"] = list()
	for(var/datum/human_ai_brain/brain as anything in GLOB.human_ai_brains)
		if(!brain.tied_human || brain.tied_human.stat == DEAD)
			continue

		data["ai_humans"] += list(list(
			"name" = brain.tied_human.real_name,
			"health" = FLOOR((brain.tied_human.health / brain.tied_human.maxHealth * 100), 1),
			"loc" = list(brain.tied_human.x, brain.tied_human.y, brain.tied_human.z),
			"faction" = brain.tied_human.faction,
			"ref" = REF(brain.tied_human),
			"brain_ref" = REF(brain),
			"in_combat" = brain.in_combat,
			"squad_id" = brain.squad_id,
			"can_assign_squad" = brain.can_assign_squad,
		))

	data["squads"] = list()
	for(var/datum/human_ai_squad/squad as anything in SShuman_ai.squads)
		var/list/name_list = list()
		for(var/datum/human_ai_brain/brain as anything in squad.ai_in_squad)
			name_list += brain.tied_human?.real_name
		data["squads"] += list(list(
			"id" = squad.id,
			"name" = squad.name,
			"members" = english_list(name_list),
			"order" = squad.current_order?.name,
			"ref" = REF(squad),
			"squad_leader" = squad.squad_leader?.tied_human?.real_name,
		))

	return data

/datum/human_ai_management_menu/ui_static_data(mob/user)
	var/list/data = list()

	return data

/datum/human_ai_management_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("view_variables")
			if(!params["ref"])
				return

			var/datum/gotten_ref = locate(params["ref"])
			if(!istype(gotten_ref))
				return

			ui.user.client?.debug_variables(gotten_ref)
			return TRUE

		if("jump_to")
			if(!params["ref"])
				return

			var/mob/living/carbon/human/ai_human = locate(params["ref"])

			if(istype(ui.user, /mob/dead/observer))
				var/mob/dead/observer/ghost = ui.user
				if(ai_human?.loc)
					ghost.JumpToCoord(ai_human.x, ai_human.y, ai_human.z)
			return TRUE

		if("create_squad")
			SShuman_ai.create_new_squad()
			return TRUE

		if("rename_squad")
			if(!params["squad"])
				return

			var/datum/human_ai_squad/squad = SShuman_ai.get_squad("[params["squad"]]")
			squad.name = tgui_input_text(ui.user, "Input new squad name", "Input")
			return TRUE

		if("assign_to_squad")
			if(!params["squad"] || !params["ai"])
				return

			var/datum/human_ai_brain/brain = locate(params["ai"])
			if(!brain.can_assign_squad)
				return TRUE

			brain.add_to_squad(params["squad"])
			return TRUE

		if("assign_order")
			if(!params["squad"] || !params["order"])
				return

			var/datum/human_ai_squad/squad = SShuman_ai.get_squad("[params["squad"]]")
			squad.set_current_order(locate(params["order"]))
			return TRUE

		if("assign_sl")
			if(!params["squad"] || !params["ai"])
				return

			var/datum/brain = locate(params["ai"])
			var/datum/human_ai_squad/squad = SShuman_ai.get_squad("[params["squad"]]")
			squad.set_squad_leader(brain)
			return TRUE

		if("delete_object") // This UI is fully GM-only so I'm not worried about someone abusing this
			if(!params["ref"])
				return

			var/datum/ref_to_del = locate(params["ref"])
			qdel(ref_to_del)
			return TRUE

/client/proc/open_human_ai_management_panel()
	set name = "Human AI Management Panel"
	set category = "Game Master.HumanAI"

	if(!check_rights(R_DEBUG))
		return

	if(human_ai_menu)
		human_ai_menu.tgui_interact(mob)
		return

	human_ai_menu = new /datum/human_ai_management_menu(src)
	human_ai_menu.tgui_interact(mob)

/client/proc/create_human_ai()
	set name = "Create Human AI - Expanded"
	set category = "Game Master.HumanAI"

	if(!check_rights(R_DEBUG))
		return

	if(!SSticker.mode)
		to_chat(src, SPAN_WARNING("The round hasn't started yet!"))
		return

	var/mob/living/carbon/human/ai_human = new()
	ai_human.AddComponent(/datum/component/human_ai)

	if(!cmd_admin_dress_human(ai_human, randomize = TRUE))
		qdel(ai_human)
		return

	ai_human.face_dir(mob.dir)
	ai_human.forceMove(get_turf(mob))
	ai_human.get_ai_brain().appraise_inventory(armor = TRUE)

/client/proc/make_human_ai(mob/living/carbon/human/mob in GLOB.human_mob_list)
	set name = "Make AI"
	set desc = "Add AI functionality to a human."
	set category = null

	if(!check_rights(R_DEBUG|R_ADMIN))
		return

	if(QDELETED(mob))
		return

	if(mob.GetComponent(/datum/component/human_ai))
		to_chat(usr, SPAN_WARNING("[mob] already has an assigned AI."))
		return

	if(mob.ckey && tgui_alert(mob, "This mob is being controlled by [mob.ckey]. Are you sure you wish to add AI to it?","Make AI", list("Yes","No")) != "Yes")
		return

	mob.AddComponent(/datum/component/human_ai)
	mob.get_ai_brain().appraise_inventory()

	message_admins("[key_name_admin(usr)] assigned an AI component to [mob.real_name].")

/client/proc/toggle_human_ai_tweaks()
	set name = "Toggle Human AI Tweaks"
	set category = "Game Master.Flags"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	if(!SSticker.mode)
		to_chat(usr, SPAN_WARNING("A mode hasn't been selected yet!"))
		return

	SSticker.mode.toggleable_flags ^= MODE_HUMAN_AI_TWEAKS
	message_admins("[src] has [MODE_HAS_TOGGLEABLE_FLAG(MODE_HUMAN_AI_TWEAKS) ? "toggled Human AI tweaks on" : "toggled Human AI tweaks off"].")

/client/proc/import_human_ai_preset_dictictonary()
	set name = "Import Human AI Presets Dictionary"
	set category = "Game Master.HumanAI"

	if(!admin_holder || !check_rights(R_MOD, FALSE))
		return

	var/dictionary_string = input(usr, "Choose a Human AI preset dictionary file.","Upload hAi_dictionary.txt") as null|file
	dictionary_string = file2text(dictionary_string)
	var/datum/human_ai_spawner_menu/the_beast
	the_beast.lazy_ui_data = json_decode(dictionary_string)
	for(var/faction_name in the_beast.lazy_ui_data)
		var/list/faction_list = the_beast.lazy_ui_data[faction_name]
		for(var/list/preset_data in faction_list)
			preset_data["path"] = text2path(preset_data["path"])
	the_beast = new()
