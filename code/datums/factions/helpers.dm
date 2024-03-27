GLOBAL_LIST_INIT_TYPED(faction_datums, /datum/faction, setup_faction_list())

/proc/setup_faction_list()
	var/list/faction_datums_list = list()
	var/datum/faction/F
	for(var/T in typesof(/datum/faction))
		F = new T
		if(!F.skip_init) //It will get garbage collected with no references.
			if(F.faction_tag_group) //Would be generated on New() if it has one.
				for(var/i in F.faction_tag_group)
					faction_datums_list[i] = F
			else faction_datums_list[F.faction_tag] = F

	return faction_datums_list

/proc/get_faction(faction = FACTION_MARINE)
	var/datum/faction/F = GLOB.faction_datums[faction]
	return F || GLOB.faction_datums[FACTION_NEUTRAL]
