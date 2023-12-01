//LV624_Outpost_Furidamu AREAS--------------------------------------//

/area/LV624_Outpost_Furidamu
	icon_state = "lv-626"
	can_build_special = TRUE
	powernet_name = "ground"
	minimap_color = MINIMAP_AREA_COLONY

//parent types

/area/LV624_Outpost_Furidamu/indoors
	name = "LV624_Outpost_Furidamu - Indoors"
	icon_state = "blue" //because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL

/area/LV624_Outpost_Furidamu/outdoors
	name = "LV624_Outpost_Furidamu - Outdoors"
	icon_state = "cliff_blocked" //because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_JUNGLE

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker
	name = "LV624_Outpost_Furidamu - Colony Caves"
	icon_state = "cliff_blocked"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/LV624_Outpost_Furidamu/oob
	name = "LV624_Outpost_Furidamu - Out Of Bounds"
	icon_state = "unknown"
	ceiling = CEILING_MAX
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL

//Landing Zone 1

/area/LV624_Outpost_Furidamu/landing_zone_1
	name = "LV624_Outpost_Furidamu - Landing Zone One"
	icon_state = "explored"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE

/area/LV624_Outpost_Furidamu/landing_zone_1/ceiling
	ceiling = CEILING_METAL

/area/shuttle/drop1/LV624_Outpost_Furidamu
	name = "LV624_Outpost_Furidamu - Dropship Alamo Landing Zone"
	icon_state = "shuttle"
	icon = 'icons/turf/area_shiva.dmi'

/area/LV624_Outpost_Furidamu/landing_zone_1/lz1_console
	name = "LV624_Outpost_Furidamu - Dropship Alamo Console"
	icon_state = "tcomsatcham"
	requires_power = FALSE

//Landing Zone 2

/area/LV624_Outpost_Furidamu/landing_zone_2
	name = "LV624_Outpost_Furidamu - Landing Zone Two"
	icon_state = "explored"
	is_resin_allowed =  FALSE
	is_landing_zone = TRUE

/area/LV624_Outpost_Furidamu/landing_zone_2/ceiling
	ceiling = CEILING_METAL

/area/shuttle/drop2/LV624_Outpost_Furidamu
	name = "LV624_Outpost_Furidamu - Dropship Normandy Landing Zone"
	icon_state = "shuttle2"
	icon = 'icons/turf/area_shiva.dmi'

/area/LV624_Outpost_Furidamu/landing_zone_2/lz2_console
	name = "LV624_Outpost_Furidamu - Dropship Normandy Console"
	icon_state = "tcomsatcham"
	requires_power = FALSE

//Caves

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/nw
	name = "Outpost Furidamu - Northwest Caves"
	icon_state = "northwest"

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/ne
	name = "Outpost Furidamu - Northeast Caves"
	icon_state = "northeast"

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/cent 
	name = "Outpost Furidamu - Central Caves"
	icon_state = "red"

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/se
	name = "Outpost Furidamu - Southeast Caves"
	icon_state = "southeast"

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/s
	name = "Outpost Furidamu - South Caves"
	icon_state = "south"

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/sw
	name = "Outpost Furidamu - Southwest Caves"
	icon_state = "southwest"

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/barrens/south
	name = "Outpost Furidamu - South Barrens"
	icon_state = "blue"
	ceiling = CEILING_NONE

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/barrens/south/ceiling
	name = "Outpost Furidamu - South Barrens"
	ceiling =  CEILING_METAL

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/barrens/north 
	name = "Outpost Furidamu - North Barrens"
	icon_state = "green"
	ceiling = CEILING_NONE

/area/LV624_Outpost_Furidamu/outdoors/ua_bunker/barrens/north/ceiling
	name = "Outpost Furidamu - North Barrens"
	ceiling =  CEILING_METAL


//River 
/area/LV624_Outpost_Furidamu/outdoors/river
	name = "Outpost Furidamu - North River"
	icon_state = "purple"

/area/LV624_Outpost_Furidamu/outdoors/river/c
	name = "Outpost Furidamu - Central River"

/area/LV624_Outpost_Furidamu/outdoors/river/s 
	name = "Outpost Furidamu - South River"

/area/LV624_Outpost_Furidamu/outdoors/river/e
	name = "Outpost Furidamu - East River"

/area/LV624_Outpost_Furidamu/outdoors/river/w
	name = "Outpost Furidamu - West River"

//Jungles

/area/LV624_Outpost_Furidamu/outdoors/jungle/ne
	name = "Outpost Furidamu - Northeast Jungle"
	icon_state = "northeast"

/area/LV624_Outpost_Furidamu/outdoors/jungle/se
	name = "Outpost Furidamu - Southeast Jungle"
	icon_state = "southeast"

/area/LV624_Outpost_Furidamu/outdoors/jungle/nw
	name = "Outpost Furidamu - Northwest Jungle"
	icon_state = "northwest"

/area/LV624_Outpost_Furidamu/outdoors/jungle/sw
	name = "Outpost Furidamu - Southwest Jungle"
	icon_state = "southwest"

/area/LV624_Outpost_Furidamu/outdoors/jungle/s
	name = "Outpost Furidamu - South Jungle"
	icon_state = "south"

/area/LV624_Outpost_Furidamu/outdoors/jungle/e
	name = "Outpost Furidamu - East Jungle"
	icon_state = "east"

/area/LV624_Outpost_Furidamu/outdoors/jungle/w
	name = "Outpost Furidamu - West Jungle"
	icon_state = "west"

/area/LV624_Outpost_Furidamu/outdoors/jungle/n
	name = "Outpost Furidamu - North Jungle"
	icon_state = "north"

/area/LV624_Outpost_Furidamu/outdoors/jungle/farm
	name = "Outpost Furidamu - Colony Farm"
	icon_state = "blue"

/area/LV624_Outpost_Furidamu/outdoors/jungle/c
	name = "Outpost Furidamu - Colony Central Jungle"
	icon_state = "purple"

/area/LV624_Outpost_Furidamu/outdoors/jungle/firing 
	name = "Outpost Furidamu - Colony Firing Range"
	icon_state = "green"

//huts

/area/LV624_Outpost_Furidamu/indoors/hut/
	name = "Outpost Furidamu - Jungle Hut"
	icon_state = "red"

/area/LV624_Outpost_Furidamu/indoors/hut/farm
	name = "Outpost Furidamu - North Colony Farming hut"

/area/LV624_Outpost_Furidamu/indoors/hut/tcomm
	name = "Outpost Furidamu - North Colony Telecomms Unit"

//buildings

/area/LV624_Outpost_Furidamu/indoors/buildings
	name = "Outpost Fuidamu - Buildings"
	icon_state = "Sleep"

/area/LV624_Outpost_Furidamu/indoors/buildings/lz1_kitchen
	name = "Outpost Furidamu - Landing Zone One Kitchen"

/area/LV624_Outpost_Furidamu/indoors/buildings/lz1_supply
	name = "Outpost Furidamu - Landing Zone One Supply"

/area/LV624_Outpost_Furidamu/indoors/buildings/lz1_barracks
	name = "Outpost Furidamu - Landing Zone One Barracks"

/area/LV624_Outpost_Furidamu/indoors/buildings/lz1_admin
	name = "Outpost Furidamu - Landing Zone One Admin"

/area/LV624_Outpost_Furidamu/indoors/buildings/construction_site
	name = "Outpost Furidamu - Greenhouse Megastructure"

/area/LV624_Outpost_Furidamu/indoors/buildings/hospital
	name = "Outpost Furidamu - Hospital"

/area/LV624_Outpost_Furidamu/indoors/buildings/engineering
	name = "Outpost Furidamu - Engineering"

/area/LV624_Outpost_Furidamu/indoors/buildings/tonwhall
	name = "Outpost Furidamu - Townhall And Workshop"

/area/LV624_Outpost_Furidamu/indoors/buildings/lz2kitchen
	name = "Outpost Furidamu - South Colony Dining Hall"

/area/LV624_Outpost_Furidamu/indoors/buildings/butchers
	name = "Outpost Furidamu - Butchers House"

/area/LV624_Outpost_Furidamu/indoors/buildings/filtration
	name = "Outpost Furidamu - Filtration Dam"

/area/LV624_Outpost_Furidamu/indoors/buildings/securedome
	name = "Outpost Furidamu - Secure Dome"

/area/LV624_Outpost_Furidamu/indoors/buildings/operation_centre
	name = "Outpost Furidamu - CLF Operation Centre"

//bridges

/area/LV624_Outpost_Furidamu/outdoors/bridge
	name = "Outpost Furidamu - Northwest Bridge To CLF Bunker"
	icon_state = "ass_line"

/area/LV624_Outpost_Furidamu/outdoors/bridge/land_bridge
	name = "Outpost Furidamu - Land Bridge To Barrens"

/area/LV624_Outpost_Furidamu/outdoors/bridge/wood_bridge_lz1_lz2
	name = "Outpost Furidamu - Wooden Bridge To LZ2"
	ceiling = CEILING_GLASS

//Bunker
/area/LV624_Outpost_Furidamu/indoors/buildings/Bunker
	name = "Outpost Furiaamu - Northwest CLF Bunker"
	icon_state = "quartstorage"

/area/LV624_Outpost_Furidamu/indoors/buildings/Bunker/noceiling
	name = "Outpost Furiaamu - Northwest CLF Bunker"
	ceiling = CEILING_NONE
