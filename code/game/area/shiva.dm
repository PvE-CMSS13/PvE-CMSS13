//Areas for Shiva's Snowball, aka Ice LZ1, above ground revamp.

/area/shiva
	name = "Shiva's Snowball"
	icon = 'icons/turf/area_shiva.dmi'
	//ambience = list('figuresomethingout.ogg')
	icon_state = "shiva"
	can_build_special = TRUE //T-Comms structure
	temperature = 375
	minimap_color = MINIMAP_AREA_COLONY

/area/shuttle/drop1/shiva
	name = "Dropship Alamo Landing Zone"
	icon_state = "shuttle"
	icon = 'icons/turf/area_shiva.dmi'
	is_resin_allowed = FALSE
	minimap_color = MINIMAP_AREA_LZ

/area/shuttle/drop2/shiva
	name = "Dropship Normandy Landing Zone"
	icon_state = "shuttle2"
	icon = 'icons/turf/area_shiva.dmi'
	is_resin_allowed = FALSE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/lz1_console
	name = "Dropship Alamo Console"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/lz1_console/two
	name = "Dropship Normandy Console"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior
	name = "Exterior"
	ceiling = CEILING_NONE


/area/shiva/interior
	name = "Interior"
	ceiling = CEILING_UNDERGROUND_ALLOW_CAS
	requires_power = TRUE

/area/shiva/interior/oob
	name = "Out Of Bounds"
	ceiling = CEILING_MAX
	icon_state = "oob"
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL

/area/shiva/interior/oob/dev_room
	name = "Secret Room"
	is_resin_allowed = FALSE
	flags_area = AREA_NOTUNNEL
	icon_state = "shiva"

//telecomms areas - exterior
/area/shiva/exterior/telecomm
	name = "Communications Relay"
	icon_state = "ass_line"
	is_resin_allowed = FALSE

/area/shiva/exterior/telecomm/lz1_north
	name = "North LZ1 Communications Relay"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/telecomm/lz2_southeast
	name = "South-East LZ2 Communications Relay"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/telecomm/lz2_northeast
	name = "North-East LZ2 Communications Relay"
	minimap_color = MINIMAP_AREA_LZ


//telecomms areas - interior
/area/shiva/interior/telecomm
	name = "Communications Relay"
	icon_state = "ass_line"
	is_resin_allowed = FALSE

/area/shiva/interior/telecomm/lz1_biceps
	name = "Fort Biceps Communications Relay"
	icon_state = "hangars0"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/interior/telecomm/lz1_flight
	name = "LZ1 Aerodrome Communications Relay"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/interior/telecomm/lz2_research
	name = "Argentinian Communications Relay"
	minimap_color = MINIMAP_AREA_LZ

//telecomms areas - caves
/area/shiva/caves/telecomm
	name = "Communications Relay"
	icon_state = "ass_line"
	is_resin_allowed = FALSE

/area/shiva/caves/telecomm/lz2_south
	name = "Backup Communications Relay"
	minimap_color = MINIMAP_AREA_LZ

//exterior areas

/area/shiva/exterior/lz1_valley
	name = "Landing Valley"
	icon_state = "landing_valley"
	is_resin_allowed = FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/lz2_fortress
	name = "Landing Bulwark"
	icon_state = "lz2_fortress"
	is_resin_allowed = FALSE
	is_landing_zone = TRUE
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/exterior/valley
	name = "Storage Bunker Valley"
	icon_state = "junkyard1"

/area/shiva/exterior/cp_colony_grounds
	name = "Colony Grounds"
	icon_state = "junkyard2"

/area/shiva/exterior/junkyard
	name = "Junkyard"
	icon_state = "junkyard0"

/area/shiva/exterior/junkyard/fortbiceps
	name = "Fort Biceps"
	icon_state = "junkyard1"

/area/shiva/exterior/junkyard/cp_bar
	name = "Bar Grounds"
	icon_state = "bar0"

/area/shiva/exterior/cp_s_research
	name = "Research Hab Exterior"
	icon_state = "junkyard1"

/area/shiva/exterior/cp_lz2
	name = "North Colony Grounds"
	icon_state = "junkyard3"

/area/shiva/exterior/research_alley
	name = "South Research Alley"
	icon_state = "junkyard2"
	minimap_color = MINIMAP_AREA_RESEARCH



//interior areas

/area/shiva/interior/caves
	name = "Caves"
	icon_state = "caves0"
	ceiling = CEILING_UNDERGROUND_BLOCK_CAS

/area/shiva/interior/caves/right_spiders
	name = "Forgotten Passage"
	icon_state = "caves1"

/area/shiva/interior/caves/left_spiders
	name = "Crevice Passage"
	icon_state = "caves2"

/area/shiva/interior/caves/s_lz2
	name = "South LZ2 Caves"
	icon_state = "caves3"
	minimap_color = MINIMAP_AREA_LZ

/area/shiva/interior/caves/cp_camp
	name = "Cave Camp"
	icon_state = "bar3"

/area/shiva/interior/caves/research_caves
	name = "South Research Hab Caves"
	icon_state = "caves2"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/shiva/interior/caves/medseceng_caves
	name = "South Med-Sec-Eng Complex Caves"
	icon_state = "caves3"

/area/shiva/interior/colony
	name = "Colony MegaStruct(TM)"
	icon_state = "res0"
	ceiling = CEILING_UNDERGROUND_METAL_ALLOW_CAS

/area/shiva/interior/colony/botany
	name = "MegaStruct(TM) Botanical Dorms"
	icon_state = "res1"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/shiva/interior/colony/s_admin
	name = "MegaStruct(TM) Crisis Center"
	icon_state = "res2"

/area/shiva/interior/colony/n_admin
	name = "MegaStruct(TM) Administration"
	icon_state = "res3"
	minimap_color = MINIMAP_AREA_COMMAND

/area/shiva/interior/colony/central
	name = "MegaStruct(TM) Residential Life"
	icon_state = "res4"

/area/shiva/interior/colony/research_hab
	name = "Research Hab Interior"
	icon_state = "res2"

/area/shiva/interior/colony/medseceng
	name = "Colony MegaStruct(TM) Med-Sec-Eng Segment"
	icon_state = "res0"

/area/shiva/interior/colony/deck
	name = "Colony MegaStruct(TM) Open Deck"
	icon_state = "res1"
	ceiling = CEILING_GLASS

/area/shiva/interior/aerodrome
	name = "Aerodrome"
	icon_state = "hangars0"

/area/shiva/interior/bar
	name = "Anti-Freeze Bar"
	icon_state = "hangars0"

/area/shiva/interior/fort_biceps
	name = "Fort Biceps Interior"
	icon_state = "hangars0"

/area/shiva/interior/warehouse
	name = "Blue Warehouse"
	icon_state = "hangars1"

/area/shiva/interior/valley_huts
	name = "Valley Bunker 1"
	icon_state = "hangars1"

/area/shiva/interior/valley_huts/no2
	name = "Valley Bunker 2"
	icon_state = "hangars2"

/area/shiva/interior/valley_huts/disposals
	name = "Valley Disposals"
	icon_state = "hangars3"

/area/shiva/interior/warehouse/caves
	name = "Blue Warehouse Ice Cave"
	icon_state = "caves1"

/area/shiva/interior/garage
	name = "Cargo Tug Repair Station"
	icon_state = "hangars2"

/area/shiva/interior/lz2_habs
	name = "Argentinian Research Headquarters"
	icon_state = "bar1"
