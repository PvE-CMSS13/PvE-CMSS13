/datum/human_ai_squad_preset/mercs
	faction = FACTION_MERCENARY

/datum/human_ai_squad_preset/mercs/grunts
	name = "Grunt Duo"
	desc = "A duo of mercenary logistics grunts, armed with sidearms."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/grunt = 2,
	)

/datum/human_ai_squad_preset/mercs/grunts/tech
	name = "Grunt Technician Duo"
	desc = "A duo of mercenary technician grunts, armed with sidearms."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/grunt/technician = 2,
	)

/datum/human_ai_squad_preset/mercs/grunts/doctors
	name = "Grunt Medical Duo"
	desc = "A duo of mercenary medical grunts, armed with sidearms."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/grunt/doctor = 2,
	)

/datum/human_ai_squad_preset/mercs/team
	name = "Sentinel Team"
	desc = "A team of sentinels armed with better equipment and armor to respond to hostile action, though their weapon makeup is the same."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/sentinel = 2,
	)

/datum/human_ai_squad_preset/mercs/at
	name = "Sentinel Anti-Tank Team"
	desc = "A team of sentinels armed with better equipment and armor to respond to hostile action, though their weapon makeup is the same. This team specializes in anti-vehicle combat."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/sentinel/at = 2,
		/datum/equipment_preset/mercenary/sentinel = 1,
	)

/datum/human_ai_squad_preset/mercs/mg
	name = "Sentinel MG Team"
	desc = "A team of sentinels armed with better equipment and armor to respond to hostile action, though their weapon makeup is the same. This team specializes in suppressive fire with light machineguns."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/sentinel/mg = 1,
		/datum/equipment_preset/mercenary/sentinel = 2,
	)

/datum/human_ai_squad_preset/mercs/squad
	name = "Sentinel Response Squad"
	desc = "A squad of sentinels, better armed to respond to hostile action. With better armor and equipment, they're a tougher foe to go up against, with a squad leader with an R81M1C Carbine as well."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/sentinel/lead = 1,
		/datum/equipment_preset/mercenary/sentinel = 3,
	)

/datum/human_ai_squad_preset/mercs/command
	name = "Sentinel Response Command Team"
	desc = "A sentinel and supervisor duo, alongside a Synthetic, responsible for the oversight of a sentinel response platoon."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/supervisor/equipped = 1,
		/datum/equipment_preset/mercenary/sentinel = 2,
		/datum/equipment_preset/mercenary/synth = 1,
	)

/datum/human_ai_squad_preset/mercs/response/heavy
	name = "Bulwark Heavy Response Team"
	desc = "A team of heavy Bulwark operatives, armed with rifles and enough armor to hold against most threats encountered, for when everything goes to hell..."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/bulwark = 2,
	)

/datum/human_ai_squad_preset/mercs/response/heavy/shotgun
	name = "Bulwark Heavy Breacher Response Team"
	desc = "A team of heavy Bulwark operatives, armed with slug shotguns and enough armor to hold against most threats encountered, for when everything goes to hell..."
	ai_to_spawn = list(
		/datum/equipment_preset/mercenary/bulwark/breacher = 2,
	)
