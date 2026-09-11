/*
//======
					Shrapnel
//======
*/
/datum/ammo/bullet/shrapnel
	name = "shrapnel"
	icon_state = "buckshot"
	accurate_range_min = 4
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER

	accuracy = HIT_ACCURACY_TIER_3
	accurate_range = 32
	max_range = 4
	damage = 25
	damage_var_low = -PROJECTILE_VARIANCE_TIER_6
	damage_var_high = PROJECTILE_VARIANCE_TIER_6
	penetration = ARMOR_PENETRATION_TIER_4
	shell_speed = AMMO_SPEED_TIER_2
	shrapnel_chance = 5

/datum/ammo/bullet/shrapnel/on_hit_obj(obj/O, obj/projectile/P)
	if(istype(O, /obj/structure/barricade))
		var/obj/structure/barricade/B = O
		B.health -= rand(2, 5)
		B.update_health(1)

/datum/ammo/bullet/shrapnel/landmine
	name = "landmine shrapnel"
	icon_state = "buckshot"
	accurate_range_min = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER

	accuracy = HIT_ACCURACY_TIER_2
	accurate_range = 3
	max_range = 6
	damage = 10
	damage_var_low = -PROJECTILE_VARIANCE_TIER_6
	damage_var_high = PROJECTILE_VARIANCE_TIER_6
	penetration = -ARMOR_PENETRATION_TIER_1
	shell_speed = AMMO_SPEED_TIER_2
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/landmine/strong
	damage = 30
	accuracy = HIT_ACCURACY_TIER_4
	shrapnel_chance = 5

//shrapnel for M5 boundmine
/datum/ammo/bullet/shrapnel/landmine/bounding
	name = "airburst shrapnel"
	icon_state = "buckshot"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER|AMMO_PRONETARGET

	accuracy = HIT_ACCURACY_TIER_3
	accurate_range = 2
	max_range = 5
	damage = 10
	damage_falloff = DAMAGE_FALLOFF_TIER_6
	damage_var_low = -PROJECTILE_VARIANCE_TIER_6
	damage_var_high = PROJECTILE_VARIANCE_TIER_6
	penetration = 0
	shell_speed = AMMO_SPEED_TIER_2
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/landmine/bounding/strong
	damage = 20
	penetration = 0
	shrapnel_chance = 5
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER

//shrapnel for TN13 mine
/datum/ammo/bullet/shrapnel/landmine/light
	name = "jagged landmine fragmentation"
	damage = 5
	penetration = -ARMOR_PENETRATION_TIER_1
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/landmine/light/strong
	damage = 15

/datum/ammo/bullet/shrapnel/rubber
	name = "rubber pellets"
	icon_state = "rubber_pellets"
	flags_ammo_behavior = AMMO_STOPPED_BY_COVER

	damage = 0
	stamina_damage = 25
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/canister
	name = "low velocity canister shot"
	icon_state = "buckshot"

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_4
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_8
	damage = 65
	penetration = ARMOR_PENETRATION_TIER_2
	shell_speed = AMMO_SPEED_TIER_1
	damage_armor_punch = 1
	pen_armor_punch = 0
	accurate_range = 3
	effective_range_max = 5
	damage_falloff = DAMAGE_FALLOFF_TIER_1
	max_range = 7

/datum/ammo/bullet/shrapnel/canister/on_hit_mob(mob/M, obj/projectile/P)
	knockback(M, P, 4)
/datum/ammo/bullet/shrapnel/canister/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
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


/datum/ammo/bullet/shrapnel/canister/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("turfs", /datum/element/bullet_trait_damage_boost, 6, GLOB.damage_boost_turfs),
		BULLET_TRAIT_ENTRY_ID("breaching", /datum/element/bullet_trait_damage_boost, 6, GLOB.damage_boost_breaching),
		BULLET_TRAIT_ENTRY_ID("pylons", /datum/element/bullet_trait_damage_boost, 5, GLOB.damage_boost_pylons)
	))

/datum/ammo/bullet/shrapnel/heavy
	name = "shrapnel cloud"
	icon_state = "shrapnel_light"
	flags_ammo_behavior = AMMO_PRONETARGET
	max_range = 6
	damage = 35
	damage_var_low = -PROJECTILE_VARIANCE_TIER_4
	damage_var_high = PROJECTILE_VARIANCE_TIER_6
	penetration = ARMOR_PENETRATION_TIER_3
	shell_speed = AMMO_SPEED_TIER_3
	shrapnel_chance = 10

/datum/ammo/bullet/shrapnel/claymore
	name = "claymore pellet"
	icon_state = "buckshot"
	accurate_range_min = 0
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_PRONETARGET|AMMO_STOPPED_BY_COVER
	accuracy = HIT_ACCURACY_TIER_10 //half & half chance of being hit
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_5
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_9
	accurate_range = 7
	max_range = 10
	damage = 20
	damage_var_low = PROJECTILE_VARIANCE_TIER_5
	damage_var_high = PROJECTILE_VARIANCE_TIER_5
	penetration = ARMOR_PENETRATION_TIER_1
	shell_speed = AMMO_SPEED_TIER_3
	shrapnel_chance = 5

//player-given claymore shrapnel
/datum/ammo/bullet/shrapnel/claymore/strong
	damage = 40
	damage_falloff = DAMAGE_FALLOFF_TIER_8
	shrapnel_chance = 15

/datum/ammo/bullet/shrapnel/claymore/strong/on_hit_mob(mob/entity, obj/projectile/bullet)
	. = ..()
	knockback(entity, bullet, 4)

/datum/ammo/bullet/shrapnel/claymore/strong/knockback_effects(mob/living/living_mob, obj/projectile/fired_projectile)
	if(iscarbonsizexeno(living_mob))
		var/mob/living/carbon/xenomorph/target = living_mob
		to_chat(target, SPAN_XENODANGER("You are shaken and slowed by the sudden impact!"))
		target.KnockDown(1.5)
		target.Stun(1.5)
		target.Slow(3)
	else
		living_mob.KnockDown(1.5)
		living_mob.Stun(1.5)
		living_mob.Slow(3)
		to_chat(living_mob, SPAN_HIGHDANGER("The impact knocks you off-balance!"))

/datum/ammo/bullet/shrapnel/hornet_rounds
	name = ".22 hornet round"
	icon_state = "hornet_round"
	flags_ammo_behavior = AMMO_BALLISTIC
	damage = 20
	shrapnel_chance = 0
	shell_speed = AMMO_SPEED_TIER_3//she fast af boi
	penetration = ARMOR_PENETRATION_TIER_5
	/// inflicts this many holo stacks per bullet hit
	var/holo_stacks = 10
	/// modifies the default cap limit of 100 by this amount
	var/bonus_damage_cap_increase = 0
	/// multiplies the default drain of 5 holo stacks per second by this amount
	var/stack_loss_multiplier = 1

/datum/ammo/bullet/shrapnel/hornet_rounds/on_hit_mob(mob/hit_mob, obj/projectile/bullet)
	. = ..()
	hit_mob.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)

/datum/ammo/bullet/shrapnel/hornet_rounds/rmc
	name = "holo-targeting pellet"
	icon_state = "hornet_round"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER
	damage = 10
	holo_stacks = 30
	accuracy = HIT_ACCURACY_TIER_5
	max_range = 6

/datum/ammo/bullet/shrapnel/incendiary
	name = "flaming shrapnel"
	icon_state = "beanbag" // looks suprisingly a lot like flaming shrapnel chunks
	flags_ammo_behavior = AMMO_STOPPED_BY_COVER

	shell_speed = AMMO_SPEED_TIER_1
	damage = 20
	penetration = ARMOR_PENETRATION_TIER_4

/datum/ammo/bullet/shrapnel/incendiary/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/bullet/shrapnel/incendiary/light
	damage = 10
	penetration = ARMOR_PENETRATION_TIER_2

/datum/ammo/bullet/shrapnel/incendiary/heavy	//Maximum warcrimes edition
	accurate_range = 32
	max_range = 8
	shell_speed = AMMO_SPEED_TIER_2
	damage = 20
	penetration = ARMOR_PENETRATION_TIER_5

/datum/ammo/bullet/shrapnel/incendiary/heavy/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary, reagent = /datum/reagent/napalm/blue)
	))

/datum/ammo/bullet/shrapnel/metal
	name = "metal shrapnel"
	icon_state = "shrapnelshot_bit"
	flags_ammo_behavior = AMMO_STOPPED_BY_COVER|AMMO_BALLISTIC
	shell_speed = AMMO_SPEED_TIER_1
	damage = 30
	shrapnel_chance = 15
	accuracy = HIT_ACCURACY_TIER_8
	penetration = ARMOR_PENETRATION_TIER_4

/datum/ammo/bullet/shrapnel/light // weak shrapnel
	name = "light shrapnel"
	icon_state = "shrapnel_light"

	damage = 10
	penetration = ARMOR_PENETRATION_TIER_1
	shell_speed = AMMO_SPEED_TIER_1
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/light/human
	name = "human bone fragments"
	icon_state = "shrapnel_human"

	shrapnel_chance = 50
	shrapnel_type = /obj/item/shard/shrapnel/bone_chips/human

/datum/ammo/bullet/shrapnel/light/human/var1 // sprite variants
	icon_state = "shrapnel_human1"

/datum/ammo/bullet/shrapnel/light/human/var2 // sprite variants
	icon_state = "shrapnel_human2"

/datum/ammo/bullet/shrapnel/light/xeno
	name = "alien bone fragments"
	icon_state = "shrapnel_xeno"

	shrapnel_chance = 50
	shrapnel_type = /obj/item/shard/shrapnel/bone_chips/xeno

/datum/ammo/bullet/shrapnel/spall // weak shrapnel
	name = "spall"
	icon_state = "shrapnel_light"

	damage = 10
	penetration = ARMOR_PENETRATION_TIER_1
	shell_speed = AMMO_SPEED_TIER_1
	shrapnel_chance = 0

/datum/ammo/bullet/shrapnel/light/glass
	name = "glass shrapnel"
	icon_state = "shrapnel_glass"

/particles/shrapnel
	icon = 'icons/obj/items/weapons/projectiles.dmi'
	icon_state = "shrapnel_bright2"
	width = 1000
	height = 1000
	count = 100
	spawning = 0
	lifespan = 0.6 SECONDS
	fadein = 0.2 SECONDS
	velocity = generator("square", 32 * 0.85, 32 * 1.15)
	rotation = generator("num", 0, 359)

/obj/shrapnel_effect
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	unacidable = TRUE
	blocks_emissive = EMISSIVE_BLOCK_GENERIC

/obj/shrapnel_effect/New()
	. = ..()
	particles = new /particles/shrapnel
	particles.spawning = rand(5,9) + rand(5,9)
	addtimer(CALLBACK(src, PROC_REF(stop)), 0.1 SECONDS)
	QDEL_IN(src, 0.9 SECONDS)

/obj/shrapnel_effect/proc/stop()
	particles.spawning = 0

/obj/shrapnel_effect/get_applying_acid_time()
	return -1

/datum/ammo/bullet/shrapnel/jagged
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_2
	accuracy = HIT_ACCURACY_TIER_MAX

/datum/ammo/bullet/shrapnel/jagged/on_hit_mob(mob/M, obj/projectile/P)
	if(isxeno(M))
		M.apply_effect(0.4, SLOW)

/datum/ammo/bullet/shrapnel/himat
	accurate_range = 8
	max_range = 8
	damage = 95
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_2
	accuracy = HIT_ACCURACY_TIER_MAX
	icon_state = "shrapnel_light"

/*
//========
					CAS 30mm impacters
//========
*/
/datum/ammo/bullet/shrapnel/gau  //for the GAU to have a impact bullet instead of firecrackers
	name = "30mm Multi-Purpose shell"

	damage = 1 // ALL DAMAGE IS IN dropship_ammo SO WE CAN DEAL DAMAGE TO RESTING MOBS, these will still remain however so that we can get cause_data and status effects.
	damage_type = BRUTE
	penetration = ARMOR_PENETRATION_TIER_2
	accuracy = HIT_ACCURACY_TIER_MAX
	max_range = 0
	shrapnel_chance = 100 //the least of your problems

/datum/ammo/bullet/shrapnel/gau/at
	name = "30mm Anti-Tank shell"

	damage = 1 // ALL DAMAGE IS IN dropship_ammo SO WE CAN DEAL DAMAGE TO RESTING MOBS, these will still remain however so that we can get cause_data and status effects.
	penetration = ARMOR_PENETRATION_TIER_8
	accuracy = HIT_ACCURACY_TIER_MAX
