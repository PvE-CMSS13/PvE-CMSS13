/obj/item/hardpoint/primary/autocannon
	name = "\improper AC3-E Autocannon"
	desc = "A primary autocannon for tanks that shoots explosive flak rounds."

	icon_state = "ace_autocannon"
	disp_icon = "tank"
	disp_icon_state = "ace_autocannon"
	activation_sounds = list('sound/weapons/vehicles/autocannon_fire.ogg')

	health = 2000
	firing_arc = 75

	ammo = new /obj/item/ammo_magazine/hardpoint/ace_autocannon
	max_clips = 5

	px_offsets = list(
		"1" = list(0, 22),
		"2" = list(0, -32),
		"4" = list(32, 0),
		"8" = list(-32, 0)
	)

	scatter = 1
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.5 SECONDS

/obj/item/hardpoint/primary/autocannon/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff),
		BULLET_TRAIT_ENTRY_ID("vehicles", /datum/element/bullet_trait_damage_boost, 20, GLOB.damage_boost_vehicles),
	))

/obj/item/hardpoint/primary/autocannon/solo
	allowed_seat = VEHICLE_DRIVER
