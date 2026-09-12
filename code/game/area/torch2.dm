/area/torch
	icon = 'icons/turf/torch.dmi'
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

/area/torch/bridgedeck
	fake_zlevel = 6

/area/torch/bridgedeck/maintenance
	name = "Bridge Maintenance"
	icon_state = "maintcentral"
	minimap_color = MINIMAP_MARS_DIRT

/area/torch/bridgedeck/maintenance/bridge
	name = "\improper Bridge Shield Generator"

/area/torch/bridgedeck/maintenance/aftport
	name = "Bridge Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/torch/bridgedeck/maintenance/aftport
	name = "Bridge Aft Port Maintenance"
	icon_state = "apmaint"

/area/torch/bridgedeck/maintenance/forestarboard
	name = "Bridge Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/torch/bridgedeck/maintenance/foreport
	name = "Bridge Fore Port Maintenance"
	icon_state = "fpmaint"

/area/torch/bridgedeck/hallway
	minimap_color = MINIMAP_AREA_JUNGLE


/area/torch/bridgedeck/hallway/fore
	name = "\improper Bridge Fore Hallway"
	icon_state = "hallF"

/area/torch/bridgedeck/hallway/aft
	name = "\improper Bridge Aft Hallway"
	icon_state = "hallA"

/area/torch/bridgedeck/maintenance/aftstarboard
	name = "Bridge Deck Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/torch/bridgedeck/maintenance/substation // First Deck (Z-4)
	name = "Bridge Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/bridgedeck/safe_room
	name = "\improper Bridge Safe Room"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/torch/bridgedeck/bridge
	name = "\improper SEV Torch Bridge"
	icon_state = "bridge"
	minimap_color = MINIMAP_AREA_COMMAND

/area/torch/bridgedeck/bridge_hallway
	name = "\improper Bridge Access Hallway"
	icon_state = "bridge_hallway"
	minimap_color = MINIMAP_AREA_JUNGLE

/area/torch/bridgedeck/bridge_hallway/port
	name = "\improper Bridge Port Access Hallway"

/area/torch/bridgedeck/bridge_hallway/starboard
	name = "\improper Bridge Starboard Access Hallway"

/area/torch/bridgedeck/storage
	name = "\improper Bridge Storage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/bridgedeck/aux_eva
	name = "\improper Command EVA Storage"
	icon_state = "eva"
	minimap_color = MINIMAP_SQUAD_BRAVO

/area/torch/bridgedeck/disciplinary_board_room
	name = "\improper Disciplinary Board Room"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/torch/bridgedeck/disciplinary_board_room/deliberation
	name = "\improper Deliberation Room"

/area/torch/bridgedeck/meeting_room
	name = "\improper Command Meeting Room"
	icon_state = "bridge_meeting"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/torch/bridgedeck/sea
	icon_state = "heads_sea"
	name = "\improper Command - SEA's Office"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/torch/bridgedeck/co
	icon_state = "heads_cap"
	name = "\improper Command - CO's Office"
	minimap_color = MINIMAP_AREA_COMMAND

/area/torch/bridgedeck/co_bed
	icon_state = "heads_cap"
	name = "\improper Command - CO's Quarters"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/torch/bridgedeck/cl
	icon_state = "heads_cl"
	name = "\improper Command - CL's Office"
	minimap_color = MINIMAP_SQUAD_PMC

/area/torch/bridgedeck/cl/backroom
	icon_state = "heads_cl"
	name = "\improper Command - CL's Backroom"

/area/torch/bridgedeck/rd
	icon_state = "heads_rd"
	name = "\improper Command - CSO's Office"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/torch/bridgedeck/sgr
	icon_state = "heads_sr"
	name = "\improper Command - SCGR's Office"
	minimap_color = MINIMAP_SQUAD_PMC


/area/torch/bridgedeck/maintenance/auxsolarbridge
	name = "Solar Maintenance - Bridge"
	icon_state = "SolarcontrolS"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/bridgedeck/cmo
	icon_state = "heads_cmo"
	name = "\improper Command - CMO's Office"
	minimap_color = MINIMAP_AREA_MEDBAY
//a
/area/torch/bridgedeck/ce
	icon_state = "heads_ce"
	name = "\improper Engineering - CE's Office"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/bridgedeck/cos
	icon_state = "heads_hos"
	name = "\improper Command - CoS' Office"
	minimap_color = MINIMAP_AREA_SEC

/area/torch/bridgedeck/xo
	icon_state = "heads_hop"
	name = "\improper Command - XO's Office"
	minimap_color = MINIMAP_AREA_COMMAND

/area/torch/bridgedeck/bridgecheck
	name = "\improper Bridge Deck Security Checkpoint"
	icon_state = "checkpoint"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/torch/firstdeck
	fake_zlevel = 5

/area/torch/firstdeck/maintenance
	name = "First Deck Maintenance"
	icon_state = "maintcentral"
	minimap_color = MINIMAP_MARS_DIRT

/area/torch/firstdeck/maintenance/aftstarboard
	name = "First Deck Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/torch/firstdeck/maintenance/aftport
	name = "First Deck Aft Port Maintenance"
	icon_state = "apmaint"

/area/torch/firstdeck/maintenance/forestarboard
	name = "First Deck Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/torch/firstdeck/maintenance/foreport
	name = "First Deck Fore Port Maintenance"
	icon_state = "fpmaint"

/area/torch/firstdeck/maintenance/centralstarboard
	name = "First Deck Starboard Maintenance"
	icon_state = "smaint"

/area/torch/firstdeck/maintenance/centralport
	name = "First Deck Port Maintenance"
	icon_state = "pmaint"

/area/torch/firstdeck/teleporter
	name = "\improper First Deck Teleporter"
	icon_state = "teleporter"

/area/torch/firstdeck/hallway
	minimap_color = MINIMAP_AREA_JUNGLE

/area/torch/firstdeck/hallway/fore
	name = "\improper First Deck Fore Hallway"
	icon_state = "hallF"

/area/torch/firstdeck/hallway/center
	name = "\improper First Deck Central Hallway"
	icon_state = "hallC1"

/area/torch/firstdeck/hallway/aft
	name = "\improper First Deck Aft Hallway"
	icon_state = "hallA"

/area/torch/firstdeck/safe_room
	name = "\improper First Deck Safe Room"

/area/torch/firstdeck/safe_room/medical
	name = "\improper Medical Safe Room"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/torch/firstdeck/maintenance/substation // First Deck (Z-4)
	name = "First Deck Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/firstdeck/fuelbay
	name = "\improper Auxiliary Fuel Bay"
	icon_state = "engineering"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/firstdeck/nuke_storage
	name = "\improper Vault"
	icon_state = "nuke_storage"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/torch/firstdeck/bathroom
	name = "\improper First Deck Head"

/area/torch/firstdeck/security
	minimap_color = MINIMAP_AREA_SEC

/area/torch/firstdeck/security/wing
	name = "\improper Security Wing"
	icon_state = "security"

/area/torch/firstdeck/security/questioning
	name = "\improper Security - Interview Room"
	icon_state = "security"

/area/torch/firstdeck/security/processing
	name = "\improper Security - Processing"
	icon_state = "security"

/area/torch/firstdeck/security/evidence
	name = "\improper Security - Evidence Storage"
	icon_state = "security"

/area/torch/firstdeck/security/locker
	name = "\improper Security - Locker Room"
	icon_state = "security"

/area/torch/firstdeck/security/detectives_office
	name = "\improper Security - Investigations Office"
	icon_state = "detective"

/area/torch/firstdeck/security/armoury
	name = "\improper Security - Armory"
	icon_state = "Warden"

/area/torch/firstdeck/security/secure_storage
	name = "\improper Security - Secure Storage"
	icon_state = "security"

/area/torch/firstdeck/security/storage
	name = "\improper Security - Equipment Storage"
	icon_state = "security"

/area/torch/firstdeck/brig
	name = "\improper Security - Brig"
	icon_state = "brig"

/area/torch/firstdeck/security/bo
	name = "\improper Security - Brig Chief"
	icon_state = "Warden"

/area/torch/firstdeck/cryo
	name = "\improper First Deck Cryogenic Storage"
	icon_state = "Sleep"
	minimap_color = MINIMAP_AREA_CELL_LOW

/area/torch/firstdeck/chargebay
	name = "\improper Mech Bay"
	icon_state = "mechbay"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE


/area/torch/firstdeck/laboratory
	name = "\improper Robotics Laboratory"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/torch/firstdeck/robotics_office
	name = "\improper Robotics Office"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/torch/firstdeck/auxpower
	name = "\improper Auxiliary Power Storage"
	icon_state = "engine_smes"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/firstdeck/medical
	minimap_color = MINIMAP_AREA_MEDBAY

/area/torch/firstdeck/medical/hallway
	name = "\improper Medical Public Hallway"
	icon_state = "medbay"

/area/torch/firstdeck/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"

/area/torch/firstdeck/medical/staging
	name = "\improper Infirmary Staging"
	icon_state = "patients"

/area/torch/firstdeck/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"

/area/torch/firstdeck/medical/sleeper
	name = "\improper Emergency Treatment Centre"
	icon_state = "exam_room"

/area/torch/firstdeck/medical/surgery
	name = "\improper Operating Theatre 1"
	icon_state = "surgery"

/area/torch/firstdeck/medical/surgery2
	name = "\improper Operating Theatre 2"
	icon_state = "surgery"

/area/torch/firstdeck/medical/washroom
	name = "\improper Medical Washroom"
	icon_state = "toilet"

/area/torch/firstdeck/medical/medpaperworkoffice
	name = "\improper Medical Paperwork Office"
	icon_state = "locker"

/area/torch/firstdeck/medical/locker
	name = "\improper Medical Locker Room"
	icon_state = "locker"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/torch/firstdeck/medical/equipstorage
	name = "\improper Medical Equipment Storage"
	icon_state = "medbay4"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/torch/firstdeck/medical/foyer
	name = "\improper Medical Foyer"
	icon_state = "medbay"

/area/torch/firstdeck/medical/foyer/storeroom
	name = "\improper Medical Storeroom"
	icon_state = "medbay"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/torch/firstdeck/medical/morgue/autopsy
	name = "\improper Autopsy"
	icon_state = "autopsy"
	minimap_color = COLOR_BLACK

/area/torch/firstdeck/counselor
	name = "\improper Counselor's Office"
	icon_state = "medbay3"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/torch/firstdeck/counselor/therapy
	name = "\improper Counselor's Therapy Room"
	icon_state = "medbay3"

/area/torch/firstdeck/hardstorage
	name = "\improper Auxiliary Engineering Hard Storage"
	icon_state = "engineering_storage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/firstdeck/thruster/d1port
	name = "\improper First Deck Port Nacelle"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/firstdeck/thruster/d1starboard
	name = "\improper First Deck Starboard Nacelle"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/firstdeck/research
	minimap_color = MINIMAP_AREA_RESEARCH

/area/torch/firstdeck/research/entry
	name = "\improper Research and Development Access"
	icon_state = "decontamination"

/area/torch/firstdeck/research/locker
	name = "\improper Research Locker Room"
	icon_state = "locker"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/torch/firstdeck/research/hallway
	name = "\improper Research Hallway"
	icon_state = "research"

/area/torch/firstdeck/research/office
	name = "\improper Research Paperwork Office"
	icon_state = "devlab"


/area/torch/firstdeck/research/misc_lab
	name = "\improper Miscellaneous Research"
	icon_state = "misclab"

/area/torch/firstdeck/research/xenoflora
	name = "\improper Xenoflora Lab"
	icon_state = "xeno_f_lab"

/area/torch/firstdeck/research/xenoflora_storage
	name = "\improper Xenoflora Storage"
	icon_state = "xeno_f_store"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/torch/firstdeck/research/development
	name = "\improper Fabricator Lab"
	icon_state = "devlab"

/area/torch/firstdeck/research/xenobiology/entry
	name = "\improper Xenobiology Access"
	icon_state = "xeno_lab"

/area/torch/firstdeck/research/xenobiology
	name = "\improper Xenobiology Lab"
	icon_state = "xeno_lab"

/area/torch/firstdeck/research/xenobiology/cell_1
	name = "\improper Xenobiology Containment Cell 1"
	icon_state = "xeno_lab_cell_1"

/area/torch/firstdeck/research/xenobiology/cell_2
	name = "\improper Xenobiology Containment Cell 2"
	icon_state = "xeno_lab_cell_2"

/area/torch/firstdeck/research/xenobiology/cell_3
	name = "\improper Xenobiology Containment Cell 3"
	icon_state = "xeno_lab_cell_3"

/area/torch/firstdeck/research/xenobiology/cell_4
	name = "\improper Xenobiology Containment Cell 4"
	icon_state = "xeno_lab_cell_4"

/area/torch/firstdeck/opscheck
	name = "\improper First Deck Security Checkpoint"
	icon_state = "checkpoint"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/torch/firstdeck/armoury
	name = "\improper Emergency Armory"
	icon_state = "Warden"
	minimap_color = MINIMAP_AREA_SEC

/area/torch/firstdeck/armoury/access
	name = "\improper Emergency Armory - Access"

/area/torch/firstdeck/armoury/tactical
	name = "\improper Emergency Armory - Tactical"
	icon_state = "Tactical"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/torch/firstdeck/conference
	name = "Briefing Room"
	icon_state = "briefing_room"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/torch/firstdeck/safe_room
	name = "\improper First Deck Safe Room"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/torch/seconddeck
	fake_zlevel = 4

/area/torch/seconddeck/maintenance
	name = "Second Deck Maintenance"
	icon_state = "maintcentral"
	minimap_color = MINIMAP_MARS_DIRT

/area/torch/seconddeck/maintenance/aftstarboard
	name = "Second Deck Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/torch/seconddeck/maintenance/aftport
	name = "Second Deck Aft Port Maintenance"
	icon_state = "apmaint"

/area/torch/seconddeck/maintenance/foreport
	name = "Second Deck Fore Port Maintenance"
	icon_state = "fpmaint"

/area/torch/seconddeck/maintenance/forestarboard
	name = "Second Deck Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/torch/seconddeck/maintenance/central
	name = "Second Deck Central Maintenance"
	icon_state = "maintcentral"

/area/torch/seconddeck/hallway
	minimap_color = MINIMAP_AREA_JUNGLE


/area/torch/seconddeck/hallway/center
	name = "\improper Second Deck Stairwell"

/area/torch/seconddeck/hallway/elevator
	name = "Second Deck Elevator Landing"
	icon_state = "hallC2_e"

/area/torch/seconddeck/hallway/fore
	name = "Second Deck Fore Hallway"
	icon_state = "hallF2"

/area/torch/seconddeck/teleporter
	name = "\improper Second Deck Teleporter"
	icon_state = "teleporter"

/area/torch/seconddeck/maintenance/substation
	name = "Second Deck Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/prototype/engine
	name = "\improper Prototype Fusion Reactor Chamber"
	icon_state = "rust_reactor"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/seconddeck/prototype/control
	name = "\improper Prototype Fusion Reactor Control Room"
	icon_state = "engine_monitoring"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/seconddeck/armory
	name = "\improper Vacant Armory"
	icon_state = "Tactical"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/torch/seconddeck/bluespace
	name = "Bluespace Drive Containment"
	icon_state = "engineering"

/area/torch/seconddeck/bluespacebay
	name = "Bluespace Drive Containment Control Room"
	icon_state = "engineering"

/area/torch/seconddeck/maintenance/incinerator
	name = "\improper Incinerator"
	icon_state = "disposal"

/area/torch/seconddeck/atmos/storage
	name = "\improper Atmospherics Storage"
	icon_state = "atmos_storage"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/shieldbay
	name = "Shield Bay"
	icon_state = "engineering"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/borg_upload
	name = "\improper Cyborg Upload Chamber"
	icon_state = "ai_upload"
	minimap_color = MINIMAP_AREA_COMMAND

/area/torch/seconddeck/robotics/surgery
	name = "\improper Robotics Operating Theatre"
	minimap_color = MINIMAP_AREA_RESEARCH

/area/torch/seconddeck/cargo
	name = "\improper Requisitions Office"
	icon_state = "quart"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/seconddeck/maintenance/auxsolarport
	name = "Solar Maintenance - Port"
	icon_state = "SolarcontrolP"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/cargo
	name = "Cargo Storage"
	icon_state = "quartstorage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/seconddeck/research
	name = "Research Storage"
	icon_state = "toxstorage"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/torch/seconddeck/fuelbay/wastetank
	name = "\improper Waste Tank"
	icon_state = "engineering"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/fuelbay
	name = "\improper Fuel Bay"
	icon_state = "engineering"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/seconddeck/engineering
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/seconddeck/engineering/atmos
	name = "\improper Atmospherics"
	icon_state = "atmos"

/area/torch/seconddeck/engineering/engine_room
	name = "\improper Engine Room"
	icon_state = "engine"

/area/torch/seconddeck/engineering/engine_monitoring
	name = "\improper Engine Monitoring Room"
	icon_state = "engine_monitoring"

/area/torch/seconddeck/engineering/engine_smes
	name = "\improper Engineering SMES"
	icon_state = "engine_smes"

/area/torch/seconddeck/engineering/engineering_bay
	name = "\improper Engineering Bay"
	icon_state = "engineering_locker"

/area/torch/seconddeck/engineering/foyer
	name = "\improper Engineering Foyer"
	icon_state = "engineering_foyer"

/area/torch/seconddeck/engineering/engineering_bay
	name = "\improper Engineering Bay"
	icon_state = "engineering_locker"

/area/torch/seconddeck/engineering/storage
	name = "\improper Engineering Storage"
	icon_state = "engineering_storage"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/medical
	name = "Medical Storage"
	icon_state = "medbay4"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/torch/seconddeck/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"
	minimap_color = COLOR_BLACK

/area/torch/seconddeck/tech
	name = "Technical Storage"
	icon_state = "storage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/seconddeck/maintenance/disposal
	name = "Waste Disposal"
	icon_state = "disposal"

/area/torch/seconddeck/auxstarboard
	name = "\improper Fore Starboard Solar Array"
	icon_state = "panelsA"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/auxsolarport
	name = "Solar Maintenance - Port"
	icon_state = "SolarcontrolP"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/seconddeck/chapel
	name = "\improper Unused Chapel"
	icon_state = "chapel"

/area/torch/thirddeck
	fake_zlevel = 3

/area/torch/thirddeck/hallway
	minimap_color = MINIMAP_AREA_JUNGLE

/area/torch/thirddeck/hallway/fore
	name = "\improper Third Deck Fore Hallway"
	icon_state = "hallF"

/area/torch/thirddeck/hallway/center
	name = "\improper Third Deck Central Hallway"
	icon_state = "hallC3"

/area/torch/thirddeck/hallway/aft
	name = "\improper Third Deck Aft Hallway"
	icon_state = "hallA"

/area/torch/thirddeck/maintenance
	name = "Third Deck Maintenance"
	icon_state = "maintcentral"
	minimap_color = MINIMAP_MARS_DIRT

/area/torch/thirddeck/maintenance/foreport
	name = "Third Deck Fore Port Maintenance"
	icon_state = "fpmaint"

/area/torch/thirddeck/maintenance/forestarboard
	name = "Third Deck Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/torch/thirddeck/maintenance/starboard
	name = "Third Deck Starboard Maintenance"
	icon_state = "smaint"

/area/torch/thirddeck/maintenance/port
	name = "Third Deck Port Maintenance"
	icon_state = "pmaint"

/area/torch/thirddeck/maintenance/aftstarboard
	name = "Third Deck Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/torch/thirddeck/maintenance/aftport
	name = "Third Deck Aft Port Maintenance"
	icon_state = "apmaint"

/area/torch/thirddeck/teleporter
	name = "\improper Third Deck Teleporter"
	icon_state = "teleporter"

/area/torch/thirddeck/maintenance/substation
	name = "Third Deck Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/thirddeck/cryo
	name = "\improper Third Deck Cryogenic Storage"
	icon_state = "Sleep"
	minimap_color = MINIMAP_AREA_CELL_LOW

/area/torch/thirddeck/cryo/bunk
	name = "\improper Bunk Room"
	icon_state = "Sleep"

/area/torch/thirddeck/bathroom
	icon_state = "head_quarters"

/area/torch/thirddeck/bathroom/sauna
	name = "\improper Sauna"
	icon_state = "sauna"

/area/torch/thirddeck/cryo/locker
	name = "\improper Cryogenic Storage Wardrobe"
	icon_state = "locker"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/thirddeck/habcheck
	name = "\improper Third Deck Security Checkpoint"
	icon_state = "checkpoint"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/torch/thirddeck/safe_room
	name = "\improper Third Deck Safe Room"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/torch/thirddeck/teleporter
	name = "\improper Third Deck Teleporter"
	icon_state = "teleporter"

/area/torch/thirddeck/recreation
	name = "\improper Recreation"
	icon_state = "crew_quarters"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/observation
	name = "\improper Observation"
	icon_state = "fitness"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/service_break_room
	name = "\improper Service Break Room"
	icon_state = "fitness"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/janitor
	name = "\improper Custodial Storage Closet"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/thirddeck/chief_steward
	name = "\improper Chief Steward's Office"
	icon_state = "kitchen"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/commissary
	name = "\improper Commissary"
	icon_state = "crew_quarters"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/gym
	name = "\improper Gym"
	icon_state = "fitness"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/atmos
	name = "\improper Auxiliary Atmospherics"
	icon_state = "atmos"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/thirddeck/cabin
	name = "\improper Vacant Cabins"
	icon_state = "crew_quarters"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/chapel
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/chapel/main
	name = "\improper Chapel"
	icon_state = "chapel"

/area/torch/thirddeck/chapel/office
	name = "\improper Chaplain's Office"

/area/torch/thirddeck/chapel/memorial
	name = "\improper Memorial Room"

/area/torch/thirddeck/office
	name = "\improper Computer Lab"
	icon_state = "conference"
	minimap_color = MINIMAP_AREA_CELL_VIP


/area/torch/thirddeck/tools
	name = "Auxiliary Tool Storage"
	icon_state = "auxstorage"
	minimap_color = MINIMAP_AREA_ENGI


/area/torch/thirddeck/hydroponics
	name = "\improper Hydroponics"
	icon_state = "hydro"
	minimap_color = MINIMAP_SQUAD_ECHO

/area/torch/thirddeck/alphadeck
	name = "\improper Holodeck Alpha"

/area/torch/thirddeck/mess
	name = "\improper Old Mess"
	icon_state = "bar"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/hardstorage
	name = "\improper Engineering Hard Storage"
	icon_state = "engineering_storage"
	minimap_color = MINIMAP_SQUAD_BRAVO

/area/torch/thirddeck/d3port
	name = "\improper Third Deck Port Nacelle"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/thirddeck/d3starboard
	name = "\improper Third Deck Starboard Nacelle"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/thirddeck/brig
	name = "\improper Permanent Brig"
	icon_state = "brig"
	minimap_color = MINIMAP_AREA_SEC

/area/torch/thirddeck/mess
	name = "\improper Mess Hall"
	icon_state = "cafeteria"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/thirddeck/mess/galley
	name = "\improper Galley"
	icon_state = "kitchen"

/area/torch/thirddeck/mess/galleybackroom
	name = "\improper Galley Cold Storage"
	icon_state = "kitchen"

/area/torch/thirddeck/disperser
	name = "\improper Obstruction Field Disperser"
	icon_state = "disperser"
	minimap_color = MINIMAP_AREA_CONTESTED_ZONE

/area/torch/thirddeck/old_mess
	name = "\improper Old Mess"
	icon_state = "bar"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/fourthdeck
	fake_zlevel = 2

/area/torch/fourthdeck/hallway
	minimap_color = MINIMAP_AREA_JUNGLE

/area/torch/fourthdeck/hallway/fore
	name = "\improper Fourth Deck Fore Hallway"
	icon_state = "hallF"


/area/torch/fourthdeck/hallway/aft
	name = "\improper Fourth Deck Aft Hallway"
	icon_state = "hallA"

/area/torch/fourthdeck/maintenance
	name = "Fourth Deck Maintenance"
	icon_state = "maintcentral"
	minimap_color = MINIMAP_MARS_DIRT

/area/torch/fourthdeck/maintenance/aft
	name = "Fourth Deck Aft Maintenance"
	icon_state = "amaint"

/area/torch/fourthdeck/maintenance/foreport
	name = "Fourth Deck Fore Port Maintenance"
	icon_state = "fpmaint"

/area/torch/fourthdeck/maintenance/forestarboard
	name = "Fourth Deck Fore Starboard Maintenance"
	icon_state = "fsmaint"

/area/torch/fourthdeck/maintenance/starboard
	name = "Fourth Deck Starboard Maintenance"
	icon_state = "smaint"

/area/torch/fourthdeck/maintenance/port
	name = "Fourth Deck Port Maintenance"
	icon_state = "pmaint"

/area/torch/fourthdeck/teleporter
	name = "\improper Fourth Deck Teleporter"
	icon_state = "teleporter"

/area/torch/fourthdeck/maintenance/substation
	name = "Fourth Deck Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/fourthdeck/catwalks
	name = "\improper Upper Hangar Deck"
	icon_state = "hangar_catwalk_p"
	minimap_color = MINIMAP_ICE

/area/torch/fourthdeck/pathfinder
	name = "\improper Pathfinder's Office"
	icon_state = "pathfinder_office"
	minimap_color = MINIMAP_SQUAD_INTEL

/area/torch/fourthdeck/hangcheck
	name = "\improper Fourth Deck Security Checkpoint"
	icon_state = "checkpoint"
	minimap_color = MINIMAP_AREA_SEC_CAVE

/area/torch/fourthdeck/monitoring
	name = "\improper Auxiliary Monitoring Room"
	icon_state = "engine_monitoring"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/fourthdeck/port_storage
	name = "Port Auxillary Storage"
	icon_state = "auxstorage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fourthdeck/starboard_storage
	name = "Starboard Auxillary Storage"
	icon_state = "auxstorage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fourthdeck/eva
	name = "\improper EVA Storage"
	icon_state = "eva"
	minimap_color = MINIMAP_SQUAD_BRAVO


/area/torch/fourthdeck/diplomatic_office
	name = "\improper Diplomatic Meeting Room"
	icon_state = "crew_quarters"
	minimap_color = MINIMAP_AREA_COMMAND_CAVE

/area/torch/fourthdeck/tools
	name = "Primary Tool Storage"
	icon_state = "primarystorage"
	minimap_color = MINIMAP_AREA_ENGI

/area/torch/fourthdeck/lounge
	name = "\improper Lounge"
	icon_state = "crew_quarters"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/fourthdeck/quartermaster/office
	name = "\improper Supply Office"
	icon_state = "quartoffice"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fourthdeck/quartermaster/sorting
	name ="\improper Supply Sorting"
	icon_state = "quartstorage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fourthdeck/quartermaster/storage/upper
	name = "\improper Supply Upper Warehouse"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fourthdeck/quartermaster/deckchief
	name = "\improper Deck Chief's Office"
	icon_state = "quart"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fourthdeck/laundry
	name = "\improper Laundry Room"
	icon_state = "Sleep"

/area/torch/fourthdeck/bathroom
	name = "\improper Fourth Deck Head"

/area/torch/fourthdeck/maintenance/waterstore
	name = "\improper Cistern"
	icon_state = "disposal"

/area/torch/fourthdeck/captainmess
	name = "Officer's Mess"
	icon_state = "bar"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/fourthdeck/adherent
	name = "\improper Adherent Maintenence"
	icon_state = "robotics"

/area/torch/fourthdeck/tcommsat/chamber
	name = "\improper Telecoms Central Compartment"
	icon_state = "tcomsatcham"
	minimap_color = MINIMAP_AREA_COMMAND

/area/torch/fourthdeck/tcommsat/computer
	name = "\improper Telecoms Control Room"
	icon_state = "tcomsatcomp"

/area/torch/fifthdeck
	fake_zlevel = 1

/area/torch/fifthdeck/hallway
	minimap_color = MINIMAP_AREA_JUNGLE

/area/torch/fifthdeck/hallway/fore
	name = "\improper Fifth Deck Fore Hallway"
	icon_state = "hallF"

/area/torch/fifthdeck/hallway/aft
	name = "\improper Fifth Deck Aft Hallway"
	icon_state = "hallA"

/area/torch/fifthdeck/maintenance
	minimap_color = MINIMAP_MARS_DIRT

/area/torch/fifthdeck/maintenance/fifthdeck
	name = "Fifth Deck Maintenance"
	icon_state = "maintcentral"

/area/torch/fifthdeck/maintenance/aftport
	name = "Fifth Deck Aft Port Maintenance"
	icon_state = "apmaint"

/area/torch/fifthdeck/maintenance/aftstarboard
	name = "Fifth Deck Aft Starboard Maintenance"
	icon_state = "asmaint"

/area/torch/fifthdeck/maintenance/fore
	name = "Fifth Deck Fore Maintenance"
	icon_state = "fmaint"

/area/torch/fifthdeck/maintenance/substation
	name = "Fifth Deck Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/fifthdeck/maintenance/substation_hanger
	name = "Hangar Substation"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/fifthdeck/hangar
	name = "\improper Hangar Deck"
	icon_state = "hangar"
	minimap_color = MINIMAP_SQUAD_INTEL

/area/torch/fifthdeck/expedition
	name = "\improper Expedition Preparation"
	icon_state = "mining"
	minimap_color = MINIMAP_SQUAD_INTEL

/area/torch/fifthdeck/expedition/eva
	name = "\improper Expedition EVA"
	icon_state = "mining"
	minimap_color = MINIMAP_SQUAD_BRAVO

/area/torch/fifthdeck/expedition_storage
	name = "\improper Hangar Expedition Storage"
	icon_state = "mining"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fifthdeck/storage
	name = "\improper Supply Warehouse"
	icon_state = "quartstorage"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fifthdeck/shuttlefuel
	name = "\improper Shuttle Fuel Bay"
	icon_state = "toxstorage"
	minimap_color = MINIMAP_AREA_ENGI_CAVE

/area/torch/fifthdeck/exploration
	name = "\improper Exploration Equipment"
	icon_state = "exploration"
	minimap_color = MINIMAP_AREA_CELL_HIGH

/area/torch/fifthdeck/pilot
	name = "\improper Pilot's Lounge"
	icon_state = "pilot_lounge"
	minimap_color = MINIMAP_SQUAD_INTEL

/area/torch/fifthdeck/bar
	name = "\improper Hidden Bar"
	icon_state = "bar"
	minimap_color = MINIMAP_AREA_CELL_VIP

/area/torch/petrov
	name = "\improper SRV Petrov"
	minimap_color = MINIMAP_AREA_SHIP

/area/torch/petrov/cell1
	name = "\improper SRV Petrov - Isolation Cell 1"
	icon_state = "shuttle"
/area/torch/petrov/cell2
	name = "\improper SRV Petrov - Isolation Cell 2"
	icon_state = "shuttlegrn"
/area/torch/petrov/cell3
	name = "\improper SRV Petrov - Isolation Cell 3"
	icon_state = "shuttle"

/area/torch/petrov/hallwaya
	name = "\improper SRV Petrov - Lower Hallway"
	icon_state = "hallA"

/area/torch/petrov/control
	name = "\improper SRV Petrov - Control Room"
	icon_state = "checkpoint1"

/area/torch/petrov/rd
	icon_state = "heads_rd"
	name = "\improper SRV Petrov - CSO's Office"
	icon_state = "head_quarters"
/area/torch/petrov/cockpit
	name = "\improper SRV Petrov - Cockpit"
	icon_state = "shuttlered"

/area/torch/petrov/maint
	name = "\improper SRV Petrov - Maintenance"
	icon_state = "engine"

/area/torch/petrov/analysis
	name = "\improper SRV Petrov - Analysis Lab"
	icon_state = "devlab"

/area/torch/petrov/toxins
	name = "\improper SRV Petrov - Toxins Lab"
	icon_state = "toxstorage"

/area/torch/petrov/rnd
	name = "\improper SRV Petrov - Fabricator Lab"
	icon_state = "devlab"

/area/torch/petrov/isolation
	name = "\improper SRV Petrov - Isolation Lab"
	icon_state = "xeno_lab"

/area/torch/petrov/phoron
	name = "\improper SRV Petrov - Sublimation Lab"
	icon_state = "toxstorage"

/area/torch/petrov/custodial
	name = "\improper SRV Petrov - Custodial"
	icon_state = "decontamination"

/area/torch/petrov/equipment
	name = "\improper SRV Petrov - Equipment Storage"
	icon_state = "locker"

/area/torch/petrov/eva
	name = "\improper SRV Petrov - EVA Storage"
	icon_state = "locker"

/area/torch/fifthdeck/canister
	name = "\improper Canister Storage"
	icon_state = "toxstorage"

/area/torch/guppy_hangar
	name = "\improper Guppy"
	icon_state = "shuttlered"

/area/torch/fifthdeck/maintenance/infirmary
	name = "\improper Auxiliary Infirmary"
	icon_state = "medbay"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/space/minimap_show
	minimap_color = MINIMAP_SOLID
	icon = 'icons/turf/torch.dmi'
	icon_state = "bluenew"
