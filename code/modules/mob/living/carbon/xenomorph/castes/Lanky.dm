/datum/caste_datum/lanky
	caste_type = XENO_CASTE_LANKY
	tier = 3

	melee_damage_lower = XENO_DAMAGE_TIER_6
	melee_damage_upper = XENO_DAMAGE_TIER_6
	melee_vehicle_damage = XENO_DAMAGE_TIER_5 * 10
	max_health = XENO_HEALTH_IMMORTAL
	plasma_gain = XENO_PLASMA_GAIN_TIER_7
	plasma_max = XENO_PLASMA_TIER_8
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_10
	armor_deflection = XENO_ARMOR_TIER_9
	evasion = XENO_EVASION_NONE
	speed = XENO_SPEED_LANKY
	heal_standing = 0.66

	evolution_allowed = TRUE
	evolves_to = list()
	deevolves_to = list()
	caste_desc = "The typical bipedal Lankies when they seed worlds."

	tackle_min = 2
	tackle_max = 6
	tackle_chance = 25

	behavior_delegate_type = /datum/behavior_delegate/lanky
	minimap_icon = "runner"

/mob/living/carbon/xenomorph/lanky
	caste_type = XENO_CASTE_LANKY
	name = XENO_CASTE_LANKY
	desc = "A tall, bipedal alien with strange growths and a thick exoskeleton."
	icon = 'icons/mob/xenos/lanky.dmi'
	icon_size = 64
	icon_state = "Normal Lanky Walking"
	plasma_types = list(PLASMA_CHITIN)
	pixel_x = -16
	old_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead xeno is hard
	tier = 3
	organ_value = 3000

	small_explosives_stun = FALSE

	acid_blood_damage = 0 /// it's a lanky innit
	acid_blood_spatter = FALSE /// We dont want that for these guys

	mob_size = MOB_SIZE_IMMOBILE

	rebounds = FALSE // no more fucking pinball crooshers
	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/onclick/crusher_stomp,
		/datum/action/xeno_action/onclick/tacmap,
	)

	gib_chance = 0
	claw_type = CLAW_TYPE_VERY_SHARP

	icon_xeno = 'icons/mob/xenos/lanky.dmi'
	icon_xenonid = 'icons/mob/xenonids/praetorian.dmi'

	weed_food_icon = 'icons/mob/xenos/weeds_64x64.dmi'
	weed_food_states = list("Praetorian_1","Praetorian_2","Praetorian_3")
	weed_food_states_flipped = list("Praetorian_1","Praetorian_2","Praetorian_3")

	ai_range = 24
	forced_retarget_time = (3 SECONDS)

/mob/living/carbon/xenomorph/lanky/Initialize(mapload, mob/living/carbon/xenomorph/oldXeno, h_number, ai_hard_off = FALSE)
	. = ..()
	AddComponent(/datum/component/footstep, 2, 50, 15, 1, "metalbang")

	playsound(src, 'sound/voice/xeno_praetorian_screech.ogg', 100, TRUE, 30, falloff = 5)
	if(!get_turf(src)) //autowiki compat, spawns in nullspace
		return
	for(var/mob/current_mob as anything in get_mobs_in_z_level_range(get_turf(src), 30) - src)
		var/relative_dir = get_dir(current_mob, src)
		var/final_dir = dir2text(relative_dir)
		to_chat(current_mob, SPAN_HIGHDANGER("You hear a terrible screech coming from [final_dir ? "the [final_dir]" : "nearby"] as the ground shakes!"))
		for(var/turf/closed/wall/wall in orange(1, src))
			wall.ex_act(1000 * 1.5)


/mob/living/carbon/xenomorph/lanky/death(cause, gibbed)
	. = ..()
	playsound(src, 'sound/voice/alien_crusher_death.ogg', 50, FALSE, 15)

/datum/behavior_delegate/lanky/melee_attack_additional_effects_target(mob/living/carbon/A)
	if(prob(50))
		A.apply_damage(5, OXY)
		to_chat(A, SPAN_XENOHIGHDANGER("You feel dizzy from the impact when [bound_xeno] slams into you!"))
		A.sway_jitter(times = 5, steps = 3)
		A.apply_effect(10, EYE_BLUR)


/mob/living/carbon/xenomorph/lanky/handle_blood_splatter(splatter_dir)
	new /obj/effect/temp_visual/dir_setting/bloodsplatter/yautjasplatter(loc, splatter_dir)
