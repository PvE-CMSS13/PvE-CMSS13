/obj/item/storage/belt/shotgun/full/mou53/fill_preset_inventory()
	var/shell_type
	for(var/i = 1 to storage_slots) //Picks ammo for MOU, which cannot shoot buck; slightly randomized with a preference for flachette.
		shell_type = pick(75; /obj/item/ammo_magazine/handful/shotgun/slug, 50; /obj/item/ammo_magazine/handful/shotgun/incendiary, 150; /obj/item/ammo_magazine/handful/shotgun/flechette)
		new shell_type(src)

/obj/item/storage/belt/utility/full/tactical/fill_preset_inventory()
	new /obj/item/tool/screwdriver/tactical(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool/largetank(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/tool/wirecutters/tactical(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))
	new /obj/item/device/multitool(src)

/obj/item/storage/belt/marine/m39/heap/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/ammo_magazine/smg/m39/heap (src)
