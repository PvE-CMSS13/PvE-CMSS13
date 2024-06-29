/obj/structure/machinery/computer/card
	name = "Identification Computer"
	desc = "Terminal for programming USCM employee ID card access."
	icon_state = "id"
	req_access = list(ACCESS_MARINE_DATABASE)
	circuit = /obj/item/circuitboard/computer/card
	var/obj/item/card/id/user_id_card
	var/obj/item/card/id/target_id_card
	// What factions we are able to modify. Hardcoded to be singular as faction search is how variables are retrieved. The variable passed to the machine for IFF can be turned into a list if desired. That shouldn't be too hard.
	var/faction = FACTION_MARINE
	/// If we're located somewhere specific, text string. Otherwise will pull from station_name.
	var/location
	var/printing

	var/authenticated = FALSE

/obj/structure/machinery/computer/card/proc/authenticate(mob/user, obj/item/card/id/id_card)
	if(!id_card)
		visible_message("[SPAN_BOLD("[src]")] states, \"AUTH ERROR: Authority confirmation card is missing!\"")
		return FALSE

	if(check_access(id_card))
		authenticated = TRUE
		visible_message("[SPAN_BOLD("[src]")] states, \"AUTH LOGIN: Welcome, [id_card.registered_name]. Access granted.\"")
		update_static_data(user)
		return TRUE

	visible_message("[SPAN_BOLD("[src]")] states, \"AUTH ERROR: You have not enough authority! Access denied.\"")
	return FALSE

/obj/structure/machinery/computer/card/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CardMod", name)
		ui.open()

/obj/structure/machinery/computer/card/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user
	var/datum/faction/console_faction = get_faction(faction)

	playsound(src, pick('sound/machines/computer_typing4.ogg', 'sound/machines/computer_typing5.ogg', 'sound/machines/computer_typing6.ogg'), 5, 1)
	switch(action)
		if("PRG_authenticate")
			var/obj/item/I = user.get_active_hand()
			if (istype(I, /obj/item/card/id))
				if(user.drop_held_item())
					I.forceMove(src)
					user_id_card = I
			if(authenticate(user, user_id_card))
				return TRUE
			// Well actualy we have no button for auth card ejection, so just spit it back in user's face
			else
				if(!user_id_card)
					return
				if(ishuman(user))
					user_id_card.forceMove(user.loc)
					if(!user.get_active_hand())
						user.put_in_hands(user_id_card)
				else
					user_id_card.forceMove(loc)
				user_id_card = null
		if("PRG_logout")
			visible_message("[SPAN_BOLD("[src]")] states, \"AUTH LOGOUT: Session end confirmed.\"")
			authenticated = FALSE
			if(ishuman(user))
				user_id_card.forceMove(user.loc)
				if(!user.get_active_hand())
					user.put_in_hands(user_id_card)
			else
				user_id_card.forceMove(loc)
			user_id_card = null
			return TRUE
		if("PRG_print")
			if(!printing)
				if(params["mode"])
					if(!authenticated || !target_id_card)
						return

					printing = TRUE
					playsound(src.loc, 'sound/machines/fax.ogg', 15, 1)
					sleep(40)
					var/tar_faction = "N/A"
					if(target_id_card.faction_group && islist(target_id_card.faction_group))
						tar_faction = jointext(target_id_card.faction_group, ", ")
					if(isnull(target_id_card.faction_group))
						target_id_card.faction_group = list()
					else
						tar_faction = target_id_card.faction_group
					var/contents = {"<center><h4>Access Report</h4></center>
								<u>Prepared By:</u> [user_id_card?.registered_name ? user_id_card.registered_name : "Unknown"]<br>
								<u>For:</u> [target_id_card.registered_name ? target_id_card.registered_name : "Unregistered"]<br>
								<hr>
								<u>Faction:</u> [tar_faction]<br>
								<u>Assignment:</u> [target_id_card.assignment]<br>
								<u>Account Number:</u> #[target_id_card.associated_account_number]<br>
								<u>Blood Type:</u> [target_id_card.blood_type]<br><br>
								<u>Access:</u><br>
								"}

					var/known_access_rights = console_faction.get_faction_access(faction)

					for(var/A in target_id_card.access)
						if(A in known_access_rights)
							contents += "  [get_access_desc(A)]"

					var/obj/item/paper/P = new /obj/item/paper(src.loc)
					P.name = "Access Report"
					P.info += contents
				else
					printing = TRUE
					playsound(src.loc, 'sound/machines/fax.ogg', 15, 1)
					sleep(40)
					var/obj/item/paper/P = new /obj/item/paper(src.loc)
					P.name = text("Crew Manifest ([])", worldtime2text())
					P.info = {"<center><h4>Crew Manifest</h4></center>
						<br>
						[GLOB.data_core.get_manifest(TRUE)]
					"}
				visible_message(SPAN_NOTICE("\The [src] prints out a paper."))
				printing = FALSE
				return TRUE
			return
		if("PRG_eject")
			var/origin_assignment
			var/origin_name
			if(target_id_card)
				if(target_id_card.registered_name != origin_name || target_id_card.assignment != origin_assignment)
					GLOB.data_core.manifest_modify(target_id_card.registered_name, target_id_card.registered_ref, target_id_card.assignment, target_id_card.rank)
					target_id_card.name = text("[target_id_card.registered_name]'s [target_id_card.card_name] ([target_id_card.assignment])")
					if(target_id_card.registered_name != origin_name)
						log_idmod(target_id_card, "<font color='orange'> [key_name_admin(user)] changed the registered name of the ID to '[target_id_card.registered_name]'. </font>")
					if(target_id_card.assignment != origin_assignment)
						log_idmod(target_id_card, "<font color='orange'> [key_name_admin(user)] changed the assignment of the ID to the custom position '[target_id_card.assignment]'. </font>")
				if(ishuman(user))
					target_id_card.forceMove(user.loc)
					if(!user.get_active_hand())
						user.put_in_hands(target_id_card)
					target_id_card = null
				else
					target_id_card.forceMove(loc)
					target_id_card = null
				visible_message("[SPAN_BOLD("[src]")] states, \"CARD EJECT: Data imprinted. Updating database... Success.\"")
				return TRUE
			else
				var/obj/item/I = user.get_active_hand()
				if (istype(I, /obj/item/card/id))
					if(user.drop_held_item())
						I.forceMove(src)
						target_id_card = I
						visible_message("[SPAN_BOLD("[src]")] states, \"CARD FOUND: Preparing ID modification protocol.\"")
						update_static_data(user)
						origin_assignment = target_id_card.assignment
						origin_name = target_id_card.registered_name
						return TRUE
			return FALSE
		if("PRG_terminate")
			if(!authenticated || !target_id_card)
				return

			target_id_card.assignment = "Terminated"
			target_id_card.access = list()
			log_idmod(target_id_card, "<font color='red'> [key_name_admin(user)] terminated the ID. </font>")
			message_admins("[key_name_admin(user)] terminated the ID of [target_id_card.registered_name].")
			return TRUE
		if("PRG_edit")
			if(!authenticated || !target_id_card)
				return

			var/new_name = strip_html(params["name"])
			if(!new_name)
				visible_message(SPAN_NOTICE("[src] buzzes rudely."))
				return
			target_id_card.registered_name = new_name
			return TRUE
		if("PRG_assign")
			if(!authenticated || !target_id_card)
				return
			var/target = params["assign_target"]
			if(!target)
				return

			if(target == "Custom")
				var/custom_name = strip_html(params["custom_name"])
				if(custom_name)
					target_id_card.assignment = custom_name
			else
				var/datum/job/job = RoleAuthority.roles_by_name[target] //We don't need to make this hardcoded for round only roles. The ID changer should work regardless of what the mode is.

				if(!job)
					visible_message("[SPAN_BOLD("[src]")] states, \"DATA ERROR: Can not find next entry in database: [target]\"")
					return

				target_id_card.access = job.get_access() //You get all of it; you don't keep anything. Not sure why it was subtracted and then added before, this is like getting a brand-new ID.
				target_id_card.assignment = job.get_assignment() // Assignment shows up on the crew tracker and manifest.
				target_id_card.rank = target // Unique identifer for the role. Shouldn't be used for display purposes in most cases as it's equivalent to user.job.
			message_admins("[key_name_admin(user)] gave the ID of [target_id_card.registered_name] the assignment '[target_id_card.assignment]'.")
			return TRUE
		if("PRG_access")
			if(!authenticated || !target_id_card)
				return

			var/access_type = params["access_target"]
			if(access_type == console_faction.faction_tag) //We're adding IFF instead of access. We want our main faction IFF>

				if(!target_id_card.faction_group)
					target_id_card.faction_group = list()
				if(access_type in target_id_card.faction_group)
					target_id_card.faction_group -= access_type
					log_idmod(target_id_card, "<font color='red'> [key_name_admin(user)] revoked [access_type] IFF. </font>")
				else
					target_id_card.faction_group |= access_type
					log_idmod(target_id_card, "<font color='green'> [key_name_admin(user)] granted [access_type] IFF. </font>")
				return TRUE

			else
				access_type = text2num(access_type) //Have to convert into a number here, which will be the access code.
				var/known_access_rights = console_faction.get_faction_access(faction)

				if(access_type in known_access_rights)
					if(access_type in target_id_card.access)
						target_id_card.access -= access_type
						log_idmod(target_id_card, "<font color='red'> [key_name_admin(user)] revoked access '[access_type]'. </font>")
					else
						target_id_card.access |= access_type
						log_idmod(target_id_card, "<font color='green'> [key_name_admin(user)] granted access '[access_type]'. </font>")
					return TRUE
		if("PRG_grantall")
			if(!authenticated || !target_id_card)
				return

			target_id_card.access |= console_faction.get_faction_access(faction)

			if(!target_id_card.faction_group)
				target_id_card.faction_group = list()

			target_id_card.faction_group |= console_faction.faction_tag //The tag of the main group, if we're in a faction group.
			log_idmod(target_id_card, "<font color='green'> [key_name_admin(user)] granted the ID all access and [faction] IFF. </font>")
			return TRUE
		if("PRG_denyall")
			if(!authenticated || !target_id_card)
				return

			target_id_card.access -= console_faction.get_faction_access(faction)
			target_id_card?.faction_group -= console_faction.faction_tag

			log_idmod(target_id_card, "<font color='red'> [key_name_admin(user)] removed all accesses and [faction] IFF. </font>")
			return TRUE
		if("PRG_grantregion")
			if(!authenticated || !target_id_card)
				return

			var/region = params["region"]
			if(!region)
				return
			if(region == "Faction (IFF system)")
				if(!target_id_card.faction_group)
					target_id_card.faction_group = list()

				target_id_card.faction_group |= console_faction.faction_tag
				log_idmod(target_id_card, "<font color='green'> [key_name_admin(user)] granted [console_faction.faction_tag] IFF. </font>")
				return TRUE

			var/regions[] = console_faction.get_faction_regions(faction)

			target_id_card.access |= regions[region]
			log_idmod(target_id_card, "<font color='green'> [key_name_admin(user)] granted all [regions] accesses. </font>")
			return TRUE
		if("PRG_denyregion")
			if(!authenticated || !target_id_card)
				return

			var/region = params["region"]
			if(!region)
				return
			if(region == "Faction (IFF system)")
				target_id_card.faction_group -= faction
				log_idmod(target_id_card, "<font color='red'> [key_name_admin(user)] revoked [faction] IFF. </font>")
				return TRUE

			var/regions[] = console_faction.get_faction_regions(faction)

			target_id_card.access -= regions[region]
			log_idmod(target_id_card, "<font color='red'> [key_name_admin(user)] revoked all [region] accesses. </font>")
			return TRUE
		if("PRG_account")
			if(!authenticated || !target_id_card)
				return

			var/account = text2num(params["account"])
			target_id_card.associated_account_number = account
			log_idmod(target_id_card, "<font color='orange'> [key_name_admin(user)] changed the account number to '[account]'. </font>")
			return TRUE

/obj/structure/machinery/computer/card/ui_static_data(mob/user)
	var/list/data = list()
	data["station_name"] = location || station_name
	data["manifest"] = GLOB.data_core.get_manifest(FALSE, FALSE, TRUE)

	var/datum/faction/console_faction = get_faction(faction)
	var/departments[] = console_faction.get_faction_departments(faction)

	data["jobs"] = list()
	for(var/department in departments)
		var/job_list[] = departments[department]
		var/department_jobs[0]
		for(var/job in job_list)
			department_jobs += list(list(
				"display_name" = replacetext(job, "&nbsp", " "),
				"job" = job
			))
		if(length(department_jobs))
			data["jobs"][department] = department_jobs


	var/faction_regions[] = console_faction.get_faction_regions(faction)
	var/regions[0] //This is the list that's going to the tgui menu.
	var/access_desc
	var/iterate = 1
	for(var/region_name in faction_regions) //Iterate through the main list of regions.
		var/accesses[0]
		for(var/access in faction_regions[region_name]) //Iterate inside the sublists, it should only list the access numbers.
			access_desc = get_access_desc(access) //Grab this so we don't roll the proc twice.
			if(access_desc)
				accesses += list(list(
					"desc" = replacetext(access_desc, "&nbsp", " "),//regions is a string identifier.
					"ref" = access,//Access should be a number, all things being well and good.
				))

		regions += list(list(
			"name" = region_name,
			"regid" = iterate,
			"accesses" = accesses
		))
		iterate++

	// Factions goes here
	if(target_id_card && target_id_card.faction_group && isnull(target_id_card.faction_group))
		target_id_card.faction_group = list()
	var/localfactions[0]

	//This is some really confusing listception. I'm theorizing here that it is wrapped like a taco to pass it as an array, not an object.
	localfactions += list(list(
		"desc" = console_faction.faction_tag,//Want the main faction tag, not the faction on the machine. The main faction is our primary IFF signal.
		"ref" = console_faction.faction_tag,
	))

	regions += list(list(
		"name" = "Faction (IFF system)",
		"regid" = "Faction (IFF system)",
		"accesses" = localfactions
	))

	data["regions"] = regions

	return data

/obj/structure/machinery/computer/card/ui_data(mob/user)
	var/list/data = list()

	data["station_name"] = location || station_name
	data["authenticated"] = authenticated

	data["has_id"] = !!target_id_card
	data["id_name"] = target_id_card ? target_id_card.name : "-----"
	if(target_id_card)
		data["id_rank"] = target_id_card.assignment ? target_id_card.assignment : "Unassigned"
		data["id_owner"] = target_id_card.registered_name ? target_id_card.registered_name : "-----"
		data["access_on_card"] = target_id_card.access + target_id_card.faction_group
		data["id_account"] = target_id_card.associated_account_number

	return data

/obj/structure/machinery/computer/card/attackby(obj/O, mob/user)
	if(istype(O, /obj/item/card/id))
		if(!operable())
			to_chat(user, SPAN_NOTICE("You tried to inject \the [O] but \the [src] remains silent."))
			return
		var/obj/item/card/id/idcard = O
		if(check_access(idcard))
			if(!user_id_card)
				if(user.drop_held_item())
					O.forceMove(src)
					user_id_card = O
				authenticate(user, user_id_card)
			else if(!target_id_card)
				if(user.drop_held_item())
					O.forceMove(src)
					target_id_card = O
					update_static_data(user)
					visible_message("[SPAN_BOLD("[src]")] states, \"CARD FOUND: Preparing ID modification protocol.\"")
			else
				to_chat(user, "Both slots are full already. Remove a card first.")
		else
			if(!target_id_card)
				if(user.drop_held_item())
					O.forceMove(src)
					target_id_card = O
					update_static_data(user)
					visible_message("[SPAN_BOLD("[src]")] states, \"CARD FOUND: Preparing ID modification protocol.\"")
			else
				to_chat(user, "Both slots are full already. Remove a card first.")
	else
		..()

/obj/structure/machinery/computer/card/attack_remote(mob/user as mob)
	return attack_hand(user)

/obj/structure/machinery/computer/card/bullet_act()
	return 0

/obj/structure/machinery/computer/card/verb/eject_id()
	set category = "Object"
	set name = "Eject ID Card"
	set src in oview(1)

	if(!usr || usr.is_mob_incapacitated()) return

	if(user_id_card)
		user_id_card.loc = get_turf(src)
		if(!usr.get_active_hand() && istype(usr,/mob/living/carbon/human))
			usr.put_in_hands(user_id_card)
		if(operable()) // Powered. Console can response.
			visible_message("[SPAN_BOLD("[src]")] states, \"AUTH LOGOUT: Session end confirmed.\"")
		else
			to_chat(usr, "You remove \the [user_id_card] from \the [src].")
		authenticated = FALSE // No card - no access
		user_id_card = null

	else if(target_id_card)
		target_id_card.loc = get_turf(src)
		if(!usr.get_active_hand() && istype(usr,/mob/living/carbon/human))
			usr.put_in_hands(target_id_card)
		if(operable()) // Powered. Make comp proceed ejection
			GLOB.data_core.manifest_modify(target_id_card.registered_name, target_id_card.registered_ref, target_id_card.assignment, target_id_card.rank)
			target_id_card.name = text("[target_id_card.registered_name]'s [target_id_card.card_name] ([target_id_card.assignment])")
			visible_message("[SPAN_BOLD("[src]")] states, \"CARD EJECT: Data imprinted. Updating database... Success.\"")
		else
			to_chat(usr, "You remove \the [target_id_card] from \the [src].")
		target_id_card = null

	else
		to_chat(usr, "There is nothing to remove from the console.")
	return

/obj/structure/machinery/computer/card/attack_hand(mob/user as mob)
	if(..())
		return
	if(inoperable())
		return
	user.set_interaction(src)
	tgui_interact(user)

/obj/structure/machinery/computer/card/uscm_ground
	dir = NORTH
	faction = FACTION_USCM_GROUND
	location = "USCM Outpost 29"
	req_access = list(ACCESS_USCM_GROUND_COMMAND)

/obj/structure/machinery/computer/card/wy
	faction = FACTION_WY
	location = "WY Regional Office"
	req_access = list(ACCESS_WY_LEADERSHIP)

//This console changes a marine's squad. It's very simple.
//It also does not: change or increment the squad count (used in the login randomizer), nor does it check for jobs.
//Which means you could get sillyiness like "Alpha Sulaco Chief Medical Officer" or "Delta Logistics Officer".
//But in the long run it's not really a big deal.

/obj/structure/machinery/computer/squad_changer
	name = "squad distribution computer"
	desc = "You can use this to change someone's squad."
	icon_state = "guest"
	req_access = list(ACCESS_MARINE_DATABASE)
	var/obj/item/card/id/ID_to_modify = null
	var/mob/living/carbon/human/person_to_modify = null
	var/faction = FACTION_MARINE

/obj/structure/machinery/computer/squad_changer/verb/eject_id()
	set category = "Object"
	set name = "Eject ID Card"
	set src in view(1)

	if(!usr || usr.is_mob_incapacitated()) return

	if(ishuman(usr) && ID_to_modify)
		to_chat(usr, "You remove \the [ID_to_modify] from \the [src].")
		ID_to_modify.forceMove(get_turf(src))
		if(!usr.get_active_hand() && istype(usr,/mob/living/carbon/human))
			usr.put_in_hands(ID_to_modify)
		ID_to_modify = null
		person_to_modify = null
	else
		to_chat(usr, "There is nothing to remove from \the [src].")
	return

/obj/structure/machinery/computer/squad_changer/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "SquadMod", name)
		ui.open()

/obj/structure/machinery/computer/squad_changer/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/user = usr

	// Please stay close, marine
	if(person_to_modify && !(person_to_modify.Adjacent(src)))
		person_to_modify = null

	playsound(src, pick('sound/machines/computer_typing4.ogg', 'sound/machines/computer_typing5.ogg', 'sound/machines/computer_typing6.ogg'), 5, 1)
	switch(action)
		if("PRG_eject")
			if(ID_to_modify)
				if(ishuman(user))
					ID_to_modify.forceMove(user.loc)
					if(!user.get_active_hand())
						user.put_in_hands(ID_to_modify)
					ID_to_modify = null
				else
					ID_to_modify.forceMove(loc)
					ID_to_modify = null
				visible_message("[SPAN_BOLD("[src]")] states, \"CARD EJECT: ID modification protocol disabled.\"")
				return TRUE
			else
				var/obj/item/I = user.get_active_hand()
				if (istype(I, /obj/item/card/id))
					if(user.drop_held_item())
						I.forceMove(src)
						ID_to_modify = I
						visible_message("[SPAN_BOLD("[src]")] states, \"CARD FOUND: Preparing ID modification protocol.\"")
						return TRUE
		if("PRG_squad")
			if(
				istype(ID_to_modify) && istype(person_to_modify) && \
				person_to_modify.skills.get_skill_level(SKILL_FIREARMS) && \
				person_to_modify.real_name == ID_to_modify.registered_name && \
				person_to_modify.Adjacent(src)
			)
				var/datum/squad/selected = get_squad_by_name(params["name"])
				if(!selected)
					return
				if(RoleAuthority.check_squad_capacity(person_to_modify, selected))
					visible_message("[SPAN_BOLD("[src]")] states, \"CAPACITY ERROR: [selected] can't have another [person_to_modify.job].\"")
					return TRUE
				if(transfer_marine_to_squad(person_to_modify, selected, person_to_modify.assigned_squad, ID_to_modify))
					visible_message("[SPAN_BOLD("[src]")] states, \"DATABASE LOG: [person_to_modify] was assigned to [selected] Squad.\"")
					return TRUE
				else
					visible_message("[SPAN_BOLD("[src]")] states, \"DATABASE ERROR: There was an error assigning [person_to_modify] to [selected] Squad.\"")
			else if(!istype(ID_to_modify))
				to_chat(usr, SPAN_WARNING("You need to insert a card to modify."))
			else if(!istype(person_to_modify) || !person_to_modify.Adjacent(src))
				visible_message("[SPAN_BOLD("[src]")] states, \"SCANNER ERROR: You need to keep the hand of the person to be assigned to Squad!\"")
			else if(!person_to_modify.skills.get_skill_level(SKILL_FIREARMS))
				visible_message("[SPAN_BOLD("[src]")] states, \"QUALIFICATION ERROR: You cannot assign untrained civilians to squads!\"")
			else
				visible_message("[SPAN_BOLD("[src]")] states, \"ID ERROR: The ID in the machine is not owned by the person whose hand is scanned!\"")
			return TRUE

/obj/structure/machinery/computer/squad_changer/ui_data(mob/user)
	// Please stay close, marine
	if(person_to_modify && !(person_to_modify.Adjacent(src)))
		person_to_modify = null
	var/list/data = list()
	if(person_to_modify)
		data["human"] = person_to_modify.name
	else
		data["human"] = null
	data["id_name"] = ID_to_modify ? ID_to_modify.name : "-----"
	data["has_id"] = !!ID_to_modify
	return data

/obj/structure/machinery/computer/squad_changer/ui_static_data(mob/user)
	var/list/data = list()
	var/list/squads = list()
	for(var/datum/squad/current_squad in RoleAuthority.squads)
		if(current_squad.name != "Root" && !current_squad.locked && current_squad.active && current_squad.faction == faction)
			var/list/squad = list(list(
				"name" = current_squad.name,
				"color" = current_squad.equipment_color
			))
			squads += squad
	data["squads"] = squads
	return data

/obj/structure/machinery/computer/squad_changer/attackby(obj/O as obj, mob/user as mob)
	if(user)
		add_fingerprint(user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(istype(O, /obj/item/card/id))
			if(!operable())
				to_chat(usr, SPAN_NOTICE("You tried to insert [O] but \the [src] remains silent."))
				return
			var/obj/item/card/id/idcard = O
			if(!ID_to_modify)
				H.drop_held_item()
				idcard.forceMove(src)
				ID_to_modify = idcard
				visible_message("[SPAN_BOLD("[src]")] states, \"CARD FOUND: Preparing ID modification protocol.\"")
			else
				to_chat(H, SPAN_NOTICE("Remove the inserted card first."))
		else if(istype(O, /obj/item/grab))
			var/obj/item/grab/G = O
			if(ismob(G.grabbed_thing))
				if(!operable())
					to_chat(usr, SPAN_NOTICE("You place [G.grabbed_thing]'s hand on scanner but \the [src] remains silent."))
					return
				var/isxenos = isxeno(G.grabbed_thing)
				H.visible_message(SPAN_NOTICE("You hear a beep as [G.grabbed_thing]'s [isxenos ? "limb" : "hand"] is scanned to \the [name]."))
				visible_message("[SPAN_BOLD("[src]")] states, \"SCAN ENTRY: [isxenos ? "Unknown lifeform detected! Forbidden operation!" : "Scanned, please stay close until operation's end."]\"")
				playsound(H.loc, 'sound/machines/screen_output1.ogg', 25, 1)
				// No Xeno Squads, please!
				if(!isxenos)
					person_to_modify = G.grabbed_thing
	else
		..()


/obj/structure/machinery/computer/squad_changer/attack_remote(mob/user as mob)
	return attack_hand(user)

/obj/structure/machinery/computer/squad_changer/bullet_act()
	return 0

/obj/structure/machinery/computer/squad_changer/attack_hand(mob/user as mob)
	if(..())
		return
	if(user)
		add_fingerprint(user)

	usr.set_interaction(src)
	if(!operable())
		return
	if(allowed(user))
		tgui_interact(user)
	else
		var/isxenos = isxeno(user)
		user.visible_message(SPAN_NOTICE("You hear a beep as [user]'s [isxenos ? "limb" : "hand"] is scanned to \the [name]."))
		visible_message("[SPAN_BOLD("[src]")] states, \"SCAN ENTRY: [isxenos ? "Unknown lifeform detected! Forbidden operation!" : "Scanned, please stay close until operation's end."]\"")
		playsound(user.loc, 'sound/machines/screen_output1.ogg', 25, 1)
		// No Xeno Squads, please!
		if(!isxenos)
			person_to_modify = user

/obj/structure/machinery/computer/squad_changer/uscm_ground
	dir = NORTH
	faction = FACTION_USCM_GROUND
	req_access = list(ACCESS_USCM_GROUND_COMMAND)


/// How often the sensor data is updated
#define SENSORS_UPDATE_PERIOD 10 SECONDS //How often the sensor data updates.
/// The job sorting ID associated with otherwise unknown jobs
#define UNKNOWN_JOB_ID 998

/obj/structure/machinery/computer/crew
	name = "crew monitoring computer"
	desc = "Used to monitor active health sensors built into the wearer's uniform.  You can see that the console highlights ship areas with BLUE and remote locations with RED."
	icon_state = "crew"
	circuit = /obj/item/circuitboard/computer/crew
	density = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 250
	active_power_usage = 500
	var/faction = FACTION_MARINE
	/// What type of /datum/crewmonitor this will create
	var/crewmonitor_type = /datum/crewmonitor

/obj/structure/machinery/computer/crew/Initialize()
	. = ..()
	if(!GLOB.crewmonitor[faction])
		GLOB.crewmonitor[faction] = new crewmonitor_type(faction)

/obj/structure/machinery/computer/crew/attack_remote(mob/living/user)
	attack_hand(user)

/obj/structure/machinery/computer/crew/attack_hand(mob/living/user)
	if(!isRemoteControlling(user))
		add_fingerprint(user)
	if(inoperable())
		return
	user.set_interaction(src)
	GLOB.crewmonitor[faction].show(user, src)

/obj/structure/machinery/computer/crew/update_icon()
	if(stat & BROKEN)
		icon_state = "crewb"
	else
		if(stat & NOPOWER)
			icon_state = "crew0"
			stat |= NOPOWER
		else
			icon_state = initial(icon_state)
			stat &= ~NOPOWER

/obj/structure/machinery/computer/crew/interact(mob/living/user)
	GLOB.crewmonitor[faction].show(user, src)

/obj/structure/machinery/computer/crew/alt
	icon_state = "cmonitor"
	density = FALSE

/obj/structure/machinery/computer/crew/alt/yautja
	name = "\improper Yautja health monitor"
	desc = "Used to monitor active health sensors of all Yautja in the system. You can see that the console highlights the human's ship areas with BLUE and the hunting locations with RED."
	faction = FACTION_YAUTJA
	crewmonitor_type = /datum/crewmonitor/yautja

/obj/structure/machinery/computer/crew/uscm_ground
	icon_state = "cmonitor"
	faction = FACTION_USCM_GROUND
	req_access = list(ACCESS_USCM_GROUND_GENERAL)

/obj/structure/machinery/computer/crew/upp
	faction = FACTION_UPP

/obj/structure/machinery/computer/crew/clf
	faction = FACTION_CLF

/obj/structure/machinery/computer/crew/pmc
	faction = FACTION_PMC

/obj/structure/machinery/computer/crew/colony
	faction = FACTION_COLONIST

/obj/structure/machinery/computer/crew/yautja
	faction = FACTION_YAUTJA

GLOBAL_LIST_EMPTY_TYPED(crewmonitor, /datum/crewmonitor)

#define SENSOR_LIVING 1
#define SENSOR_VITALS 2
#define SENSOR_COORDS 3
/// This is a really hacky way to make SOF work, but the nice and easy alternative would screw with round spawning
#define RAIDER_OFFICER_SQUAD "SOF [JOB_MARINE_RAIDER_CMD]"
#define RAIDER_SL_SQUAD "SOF [JOB_MARINE_RAIDER_SL]"
#define RAIDER_SQUAD "SOF [JOB_MARINE_RAIDER]"

/datum/crewmonitor
	/// List of user -> UI source
	var/list/ui_sources = list()
	/// Cache of data generated, used for serving the data within SENSOR_UPDATE_PERIOD of the last update
	var/list/data = list()
	/// Cache of last update time
	var/last_update
	/// Map of job to ID for sorting purposes
	var/list/jobs
	var/faction = FACTION_MARINE

/datum/crewmonitor/New(set_faction = FACTION_MARINE)
	..()
	faction = set_faction
	setup_for_faction(faction)

/datum/crewmonitor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CrewConsole")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/crewmonitor/proc/show(mob/M, source)
	if(!ui_sources.len)
		START_PROCESSING(SSprocessing, src)
	ui_sources[M] = source
	tgui_interact(M)

/datum/crewmonitor/process()
	if(data && last_update && world.time <= last_update + SENSORS_UPDATE_PERIOD)
		return
	update_data()
	// Update active users UI
	for(var/H in ui_sources)
		var/datum/tgui/ui = SStgui.try_update_ui(H, src)
		if(!ui) // What are you doing in list?
			ui_sources -= H

/datum/crewmonitor/ui_close(mob/M)
	. = ..()
	ui_sources -= M
	if(!ui_sources.len)
		STOP_PROCESSING(SSprocessing, src)

/datum/crewmonitor/ui_host(mob/user)
	return ui_sources[user]

/datum/crewmonitor/ui_data(mob/user)
	. = list(
		"sensors" = update_data(),
		"link_allowed" = isAI(user),
	)

/datum/crewmonitor/proc/update_data()
	var/list/results = list()
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		// Predators
		if(isyautja(H))
			continue
		// Check for a uniform
		var/obj/item/clothing/under/C = H.w_uniform
		if(!C || !istype(C))
			continue
		// Check that sensors are present and active
		if(!C.has_sensor || !C.sensor_mode || !(faction in H.faction_group))
			continue

		// Check if z-level is correct
		var/turf/pos = get_turf(H)
		if(!pos)
			continue
		if(is_admin_level(pos.z))
			continue

		// The entry for this human
		var/list/entry = list(
			"ref" = REF(H),
			"name" = "Unknown",
			"ijob" = UNKNOWN_JOB_ID
		)

		// ID and id-related data
		var/obj/item/card/id/id_card = H.get_idcard()
		if (id_card)
			entry["name"] = id_card.registered_name
			entry["assignment"] = id_card.assignment
			if(id_card.assignment in jobs)
				entry["ijob"] = jobs[id_card.assignment]

		// Binary living/dead status
		if (C.sensor_mode >= SENSOR_LIVING)
			entry["life_status"] = !H.stat

		// Damage
		if (C.sensor_mode >= SENSOR_VITALS)
			entry += list(
				"oxydam" = round(H.getOxyLoss(), 1),
				"toxdam" = round(H.getToxLoss(), 1),
				"burndam" = round(H.getFireLoss(), 1),
				"brutedam" = round(H.getBruteLoss(), 1)
			)

		// Location
		if (C.sensor_mode >= SENSOR_COORDS)
			if(is_mainship_level(pos.z))
				entry["side"] = "Almayer"
			var/area/A = get_area(H)
			entry["area"] = sanitize_area(A.name)

		// Trackability
		entry["can_track"] = H.detectable_by_ai()

		results[++results.len] = entry

	// Cache result
	data = results
	last_update = world.time

	return results

/datum/crewmonitor/ui_act(action,params)
	. = ..()
	if(.)
		return
	switch (action)
		if ("select_person")
			// May work badly cause currently there is no player-controlled AI
			var/mob/living/silicon/ai/AI = usr
			if(!istype(AI))
				return
			var/mob/living/carbon/human/H
			for(var/entry in data)
				if(entry["name"] == params["name"])
					H = locate(entry["ref"])
					break
			if(!H) // Sanity check
				to_chat(AI, SPAN_NOTICE("ERROR: unable to track subject with ID '[params["name"]]'"))
			else
				// We do not care is there camera or no - we just know his location
				AI.ai_actual_track(H)

/datum/crewmonitor/proc/setup_for_faction(set_faction = FACTION_MARINE)
	switch(set_faction)
		if(FACTION_MARINE)
			jobs = list(
				// Note that jobs divisible by 10 are considered heads of staff, and bolded
				// 00-09: High Command, defined at bottom
				JOB_CMC = 00,//Grade O10
				JOB_ACMC = 00,
				JOB_PROVOST_CMARSHAL = 00,
				JOB_GENERAL = 00,
				JOB_PROVOST_SMARSHAL = 01,//Grade O9
				JOB_PROVOST_MARSHAL = 02,//Grade O8
				JOB_COLONEL = 04,//Grade O6
				JOB_PROVOST_INSPECTOR = 04,
				// 10-19: Command
				JOB_CO = 10,
				JOB_XO = 11,
				JOB_MARINE_RAIDER_CMD = 11,
				RAIDER_OFFICER_SQUAD = 11,
				JOB_SO = 12,
				JOB_SEA = 13,
				// 20-29: Aux Command
				JOB_AUXILIARY_OFFICER = 20,
				JOB_SYNTH = 21,
				JOB_PILOT = 22,
				JOB_DROPSHIP_CREW_CHIEF = 23,
				JOB_INTEL = 24,
				// 30-39: Security
				JOB_CHIEF_POLICE = 30,
				JOB_PROVOST_TML = 30,
				JOB_WARDEN = 31,
				JOB_PROVOST_ENFORCER = 31,
				JOB_RIOT_CHIEF = 32,
				JOB_RIOT = 33,
				JOB_POLICE = 34,
				JOB_PROVOST_ADVISOR = 35,
				// 40-49: MedSci
				JOB_CMO = 40,
				JOB_RESEARCHER = 41,
				JOB_DOCTOR = 42,
				JOB_SURGEON = 42,
				JOB_NURSE = 43,
				// 50-59: Engineering
				JOB_CHIEF_ENGINEER = 50,
				JOB_ORDNANCE_TECH = 51,
				JOB_MAINT_TECH = 52,
				// 60-69: Cargo
				JOB_CHIEF_REQUISITION = 60,
				JOB_CARGO_TECH = 61,
				JOB_MESS_SERGEANT = 62,
				// 70-139: SQUADS (look below)
				// 140+: Civilian/other
				JOB_CORPORATE_LIAISON = 240,
				JOB_PASSENGER = 241,
				// Non Almayer jobs lower then registered
				JOB_SYNTH_SURVIVOR = 250,
				JOB_SURVIVOR = 251,
				JOB_COLONIST = 252,
				JOB_WORKING_JOE = 253,

				// WO jobs
				// 10-19: Command
				JOB_WO_CO = 10,
				JOB_WO_XO = 11,
				// 20-29: Aux Command
				JOB_WO_CHIEF_POLICE = 20,
				JOB_WO_SO = 21,
				// 30-39: Security
				JOB_WO_CREWMAN = 30,
				JOB_WO_POLICE = 31,
				JOB_WO_PILOT = 32,
				// 40-49: MedSci
				JOB_WO_CMO = 40,
				JOB_WO_RESEARCHER = 41,
				JOB_WO_DOCTOR = 42,
				// 50-59: Engineering
				JOB_WO_CHIEF_ENGINEER = 50,
				JOB_WO_ORDNANCE_TECH = 51,
				// 60-69: Cargo
				JOB_WO_CHIEF_REQUISITION = 60,
				JOB_WO_REQUISITION = 61,
				// 70-139: SQUADS (look below)
				// 140+: Civilian/other
				JOB_WO_CORPORATE_LIAISON = 240,
				JOB_WO_SYNTH = 250,

				// ANYTHING ELSE = UNKNOWN_JOB_ID, Unknowns/custom jobs will appear after civilians, and before stowaways
				JOB_STOWAWAY = 999,

				// 200-229: Visitors
				JOB_UPP_REPRESENTATIVE = 301,
				JOB_TWE_REPRESENTATIVE = 301,
				JOB_TIS_SA = 310,
				JOB_TIS_IO = 311,
				JOB_PMC_DIRECTOR = 320,
				JOB_PMC_LEADER = 320,
				JOB_PMC_LEAD_INVEST = 320,
				JOB_PMC_SYNTH = 321,
				JOB_PMC_XENO_HANDLER = 321,
				JOB_PMC_SNIPER = 322,
				JOB_PMC_GUNNER = 323,
				JOB_PMC_MEDIC = 324,
				JOB_PMC_INVESTIGATOR = 324,
				JOB_PMC_ENGINEER = 325,
				JOB_PMC_STANDARD = 326,
				JOB_PMC_DOCTOR = 327,
				JOB_WY_GOON_LEAD = 328,
				JOB_WY_GOON = 329,

				// Appear at bottom of squad list
				JOB_MARINE_RAIDER_SL = 130,
				RAIDER_SL_SQUAD = 130,
				JOB_MARINE_RAIDER = 131,
				RAIDER_SQUAD = 131,
			)
			//This adds squads to the selector, I've expanded squad numbers from 70 to 240. 70 to 130 are Almayer, then the raiders, then the two Outpost squads, ending at 150-159 presently.
			//This sets up the proper squad colors.
			var/squad_number = 70
			for(var/squad_name in ROLES_SQUAD_ALL)
				if(squad_number >= 130)
					break //Only the Almayer squads, 70 - 130
				jobs += list(
					"[squad_name][JOB_SQUAD_LEADER]" = (squad_number),
					"[squad_name][JOB_SQUAD_TEAM_LEADER]" = (squad_number + 1),
					"[squad_name][JOB_SQUAD_SPECIALIST]" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Scout" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Sniper" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Demo" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Grenadier" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Pyro" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SMARTGUN]" = (squad_number + 3),
					"[squad_name][JOB_SQUAD_ENGI]" = (squad_number + 4),
					"[squad_name][JOB_SQUAD_MEDIC]" = (squad_number + 5),
					"[squad_name][JOB_SQUAD_MARINE]" = (squad_number + 6),
				)
				squad_number += 10
		if(FACTION_WY, FACTION_PMC)
			jobs = list(
				// Note that jobs divisible by 10 are considered heads of staff, and bolded
				// 00-09: High Command
				JOB_DIRECTOR = 00,
				JOB_CHIEF_EXECUTIVE = 01,
				// 10-19: Command Level Staff
				JOB_PMC_DIRECTOR = 10,
				JOB_DIVISION_MANAGER = 10,
				JOB_ASSISTANT_MANAGER = 11,
				// 20-29: Corporate Staff
				JOB_EXECUTIVE_SUPERVISOR = 20,
				JOB_SENIOR_EXECUTIVE = 21,
				JOB_EXECUTIVE_SPECIALIST = 22,
				JOB_EXECUTIVE = 23,
				JOB_JUNIOR_EXECUTIVE = 24,
				// 30-39: Security
				JOB_WY_GOON_LEAD = 30,
				JOB_WY_GOON = 31,
				// 40-49: MedSci
				JOB_PMC_SYNTH = 40,
				JOB_PMC_XENO_HANDLER = 41,
				JOB_PMC_DOCTOR = 42,
				JOB_WY_GOON_RESEARCHER = 43,
				// 50-59: Engineering & Vehicle Crew
				JOB_PMC_CREWMAN = 51,
				JOB_PMC_ENGINEER = 52,
				// 60-69: Investigation Team
				JOB_PMC_LEAD_INVEST = 60,
				JOB_PMC_INVESTIGATOR = 61,
				JOB_PMC_DETAINER = 62,

				// 70-79 PMCs Combat Team
				JOB_PMC_LEADER = 70,
				JOB_PMC_SNIPER = 71,
				JOB_PMC_GUNNER = 72,
				JOB_PMC_MEDIC = 73,
				JOB_PMC_STANDARD = 75,

				// ANYTHING ELSE = UNKNOWN_JOB_ID, Unknowns/custom jobs will appear after civilians, and before stowaways
				JOB_STOWAWAY = 999,

				// 200-229: Visitors
				JOB_UPP_REPRESENTATIVE = 301,
				JOB_TWE_REPRESENTATIVE = 301,
				JOB_COLONEL = 301,
				JOB_TRAINEE = 302, //Trainees aren't really cared about
			)
		if(FACTION_UPP)
			jobs = list(
				// Note that jobs divisible by 10 are considered heads of staff, and bolded
				// 00-09: High Command
				JOB_UPP_KOL_OFFICER = 00,
				// 10-19: Command Team
				JOB_UPP_MAY_OFFICER = 10,
				JOB_UPP_KPT_OFFICER = 11,
				JOB_UPP_SRLT_OFFICER = 13,
				JOB_UPP_LT_OFFICER = 14,
				// 20-29: Commandos
				JOB_UPP_COMMANDO_LEADER = 20,
				JOB_UPP_COMMANDO_MEDIC = 21,
				JOB_UPP_COMMANDO = 22,
				// 30-39: Security
				JOB_UPP_POLICE = 31,
				// 40-49: MedSci
				JOB_UPP_LT_DOKTOR = 41,
				// 50-59: Engineering
				JOB_UPP_COMBAT_SYNTH = 50,
				JOB_UPP_CREWMAN = 51,
				// 70-69: Soldiers //Was 60 previously, which cargo colors.
				JOB_UPP_LEADER = 70,
				JOB_UPP_SPECIALIST = 71,
				JOB_UPP_MEDIC = 72,
				JOB_UPP_ENGI = 73,
				JOB_UPP = 74,
				JOB_UPP_CONSCRIPT = 75,

				// ANYTHING ELSE = UNKNOWN_JOB_ID, Unknowns/custom jobs will appear after civilians, and before stowaways
				JOB_STOWAWAY = 999,

				// 200-229: Visitors
				JOB_UPP_REPRESENTATIVE = 301,
				JOB_TWE_REPRESENTATIVE = 301,
				JOB_COLONEL = 301
			)
		if(FACTION_USCM_GROUND)
			jobs = list(
				//We want to keep the high command list; they should still appear here.
				JOB_CMC = 00,//Grade O10
				JOB_ACMC = 00,
				JOB_PROVOST_CMARSHAL = 00,
				JOB_GENERAL = 00,
				JOB_PROVOST_SMARSHAL = 01,//Grade O9
				JOB_PROVOST_MARSHAL = 02,//Grade O8
				JOB_COLONEL = 04,//Grade O6
				JOB_PROVOST_INSPECTOR = 04,

				JOB_USCM_GROUND_CO = 10,
				JOB_CO = 11,
				JOB_XO = 12,
				JOB_MARINE_RAIDER_CMD = 13,
				RAIDER_OFFICER_SQUAD = 14,
				"Adjunct Officer" = 20,

				JOB_USCM_GROUND_CIVILIAN = 240,
				"Maintenance Synthetic" = 250,

				JOB_STOWAWAY = 999,

				// 200-229: Visitors, includes other USCM ranking officers. Subject to change.
				JOB_UPP_REPRESENTATIVE = 301,
				JOB_TWE_REPRESENTATIVE = 301,
				JOB_PMC_DIRECTOR = 320,
				JOB_PMC_LEAD_INVEST = 320,
			)
			var/squad_number = 140 //Squad colors 140 to 159 are USCM Ground.
			for(var/squad_name in ROLES_SQUAD_USCM_GROUND)
				squad_name += " "
				jobs += list(
					"[squad_name][JOB_SQUAD_LEADER]" = (squad_number),
					"[squad_name][JOB_SQUAD_TEAM_LEADER]" = (squad_number + 1),
					"[squad_name][JOB_SQUAD_SPECIALIST]" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Heavy" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SPECIALIST]: Sapper" = (squad_number + 2),
					"[squad_name][JOB_SQUAD_SMARTGUN]" = (squad_number + 3),
					"[squad_name][JOB_SQUAD_MEDIC]" = (squad_number + 4),
					"[squad_name][JOB_SQUAD_MARINE]" = (squad_number + 5),
				)
				squad_number += 10

		else
			jobs = list()

/datum/crewmonitor/yautja
	faction = FACTION_YAUTJA

/datum/crewmonitor/yautja/update_data()
	var/list/results = list()
	for(var/mob/living/carbon/human/human_mob as anything in GLOB.human_mob_list)

		if(!isyautja(human_mob))
			continue

		if(faction != human_mob.faction)
			continue

		// Check if z-level is correct
		var/turf/pos = get_turf(human_mob)
		if(!pos)
			continue

		// The entry for this human
		var/list/entry = list(
			"ref" = REF(human_mob),
			"name" = human_mob.real_name,
			"ijob" = UNKNOWN_JOB_ID,
			"assignment" = "Hunter",
			"oxydam" = round(human_mob.getOxyLoss(), 1),
			"toxdam" = round(human_mob.getToxLoss(), 1),
			"burndam" = round(human_mob.getFireLoss(), 1),
			"brutedam" = round(human_mob.getBruteLoss(), 1),
			"can_track" = TRUE,
		)

		if(is_mainship_level(pos.z))
			entry["side"] = "Almayer"

		var/area/mob_area = get_area(human_mob)
		entry["area"] = sanitize_area(mob_area.name)

		results[++results.len] = entry

	// Cache result
	data = results
	last_update = world.time

	return results

#undef SENSOR_LIVING
#undef SENSOR_VITALS
#undef SENSOR_COORDS
#undef SENSORS_UPDATE_PERIOD
#undef UNKNOWN_JOB_ID
#undef RAIDER_SQUAD
#undef RAIDER_SL_SQUAD
#undef RAIDER_OFFICER_SQUAD
