/datum/squad
	/// Maxium number of standards; anything below 0 means there is no hard cap.
	var/max_riflemen = -1

/datum/squad/marine/charlie
	name = SQUAD_MARINE_3
	equipment_color = "#D99281"
	chat_color = "#965545"
	access = list(ACCESS_MARINE_CHARLIE)
	radio_freq = CHARLIE_FREQ
	minimap_color = MINIMAP_SQUAD_CHARLIE
	usable = TRUE
	max_riflemen = 4
	max_engineers = 1
	max_medics = 1
	max_specialists = 1
	max_tl = 2
	max_smartgun = 2
	max_leaders = 1

/datum/squad/marine/delta
	name = SQUAD_MARINE_4
	equipment_color = "#9FCD61"
	chat_color = "#698740"
	access = list(ACCESS_MARINE_DELTA)
	radio_freq = DELTA_FREQ
	minimap_color = MINIMAP_SQUAD_DELTA
	usable = TRUE
	max_riflemen = 4
	max_engineers = 1
	max_medics = 1
	max_specialists = 1
	max_tl = 2
	max_smartgun = 2
	max_leaders = 1
