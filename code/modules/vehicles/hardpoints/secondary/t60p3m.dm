/obj/item/hardpoint/secondary/t60p3m
	name = "\improper T6OP-3M 'Buzzard' RWS"
	desc = "A secondary remotely-controlled weapon system for UPP tanks using an older-model machine gun."
	desc_lore = "An older, albeit modernized remote machinegun seen in use by the Cheetah 2A. This Russo-Polish developed machinegun features robust autonomous fire capability, and was commonly used to intercept low-threat projectiles, though thanks to the superior active and passive systems in most vehicles, tankists now prefer to simply fire it at infantry and soft targets instead. Known for an annoying tendency for drifting off target in certain high temperature environments."

	icon = 'icons/obj/vehicles/hardpoints/upptank.dmi'
	icon_state = "t60p3m"
	disp_icon = "upptank"
	disp_icon_state = "t60p3m"
	activation_sounds = list('sound/weapons/gun_smartgun1.ogg', 'sound/weapons/gun_smartgun2.ogg', 'sound/weapons/gun_smartgun3.ogg', 'sound/weapons/gun_smartgun4.ogg')

	health = 2000
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/t60p3m
	max_clips = 1

	use_muzzle_flash = FALSE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(8, -7),
		"2" = list(-7, -21),
		"4" = list(12, -10),
		"8" = list(-11, 7)
	)

	scatter = 1
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(
		GUN_FIREMODE_AUTOMATIC,
	)
	fire_delay = 0.1 SECONDS

/obj/item/hardpoint/secondary/t60p3m/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/secondary/t60p3m/solo
	allowed_seat = VEHICLE_DRIVER
