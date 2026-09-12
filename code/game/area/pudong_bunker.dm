//====================================================================================================
//BASE
/area/pudong
	name = "MI264 - Pudong Bunker"
	icon_state = "lv-626"
	can_build_special = TRUE
	minimap_color = MINIMAP_AREA_COLONY
	powernet_name = "pudong"
//======================================================================================PARENT
/area/pudong/base
	name = "Pudong Bunker Base"
	ceiling = CEILING_REINFORCED_METAL
	sound_environment = SOUND_ENVIRONMENT_ROOM
	soundscape_playlist = AMBIENCE_SHIP
/area/pudong/caves
	name = "Pudong Caves"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	ambience_exterior = AMBIENCE_CAVE
	soundscape_playlist = SCAPE_PL_CAVE
	base_muffle = MUFFLE_HIGH
	temperature = T0C
/area/pudong/exterior
	name = "Pudong Exterior"
	soundscape_playlist = SCAPE_PL_WIND
	temperature = ICE_COLONY_TEMPERATURE
/area/pudong/oob
	name = "OOB"
	ceiling = CEILING_UNDERGROUND_METAL_BLOCK_CAS
	requires_power = FALSE
//==============================================================================BASE
/area/pudong/base/maintenance
	name = "Pudong - Maintenance"
	icon_state = "yellow"
/area/pudong/base/power
	name = "Pudong - Power Station"
	icon_state = "engine_smes"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	soundscape_playlist = SCAPE_PL_ENG
/area/pudong/base/engi
	name = "Pudong - Engineering"
	icon_state = "engine"
	minimap_color = MINIMAP_AREA_ENGI
	soundscape_playlist = SCAPE_PL_ENG
/area/pudong/base/server
	name = "Pudong - Server Room"
	icon_state = "bridge"
	minimap_color = MINIMAP_AREA_COMMAND
	soundscape_playlist = SCAPE_PL_CIC
/area/pudong/base/quarters
	name = "Pudong - Quarters"
	icon_state = "green"
/area/pudong/base/cryo
	name = "Pudong - Cryogenic Storage"
	icon_state = "cryo"
/area/pudong/base/galley
	name = "Pudong - Galley"
	icon_state = "green"
/area/pudong/base/platoon
	name = "Pudong - Platoon Commander's Office"
	icon_state = "green"
/area/pudong/base/briefing
	name = "Pudong - Briefing Hall"
	icon_state = "green"
/area/pudong/base/armory
	name = "Pudong - Armory"
	icon_state = "armory"
	minimap_color = MINIMAP_AREA_SEC
/area/pudong/base/nco
	name = "Pudong - Sergeants' Office"
	icon_state = "security"
/area/pudong/base/treatment
	name = "Pudong - Treatment Space"
	icon_state = "medbay"
	minimap_color = MINIMAP_AREA_MEDBAY
/area/pudong/base/hangar
	name = "Pudong - Hangar Space"
	icon_state = "purple"
/area/pudong/base/bunker
	name = "Pudong - Bunker System"
	icon_state = "red"
//===============================================================================CAVES
/area/pudong/caves/main
	name = "Pudong Caves"
	icon_state = "cave"
/area/pudong/caves/depths
	name = "Pudong Depths"
	icon_state = "cave"
//===============================================================================EXTERIOR
/area/pudong/exterior/cliff
	name = "Pudong Clifface"
	icon_state = "north"
/area/pudong/exterior/cavern
	name = "Pudong Caverns"
	icon_state = "east"
//===============================================================================OOB
/area/pudong/oob/buttons
	name = "Out of Bounds"
	icon_state = "mech"
	requires_power = FALSE
