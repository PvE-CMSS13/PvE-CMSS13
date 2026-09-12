/datum/caste_datum/spider_hunter //The sneaky ambusher
	caste_type = XENO_CASTE_SPIDER_HUNTER //For when you want to hunt
	tier = 1
	melee_damage_lower = XENO_DAMAGE_TIER_3
	melee_damage_upper = XENO_DAMAGE_TIER_4
	melee_vehicle_damage = XENO_DAMAGE_TIER_2
	max_health = XENO_HEALTH_SPIDER
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_10
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_1
	armor_deflection = XENO_ARMOR_TIER_1
	evasion = XENO_EVASION_MEDIUM
	speed = XENO_SPEED_FASTSPIDER
	fire_vulnerability_mult = FIRE_MULTIPLIER_DEADLY //v weak to fire

	caste_desc = "An ambusher from the dark."
	evolves_to = list() //XENO_CASTE_SPIDER_NURSE, XENO_CASTE_SPIDER_HUNTER
	deevolves_to = list(XENO_CASTE_SPIDER_GUARD)

	tackle_min = 3
	tackle_max = 5
	tackle_chance = 50
	tacklestrength_min = 3
	tacklestrength_max = 3

	heal_resting = 3
	heal_standing = 2
	heal_knocked_out = 2
	innate_healing = TRUE

	behavior_delegate_type = /datum/behavior_delegate/spider_hunter
	minimap_icon = "lurker"

/mob/living/carbon/xenomorph/spider_hunter
	caste_type = XENO_CASTE_SPIDER_HUNTER
	name = XENO_CASTE_SPIDER_HUNTER
	desc = "A giant arachnoid, furry and black. It makes you shudder to look at it. This one has glittering purple eyes."
	icon = 'icons/mob/xenos/spider_hunter.dmi'
	icon_size = 48
	icon_state = "Spider Hunter Running"
	plasma_types = list(PLASMA_CHITIN)
	tier = 2

	speaking_noise = "click_talk"

	slash_verb = "bite"
	slashes_verb = "bites"
	slash_sound = 'sound/weapons/bite.ogg'

	acid_blood_damage = 0 /// it's a spider innit
	acid_blood_spatter = FALSE /// We dont want that for these guys

	icon_xeno = 'icons/mob/xenos/spider_hunter.dmi'
	icon_xenonid = 'icons/mob/xenos/spider_hunter.dmi'

	weed_food_icon = 'icons/mob/xenos/weeds.dmi'
	weed_food_states = list("Hellhound_1","Hellhound_2","Hellhound_3")
	weed_food_states_flipped = list("Hellhound_1","Hellhound_2","Hellhound_3")

	target_unconscious = FALSE

	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/plant_webs,
		/datum/action/xeno_action/activable/pounce/lurker,
		/datum/action/xeno_action/onclick/lurker_invisibility,
		/datum/action/xeno_action/onclick/lurker_assassinate,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)
	gib_chance = 1
	claw_type = CLAW_TYPE_SHARP
	pull_multiplier = 0.5

/mob/living/carbon/xenomorph/spider_hunter/death(cause, gibbed)
	. = ..(cause, gibbed, "lets out a rattle as it collapses, legs siezing up.")
	if(!.)
		return

/mob/living/carbon/xenomorph/spider_hunter/handle_blood_splatter(splatter_dir)
	new /obj/effect/temp_visual/dir_setting/bloodsplatter/yautjasplatter(loc, splatter_dir)

	forced_retarget_time = (2 SECONDS)

/mob/living/carbon/xenomorph/spider_hunter/init_movement_handler()
	return new /datum/xeno_ai_movement/linger/lurking(src)

/datum/behavior_delegate/spider_hunter
	name = "Base Spider Hunter Behavior Delegate"

	// Config
	var/invis_recharge_time = 30 SECONDS
	var/invis_start_time = -1 // Special value for when we're not invisible
	var/invis_duration = 20 SECONDS // so we can display how long the spider_hunter is invisible to it

/datum/behavior_delegate/spider_hunter/melee_attack_additional_effects_target(mob/living/carbon/A)
	if(prob(75))
		A.apply_damage(15, TOX)
		to_chat(A, SPAN_XENOHIGHDANGER("You feel woozy, as the [bound_xeno] bites into you with fangs that drip with venom!"))
		A.sway_jitter(times = 5, steps = 3)
		A.apply_effect(5, DAZE)
		A.apply_effect(20, EYE_BLUR)

	return

/datum/behavior_delegate/spider_hunter/melee_attack_additional_effects_self()
	..()

	var/datum/action/xeno_action/onclick/lurker_invisibility/lurker_invis_action = get_action(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
	if (lurker_invis_action)
		lurker_invis_action.invisibility_off() // Full cooldown

/datum/behavior_delegate/spider_hunter/proc/decloak_handler(mob/source)
	SIGNAL_HANDLER
	var/datum/action/xeno_action/onclick/lurker_invisibility/lurker_invis_action = get_action(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
	if(istype(lurker_invis_action))
		lurker_invis_action.invisibility_off(0.5) // Partial refund of remaining time

/// Implementation for enabling invisibility.
/datum/behavior_delegate/spider_hunter/proc/on_invisibility()
	var/datum/action/xeno_action/activable/pounce/lurker/lurker_pounce_action = get_action(bound_xeno, /datum/action/xeno_action/activable/pounce/lurker)
	if(lurker_pounce_action)
		lurker_pounce_action.knockdown = TRUE // pounce knocks down
		lurker_pounce_action.freeze_self = TRUE
	ADD_TRAIT(bound_xeno, TRAIT_CLOAKED, TRAIT_SOURCE_ABILITY("cloak"))
	RegisterSignal(bound_xeno, COMSIG_MOB_EFFECT_CLOAK_CANCEL, PROC_REF(decloak_handler))
	bound_xeno.stealth = TRUE
	invis_start_time = world.time

/// Implementation for disabling invisibility.
/datum/behavior_delegate/spider_hunter/proc/on_invisibility_off()
	var/datum/action/xeno_action/activable/pounce/lurker/lurker_pounce_action = get_action(bound_xeno, /datum/action/xeno_action/activable/pounce/lurker)
	if(lurker_pounce_action)
		lurker_pounce_action.knockdown = FALSE // pounce no longer knocks down
		lurker_pounce_action.freeze_self = FALSE
	bound_xeno.stealth = FALSE
	REMOVE_TRAIT(bound_xeno, TRAIT_CLOAKED, TRAIT_SOURCE_ABILITY("cloak"))
	UnregisterSignal(bound_xeno, COMSIG_MOB_EFFECT_CLOAK_CANCEL)
	invis_start_time = -1

/datum/behavior_delegate/spider_hunter/append_to_stat()
	. = list()

	// Invisible
	if(invis_start_time != -1)
		var/time_left = (invis_duration-(world.time - invis_start_time)) / 10
		. += "Invisibility Remaining: [time_left] second\s."
		return

	var/datum/action/xeno_action/onclick/lurker_invisibility/lurker_invisibility_action = get_action(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
	if(!lurker_invisibility_action)
		return

	// Recharged
	if(lurker_invisibility_action.cooldown_timer_id == TIMER_ID_NULL)
		. += "Invisibility Recharge: Ready."
		return

	// Recharging
	var/time_left = timeleft(lurker_invisibility_action.cooldown_timer_id) / 10
	. += "Invisibility Recharge: [time_left] second\s."

/datum/behavior_delegate/spider_hunter/on_collide(atom/movable/movable_atom)
	. = ..()

	if(!ishuman(movable_atom))
		return

	if(!bound_xeno || !bound_xeno.stealth)
		return

	var/datum/action/xeno_action/onclick/lurker_invisibility/lurker_invisibility_action = get_action(bound_xeno, /datum/action/xeno_action/onclick/lurker_invisibility)
	if(!lurker_invisibility_action)
		return

	var/mob/living/carbon/human/bumped_into = movable_atom
	if(HAS_TRAIT(bumped_into, TRAIT_CLOAKED)) //ignore invisible scouts and preds
		return

	to_chat(bound_xeno, SPAN_XENOHIGHDANGER("We bumped into someone and lost our invisibility!"))
	lurker_invisibility_action.invisibility_off(0.5) // partial refund of remaining time
