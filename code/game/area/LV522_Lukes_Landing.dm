//lv522 AREAS--------------------------------------//

/area/lv522_l_l
	icon_state = "lv-626"
	can_build_special = TRUE
	powernet_name = "LV522_Lukes_Landing"
	minimap_color = MINIMAP_AREA_COLONY

//parent types

/area/lv522_l_l/indoors
	name = "Lukes Landing - Indoors"
	icon_state = "cliff_blocked" //because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	soundscape_playlist = SCAPE_PL_LV522_INDOORS


/area/lv522_l_l/outdoors
	name = "Lukes Landing - Outdoors"
	icon_state = "cliff_blocked" //because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	soundscape_playlist = SCAPE_PL_LV522_OUTDOORS

/area/lv522_l_l/basement
	name = "Lukes Landing - Underground"
	icon_state = "cliff_blocked"
	ceiling = CEILING_REINFORCED_METAL
	powernet_name = "LV522_LL_Colony Underground"

//Colony

/area/lv522_l_l/indoors/corporate
	name = "A Block - Corporate"
	icon_state = "blue"
	minimap_color = MINIMAP_AREA_COMMAND

/area/lv522_l_l/indoors/canteen
	name = "B Block - Canteen"
	icon_state = "green"

/area/lv522_l_l/indoors/clinic
	name = "B Block - Clinic"
	icon_state = "medbay"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/lv522_l_l/indoors/storage
	name = "B Block - Storage"
	icon_state = "storage"

/area/lv522_l_l/indoors/sec
	name = "B Block - Office Of Colonial Marshals"
	icon_state = "head_quarters"
	minimap_color = MINIMAP_AREA_SEC

/area/lv522_l_l/indoors/slaughterhouse
	name = "D Block - Slaughterhouse"
	icon_state = "kitchen"

/area/lv522_l_l/indoors/engineering
	name = "B Block - Engineering Storehouse"
	icon_state = "yellow"
	minimap_color = MINIMAP_AREA_ENGI

/area/lv522_l_l/indoors/dorms
	name = "C Block - Dorms"
	icon_state = "purple"

/area/lv522_l_l/indoors/airtraffic
	name = "D Block - Air Traffic Tower"
	icon_state = "blue"

/area/lv522_l_l/indoors/mining
	name = "LV522 Lukes Landing - Colony Outskirts - Mining"
	icon_state = "blue"

//Colony Outside

/area/lv522_l_l/outdoors/engineering
	name = "Outdoors - Engineering Storehouse"
	icon_state = "mechbay"
	minimap_color = MINIMAP_AREA_ENGI

/area/lv522_l_l/outdoors/colony
	name = "LV522 Lukes Landing - Colony Interior"
	icon_state = "east"

/area/lv522_l_l/outdoors/comms_relay
	name = "LV522 Colony Outskirts - Communications Relay"
	icon_state = "blue"

/area/lv522_l_l/outdoors/mining
	name = "LV522 Colony Outskirts - Mining"
	icon_state = "blue"

//colony outskirts

/area/lv522_l_l/outdoors/colony_outskirts
	name = "LV522 - Barrens"
	icon_state = "west"

//Basement

/area/lv522_l_l/basement/colony
	name = "Lukes Landing - Colony Sublevel"
	icon_state = "red"
	requires_power = FALSE

/area/lv522_l_l/basement/mine
	name = "LV522 - Location indeterminate"
	icon_state = "blue"
	requires_power = FALSE
