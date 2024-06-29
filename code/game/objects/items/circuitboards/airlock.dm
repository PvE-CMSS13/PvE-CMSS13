
/obj/item/circuitboard/airlock
	name = "airlock electronics"
	gender = PLURAL
	icon_state = "door_electronics"
	w_class = SIZE_SMALL
	matter = list("metal" = 50,"glass" = 50)
	var/list/conf_access
	/// TRUE to set req_one_access instead of req_access
	var/one_access = FALSE
	var/fried = FALSE

/obj/item/circuitboard/airlock/update_icon()
	. = ..()
	if(fried)
		icon_state = "door_electronics_smoked"

/obj/item/circuitboard/airlock/attack_self(mob/user as mob)
	if (!ishuman(user) && !istype(user,/mob/living/silicon/robot))
		return ..(user)

	var/mob/living/carbon/human/H = user
	if(H.getBrainLoss() >= 60)
		return

	var/engineering_skill = user.skills.get_skill_level(SKILL_ENGINEER)
	if(engineering_skill <= SKILL_UNSKILLED) //No engineering skill or they don't have the datum.
		to_chat(user, SPAN_WARNING("You have no idea what to do with this."))
		return

	if(!conf_access) conf_access = list()

	/*
	I gave this deep thought. How does one know the access codes to configure?
	The board isn't preconfigured, so it would need to be programmed in by the user.
	At least for gameplay purposes of constructing new doors, we need to specify the codes.
	How does the user know which codes to configure then? It wouldn't come from their ID, as ID access
	can easily change during the game. The user must have the knowledge of access codes,
	so clearly it would require some mind variable. Ie, the user's memory of what codes they actually
	know how to program in.

	I decided to simplify that; engineering 1 is for the main faction access codes. Engineering 2 and above
	is all access codes for the faction. Maybe in the future that can be expanded to be more granular.

	Also, I got rid of the access requirements as they don't really make sense with this system. You're
	programming a board, not trying to crack some kind of harddrive.
	*/

	var/datum/faction/user_faction = get_faction(user.faction)
	var/accesses[] = user_faction.get_faction_access(user.faction, (engineering_skill > SKILL_ENGINEER_TRAINED)) //Retrieves the main or full list. TRUE or FALSE on the second statement.
	var/unknown_access[] = conf_access - accesses //Gives us a list of access levels we do not know. In case that is true.

	var/t1
	var/aname

	//These colors are ugly as sin, but it's fine.
	t1 += "Access requirement is set to "
	t1 += one_access ? "<a style='color: green' href='?src=\ref[src];command=one_access'>ONE</a><hr>" : "<a style='color: red' href='?src=\ref[src];command=one_access'>ALL</a><hr>"
	t1 += "<br>"
	if(length(conf_access))
		if(length(unknown_access)) t1 += SPAN_RED("Uknown access codes detected.<br>") //Got some unknowns.
		t1 += "<a href='?src=\ref[src];command=clear_memory;engineering_skill=[engineering_skill]'>Clear Memory</a><hr>" //Can always clear the memory, but it takes a moment.

	for (var/acc in accesses)
		aname = get_access_desc(acc)

		if (!(acc in conf_access))
			t1 += "<a href='?src=\ref[src];command=toggle_access;access=[acc]'>[aname]</a><br>"
		else t1 += "<a style='color: [one_access? "green" : "red"]' href='?src=\ref[src];command=toggle_access;access=[acc]'>[aname]</a><br>"

	t1 += text("<p><a href='?src=\ref[];command=close'>Close</a></p>\n", src)

	show_browser(user, t1, "Access Control", "airlock_electronics")
	onclose(user, "airlock")

/obj/item/circuitboard/airlock/Topic(href, href_list)
	..()
	if (usr.stat || usr.is_mob_restrained() || (!ishuman(usr) && !istype(usr,/mob/living/silicon)))
		return

	switch(href_list["command"])
		if("close")
			close_browser(usr, "airlock_electronics")
			return
		if("one_access")
			one_access = !one_access

		if("toggle_access")
			toggle_access(href_list["access"])

		if("clear_memory")
			if(!clear_memory(usr, href_list["engineering_skill"])) return FALSE

	attack_self(usr)

/obj/item/circuitboard/airlock/proc/toggle_access(acc)
	var/req = text2num(acc)
	conf_access = (req in conf_access) ? conf_access - req : conf_access + req

/obj/item/circuitboard/airlock/proc/clear_memory(mob/living/user, engineering_skill = SKILL_ENGINEER_TRAINED) //Still need to convert later on if it's properly referenced.
	to_chat(user, SPAN_NOTICE("You will need time to clear the buffer, stand still."))
	if(!do_after(user, (SKILL_ENGINEER_MAX - text2num(engineering_skill) + 0.5) SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))//3.5 seconds - skill level in seconds.
		to_chat(user, SPAN_WARNING("You were interrupted!"))
		return FALSE

	conf_access = list() //We'll make a new list.
	return TRUE
