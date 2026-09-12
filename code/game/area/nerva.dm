/area/nerva
	icon = 'icons/turf/area_almayer.dmi'
	// ambience = list('sound/ambience/shipambience.ogg')
	icon_state = "almayer"
	ceiling = CEILING_METAL
	powernet_name = "nerva"
	sound_environment = SOUND_ENVIRONMENT_ROOM
	soundscape_playlist = list('sound/ambience/ambigen1.ogg','sound/ambience/ambigen3.ogg', 'sound/ambience/maintambience.ogg','sound/ambience/biomass.ogg', 'sound/ambience/seag1.ogg','sound/ambience/vents.ogg', 'sound/ambience/signal.ogg','sound/ambience/ambisin3.ogg','sound/ambience/ambisin1.ogg', 'sound/ambience/ambisin4.ogg', 'sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambigen14.ogg')
	soundscape_interval = 180
	// soundscape_playlist = list('sound/effects/xylophone1.ogg', 'sound/effects/xylophone2.ogg', 'sound/effects/xylophone3.ogg')
	ambience_exterior = AMBIENCE_ALMAYER
	ceiling_muffle = FALSE

	///Whether this area is used for hijack evacuation progress
	var/hijack_evacuation_area = FALSE

	///The weight this area gives towards hijack evacuation progress
	var/hijack_evacuation_weight = 0

	///Whether this area is additive or multiplicative towards evacuation progress
	var/hijack_evacuation_type = EVACUATION_TYPE_NONE

/area/nerva/fourth
	fake_zlevel = 4

/area/nerva/fourth/maint
	name = "\improper Fourth Deck Maintenance"
	icon_state = "upperhull"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/nerva/fourth/hallway
	name = "\improper Fourth Deck Hallway"
	icon_state = "missionplanner"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/nerva/fourth/core
	name = "\improper Fourth Deck AI Core"
	icon_state = "airoom"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/third
	fake_zlevel = 3

/area/nerva/third/maint
	name = "\improper Third Deck Maintenance"
	icon_state = "upperhull"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/nerva/third/chapel
	name = "\improper Third Deck Chapel"
	icon_state = "officerrnr"

/area/nerva/third/laundry
	name = "\improper Third Deck Laundry"
	icon_state = "laundry"

/area/nerva/third/reporter
	name = "\improper Third Deck Reporter"
	icon_state = "selfdestruct"

/area/nerva/third/hallway
	name = "\improper Third Deck Hallway"
	icon_state = "stern"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/nerva/third/brig
	name = "\improper Third Deck Brig Habitat"
	icon_state = "brigcells"
	minimap_color = MINIMAP_AREA_SEC
/area/nerva/third/thruster
	name = "\improper Third Deck Thrusters"
	icon_state = "selfdestruct"
	minimap_color = MINIMAP_AREA_ENGI

/area/nerva/third/psych
	name = "\improper Third Deck Counselor Office"
	icon_state = "gruntrnr"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/nerva/third/engineerrnr
	name = "\improper Third Deck Engineering Lounge"
	icon_state = "gruntrnr"
	minimap_color = MINIMAP_AREA_ENGI

/area/nerva/third/air
	name = "\improper Third Deck Engineering Air Supply"
	icon_state = "lifesupport"
	minimap_color = MINIMAP_AREA_ENGI

/area/nerva/third/escapepod
	name = "\improper Third Deck Escape Pod(2)"
	icon_state = "shuttle2"

/area/nerva/third/officerbunkfore
	name = "\improper Third Deck Fore Officer Bedrooms"
	icon_state = "livingspace"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/third/officerbunkmid
	name = "\improper Third Deck Central Officer Bunks"
	icon_state = "livingspace"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/third/officerbunkmid
	name = "\improper Third Deck Central Officer Bunks"
	icon_state = "livingspace"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/third/commonbunks
	name = "\improper Third Deck Common Bunks"
	icon_state = "livingspace"

/area/nerva/third/commontools
	name = "\improper Third Deck Tool Access"
	icon_state = "workshop"
	minimap_color = MINIMAP_AREA_ENGI

/area/nerva/second
	fake_zlevel = 2

/area/nerva/second/maint
	name = "\improper Second Deck Maintenance"
	icon_state = "lowerhull"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/nerva/second/medical
	name = "\improper Second Deck Medbay"
	icon_state = "medical"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/nerva/second/researchdesk
	name = "\improper Second Deck Research Desk"
	icon_state = "science"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/nerva/second/req
	name = "\improper Second Deck Requisitions"
	icon_state = "req"

/area/nerva/second/hallway
	name = "\improper Second Deck Hallway"
	icon_state = "starboard"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/nerva/second/bar
	name = "\improper Second Deck Bar"
	icon_state = "food"

/area/nerva/second/headbunks
	name = "\improper Second Deck Head of Personal Bedrooms"
	icon_state = "livingspace"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/second/eva
	name = "\improper Second Deck EVA Equipment"
	icon_state = "blue-old"

/area/nerva/second/cryopods
	name = "\improper Second Deck Cryo Pods"
	icon_state = "cryo"

/area/nerva/second/engineering
	name = "\improper Second Deck Engineering Workshop"
	icon_state = "cryo"
	minimap_color = MINIMAP_AREA_ENGI

/area/nerva/second/engineering/burn
	name = "\improper Second Deck Power Combustion Chamber"
	icon_state = "cryo"
	minimap_color = MINIMAP_AREA_ENGI

/area/nerva/second/engineering/tcomms
	name = "\improper Second Deck Telecommunications"
	icon_state = "tcomms"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/second/cic
	name = "\improper Second Deck Bridge"
	icon_state = "cic"
	minimap_color = MINIMAP_AREA_COMMAND

/area/nerva/second/sec
	name = "\improper Second Deck Security Wing"
	icon_state = "brig"
	minimap_color = MINIMAP_AREA_SEC
/area/nerva/second/sec/armory
	name = "\improper Second Deck Brig Armory"
	icon_state = "brig"
	minimap_color = MINIMAP_AREA_SEC
/area/nerva/first
	fake_zlevel = 1

/area/nerva/first/maint
	name = "\improper First Deck Maintenance"
	icon_state = "lowerhull"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/nerva/first/thrusters
	name = "\improper First Deck Thruster Rooms"
	icon_state = "selfdestruct"

/area/nerva/first/hanger/port
	icon_state = "dropship"

/area/nerva/first/hanger/port
	name = "\improper First Deck Port Hanger"

/area/nerva/first/hanger/aft
	name = "\improper First Deck Aft Hanger"

/area/nerva/first/hallway
	name = "\improper First Deck Hallway"
	icon_state = "starboardumbilical"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/nerva/first/escapepods
	name = "\improper First Deck Escape Pods"
	icon_state = "lifeboat"


/area/nerva/first/research
	name = "\improper First Deck Laboratories"
	icon_state = "science"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/nerva/first/panic
	name = "\improper First Deck Weapons Controls and Panic Room"
	icon_state = "brig"
	minimap_color = MINIMAP_AREA_SEC

/area/nerva/first/com
	name = "\improper First Deck AI Interface"
	icon_state = "airoom"
	minimap_color = MINIMAP_AREA_COMMAND
