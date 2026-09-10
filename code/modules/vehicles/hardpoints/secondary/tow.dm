/obj/item/hardpoint/secondary/towlauncher
	name = "\improper TOW Launcher"
	desc = "A secondary weapon for tanks that shoots rockets. It loads multiple rockets at once."

	icon_state = "tow_launcher"
	disp_icon = "tank"
	disp_icon_state = "towlauncher"

	health = 2000
	firing_arc = 90

	ammo = new /obj/item/ammo_magazine/hardpoint/towlauncher
	max_clips = 2

	px_offsets = list(
		"1" = list(1, 10),
		"2" = list(-1, 5),
		"4" = list(0, 0),
		"8" = list(0, 18)
	)

	muzzle_flash_pos = list(
		"1" = list(8, -7),
		"2" = list(-8, -23),
		"4" = list(11, -8),
		"8" = list(-11, 10)
	)

	scatter = 2
	fire_delay = 8.0 SECONDS

/obj/item/hardpoint/secondary/towlauncher/set_bullet_traits()
	..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff),
		BULLET_TRAIT_ENTRY_ID("vehicles", /datum/element/bullet_trait_damage_boost, 350, GLOB.damage_boost_vehicles),
	))
