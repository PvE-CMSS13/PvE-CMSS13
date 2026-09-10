/*
//======
					Rocket Ammo
//======
*/

/datum/ammo/rocket
	name = "hypervelocity high explosive rocket"
	icon_state = "missile"
	ping = null //no bounce off.
	sound_bounce = "rocket_ricochet"
	damage_falloff = 0
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_STRIKES_SURFACE
	var/datum/effect_system/smoke_spread/smoke

	accuracy = HIT_ACCURACY_TIER_2
	accurate_range = 7
	max_range = 11
	damage = 15
	shell_speed = AMMO_SPEED_TIER_5
	ammo_glowing = TRUE
	bullet_light_color = COLOR_VERY_SOFT_YELLOW
	var/blast_power = 300
	var/falloff_rate = 40

/datum/ammo/rocket/New()
	..()
	smoke = new()

/datum/ammo/rocket/Destroy()
	qdel(smoke)
	smoke = null
	. = ..()

/datum/ammo/rocket/on_hit_mob(mob/mob, obj/projectile/projectile)
	if(iscarbon(mob)) // Doesn't matter how built-different you are, it's an explosive rocket-propelled projectile hitting you.
		mob.ex_act((blast_power*2), null, projectile.weapon_cause_data, 100)
	cell_explosion(get_turf(mob), blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	smoke.set_up(1, get_turf(mob))
	smoke.start()

/datum/ammo/rocket/on_hit_obj(obj/object, obj/projectile/projectile)
	cell_explosion(get_turf(object), blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	smoke.set_up(1, get_turf(object))
	smoke.start()

/datum/ammo/rocket/on_hit_turf(turf/turf, obj/projectile/projectile)
	cell_explosion(turf, blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	smoke.set_up(1, turf)
	smoke.start()

/datum/ammo/rocket/do_at_max_range(obj/projectile/projectile)
	cell_explosion(get_turf(projectile), blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	smoke.set_up(1, get_turf(projectile))
	smoke.start()

/datum/ammo/rocket/smoke
	name = "hypervelocity smoke rocket"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_STRIKES_SURFACE
	damage = 350
	blast_power = 50
	falloff_rate = 100

/datum/ammo/rocket/smoke/on_hit_mob(mob/mob, obj/projectile/projectile)
	cell_explosion(get_turf(mob), blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	var/datum/effect_system/smoke_spread/bad/landingSmoke = new /datum/effect_system/smoke_spread/bad
	landingSmoke.set_up(5, 0, get_turf(mob), null, 30)
	landingSmoke.start()
	landingSmoke = null


/datum/ammo/rocket/smoke/on_hit_obj(obj/object, obj/projectile/projectile)
	cell_explosion(get_turf(object), blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	var/datum/effect_system/smoke_spread/bad/landingSmoke = new /datum/effect_system/smoke_spread/bad
	landingSmoke.set_up(5, 0, get_turf(object), null, 30)
	landingSmoke.start()
	landingSmoke = null

/datum/ammo/rocket/smoke/on_hit_turf(turf/turf, obj/projectile/projectile)
	cell_explosion(turf, blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	var/datum/effect_system/smoke_spread/bad/landingSmoke = new /datum/effect_system/smoke_spread/bad
	landingSmoke.set_up(5, 0, turf, null, 30)
	landingSmoke.start()
	landingSmoke = null

/datum/ammo/rocket/smoke/do_at_max_range(obj/projectile/projectile)
	cell_explosion(get_turf(projectile), blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
	var/datum/effect_system/smoke_spread/bad/landingSmoke = new /datum/effect_system/smoke_spread/bad
	landingSmoke.set_up(5, 0, get_turf(projectile), null, 30)
	landingSmoke.start()
	landingSmoke = null

/datum/ammo/rocket/ap
	name = "hypervelocity anti-armor rocket"
	damage_falloff = 0
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET

	accuracy = HIT_ACCURACY_TIER_8
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_9
	accurate_range = 9
	max_range = 11
	damage = 150
	shrapnel_chance = 5
	shrapnel_type = /obj/item/large_shrapnel/at_rocket_dud
	penetration= ARMOR_PENETRATION_TIER_10
	var/vehicle_slowdown_time = 2 SECONDS
	blast_power = 200
	falloff_rate = 50

/datum/ammo/rocket/ap/on_hit_mob(mob/mob, obj/projectile/projectile)
	var/turf/turf = get_turf(mob)
	mob.ex_act((blast_power*2), projectile.dir, projectile.weapon_cause_data, 100)
	mob.apply_effect(3, WEAKEN)
	mob.apply_effect(3, PARALYZE)
	if(iscarbon(mob)) // Doesn't matter how built-different you are, it's an explosive rocket-propelled projectile hitting you.
		mob.ex_act((blast_power*3), null, projectile.weapon_cause_data, 100)
	if(mob.mob_size >= MOB_SIZE_BIG) // Bonus vs BIG things
		var/mob/living/alivent = mob
		alivent.apply_armoured_damage(damage*2.5, ARMOR_BOMB, BRUTE, null, penetration)
	cell_explosion(turf, blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	smoke.set_up(1, turf)
	smoke.start()

/datum/ammo/rocket/ap/on_hit_obj(obj/object, obj/projectile/projectile)
	if(istype(object, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/mob = object
		mob.next_move = world.time + vehicle_slowdown_time
		playsound(mob, 'sound/effects/meteorimpact.ogg', 35)
		mob.at_munition_interior_explosion_effect(cause_data = create_cause_data("Anti-Armor Rocket"))
		mob.interior_crash_effect()
		mob.ex_act((blast_power*2), projectile.dir, projectile.weapon_cause_data, 100)
	else
		var/turf/turf = get_turf(object)
		object.ex_act((blast_power*2), projectile.dir, projectile.weapon_cause_data, 100)
		cell_explosion(turf, blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
		smoke.set_up(1, turf)
		smoke.start()

/datum/ammo/rocket/ap/on_hit_turf(turf/turf, obj/projectile/projectile)
	var/hit_something = 0
	for(var/mob/mob in turf)
		mob.ex_act((blast_power*2), projectile.dir, projectile.weapon_cause_data, 100)
		mob.apply_effect(3, WEAKEN)
		mob.apply_effect(3, PARALYZE)
		hit_something = 1
		continue
	if(!hit_something)
		for(var/obj/object in turf)
			if(object.density)
				object.ex_act((blast_power*2), projectile.dir, projectile.weapon_cause_data, 100)
				hit_something = 1
				continue
	if(!hit_something)
		turf.ex_act(blast_power, projectile.dir, projectile.weapon_cause_data, 200)

	cell_explosion(turf, blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	smoke.set_up(1, turf)
	smoke.start()

/datum/ammo/rocket/ap/do_at_max_range(obj/projectile/projectile)
	var/turf/turf = get_turf(projectile)
	var/hit_something = 0
	for(var/mob/mob in turf)
		mob.ex_act((blast_power*3), projectile.dir, projectile.weapon_cause_data, 100)
		mob.apply_effect(3, WEAKEN)
		mob.apply_effect(3, PARALYZE)
		hit_something = 1
		break
	if(!hit_something)
		for(var/obj/object in turf)
			if(object.density)
				object.ex_act(blast_power, projectile.dir, projectile.weapon_cause_data, 100)
				hit_something = 1
				break
	if(!hit_something)
		turf.ex_act(blast_power, projectile.dir, projectile.weapon_cause_data)
	cell_explosion(turf, blast_power, falloff_rate, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	smoke.set_up(1, turf)
	smoke.start()

/datum/ammo/rocket/ap/anti_tank
	name = "anti-tank rocket"
	damage = 200
	vehicle_slowdown_time = 5 SECONDS
	shell_speed = AMMO_SPEED_TIER_3 //Someone might manage to hit a rest hotkey in time at this speed, who knows
	blast_power = 100
	falloff_rate = 100

/datum/ammo/rocket/ap/anti_tank/on_hit_obj(obj/object, obj/projectile/projectile)
	if(istype(object, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/mob = object
		mob.next_move = world.time + vehicle_slowdown_time
		playsound(mob, 'sound/effects/meteorimpact.ogg', 35)
		mob.at_munition_interior_explosion_effect(cause_data = create_cause_data("Anti-Tank Rocket"))
		mob.interior_crash_effect()
		var/turf/turf = get_turf(mob.loc)
		mob.ex_act(blast_power, projectile.dir, projectile.weapon_cause_data, 100)
		smoke.set_up(1, turf)
		smoke.start()
		return
	return ..()

/datum/ammo/rocket/ap/tank_towlauncher
	name = "anti-armor missile"
	max_range = 16

/datum/ammo/rocket/ap/tank_towlauncher/aa
	name = "hypervelocity missile"
	max_range = 16
	shell_speed = AMMO_SPEED_TIER_8

//USCM Hornet AA missile
/datum/ammo/rocket/ap/anti_air
	name = "hypervelocity anti-air missile"
	damage = 250
	max_range = 16
	vehicle_slowdown_time = 4 SECONDS
	shell_speed = AMMO_SPEED_TIER_8

// UPP APC MISSILES
/datum/ammo/rocket/ap/tank_towlauncher/hj35_launcher
	icon_state = "hj35_missile"
	max_range = 16

//UPP TANK RAILGUN CANNON
/datum/ammo/rocket/ap/railgun
	name = "railgun round"
	icon_state = "railgun"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET

	accuracy = HIT_ACCURACY_TIER_5
	accurate_range = 32
	max_range = 32
	damage = 250
	damage_var_high = 120
	shell_speed = AMMO_SPEED_TIER_HITSCAN
	vehicle_slowdown_time = 15 SECONDS
	penetration= ARMOR_PENETRATION_TIER_10

/datum/ammo/rocket/ap/railgun/do_at_max_range(obj/projectile/projectile)
	var/turf/turf = get_turf(projectile)
	var/hit_something = 0
	for(var/mob/mob in turf)
		mob.ex_act(450, projectile.dir, projectile.weapon_cause_data, 40)
		mob.apply_effect(3, WEAKEN)
		mob.apply_effect(3, PARALYZE)
		hit_something = 1
		break
	if(!hit_something)
		for(var/obj/object in turf)
			if(object.density)
				object.ex_act(250, projectile.dir, projectile.weapon_cause_data, 200)
				hit_something = 1
				break
	if(!hit_something)
		turf.ex_act(150, projectile.dir, projectile.weapon_cause_data)
	cell_explosion(turf, 550, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	smoke.set_up(1, turf)
	smoke.start()

/datum/ammo/rocket/ap/railgun/on_hit_obj(obj/object, obj/projectile/projectile)
	if(istype(object, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/mob = object
		mob.next_move = world.time + vehicle_slowdown_time
		playsound(mob, 'sound/effects/meteorimpact.ogg', 35)
		mob.at_munition_interior_explosion_effect(cause_data = create_cause_data("railgun round"))
		mob.interior_crash_effect()
		var/turf/turf = get_turf(mob.loc)
		mob.ex_act(50, projectile.dir, projectile.weapon_cause_data, 50)
		cell_explosion(get_turf(mob), 100, 40, EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL, null, projectile.weapon_cause_data)
		smoke.set_up(1, turf)
		smoke.start()

		return
	return ..()

//UPP Goose AA missile
/datum/ammo/rocket/anti_air
	name = "anti-air missile"
	icon_state = "emblr"
	damage = 100
	max_range = 14
	shell_speed = AMMO_SPEED_TIER_6

//UA TANK CANNON
/datum/ammo/rocket/ltb
	name = "cannon round"
	icon_state = "ltb"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET

	accuracy = HIT_ACCURACY_TIER_3
	accurate_range = 32
	max_range = 32
	damage = 200
	shell_speed = AMMO_SPEED_TIER_3
	var/vehicle_slowdown_time = 10 SECONDS

/datum/ammo/rocket/ltb/on_hit_mob(mob/mob, obj/projectile/projectile)
	if(iscarbon(mob)) // Tank beats everything.
		mob.ex_act(350, null, projectile.weapon_cause_data, 150)
	if(mob.mob_size >= MOB_SIZE_BIG)
		var/mob/living/alivent = mob
		alivent.apply_armoured_damage(damage*2.5, ARMOR_BOMB, BRUTE, null, penetration)
	cell_explosion(get_turf(mob), 165, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	cell_explosion(get_turf(mob), 150, 100, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/rocket/ltb/on_hit_obj(obj/object, obj/projectile/projectile)
	if(istype(object, /obj/vehicle/multitile))
		var/obj/vehicle/multitile/mob = object
		mob.next_move = world.time + vehicle_slowdown_time
		playsound(mob, 'sound/effects/meteorimpact.ogg', 35)
		mob.at_munition_interior_explosion_effect(cause_data = create_cause_data("Anti-Tank Rocket"))
		mob.interior_crash_effect()
		var/turf/turf = get_turf(mob.loc)
		mob.ex_act(150, projectile.dir, projectile.weapon_cause_data, 100)
		smoke.set_up(1, turf)
		smoke.start()
		return
	cell_explosion(get_turf(object), 165, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	cell_explosion(get_turf(object), 150, 100, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/rocket/ltb/on_hit_turf(turf/turf, obj/projectile/projectile)
	cell_explosion(get_turf(turf), 165, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	cell_explosion(get_turf(turf), 150, 100, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/rocket/ltb/do_at_max_range(obj/projectile/projectile)
	cell_explosion(get_turf(projectile), 165, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	cell_explosion(get_turf(projectile), 150, 100, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

//UPP TANK CANNON
/datum/ammo/rocket/ltb/p17702
	name = "93mmm round"
	icon_state = "p17702"

	shell_speed = AMMO_SPEED_TIER_4

/datum/ammo/rocket/wp
	name = "white phosphorous rocket"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_EXPLOSIVE|AMMO_STRIKES_SURFACE
	damage_type = BURN

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 8
	damage = 90
	max_range = 11

/datum/ammo/rocket/wp/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/rocket/wp/drop_flame(turf/turf, datum/cause_data/cause_data)
	playsound(turf, 'sound/weapons/gun_flamethrower3.ogg', 75, 1, 7)
	if(!istype(turf)) return
	smoke.set_up(1, turf)
	smoke.start()
	var/datum/reagent/napalm/blue/reagent = new()
	new /obj/flamer_fire(turf, cause_data, reagent, 3)

	var/datum/effect_system/smoke_spread/phosphorus/strong/landingSmoke = new /datum/effect_system/smoke_spread/phosphorus/strong
	landingSmoke.set_up(3, 0, turf, null, 6, cause_data)
	landingSmoke.start()
	landingSmoke = null

/datum/ammo/rocket/wp/on_hit_mob(mob/mob, obj/projectile/projectile)
	drop_flame(get_turf(mob), projectile.weapon_cause_data)

/datum/ammo/rocket/wp/on_hit_obj(obj/object, obj/projectile/projectile)
	drop_flame(get_turf(object), projectile.weapon_cause_data)

/datum/ammo/rocket/wp/on_hit_turf(turf/turf, obj/projectile/projectile)
	drop_flame(turf, projectile.weapon_cause_data)

/datum/ammo/rocket/wp/do_at_max_range(obj/projectile/projectile)
	drop_flame(get_turf(projectile), projectile.weapon_cause_data)

/datum/ammo/rocket/wp/upp
	name = "extreme-intensity incendiary rocket"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_EXPLOSIVE|AMMO_STRIKES_SURFACE
	damage_type = BURN

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 8
	damage = 150
	max_range = 10

/datum/ammo/rocket/wp/upp/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/rocket/wp/upp/drop_flame(turf/turf, datum/cause_data/cause_data)
	playsound(turf, 'sound/weapons/gun_flamethrower3.ogg', 75, 1, 7)
	if(!istype(turf)) return
	smoke.set_up(1, turf)
	smoke.start()
	var/datum/reagent/napalm/upp/reagent = new()
	new /obj/flamer_fire(turf, cause_data, reagent, 3)

/datum/ammo/rocket/wp/upp/on_hit_mob(mob/mob, obj/projectile/projectile)
	drop_flame(get_turf(mob), projectile.weapon_cause_data)

/datum/ammo/rocket/wp/upp/on_hit_obj(obj/object, obj/projectile/projectile)
	drop_flame(get_turf(object), projectile.weapon_cause_data)

/datum/ammo/rocket/wp/upp/on_hit_turf(turf/turf, obj/projectile/projectile)
	drop_flame(turf, projectile.weapon_cause_data)

/datum/ammo/rocket/wp/upp/do_at_max_range(obj/projectile/projectile)
	drop_flame(get_turf(projectile), projectile.weapon_cause_data)

/datum/ammo/rocket/wp/quad
	name = "thermobaric rocket"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_STRIKES_SURFACE

	damage = 100
	max_range = 32
	shell_speed = AMMO_SPEED_TIER_3

/datum/ammo/rocket/wp/quad/on_hit_mob(mob/mob, obj/projectile/projectile)
	drop_flame(get_turf(mob), projectile.weapon_cause_data)
	explosion(projectile.loc,  -1, 2, 4, 5, , , ,projectile.weapon_cause_data)

/datum/ammo/rocket/wp/quad/on_hit_obj(obj/object, obj/projectile/projectile)
	drop_flame(get_turf(object), projectile.weapon_cause_data)
	explosion(projectile.loc,  -1, 2, 4, 5, , , ,projectile.weapon_cause_data)

/datum/ammo/rocket/wp/quad/on_hit_turf(turf/turf, obj/projectile/projectile)
	drop_flame(turf, projectile.weapon_cause_data)
	explosion(projectile.loc,  -1, 2, 4, 5, , , ,projectile.weapon_cause_data)

/datum/ammo/rocket/wp/quad/do_at_max_range(obj/projectile/projectile)
	drop_flame(get_turf(projectile), projectile.weapon_cause_data)
	explosion(projectile.loc,  -1, 2, 4, 5, , , ,projectile.weapon_cause_data)

/datum/ammo/rocket/custom
	name = "custom rocket"
	accurate_range = 8
	max_range = 8

/datum/ammo/rocket/custom/proc/prime(atom/atom, obj/projectile/projectile)
	var/obj/item/weapon/gun/launcher/rocket/launcher = projectile.shot_from
	var/obj/item/ammo_magazine/rocket/custom/rocket = launcher.current_mag
	if(rocket.locked && rocket.warhead && rocket.warhead.detonator)
		if(rocket.fuel && rocket.fuel.reagents.get_reagent_amount(rocket.fuel_type) >= rocket.fuel_requirement)
			rocket.forceMove(projectile.loc)
		rocket.warhead.cause_data = projectile.weapon_cause_data
		rocket.warhead.prime()
		qdel(rocket)
	smoke.set_up(1, get_turf(atom))
	smoke.start()

/datum/ammo/rocket/custom/on_hit_mob(mob/mob, obj/projectile/projectile)
	prime(mob, projectile)

/datum/ammo/rocket/custom/on_hit_obj(obj/object, obj/projectile/projectile)
	prime(object, projectile)

/datum/ammo/rocket/custom/on_hit_turf(turf/turf, obj/projectile/projectile)
	prime(turf, projectile)

/datum/ammo/rocket/custom/do_at_max_range(obj/projectile/projectile)
	prime(null, projectile)

