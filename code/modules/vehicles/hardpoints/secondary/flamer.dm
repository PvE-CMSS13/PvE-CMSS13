/obj/item/hardpoint/secondary/small_flamer
	name = "\improper LZR-N Flamer Unit"
	desc = "A secondary weapon for tanks that spews hot fire."

	icon_state = "flamer"
	disp_icon = "tank"
	disp_icon_state = "flamer"
	activation_sounds = list('sound/weapons/vehicles/flamethrower.ogg')

	health = 2000
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/secondary_flamer
	max_clips = 4

	use_muzzle_flash = FALSE

	var/max_range = 7

	px_offsets = list(
		"1" = list(2, 14),
		"2" = list(-2, 3),
		"4" = list(3, 0),
		"8" = list(-3, 18)
	)

	scatter = 2
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.5 SECONDS

/obj/item/hardpoint/secondary/small_flamer/try_fire(atom/target, mob/living/user, params)
	if(get_turf(target) in owner.locs)
		to_chat(user, SPAN_WARNING("The target is too close."))
		return NONE

	return ..()

/obj/item/hardpoint/secondary/small_flamer/handle_fire(atom/target, mob/living/user, params)
	//step forward along path so flame starts outside hull
	var/list/turfs = get_line(get_origin_turf(), get_turf(target))
	var/turf/origin_turf
	for(var/turf/turf as anything in turfs)
		if(turf in owner.locs)
			continue
		origin_turf = turf
		break

	var/distance = get_dist(origin_turf, get_turf(target))
	var/fire_amount = min(ammo.current_rounds, distance+1, max_range)
	ammo.current_rounds -= fire_amount
	var/datum/reagent/burnystuff = new /datum/reagent/napalm/high_damage()

	new /obj/flamer_fire(origin_turf, create_cause_data(initial(name), user), burnystuff, fire_amount, null, FLAMESHAPE_LINE, target)

	play_firing_sounds()

	COOLDOWN_START(src, fire_cooldown, fire_delay)

	return AUTOFIRE_CONTINUE

/obj/item/hardpoint/secondary/small_flamer/solo
	allowed_seat = VEHICLE_DRIVER
