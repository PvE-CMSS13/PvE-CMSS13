// UPP Cannon for upp tank
/obj/item/hardpoint/primary/cannon/railgun
	name = "\improper Railgun Cannon"
	desc = "A primary weapon for UPP tanks that fires hypervelocity sabots."
	desc = "A primary weapon for UPP tanks that fires hypervelocity sabots."
	desc_lore = "An experimental chemical-railgun developed in a secreted orbital facility outside of Sol for hard targets, such as bunkers or dedicated armour. Using a high-efficiency hypergolic propellant as the first stage, which is then accelerated to blistering velocities by the magnetic rails. Thanks to excessive energy requirements, the turret internals were significantly remodelled to account for the capacitors and dedicated generator. Suffers from wear-through issues on barrels, and heat-masking."

	icon = 'icons/obj/vehicles/hardpoints/upptank.dmi'
	icon_state = "railgun"
	disp_icon = "upptank"
	disp_icon_state = "railgun"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 2300
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/railgun
	max_clips = 2

	px_offsets = list(
		"1" = list(-1, 18),
		"2" = list(0, -38),
		"4" = list(17, 12),
		"8" = list(-18, 12)
	)

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(0, 67),
		"2" = list(-1, -88),
		"4" = list(86, -6),
		"8" = list(-86, -6)
	)

	scatter = 0
	fire_delay = 10.0 SECONDS

/obj/item/hardpoint/primary/cannon/railgun/solo
	allowed_seat = VEHICLE_DRIVER
