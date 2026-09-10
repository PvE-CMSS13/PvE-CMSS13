// UPP Cannon for upp tank
/obj/item/hardpoint/primary/cannon/p17702
	name = "\improper P-177-02 93mm Cannon"
	desc = "A primary cannon for tanks that shoots 93mm high-explosive anti-tank rounds."
	desc_lore = " Developed in Vietnam as part of a multinational project including China, Cambodia and Laos. This 93mm smoothbore cannon is seen in use with several light UPP vehicles and defensive fortifications. Though it's most notable as the standard gun for the Cheetah 2A. A rugged gun capable of operating in the most inhospitable environments, be it deep-sea trenches, airless moons, alien bogs or impossible jungles."

	icon = 'icons/obj/vehicles/hardpoints/upptank.dmi'
	icon_state = "p17702"
	disp_icon = "upptank"
	disp_icon_state = "p17702"
	activation_sounds = list('sound/weapons/vehicles/cannon_fire1.ogg', 'sound/weapons/vehicles/cannon_fire2.ogg')

	health = 2000
	firing_arc = 60

	ammo = new /obj/item/ammo_magazine/hardpoint/p17702
	max_clips = 4

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
	fire_delay = 4 SECONDS

/obj/item/hardpoint/primary/cannon/p17702/solo
	allowed_seat = VEHICLE_DRIVER
