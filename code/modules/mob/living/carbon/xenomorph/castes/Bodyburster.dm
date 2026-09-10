/datum/caste_datum/bodyburster
	caste_type = XENO_CASTE_BODYBURSTER
	tier = 2

	melee_damage_lower = XENO_DAMAGE_TIER_4
	melee_damage_upper = XENO_DAMAGE_TIER_5
	melee_vehicle_damage = XENO_DAMAGE_TIER_4
	max_health = XENO_HEALTH_TIER_2
	plasma_gain = XENO_PLASMA_GAIN_TIER_8
	plasma_max = XENO_PLASMA_TIER_10
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_4
	armor_deflection = XENO_ARMOR_TIER_3
	evasion = XENO_EVASION_MEDIUM
	speed = XENO_SPEED_RAPTOR

	evolves_to = list()
	deevolves_to = list()
	caste_desc = "A powerful new xenogenetic abberation."
	can_vent_crawl = 0

	tackle_min = 2
	tackle_max = 4

	minimap_icon = "warrior"

	heal_resting = 1.4

/mob/living/carbon/xenomorph/bodyburster
	caste_type = XENO_CASTE_BODYBURSTER
	name = XENO_CASTE_BODYBURSTER
	desc = "A horrific abberation of the usual alien, with an armored carapace. The human skull is almost clearly visible within its head, and bits of skin and gore still cling to crevices in its body."
	icon = 'icons/mob/xenos/bodyburster.dmi'
	icon_size = 48
	icon_state = "Normal Bodyburster Walking"
	plasma_types = list(PLASMA_CATECHOLAMINE)
	pixel_x = -8
	old_x = -8
	tier = 2
	pull_speed = 2 // about what it was before, slightly faster
	organ_value = 2000

	claw_type = CLAW_TYPE_SHARP
	gib_chance = 100

	icon_xeno = 'icons/mob/xenos/bodyburster.dmi'
	icon_xenonid = 'icons/mob/xenonids/warrior.dmi'
	acid_blood_damage = 45 /// yowch!
	acid_blood_spatter = TRUE /// They should be dangerous in close quarters

	weed_food_icon = 'icons/mob/xenos/weeds_64x64.dmi'
	weed_food_states = list("Warrior_1","Warrior_2","Warrior_3")
	weed_food_states_flipped = list("Warrior_1","Warrior_2","Warrior_3")

/*
 * ==========================================================================|
 * 							BASE DEFINES AND PROCS
 * --------------------------------------------------------------------------|
 * ==========================================================================|
*/

/// The aggression the alien starts with by default.
#define AGGRESSION_MINIMUM 0
/// The maximum aggression it is possible to accumulate.
#define AGGRESSION_MAXIMUM 100
/// Aggression required to go full-on lethals instead of capture.
#define AGGRESSION_ENABLE_LETHAL 40
/// The cap on aggression increase when something significant happens, like taking damage.
#define AGGRESSION_INCREMENT_CAP 10

/// Threshold for lunging at a target. Low as the alien wants to do this early.
#define AGGRESSION_LUNGE 10
/// Threshold for throwing humans around.
#define AGGRESSION_FLING 70
/// Threshold for stabbing them with the tail.
#define AGGRESSION_TAIL_STAB 50
/// Threshold for headbiting/instakilling a downed human.
#define AGGRESSION_HEADBITE 90

	/// AI behavior variables should probably go into their own datum. I thought about placing this into movement handler, but these govern general behavior.
	var/aggression_cur = AGGRESSION_MINIMUM ///How angry this alien is. Higher aggression means more lethal options are open.
	var/aggression_min = AGGRESSION_MINIMUM ///Aggression cannot fall below this value.

/mob/living/carbon/xenomorph/bodyburster/Initialize()
	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/regurgitate,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/activable/tail_stab/bodyburster,
		/datum/action/xeno_action/activable/fling/bodyburster,
		/datum/action/xeno_action/activable/lunge/bodyburster,
		/datum/action/xeno_action/activable/headbite/bodyburster,
		/datum/action/xeno_action/onclick/tacmap,
	)
	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

	. = ..()

/mob/living/carbon/xenomorph/bodyburster/apply_damage(damage = 0, damagetype = BRUTE, def_zone = null, used_weapon = null, sharp = 0, edge = 0, force = FALSE)
	. = ..() //It will take the previous arguments.

	if(.)
		/// Fire gives the largest aggression increase.
		aggression_cur = min(AGGRESSION_MAXIMUM, aggression_cur + min(AGGRESSION_INCREMENT_CAP, damage * (damagetype == BURN ? 0.25 : 0.17) ) ) /// Multiplying is faster than dividing. Go figure.

/*
 * ==========================================================================|
 * 						MOVEMENT LOOPS AND BEHAVIOR LOGIC
 * --------------------------------------------------------------------------|
 * ==========================================================================|
*/

/mob/living/carbon/xenomorph/bodyburster/process_ai(delta_time)
	var/mob/living/pulling_target = pulling /// Let's see if the alien is pulling anyone.
	var/mob/living/potential_target = current_target

	if(istype(pulling_target)) /// Our bodyburster is pulling someone.
		if(get_active_hand()) swap_hand() /// Swap hand to either tackle or harm.
		ai_active_intent = INTENT_DISARM /// If we are pulling someone and are not too aggressive, switch to disarm.
		if(prob(5)) emote("tail")

	else if(istype(potential_target)) /// We have a target. We'll do more thorough checking in the main loop, for now we only need to know if they are being pulled by a hostile or friendly xeno.
		var/mob/living/carbon/xenomorph/other_xenomorph = potential_target.pulledby /// Are they being pulled by an alien?
		/// Need to make sure the alien dragging is friendly to us. If it is not friendly, or not a xeno, our alien will try to grab back.
		ai_active_intent = (istype(other_xenomorph) && IS_SAME_HIVENUMBER(src, other_xenomorph)) ? INTENT_DISARM : INTENT_GRAB

	/// I had it set up for slightly faster assignment, but this is easier to read.
	ai_active_intent = (aggression_cur >= AGGRESSION_ENABLE_LETHAL) ? INTENT_HARM : ai_active_intent /// Override harm or continue with the previous intent.

	return ..()

/datum/xeno_ai_movement/assault
	do_climb_structures = TRUE /// The alien will climb structures, if able.

/mob/living/carbon/xenomorph/bodyburster/init_movement_handler()
	return new /datum/xeno_ai_movement/assault(src)

/mob/living/carbon/xenomorph/bodyburster/ai_move_idle(delta_time)
	if(!ai_movement_handler)
		CRASH("No valid movement handler for [src]!")

	var/mob/living/pulling_target = pulling
	return (istype(pulling_target) && length(GLOB.ai_hives)) ? ai_movement_handler.ai_move_hive(delta_time) : ai_movement_handler.ai_move_idle(delta_time)

/mob/living/carbon/xenomorph/bodyburster/ai_move_target(delta_time)
	if(!ai_movement_handler)
		CRASH("No valid movement handler for [src]!")

	var/mob/living/pulling_target = pulling
	return (istype(pulling_target) && length(GLOB.ai_hives)) ? ai_movement_handler.ai_move_hive(delta_time) : ai_movement_handler.ai_move_target(delta_time)

/datum/xeno_ai_movement/assault/ai_move_target(delta_time)
	var/mob/living/carbon/xenomorph/bodyburster/current_parent = parent

	/// Moving toward target grows aggression.
	current_parent.aggression_cur = min(AGGRESSION_MAXIMUM, current_parent.aggression_cur + 0.1) ///Fractions for a more gradual aggression gain/loss.
	return ..()

/datum/xeno_ai_movement/assault/ai_move_idle(delta_time)
	var/mob/living/carbon/xenomorph/bodyburster/current_parent = parent

	/// Being idle drains aggression.
	current_parent.aggression_cur = max(current_parent.aggression_min, current_parent.aggression_cur - 0.1)
	return ..()

/*
 * ==========================================================================|
 * 							SPECIAL ACTIONS
 * --------------------------------------------------------------------------|
 * ==========================================================================|
*/

/mob/living/carbon/xenomorph/bodyburster/check_additional_ai_activation(activation_threshold)
	return (aggression_cur >= activation_threshold)

/datum/action/xeno_action/activable/tail_stab/bodyburster /// Specific to bodybursters, so that not all xenos get it.
	default_ai_action = TRUE
	ai_prob_chance = 50 //So they are not spamming it quite as often.
	charge_time = null /// AI bodybursters can just use this whenever instead of having to charge it up.
	xeno_cooldown = 30 SECONDS

/datum/action/xeno_action/activable/tail_stab/process_ai(mob/living/carbon/xenomorph/parent, delta_time)
	/// Short-circuit. Will return the last thing checked or FALSE if it fails at any step.
	/// We do not need to check for distance here as the tailstab itself will do that; that distance being 2.
	return parent.check_additional_ai_activation(AGGRESSION_TAIL_STAB) && DT_PROB(ai_prob_chance, delta_time) && use_ability_async(parent.current_target)

/datum/action/xeno_action/activable/fling/bodyburster
	default_ai_action = TRUE
	ai_prob_chance = 35
	xeno_cooldown = 15 SECONDS

/datum/action/xeno_action/activable/fling/process_ai(mob/living/carbon/xenomorph/parent, delta_time)
	/// We have a home turf to fling to.
	if(parent.check_additional_ai_activation(AGGRESSION_FLING) && DT_PROB(ai_prob_chance, delta_time))
		parent.dir = parent.ai_movement_handler.home_turf ? get_dir(parent, parent.ai_movement_handler.home_turf) : pick(NORTH, SOUTH, EAST, WEST) /// Pick at random if there is no valid direction.
		use_ability_async(parent.current_target)

/datum/action/xeno_action/activable/lunge/bodyburster
	default_ai_action = TRUE
	grab_range = 3
	ai_prob_chance = 90 // Want to do this often, as it's their way of saying hello.
	xeno_cooldown = 15 SECONDS

/datum/action/xeno_action/activable/lunge/process_ai(mob/living/carbon/xenomorph/parent, delta_time)
	/// Want to make sure no obstacles are in the way so that the alien is not lunging for no reason, or bonking into barricades like an idiot.
	/// Maybe in the future the actual lunge can be stripped down for the AI only?
	if( parent.check_additional_ai_activation(AGGRESSION_LUNGE) && DT_PROB(ai_prob_chance, delta_time) && get_dist(parent, parent.current_target) == grab_range )
		/// get_step_to() should return the turf nearest the target if successful, with no obstacles to block movement there with the lunge.
		var/turf/T = get_step_to(parent, parent.current_target)
		return T?.AdjacentQuick(parent.current_target.loc) && use_ability_async(parent.current_target)

/// Override for bodyburster lunges. Similar to the woyer grab, but this one only inflicts pain without stuns and has a shorter range.
/mob/living/carbon/xenomorph/bodyburster/start_pulling(atom/movable/AM, lunge)
	if (!check_state() || agility || !isliving(AM)) return FALSE

	var/mob/living/L = AM
	var/should_neckgrab = !can_not_harm(L) && lunge

	if(!QDELETED(L) && !QDELETED(L.pulledby) && L != src ) //override pull of other mobs
		visible_message(SPAN_WARNING("[src] has broken [L.pulledby]'s grip on [L]!"), null, null, 5)
		L.pulledby.stop_pulling()

	. = ..(L, lunge, should_neckgrab)

	if(.)
		var/pain_to_cause = PAIN_XENO_DRAG /// Basic amount of pain caused with each grab.
		if(should_neckgrab && L.mob_size < MOB_SIZE_BIG)
			pain_to_cause += PAIN_XENO_GRAB /// Neck grabs cause even more pain.
			L.pulledby = src
			visible_message(SPAN_XENOWARNING("\The [src] grabs [L] by the throat!"), \
			SPAN_XENOWARNING("You grab [L] by the throat!"))

		L.pain.apply_pain(pain_to_cause)
		grab_level = GRAB_XENO /// Alien-specific grab level, with its own logic for escaping. AI only for the moment. See /mob/living/resist_grab()
		if(prob(10)) emote("growl")
		///	The actual pain processing for humans is handled in: /mob/living/carbon/proc/handle_grabbed() Other mobs don't process the effects of the grab, like other xenomorphs.

/mob/living/carbon/xenomorph/bodyburster/stop_pulling(bumped_movement = FALSE)
	//Let's see if we can ignore this. If our direction is the same as where the mob went, we likely bumped into them. So we lasso them back.
	if(bumped_movement && grab_level == GRAB_XENO && get_dir(src, pulling) == dir) /// Only on xeno grabs, so if they are on GRAB_PASSIVE, this doesn't trigger.
		pulling.loc = get_step_towards(src, pulling) // GET OVER HERE!
	else return ..()

/datum/action/xeno_action/activable/headbite/bodyburster
	default_ai_action = TRUE
	ai_prob_chance = 95 // Absolutely DEAD if the alien is angry enough.
	xeno_cooldown = 30 SECONDS // Don't want to chain these, as unlikely as that could be.

/datum/action/xeno_action/activable/headbite/bodyburster/process_ai(mob/living/carbon/xenomorph/parent, delta_time)
	return parent.check_additional_ai_activation(AGGRESSION_HEADBITE) && DT_PROB(ai_prob_chance, delta_time) && use_ability_async(parent.current_target)

/mob/living/carbon/xenomorph/bodyburster/initialize_pass_flags(datum/pass_flags_container/pass_flags_container)
	..()
	if (pass_flags_container)
		pass_flags_container.flags_pass |= PASS_FLAGS_CRAWLER


/mob/living/carbon/xenomorph/bodyburster/cause_unbearable_pain(mob/living/carbon/victim)
	if(loc != victim)
		return
	if(prob(15))
		victim.pain.apply_pain(PAIN_XENO_DRAG)
	victim.visible_message(SPAN_DANGER("\The [victim] is deathly pale, sweat beading across their skin."),
						SPAN_DANGER(pick("YOU FEEL DEATHLY COLD!", "YOU ARE BURNING UP!", "MAKE IT STOP!", "SOMETHING IS WRONG WITH YOUR BODY!", "YOUR MUSCLES SHIVER AND TWITCH UNCONTROLLABLY!", "YOUR BONES FEEL LIKE THEY ARE BREAKING!", "YOU CAN'T BREATHE!", "EVERYTHING HURTS!")))
	addtimer(CALLBACK(src, PROC_REF(cause_unbearable_pain), victim), rand(3, 5) SECONDS, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)

/mob/living/carbon/xenomorph/bodyburster/chest_burst(mob/living/carbon/victim)
	set waitfor = 0
	if(victim.chestburst || loc != victim)
		return
	victim.mob_flags |= BODY_BURSTING
	victim.chestburst = TRUE
	to_chat(src, SPAN_DANGER("We start emerging from [victim]'s body!"))
	if(!HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
		victim.apply_effect(20, SUPERSLOW)
	victim.visible_message(SPAN_DANGER("\The [victim] starts to shake uncontrollably, their flesh giving way to a new form!"),
						SPAN_DANGER("YOU FEEL YOUR BODY CHURN AND SHIFT!"))
	victim.make_jittery(200)
	sleep(10)
	if(!victim || !victim.loc)
		return//host could've been deleted, or we could've been removed from host.
	if(loc != victim)
		victim.chestburst = 0
		return
	if(ishuman(victim) || isyautja(victim))
		victim.emote("burstscream")
	sleep(25) //Sound delay
	victim.update_burst()
	sleep(10) //Sprite delay
	playsound(victim, 'sound/effects/gibbed.ogg', 50)
	if(!victim || !victim.loc)
		return
	if(loc != victim)
		victim.chestburst = 0 //if a doc removes the larva during the sleep(10), we must remove the 'bursting' overlay on the human
		victim.update_burst()
		return

	var/burstcount = 0

	victim.spawn_gibs()

	for(var/mob/living/carbon/xenomorph/bodyburster/burster_embryo in victim)
		var/datum/hive_status/hive = GLOB.hive_datum[burster_embryo.hivenumber]
		burster_embryo.forceMove(get_turf(victim)) //moved to the turf directly so we don't get stuck inside a cryopod or another mob container.
		var/list/splitname = splittext(victim.real_name, " ")
		burster_embryo.name = "[splitname[1]]omorph ([burster_embryo.nicknumber])"
		burster_embryo.real_name = burster_embryo.name
		playsound(burster_embryo, pick('sound/voice/alien_roar1.ogg', 'sound/voice/alien_roar2.ogg', 'sound/voice/alien_roar3.ogg', 'sound/voice/alien_roar4.ogg', 'sound/voice/alien_roar5.ogg', 'sound/voice/alien_roar6.ogg'), 30)

		if(burster_embryo.client)
			burster_embryo.set_lighting_alpha_from_prefs(burster_embryo.client)

		burster_embryo.attack_log += "\[[time_stamp()]\]<font color='red'> bodybursted from [key_name(victim)] in [get_area_name(burster_embryo)] at X[victim.x], Y[victim.y], Z[victim.z]</font>"
		victim.attack_log += "\[[time_stamp()]\]<font color='orange'> Was bodybursted in [get_area_name(burster_embryo)] at X[victim.x], Y[victim.y], Z[victim.z]. The larva was [key_name(burster_embryo)].</font>"

		if(burstcount)
			step(burster_embryo, pick(GLOB.cardinals))

		if(GLOB.round_statistics && (ishuman(victim)) && (SSticker.current_state == GAME_STATE_PLAYING) && (ROUND_TIME > 1 MINUTES))
			GLOB.round_statistics.total_larva_burst++
		GLOB.larva_burst_by_hive[hive] = (GLOB.larva_burst_by_hive[hive] || 0) + 1
		burstcount++

		if(!victim.first_xeno)
			if(hive.hive_orders)
				to_chat(burster_embryo, SPAN_XENOHIGHDANGER("The unknown force guides us to our new form..."))
				to_chat(burster_embryo, SPAN_XENOHIGHDANGER("\"[hive.hive_orders]\""))
			log_attack("[key_name(victim)] bodyburst in [get_area_name(burster_embryo)] at X[victim.x], Y[victim.y], Z[victim.z]. The bodyburster was [key_name(burster_embryo)].") //this is so that admins are not spammed with los logs

	for(var/list/obj/limb/limbs in victim)
		if(istype(limbs, /obj/limb/chest) || istype(limbs, /obj/limb/groin))
			continue
		qdel(limbs)

	for(var/obj/item/alien_embryo/AE in victim)
		qdel(AE)

	var/datum/cause_data/cause = create_cause_data("bodybursting", src)
	victim.gib(cause)

/obj/item/alien_embryo/bodyburster
	icon = 'icons/mob/xenos/bodyburster.dmi'
	flags_embryo = FLAG_EMBRYO_HYBRID

#undef AGGRESSION_MINIMUM
#undef AGGRESSION_MAXIMUM
#undef AGGRESSION_INCREMENT_CAP
#undef AGGRESSION_ENABLE_LETHAL

#undef AGGRESSION_LUNGE
#undef AGGRESSION_FLING
#undef AGGRESSION_TAIL_STAB
#undef AGGRESSION_HEADBITE
