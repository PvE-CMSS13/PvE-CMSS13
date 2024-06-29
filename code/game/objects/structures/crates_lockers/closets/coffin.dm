/obj/structure/closet/coffin
	name = "coffin"
	desc = "It's a burial receptacle for the dearly departed."
	icon_state = "coffin"
	icon_closed = "coffin"
	icon_opened = "coffin_open"
	material = MATERIAL_WOOD
	anchored = FALSE
	layer = BETWEEN_OBJECT_ITEM_LAYER

/obj/structure/closet/coffin/update_icon()
	if(!opened)
		icon_state = icon_closed
	else
		icon_state = icon_opened

/obj/structure/closet/coffin/predator
	name = "strange coffin"
	desc = "It's a burial receptacle for the dearly departed. Seems to have weird markings on the side..?"
	icon_state = "pred_coffin"
	icon_closed = "pred_coffin"
	icon_opened = "pred_coffin_open"

	open_sound = 'sound/effects/stonedoor_openclose.ogg'
	close_sound = 'sound/effects/stonedoor_openclose.ogg'


/obj/structure/closet/coffin/woodencrate //Subtyped here so Req doesn't sell them
	name = "wooden crate"
	desc = "A wooden crate. Shoddily assembled, spacious and worthless on the ASRS"
	icon_state = "closed_woodcrate"
	icon_opened = "open_woodcrate"
	icon_closed = "closed_woodcrate"
	material = MATERIAL_WOOD
	store_mobs = FALSE
	climbable = TRUE
	throwpass = 1


/obj/structure/closet/coffin/woodencrate/armory_supplies
	name = "restricted supplies"
	desc = "This crate contains surplus firepower to be utilized in special field operations or if authroized by command staff."

/// This crate provides some special ammo options at random. Used in the Blackstone outpost.
#define POPULATE_RANDOM_AMMO(number, path) for(var/n = 1 to number) new path(src)
// Why is this a define? Practice, mostly.
#define POPULATE_RANDOM_AMMO_PICK(number, choices...) \
	var/path_choice; \
	for(var/n = 1 to number) {\
		path_choice = pick(choices); \
		new path_choice(src)};

/obj/structure/closet/coffin/woodencrate/armory_supplies/Initialize()
	. = ..()
	// Our possible options.
	var/limited_options[] = list("Buck", "Flamer", "Uranium")
	var/exclusive_options[] = list("Rocket", "Smartgun", "Sentry", "Shotgun")
	var/possible_options[] = list("AP", "Wall", "HEAP", "Incen") + limited_options + exclusive_options
	// Can only have one of these per crate, no more.

	var/selected
	for(var/i = 1 to 4) //4 loops. 0 to 3 also works, but I think this is easier to read.
		selected = pick(possible_options)
		switch(selected)
			// Non-exclusive options.
			if("AP")
				// AP rifle ammo.
				POPULATE_RANDOM_AMMO(4, /obj/item/ammo_magazine/rifle/m41aMK1/ap)
			if("Wall")
				// Wall-penetrating rifle ammo.
				POPULATE_RANDOM_AMMO(4, /obj/item/ammo_magazine/rifle/m41aMK1/penetrating)
			if("HEAP")
				// HEAP rifle ammo.
				POPULATE_RANDOM_AMMO(4, /obj/item/ammo_magazine/rifle/m41aMK1/heap)
			if("Incen")
				// Incendiary rifle ammo.
				POPULATE_RANDOM_AMMO(4, /obj/item/ammo_magazine/rifle/m41aMK1/incendiary)

			// Limited options.
			if("Buck")
				// Special type buck.
				POPULATE_RANDOM_AMMO(2, /obj/item/ammo_magazine/shotgun/buckshot/special)
				possible_options -= selected // Once per crate for each.
			if("Flamer")
				// Incinerator tanks.
				POPULATE_RANDOM_AMMO(2, /obj/item/ammo_magazine/flamer_tank)
				possible_options -= selected
			if("Uranium")
				// Depeleted uranium marksman rifle ammo.
				POPULATE_RANDOM_AMMO(3, /obj/item/ammo_magazine/rifle/m4ra/pve)
				possible_options -= selected

			// Exclusive options.
			if("Rocket")
				// Disposable rocket launcher.
				POPULATE_RANDOM_AMMO(1, /obj/item/prop/folded_anti_tank_sadar)
			if("Smartgun")
				// Smartgun drums. Individual chance.
				POPULATE_RANDOM_AMMO_PICK(2, 150; /obj/item/ammo_magazine/smartgun, 50; /obj/item/ammo_magazine/smartgun/holo_targetting)
			if("Sentry")
				// Sentry ammo, mostly for the Sapper.
				POPULATE_RANDOM_AMMO(3, /obj/item/ammo_magazine/sentry)
			if("Shotgun")
				// Slugs and flechette ammo. 100 rounds, for the B18 spec.
				POPULATE_RANDOM_AMMO_PICK(1, 100; /obj/item/ammo_box/magazine/shotgun/flechette, 200; /obj/item/ammo_box/magazine/shotgun, 70; /obj/item/ammo_box/magazine/shotgun/incendiary)

		if(selected in exclusive_options) possible_options -= exclusive_options
		else if (selected in limited_options) possible_options -= selected

#undef POPULATE_RANDOM_AMMO
#undef POPULATE_RANDOM_AMMO_PICK
