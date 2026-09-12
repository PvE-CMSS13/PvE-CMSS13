/datum/human_ai_equipment_preset/uscm
	faction = FACTION_MARINE

/datum/human_ai_equipment_preset/uscm/rifleman
	name = "USCM Squad Rifleman"
	desc = "Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	path = /datum/equipment_preset/uscm/private_equipped

/datum/human_ai_equipment_preset/uscm/rifleman/battlerifle
	name = "USCM Squad Sniper (M49A6)"
	desc = "Armed with a M49A6 rifle with DU magazines, carries a simple IFAK with gauze, ointment, splints and an injector."
	path = /datum/equipment_preset/uscm/private_equipped/battlerifle

/datum/human_ai_equipment_preset/uscm/smartgunner
	name = "USCM Squad Smartgunner"
	desc = "Armed with a M56A2 smartgun, carries a simple IFAK with gauze, ointment and an injector."
	path = /datum/equipment_preset/uscm/smartgunner_equipped

/datum/human_ai_equipment_preset/uscm/medic
	name = "USCM Squad Corpsman"
	desc = "Able to stablize wounded. Armed with a M41A rifle, carries medical equipment."
	path = /datum/equipment_preset/uscm/medic_equipped

/datum/human_ai_equipment_preset/uscm/squadleader
	name = "USCM Squad Leader"
	desc = "Functionally a rifleman. Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	path = /datum/equipment_preset/uscm/tl_equipped

/datum/human_ai_equipment_preset/uscm/sectionleader
	name = "USCM Section Leader"
	desc = "Functionally a rifleman. Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	path = /datum/equipment_preset/uscm/leader_equipped

//

/datum/human_ai_equipment_preset/uscm/engineer
	name = "USCM Combat Engineer"
	desc = "A USCM Combat engineer, standard equipment with some engineering tools. Per the techmanual these guys are pretty fucking crazy, read it. It's cool."
	path = /datum/equipment_preset/uscm/engineer_equipped

/datum/human_ai_equipment_preset/uscm/mortar_operator
	name = "USCM Mortar Operator"
	desc = "Amred with a pistol this guy operates mortars but doesn't actually have one, use for set dressing"
	path = /datum/equipment_preset/uscm/mortar_operator_equipped

/datum/human_ai_equipment_preset/uscm/rpg_weapons_op
	name = "USCM RPG Weapons Operator"
	desc = "A USCM rocketeer, has an RPG"
	path = /datum/equipment_preset/uscm/specialist_equipped

/datum/human_ai_equipment_preset/uscm/rpg_weapons_loader
	name = "USCM RPG Weapons Loader"
	desc = "USCM RPG assistant, armed with M41A"
	path = /datum/equipment_preset/uscm/specialist_equipped/loader

/datum/human_ai_equipment_preset/uscm/b18_operator
	name = "USCM B18 Operator"
	desc = "USCM B18 Spec, armed with M41A"
	path = /datum/equipment_preset/uscm/specialist_equipped/b18

/datum/human_ai_equipment_preset/uscm/sniper_operator
	name = "USCM Sniper Operator"
	desc = "USCM generic marine outfitted with an M42A"
	path = /datum/equipment_preset/uscm/specialist_equipped/sniper

/datum/human_ai_equipment_preset/uscm/spotter_operator
	name = "USCM Spotter Operator"
	desc = "USCM generic marine spotter"
	path = /datum/equipment_preset/uscm/specialist_equipped/spotter

/datum/human_ai_equipment_preset/uscm/tanker
	name = "USCM Tank Crewman"
	desc = "USCM Tank crewman, armed with a pistol"
	path = /datum/equipment_preset/uscm/tank

/datum/human_ai_equipment_preset/uscm/marsoc
	name = "USCM MARSOC"
	desc = "USCM Special Forces MARSOC. Use sparingly"
	path = /datum/equipment_preset/uscm/marsoc

//

/datum/human_ai_equipment_preset/uscm/combat_android
	name = "USCM Combat Android"
	desc = "You signed documents saying you wouldn't use these..."
	path = /datum/equipment_preset/synth/working_joe/security_android

/datum/human_ai_equipment_preset/uscm/working_joe
	name = "USCM Working Joe"
	desc = "You always know a working joe"
	path = /datum/equipment_preset/synth/working_joe

/datum/human_ai_equipment_preset/uscm/working_joe/engi
	name = "USCM Hazmat Joe"
	desc = "You always know a working joe"
	path = /datum/equipment_preset/synth/working_joe/engi

//EVA
/datum/human_ai_equipment_preset/uscm/eva
	faction = /datum/human_ai_equipment_preset/uscm::faction + " (EVA)"

/datum/human_ai_equipment_preset/uscm/eva/rifleman/eva
	name = "USCM Squad Rifleman EVA"
	desc = "Armed with a M41A or M49A rifle, carries a simple IFAK with gauze, ointment and an injector."
	path = /datum/equipment_preset/uscm/private_equipped/eva

/datum/human_ai_equipment_preset/uscm/eva/rifleman/battlerifle
	name = "USCM Squad Sniper (M49A6)"
	desc = "Armed with a M49A6 rifle with DU magazines, carries a simple IFAK with gauze, ointment, splints and an injector."
	path = /datum/equipment_preset/uscm/private_equipped/eva/battlerifle

/datum/human_ai_equipment_preset/uscm/eva/rifleman/flamer
	name = "EVA USCM Squad Rifleman (Incinerator)"
	desc = "Armed with a M4A3 AP-loaded Pistol and a M240A1 Incinerator."
	path = /datum/equipment_preset/uscm/private_equipped/eva/flamer

/datum/human_ai_equipment_preset/uscm/eva/rifleman/grenade
	name = "USCM Squad Grenadier (M92 HEFA)"
	desc = "Armed with a M4A3 AP-loaded Pistol and a M92 grenade launcher loaded with 30mm HEFA."
	path = /datum/equipment_preset/uscm/private_equipped/eva/grenade

/datum/human_ai_equipment_preset/uscm/eva/rpg_weapons_op
	name = "USCM RPG Weapons Operator"
	desc = "A USCM rocketeer, has an RPG"
	path = /datum/equipment_preset/uscm/specialist_equipped/eva

/datum/human_ai_equipment_preset/uscm/eva/smartgunner
	name = "EVA USCM Squad Smartgunner"
	desc = "Armed with a M56A2 smartgun, carries a simple IFAK with gauze, ointment, splints and an injector."
	path = /datum/equipment_preset/uscm/smartgunner_equipped/eva

/datum/human_ai_equipment_preset/uscm/eva/medic
	name = "EVA USCM Squad Corpsman"
	desc = "Able to stablize wounded. Armed with a M41A rifle, carries medical equipment."
	path = /datum/equipment_preset/uscm/medic_equipped/eva

/datum/human_ai_equipment_preset/uscm/eva/squadleader
	name = "EVA USCM Squad Leader"
	desc = "Functionally a rifleman. Armed with a M41A rifle, carries a simple IFAK with gauze, ointment, splints and an injector."
	path = /datum/equipment_preset/uscm/tl_equipped/eva

/datum/human_ai_equipment_preset/uscm/eva/sectionleader
	name = "EVA USCM Section Leader"
	desc = "Functionally a rifleman. Armed with a M41A rifle, carries a simple IFAK with gauze, ointment, splints and an injector."
	path = /datum/equipment_preset/uscm/leader_equipped/eva


