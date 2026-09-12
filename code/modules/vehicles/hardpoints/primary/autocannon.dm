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

/obj/item/hardpoint/primary/autocannon/twe_tank
	name = "\improper L26A2 75mm Autocannon"
	desc = "Tosubishi Heavy Industrial Manufacturing main gun for the FV150. Its rapid fire rate and multipurpose ammunition offers stopping power against infantry, structures, and medium armor. Careful use can even disable tanks."
	icon = 'icons/obj/vehicles/hardpoints/twe_tank.dmi'
	icon_state = "light_autocannon"
	disp_icon = "tank"
	disp_icon_state = "light_autocannon"

	allowed_seat = VEHICLE_GUNNER

	firing_arc = 75
	fire_delay = 0.4 SECONDS

	ammo = new /obj/item/ammo_magazine/hardpoint/light_autocannon
	max_clips = 3

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)


/obj/item/hardpoint/primary/autocannon/twe_tank/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff),
		BULLET_TRAIT_ENTRY_ID("vehicles", /datum/element/bullet_trait_damage_boost, 10, GLOB.damage_boost_vehicles),
	))
