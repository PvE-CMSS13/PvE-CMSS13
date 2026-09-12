/datum/caste_datum/alien
	caste_type = XENO_CASTE_ALIEN
	tier = 2
	melee_damage_lower = XENO_DAMAGE_TIER_3
	melee_damage_upper = XENO_DAMAGE_TIER_4
	melee_vehicle_damage = XENO_DAMAGE_TIER_3
	max_health = XENO_HEALTH_ALIEN
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_10 * 10
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_1
	armor_deflection = XENO_ARMOR_TIER_1
	evasion = XENO_EVASION_MEDIUM
	speed = XENO_SPEED_HELLHOUND //Faster than drones, slower than lurkers.

	caste_desc = "Creature from outer space."
	evolves_to = list(XENO_CASTE_QUEEN) //Add more here separated by commas
	deevolves_to = list("Drone")

	can_hold_facehuggers = 1
	can_hold_eggs = CAN_HOLD_TWO_HANDS
	max_build_dist = 1

	tackle_min = 1
	tackle_max = 2
	tackle_chance = 90
	tacklestrength_min = 1
	tacklestrength_max = 2

	minimap_icon = "warrior"


/mob/living/carbon/xenomorph/alien
	caste_type = XENO_CASTE_ALIEN
	name = XENO_CASTE_ALIEN
	desc = "Chitinous monstrosity."
	icon = 'icons/mob/xenos/thealien.dmi'
	icon_size = 48
	icon_state = "Normal Alien Walking"
	plasma_types = list(PLASMA_PURPLE)
	tier = 2
	organ_value = 800
	pixel_x = -12
	old_x = -12
	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/regurgitate,
		/datum/action/xeno_action/activable/tail_stab,
		/datum/action/xeno_action/activable/pounce/runner,
		/datum/action/xeno_action/onclick/xenohide,
		/datum/action/xeno_action/activable/corrosive_acid/strong,
		/datum/action/xeno_action/activable/fling/alien,
		/datum/action/xeno_action/activable/headbite,
		/datum/action/xeno_action/activable/lunge/alien,
		/datum/action/xeno_action/onclick/plant_weeds, //first macro
		/datum/action/xeno_action/onclick/choose_resin, //second macro
		/datum/action/xeno_action/activable/secrete_resin, //third macro
		)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

	icon_xeno = 'icons/mob/xenos/thealien.dmi'
	icon_xenonid = 'icons/mob/xenonids/drone.dmi'
	weed_food_icon = 'icons/mob/xenos/weeds_48x48.dmi'
	weed_food_states = list("Drone_1","Drone_2","Drone_3")
	weed_food_states_flipped = list("Drone_1","Drone_2","Drone_3")
	universal_understand = TRUE
	acid_blood_damage = 50
	acid_splash_cooldown = 20
	pull_multiplier = 0.2 /// Pretty much no pull delay, for those quick drags.
	claw_type = CLAW_TYPE_SHARP
	preset_name = "The Alien"

/mob/living/carbon/xenomorph/alien/Initialize(ai_hard_off = TRUE)
	. = ..()
	preset_name = pick("Abomination", "Monstrosity", "Alien")
	generate_name()
