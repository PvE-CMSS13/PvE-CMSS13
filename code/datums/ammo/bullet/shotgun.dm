/*
//======
					Shotgun Ammo
//======
*/

/datum/ammo/bullet/shotgun
	headshot_state = HEADSHOT_OVERLAY_HEAVY

/datum/ammo/bullet/shotgun/slug
	name = "shotgun slug"
	handful_state = "slug_shell"
	shell_casing = /obj/effect/decal/ammo_casing/greenshell

	accurate_range = 7
	max_range = 14
	damage = 90
	penetration = ARMOR_PENETRATION_TIER_6
	damage_var_low = PROJECTILE_VARIANCE_TIER_10
	damage_var_high = PROJECTILE_VARIANCE_TIER_1
	damage_armor_punch = 2
	handful_state = "slug_shell"

/datum/ammo/bullet/shotgun/slug/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 4)

/datum/ammo/bullet/shotgun/slug/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(3.5)
		target.Stun(3.5)
		target.Slow(5)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.KnockDown(2)
			living_mob.Stun(2)
			living_mob.Superslow(5)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/slug/special
	name = "shotgun slug, USCM magnum load"
	handful_state = "special_slug"
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	accurate_range = 10
	max_range = 18
	damage = 110
	damage_armor_punch = 5
	penetration = ARMOR_PENETRATION_TIER_8
	firing_freq_offset = SOUND_FREQ_LOW

/datum/ammo/bullet/shotgun/slug/special/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 7)
	pushback(M, P, 7)

/datum/ammo/bullet/shotgun/beanbag
	name = "beanbag slug"
	headshot_state = HEADSHOT_OVERLAY_LIGHT //It's not meant to kill people... but if you put it in your mouth, it will.
	handful_state = "beanbag_slug"
	icon_state = "beanbag"
	shell_casing = /obj/effect/decal/ammo_casing/blueshell
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IGNORE_RESIST
	max_range = 12
	shrapnel_chance = 0
	damage = 20
	stamina_damage = 45
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_3
	handful_state = "beanbag_slug"

/datum/ammo/bullet/shotgun/beanbag/on_hit_mob(mob/M, obj/projectile/P)
	if(!M || M == P.firer) return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		shake_camera(H, 2, 1)


/datum/ammo/bullet/shotgun/incendiary
	name = "incendiary slug"
	handful_state = "incendiary_slug"
	shell_casing = /obj/effect/decal/ammo_casing/redshell
	damage_type = BURN
	flags_ammo_behavior = AMMO_BALLISTIC

	accuracy = -HIT_ACCURACY_TIER_2
	max_range = 12
	damage = 55
	penetration= ARMOR_PENETRATION_TIER_1
	handful_state = "incendiary_slug"

/datum/ammo/bullet/shotgun/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/incendiary/on_hit_mob(mob/M,obj/projectile/P)
	burst(get_turf(M),P,damage_type)
	knockback(M, P)

/datum/ammo/bullet/shotgun/incendiary/on_hit_obj(obj/O,obj/projectile/P)
	burst(get_turf(P),P,damage_type)

/datum/ammo/bullet/shotgun/incendiary/on_hit_turf(turf/T,obj/projectile/P)
	burst(get_turf(T),P,damage_type)


/datum/ammo/bullet/shotgun/flechette
	name = "flechette shell"
	icon_state = "flechette"
	handful_state = "flechette_shell"
	shell_casing = /obj/effect/decal/ammo_casing/blueshell
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/flechette_spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 12
	damage = 30
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_7
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	multiple_handful_name = TRUE

/datum/ammo/bullet/shotgun/flechette/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 2)

/datum/ammo/bullet/shotgun/flechette_spread
	name = "additional flechette"
	icon_state = "flechette"

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 12
	damage = 30
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_7
	scatter = SCATTER_AMOUNT_TIER_5

/datum/ammo/bullet/shotgun/flechette_spread/awesome
	damage = 60
	max_range = 5
	damage_var_low = PROJECTILE_VARIANCE_TIER_10
	damage_var_high = PROJECTILE_VARIANCE_TIER_5

/datum/ammo/bullet/shotgun/flechette/special
	name = "flechette shell, USCM DU type"
	handful_state = "special_dart"
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/flechette_spread/special
	max_range = 14
	damage = 50
	damage_var_low = PROJECTILE_VARIANCE_TIER_10
	damage_var_high = PROJECTILE_VARIANCE_TIER_5
	penetration = ARMOR_PENETRATION_TIER_9
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_5

/datum/ammo/bullet/shotgun/flechette/special/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/shotgun/flechette/special/on_hit_mob(mob/M,obj/projectile/P)
	M.AddComponent(/datum/component/status_effect/toxic_buildup, toxic_buildup = 15, toxic_buildup_dissipation = 0.3, max_buildup = 75)
	knockback(M, P, 5)
	if(M.mob_size >= MOB_SIZE_BIG)
		var/mob/living/L = M
		L.apply_armoured_damage(damage*1.3, ARMOR_BULLET, BRUTE, null, penetration) // As bugs don't take toxin damage, this should give it a little more oomf versus them

/datum/ammo/bullet/shotgun/flechette_spread/special
	name = "additional DU flechette"
	icon_state = "flechette"

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_5
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 14
	damage = 45
	damage_var_low = PROJECTILE_VARIANCE_TIER_10
	damage_var_high = PROJECTILE_VARIANCE_TIER_5
	penetration = ARMOR_PENETRATION_TIER_9
	scatter = SCATTER_AMOUNT_TIER_5

/datum/ammo/bullet/shotgun/flechette_spread/special/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/shotgun/flechette_spread/special/on_hit_mob(mob/M,obj/projectile/P)
	M.AddComponent(/datum/component/status_effect/toxic_buildup, toxic_buildup = 10, toxic_buildup_dissipation = 0.3, max_buildup = 75)
	if(M.mob_size >= MOB_SIZE_BIG)
		var/mob/living/L = M
		L.apply_armoured_damage(damage*1.2, ARMOR_BULLET, BRUTE, null, penetration) // As bugs don't take toxin damage, this should give it a little more oomf versus them

/datum/ammo/bullet/shotgun/buckshot
	name = "buckshot shell"
	icon_state = "buckshot"
	handful_state = "buckshot_shell"
	shell_casing = /obj/effect/decal/ammo_casing/redshell
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_5
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_5
	accurate_range = 7
	max_range = 9
	damage = 50
	damage_var_low = PROJECTILE_VARIANCE_TIER_10
	damage_var_high = PROJECTILE_VARIANCE_TIER_1
	penetration = ARMOR_PENETRATION_TIER_1
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_7
	shell_speed = AMMO_SPEED_TIER_2
	damage_armor_punch = 0
	pen_armor_punch = 0
	handful_state = "buckshot_shell"
	multiple_handful_name = TRUE

/datum/ammo/bullet/shotgun/buckshot/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 3)

/datum/ammo/bullet/shotgun/buckshot/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(2.5)
		target.Stun(2.5)
		target.Slow(4)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.KnockDown(3)
			living_mob.Stun(3)
			living_mob.Slow(5)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/buckshot/incendiary
	name = "incendiary buckshot shell"
	handful_state = "incen_buckshot"
	shell_casing = /obj/effect/decal/ammo_casing/redshell
	handful_type = /obj/item/ammo_magazine/handful/shotgun/buckshot/incendiary
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/spread/incendiary
	damage = 40
	shell_speed = AMMO_SPEED_TIER_1

/datum/ammo/bullet/shotgun/buckshot/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/buckshot/incendiary/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P)

/datum/ammo/bullet/shotgun/buckshot/special
	name = "buckshot shell, USCM special type"
	handful_state = "special_buck"
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/spread/special

	accurate_range = 8
	max_range = 8
	damage = 60
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_8
	firing_freq_offset = SOUND_FREQ_LOW

//buckshot variant only used by the masterkey shotgun attachment.
/datum/ammo/bullet/shotgun/buckshot/masterkey
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/spread/masterkey

	damage = 55

/datum/ammo/bullet/shotgun/spread
	name = "additional buckshot"
	icon_state = "buckshot"

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 4
	max_range = 6
	damage = 50
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_1
	shell_speed = AMMO_SPEED_TIER_2
	scatter = SCATTER_AMOUNT_TIER_1
	damage_armor_punch = 0
	pen_armor_punch = 0

/datum/ammo/bullet/shotgun/spread/masterkey
	damage = 20

/datum/ammo/bullet/shotgun/spread/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 3)
/datum/ammo/bullet/shotgun/spread/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(2.5)
		target.Stun(2.5)
		target.Slow(4)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.KnockDown(3)
			living_mob.Stun(3)
			living_mob.Slow(5)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/spread/special
	name = "additional buckshot, USCM special type"

	accurate_range = 8
	max_range = 8
	damage = 90
	firing_freq_offset = SOUND_FREQ_LOW

/datum/ammo/bullet/shotgun/spread/incendiary
	name = "additional incendiary buckshot"
	damage = 40
	shell_speed = AMMO_SPEED_TIER_1

/datum/ammo/bullet/shotgun/spread/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/spread/incendiary/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P)

/*
					8 GAUGE SHOTGUN AMMO
*/

/datum/ammo/bullet/shotgun/heavy/buckshot
	name = "heavy buckshot shell"
	icon_state = "buckshot"
	handful_state = "heavy_buckshot"
	shell_casing = /obj/effect/decal/ammo_casing/redshell
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/buckshot/spread
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_8
	accurate_range = 8
	max_range = 10
	damage = 75
	penetration = ARMOR_PENETRATION_TIER_2
	shell_speed = AMMO_SPEED_TIER_2
	damage_armor_punch = 0
	pen_armor_punch = 0

/datum/ammo/bullet/shotgun/heavy/buckshot/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 4)
/datum/ammo/bullet/shotgun/heavy/buckshot/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(5)
		target.Stun(5)
		target.Slow(8)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.KnockDown(2)
			living_mob.Stun(2)
			living_mob.Slow(6)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/heavy/buckshot/spread
	name = "additional heavy buckshot"
	max_range = 7
	scatter = SCATTER_AMOUNT_TIER_1
	bonus_projectiles_amount = 0

/datum/ammo/bullet/shotgun/heavy/buckshot/spread/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(5)
		target.Stun(5)
		target.Slow(8)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.KnockDown(2)
			living_mob.Stun(2)
			living_mob.Slow(6)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/heavy/buckshot/special
	name = "superheavy buckshot shell"
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/buckshot/spread/special
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_8
	accurate_range = 8
	max_range = 8
	damage = 100
	shell_speed = AMMO_SPEED_TIER_2
	penetration = ARMOR_PENETRATION_TIER_3
	damage_armor_punch = 0
	pen_armor_punch = 0

/datum/ammo/bullet/shotgun/heavy/buckshot/spread/special
	name = "additional superheavy buckshot"
	accurate_range = 8
	max_range = 8
	damage = 100
	penetration = ARMOR_PENETRATION_TIER_3

//basically the same
/datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath
	name = "dragon's breath shell"
	handful_state = "heavy_dragonsbreath"
	multiple_handful_name = TRUE
	damage_type = BURN
	damage = 60
	accurate_range = 4
	max_range = 6
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath/spread

/datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shotgun/heavy/buckshot/dragonsbreath/spread
	name = "additional dragon's breath"
	bonus_projectiles_amount = 0
	shell_speed = AMMO_SPEED_TIER_4


/datum/ammo/bullet/shotgun/heavy/slug
	name = "heavy shotgun slug"
	handful_state = "heavy_slug"
	shell_casing = /obj/effect/decal/ammo_casing/greenshell

	accurate_range = 7
	max_range = 17
	damage = 120 //ouch.
	penetration = ARMOR_PENETRATION_TIER_9
	damage_armor_punch = 2

/datum/ammo/bullet/shotgun/heavy/slug/on_hit_mob(mob/M,obj/projectile/P)
	knockback(M, P, 5)

/datum/ammo/bullet/shotgun/heavy/slug/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(7)
		target.Stun(7)
		target.Slow(10)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.KnockDown(8)
			living_mob.Stun(8)
			living_mob.Superslow(15)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)

/datum/ammo/bullet/shotgun/heavy/beanbag
	name = "heavy beanbag slug"
	icon_state = "beanbag"
	shell_casing = /obj/effect/decal/ammo_casing/blueshell
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	handful_state = "heavy_beanbag"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IGNORE_RESIST

	max_range = 7
	shrapnel_chance = 0
	damage = 25
	stamina_damage = 100
	accuracy = HIT_ACCURACY_TIER_6
	shell_speed = 3

/datum/ammo/bullet/shotgun/heavy/beanbag/on_hit_mob(mob/M, obj/projectile/P)
	if(!M || M == P.firer)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		shake_camera(H, 2, 1)

/datum/ammo/bullet/shotgun/heavy/flechette
	name = "heavy flechette shell"
	icon_state = "flechette"
	handful_state = "heavy_flechette"
	shell_casing = /obj/effect/decal/ammo_casing/blueshell
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/heavy/flechette_spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_3
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_3
	max_range = 12
	damage = 45
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_2

/datum/ammo/bullet/shotgun/heavy/flechette_spread
	name = "additional heavy flechette"
	icon_state = "flechette"
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	max_range = 12
	damage = 45
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	scatter = SCATTER_AMOUNT_TIER_4

/*
					16 GAUGE SHOTGUN AMMO
*/

/datum/ammo/bullet/shotgun/buckshot/light
	name = "light buckshot"
	handful_state = "lightshot_shell"
	multiple_handful_name = TRUE
	bonus_projectiles_type = /datum/ammo/bullet/shotgun/buckshot/light/spread

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_10
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_1
	damage = 45
	max_range = 7
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	penetration = ARMOR_PENETRATION_TIER_1


/datum/ammo/bullet/shotgun/buckshot/light/spread
	name = "light buckshot spread"
	bonus_projectiles_amount = 0
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_10
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_1
	scatter = SCATTER_AMOUNT_TIER_3
	damage = 20

//Enormous shell for Van Bandolier's superheavy double-barreled hunting gun.
/datum/ammo/bullet/shotgun/twobore
	name = "two bore bullet"
	icon_state = "autocannon"
	handful_state = "twobore"

	accurate_range = 8 //Big low-velocity projectile; this is for blasting dangerous game at close range.
	max_range = 14 //At this range, it's lost all its damage anyway.
	damage = 300 //Hits like a buckshot PB.
	penetration = ARMOR_PENETRATION_TIER_3
	damage_falloff = DAMAGE_FALLOFF_TIER_1 * 3 //It has a lot of energy, but the 26mm bullet drops off fast.
	effective_range_max = EFFECTIVE_RANGE_MAX_TIER_2 //Full damage up to this distance, then falloff for each tile beyond.
	var/hit_messages = list()

/datum/ammo/bullet/shotgun/twobore/on_hit_mob(mob/living/M, obj/projectile/P)
	var/mob/shooter = P.firer
	if(shooter && ismob(shooter) && HAS_TRAIT(shooter, TRAIT_TWOBORE_TRAINING) && M.stat != DEAD && prob(40)) //Death is handled by periodic life() checks so this should have a chance to fire on a killshot.
		if(!length(hit_messages)) //Pick and remove lines, refill on exhaustion.
			hit_messages = list("Got you!", "Aha!", "Bullseye!", "It's curtains for you, Sonny Jim!", "Your head will look fantastic on my wall!", "I have you now!", "You miserable coward! Come and fight me like a man!", "Tally ho!")
		var/message = pick_n_take(hit_messages)
		shooter.say(message)

	if(P.distance_travelled > 8)
		knockback(M, P, 12)

	else if(!M || M == P.firer || M.body_position == LYING_DOWN) //These checks are included in knockback and would be redundant above.
		return

	shake_camera(M, 3, 4)
	M.KnockDown(2) // If you ask me the KD should be left out, but players like their visual cues
	M.Stun(2)
	M.apply_effect(4, SLOW)
	if(iscarbonsizexeno(M))
		to_chat(M, SPAN_XENODANGER("The impact knocks you off your feet!"))
	else //This will hammer a Yautja as hard as a human.
		to_chat(M, SPAN_HIGHDANGER("The impact knocks you off your feet!"))

	step(M, get_dir(P.firer, M))

/datum/ammo/bullet/shotgun/twobore/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(0.5) // If you ask me the KD should be left out, but players like their visual cues
		target.Stun(0.5)
		target.apply_effect(2, SUPERSLOW)
		target.apply_effect(5, SLOW)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.apply_effect(1, SUPERSLOW)
			living_mob.apply_effect(2, SLOW)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)
