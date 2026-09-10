/obj/item/hardpoint/secondary/m56cupola
	name = "\improper M56 Cupola"
	desc = "A secondary remotely-controlled weapon system for tanks using a modified M56."

	icon_state = "m56_cupola"
	disp_icon = "tank"
	disp_icon_state = "m56cupola"
	activation_sounds = list('sound/weapons/gun_smartgun1.ogg', 'sound/weapons/gun_smartgun2.ogg', 'sound/weapons/gun_smartgun3.ogg', 'sound/weapons/gun_smartgun4.ogg')

	health = 2000
	firing_arc = 120

	ammo = new /obj/item/ammo_magazine/hardpoint/m56_cupola
	max_clips = 3

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

/obj/item/hardpoint/secondary/m56cupola/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

/obj/item/hardpoint/secondary/m56cupola/aev
	name = "\improper Pintle-Mounted M56 RWS"
	desc = "A remotely-controlled weapon system for armored engineering vehicles using a modified M56."
	disp_icon_state = "m56pintle"

	allowed_seat = VEHICLE_DRIVER

	firing_arc = 150

	ammo = new /obj/item/ammo_magazine/hardpoint/m56_cupola/aev
	max_clips = 5

	muzzle_flash_pos = list(
		"1" = list(8, -1),
		"2" = list(-7, -21),
		"4" = list(13, -10),
		"8" = list(-11, 1)
	)

	scatter = 2


/obj/item/hardpoint/secondary/m56cupola/twe_tank
	name = "\improper L98 10x28mm Hull General Purpose Machine Gun"
	desc = "Imperial implementation of a hull machine gun in a powered cupola. Compact with integrated liquid cooling, and armored hull proofed to small arms. However, its angle of horizontal traverse is limited to the front arc, and its vertical no more than 23 degrees. The mounted weapon is a heavy barreled variant of the regular 10x28mm pulse-action general purpose machine gun. It is built under license from Armat by Weyland Yutani."
	icon = 'icons/obj/vehicles/hardpoints/twe_tank.dmi'
	disp_icon_state = "mounted_cupola"
	icon_state = "mounted_cupola"

	allowed_seat = VEHICLE_DRIVER

	firing_arc = 75

	ammo = new /obj/item/ammo_magazine/hardpoint/m56_cupola/twe_tank
	max_clips = 5

	muzzle_flash_pos = list(
		"1" = list(8, -1),
		"2" = list(-8, -21),
		"4" = list(13, -10),
		"8" = list(-11, 1)
	)

	scatter = 2
