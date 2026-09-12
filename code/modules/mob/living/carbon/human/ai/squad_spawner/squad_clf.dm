/datum/human_ai_squad_preset/clf
	faction = "Insurrectionists"

/datum/human_ai_squad_preset/clf/patrol
	name = "TWE Rebel, Patrol"
	desc = "A rebel patrol armed with Bizon SMGs, MAR variant rifles and uncommonly an F90 rifle, and carrying IFAKs with gauze, ointment and injectors."
	ai_to_spawn = list(
		/datum/equipment_preset/clf/soldier = 2,
	)

/datum/human_ai_squad_preset/clf/at
	name = "TWE Rebel, Anti-Tank Team"
	desc = "A rebel patrol with a few M83 SADAR launchers and armed with a Bizon SMG, MAR variant rifle and uncommonly an F90 rifle, and carrying IFAKs with gauze, ointment and injectors."
	ai_to_spawn = list(
		/datum/equipment_preset/clf/engineer = 1,
		/datum/equipment_preset/clf/soldier = 1,
	)

/datum/human_ai_squad_preset/clf/fortified
	name = "TWE Rebel, Defensive Team"
	desc = "Best utilized for defensive positions; armed with a M240A1 incinerator, Bizon SMGs, MAR variant rifles, uncommonly a F90, and ample medical supplies."
	ai_to_spawn = list(
		/datum/equipment_preset/clf/soldier = 2,
		/datum/equipment_preset/clf/soldier/flamer = 1,
		/datum/equipment_preset/clf/medic = 1,
	)

/datum/human_ai_squad_preset/clf/leader_escort
	name = "TWE Rebel, Squad"
	desc = "A rebel patrol armed with a Bizon SMG, MAR variant rifle and uncommonly an F90 rifle, and ample medical supplies."
	ai_to_spawn = list(
		/datum/equipment_preset/clf/leader = 1,
		/datum/equipment_preset/clf/soldier = 2,
		/datum/equipment_preset/clf/medic = 1,
	)

/datum/human_ai_squad_preset/clf/honor_guard
	name = "TWE Rebel, Command Element"
	ai_to_spawn = list(
		/datum/equipment_preset/clf/commander = 1,
		/datum/equipment_preset/clf/soldier = 2,
		/datum/equipment_preset/clf/medic = 1,
	)

//UA Rebels

/datum/human_ai_squad_preset/clf/ua/patrol
	name = "UA Rebel, Patrol"
	ai_to_spawn = list(
		/datum/equipment_preset/rebel/soldier = 2,
	)

/datum/human_ai_squad_preset/clf/ua/at
	name = "UA Rebel, Anti-Tank Team"
	ai_to_spawn = list(
		/datum/equipment_preset/rebel/at = 1,
		/datum/equipment_preset/rebel/soldier = 1,
	)

/datum/human_ai_squad_preset/clf/ua/fortified
	name = "UA Rebel, Flamethrower Team"
	ai_to_spawn = list(
		/datum/equipment_preset/rebel/soldier = 2,
		/datum/equipment_preset/rebel/soldier/flamer = 1,
		/datum/equipment_preset/rebel/medic = 1,
	)

/datum/human_ai_squad_preset/clf/ua/leader_escort
	name = "UA Rebel, Squad"
	ai_to_spawn = list(
		/datum/equipment_preset/rebel/soldier/leader = 1,
		/datum/equipment_preset/rebel/soldier = 2,
		/datum/equipment_preset/rebel/medic = 1,
	)

/datum/human_ai_squad_preset/clf/ua/support
	name = "UA Rebel, Medic Element"
	ai_to_spawn = list(
		/datum/equipment_preset/rebel/medic = 2,
	)

/datum/human_ai_squad_preset/clf/ua/honor_guard
	name = "UA Rebel, Command Element"
	ai_to_spawn = list(
		/datum/equipment_preset/rebel/commander = 1,
		/datum/equipment_preset/rebel/soldier/leader = 1,
		/datum/equipment_preset/rebel/soldier = 2,
		/datum/equipment_preset/rebel/medic = 1,
	)

/datum/human_ai_squad_preset/clf/canc
	name = "CANC Rebel, Patrol"
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/leader = 1,
		/datum/equipment_preset/canc/remnant = 2,
	)

/datum/human_ai_squad_preset/clf/canc/recruits
	name = "CANC Rebel, Recruits"
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant = 1,
		/datum/equipment_preset/canc/newblood = 2,
	)

/datum/human_ai_squad_preset/clf/canc/mgteam
	name = "CANC Rebel, Machinegun Team"
	ai_to_spawn = list(
		/datum/equipment_preset/canc/machinegunner = 1,
		/datum/equipment_preset/canc/remnant = 1,
	)

/datum/human_ai_squad_preset/clf/canc/lmgteam
	name = "CANC Rebel, Light Machinegun Team"
	ai_to_spawn = list(
		/datum/equipment_preset/canc/newblood_machinegunner = 1,
		/datum/equipment_preset/canc/newblood = 1,
	)

/datum/human_ai_squad_preset/clf/canc/atteam
	name = "CANC Rebel, Anti-Tank Team"
	ai_to_spawn = list(
		/datum/equipment_preset/canc/at = 1,
		/datum/equipment_preset/canc/remnant = 1,
	)
