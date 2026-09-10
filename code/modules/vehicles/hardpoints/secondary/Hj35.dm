/obj/item/hardpoint/secondary/hj35launcher
	name = "\improper HJ-35 Launcher"
	desc = "A secondary weapon for UPP armored vehicles that shoots rockets. It loads multiple rockets at once."
	icon = 'icons/obj/vehicles/hardpoints/uppapc.dmi'

	icon_state = "hj35launcher"
	disp_icon = "uppapc"
	disp_icon_state = "apc_hj35"

	health = 2000
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/hj35launcher
	max_clips = 1

	px_offsets = list(
		"1" = list(0, 0),
		"2" = list(0, 0),
		"4" = list(0, 0),
		"8" = list(0, 0)
	)

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(1, 20),
		"2" = list(33, -25),
		"4" = list(39, 16),
		"8" = list(-5, -10)
	)

	scatter = 1.5
	fire_delay = 5.0 SECONDS

/obj/item/hardpoint/secondary/hj35launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff),
		BULLET_TRAIT_ENTRY_ID("vehicles", /datum/element/bullet_trait_damage_boost, 350, GLOB.damage_boost_vehicles),
	))

// for upp tank
/obj/item/hardpoint/secondary/hj35launcher/upptank
	name = "\improper HJ-35-T Launcher"
	desc = "A secondary weapon for upp tank that shoots rockets"
	icon = 'icons/obj/vehicles/hardpoints/upptank.dmi'

	icon_state = "hj35tlauncher"
	disp_icon = "upptank"
	disp_icon_state = "hj35t"

	health = 2000
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/hj35launcher
	max_clips = 1

	use_muzzle_flash = FALSE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(33, 20),
		"2" = list(-33, -25),
		"4" = list(39, 0),
		"8" = list(-5, 10)
	)

/obj/item/hardpoint/secondary/hj35launcher/solo
	allowed_seat = VEHICLE_DRIVER

/obj/item/hardpoint/secondary/hj35launcher/upptank/solo
	allowed_seat = VEHICLE_DRIVER
