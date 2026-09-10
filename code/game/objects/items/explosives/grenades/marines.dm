
/*
//================================================
				Blast Grenades
//================================================
*/

#define GRENADE_FIRE_RESISTANCE_MIN 10
#define GRENADE_FIRE_RESISTANCE_MAX 40

/obj/item/explosive/grenade/high_explosive
	name = "\improper M40 HEDP grenade"
	desc = "High-Explosive Dual-Purpose. A small, but deceptively strong grenade that has been phasing out the M15 HE grenade. Explodes with a powerful blast, releasing shrapnel in a casualty radius of five meters. Can be fired from a PN 30mm UGL for impact detonation, or primed in-hand and thrown to detonate after 4 seconds."
	icon_state = "grenade"
	det_time = 40
	item_state = "grenade_hedp"
	caliber = "30mm"
	dangerous = TRUE
	underslug_launchable = TRUE
	dual_purpose = TRUE
	arm_sound = 'sound/weapons/grenade.ogg'
	var/explosion_power = 100
	var/explosion_falloff = 30
	var/shrapnel_count = 32
	var/shrapnel_type = /datum/ammo/bullet/shrapnel
	var/fire_resistance = 15 //to prevent highly controlled massive explosions
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL_HALF

/obj/item/explosive/grenade/high_explosive/New()
	..()

	fire_resistance = rand(GRENADE_FIRE_RESISTANCE_MIN, GRENADE_FIRE_RESISTANCE_MAX)

/obj/item/explosive/grenade/high_explosive/prime(mob/living/user)
	set waitfor = 0
	if(fuse_type == IMPACT_FUSE)
		to_chat(user, SPAN_WARNING("This grenade is set for impact-fusing!"))
		return
	if(shrapnel_count)
		create_shrapnel(loc, shrapnel_count, , ,shrapnel_type, cause_data)
	apply_explosion_overlay()
	cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, null, cause_data)
	qdel(src)

/obj/item/explosive/grenade/high_explosive/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		if(shrapnel_count)
			create_shrapnel(loc, shrapnel_count, , ,shrapnel_type, cause_data)
			sleep(2) //so that mobs are not knocked down before being hit by shrapnel. shrapnel might also be getting deleted by explosions?
		apply_explosion_overlay()
		cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, null, cause_data)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/proc/apply_explosion_overlay()
	var/obj/effect/overlay/O = new /obj/effect/overlay(loc)
	O.name = "grenade"
	O.icon = 'icons/effects/explosion.dmi'
	flick("grenade", O)
	QDEL_IN(O, 7)

/obj/item/explosive/grenade/high_explosive/flamer_fire_act(damage, flame_cause_data)
	fire_resistance--
	if(fire_resistance<=0)
		cause_data = flame_cause_data
		prime()

/obj/item/explosive/grenade/high_explosive/super
	name = "\improper M40/2 HEDP grenade"
	desc = "High-Explosive Dual-Purpose. A small, but deceptively strong grenade that has been phasing out the M15 HE grenade. This version is stronger."
	icon_state = "m40_2"
	item_state = "grenade_hedp2"
	explosion_power = 150
	explosion_falloff = 50

/obj/item/explosive/grenade/high_explosive/pmc
	name = "\improper M12 blast grenade"
	desc = "A high-explosive grenade produced for private security firms. It explodes around 3 seconds after the pin has been pulled."
	icon_state = "grenade_pmc"
	item_state = "grenade_ex"
	caliber = "non-standard"
	underslug_launchable = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	explosion_power = 200
	shrapnel_count = 0
	dual_purpose = FALSE
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL_HALF

/obj/item/explosive/grenade/high_explosive/stick
	name = "\improper Webley Mk15 stick grenade"
	desc = "A blast grenade produced in the colonies, most commonly using old designs and schematics. It explodes 3 seconds after the pin has been pulled."
	icon_state = "grenade_stick"
	item_state = "grenade_stick"
	caliber = "non-standard"
	force = 10
	w_class = SIZE_SMALL
	throwforce = 15
	throw_speed = SPEED_FAST
	throw_range = 7
	underslug_launchable = FALSE
	explosion_power = 100
	shrapnel_count = 0
	dual_purpose = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/upp
	name = "\improper Type 6 grenade"
	desc = "The standard issue fragmentation grenade of the UPP military. It explodes 3 seconds after the pin has been pulled."
	icon_state = "grenade_upp"
	item_state = "grenade_upp"
	caliber = "non-standard"
	throw_speed = SPEED_FAST
	throw_range = 6
	underslug_launchable = FALSE
	explosion_power = 100
	shrapnel_count = 48
	dual_purpose = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/*
//================================================
				Fragmentation Grenades
//================================================
*/
/obj/item/explosive/grenade/high_explosive/frag
	name = "\improper M40 HEFA grenade"
	desc = "High-Explosive Fragmenting-Antipersonnel. A small, but deceptively strong fragmentation grenade that has been phasing out the M15 fragmentation grenades alongside the M40 HEDP. Capable of being loaded in the M92 Launcher, or thrown by hand."
	icon_state = "grenade_hefa"
	item_state = "grenade_hefa"
	explosion_power = 40
	shrapnel_count = 48
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/frag/toy
	AUTOWIKI_SKIP(TRUE)

	name = "toy HEFA grenade"
	desc = "High-Explosive Fragmenting-Antipersonnel. A small, but deceptively strong fragmentation grenade that has been phasing out the M15 fragmentation grenades alongside the M40 HEDP. Capable of being loaded in the M92 Launcher, or thrown by hand. Wait, the labeling on the side indicates this is a toy, what the hell?"
	explosion_power = 0
	shrapnel_type = /datum/ammo/bullet/shrapnel/rubber
	antigrief_protection = FALSE
	dual_purpose = FALSE

/obj/item/explosive/grenade/high_explosive/m15
	name = "\improper M15 fragmentation grenade"
	desc = "An outdated USCM Fragmentation Grenade. With decades of service in the USCM, the old M15 Fragmentation Grenade is slowly being replaced by the slightly safer M40-series grenades. It is set to detonate in 4 seconds."
	icon_state = "grenade_ex"
	item_state = "grenade_ex"
	caliber = "non-standard"
	throw_speed = SPEED_FAST
	dual_purpose = FALSE
	throw_range = 6
	underslug_launchable = FALSE
	explosion_power = 200
	shrapnel_count = 48
	arm_sound = 'sound/weapons/pinpull.ogg'
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/*
+//================================================
+				Canister Grenade
+//================================================
+*/

/obj/item/explosive/grenade/high_explosive/airburst/canister
	name = "\improper M108 canister grenade"
	desc = "30mm canister grenade, effectively low velocity buckshot. Substantial close combat impact when paired with the 5 round PN pump action grenade launcher. No, you can't set it off with a hammer, moron. Not a hand-grenade, as marked by the yellow color-band on its hull, launcher-fired only."
	icon_state = "grenade_buck"
	item_state = "grenade_buck"
	hand_throwable = FALSE
	underslug_launchable = TRUE
	dual_purpose = FALSE
	caliber = "30mm"
	explosion_power = 0
	explosion_falloff = 25
	det_time = 0 //this should mean that it will explode instantly when fired and thus generate the shotshell effect.
	shrapnel_count = 18
	shrapnel_type = /datum/ammo/bullet/shrapnel/canister
	dispersion_angle = 15 //hopefully this means the cone spread is pretty small

/obj/item/explosive/grenade/high_explosive/airburst/canister/proc/canister_fire(mob/living/user, target)
	var/direction = Get_Compass_Dir(user, target)
	var/position = get_step(user, direction) //otherwise we buckshot ourselves
	create_shrapnel(position, min(direct_hit_shrapnel, shrapnel_count), direction , dispersion_angle, shrapnel_type, cause_data, FALSE, 100)
	if(shrapnel_count)
		create_shrapnel(loc, shrapnel_count, direction, dispersion_angle, shrapnel_type, cause_data, FALSE, 0)
	qdel(src)
// canister has no impact explosion.
/obj/item/explosive/grenade/high_explosive/airburst/canister/launch_impact(atom/hit_atom)
	return

/*
//================================================
				Airburst Grenades
//================================================
*/
// M74 are the launcher-only variant. Flag with hand_throwable = FALSE.
/obj/item/explosive/grenade/high_explosive/airburst
	name = "\improper M74 AGM-F 40mm Grenade"
	desc = "M74 - Airburst Grenade Munition - Fragmentation. This grenade must be launched with a grenade launcher, and detonates once it reaches its destination. It disperses jagged shrapnel in a cone in front of itself, tearing through sinews and armor alike. Dispersion pattern is optimized against large target. Suffers from overpenetration on a direct hit."
	icon_state = "grenade_m74_airburst_f"
	item_state = "grenade_m74_airburst_f_active"
	caliber = "40x53mm"
	explosion_power = 0
	explosion_falloff = 25
	shrapnel_count = 16
	det_time = 0 // Unused, because we don't use prime.
	hand_throwable = FALSE
	dual_purpose = FALSE
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR
	shrapnel_type = /datum/ammo/bullet/shrapnel/jagged
	var/direct_hit_shrapnel = 5
	var/dispersion_angle = 40

/obj/item/explosive/grenade/high_explosive/airburst/prime()
// We don't prime, we use launch_impact.

/obj/item/explosive/grenade/high_explosive/airburst/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		if(ismob(hit_atom))
			var/mob/M = hit_atom
			create_shrapnel(loc, min(direct_hit_shrapnel, shrapnel_count), last_move_dir , dispersion_angle ,shrapnel_type, cause_data, FALSE, 100)
			M.apply_effect(3.0, SUPERSLOW)
			shrapnel_count -= direct_hit_shrapnel
		if(shrapnel_count)
			create_shrapnel(loc, shrapnel_count, last_move_dir , dispersion_angle ,shrapnel_type, cause_data, FALSE, 0)
			sleep(2) //so that mobs are not knocked down before being hit by shrapnel. shrapnel might also be getting deleted by explosions?
		apply_explosion_overlay()
		if(explosion_power)
			cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, last_move_dir, cause_data)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/airburst/hornet_shell
	name = "\improper M74 AGM-H 40mm Hornet Shell"
	desc = "Functions identically to the standard AGM-F 40mm grenade, except instead of exploding into shrapnel, the hornet shell shoots off holo-targeting .22lr rounds. The equivalent to buckshot at-range."
	icon_state = "grenade_hornet"
	item_state = "grenade_hornet_active"
	dual_purpose = FALSE
	shrapnel_count = 5
	shrapnel_type = /datum/ammo/bullet/shrapnel/hornet_rounds
	direct_hit_shrapnel = 5
	dispersion_angle = 15//tight cone

/obj/item/explosive/grenade/high_explosive/airburst/starshell
	name = "\improper M74 AGM-S Star Shell"
	desc = "Functions identically to the standard AGM-F 40mm grenade, except instead of exploding into shrapnel, the star shells bursts into burning phosphor that illuminates the area."
	icon_state = "grenade_starshell"
	item_state = "grenade_starshell_active"
	dual_purpose = FALSE
	shrapnel_count = 8
	shrapnel_type = /datum/ammo/flare/starshell
	direct_hit_shrapnel = 5
	dispersion_angle = 360 //beeg circle

/*
//================================================
				M203 Grenades
//================================================
*/

/obj/item/explosive/grenade/incendiary/impact
	name = "\improper 40mm incendiary grenade"
	desc = "This is a 40mm grenade, designed to be launched by a grenade launcher and detonate on impact. This one is marked as a incendiary grenade, watch your fire."
	icon_state = "grenade_40mm_inc"
	det_time = 0
	item_state = "grenade_fire"
	caliber = "40x53mm"
	hand_throwable = FALSE
	dangerous = TRUE
	underslug_launchable = TRUE
	flame_level = BURN_TIME_TIER_2
	burn_level = BURN_LEVEL_TIER_3
	flameshape = FLAMESHAPE_DEFAULT
	radius = 2
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/explosive/grenade/incendiary/impact/prime()
	return

/obj/item/explosive/grenade/incendiary/impact/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	var/turf/hit_turf = null
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom))
		hit_turf = hit_atom
		if(hit_turf.density && !rebounding)
			detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		var/angle = dir2angle(last_move_dir)
		var/turf/target = locate(x + sin(angle)*radius, y + cos(angle)*radius, z)
		if(target)
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, target)
		else
			//Not stellar, but if we can't find a direction, fall back to HIDP behaviour.
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, target)
		playsound(src, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/impact //omega hell killer grenade of doom from hell
	name = "\improper 40mm HE grenade"
	desc = "This is a 40mm grenade, designed to be launched by a grenade launcher and detonate on impact. This one is marked as a High-Explosive Dual-Purpose grenade, watch your fire."
	icon_state = "grenade_40mm_hedp"
	item_state = "grenade_hedp"
	caliber = "40x53mm"
	det_time = 0
	hand_throwable = FALSE
	dangerous = TRUE
	underslug_launchable = TRUE
	explosion_power = 100 //hedp
	shrapnel_count = 0
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/impact/prime()
// We don't prime, we use launch_impact.

/obj/item/explosive/grenade/high_explosive/impact/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		if(explosion_power)
			cell_explosion(loc, explosion_power, explosion_falloff, falloff_mode, last_move_dir, cause_data)
		if(shrapnel_count)
			create_shrapnel(loc, shrapnel_count, , ,shrapnel_type, cause_data)
		qdel(src)

/obj/item/explosive/grenade/high_explosive/impact/frag
	name = "\improper 40mm frag grenade"
	desc = "This is a 40mm grenade, designed to be launched by a grenade launcher and detonate on impact. This one is marked as a High-Explosive Fragmenting-Antipersonnel grenade, watch your fire."
	icon_state = "grenade_40mm_he"
	item_state = "grenade_hefa"
	explosion_power = 75
	shrapnel_count = 32
	shrapnel_type = /datum/ammo/bullet/shrapnel/heavy
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/impact/upp
	name = "\improper VOG-73 HE grenade"
	desc = "This is a caseless 40mm grenade, designed to be launched by a grenade launcher and detonate on impact with an injury radius of 3 metres. This one bears markings of the UPP."
	icon_state = "grenade_40mm_upp"
	item_state = "grenade_hedp"
	caliber = "40x103mm"
	dangerous = FALSE
	explosion_power = 180 //Stronger than HEDP to make up for one shot in the tube
	explosion_falloff = 40 //But quicker to lose blast damage
	shrapnel_count = 16
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL_HALF

/obj/item/explosive/grenade/high_explosive/impact/upp/ap
	name = "\improper VPG-77 AP grenade"
	desc = "This is a caseless armor-piercing 40mm grenade, designed to be launched by a grenade launcher and used against armored targets. This one bears markings of the UPP. Beware of what's in front of you when firing."
	icon_state = "grenade_40mm_upp_ap"
	item_state = "grenade_hedp"
	explosion_power = 300 //Stronger than a HEAP grenade, to make up for one shot in the tube
	explosion_falloff = 900 //But no blast to speak of
	shrapnel_count = 0
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_EXPONENTIAL

/obj/item/explosive/grenade/high_explosive/airburst/upp
	name = "\improper VShG-80 Assault-Grenade"
	desc = "This is a caseless 40mm airbursting cannister round, designed for use in urban environments and close quarters combat, favoured by assault troops and sappers. Fires low velocity buckshot on impact in a wide cone."
	icon_state = "grenade_40mm_buckshot"
	item_state = "grenade_hornet_active"
	caliber = "40x103mm"
	explosion_power = 0
	explosion_falloff = 25
	shrapnel_count = 33
	shrapnel_type = /datum/ammo/bullet/shrapnel/canister
	direct_hit_shrapnel = 33
	dispersion_angle = 25//a little big and forgiving

/obj/item/explosive/grenade/incendiary/impact/upp
	name = "\improper VTBG-44 Thermobaric Grenade"
	desc = "This is a caseless incendiary 40mm grenade, developed for use in dense foliage or against hardened positions. Has an explosive punch."
	caliber = "40x103mm"
	flame_level = BURN_TIME_TIER_5
	burn_level = BURN_LEVEL_TIER_4

/obj/item/explosive/grenade/incendiary/impact/upp/launch_impact(atom/hit_atom)
	..()
	cell_explosion(get_turf(hit_atom), 80, 40, EXPLOSION_FALLOFF_SHAPE_LINEAR, cause_data)

/obj/item/explosive/grenade/high_explosive/airburst/buckshot
	name = "\improper 40mm Buckshot Shell"
	desc = "A classic of grenade launchers everywhere, this is a 40mm shell loaded with buckshot; very dangerous, watch your fire."
	icon_state = "grenade_40mm_buckshot"
	item_state = "grenade_hornet_active"
	shrapnel_count = 10
	shrapnel_type = /datum/ammo/bullet/shotgun/spread
	direct_hit_shrapnel = 5
	dispersion_angle = 35//big

/*
//================================================
				Impact HEAP Grenade
//================================================
*/

/obj/item/explosive/grenade/high_explosive/impact/heap
	name = "\improper M38 HEAP blast grenade"
	desc = "High-Explosive, Armour Piercing. A small, but deceptively strong blast grenade that can penetrate appreciable quantities of armor, whilst retaining a similar casualty radius as the standard M40. Not a hand-grenade, as marked by the yellow color-band on its hull, launcher-fired only. Due to faulty primers, it is inadvisable to fire them directly at hard surfaces like walls, landing them just in front is recommended."
	icon_state = "grenade_heap"
	item_state = "grenade_chem"
	caliber = "30mm"
	explosion_power = 250
	explosion_falloff = 200
	shrapnel_count = 0
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/*
+//================================================
+				Bounding Fragmentation Grenade
+//================================================
+*/

/obj/item/explosive/grenade/high_explosive/impact/tmfrag
	name = "\improper M51A BFAB grenade"
	desc = "Bounding Fragmentation, Air-Burst. Rather than traditionally detonating on impact, this round propels itself up into the air prior to exploding into a lethal hail of shrapnel a second later. Effective against troops in the open or in foxholes. Not a hand-grenade, as marked by the yellow color-band on its hull, launcher-fired only."
	icon_state = "grenade_bfab"
	item_state = "grenade_bfab"
	caliber = "30mm"
	explosion_power = 40
	shrapnel_count = 48
	shrapnel_type = /datum/ammo/bullet/shrapnel/heavy
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/high_explosive/impact/tmfrag/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		sleep(2)
		qdel(src)
		for(var/mob/mob in range(5, hit_atom))
			mob.show_message(SPAN_USERDANGER("The grenade flies up into the air before exploding!"), SHOW_MESSAGE_VISIBLE)
		sleep(5)	//simulating it bounding up into the air before detonating
		if(shrapnel_count)
			create_shrapnel(hit_atom, shrapnel_count, , ,shrapnel_type, cause_data)
			sleep(2) //so that mobs are not knocked down before being hit by shrapnel. shrapnel might also be getting deleted by explosions?
		apply_explosion_overlay()
		if(explosion_power)
			cell_explosion(hit_atom, explosion_power, explosion_falloff, falloff_mode, null, cause_data)

/*
//================================================
				Airborne Starshell Grenade
//================================================
*/

/obj/item/explosive/grenade/high_explosive/impact/flare
	name = "\improper M72A2 HIPF starshell grenade"
	desc = "High-Illumination, Parachute-Flare. Fired into the air, the M72A2 releases a parachute and ignites, illuminating the surrounding area for several minutes. Longer lasting than the A1 models, is is unfortunately not as bright. Can also be fired into ceilings where it will partially embed and serve as an overhead light source until it burns out."
	icon_state = "grenade_hipf"
	item_state = "grenade_hipf"
	caliber = "30mm"
	dangerous = TRUE	//kept so marines don't punt flare grenades up aboard the Garrow
	explosion_power = 0
	shrapnel_count = 0

/obj/item/explosive/grenade/high_explosive/impact/flare/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		qdel(src)
		sleep(5)	//simulating it arcing up out of view before igniting
		for(var/mob/mob in range(10, hit_atom))
			mob.show_message(SPAN_HIGHDANGER("A flare bursts into bright light overhead!"), SHOW_MESSAGE_VISIBLE)
		new /obj/item/device/flashlight/flare/on/illumination(hit_atom)
		playsound(hit_atom, 'sound/weapons/gun_flare.ogg', 50, 1, 4)

/*
//================================================
				Incendiary Grenades
//================================================
*/

/obj/item/explosive/grenade/incendiary
	name = "\improper M77 HIAM incendiary grenade"
	desc = "High-explosive-Incendiary, Anti-Mobility. The M77 is a small, but deceptively strong incendiary grenade designed to disrupt enemy mobility with long-lasting Type B napalm spread by a small explosive charge within the casing. It is set to detonate in 4 seconds."
	icon_state = "grenade_fire"
	det_time = 40
	item_state = "grenade_fire"
	caliber = "30mm"
	arm_sound = 'sound/weapons/grenade.ogg'
	dangerous = TRUE
	underslug_launchable = TRUE
	dual_purpose = TRUE
	var/flame_level = BURN_TIME_TIER_5 + 5 //Type B standard, 50 base + 5 from chemfire code.
	var/burn_level = BURN_LEVEL_TIER_2
	var/flameshape = FLAMESHAPE_DEFAULT
	var/radius = 2
	var/fire_type = FIRE_VARIANT_TYPE_B //Armor Shredding Greenfire

/obj/item/explosive/grenade/incendiary/prime(mob/living/user)
	set waitfor = 0
	if(fuse_type == IMPACT_FUSE)
		to_chat(user, SPAN_WARNING("This grenade is set for impact-fusing!"))
		return
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, null, fire_type)
	playsound(src.loc, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
	qdel(src)

/obj/item/explosive/grenade/incendiary/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, null, fire_type)
		playsound(src.loc, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
		qdel(src)

/proc/flame_radius(datum/cause_data/cause_data, radius = 1, turf/T, flame_level = 20, burn_level = 30, flameshape = FLAMESHAPE_DEFAULT, target, fire_type = FIRE_VARIANT_DEFAULT)
	//This proc is used to generate automatically-colored fires from manually adjusted item variables.
	//It parses them as parameters and sets color automatically based on Intensity, then sends an edited reagent to the standard flame code.
	//By default, this generates a napalm fire with a radius of 1, flame_level of 20 per UT (prev 14 as greenfire), burn_level of 30 per UT (prev 15 as greenfire), in a diamond shape.
	if(!istype(T))
		return
	var/datum/reagent/R = new /datum/reagent/napalm/ut()
	if(burn_level >= BURN_LEVEL_TIER_7)
		R = new /datum/reagent/napalm/blue()
	else if(burn_level <= BURN_LEVEL_TIER_2)
		R = new /datum/reagent/napalm/green()

	R.durationfire = flame_level
	R.intensityfire = burn_level
	R.rangefire = radius

	new /obj/flamer_fire(T, cause_data, R, R.rangefire, null, flameshape, target, , , fire_type)

/obj/item/explosive/grenade/incendiary/molotov
	name = "\improper improvised firebomb"
	desc = "A potent, improvised firebomb, coupled with a pinch of gunpowder. Cheap, very effective, and deadly in confined spaces. Commonly found in the hands of rebels and terrorists. It can be difficult to predict how many seconds you have before it goes off, so be careful. Chances are, it might explode in your face."
	icon_state = "molotov"
	item_state = "molotov"
	caliber = "non-standard"
	arm_sound = 'sound/items/Welder2.ogg'
	underslug_launchable = FALSE
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/explosive/grenade/incendiary/molotov/New(loc, custom_burn_level)
	det_time = rand(10,40) //Adds some risk to using this thing.
	if(custom_burn_level)
		burn_level = custom_burn_level
	..(loc)

/obj/item/explosive/grenade/incendiary/molotov/prime()
	playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 35, 1, 4)
	..()

/*
//================================================
				Airburst Incendiary Grenades
//================================================
*/
// M74 are the launcher-only variant. Flag with hand_throwable = FALSE.
/obj/item/explosive/grenade/incendiary/airburst
	name = "\improper M74 AGM-I 40mm Grenade"
	desc = "M74 - Airburst Grenade Munition - Incendiary. This grenade must be launched with a grenade launcher, and detonates once it reaches its destination. It disperses a cone of lingering flames in a small area in front of it. The warped pieces of the grenade can also set fire as they fly away."
	icon_state = "grenade_m74_airburst_i"
	item_state = "grenade_m74_airburst_i_active"
	caliber = "40x53mm"
	det_time = 0 // Unused, because we don't use prime.
	hand_throwable = FALSE
	flame_level = 15
	burn_level = 20
	flameshape = FLAMESHAPE_TRIANGLE
	radius = 2
	var/shrapnel_count = 5
	var/shrapnel_type = /datum/ammo/bullet/shrapnel/incendiary

/obj/item/explosive/grenade/incendiary/airburst/prime()

/obj/item/explosive/grenade/incendiary/airburst/launch_impact(atom/hit_atom)
	..()
	var/detonate = TRUE
	var/turf/hit_turf = null
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom))
		hit_turf = hit_atom
		if(hit_turf.density && !rebounding)
			detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		var/angle = dir2angle(last_move_dir)
		var/turf/target = locate(src.loc.x + sin(angle)*radius, src.loc.y + cos(angle)*radius, src.loc.z)
		if(shrapnel_count)
			create_shrapnel(loc, shrapnel_count, last_move_dir , 30 ,shrapnel_type, cause_data, FALSE, 0)
		if(target)
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, flameshape, target)
		else
			//Not stellar, but if we can't find a direction, fall back to HIDP behaviour.
			INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flame_radius), cause_data, radius, get_turf(src), flame_level, burn_level, FLAMESHAPE_DEFAULT, target)
		playsound(src.loc, 'sound/weapons/gun_flamethrower2.ogg', 35, 1, 4)
		qdel(src)

/*
//================================================
				Smoke Grenades
//================================================
*/

/obj/item/explosive/grenade/smokebomb
	name = "\improper M47 HSDP smoke grenade"
	desc = "The M47 HSDP is a small, but powerful smoke grenade. Based off the same platform as the M40 HEDP. Can be fired from a PN 30mm UGL for impact detonation, or primed in-hand and thrown to detonate after 2 seconds."
	icon_state = "grenade_smoke"
	det_time = 20
	item_state = "grenade_smoke"
	caliber = "30mm"
	underslug_launchable = TRUE
	harmful = FALSE
	antigrief_protection = FALSE
	arm_sound = 'sound/weapons/grenade.ogg'
	var/datum/effect_system/smoke_spread/bad/smoke
	var/smoke_type = /datum/effect_system/smoke_spread/bad
	var/smoke_radius = 3
	var/smoke_duration = 40
	dual_purpose = TRUE
	spent_case = /obj/item/trash/grenade

/obj/item/explosive/grenade/smokebomb/New()
	..()
	smoke = new smoke_type(src)
	smoke.attach(src)

/obj/item/explosive/grenade/smokebomb/Destroy()
	QDEL_NULL(smoke)
	return ..()

/obj/item/explosive/grenade/smokebomb/prime(mob/living/user)
	set waitfor = 0
	if(fuse_type == IMPACT_FUSE)
		to_chat(user, SPAN_WARNING("This grenade is set for impact-fusing!"))
		return
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	smoke.set_up(smoke_radius, 0, get_turf(src), null, smoke_duration)
	smoke.start()
	new spent_case(get_turf(src))
	qdel(src)

/obj/item/explosive/grenade/smokebomb/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
		smoke.set_up(smoke_radius, 0, get_turf(src), null, smoke_duration)
		smoke.start()
		if(spent_case)
			new spent_case(get_turf(src))
		qdel(src)

/obj/item/explosive/grenade/smokebomb/green
	name = "\improper M47-G HSDP smoke grenade"
	desc = "The M47 HSDP is a small, but powerful smoke grenade. Based off the same platform as the M40 HEDP. Can be fired from a PN 30mm UGL for impact detonation, or primed in-hand and thrown to detonate after 2 seconds. The G subtype erupts into a cloud of green smoke upon detonation."
	icon_state = "grenade_smoke_green"
	smoke_type = /datum/effect_system/smoke_spread/bad/green
	smoke_radius = 2

/obj/item/explosive/grenade/smokebomb/red
	name = "\improper M47-R HSDP smoke grenade"
	desc = "The M47 HSDP is a small, but powerful smoke grenade. Based off the same platform as the M40 HEDP. Can be fired from a PN 30mm UGL for impact detonation, or primed in-hand and thrown to detonate after 2 seconds. The R subtype erupts into a cloud of red smoke upon detonation."
	icon_state = "grenade_smoke_red"
	smoke_type = /datum/effect_system/smoke_spread/bad/red
	smoke_radius = 2

/obj/item/explosive/grenade/smokebomb/upp
	name = "RDG-17 smoke grenade"
	desc = "Handgrenade, smoke, model 17. Simple, old and efficient design, these grenades are produced basically everywhere for use in the UPP Armed Collective."
	icon_state = "grenade_upp_smoke"
	caliber = "non-standard"
	arm_sound = 'sound/weapons/pinpull.ogg'

/obj/item/explosive/grenade/phosphorus
	name = "\improper M60 WPSI grenade"
	desc = "The M60 WPSI is a small, but powerful chemical compound grenade, designated as such with a white cap. Usable for both smoke-screen purposes and as an incendiary device. Two second fuse."
	icon_state = "grenade_phos"
	det_time = 20
	item_state = "grenade_training"
	caliber = "30mm"
	underslug_launchable = TRUE
	dual_purpose = TRUE
	arm_sound = 'sound/weapons/grenade.ogg'
	var/shrapnel_count = 16
	var/shrapnel_type = /datum/ammo/bullet/shrapnel/incendiary/light
	var/datum/effect_system/smoke_spread/phosphorus/smoke
	dangerous = TRUE
	harmful = TRUE
	var/smoke_radius = 3

/obj/item/explosive/grenade/phosphorus/Destroy()
	QDEL_NULL(smoke)
	return ..()

/obj/item/explosive/grenade/phosphorus/Initialize()
	. = ..()
	smoke = new /datum/effect_system/smoke_spread/phosphorus
	smoke.attach(src)

/obj/item/explosive/grenade/phosphorus/prime(mob/living/user)
	set waitfor = 0
	if(fuse_type == IMPACT_FUSE)
		to_chat(user, SPAN_WARNING("This grenade is set for impact-fusing!"))
		return
	playsound(src.loc, 'sound/effects/wp_smoke.ogg', 25, 1, 5)
	smoke.set_up(smoke_radius, 0, get_turf(src), null, 25)
	smoke.start()
	create_shrapnel(loc, shrapnel_count, , ,shrapnel_type, cause_data)
	qdel(src)

/obj/item/explosive/grenade/phosphorus/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
		smoke.set_up(smoke_radius, 0, get_turf(src), null, 25)
		smoke.start()
		create_shrapnel(loc, shrapnel_count, , ,shrapnel_type, cause_data)
		qdel(src)

/obj/item/explosive/grenade/phosphorus/upp
	name = "\improper Type 8 WP grenade"
	desc = "A deadly gas grenade found within the ranks of the UPP. Designed to spill white phosphorus on the target. It explodes 2 seconds after the pin has been pulled."
	underslug_launchable = FALSE
	dual_purpose = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	icon_state = "grenade_upp_wp"
	item_state = "grenade_upp_wp"
	caliber = "non-standard"

/obj/item/explosive/grenade/phosphorus/clf
	name = "\improper improvised phosphorus bomb"
	desc = "An improvised version of gas grenade designed to spill white phosphorus on the target. It explodes 2 seconds after the pin has been pulled."
	underslug_launchable = FALSE
	dual_purpose = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	icon_state = "grenade_phos_clf"
	item_state = "grenade_phos_clf"
	caliber = "non-standard"

/*
//================================================
				Sonic Electronic Ball Breakers
//================================================
*/

/obj/item/explosive/grenade/sebb
	name = "\improper G2 Electroshock grenade"
	desc = "This is a G2 Electroshock Grenade. Produced by Armat Battlefield Systems, it's sometimes referred to as the Sonic Electric Ball Breaker, \
		after a rash of incidents where the intense 1.2 gV sonic payload caused... rupturing. \
		A bounding landmine mode is available for this weapon which activates a small drill to self-bury itself when planted. Simply plant it at your feet and walk away."
	icon_state = "grenade_sebb"
	item_state = "grenade_sebb"
	caliber = "non-standard"
	det_time = 3 SECONDS
	underslug_launchable = TRUE
	/// Maximum range of effect
	var/range = 5
	/// Maximum possible damage before falloff.
	var/damage = 110
	/// Factor to mutiply the effect range has on damage.
	var/falloff_dam_reduction_mult = 20
	/// Post falloff calc damage is divided by this to get xeno slowdown
	var/xeno_slowdown_numerator = 12
	/// Post falloff calc damage is multipled by this to get human stamina damage
	var/human_stam_dam_factor = 0.9

/obj/item/explosive/grenade/sebb/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("To put into mine mode, plant at feet.")

/obj/item/explosive/grenade/sebb/afterattack(atom/target, mob/user, proximity)
	var/turf/user_turf = get_turf(user)
	if(active)
		return

	if(!isturf(target))
		return

	if(user.action_busy)
		return

	if(target != get_turf(user))
		return

	if(locate(/obj/item/explosive/mine) in get_turf(src))
		to_chat(user, SPAN_WARNING("There already is a mine at this position!"))
		return

	if(antigrief_protection && user.faction == FACTION_MARINE && explosive_antigrief_check(src, user))
		to_chat(user, SPAN_WARNING("\The [name]'s safe-area accident inhibitor prevents you from planting!"))
		msg_admin_niche("[key_name(user)] attempted to plant \a [name] in [get_area(src)] [ADMIN_JMP(src.loc)]")
		return

	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		if(!human.allow_gun_usage)
			to_chat(user, SPAN_WARNING("Your programming prevents you from using this!"))
			return

	if(user_turf && (user_turf.density || locate(/obj/structure/fence) in user_turf))
		to_chat(user, SPAN_WARNING("You can't plant a mine here."))
		return

	if(Adjacent(/obj/item/explosive/mine)) // bit more strict on this than normal mines
		to_chat(user, SPAN_WARNING("Too close to another mine! Plant it somewhere less obvious."))
		return

	user.visible_message(SPAN_NOTICE("[user] starts deploying [src]."),
		SPAN_NOTICE("You switch [src] into landmine mode and start placing it..."))
	playsound(user.loc, 'sound/effects/thud.ogg', 40)
	if(!do_after(user, 5 SECONDS * user.get_skill_duration_multiplier(SKILL_CONSTRUCTION), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		to_chat(user, SPAN_NOTICE("You stop planting."))
		return

	user.visible_message(SPAN_NOTICE("[user] finishes deploying [src]."),
		SPAN_NOTICE("You finish deploying [src]."))
	var/obj/item/explosive/mine/sebb/planted = new /obj/item/explosive/mine/sebb(get_turf(user))
	planted.activate_sensors()
	planted.iff_signal = user.faction // assuring IFF is set
	planted.pixel_x += rand(-5, 5)
	planted.pixel_y += rand(-5, 5)
	qdel(src)

/obj/item/explosive/grenade/sebb/activate()
	..()
	var/beeplen = 6 // Actual length of the sound rounded up to nearest decisecond
	var/soundtime = det_time - beeplen
	if(det_time < beeplen) // just play sound if detonation shorter than the sound
		playsound(loc, 'sound/effects/sebb_explode.ogg', 90, 0, 10)
	else
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), loc, 'sound/effects/sebb_beep.ogg', 60, 0, 10), soundtime)

/obj/item/explosive/grenade/sebb/prime()
	var/datum/effect_system/spark_spread/sparka = new
	var/turf/sebb_turf = get_turf(src)
	var/list/full_range = oview(range, src) // Fill a list of stuff in the range so we won't have to spam oview
	new /obj/effect/overlay/temp/sebb(sebb_turf)

	playsound(src.loc, 'sound/effects/sebb_explode.ogg', 90, 0, 10)

	for(var/obj/structure/machinery/defenses/sentry/sentry_stun in full_range)
		sentry_stun.sentry_range = 0 // Temporarily "disable" the sentry by killing its range then setting it back.
		new /obj/effect/overlay/temp/elec_arc(get_turf(sentry_stun))  // sprites are meh but we need visual indication that the sentry was messed up
		addtimer(VARSET_CALLBACK(sentry_stun, sentry_range, initial(sentry_stun.sentry_range)), 5 SECONDS) // assure to set it back
		sentry_stun.visible_message(SPAN_DANGER("[src]'s screen flickes violently as it's shocked!"))
		sentry_stun.visible_message(SPAN_DANGER("[src] says \"ERROR: Fire control system resetting due to critical voltage flucuation!\""))
		sparka.set_up(1, 1, sentry_stun)
		sparka.start()

	for(var/turf/turf in full_range)
		if(prob(8))
			var/datum/effect_system/spark_spread/sparkTurf = new //using a different spike system because the spark system doesn't like when you reuse it for differant things
			sparkTurf.set_up(1, 1, turf)
			sparkTurf.start()
		if(prob(10))
			new /obj/effect/overlay/temp/emp_sparks(turf)

	for(var/mob/living/carbon/mob in full_range) // no legacy mob support

		var/mob_dist = get_dist(src, mob) // Distance from mob

		/**
		 * Damage equation: damage - (mob distance * falloff_dam_reduction_mult)
		 * Example: A marine is 3 tiles out, the distance (3) is multiplied by falloff_dam_reduction_mult to get falloff.
		 * The raw damage is minused by falloff to get actual damage
		*/

		var/falloff = mob_dist * falloff_dam_reduction_mult
		var/damage_applied = damage - falloff // Final damage applied after falloff calc
		sparka.set_up(1, 1, mob)
		sparka.start()
		shake_camera(mob, 1, 1)
		if(ishuman(mob))
			var/mob/living/carbon/human/shocked_human = mob
			if(isspeciessynth(shocked_human)) // Massive overvoltage to ungrounded robots is pretty bad
				shocked_human.Stun(1 + (damage_applied/40))
				damage_applied *= 1.5
				new /obj/effect/overlay/temp/elec_arc(get_turf(shocked_human))
				to_chat(mob, SPAN_HIGHDANGER("All of your systems jam up as your main bus is overvolted by [damage_applied*2] volts."))
				mob.visible_message(SPAN_WARNING("[mob] seizes up from the elctric shock"))
			shocked_human.take_overall_armored_damage(damage_applied, ARMOR_ENERGY, BURN, 90) // 90% chance to be on additional limbs
			shocked_human.make_dizzy(damage_applied)
			mob.apply_stamina_damage(damage_applied*human_stam_dam_factor) // Stamina damage
			shocked_human.emote("pain")
		else //nonhuman damage + slow
			mob.apply_damage(damage_applied, BURN)
			if((mob_dist < (range-3))) // 2 tiles around small superslow
				mob.Superslow(2)
			mob.Slow(damage_applied/11)

		if(mob_dist < 1) // Range based stuff, standing ontop of the equivalent of a canned lighting bolt should mess you up.
			mob.Superslow(3) // Note that humans will likely be in stamcrit so it's always worse for them when ontop of it and we can just balancing it on xenos.
			mob.eye_blurry = damage_applied/4
			mob.Daze(1)
		else if((mob_dist < (range-1)) && (mob.mob_size < MOB_SIZE_XENO_VERY_SMALL)) // Flicker stun humans that are closer to the grenade and larvas too.
			mob.apply_effect(1 + (damage_applied/100),WEAKEN) // 1 + damage/40
			mob.eye_blurry = damage_applied/8

		else
			to_chat(mob, SPAN_HIGHDANGER("Your entire body seizes up as a powerful shock courses through it!"))


		new /obj/effect/overlay/temp/emp_sparks(mob)
		mob.make_jittery(damage_applied*2)
	empulse(src, 1, 2) // mini EMP
	qdel(src)


/obj/item/explosive/grenade/sebb/primed
	desc = "A G2 Electroshock Grenade, looks like it's quite angry! Oh shit!"
	det_time = 7 // 0.7 seconds to blow up. We want them to get caught if they go through.

/obj/item/explosive/grenade/sebb/primed/Initialize()
	. = ..()
	src.visible_message(SPAN_HIGHDANGER("[src] pops out of the ground!"))
	activate()

/obj/effect/overlay/temp/sebb
	icon = 'icons/effects/sebb.dmi'
	icon_state = "sebb_explode"
	layer = ABOVE_LIGHTING_PLANE
	pixel_x = -175 // We need these offsets to force center the sprite because BYOND is dumb
	pixel_y = -175
	appearance_flags = RESET_COLOR

/*
//================================================
			Nerve Gas Grenades
//================================================
*/
/obj/item/explosive/grenade/nerve_gas
	name = "\improper CN20 canister grenade"
	desc = "A canister grenade of deadly nerve gas. It is set to detonate in 4 seconds."
	icon_state = "flashbang2"//temp icon
	det_time = 40
	item_state = "grenade_phos_clf"//temp icon
	caliber = "non-standard"
	underslug_launchable = FALSE
	harmful = TRUE
	antigrief_protection = TRUE
	arm_sound = 'sound/weapons/pinpull.ogg'
	/// The nerve gas datum
	var/datum/effect_system/smoke_spread/cn20/nerve_gas
	/// The typepath of the nerve gas
	var/nerve_gas_type = /datum/effect_system/smoke_spread/cn20
	/// The radius the gas will reach
	var/nerve_gas_radius = 4
	spent_case = /obj/item/trash/grenade/gas

/obj/item/explosive/grenade/nerve_gas/Initialize(mapload, ...)
	. = ..()
	nerve_gas = new nerve_gas_type
	nerve_gas.attach(src)

/obj/item/explosive/grenade/nerve_gas/Destroy()
	QDEL_NULL(nerve_gas)
	return ..()

/obj/item/explosive/grenade/nerve_gas/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	nerve_gas.set_up(nerve_gas_radius, 0, get_turf(src), null, 20)
	nerve_gas.start()
	new spent_case(get_turf(src))
	qdel(src)

/obj/item/explosive/grenade/nerve_gas/xeno
	name = "\improper CN20-X canister grenade"
	nerve_gas_type = /datum/effect_system/smoke_spread/cn20/xeno

/*
//================================================
			LSD Gas Grenades
//================================================
*/
/obj/item/explosive/grenade/LSD
	name = "\improper ALD-91 canister grenade"
	desc = "A canister grenade of nonlethal LSD gas. It is set to detonate in 4 seconds."
	icon_state = "flashbang2"//temp icon
	det_time = 40
	item_state = "grenade_phos_clf"//temp icon
	caliber = "non-standard"
	underslug_launchable = FALSE
	harmful = TRUE
	antigrief_protection = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	var/datum/effect_system/smoke_spread/LSD/LSD_gas
	var/LSD_gas_radius = 4
	spent_case = /obj/item/trash/grenade/gas

/obj/item/explosive/grenade/LSD/Initialize()
	. = ..() //if it ain't broke don't fix it
	LSD_gas = new /datum/effect_system/smoke_spread/LSD
	LSD_gas.attach(src)

/obj/item/explosive/grenade/LSD/Destroy()
	QDEL_NULL(LSD_gas)
	return ..()

/obj/item/explosive/grenade/LSD/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	LSD_gas.set_up(LSD_gas_radius, 0, get_turf(src), null, 20)
	LSD_gas.start()
	new spent_case(get_turf(src))
	qdel(src)

/*
//================================================
			Tear Gas Grenades
//================================================
*/
/obj/item/explosive/grenade/tear
	name = "\improper tear gas grenade"
	desc = "A canister grenade of nonlethal Tear gas. It is set to detonate in 4 seconds."
	icon_state = "flashbang2"//temp icon
	det_time = 40
	item_state = "grenade_phos_clf"//temp icon
	caliber = "non-standard"
	underslug_launchable = FALSE
	harmful = TRUE
	antigrief_protection = FALSE
	arm_sound = 'sound/weapons/pinpull.ogg'
	var/datum/effect_system/smoke_spread/tear/tear_gas
	var/tear_gas_radius = 3
	spent_case = /obj/item/trash/grenade/gas

/obj/item/explosive/grenade/tear/Initialize()
	. = ..() //if it ain't broke don't fix it
	tear_gas = new /datum/effect_system/smoke_spread/tear
	tear_gas.attach(src)

/obj/item/explosive/grenade/tear/Destroy()
	QDEL_NULL(tear_gas)
	return ..()

/obj/item/explosive/grenade/tear/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	tear_gas.set_up(tear_gas_radius, 0, get_turf(src), null, 90)
	tear_gas.start()
	new spent_case(get_turf(src))
	qdel(src)

/obj/item/explosive/grenade/tear/marine
	name = "\improper M66 teargas grenade"
	desc = "Tear gas grenade used for nonlethal riot control. Please wear adequate gas protection."
	icon_state = "grenade_gas"
	det_time = 40
	item_state = "grenade_phos"//temp icon
	caliber = "30mm"
	underslug_launchable = TRUE
	tear_gas_radius = 4
	arm_sound = 'sound/weapons/grenade.ogg'
	spent_case = /obj/item/trash/grenade/gas/marine

/*
//================================================
			Airburst Smoke Grenades
//================================================
*/

/obj/item/explosive/grenade/smokebomb/airburst
	name = "\improper M74 AGM-S 40mm Grenade"
	desc = "M74 - Airburst Grenade Munition - Smoke. This grenade must be launched with a grenade launcher, and detonates once it reaches its destination. Upon detonation, instantly combines multiple chemicals inside its casing to form a smoke cloud."
	icon_state = "grenade_m74_airburst_s"
	item_state = "grenade_m74_airburst_s_active"
	det_time = 0 // Unused, because we don't use prime.
	hand_throwable = FALSE
	smoke_radius = 2
	spent_case = null

/obj/item/explosive/grenade/smokebomb/airburst/New()
	..()
	smoke = new /datum/effect_system/smoke_spread/bad
	smoke.attach(src)


/obj/item/explosive/grenade/smokebomb/airburst/prime()
// We don't prime, we use launch_impact.

/*
//================================================
				Baton Slugs
//================================================
*/

/obj/item/explosive/grenade/slug
	name = "slug shell"
	desc = "It doesn't actually explode. Fancy that."
	icon_state = "chemg"
	hand_throwable = FALSE
	var/impact_damage = 10
	var/impact_sound = 'sound/weapons/baton_slug_impact.ogg'
	var/slowdown_time = 2
	var/knockout_time = 0.1
	var/dazed_time = 0.5
	var/inactive_icon = "chemg"
	var/throw_max = 3 //What is the max range the baton can push/fling someone
	var/throw_min = 1 //what is the min range the baton can push/fling
	var/ram_distance = 2 //How far can the baton bounce after impacting a mob, Also how many times it can bounce
	has_arm_sound = FALSE
	throwforce = 10
	antigrief_protection = FALSE

/obj/item/explosive/grenade/slug/prime()
	active = 0
	overlays.Cut()
	icon_state = initial(icon_state)
	w_class = initial(w_class)
	throwforce = initial(throwforce)
	throw_max = initial(throw_max)
	throw_min = initial(throw_min)
	ram_distance = initial(ram_distance)

/obj/item/explosive/grenade/slug/launch_impact(atom/hit_atom)
	if(!active)
		return
	if(ismob(hit_atom))
		impact_mob(hit_atom)
		ram_distance -- //for max pinballing.
	icon_state = inactive_icon

/obj/item/explosive/grenade/slug/proc/impact_mob(mob/living/smacked)
	var/direction = Get_Angle(src, smacked)
	var/target_turf = get_angle_target_turf(src,direction, throw_max)
	var/fling = rand(throw_min, throw_max) //WEEEEEEEEEEEEEEEEEEEE What is going to be put into throw_atom
	var/random_tile = 0 //random tile for bounce

	playsound(smacked.loc, impact_sound, 75, 1)
	smacked.apply_damage(impact_damage, BRUTE)
	smacked.attack_log += "\[[time_stamp()]\] [src], fired by [fingerprintslast], struck [key_name(smacked)]."

	random_tile = get_random_turf_in_range(src,ram_distance,ram_distance) //getting random tile for bounce
	src.throw_atom(random_tile,ram_distance,SPEED_FAST,src,TRUE,NORMAL_LAUNCH,NO_FLAGS) //time for a little trolling

	if(isyautja(smacked)|| issynth(smacked))
		smacked.apply_effect(slowdown_time * 0.5, SLOW)
		smacked.apply_effect(dazed_time * 0.5, DAZE)

	if(smacked.mob_size >= MOB_SIZE_BIG)//big xenos not KO'ed
		smacked.apply_effect(slowdown_time * 1.2, SLOW)//They are slowed more :trol:
		smacked.apply_effect(dazed_time * 1.2, DAZE)
		return

	smacked.apply_effect(knockout_time, WEAKEN)//but little xenos and humans are
	smacked.throw_atom(target_turf, fling, SPEED_AVERAGE, smacked, TRUE)
	smacked.apply_effect(slowdown_time, SLOW)
	smacked.apply_effect(dazed_time, DAZE)
	smacked.visible_message(SPAN_NOTICE("[smacked] is hit by the [src], which shatters apart after impact."),
		SPAN_NOTICE("The [src] shatters against you after imparting it's force!"))
	qdel(src)

/obj/item/explosive/grenade/slug/baton
	name = "\improper M230 LLRB grenade"
	desc = "Rarely issued to the Colonial Marines, the M230 less-than-lethal rounds are primarily used during civil disturbances. Can still be lethal if fired against particularly soft tissue."
	icon_state = "grenade_ltl"
	item_state = "baton_slug"
	inactive_icon = "grenade_ltl"
	caliber = "30mm"
	antigrief_protection = FALSE
	underslug_launchable = TRUE
	hand_throwable = FALSE
	impact_damage = 15
	slowdown_time = 2
	knockout_time = 0.8
	dazed_time = 1.7

/obj/item/explosive/grenade/slug/baton/Initialize()
	. = ..()
	setDir(NORTH) //so they're oriented properly in our inventory


/*
//================================================
					Other
//================================================
*/

/obj/item/explosive/grenade/high_explosive/training
	name = "M07 training grenade"
	desc = "A harmless reusable version of the M40 HEDP, used for training. Capable of being loaded in the M92 Launcher, or thrown by hand."
	icon_state = "grenade_training"
	item_state = "grenade_training"
	dangerous = TRUE
	harmful = FALSE
	antigrief_protection = FALSE
	explosion_power = 0	//SOMEHOW, MARINES FOUND A WAY TO KILL ONE ANOTHER WITH THESE
	explosion_falloff = 0

/obj/item/explosive/grenade/high_explosive/training/prime()
	spawn(0)
		playsound(loc, 'sound/items/detector.ogg', 80, 0, 7)
		active = 0 //so we can reuse it
		overlays.Cut()
		icon_state = initial(icon_state)
		det_time = initial(det_time) //these can be modified when fired by UGL
		throw_range = initial(throw_range)
		w_class = initial(w_class)

/obj/item/explosive/grenade/high_explosive/training/flamer_fire_act()
	return

/obj/item/explosive/grenade/high_explosive/training/launch_impact(atom/hit_atom)
	if(!active)
		return
	icon_state = initial(icon_state)

/obj/item/explosive/grenade/high_explosive/m15/rubber
	name = "\improper M15 rubber pellet grenade"
	desc = "A relatively harmless version of the M15 grenade designed for riot control and combat exercises."
	icon_state = "rubber_grenade"
	item_state = "rubber_grenade"
	explosion_power = 0
	shrapnel_type = /datum/ammo/bullet/shrapnel/rubber
	antigrief_protection = FALSE

/// Baton slugs
/obj/item/explosive/grenade/baton
	name = "\improper HIRR baton slug"
	desc = "Cousin to the M15 Rubber pellet, the HIRR baton slug was recalled from military and civilian police forces due to over-packed propellant in the sabot casing. Now it is utilized as a less-than-lethal option in engagements with human, and sometimes non-human, forces. Historically, the HIRR was incredibly popular during the Arcturus conflict, as the impact force was found to reliably incapacitate Arcturian resistance forces by breaking their ribs into their lungs."
	icon_state = "grenade_ltl"
	item_state = "rubber_grenade"
	hand_throwable = FALSE
	antigrief_protection = FALSE


/obj/item/explosive/grenade/baton/flamer_fire_act()
	return

/obj/item/explosive/grenade/slug/baton/m79
	name = "\improper LTL 40mm grenade"
	desc = "It's a Less Than Lethal 40mm rubber projectile."
	icon_state = "grenade_40mm_ltl"
	item_state = "rubber_grenade"

/obj/item/explosive/grenade/high_explosive/holy_hand_grenade
	AUTOWIKI_SKIP(TRUE)

	name = "\improper Holy Hand Grenade of Antioch"
	desc = "And Saint Attila raised the hand grenade up on high, saying, \"O LORD, bless this Thy hand grenade that with it Thou mayest blow Thine enemies to tiny bits, in Thy mercy.\" And the LORD did grin and the people did feast upon the lambs and sloths and carp and anchovies... And the LORD spake, saying, \"First shalt thou take out the Holy Pin, then shalt thou count to three, no more, no less. Three shall be the number thou shalt count, and the number of the counting shall be three. Four shalt thou not count, neither count thou two, excepting that thou then proceed to three. Five is right out. Once the number three, being the third number, be reached, then lobbest thou thy Holy Hand Grenade of Antioch towards thy foe, who, being naughty in My sight, shall snuff it.\""
	icon_state = "grenade_antioch"
	item_state = "grenade_antioch"
	caliber = "non-standard"
	throw_speed = SPEED_VERY_FAST
	throw_range = 10
	underslug_launchable = FALSE
	explosion_power = 300
	det_time = 50
	unacidable = TRUE
	arm_sound = 'sound/voice/holy_chorus.ogg'//https://www.youtube.com/watch?v=hNV5sPZFuGg
	falloff_mode = EXPLOSION_FALLOFF_SHAPE_LINEAR

/obj/item/explosive/grenade/metal_foam
	name = "\improper M42 MFHS grenade"
	desc = "A Metal-Foam Hull-Sealant grenade originally used for emergency repairs but have found other practical applications on the field. Based off the same hull as the M40 HEDP. Has a 2 second fuse."
	icon_state = "grenade_metal_foam"
	item_state = "grenade_metal_foam"
	caliber = "30mm"
	det_time = 20
	underslug_launchable = TRUE
	harmful = FALSE
	arm_sound = 'sound/weapons/grenade.ogg'
	var/foam_metal_type = FOAM_METAL_TYPE_IRON

/obj/item/explosive/grenade/metal_foam/prime()
	var/datum/effect_system/foam_spread/s = new()
	s.set_up(12, get_turf(src), metal_foam = foam_metal_type) //12 amt = 2 tiles radius (5 tile length diamond)
	s.start()
	qdel(src)

// abstract grenades used for hijack explosions

/obj/item/explosive/grenade/high_explosive/bursting_pipe
	name = "bursting pipe"
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/item/explosive/grenade/incendiary/bursting_pipe
	name = "bursting pipe"
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	flame_level = BURN_TIME_TIER_3
	burn_level = BURN_LEVEL_TIER_3
	radius = 2
	fire_type = FIRE_VARIANT_DEFAULT

//Royal marine grenades

/obj/item/explosive/grenade/high_explosive/rmc
	name = "\improper R2175/A HEDP grenade"
	desc = "High-Explosive Dual-Purpose. A small, but deceptively strong blast grenade that has recently been added to the arsenal of the RMC."
	icon_state = "rmc_grenade"
	item_state = "grenade_hedp"
	caliber = "30mm"
	explosion_power = 130
	explosion_falloff = 30

/obj/item/explosive/grenade/incendiary/rmc
	name = "\improper R2175/B HIDP grenade"
	desc = "The R2175/B HIDP is a small, but deceptively strong incendiary grenade designed to rapidly clear areas with fast-acting potent fire. It is set to detonate in 4 seconds."
	icon_state = "rmc_grenade_fire"
	item_state = "grenade_fire"
	caliber = "30mm"
	flame_level = BURN_TIME_TIER_1
	burn_level = BURN_LEVEL_TIER_8
	radius = 3
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/explosive/grenade/nerve_gas/xeno/rmc
	name = "\improper R2175/CN20 grenade"
	desc = "A small grenade containing a vial of deadly nerve gas. Usually knocks out the targets for long enough to allow RMCs to take them out. You can almost hear your Instructor's screaming in the back of your head, mentioning something about a gas mask. It is set to detonate in 3.5 seconds."
	icon_state = "rmc_grenade_gas"
	item_state = "grenade_smoke"
	caliber = "30mm"
	det_time = 35
	item_state = "grenade_smoke"
	arm_sound = 'sound/weapons/grenade.ogg'
	underslug_launchable = TRUE
	dual_purpose = TRUE
	spent_case = /obj/item/trash/grenade/gas/rmc

/obj/item/explosive/grenade/nerve_gas/xeno/rmc/prime()
	playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
	nerve_gas.set_up(nerve_gas_radius, 0, get_turf(src), null, 12)
	nerve_gas.start()
	new spent_case(get_turf(src))
	qdel(src)

/obj/item/explosive/grenade/nerve_gas/xeno/rmc/launch_impact(atom/hit_atom)
	if(fuse_type != IMPACT_FUSE)
		return
	var/detonate = TRUE
	if(isobj(hit_atom) && !rebounding)
		detonate = FALSE
	if(isturf(hit_atom) && hit_atom.density && !rebounding)
		detonate = FALSE
	if(active && detonate) // Active, and we reached our destination.
		playsound(src.loc, 'sound/effects/smoke.ogg', 25, 1, 4)
		nerve_gas.set_up(nerve_gas_radius, 0, get_turf(src), null, 12)
		nerve_gas.start()
		new spent_case(get_turf(src))
		qdel(src)

// RMC 20mm baby-nades

/obj/item/explosive/grenade/high_explosive/impact/rmc20mm
	name = "\improper L103A1 20mm HE grenade"
	desc = "A 20mm grenade that explodes upon impact. Less powerful than full-sized grenades."
	icon_state = "grenade_20mm_he"
	item_state = "grenade_hedp"
	caliber = "20mm"
	explosion_power = 80
	shrapnel_count = 8

/obj/item/explosive/grenade/high_explosive/airburst/rmc20mm
	name = "\improper L104A1 20mm fragmentation grenade"
	desc = "A 20mm grenade that explodes into shrapnel upon impact."
	icon_state = "grenade_20mm_frag"
	item_state = "grenade_hefa"
	caliber = "20mm"
	shrapnel_type = /datum/ammo/bullet/shrapnel/heavy
	direct_hit_shrapnel = 12
	explosion_power = 30
	shrapnel_count = 36
	dispersion_angle = 45

/obj/item/explosive/grenade/incendiary/airburst/rmc20mm
	name = "\improper L103A1/I 20mm incendiary grenade"
	desc = "A 20mm grenade that explodes into flaming shrapnel & a pool of incendiary compound upon impact."
	icon_state = "grenade_20mm_inc"
	item_state = "grenade_fire"
	caliber = "20mm"
	flame_level = BURN_TIME_TIER_1
	burn_level = BURN_LEVEL_TIER_8
	flameshape = FLAMESHAPE_IRREGULAR
	radius = 2
	shrapnel_count = 12
	shrapnel_type = /datum/ammo/bullet/shrapnel/incendiary/heavy

/obj/item/explosive/grenade/smokebomb/airburst/rmc20mm
	name = "\improper L101A2 20mm nerve-agent grenade"
	desc = "A 20mm grenade that explodes into a voluminous cloud of nerve gas upon impact."
	icon_state = "grenade_20mm_gas"
	item_state = "grenade_smoke"
	caliber = "20mm"
	spent_case = null
	smoke_radius = 3
	smoke_duration = 12

/obj/item/explosive/grenade/smokebomb/airburst/rmc20mm/New()
	..()
	smoke = new /datum/effect_system/smoke_spread/cn20/xeno
	smoke.attach(src)

/obj/item/explosive/grenade/high_explosive/impact/rmc20mm/holo
	name = "\improper L104A1/H 20mm holo-targetting grenade"
	desc = "A 20mm grenade that explodes into shrapnel upon impact. The shrapenl of this one douses the target in a chemical compound which aids in target acquisition by sensors."
	icon_state = "grenade_20mm_holo"
	item_state = "grenade_phos"
	caliber = "20mm"
	explosion_power = 10
	shrapnel_count = 32
	shrapnel_type = /datum/ammo/bullet/shrapnel/hornet_rounds/rmc

/obj/item/explosive/grenade/high_explosive/impact/heap/rmc20mm
	name = "\improper L108A1 HESH grenade"
	desc = "A powerful high-explosive squash-head 20mm grenade that explodes upon impact."
	icon_state = "grenade_20mm_squash"
	item_state = "grenade_training"
	caliber = "20mm"
	explosion_power = 160
