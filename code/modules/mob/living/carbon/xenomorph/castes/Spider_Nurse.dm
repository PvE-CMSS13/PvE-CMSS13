/datum/caste_datum/spider_nurse //specialised spitter-esque enemy
	caste_type = XENO_CASTE_SPIDER_NURSE //For when you want to send ranged spiders at the enemy
	tier = 1
	melee_damage_lower = XENO_DAMAGE_TIER_2
	melee_damage_upper = XENO_DAMAGE_TIER_3
	melee_vehicle_damage = XENO_DAMAGE_TIER_2
	max_health = XENO_HEALTH_SPIDER
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_10
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_1
	armor_deflection = XENO_ARMOR_TIER_1
	evasion = XENO_EVASION_LOW
	speed = XENO_SPEED_SPIDER
	fire_vulnerability_mult = FIRE_MULTIPLIER_EXTREME //weak to fire

	caste_desc = "A ranger of the cluster."
	evolves_to = list() //XENO_CASTE_SPIDER_NURSE, XENO_CASTE_SPIDER_HUNTER
	deevolves_to = list(XENO_CASTE_SPIDER_GUARD)

	tackle_min = 2
	tackle_max = 3
	tackle_chance = 20

	heal_resting = 4
	heal_standing = 3
	heal_knocked_out = 2
	innate_healing = TRUE

	behavior_delegate_type = /datum/behavior_delegate/spider_nurse
	minimap_icon = "spitter"

/mob/living/carbon/xenomorph/spider_nurse
	caste_type = XENO_CASTE_SPIDER_NURSE
	name = XENO_CASTE_SPIDER_NURSE
	desc = "A giant arachnoid, furry in a pale hue. It makes you shudder to look at it. This one has shimmering green eyes."
	icon = 'icons/mob/xenos/spider_nurse.dmi'
	icon_size = 48
	icon_state = "Spider Nurse Running"
	plasma_types = list(PLASMA_CHITIN)
	tier = 2

	speaking_noise = "click_talk"

	slash_verb = "bite"
	slashes_verb = "bites"
	slash_sound = 'sound/weapons/bite.ogg'

	acid_blood_damage = 0 /// it's a spider innit
	acid_blood_spatter = FALSE /// We dont want that for these guys

	icon_xeno = 'icons/mob/xenos/spider_nurse.dmi'
	icon_xenonid = 'icons/mob/xenos/spider_nurse.dmi'

	weed_food_icon = 'icons/mob/xenos/weeds.dmi'
	weed_food_states = list("Hellhound_1","Hellhound_2","Hellhound_3")
	weed_food_states_flipped = list("Hellhound_1","Hellhound_2","Hellhound_3")
	var/linger_range = 5
	var/linger_deviation = 1

	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/plant_webs,
		/datum/action/xeno_action/activable/slowing_spit/ai, //first macro
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	gib_chance = 1
	claw_type = CLAW_TYPE_SHARP
	pull_multiplier = 1

	target_unconscious = FALSE

/datum/behavior_delegate/spider_nurse/melee_attack_additional_effects_target(mob/living/carbon/A)
	if(prob(60))
		A.apply_damage(10, TOX)
		to_chat(A, SPAN_XENOHIGHDANGER("You feel woozy, as the [bound_xeno] bites into you with fangs that drip with venom!"))
		A.sway_jitter(times = 3, steps = 2)
		A.apply_effect(5, DAZE)
		A.apply_effect(10, EYE_BLUR)

/mob/living/carbon/xenomorph/spider_nurse/death(cause, gibbed)
	. = ..(cause, gibbed, "lets out a rattle as it collapses, legs siezing up.")
	if(!.)
		return

/mob/living/carbon/xenomorph/spider_nurse/handle_blood_splatter(splatter_dir)
	new /obj/effect/temp_visual/dir_setting/bloodsplatter/yautjasplatter(loc, splatter_dir)

/datum/behavior_delegate/spider_nurse
	name = "Spider Nurse Behavior Delegate"

/datum/action/xeno_action/activable/slowing_spit/ai
	default_ai_action = TRUE
	ai_prob_chance = 85
	xeno_cooldown = 3 SECONDS


/datum/action/xeno_action/activable/slowing_spit/ai/process_ai(mob/living/carbon/xenomorph/parent, delta_time)
	/// Short-circuit. Will return the last thing checked or FALSE if it fails at any step.
	/// We do not need to check for distance here as the tailstab itself will do that; that distance being 2.
	return DT_PROB(ai_prob_chance, delta_time) && use_ability_async(parent.current_target) && (get_dist(parent, parent.current_target) <= 7) && !check_for_obstacles_projectile(parent, parent.current_target, GLOB.ammo_list[/datum/ammo/xeno/toxin])

/proc/check_for_obstacles_projectile(mob/firer, mob/target, obj/projectile/P)
	var/list/turf/path = get_line(firer, target, include_start_atom = FALSE)
	if(!length(path) || get_dist(firer, target) > P.ammo.max_range)
		return TRUE

	var/blocked = FALSE
	for(var/turf/T in path)
		if(T.density && T.opacity)
			blocked = TRUE
			break

		for(var/obj/O in T)
			if(O.get_projectile_hit_boolean(P) && O.opacity)
				blocked = TRUE
				break

	return blocked

/mob/living/carbon/xenomorph/spider_nurse/init_movement_handler()
	var/datum/xeno_ai_movement/linger/linger_movement = new(src)
	linger_movement.linger_range = linger_range
	linger_movement.linger_deviation = linger_deviation
	return linger_movement
