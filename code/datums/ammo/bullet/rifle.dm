/*
//======
					Rifle Ammo
//======
*/

/datum/ammo/bullet/rifle
	name = "rifle bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM

	damage = 40
	penetration = ARMOR_PENETRATION_TIER_1
	accurate_range = 16
	accuracy = HIT_ACCURACY_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	shell_speed = AMMO_SPEED_TIER_6
	effective_range_max = 7
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	max_range = 24 //So S8 users don't have their bullets magically disappaer at 22 tiles (S8 can see 24 tiles)

/datum/ammo/bullet/rifle/holo_target
	name = "holo-targeting rifle bullet"
	damage = 30
	var/holo_stacks = 10

/datum/ammo/bullet/rifle/holo_target/on_hit_mob(mob/M, obj/projectile/P)
	. = ..()
	M.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time)

/datum/ammo/bullet/rifle/holo_target/hunting
	name = "holo-targeting hunting bullet"
	damage = 25
	holo_stacks = 15

/datum/ammo/bullet/rifle/explosive
	name = "explosive rifle bullet"

	damage = 25
	accurate_range = 22
	accuracy = 0
	shell_speed = AMMO_SPEED_TIER_4
	damage_falloff = DAMAGE_FALLOFF_TIER_9

/datum/ammo/bullet/rifle/explosive/on_hit_mob(mob/M, obj/projectile/P)
	cell_explosion(get_turf(M), 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, P.weapon_cause_data)

/datum/ammo/bullet/rifle/explosive/on_hit_obj(obj/O, obj/projectile/P)
	cell_explosion(get_turf(O), 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, P.weapon_cause_data)

/datum/ammo/bullet/rifle/explosive/on_hit_turf(turf/T, obj/projectile/P)
	if(T.density)
		cell_explosion(T, 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, P.weapon_cause_data)

/datum/ammo/bullet/rifle/ap
	name = "armor-piercing rifle bullet"

	damage = 30
	penetration = ARMOR_PENETRATION_TIER_8

// Basically AP but better. Focused at taking out armour temporarily
/datum/ammo/bullet/rifle/ap/toxin
	name = "toxic rifle bullet"
	var/acid_per_hit = 7
	var/organic_damage_mult = 3

/datum/ammo/bullet/rifle/ap/toxin/on_hit_mob(mob/M, obj/projectile/P)
	. = ..()
	M.AddComponent(/datum/component/toxic_buildup, acid_per_hit)

/datum/ammo/bullet/rifle/ap/toxin/on_hit_turf(turf/T, obj/projectile/P)
	. = ..()
	if(T.flags_turf & TURF_ORGANIC)
		P.damage *= organic_damage_mult

/datum/ammo/bullet/rifle/ap/toxin/on_hit_obj(obj/O, obj/projectile/P)
	. = ..()
	if(O.flags_obj & OBJ_ORGANIC)
		P.damage *= organic_damage_mult


/datum/ammo/bullet/rifle/ap/penetrating
	name = "wall-penetrating rifle bullet"
	shrapnel_chance = 0

	damage = 35
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/ap/penetrating/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/rifle/le
	name = "armor-shredding rifle bullet"

	damage = 20
	penetration = ARMOR_PENETRATION_TIER_4
	pen_armor_punch = 5

/datum/ammo/bullet/rifle/heap
	name = "high-explosive armor-piercing rifle bullet"

	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 55//big damage, doesn't actually blow up because thats stupid.
	penetration = ARMOR_PENETRATION_TIER_8

/datum/ammo/bullet/rifle/rubber
	name = "rubber rifle bullet"
	sound_override = 'sound/weapons/gun_c99.ogg'

	damage = 0
	stamina_damage = 15
	shrapnel_chance = 0

/datum/ammo/bullet/rifle/incendiary
	name = "incendiary rifle bullet"
	damage_type = BURN
	shrapnel_chance = 0
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 30
	shell_speed = AMMO_SPEED_TIER_4
	accuracy = -HIT_ACCURACY_TIER_2
	damage_falloff = DAMAGE_FALLOFF_TIER_10

/datum/ammo/bullet/rifle/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/rifle/m4ra
	name = "A19 high velocity bullet"
	shrapnel_chance = 0
	damage_falloff = 0
	flags_ammo_behavior = AMMO_BALLISTIC
	accurate_range_min = 4

	damage = 55
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration= ARMOR_PENETRATION_TIER_7
	shell_speed = AMMO_SPEED_TIER_6

/datum/ammo/bullet/rifle/m4ra/incendiary
	name = "A19 high velocity incendiary bullet"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 40
	accuracy = HIT_ACCURACY_TIER_4
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration= ARMOR_PENETRATION_TIER_5
	shell_speed = AMMO_SPEED_TIER_6

/datum/ammo/bullet/rifle/m4ra/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/rifle/m4ra/impact
	name = "A19 high velocity impact bullet"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 40
	accuracy = -HIT_ACCURACY_TIER_2
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration = ARMOR_PENETRATION_TIER_10
	shell_speed = AMMO_SPEED_TIER_6

/datum/ammo/bullet/rifle/m4ra/impact/on_hit_mob(mob/M, obj/projectile/P)
	knockback(M, P, 32) // Can knockback basically at max range

/datum/ammo/bullet/rifle/m4ra/impact/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(0.5) // purely for visual effect, noone actually cares
		target.Stun(0.5)
		target.apply_effect(2, SUPERSLOW)
		target.apply_effect(5, SLOW)
	else
		if(!isyautja(living_mob)) //Not predators.
			living_mob.apply_effect(1, SUPERSLOW)
			living_mob.apply_effect(2, SLOW)
			to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))
		living_mob.apply_stamina_damage(fired_projectile.ammo.damage, fired_projectile.def_zone, ARMOR_BULLET)


// PvE M4RA rounds - pens&does toxin to whomever gets hit by it
/datum/ammo/bullet/rifle/m4ra/du
	name = "depleted uranium bullet"

	damage = 60
	penetration = ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/rifle/m4ra/du/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/rifle/m4ra/du/on_hit_mob(mob/target, obj/projectile/fired_proj)
	target.AddComponent(/datum/component/toxic_buildup)
	knockback(target, fired_proj, max_range = 2)


/datum/ammo/bullet/rifle/mar40
	name = "heavy rifle bullet"

	damage = 55

/datum/ammo/bullet/rifle/type71
	name = "heavy rifle bullet"

	damage = 55
	penetration = ARMOR_PENETRATION_TIER_3

/datum/ammo/bullet/rifle/type71/ap
	name = "heavy armor-piercing rifle bullet"

	damage = 40
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/type71/heap
	name = "heavy high-explosive armor-piercing rifle bullet"

	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 65
	penetration = ARMOR_PENETRATION_TIER_10
