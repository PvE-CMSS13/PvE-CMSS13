/obj/item/hardpoint/primary/cannon
	name = "LTB Cannon"
	desc = "A primary cannon for tanks that shoots explosive rounds"

	icon_state = "ltb_cannon"
	disp_icon = "tank"
	disp_icon_state = "ltb_cannon"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 2000
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/ltb_cannon
	max_clips = 4

	px_offsets = list(
		"1" = list(0, 21),
		"2" = list(0, -32),
		"4" = list(32, 0),
		"8" = list(-32, 0)
	)

	muzzle_flash_pos = list(
		"1" = list(0, 59),
		"2" = list(0, -74),
		"4" = list(89, -4),
		"8" = list(-89, -4)
	)

	scatter = 0
	fire_delay = 10.0 SECONDS


/obj/item/hardpoint/primary/cannon/custom
	disp_icon_state = "ltb_cannon_custom"

/obj/item/hardpoint/primary/cannon/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

