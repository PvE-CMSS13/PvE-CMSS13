//====================================================================================================
//BASE
/area/bandakar
	name = "MI410 - Bandakar Pass Staging Ground"
	icon_state = "lv-626"
	can_build_special = TRUE
	minimap_color = MINIMAP_AREA_COLONY
	temperature = TROPICAL_TEMP
	powernet_name = "bandakar"
//======================================================================================PARENT
/area/bandakar/base
	name = "Bandakar Staging Ground"
	ceiling = CEILING_REINFORCED_METAL
	sound_environment = SOUND_ENVIRONMENT_ROOM
	soundscape_playlist = SCAPE_PL_ENG
	base_muffle = MUFFLE_MEDIUM
/area/bandakar/tent
	name = "Bandakar Tents"
	ceiling = CEILING_GLASS
	soundscape_playlist = AMBIENCE_BIGRED
	base_muffle = MUFFLE_LOW
/area/bandakar/caves
	name = "Bandakar Caves"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_CAVE
	soundscape_playlist = SCAPE_PL_CAVE
	base_muffle = MUFFLE_HIGH
	temperature = T20C
/area/bandakar/exterior
	name = "Bandakar Exterior"
	soundscape_playlist = AMBIENCE_BIGRED
	base_muffle = MUFFLE_LOW
/area/bandakar/oob
	name = "OOB"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	requires_power = FALSE
//==============================================================================BASE
/area/bandakar/base/maintenance
	name = "Bandakar - Maintenance"
	icon_state = "yellow"
/area/bandakar/base/power
	name = "Bandakar - Power Station"
	icon_state = "engine_smes"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	soundscape_playlist = SCAPE_PL_ENG
/area/bandakar/base/engi
	name = "Bandakar - Engineering"
	icon_state = "engine"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	soundscape_playlist = SCAPE_PL_ENG
/area/bandakar/base/cryo
	name = "Bandakar - Cryogenic Storage"
	icon_state = "cryo"
/area/bandakar/base/platoon
	name = "Bandakar - Platoon Commander's Office"
	icon_state = "green"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE
/area/bandakar/base/armory
	name = "Bandakar - Armory"
	icon_state = "armory"
	minimap_color = MINIMAP_AREA_SEC_CAVE
//==============================================================================TENT
/area/bandakar/tent/quarters
	name = "Bandakar - Quarters"
	icon_state = "green"
/area/bandakar/tent/galley
	name = "Bandakar - Galley Tent"
	icon_state = "green"
/area/bandakar/tent/briefing
	name = "Bandakar - Briefing Tent"
	icon_state = "green"
/area/bandakar/tent/treatment
	name = "Bandakar - Treatment Tent"
	icon_state = "medbay"
	minimap_color = MINIMAP_AREA_MEDBAY
/area/bandakar/tent/storage
	name = "Bandakar - Storage"
	icon_state = "purple"
/area/bandakar/tent/bunker
	name = "Bandakar - Bunkers"
	icon_state = "red"
//===============================================================================CAVES
/area/bandakar/caves/main
	name = "Bandakar Caves"
	icon_state = "cave"
//===============================================================================EXTERIOR
/area/bandakar/exterior/cavern
	name = "Bandakar Canyon"
	icon_state = "east"
//===============================================================================OOB
/area/bandakar/oob/buttons
	name = "Out of Bounds"
	icon_state = "mech"
	requires_power = FALSE
