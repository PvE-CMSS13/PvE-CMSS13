/obj/item/hardpoint/support/flare_launcher
	name = "\improper M-87F Flare Launcher"
	desc = "A support module for APCs that shoots flares."
	icon = 'icons/obj/vehicles/hardpoints/apc.dmi'

	icon_state = "flare_launcher"
	disp_icon = "apc"
	disp_icon_state = "flare_launcher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	damage_multiplier = 0.15

	activatable = TRUE

	health = 1500
	firing_arc = 120

	allowed_seat = VEHICLE_DRIVER

	ammo = new /obj/item/ammo_magazine/hardpoint/flare_launcher
	max_clips = 3

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_laser"

	muzzle_flash_pos = list(
		"1" = list(-4, -34),
		"2" = list(5, 14),
		"4" = list(-20, -6),
		"8" = list(20, -6)
	)

	scatter = 6
	fire_delay = 3.0 SECONDS

/obj/item/hardpoint/support/flare_launcher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

// UPP APC
/obj/item/hardpoint/support/flare_launcher/upp
	name = "\improper ZSL-Flare Launcher"
	desc = "A support module for APCs that shoots flares."
	icon = 'icons/obj/vehicles/hardpoints/uppapc.dmi'

	icon_state = "upp_flare_launcher"
	disp_icon = "uppapc"
	disp_icon_state = "upp_flare_launcher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	damage_multiplier = 0.15

	activatable = TRUE

	health = 1500
	firing_arc = 120

	allowed_seat = VEHICLE_DRIVER

	ammo = new /obj/item/ammo_magazine/hardpoint/flare_launcher
	max_clips = 3

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_laser"

	muzzle_flash_pos = list(
		"1" = list(38, 50),
		"2" = list(-5, -38),
		"4" = list(63, 5),
		"8" = list(-30, 42)
	)

	scatter = 6
	fire_delay = 3.0 SECONDS

// UPP TANK
/obj/item/hardpoint/support/flare_launcher/upptank
	name = "\improper VT/CZ-Flare Launcher"
	desc = "A support module for Tanks that shoots flares."
	icon = 'icons/obj/vehicles/hardpoints/upptank.dmi'

	icon_state = "turret_slauncher"
	disp_icon = "upptank"
	disp_icon_state = "turret_slauncher"
	activation_sounds = list('sound/weapons/gun_m92_attachable.ogg')

	damage_multiplier = 0.15

	activatable = TRUE

	health = 1500
	firing_arc = 120

	allowed_seat = VEHICLE_GUNNER

	use_muzzle_flash = FALSE

/obj/item/hardpoint/support/flare_launcher/upptank/solo
	allowed_seat = VEHICLE_DRIVER
