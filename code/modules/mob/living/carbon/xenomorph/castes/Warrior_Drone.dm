/datum/caste_datum/warrior_drone //Better than a drone with no soldier abilities the warrior drone is for when you want something inbetween.
	caste_type = XENO_CASTE_WARRIOR_DRONE //^More for rounds where you want less hordes
	tier = 2
	melee_damage_lower = XENO_DAMAGE_TIER_3
	melee_damage_upper = XENO_DAMAGE_TIER_4
	melee_vehicle_damage = XENO_DAMAGE_TIER_3
	max_health = XENO_HEALTH_TIER_1
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_10
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_1
	armor_deflection = XENO_ARMOR_TIER_1
	evasion = XENO_EVASION_MEDIUM
	speed = XENO_SPEED_TIER_7_5 //Faster than drones, slower than lurkers.

	caste_desc = "A warrior of the hive."
	evolves_to = list(XENO_CASTE_QUEEN, XENO_CASTE_BURROWER, XENO_CASTE_CARRIER, XENO_CASTE_HIVELORD) //Add more here separated by commas
	deevolves_to = list("Drone")

	tackle_min = 2
	tackle_max = 3

	minimap_icon = "warrior"

/mob/living/carbon/xenomorph/warrior_drone
	caste_type = XENO_CASTE_WARRIOR_DRONE
	name = XENO_CASTE_WARRIOR_DRONE
	desc = "An alien warrior."
	icon = 'icons/mob/xenos/warriordrone.dmi'
	icon_size = 48
	icon_state = "Warrior Drone Walking"
	plasma_types = list(PLASMA_PURPLE)
	tier = 2
	pixel_x = -12
	old_x = -12
	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/regurgitate,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	gib_chance = 100
	claw_type = CLAW_TYPE_SHARP
	pull_multiplier = 0.2 /// Pretty much no pull delay, for those quick drags.

	acid_blood_damage = 30 /// Better than drone worse than soldier
	acid_blood_spatter = FALSE /// We dont want that for these guys

	icon_xeno = 'icons/mob/xenos/warriordrone.dmi'
	icon_xenonid = 'icons/mob/xenonids/drone.dmi'

	target_unconscious = FALSE
