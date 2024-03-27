/area/whiskey_outpost
	name = "\improper Whiskey Outpost"
	icon = 'icons/turf/area_whiskey.dmi'
	icon_state = "outside"
	ceiling = CEILING_METAL
	powernet_name = "ground"

/*
|***INSIDE AREAS***|
*/

/area/whiskey_outpost/inside
	name = "Interior Whiskey Outpost"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	minimap_color = MINIMAP_AREA_CAVES

/area/whiskey_outpost/inside/hospital
	name = "\improper Hospital"
	icon_state = "medical"
	minimap_color = MINIMAP_AREA_MEDBAY_CAVE

/area/whiskey_outpost/inside/hospital/triage
	name = "\improper Triage Center"

/area/whiskey_outpost/inside/cic
	name = "\improper Command Information Center"
	icon_state = "CIC"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/whiskey_outpost/inside/bunker
	name = "\improper Bunker"
	icon_state = "bunker"

/area/whiskey_outpost/inside/bunker/pillbox
	ceiling = CEILING_METAL

/area/whiskey_outpost/inside/bunker/pillbox/one
	name = "Pillbox Bourbon"
	icon_state = "p1"

/area/whiskey_outpost/inside/bunker/pillbox/two
	name = "Pillbox Wine"
	icon_state = "p2"

/area/whiskey_outpost/inside/bunker/pillbox/three
	name = "Pillbox Vodka"
	icon_state = "p3"

/area/whiskey_outpost/inside/bunker/pillbox/four
	name = "Pillbox Tequila"
	icon_state = "p4"

/area/whiskey_outpost/inside/bunker/bunker/front
	name = "Pillbox Beer"
	icon_state = "p5"


/area/whiskey_outpost/inside/engineering
	name = "\improper Engineering"
	icon_state = "engineering"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/whiskey_outpost/inside/living
	name = "\improper Living Quarters"
	icon_state = "livingspace"

/area/whiskey_outpost/inside/supply
	name = "\improper Supply Depot"
	icon_state = "req"

/*
|***OUTSIDE AREAS***|
*/

/area/whiskey_outpost/outside
	name = "\improper Unused"
	icon_state = "outside"
	ceiling = CEILING_NONE
	//ambience = list('sound/ambience/jungle_amb1.ogg')
	requires_power = 1
	always_unpowered = 1
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	minimap_color = MINIMAP_AREA_COLONY

/area/whiskey_outpost/outside/north
	name = "\improper Northern Beach"
	icon_state = "north"
	//ambience = list('sound/ambience/ambimine.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambisin4.ogg')

/area/whiskey_outpost/outside/north/northwest
	name = "\improper North-Western Beach"
	icon_state = "northwest"

/area/whiskey_outpost/outside/north/northeast
	name = "\improper North-Eastern Beach"
	icon_state = "northeast"

/area/whiskey_outpost/outside/north/beach
	name = "\improper Bunker Beach"
	icon_state = "farnorth"

/area/whiskey_outpost/outside/north/platform
	name = "\improper Bunker Platform"
	icon_state = "platform"

/area/whiskey_outpost/outside/lane

/area/whiskey_outpost/outside/lane/one_north
	name = "\improper Western Jungle North"
	icon_state = "lane1n"

/area/whiskey_outpost/outside/lane/one_south
	name = "\improper Western Jungle South"
	icon_state = "lane1s"

/area/whiskey_outpost/outside/lane/two_north
	name = "\improper Western Path North"
	icon_state = "lane2n"

/area/whiskey_outpost/outside/lane/two_south
	name = "\improper Western Path South"
	icon_state = "lane2s"

/area/whiskey_outpost/outside/lane/three_north
	name = "\improper Eastern Path North"
	icon_state = "lane3n"

/area/whiskey_outpost/outside/lane/three_south
	name = "\improper Eastern Path South"
	icon_state = "lane3s"

/area/whiskey_outpost/outside/lane/four_north
	name = "\improper Eastern Crash Site North"
	icon_state = "lane4n"

/area/whiskey_outpost/outside/lane/four_south
	name = "\improper Eastern Crash Site South"
	icon_state = "lane4s"

//lane4south
/area/whiskey_outpost/outside/south
	name = "\improper Perimeter Entrance"
	icon_state = "south"

/area/whiskey_outpost/outside/south/far
	name = "Southern Jungle"
	icon_state = "farsouth"

/area/whiskey_outpost/outside/south/very_far
	name = "\improper Far-Southern Jungle"
	icon_state = "veryfarsouth"

/area/whiskey_outpost/outside/mortar_pit
	name = "\improper Mortar Pit"
	icon_state = "mortarpit"

/area/whiskey_outpost/outside/river
	name = "\improper Riko's River Central"
	icon_state = "river"

/area/whiskey_outpost/outside/river/east
	name = "\improper Riko's River East"
	icon_state = "rivere"

/area/whiskey_outpost/outside/river/west
	name = "\improper Riko's River West"
	icon_state = "riverw"

/*
|***CAVE AREAS***|
*/

/area/whiskey_outpost/inside/caves
	name = "\improper Rock"
	icon_state = "rock"
	//ambience = list('sound/ambience/ambimine.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambisin4.ogg')
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	requires_power = 1
	always_unpowered = 1
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/whiskey_outpost/inside/caves/tunnel
	name = "\improper Tunnel"
	icon_state = "tunnel"
	flags_area = AREA_NOTUNNEL

/area/whiskey_outpost/inside/caves/caverns
	name = "\improper Northern Caverns"
	icon_state = "caves"
/area/whiskey_outpost/inside/caves/caverns/west
	name = "\improper Western Caverns"
	icon_state = "caveswest"

/area/whiskey_outpost/inside/caves/caverns/east
	name = "\improper Eastern Caverns"
	icon_state = "caveseast"

/*
****************************************************
					BLACKSTONE AREAS
****************************************************
*/

/area/whiskey_outpost/blackstone
	name = "\improper Whiskey Outpost Blackstone Area"
	fake_zlevel = MAP_FAKE_Z_BLACKSTONE_GROUND //So they are not the same as the Almayer fake z's. Stupid, but necessary.
	sound_environment = SOUND_ENVIRONMENT_GENERIC

/*
There are some areas that start out unpowered but can be powered, mostly near the outpost or supply warehouse. They have the "whiskey_outpost"
powernet. Everything else isn't really meant to be powered on, though it can be other than the river. These areas are on the "ground"
powernet.
*/

/*
|***INSIDE AREAS***|
*/

//Inside areas are powered from the start.

/area/whiskey_outpost/blackstone/inside
	name = "\improper Interior Whiskey Outpost"
	powernet_name = "whiskey_outpost"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COLONY
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/whiskey_outpost/blackstone/inside/outpost_north
	name = "\improper Briefing Hall"
	icon_state = "bunker_brief"
	minimap_color = MINIMAP_AREA_SEC
	sound_environment = SOUND_ENVIRONMENT_AUDITORIUM

/area/whiskey_outpost/blackstone/inside/outpost_central
	name = "\improper Outpost Central Hall"
	icon_state = "bunker"
	minimap_color = MINIMAP_AREA_SEC
	sound_environment = SOUND_ENVIRONMENT_HALLWAY

/area/whiskey_outpost/blackstone/inside/outpost_south
	name = "\improper Outpost Arrival Hall"
	icon_state = "bunker_arrival"
	minimap_color = MINIMAP_AREA_SEC
	sound_environment = SOUND_ENVIRONMENT_HALLWAY

/area/whiskey_outpost/blackstone/inside/bunks
	name = "\improper Squad Bunks"
	icon_state = "bunks"
	sound_environment = SOUND_ENVIRONMENT_LIVINGROOM

/area/whiskey_outpost/blackstone/inside/bunks/bathroom
	name = "\improper Squad Bathrooms"
	icon_state = "bathrooms"
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/whiskey_outpost/blackstone/inside/cryo
	name = "\improper Cryo Room"
	icon_state = "cryo"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/whiskey_outpost/blackstone/inside/armory
	name = "\improper Platoon Armory"
	icon_state = "armory"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS
	minimap_color = MINIMAP_AREA_SEC_CAVE
	sound_environment = SOUND_ENVIRONMENT_HANGAR

/area/whiskey_outpost/blackstone/inside/senior_enlisted_west
	name = "\improper Senior Enlisted West Office"
	icon_state = "senior_enlisted"

/area/whiskey_outpost/blackstone/inside/senior_enlisted_east
	name = "\improper Senior Enlisted East Office"
	icon_state = "senior_enlisted"

/area/whiskey_outpost/blackstone/inside/cafeteria
	name = "\improper Cafeteria"
	icon_state = "cafeteria"
	sound_environment = SOUND_ENVIRONMENT_LIVINGROOM

/area/whiskey_outpost/blackstone/inside/medbay
	name = "\improper Sickbay"
	icon_state = "sickbay"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/whiskey_outpost/blackstone/inside/combat_information_center
	name = "\improper Combat Information Center"
	icon_state = "command"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE
	soundscape_playlist = SCAPE_PL_CIC

/area/whiskey_outpost/blackstone/inside/meeting_room
	name = "\improper Meeting Room"
	icon_state = "command"
	minimap_color = MINIMAP_AREA_COMMAND

/area/whiskey_outpost/blackstone/inside/maintenance_closet
	name = "\improper Maintenance Closet"
	icon_state = "maint_engi"
	minimap_color = MINIMAP_AREA_ENGI
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/whiskey_outpost/blackstone/inside/commander_office
	name = "\improper Commander's Office"
	icon_state = "commander"
	minimap_color = MINIMAP_AREA_COMMAND

/area/whiskey_outpost/blackstone/inside/commander_quarters
	name = "\improper Commander's Quarters"
	icon_state = "commander"
	minimap_color = MINIMAP_AREA_COMMAND

/area/whiskey_outpost/blackstone/inside/lieutenant_office
	name = "\improper Lieutenant's Office"
	icon_state = "lieutenant"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/whiskey_outpost/blackstone/inside/eastern_checkpoint
	name = "\improper Blackstone Bridge Checkpoint"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS
	minimap_color = MINIMAP_AREA_SEC

/area/whiskey_outpost/blackstone/inside/warehouse
	name = "\improper Supply Warehouse"
	icon_state = "req"
	minimap_color = MINIMAP_AREA_ENGI
	sound_environment = SOUND_ENVIRONMENT_HANGAR

/area/whiskey_outpost/blackstone/inside/warehouse/checkpoint
	name = "\improper Warehouse Checkpoint"
	icon_state = "req_checkpoint"
	sound_environment = SOUND_ENVIRONMENT_HANGAR

/area/whiskey_outpost/blackstone/inside/pillbox
	name = "\improper Pillbox Washington"
	minimap_color = MINIMAP_AREA_SEC
	sound_environment = SOUND_ENVIRONMENT_HANGAR

/area/whiskey_outpost/blackstone/inside/pillbox/one
	icon_state = "p1"

/area/whiskey_outpost/blackstone/inside/pillbox/two
	name = "\improper Pillbox Adams"
	icon_state = "p2"

/area/whiskey_outpost/blackstone/inside/pillbox/three
	name = "\improper Pillbox Jefferson"
	icon_state = "p3"

/area/whiskey_outpost/blackstone/inside/pillbox/four
	name = "\improper Pillbox Madison"
	icon_state = "p4"

/area/whiskey_outpost/blackstone/inside/visitor_dormitory
	name = "\improper Visitor Dormitory"
	icon_state = "livingspace"
	sound_environment = SOUND_ENVIRONMENT_CARPETED_HALLWAY

/area/whiskey_outpost/blackstone/inside/visitor_dormitory/room_one
	name = "\improper Visitor Dormitory Bedroom One"
	sound_environment = SOUND_ENVIRONMENT_LIVINGROOM

/area/whiskey_outpost/blackstone/inside/visitor_dormitory/room_two
	name = "\improper Visitor Dormitory Bedroom Two"
	sound_environment = SOUND_ENVIRONMENT_LIVINGROOM

/*
|***OUTSIDE AREAS***|
*/

//Outside areas are largely unpowered.

/area/whiskey_outpost/blackstone/outside
	name = "\improper Unused"
	icon_state = "outside"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY
	sound_environment = SOUND_ENVIRONMENT_PLAIN

/area/whiskey_outpost/blackstone/outside/impassable
	name = "\improper Rock & Dense Jungle"
	icon_state = "openrock"
	sound_environment = SOUND_ENVIRONMENT_FOREST

/area/whiskey_outpost/blackstone/outside/outpost
	powernet_name = "whiskey_outpost"
	icon_state = "platform_n"

/area/whiskey_outpost/blackstone/outside/outpost/north
	name = "\improper Outpost Compound - North"
	sound_environment = SOUND_ENVIRONMENT_ALLEY
/area/whiskey_outpost/blackstone/outside/outpost/south
	name = "\improper Outpost Compound - South"
	icon_state = "platform_s"
/area/whiskey_outpost/blackstone/outside/outpost/east
	name = "\improper Outpost Compound - East"
	icon_state = "platform_e"
/area/whiskey_outpost/blackstone/outside/outpost/west
	name = "\improper Outpost Compound - West"
	icon_state = "platform_w"

/area/whiskey_outpost/blackstone/outside/jungle
	minimap_color = MINIMAP_AREA_JUNGLE
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambience_exterior = AMBIENCE_JUNGLE

/area/whiskey_outpost/blackstone/outside/jungle/perimeter_entrance
	name = "\improper Perimeter Entrance - Central"
	icon_state = "south"

/area/whiskey_outpost/blackstone/outside/jungle/perimeter_entrance/west
	name = "\improper Perimeter Entrance - West"
	icon_state = "southwest"

/area/whiskey_outpost/blackstone/outside/jungle/perimeter_entrance/east
	name = "\improper Perimeter Entrance - East"
	icon_state = "southeast"

/area/whiskey_outpost/blackstone/outside/jungle/north
	name = "\improper North Jungle - Central"
	icon_state = "farsouth"

/area/whiskey_outpost/blackstone/outside/jungle/north/west
	name = "\improper North Jungle - West"
	icon_state = "farsouth_w"

/area/whiskey_outpost/blackstone/outside/jungle/north/east
	name = "\improper North Jungle - East"
	icon_state = "farsouth_e"

/area/whiskey_outpost/blackstone/outside/jungle/southern
	name = "\improper Southern Jungle - Central"
	icon_state = "veryfarsouth"

/area/whiskey_outpost/blackstone/outside/jungle/southern/west
	name = "\improper Southern Jungle - West"
	icon_state = "veryfarsouth_w"

/area/whiskey_outpost/blackstone/outside/jungle/southern/east
	name = "\improper Southern Jungle - East"
	icon_state = "veryfarsouth_e"

/area/whiskey_outpost/blackstone/outside/jungle/south_east
	name = "\improper Dense Jungle - East"
	icon_state = "denseeast"
	ambience_exterior = AMBIENCE_DENSE_JUNGLE

/area/whiskey_outpost/blackstone/outside/jungle/south_west
	name = "\improper Dense Jungle - South West"
	icon_state = "densewest"
	ambience_exterior = AMBIENCE_DENSE_JUNGLE

/area/whiskey_outpost/blackstone/outside/jungle/far_west
	name = "\improper Dense Jungle - Far West"
	icon_state = "densefarwest"
	ambience_exterior = AMBIENCE_DENSE_JUNGLE

/area/whiskey_outpost/blackstone/outside/jungle/sandstone_temple
	name = "\improper Jungle Temple"
	icon_state = "temple"
	ambience_exterior = AMBIENCE_DENSE_JUNGLE

/area/whiskey_outpost/blackstone/outside/jungle/sandstone_shrine
	name = "\improper Jungle Shrine"
	icon_state = "shrine"
	ambience_exterior = AMBIENCE_DENSE_JUNGLE

/area/whiskey_outpost/blackstone/outside/jungle/jungle_pass
	name = "\improper Untamed Jungle Pass"
	icon_state = "jungle_pass"

/area/whiskey_outpost/blackstone/outside/landing_zone
	name = "\improper Outpost Landing Zone"
	icon_state = "landingzone"
	is_resin_allowed = FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ
	sound_environment = SOUND_ENVIRONMENT_QUARRY

//River cannot be powered, as it doesn't make sense to have functional machinery in it.
/area/whiskey_outpost/blackstone/outside/river
	name = "\improper Capella River - Central"
	icon_state = "river"
	always_unpowered = TRUE
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	ambience_exterior = AMBIENCE_RIVER

/area/whiskey_outpost/blackstone/outside/river/east
	name = "\improper Capella River - East"
	icon_state = "rivere"

/area/whiskey_outpost/blackstone/outside/river/west
	name = "\improper Capella River - West"
	icon_state = "riverw"

/area/whiskey_outpost/blackstone/outside/river/south_east
	name = "\improper Capella River - South East"
	icon_state = "riverse"

/area/whiskey_outpost/blackstone/outside/digsite_wilderness
	name = "\improper Excavation Site Wilderness"
	icon_state = "digsite_wilderness"
	ambience_exterior = AMBIENCE_JUNGLE

/area/whiskey_outpost/blackstone/outside/bridge
	icon_state = "platform"
	powernet_name = "whiskey_outpost"
	sound_environment = SOUND_ENVIRONMENT_PARKING_LOT

/area/whiskey_outpost/blackstone/outside/bridge/north
	name = "\improper Blackstone Bridge - North"
	icon_state = "bridge_north"

/area/whiskey_outpost/blackstone/outside/bridge/south
	name = "\improper Blackstone Bridge - South"
	icon_state = "bridge_south"

/area/whiskey_outpost/blackstone/outside/bridge/pitstop
	name = "\improper Blackstone Bridge Pitstop"

/area/whiskey_outpost/blackstone/outside/dorms_island
	name = "\improper Visitor Dormitory Exterior"
	icon_state = "central"

/area/whiskey_outpost/blackstone/outside/outpost_beach
	name = "\improper Outpost Exterior - Central"
	icon_state = "central"

/area/whiskey_outpost/blackstone/outside/outpost_beach/east
	name = "\improper Outpost Exterior - East"
	icon_state = "east"

/area/whiskey_outpost/blackstone/outside/outpost_beach/west
	name = "\improper Outpost Exterior - West"
	icon_state = "west"

/area/whiskey_outpost/blackstone/outside/outpost_beach/mine
	name = "\improper Outpost Exterior - Abandoned Mine"
	icon_state = "digsite"

/area/whiskey_outpost/blackstone/outside/bball_court
	name = "\improper Basketball Court"
	icon_state = "bball"
	powernet_name = "whiskey_outpost"
	sound_environment = SOUND_ENVIRONMENT_PARKING_LOT

/area/whiskey_outpost/blackstone/outside/boxing_ring
	name = "\improper Boxing Ring"
	icon_state = "boxing"
	powernet_name = "whiskey_outpost"
	sound_environment = SOUND_ENVIRONMENT_PARKING_LOT

/area/whiskey_outpost/blackstone/outside/central_road
	name = "\improper Central Road"
	icon_state = "central_road"
	powernet_name = "whiskey_outpost"
	sound_environment = SOUND_ENVIRONMENT_PARKING_LOT

/area/whiskey_outpost/blackstone/outside/perimeter_defense
	name = "\improper Perimeter Defense"
	icon_state = "perimeter_defense"
	powernet_name = "whiskey_outpost"
	sound_environment = SOUND_ENVIRONMENT_PARKING_LOT

//POWERED

/area/whiskey_outpost/blackstone/outside/mortar_pit
	name = "\improper Mortar Pit"
	icon_state = "mortarpit"
	powernet_name = "whiskey_outpost"
	sound_environment = SOUND_ENVIRONMENT_QUARRY

/area/whiskey_outpost/blackstone/outside/comm_tower
	name = "\improper Communication Tower"
	icon_state = "comms"
	powernet_name = "whiskey_outpost"
	minimap_color = MINIMAP_AREA_ENGI
	sound_environment = SOUND_ENVIRONMENT_QUARRY

/*
|***UNDERGROUND AREAS***|
*/

/*
Just about all underground areas are unpowered and cannot be powered on other than the maintenance shafts.
*/

/area/whiskey_outpost/blackstone/underground
	name = "\improper Cave Rock"
	icon_state = "caverock"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE
	sound_environment = SOUND_ENVIRONMENT_QUARRY

/area/whiskey_outpost/blackstone/underground/western_caves
	icon_state = "cave"
	minimap_color = MINIMAP_AREA_CAVES
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambience_exterior = AMBIENCE_CAVE
	soundscape_playlist = SCAPE_PL_CAVE
	soundscape_interval = 25

/area/whiskey_outpost/blackstone/underground/western_caves/north
	name = "\improper Western Caves - North"
	icon_state = "cave_north"

/area/whiskey_outpost/blackstone/underground/western_caves/center
	name = "\improper Western Caves - Center"

/area/whiskey_outpost/blackstone/underground/western_caves/south
	name = "\improper Western Caves - South"
	icon_state = "cave_south"

/area/whiskey_outpost/blackstone/underground/western_caves/church
	name = "\improper Overgrown Chapel"
	icon_state = "church"

/area/whiskey_outpost/blackstone/underground/crab_shack
	name = "\improper Mr. Potatoe's Cave"
	icon_state = "cave"
	minimap_color = MINIMAP_AREA_CAVES
	sound_environment = SOUND_ENVIRONMENT_CAVE

/area/whiskey_outpost/blackstone/underground/mountain
	name = "\improper Mountain Rock"
	icon_state = "rock"
	ceiling = CEILING_DEEP_UNDERGROUND
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS

/area/whiskey_outpost/blackstone/underground/mountain/maintenance
	name = "\improper Deep Underground"
	fake_zlevel = MAP_FAKE_Z_BLACKSTONE_BASEMENT

/area/whiskey_outpost/blackstone/underground/mountain/tunnel
	name = "\improper Mountain Tunnel"
	icon_state = "tunnel"
	flags_area = AREA_NOTUNNEL
	ceiling = CEILING_DEEP_UNDERGROUND_METAL

/area/whiskey_outpost/blackstone/underground/excavation_site
	name = "\improper Excavation Site"
	icon_state = "digsite"
	minimap_color = MINIMAP_AREA_CAVES
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambience_exterior = AMBIENCE_CAVE
	soundscape_playlist = SCAPE_PL_CAVE

//POWERED

/area/whiskey_outpost/blackstone/underground/bunker
	name = "\improper Bunker"
	icon_state = "bunker"
	fake_zlevel = MAP_FAKE_Z_BLACKSTONE_BUNKER
	ceiling = CEILING_DEEP_UNDERGROUND_METAL
	powernet_name = "underground_bunker"
	unlimited_power = TRUE //Gets power from the rest of the facility.

//So the cameras display proper names.
/area/whiskey_outpost/blackstone/underground/bunker/observation
	name = "\improper Bunker - Containment Observation"
/area/whiskey_outpost/blackstone/underground/bunker/containment
	name = "\improper Bunker - Containment Cell"
/area/whiskey_outpost/blackstone/underground/bunker/servers
	name = "\improper Bunker - Servers"
/area/whiskey_outpost/blackstone/underground/bunker/surgery
	name = "\improper Bunker - Surgery"
/area/whiskey_outpost/blackstone/underground/bunker/specimens
	name = "\improper Bunker - Specimen Storage"
/area/whiskey_outpost/blackstone/underground/bunker/storage
	name = "\improper Bunker - Aux Storage"

/area/whiskey_outpost/blackstone/underground/bunker/autopsy
	name = "\improper Bunker - Autopsy"
/area/whiskey_outpost/blackstone/underground/bunker/security_post
	name = "\improper Bunker - Security Post"
/area/whiskey_outpost/blackstone/underground/bunker/cell_one
	name = "\improper Bunker - Cell 1"
/area/whiskey_outpost/blackstone/underground/bunker/cell_two
	name = "\improper Bunker - Cell 2"
/area/whiskey_outpost/blackstone/underground/bunker/cell_three
	name = "\improper Bunker - Cell 3"
/area/whiskey_outpost/blackstone/underground/bunker/break_room
	name = "\improper Bunker - Break Room"

/area/whiskey_outpost/blackstone/underground/maintenance
	name = "\improper Underground Tunnels"
	fake_zlevel = MAP_FAKE_Z_BLACKSTONE_BASEMENT
	powernet_name = "whiskey_outpost"
	ceiling = CEILING_DEEP_UNDERGROUND
	minimap_color = MINIMAP_AREA_ENGI
	soundscape_playlist = SCAPE_PL_ENG
	sound_environment = SOUND_ENVIRONMENT_STONE_CORRIDOR

/area/whiskey_outpost/blackstone/underground/maintenance/engineering
	name = "\improper Engineering Basement"
	icon_state = "maint_engi"
	minimap_color = MINIMAP_AREA_ENGI_CAVE
	sound_environment = SOUND_ENVIRONMENT_STONEROOM

/area/whiskey_outpost/blackstone/underground/maintenance/boiler
	name = "\improper Maintenance Tunnels - Boiler Room"
	icon_state = "maint_boiler"

/area/whiskey_outpost/blackstone/underground/maintenance/south_west
	name = "\improper Maintenance Tunnels - South West"
	icon_state = "maint_sw"

/area/whiskey_outpost/blackstone/underground/maintenance/south_east
	name = "\improper Maintenance Tunnels - South East"
	icon_state = "maint_se"

/area/whiskey_outpost/blackstone/underground/maintenance/north_west
	name = "\improper Maintenance Tunnels - North West"
	icon_state = "maint_nw"

/area/whiskey_outpost/blackstone/underground/maintenance/north_east
	name = "\improper Maintenance Tunnels - North East"
	icon_state = "maint_ne"
