/*
//======
					Misc Ammo
//======
*/

/datum/ammo/alloy_spike
	name = "alloy spike"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	ping = "ping_s"
	icon_state = "MSpearFlight"
	sound_hit = "alloy_hit"
	sound_armor = "alloy_armor"
	sound_bounce = "alloy_bounce"

	accuracy = HIT_ACCURACY_TIER_8
	accurate_range = 12
	max_range = 12
	damage = 30
	penetration= ARMOR_PENETRATION_TIER_10
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_7
	shrapnel_type = /obj/item/shard/shrapnel

/datum/ammo/flamethrower
	name = "flame"
	icon_state = "pulse0"
	damage_type = BURN
	flags_ammo_behavior = AMMO_IGNORE_ARMOR|AMMO_HITS_TARGET_TURF

	max_range = 6
	damage = 35

/datum/ammo/flamethrower/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/flamethrower/on_hit_mob(mob/M, obj/projectile/P)
	drop_flame(get_turf(M), P.weapon_cause_data)

/datum/ammo/flamethrower/on_hit_obj(obj/O, obj/projectile/P)
	drop_flame(get_turf(O), P.weapon_cause_data)

/datum/ammo/flamethrower/on_hit_turf(turf/T, obj/projectile/P)
	drop_flame(T, P.weapon_cause_data)

/datum/ammo/flamethrower/do_at_max_range(obj/projectile/P)
	drop_flame(get_turf(P), P.weapon_cause_data)

/datum/ammo/flamethrower/tank_flamer
	flamer_reagent_type = /datum/reagent/napalm/blue

	max_range = 8

/datum/ammo/flamethrower/sentry_flamer
	flags_ammo_behavior = AMMO_IGNORE_ARMOR|AMMO_IGNORE_COVER|AMMO_FLAME
	flamer_reagent_type = /datum/reagent/napalm/blue

	accuracy = HIT_ACCURACY_TIER_8
	accurate_range = 6
	max_range = 12
	shell_speed = AMMO_SPEED_TIER_3

/datum/ammo/flamethrower/sentry_flamer/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/flamethrower/sentry_flamer/glob
	max_range = 14
	accurate_range = 10
	var/datum/effect_system/smoke_spread/phosphorus/smoke

/datum/ammo/flamethrower/sentry_flamer/glob/New()
	. = ..()
	smoke = new()

/datum/ammo/flamethrower/sentry_flamer/glob/drop_flame(turf/T, datum/cause_data/cause_data)
	if(!istype(T))
		return
	smoke.set_up(1, 0, T, new_cause_data = cause_data)
	smoke.start()

/datum/ammo/flamethrower/sentry_flamer/glob/Destroy()
	qdel(smoke)
	return ..()

/datum/ammo/flamethrower/sentry_flamer/mini
	name = "normal fire"

/datum/ammo/flamethrower/sentry_flamer/mini/drop_flame(turf/T, datum/cause_data/cause_data)
	if(!istype(T))
		return
	var/datum/reagent/napalm/ut/R = new()
	R.durationfire = BURN_TIME_INSTANT
	new /obj/flamer_fire(T, cause_data, R, 0)

/datum/ammo/flare
	name = "flare"
	ping = null //no bounce off.
	damage_type = BURN
	flags_ammo_behavior = AMMO_HITS_TARGET_TURF
	icon_state = "flare"

	damage = 15
	accuracy = HIT_ACCURACY_TIER_3
	max_range = 14
	shell_speed = AMMO_SPEED_TIER_3

	var/flare_type = /obj/item/device/flashlight/flare/on/gun
	handful_type = /obj/item/device/flashlight/flare

/datum/ammo/flare/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/flare/on_hit_mob(mob/M,obj/projectile/P)
	drop_flare(get_turf(M), P, P.firer)

/datum/ammo/flare/on_hit_obj(obj/O,obj/projectile/P)
	drop_flare(get_turf(P), P, P.firer)

/datum/ammo/flare/on_hit_turf(turf/T, obj/projectile/P)
	if(T.density && isturf(P.loc))
		drop_flare(P.loc, P, P.firer)
	else
		drop_flare(T, P, P.firer)

/datum/ammo/flare/do_at_max_range(obj/projectile/P, mob/firer)
	drop_flare(get_turf(P), P, P.firer)

/datum/ammo/flare/proc/drop_flare(turf/T, obj/projectile/fired_projectile, mob/firer)
	var/obj/item/device/flashlight/flare/G = new flare_type(T)
	var/matrix/rotation = matrix()
	rotation.Turn(fired_projectile.angle - 90)
	G.apply_transform(rotation)
	G.visible_message(SPAN_WARNING("\A [G] bursts into brilliant light nearby!"))
	return G

/datum/ammo/flare/signal
	name = "signal flare"
	icon_state = "flare_signal"
	flare_type = /obj/item/device/flashlight/flare/signal/gun
	handful_type = /obj/item/device/flashlight/flare/signal

/datum/ammo/flare/signal/drop_flare(turf/T, obj/projectile/fired_projectile, mob/firer)
	var/obj/item/device/flashlight/flare/signal/gun/signal_flare = ..()
	signal_flare.activate_signal(firer)
	if(istype(fired_projectile.shot_from, /obj/item/weapon/gun/flare))
		var/obj/item/weapon/gun/flare/flare_gun_fired_from = fired_projectile.shot_from
		flare_gun_fired_from.last_signal_flare_name = signal_flare.name

/datum/ammo/flare/starshell
	name = "starshell ash"
	icon_state = "starshell_bullet"
	max_range = 5
	flare_type = /obj/item/device/flashlight/flare/on/starshell_ash

/datum/ammo/flare/starshell/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff, /datum/element/bullet_trait_incendiary)
	))

/datum/ammo/souto
	name = "Souto Can"
	ping = null //no bounce off.
	damage_type = BRUTE
	shrapnel_type = /obj/item/reagent_container/food/drinks/cans/souto/classic
	flags_ammo_behavior = AMMO_SKIPS_ALIENS|AMMO_IGNORE_ARMOR|AMMO_IGNORE_RESIST|AMMO_BALLISTIC|AMMO_STOPPED_BY_COVER|AMMO_SPECIAL_EMBED
	var/obj/item/reagent_container/food/drinks/cans/souto/can_type
	icon_state = "souto_classic"

	max_range = 12
	shrapnel_chance = 10
	accuracy = HIT_ACCURACY_TIER_8 + HIT_ACCURACY_TIER_8
	accurate_range = 12
	shell_speed = AMMO_SPEED_TIER_1

/datum/ammo/souto/on_embed(mob/embedded_mob, obj/limb/target_organ)
	if(ishuman(embedded_mob) && !isyautja(embedded_mob))
		if(istype(target_organ))
			target_organ.embed(new can_type)

/datum/ammo/souto/on_hit_mob(mob/M, obj/projectile/P)
	if(!M || M == P.firer) return
	if(M.throw_mode && !M.get_active_hand()) //empty active hand and we're in throw mode. If so we catch the can.
		if(!M.is_mob_incapacitated()) // People who are not able to catch cannot catch.
			if(P.contents.len == 1)
				for(var/obj/item/reagent_container/food/drinks/cans/souto/S in P.contents)
					M.put_in_active_hand(S)
					for(var/mob/O in viewers(world_view_size, P)) //find all people in view.
						O.show_message(SPAN_DANGER("[M] catches the [S]!"), SHOW_MESSAGE_VISIBLE) //Tell them the can was caught.
					return //Can was caught.
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.name == "Human") //no effect on synths or preds.
			H.apply_effect(6, STUN)
			H.apply_effect(8, WEAKEN)
			H.apply_effect(15, DAZE)
			H.apply_effect(15, SLOW)
		shake_camera(H, 2, 1)
		if(P.contents.len)
			drop_can(P.loc, P) //We make a can at the location.

/datum/ammo/souto/on_hit_obj(obj/O,obj/projectile/P)
	drop_can(P.loc, P) //We make a can at the location.

/datum/ammo/souto/on_hit_turf(turf/T, obj/projectile/P)
	drop_can(P.loc, P) //We make a can at the location.

/datum/ammo/souto/do_at_max_range(obj/projectile/P)
	drop_can(P.loc, P) //We make a can at the location.

/datum/ammo/souto/on_shield_block(mob/M, obj/projectile/P)
	drop_can(P.loc, P) //We make a can at the location.

/datum/ammo/souto/proc/drop_can(loc, obj/projectile/P)
	if(P.contents.len)
		for(var/obj/item/I in P.contents)
			I.forceMove(loc)
	randomize_projectile(P)

/datum/ammo/souto/proc/randomize_projectile(obj/projectile/P)
	shrapnel_type = pick(typesof(/obj/item/reagent_container/food/drinks/cans/souto)-/obj/item/reagent_container/food/drinks/cans/souto)

/datum/ammo/grenade_container
	name = "grenade shell"
	ping = null
	damage_type = BRUTE
	var/nade_type = /obj/item/explosive/grenade/high_explosive
	icon_state = "grenade"
	flags_ammo_behavior = AMMO_IGNORE_COVER|AMMO_SKIPS_ALIENS

	damage = 15
	accuracy = HIT_ACCURACY_TIER_3
	max_range = 6

/datum/ammo/grenade_container/on_hit_mob(mob/M,obj/projectile/P)
	drop_nade(P)

/datum/ammo/grenade_container/on_hit_obj(obj/O,obj/projectile/P)
	drop_nade(P)

/datum/ammo/grenade_container/on_hit_turf(turf/T,obj/projectile/P)
	drop_nade(P)

/datum/ammo/grenade_container/do_at_max_range(obj/projectile/P)
	drop_nade(P)

/datum/ammo/grenade_container/proc/drop_nade(obj/projectile/P)
	var/turf/T = get_turf(P)
	var/obj/item/explosive/grenade/G = new nade_type(T)
	G.visible_message(SPAN_WARNING("\A [G] lands on [T]!"))
	G.det_time = 10
	G.cause_data = P.weapon_cause_data
	G.activate()

/datum/ammo/grenade_container/rifle
	flags_ammo_behavior = NO_FLAGS

/datum/ammo/grenade_container/smoke
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb
	icon_state = "smoke_shell"

/datum/ammo/grenade_container/tank_glauncher
	max_range = 8

/datum/ammo/hugger_container
	name = "hugger shell"
	ping = null
	damage_type = BRUTE
	var/hugger_hive = XENO_HIVE_NORMAL
	icon_state = "smoke_shell"

	damage = 15
	accuracy = HIT_ACCURACY_TIER_3
	max_range = 6

/datum/ammo/hugger_container/on_hit_mob(mob/M,obj/projectile/P)
	spawn_hugger(get_turf(P))

/datum/ammo/hugger_container/on_hit_obj(obj/O,obj/projectile/P)
	spawn_hugger(get_turf(P))

/datum/ammo/hugger_container/on_hit_turf(turf/T,obj/projectile/P)
	spawn_hugger(get_turf(P))

/datum/ammo/hugger_container/do_at_max_range(obj/projectile/P)
	spawn_hugger(get_turf(P))

/datum/ammo/hugger_container/proc/spawn_hugger(turf/T)
	var/obj/item/clothing/mask/facehugger/child = new(T)
	child.hivenumber = hugger_hive
	INVOKE_ASYNC(child, TYPE_PROC_REF(/obj/item/clothing/mask/facehugger, leap_at_nearest_target))

/*
//========
					SHARP Dart Ammo
//========
*/
/datum/ammo/rifle/sharp
	name = "dart"
	ping = null //no bounce off.
	damage_type = BRUTE
	shrapnel_type = /obj/item/sharp
	flags_ammo_behavior = AMMO_SPECIAL_EMBED|AMMO_NO_DEFLECT|AMMO_STRIKES_SURFACE_ONLY|AMMO_HITS_TARGET_TURF
	icon_state = "sonicharpoon"
	var/embed_object = /obj/item/sharp/explosive

	shrapnel_chance = 100
	accuracy = HIT_ACCURACY_TIER_MAX
	accurate_range = 12
	max_range = 7
	damage = 35
	shell_speed = AMMO_SPEED_TIER_2

/datum/ammo/rifle/sharp/on_embed(mob/embedded_mob, obj/limb/target_organ)
	if(!ishuman(embedded_mob))
		return
	var/mob/living/carbon/human/humano = embedded_mob
	if(humano.species.flags & NO_SHRAPNEL)
		return
	if(istype(target_organ))
		target_organ.embed(new embed_object)

/datum/ammo/rifle/sharp/on_hit_obj(obj/O, obj/projectile/P)
	drop_dart(P.loc, P)

/datum/ammo/rifle/sharp/on_hit_turf(turf/T, obj/projectile/P)
	drop_dart(T, P)

/datum/ammo/rifle/sharp/do_at_max_range(obj/projectile/P)
	drop_dart(P.loc, P)

/datum/ammo/rifle/sharp/proc/drop_dart(loc, obj/projectile/P)
	new embed_object(loc, P.dir)

/datum/ammo/rifle/sharp/explosive
	name = "9X-E sticky explosive dart"

/datum/ammo/rifle/sharp/explosive/on_hit_mob(mob/living/M, obj/projectile/P)
	if(!M || M == P.firer) return
	var/mob/shooter = P.firer
	shake_camera(M, 2, 1)
	if(shooter && ismob(shooter))
		if(!M.get_target_lock(shooter.faction_group))
			var/obj/item/weapon/gun/rifle/sharp/weapon = P.shot_from
			if(weapon && weapon.explosion_delay_sharp)
				addtimer(CALLBACK(src, PROC_REF(delayed_explosion), P, M, shooter), 5 SECONDS)
			else
				addtimer(CALLBACK(src, PROC_REF(delayed_explosion), P, M, shooter), 1 SECONDS)

/datum/ammo/rifle/sharp/explosive/drop_dart(loc, obj/projectile/P, mob/shooter)
	var/signal_explosion = FALSE
	if(locate(/obj/item/explosive/mine) in get_turf(loc))
		signal_explosion = TRUE
	var/obj/item/explosive/mine/sharp/dart = new /obj/item/explosive/mine/sharp(loc)
	// if no darts on tile, don't arm, explode instead.
	if(signal_explosion)
		INVOKE_ASYNC(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, prime), shooter)
	else
		dart.anchored = TRUE
		addtimer(CALLBACK(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, deploy_mine), shooter), 3 SECONDS, TIMER_DELETE_ME)
		addtimer(CALLBACK(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, disarm)), 1 MINUTES, TIMER_DELETE_ME)

/datum/ammo/rifle/sharp/explosive/proc/delayed_explosion(obj/projectile/P, mob/M, mob/shooter)
	if(ismob(M))
		var/explosion_size = 100
		var/falloff_size = 50
		var/cause_data = create_cause_data("P9 SHARP Rifle", shooter)
		cell_explosion(get_turf(M), explosion_size, falloff_size, EXPLOSION_FALLOFF_SHAPE_LINEAR, P.dir, cause_data)
		M.ex_act(150, P.dir, P.weapon_cause_data, 100)
		M.apply_effect(2, WEAKEN)
		M.apply_effect(2, PARALYZE)
		playsound(get_turf(M), 'sound/weapons/gun_sharp_explode.ogg', 45)

/datum/ammo/rifle/sharp/track
	name = "9X-T sticky tracker dart"
	icon_state = "sonicharpoon_tracker"
	embed_object = /obj/item/sharp/track
	var/tracker_timer = 1 MINUTES

/datum/ammo/rifle/sharp/track/on_hit_mob(mob/living/M, obj/projectile/P)
	if(!M || M == P.firer) return
	shake_camera(M, 2, 1)
	var/obj/item/weapon/gun/rifle/sharp/weapon = P.shot_from
	if(weapon)
		weapon.sharp_tracked_mob_list |= M
	addtimer(CALLBACK(src, PROC_REF(remove_tracker), M, P), tracker_timer)

/datum/ammo/rifle/sharp/track/proc/remove_tracker(mob/living/M, obj/projectile/P)
	var/obj/item/weapon/gun/rifle/sharp/weapon = P.shot_from
	if(weapon)
		weapon.sharp_tracked_mob_list -= M

/datum/ammo/rifle/sharp/track/infinite
	tracker_timer = 999 MINUTES

/datum/ammo/rifle/sharp/flechette
	name = "9X-F flechette dart"
	icon_state = "sonicharpoon_flechette"
	embed_object = /obj/item/sharp/flechette
	shrapnel_type = /datum/ammo/bullet/shotgun/flechette_spread/awesome

/datum/ammo/rifle/sharp/flechette/on_hit_mob(mob/living/M, obj/projectile/P)
	if(!M || M == P.firer) return
	var/mob/shooter = P.firer
	shake_camera(M, 2, 1)
	if(shooter && ismob(shooter))
		if(!M.get_target_lock(shooter.faction_group))
			create_flechette(M.loc, P)

/datum/ammo/rifle/sharp/flechette/on_pointblank(mob/living/M, obj/projectile/P)
	if(!M) return
	P.dir = get_dir(P.firer, M)

/datum/ammo/rifle/sharp/flechette/on_hit_obj(obj/O, obj/projectile/P)
	create_flechette(O.loc, P)

/datum/ammo/rifle/sharp/flechette/on_hit_turf(turf/T, obj/projectile/P)
	create_flechette(T, P)

/datum/ammo/rifle/sharp/flechette/do_at_max_range(obj/projectile/P)
	create_flechette(P.loc, P)

/datum/ammo/rifle/sharp/flechette/proc/create_flechette(loc, obj/projectile/P)
	var/shrapnel_count = 15
	var/direct_hit_shrapnel = 8
	var/dispersion_angle = 20
	create_shrapnel(loc, min(direct_hit_shrapnel, shrapnel_count), P.dir, dispersion_angle, shrapnel_type, P.weapon_cause_data, FALSE, 100)
	shrapnel_count -= direct_hit_shrapnel
	if(shrapnel_count)
		create_shrapnel(loc, shrapnel_count, P.dir, dispersion_angle ,shrapnel_type, P.weapon_cause_data, FALSE, 0)
	apply_explosion_overlay(loc)

/datum/ammo/rifle/sharp/flechette/proc/apply_explosion_overlay(turf/loc)
	var/obj/effect/overlay/O = new /obj/effect/overlay(loc)
	O.name = "grenade"
	O.icon = 'icons/effects/explosion.dmi'
	flick("grenade", O)
	QDEL_IN(O, 7)
