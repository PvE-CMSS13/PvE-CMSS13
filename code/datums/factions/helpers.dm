GLOBAL_LIST_INIT_TYPED(faction_datums, /datum/faction, setup_faction_list())

/proc/setup_faction_list()
	var/list/faction_datums_list = list()
	var/datum/faction/current_faction
	for(var/T in typesof(/datum/faction))
		current_faction = new T
		if(!current_faction.skip_init) //It will get garbage collected with no references.
			if(current_faction.faction_tag_group) //Would be generated on New() if it has one.
				for(var/i in current_faction.faction_tag_group)
					faction_datums_list[i] = current_faction
			else faction_datums_list[current_faction.faction_tag] = current_faction

	return faction_datums_list

/proc/get_faction(faction = FACTION_MARINE)
	var/datum/faction/referenced_faction = GLOB.faction_datums[faction]
	return referenced_faction || GLOB.faction_datums[FACTION_NEUTRAL]
