/obj/item/hardpoint/primary/cannon/ridgeway
	name = "\improper M613 115mm Cannon"
	desc = "  The main gun of the M40 Ridgeway heavy tank. A high-velocity smoothbore 115mm cannon capable of of a withering fire-rate of 60 rounds per minute. Paired with exceptional accuracy, it's able to combat any potential threat; from hostile armour, to reinforced bunkers. This cannon's autoloader seems to be damaged or modified, it probably won't achieve the same rate of fire, tough luck."

	icon_state = "ridgeway_cannon"
	disp_icon = "ridgeway"
	disp_icon_state = "ridgeway_cannon"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 2000
	firing_arc = 75

	ammo = new /obj/item/ammo_magazine/hardpoint/ridgewaycannon
	max_clips = 6

	px_offsets = list(
		"1" = list(0, 46),
		"2" = list(0, -50),
		"4" = list(61, 0),
		"8" = list(-63, 0)
	)

	use_muzzle_flash = TRUE
	angle_muzzleflash = FALSE
	muzzleflash_icon_state = "muzzle_flash"

	muzzle_flash_pos = list(
		"1" = list(16, 100),
		"2" = list(16, -110),
		"4" = list(140, 4),
		"8" = list(-105, 4)
	)

	scatter = 0
	fire_delay = 3 SECONDS
