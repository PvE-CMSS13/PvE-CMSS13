/*
//======
					Rifle Ammo
//======
*/

//====== 10X24 Pulse Rifle
/datum/ammo/bullet/rifle
	name = "10x24 bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_1
	accurate_range = 16
	accuracy = HIT_ACCURACY_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	shell_speed = AMMO_SPEED_TIER_6
	effective_range_max = 7
	damage_falloff = DAMAGE_FALLOFF_TIER_7
	max_range = 24

/datum/ammo/bullet/rifle/holo_target
	name = "holo-targeting 10x24 bullet"
	damage = 30
	/// inflicts this many holo stacks per bullet hit
	var/holo_stacks = 10
	/// modifies the default cap limit of 100 by this amount
	var/bonus_damage_cap_increase = 0
	/// multiplies the default drain of 5 holo stacks per second by this amount
	var/stack_loss_multiplier = 1

/datum/ammo/bullet/rifle/holo_target/on_hit_mob(mob/hit_mob, obj/projectile/bullet)
	. = ..()
	hit_mob.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)


/datum/ammo/bullet/rifle/holo_target/hunting
	name = "holo-targeting 10x24 bullet"
	damage = 25
	holo_stacks = 15

/datum/ammo/bullet/rifle/holo_target/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/explosive
	name = "explosive 10x24 bullet"
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
	name = "armor-piercing 10x24 bullet"

	damage = 30
	penetration = ARMOR_PENETRATION_TIER_8

/datum/ammo/bullet/rifle/ap/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

// Basically AP but better. Focused at taking out armour temporarily
/datum/ammo/bullet/rifle/ap/toxin
	name = "toxic 10x24 bullet"
	var/acid_per_hit = 7
	var/organic_damage_mult = 3

/datum/ammo/bullet/rifle/ap/toxin/on_hit_mob(mob/M, obj/projectile/P)
	. = ..()
	M.AddComponent(/datum/component/status_effect/toxic_buildup, acid_per_hit)

/datum/ammo/bullet/rifle/ap/toxin/on_hit_turf(turf/T, obj/projectile/P)
	. = ..()
	if(T.turf_flags & TURF_ORGANIC)
		P.damage *= organic_damage_mult

/datum/ammo/bullet/rifle/ap/toxin/on_hit_obj(obj/O, obj/projectile/P)
	. = ..()
	if(O.flags_obj & OBJ_ORGANIC)
		P.damage *= organic_damage_mult


/datum/ammo/bullet/rifle/ap/penetrating
	name = "wall-penetrating 10x24 bullet"
	shrapnel_chance = 0

	damage = 35
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/ap/penetrating/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))


/datum/ammo/bullet/rifle/le
	name = "armor-shredding 10x24 bullet"
	damage = 20
	penetration = ARMOR_PENETRATION_TIER_4
	pen_armor_punch = 5


/datum/ammo/bullet/rifle/heap
	name = "high-explosive armor-piercing 10x24 bullet"
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 55//big damage, doesn't actually blow up because thats stupid.
	penetration = ARMOR_PENETRATION_TIER_8
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_3

/datum/ammo/bullet/rifle/heap/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/rubber
	name = "rubber 10x24 bullet"
	damage = 5
	stamina_damage = 15
	shrapnel_chance = 0

/datum/ammo/bullet/rifle/incendiary
	name = "incendiary 10x24 bullet"
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

//====== 10X28 Smartgun

/datum/ammo/bullet/rifle/heavy
	name = "10x28 bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 55
	penetration = ARMOR_PENETRATION_TIER_3
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_6
	effective_range_max = 10
	damage_falloff = DAMAGE_FALLOFF_TIER_9

//Only applicable for the M42A 'basic' magazines
/datum/ammo/bullet/rifle/heavy/on_hit_mob(mob/M,obj/projectile/P)
	if((P.projectile_flags & PROJECTILE_BULLSEYE) && M == P.original)
		var/mob/living/L = M
		L.apply_armoured_damage(damage*2, ARMOR_BULLET, BRUTE, null, penetration)
		to_chat(P.firer, SPAN_WARNING("Bullseye!"))

/datum/ammo/bullet/rifle/heavy/rmcdmr
	name = "8.88x51 squash-head bullet"
	damage = 60
	penetration = ARMOR_PENETRATION_TIER_6
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_7
	effective_range_max = 24

/datum/ammo/bullet/rifle/heavy/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/heavy/ap
	name = "armor-piercing 10x28 bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_7

/datum/ammo/bullet/rifle/heavy/ap/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/heavy/impdet
	name = "impact-detonating 10x28 bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 40
	penetration = -ARMOR_PENETRATION_TIER_2
	damage_falloff = DAMAGE_FALLOFF_TIER_5
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

/datum/ammo/bullet/rifle/heavy/impdet/on_hit_mob(mob/entity, obj/projectile/bullet)
	slowdown(entity, bullet)

/datum/ammo/bullet/rifle/heavy/heap
	name = "high explosive armor-piercing 10x28 bullet"
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 70
	penetration = ARMOR_PENETRATION_TIER_10
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_3

/datum/ammo/bullet/rifle/heavy/heap/tracer
	icon_state = "bullet_red"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_RED

// Terminator Smartgun

/datum/ammo/bullet/rifle/heavy/dirty
	name = "irradiated 10x28 bullet"
	debilitate = list(0,0,0,3,0,0,0,1)
	damage = 60
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_7

/datum/ammo/bullet/rifle/heavy/ap/dirty
	name = "irradiated armor-piercing 10x28 bullet"
	debilitate = list(0,0,0,3,0,0,0,1)
	damage = 45

/datum/ammo/bullet/rifle/heavy/impdet/dirty
	name = "irradiated impact-detonating 10x28 bullet"
	damage = 45
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_7

// RMC Smartgun

/datum/ammo/bullet/rifle/heavy/holo_target //Royal marines smartgun bullet, less damage, holo-target effect & range-limited knock/pushback
	name = "holo-targeting 10x28 bullet"
	damage = 40
	/// inflicts this many holo stacks per bullet hit
	var/holo_stacks = 25
	/// modifies the default cap limit of 100 by this amount
	var/bonus_damage_cap_increase = 300
	/// multiplies the default drain of 5 holo stacks per second by this amount
	var/stack_loss_multiplier = 2

/datum/ammo/bullet/rifle/heavy/holo_target/on_hit_mob(mob/hit_mob, obj/projectile/bullet)
	. = ..()
	hit_mob.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)
	knockback(hit_mob, bullet, max_range = 2)

/datum/ammo/bullet/rifle/heavy/holo_target/ap
	name = "holo-targetting armor-piercing 10x28 bullet"
	icon_state = "bullet"
	damage = 30
	penetration = ARMOR_PENETRATION_TIER_8

/datum/ammo/bullet/rifle/heavy/holo_target/impdet
	name = "holo-targetting impact-detonating 10x28 bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	holo_stacks = 50 //holo's all over targets, or something
	damage = 30
	penetration = -ARMOR_PENETRATION_TIER_2
	damage_falloff = DAMAGE_FALLOFF_TIER_5

/datum/ammo/bullet/rifle/heavy/holo_target/impdet/on_hit_mob(mob/entity, obj/projectile/bullet)
	..()
	slowdown(entity, bullet)

/datum/ammo/bullet/rifle/heavy/upp_smartgun
	name = "12.7x40 bullet"
	damage = 90 //giant fuck off bullet
	damage_falloff = 0

/datum/ammo/bullet/rifle/heavy/upp_smartgun/on_hit_mob(mob/target, obj/projectile/fired_proj)
	knockback(target, fired_proj, max_range = 5)

/datum/ammo/bullet/rifle/heavy/upp_smartgun/ap
	name = "12.7x40 armor-piercing bullet"
	damage = 75
	penetration = ARMOR_PENETRATION_TIER_8

/datum/ammo/bullet/rifle/heavy/upp_smartgun/flak
	name = "12.7x40 flak bullet" //the gun makes the round detonate really early or something
	damage = 20
	penetration = -ARMOR_PENETRATION_TIER_2
	bonus_projectiles_amount = EXTRA_PROJECTILES_TIER_3
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	bonus_projectiles_type = /datum/ammo/bullet/rifle/heavy/upp/flak_spread

/datum/ammo/bullet/rifle/heavy/upp/flak/on_hit_mob(mob/target, obj/projectile/fired_proj)
	knockback(target, fired_proj, max_range = 3)

/datum/ammo/bullet/rifle/heavy/upp/flak_spread
	name = "12.7x40 flak"
	damage = 15
	penetration = -ARMOR_PENETRATION_TIER_2
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	damage_var_low = PROJECTILE_VARIANCE_TIER_8
	damage_var_high = PROJECTILE_VARIANCE_TIER_8
	scatter = SCATTER_AMOUNT_TIER_2

/datum/ammo/bullet/rifle/heavy/upp/flak_spread/on_hit_mob(mob/target, obj/projectile/fired_proj)
	knockback(target, fired_proj, max_range = 3)


// Specialist M42A rounds

/datum/ammo/bullet/rifle/heavy/heap/sniper
	name = "high explosive armor-piercing sniper bullet"
	damage = 90 //match-grade munitions developing better velocity from the rifle
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER|AMMO_IGNORE_COVER

	accurate_range_min = 4
	accurate_range = 32
	effective_range_max = 0
	max_range = 32
	accuracy = HIT_ACCURACY_TIER_8
	scatter = 0
	shell_speed = AMMO_SPEED_TIER_8

/datum/ammo/bullet/rifle/heavy/incendiary
	name = "incendiary sniper bullet"
	damage_type = BRUTE
	damage = 60
	penetration = ARMOR_PENETRATION_TIER_4
	shrapnel_chance = 0
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER|AMMO_IGNORE_COVER

	accurate_range_min = 4
	accurate_range = 32
	effective_range_max = 0
	max_range = 32
	accuracy = HIT_ACCURACY_TIER_6
	shell_speed = AMMO_SPEED_TIER_7

/datum/ammo/bullet/rifle/heavy/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/rifle/heavy/incendiary/on_hit_mob(mob/M,obj/projectile/P)
	if((P.projectile_flags & PROJECTILE_BULLSEYE) && M == P.original)
		var/mob/living/L = M
		var/blind_duration = 5
		if(isxeno(M))
			var/mob/living/carbon/xenomorph/target = M
			if(target.mob_size >= MOB_SIZE_BIG)
				blind_duration = 2
		L.AdjustEyeBlur(blind_duration)
		L.adjust_fire_stacks(10)
		to_chat(P.firer, SPAN_WARNING("Bullseye!"))

/datum/ammo/bullet/rifle/heavy/flak
	name = "flak sniper bullet"
	damage_type = BRUTE
	damage = 55
	damage_var_high = PROJECTILE_VARIANCE_TIER_8 //Documenting old code: This converts to a variance of 96-109% damage. -Kaga
	penetration = 0
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_SNIPER|AMMO_IGNORE_COVER

	accurate_range_min = 4
	accurate_range = 32
	effective_range_max = 0
	max_range = 32
	accuracy = HIT_ACCURACY_TIER_8
	scatter = SCATTER_AMOUNT_TIER_8
	shell_speed = AMMO_SPEED_TIER_7

/datum/ammo/bullet/rifle/heavy/flak/on_hit_mob(mob/M,obj/projectile/P)
	if((P.projectile_flags & PROJECTILE_BULLSEYE) && M == P.original)
		var/slow_duration = 7
		var/mob/living/L = M
		if(isxeno(M))
			var/mob/living/carbon/xenomorph/target = M
			if(target.mob_size >= MOB_SIZE_BIG)
				slow_duration = 4
		M.adjust_effect(slow_duration, SUPERSLOW)
		L.apply_armoured_damage(damage, ARMOR_BULLET, BRUTE, null, penetration)
		to_chat(P.firer, SPAN_WARNING("Bullseye!"))
	else
		burst(get_turf(M),P,damage_type, 2 , 2)
		burst(get_turf(M),P,damage_type, 1 , 2 , 0)

/datum/ammo/bullet/rifle/heavy/flak/on_near_target(turf/T, obj/projectile/P)
	burst(T,P,damage_type, 2 , 2)
	burst(T,P,damage_type, 1 , 2, 0)
	return 1

// Custom Specialist M49A rounds

/datum/ammo/bullet/rifle/heavy/spec
	name = "high velocity 10x28 bullet"
	shrapnel_chance = 0
	damage_falloff = 0
	flags_ammo_behavior = AMMO_BALLISTIC
	accurate_range_min = 4

	damage = 65
	scatter = -SCATTER_AMOUNT_TIER_8
	penetration= ARMOR_PENETRATION_TIER_7
	shell_speed = AMMO_SPEED_TIER_7

/datum/ammo/bullet/rifle/heavy/spec/incendiary
	name = "high velocity incendiary 10x28 bullet"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 50
	penetration= ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/rifle/heavy/spec/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary, /datum/reagent/napalm/high_damage)
	))

/datum/ammo/bullet/rifle/heavy/spec/explosive
	name = "high velocity explosive 10x28 bullet"
	flags_ammo_behavior = AMMO_BALLISTIC

	damage = 50
	accuracy = HIT_ACCURACY_TIER_2
	penetration = ARMOR_PENETRATION_TIER_5
	damage_armor_punch = 5

/datum/ammo/bullet/rifle/heavy/spec/explosive/on_hit_mob(mob/M, obj/projectile/P)
	knockback(M, P, 6) // Can knockback out to 1/4th-range
	var/slow_duration = 7
	var/mob/living/L = M
	if(isxeno(M))
		var/mob/living/carbon/xenomorph/target = M
		if(target.mob_size >= MOB_SIZE_BIG)
			slow_duration = 2 // Crushers & such are still a threat, recovering much quicker
		M.adjust_effect(slow_duration, SUPERSLOW)
		L.apply_armoured_damage(damage, ARMOR_BULLET, BRUTE, null, penetration)
	else
		M.adjust_effect(slow_duration, SUPERSLOW)
		burst(get_turf(M),P,damage_type, 2 , 2)
		burst(get_turf(M),P,damage_type, 1 , 2 , 0)

/datum/ammo/bullet/rifle/heavy/spec/explosive/on_near_target(turf/T, obj/projectile/P)
	burst(T,P,damage_type, 2 , 4)
	burst(T,P,damage_type, 1 , 2, 0)
	return 1

/datum/ammo/bullet/rifle/heavy/spec/du
	name = "high velocity depleted uranium 10x28 bullet"

	damage = 50 //Overall same damage as base rounds, but 15 tox DoT
	penetration = ARMOR_PENETRATION_TIER_10 //DU's a heavy armour-piercing kind of material
	accuracy = HIT_ACCURACY_TIER_4
	scatter = -SCATTER_AMOUNT_TIER_8

/datum/ammo/bullet/rifle/heavy/spec/du/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/rifle/heavy/spec/du/on_hit_mob(mob/target, obj/projectile/fired_proj)
	target.AddComponent(/datum/component/status_effect/toxic_buildup, toxic_buildup = 15, toxic_buildup_dissipation = 0.3, max_buildup = 75)
	knockback(target, fired_proj, 16) // Can knockback out to 2/3rds-range
	if(target.mob_size >= MOB_SIZE_BIG)
		var/mob/living/L = target
		L.apply_armoured_damage(damage*1.3, ARMOR_BULLET, BRUTE, null, penetration) // As bugs don't take toxin damage, this should give it a little more oomf versus them

/datum/ammo/bullet/rifle/heavy/iff/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

//====== 10x27 Type 71

/datum/ammo/bullet/rifle/upp
	name = "10x27 bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	damage = 50
	penetration = ARMOR_PENETRATION_TIER_2
	accuracy = HIT_ACCURACY_TIER_3
	shell_speed = AMMO_SPEED_TIER_6
	effective_range_max = 10
	damage_falloff = DAMAGE_FALLOFF_TIER_7

/datum/ammo/bullet/rifle/upp/rubber
	name = "rubber 10x27 bullet"
	damage = 10
	stamina_damage = 20
	shrapnel_chance = 0

/datum/ammo/bullet/rifle/upp/tracer
	icon_state = "bullet_green"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_GREEN

/datum/ammo/bullet/rifle/upp/ap
	name = "armor-piercing 10x27 bullet"
	damage = 43
	penetration = ARMOR_PENETRATION_TIER_8

/datum/ammo/bullet/rifle/upp/ap/penetrating
	name = "wall-penerating 10x27 bullet"
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/upp/ap/penetrating/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating)
	))

/datum/ammo/bullet/rifle/upp/heap
	name = "high-explosive armor-piercing 10x27 bullet"
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 55
	penetration = ARMOR_PENETRATION_TIER_8
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_3

/datum/ammo/bullet/rifle/upp/heap/tracer
	icon_state = "bullet_green"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_GREEN

/datum/ammo/bullet/rifle/upp/heap/tracer/super_tracer
	name = "high-explosive armor-piercing magnesium tracer 10x27 bullet"

/datum/ammo/bullet/rifle/upp/heap/tracer/super_tracer/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary, stacks = 1, reagent = /datum/reagent/lithium)
	))

/datum/ammo/bullet/rifle/upp/heap/tracer/super_tracer/on_hit_mob(mob/M, obj/projectile/P)
	var/obj/item/device/flashlight/flare/on/illumination/chemical/light = new /obj/item/device/flashlight/flare/on/illumination/chemical(get_turf(M), 35)
	light.light_color = COLOR_GREEN

/datum/ammo/bullet/rifle/upp/heap/tracer/super_tracer/on_hit_turf(turf/T, obj/projectile/P)
	. = ..()
	var/obj/item/device/flashlight/flare/on/illumination/chemical/light = new /obj/item/device/flashlight/flare/on/illumination/chemical(T, 35)
	light.light_color = COLOR_GREEN

/datum/ammo/bullet/rifle/upp/heap/tracer/super_tracer/on_hit_obj(obj/O, obj/projectile/P)
	. = ..()
	var/obj/item/device/flashlight/flare/on/illumination/chemical/light = new /obj/item/device/flashlight/flare/on/illumination/chemical(get_turf(O), 35)
	light.light_color = COLOR_GREEN


/datum/ammo/bullet/rifle/upp/heap/tracer/penetrating
	name = "wall-penerating 10x27 bullet"
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_10
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "bullet_blue"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_CYAN
	//damage_falloff = DAMAGE_FALLOFF_TIER_4
	//max_range = /datum/ammo/bullet/rifle/upp/heap/mg::max_range*2

/datum/ammo/bullet/rifle/upp/heap/tracer/penetrating/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_penetrating/weak/pkp)
	))

//10X31 AK500
/datum/ammo/bullet/rifle/heavy/upp
	name = "10x31 bullet"

// Misc

/datum/ammo/bullet/rifle/mar40
	name = "8.8x29 rifle bullet"
	damage = 45
	shell_casing = /obj/effect/decal/ammo_casing/cartridge

/datum/ammo/bullet/rifle/m16
	name = "5.56x45 rifle bullet"
	damage = 35
	shell_casing = /obj/effect/decal/ammo_casing/cartridge

/datum/ammo/bullet/rifle/m16/ap
	name = "armor-piercing 5.56x45 rifle bullet"
	damage = 30
	penetration = ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/rifle/ar10
	name = "7.62x51 rifle bullet"
	damage = 55
	shell_casing = /obj/effect/decal/ammo_casing/cartridge

//R81M1
/datum/ammo/bullet/rifle/r81m1
	name = "9x32 high-velocity rifle bullet"
	damage = 50
	accuracy = HIT_ACCURACY_TIER_5

/datum/ammo/bullet/rifle/r81m1/ap
	name = "9x32 high-velocity AP rifle bullet"
	damage = 40
	penetration = ARMOR_PENETRATION_TIER_3

/datum/ammo/bullet/rifle/r81m1/hp
	name = "9x32 high-velocity HP rifle bullet"
	damage = 60
	penetration = -ARMOR_PENETRATION_TIER_3
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_5

//NSG TWE RMC AMMO

/datum/ammo/bullet/rifle/twe
	name = "8.5x33 bullet"
	damage = 36
	penetration = ARMOR_PENETRATION_TIER_2
	accurate_range = 20

/datum/ammo/bullet/rifle/ap/twe
	name = "armor-piercing 8.5x33 bullet"

/datum/ammo/bullet/rifle/heap/twe
	name = "high-explosive armor-piercing 8.5x33 bullet"
	damage = 50
	penetration = ARMOR_PENETRATION_TIER_9
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_4

//9.7x16 AG80

/datum/ammo/bullet/rifle/ag80
	name = "9.7x16 bullet"
	damage = 35
	penetration = ARMOR_PENETRATION_TIER_1 // shouldn't be higher pen than 10x24

/datum/ammo/bullet/rifle/ag80/tracer
	icon_state = "bullet_green"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_GREEN

/datum/ammo/bullet/rifle/ag80/ap
	name = "armor-piercing 9.7x16 bullet"
	damage = 30
	penetration = ARMOR_PENETRATION_TIER_7 // not as good as 10x24 AP but still impressive for calibre size

/datum/ammo/bullet/rifle/ag80/rubber
	name = "rubber 9.7x16 bullet"
	damage = 4
	stamina_damage = 12
	shrapnel_chance = 0

/datum/ammo/bullet/rifle/ag80/heap
	name = "high-explosive armor-piercing 9.7x16 bullet"
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	damage = 45 //big damage, doesn't actually blow up because thats stupid.
	penetration = ARMOR_PENETRATION_TIER_6
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_2 //thinner round should have less shrap potential vs the 10x24, no?

/datum/ammo/bullet/rifle/ag80/heap/tracer
	icon_state = "bullet_green"
	ammo_glowing = TRUE
	bullet_light_color = COLOR_SOFT_GREEN

/datum/ammo/bullet/rifle/lw317
	name = "6x38 bullet"
	damage = 35
	penetration = ARMOR_PENETRATION_TIER_1

/datum/ammo/bullet/rifle/lw317/ap
	name = "armor-piercing 6x38 bullet"
	damage = 30
	penetration = ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/rifle/isr
	name = "heavy 9.2x34mm bullet"

	damage = 35
	penetration = ARMOR_PENETRATION_TIER_1
