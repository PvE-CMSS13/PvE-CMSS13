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
	flags_ammo_behavior = AMMO_IGNORE_ARMOR|AMMO_IGNORE_COVER|AMMO_FLAME|AMMO_HITS_TARGET_TURF
	flamer_reagent_id = "utnapthal"
	max_range = 8
	damage = 50
	shell_speed = AMMO_SPEED_TIER_4

/datum/ammo/flamethrower/tank_flamer/drop_flame(turf/turf, datum/cause_data/cause_data)
	if(!istype(turf))
		return

	var/datum/reagent/napalm/ut/reagent = new()
	new /obj/flamer_fire(turf, cause_data, reagent, 2)

	var/datum/effect_system/smoke_spread/landingsmoke = new /datum/effect_system/smoke_spread
	landingsmoke.set_up(1, 0, turf, null, 3, cause_data)
	landingsmoke.start()
	landingsmoke = null

	max_range = 8

/datum/ammo/flamethrower/sentry_flamer
	flags_ammo_behavior = AMMO_IGNORE_ARMOR|AMMO_IGNORE_COVER|AMMO_FLAME
	flamer_reagent_id = "napalmx"

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

/datum/ammo/flamethrower/pve/drop_flame(turf/T, datum/cause_data/cause_data)
	if(!istype(T))
		return
	var/datum/reagent/reagent = GLOB.chemical_reagents_list[flamer_reagent_id]
	new /obj/flamer_fire(T, cause_data, reagent, 1)

/datum/ammo/flamethrower/sentry_flamer/wy
	name = "sticky fire"
	flamer_reagent_id = "stickynapalm"
	shell_speed = AMMO_SPEED_TIER_4

/datum/ammo/flamethrower/sentry_flamer/upp
	name = "gel fire"
	flamer_reagent_id = "napalmgel"

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
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary, stacks = 2.5)
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
	damage = 2.5
	flare_type = /obj/item/device/flashlight/flare/on/starshell_ash

/datum/ammo/flare/starshell/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff),
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary, stacks = 1)
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

/datum/ammo/souto/on_embed(mob/embedded_mob, obj/limb/target_organ, silent = FALSE)
	if(ishuman(embedded_mob) && !isyautja(embedded_mob))
		if(istype(target_organ))
			target_organ.embed(new can_type)

/datum/ammo/souto/on_hit_mob(mob/M, obj/projectile/P)
	if(!M || M == P.firer) return
	if(M.throw_mode && !M.get_active_hand()) //empty active hand and we're in throw mode. If so we catch the can.
		if(!M.is_mob_incapacitated()) // People who are not able to catch cannot catch.
			if(length(P.contents) == 1)
				for(var/obj/item/reagent_container/food/drinks/cans/souto/S in P.contents)
					M.put_in_active_hand(S)
					for(var/mob/O in viewers(GLOB.world_view_size, P)) //find all people in view.
						O.show_message(SPAN_DANGER("[M] catches [S]!"), SHOW_MESSAGE_VISIBLE) //Tell them the can was caught.
					return //Can was caught.
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.species.name == "Human") //no effect on synths or preds.
			H.apply_effect(6, STUN)
			H.apply_effect(8, WEAKEN)
			H.apply_effect(15, DAZE)
			H.apply_effect(15, SLOW)
		shake_camera(H, 2, 1)
		if(length(P.contents))
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
	if(length(P.contents))
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
	max_range = 9

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
	G.det_time = 0.5 SECONDS
	G.cause_data = P.weapon_cause_data
	G.activate()

/datum/ammo/grenade_container/rifle
	flags_ammo_behavior = NO_FLAGS

/datum/ammo/grenade_container/smoke
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb
	icon_state = "smoke_shell"

/datum/ammo/grenade_container/smoke/upp
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb/upp
	icon_state = "smoke_shell"

/datum/ammo/grenade_container/incen
	name = "incendiary smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/phosphorus

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

/datum/ammo/xeno_container
	name = "xenomorph shell"
	ping = null
	damage_type = BRUTE
	var/xeno_hive = XENO_HIVE_NORMAL
	var/bug_type = /mob/living/carbon/xenomorph/drone
	icon_state = "hornet_round"

	damage = 15
	accuracy = HIT_ACCURACY_TIER_3
	max_range = 6

/datum/ammo/xeno_container/on_hit_mob(mob/M,obj/projectile/P)
	spawn_bug(get_turf(P))

/datum/ammo/xeno_container/on_hit_obj(obj/O,obj/projectile/P)
	spawn_bug(get_turf(P))

/datum/ammo/xeno_container/on_hit_turf(turf/T,obj/projectile/P)
	spawn_bug(get_turf(P))

/datum/ammo/xeno_container/do_at_max_range(obj/projectile/P)
	spawn_bug(get_turf(P))

/datum/ammo/xeno_container/proc/spawn_bug(turf/T)
	var/mob/living/carbon/xenomorph/xeno = new bug_type(T)
	xeno.hivenumber = xeno_hive

/datum/ammo/xeno_container/crusher
	name = "big xenomorph shell"
	xeno_hive = XENO_HIVE_NORMAL
	bug_type = /mob/living/carbon/xenomorph/crusher
	icon_state = "baton_slug"

/datum/ammo/xeno_container/king
	name = "huge xenomorph shell"
	xeno_hive = XENO_HIVE_NORMAL
	bug_type = /mob/living/carbon/xenomorph/king
	icon_state = "ltb"

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
	icon = 'icons/obj/items/weapons/1218_projectiles.dmi'
	icon_state = "sharp_explosive_dart"
	handful_state = "sharp_explosive"
	var/embed_object = /obj/item/sharp/explosive
	var/mine_mode = SHARP_DANGER_MODE
	var/holo_stacks = 100
	var/bonus_damage_cap_increase = 0
	var/stack_loss_multiplier = 20

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

/datum/ammo/rifle/sharp/explosive/on_hit_mob(mob/living/target, obj/projectile/shot_dart)
	if(!target || target == shot_dart.firer) return
	var/mob/shooter = shot_dart.firer
	var/obj/item/weapon/gun/rifle/sharp/weapon = shot_dart.shot_from
	shake_camera(target, 2, 1)
	if(shooter && ismob(shooter))
		target.balloon_alert(target, "you have been hit by an explosive dart!", text_color = "#ce1e1e")
		if(!target.get_target_lock(shooter.faction_group))
			if(weapon)
				mine_mode = weapon.current_mine_mode
				addtimer(CALLBACK(src, PROC_REF(delayed_explosion), shot_dart, target, shooter), 2.5 SECONDS)
				target.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)

/datum/ammo/rifle/sharp/explosive/drop_dart(loc, obj/projectile/shot_dart, mob/shooter)
	var/signal_explosion = FALSE
	if(locate(/obj/item/explosive/mine) in get_turf(loc))
		signal_explosion = TRUE
	var/obj/item/explosive/mine/sharp/dart = new /obj/item/explosive/mine/sharp(loc)
	var/obj/item/weapon/gun/rifle/sharp/weapon = shot_dart.shot_from
	if(weapon)
		dart.set_mine_mode(weapon.current_mine_mode)
	// if no darts on tile, don't arm, explode instead.
	if(signal_explosion)
		INVOKE_ASYNC(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, prime), shooter)
	else
		dart.anchored = TRUE
		addtimer(CALLBACK(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, deploy_mine), shooter, weapon), 3 SECONDS, TIMER_DELETE_ME)
		addtimer(CALLBACK(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, disarm)), 10 MINUTES, TIMER_DELETE_ME)

/datum/ammo/rifle/sharp/explosive/proc/delayed_explosion(obj/projectile/shot_dart, mob/target, mob/shooter)
	if(ismob(target))
		var/explosion_strength = 100
		var/explosion_falloff = 50
		var/cause_data = create_cause_data("P9 SHARP Rifle", shooter)

		switch(mine_mode)
			if(SHARP_DIRECTED_MODE)
				explosion_strength = 150
				explosion_falloff = explosion_strength
			if(SHARP_SAFE_MODE)
				for(var/mob/living/carbon/human in range((explosion_strength / explosion_falloff) - 1, target))
					if (human.get_target_lock(shooter.faction_group))
						playsound(target, 'sound/weapons/smartgun_fail.ogg', target, 25)
						to_chat(target, SPAN_WARNING("[shot_dart] releases itself from you!"))
						target.balloon_alert(target, "an attached explosive dart releases itself from you!")
						to_chat(shooter, SPAN_WARNING("[shot_dart] recognized an IFF marked target and did not detonate!"))
						return
		cell_explosion(get_turf(target), explosion_strength, explosion_falloff, EXPLOSION_FALLOFF_SHAPE_LINEAR, CARDINAL_ALL_DIRS, cause_data)
		target.ex_act(150, shot_dart.dir, shot_dart.weapon_cause_data, 100)
		target.apply_effect(2, WEAKEN)
		target.apply_effect(2, PARALYZE)
		playsound(get_turf(target), 'sound/weapons/gun_sharp_explode.ogg', 45)

/datum/ammo/rifle/sharp/incendiary
	name = "9X-I sticky incendiary dart"
	icon_state = "sharp_incendiary_dart"
	handful_state = "sharp_incendiary"
	embed_object = /obj/item/sharp/incendiary

/datum/ammo/rifle/sharp/incendiary/on_hit_mob(mob/living/target, obj/projectile/shot_dart)
	if(!target || target == shot_dart.firer)
		return
	var/mob/shooter = shot_dart.firer
	var/obj/item/weapon/gun/rifle/sharp/weapon = shot_dart.shot_from
	shake_camera(target, 2, 1)
	if(shooter && ismob(shooter))
		target.balloon_alert(target, "you have been hit by an incendiary dart!", text_color = "#ce7c1e")
		if(!target.get_target_lock(shooter.faction_group))
			playsound(get_turf(target), 'sound/weapons/gun_sharp_explode.ogg', 100)
			if(weapon)
				mine_mode = weapon.current_mine_mode
				addtimer(CALLBACK(src, PROC_REF(delayed_fire), shot_dart, target, shooter), 2.5 SECONDS)
				target.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)

/datum/ammo/rifle/sharp/incendiary/drop_dart(loc, obj/projectile/shot_dart, mob/shooter)
	var/signal_explosion = FALSE
	if(locate(/obj/item/explosive/mine) in get_turf(loc))
		signal_explosion = TRUE
	var/obj/item/explosive/mine/sharp/incendiary/dart = new /obj/item/explosive/mine/sharp/incendiary(loc)
	var/obj/item/weapon/gun/rifle/sharp/weapon = shot_dart.shot_from
	if(weapon)
		dart.set_mine_mode(weapon.current_mine_mode)
	// if no darts on tile, don't arm, explode instead.
	if(signal_explosion)
		INVOKE_ASYNC(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp/incendiary, prime), shooter)
	else
		dart.anchored = TRUE
		addtimer(CALLBACK(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, deploy_mine), shooter), 3 SECONDS, TIMER_DELETE_ME)
		addtimer(CALLBACK(dart, TYPE_PROC_REF(/obj/item/explosive/mine/sharp, disarm)), 10 MINUTES, TIMER_DELETE_ME)

/datum/ammo/rifle/sharp/incendiary/proc/delayed_fire(obj/projectile/shot_dart, mob/target, mob/shooter)
	if(ismob(target))
		var/datum/effect_system/smoke_spread/phosphorus/weak/smoke = new /datum/effect_system/smoke_spread/phosphorus/weak
		var/smoke_radius = 1
		var/datum/reagent/incendiary_reagent = new /datum/reagent/napalm/green
		var/flame_radius = 2
		switch(mine_mode)
			if(SHARP_DIRECTED_MODE)
				incendiary_reagent = new /datum/reagent/napalm/blue
				flame_radius = 1
				new /obj/flamer_fire(get_turf(target), WEAKREF(shooter), incendiary_reagent, flame_radius)
				playsound(get_turf(target), 'sound/weapons/gun_flamethrower3.ogg', 45)
				return
			if(SHARP_SAFE_MODE)
				for(var/mob/living/carbon/human in range(smoke_radius, target))
					if (human.get_target_lock(shooter.faction_group))
						playsound(target, 'sound/weapons/smartgun_fail.ogg', target, 25)
						to_chat(target, SPAN_WARNING("[shot_dart] releases itself from you!"))
						target.balloon_alert(target, "an attached incendiary dart releases itself from you!")
						to_chat(shooter, SPAN_WARNING("[shot_dart] recognized an IFF marked target and did not detonate!"))
						return
		new /obj/flamer_fire(get_turf(target), WEAKREF(shooter), incendiary_reagent, flame_radius)
		smoke.set_up(smoke_radius, 0, get_turf(target))
		smoke.start()
		playsound(get_turf(target), 'sound/weapons/gun_flamethrower3.ogg', 45)

/datum/ammo/rifle/sharp/track
	name = "9X-T sticky tracker dart"
	icon_state = "sonicharpoon_tracker"
	handful_state = "sharp_tracker"
	embed_object = /obj/item/sharp/track
	var/tracker_timer = 5 MINUTES

/datum/ammo/rifle/sharp/track/on_hit_mob(mob/living/target, obj/projectile/shot_dart)
	if(!target || target == shot_dart.firer) return
	shake_camera(target, 2, 1)
	var/obj/item/weapon/gun/rifle/sharp/weapon = shot_dart.shot_from
	if(weapon)
		weapon.sharp_tracked_mob_list |= target
	addtimer(CALLBACK(src, PROC_REF(remove_tracker), target, shot_dart), tracker_timer)
	target.AddComponent(/datum/component/bonus_damage_stack, holo_stacks, world.time, bonus_damage_cap_increase, stack_loss_multiplier)

/datum/ammo/rifle/sharp/track/proc/remove_tracker(mob/living/target, obj/projectile/shot_dart)
	var/obj/item/weapon/gun/rifle/sharp/weapon = shot_dart.shot_from
	if(weapon)
		weapon.sharp_tracked_mob_list -= target

/datum/ammo/rifle/sharp/track/infinite
	tracker_timer = 999 MINUTES

/datum/ammo/rifle/sharp/flechette
	name = "9X-F flechette dart"
	icon_state = "sharp_flechette_dart"
	handful_state = "sharp_flechette"
	flags_ammo_behavior = AMMO_SPECIAL_EMBED|AMMO_NO_DEFLECT|AMMO_STRIKES_SURFACE_ONLY|AMMO_HITS_TARGET_TURF|AMMO_PRONETARGET
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
	var/shrapnel_count = 12
	var/dispersion_angle = 30
	create_shrapnel(loc, shrapnel_count, P.dir, dispersion_angle, shrapnel_type, P.weapon_cause_data, FALSE, 100)
	apply_explosion_overlay(loc)

/datum/ammo/rifle/sharp/flechette/proc/apply_explosion_overlay(turf/loc)
	var/obj/effect/overlay/O = new /obj/effect/overlay(loc)
	O.name = "grenade"
	O.icon = 'icons/effects/explosion.dmi'
	flick("grenade", O)
	QDEL_IN(O, 7)

/datum/ammo/anti_air
	name = "anti-air missile"
	ping = null //no bounce off.
	damage_type = CLONE //Shouldn't ever hit anyone
	flags_ammo_behavior = AMMO_MP //As above, ensures it'll miss if it ever travels any distance
	icon_state = "flare"
	damage = 0
	max_range = 1
	shell_speed = AMMO_SPEED_TIER_HITSCAN

/datum/ammo/anti_air/on_hit_mob(mob/mob, obj/projectile/projectile)
	return

/datum/ammo/anti_air/on_hit_obj(obj/object, obj/projectile/projectile)
	return

/datum/ammo/anti_air/on_hit_turf(turf/turf, obj/projectile/projectile)
	return

/datum/ammo/anti_air/do_at_max_range(obj/projectile/projectile)
	return
