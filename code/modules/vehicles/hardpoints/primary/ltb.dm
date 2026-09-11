/obj/item/hardpoint/primary/cannon
	name = "\improper LTB Cannon"
	desc = "A primary cannon for tanks that shoots 85mm high-explosive anti-tank rounds. Comes standard on the M22 Jackson tank, uncommonly mounted to M34 Longstreets."

	icon_state = "ltb_cannon"
	disp_icon = "tank"
	disp_icon_state = "ltb_cannon"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 2000
	firing_arc = 75

	ammo = new /obj/item/ammo_magazine/hardpoint/ltb_cannon
	max_clips = 8

	px_offsets = list(
		"1" = list(0, 21),
		"2" = list(0, -32),
		"4" = list(32, 0),
		"8" = list(-32, 0)
	)

	muzzle_flash_pos = list(
		"1" = list(0, 65),
		"2" = list(0, -80),
		"4" = list(95, -4),
		"8" = list(-95, -4)
	)

	scatter = 0
	fire_delay = 3 SECONDS

/obj/item/hardpoint/primary/cannon/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff),
		BULLET_TRAIT_ENTRY_ID("vehicles", /datum/element/bullet_trait_damage_boost, 300, GLOB.damage_boost_vehicles),
	))

/obj/item/hardpoint/primary/cannon/wolfpack
	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	muzzle_flash_pos = list(
		"1" = list(0, 65),
		"2" = list(0, -80),
		"4" = list(95, -4),
		"8" = list(-95, -4)
	)
