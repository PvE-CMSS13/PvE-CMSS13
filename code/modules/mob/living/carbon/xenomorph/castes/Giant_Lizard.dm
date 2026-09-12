/datum/caste_datum/giant_lizard //The jungle nightmare
	caste_type = XENO_CASTE_GIANT_LIZARD //For when you want to hunt folks with lizards
	tier = 1
	melee_damage_lower = XENO_DAMAGE_TIER_3
	melee_damage_upper = XENO_DAMAGE_TIER_4
	melee_vehicle_damage = XENO_DAMAGE_TIER_2
	max_health = XENO_HEALTH_TIER_3
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_10
	xeno_explosion_resistance = XENO_NO_EXPLOSIVE_ARMOR
	armor_deflection = XENO_NO_ARMOR
	evasion = XENO_EVASION_LOW
	speed = XENO_SPEED_HELLHOUND
	fire_vulnerability_mult = FIRE_MULTIPLIER_EXTREME //weak to fire

	caste_desc = "A prowler of the jungles."
	evolves_to = list()
	deevolves_to = list()

	heal_resting = 1
	heal_standing = 0.5
	heal_knocked_out = 0.25
	innate_healing = TRUE

	behavior_delegate_type = /datum/behavior_delegate/giant_lizard
	minimap_icon = "runner"

/mob/living/carbon/xenomorph/giant_lizard
	caste_type = XENO_CASTE_GIANT_LIZARD
	name = XENO_CASTE_GIANT_LIZARD
	desc = "A large, wolf-like reptile. Its eyes are keenly focused on yours."
	icon = 'icons/mob/xenos/giant_lizard.dmi'
	icon_size = 64
	pixel_x = -16
	old_x = -16
	icon_state = "Normal Giant Lizard Running"
	plasma_types = list(PLASMA_CHITIN)
	mob_size = MOB_SIZE_XENO_SMALL
	tier = 1

	slash_verb = "bite"
	slashes_verb = "bites"
	slash_sound = 'sound/weapons/bite.ogg'

	acid_blood_damage = 0 /// it's a lizard innit
	acid_blood_spatter = FALSE /// We dont want that for these guys

	icon_xeno = 'icons/mob/xenos/giant_lizard.dmi'
	icon_xenonid = 'icons/mob/xenos/giant_lizard.dmi'

	weed_food_icon = 'icons/mob/xenos/weeds.dmi'
	weed_food_states = list("Hellhound_1","Hellhound_2","Hellhound_3")
	weed_food_states_flipped = list("Hellhound_1","Hellhound_2","Hellhound_3")

	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/activable/pounce,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	gib_chance = 0
	claw_type = CLAW_TYPE_SHARP
	pull_multiplier = 0.8

	target_unconscious = FALSE

/datum/action/xeno_action/activable/pounce
		ai_prob_chance = 50
		distance = 3

/datum/behavior_delegate/giant_lizard/melee_attack_additional_effects_target(mob/living/carbon/A)
	if(prob(50))
		A.apply_damage(5, OXY)
		to_chat(A, SPAN_XENOHIGHDANGER("You feel woozy, as the [bound_xeno] bites into you with teeth that drip with shimmering saliva!"))
		A.sway_jitter(times = 5, steps = 3)
		A.apply_effect(1, PARALYZE)
		A.apply_effect(10, EYE_BLUR)


/mob/living/carbon/xenomorph/giant_lizard/death(cause, gibbed)
	. = ..(cause, gibbed, "lets out a waning growl.")
	if(!.)
		return

/mob/living/carbon/xenomorph/giant_lizard/handle_blood_splatter(splatter_dir)
	new /obj/effect/temp_visual/dir_setting/bloodsplatter/human(loc, splatter_dir)

