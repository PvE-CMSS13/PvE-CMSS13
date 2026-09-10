//------------SQUAD PREP VENDORS -------------------

//------------SQUAD PREP WEAPON RACKS---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep
	name = "\improper ColMarTech Automated Weapons Rack"
	desc = "An automated weapon rack hooked up to a big storage of standard-issue weapons."
	icon_state = "guns"
	req_access = list()
	req_one_access = list(ACCESS_MARINE_DATABASE, ACCESS_MARINE_PREP)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/populate_product_list(scale)
	listed_products = list(
		list("PRIMARY FIREARMS", -1, null, null),
		list("M49A Battle Rifle", floor(scale * 10), /obj/item/weapon/gun/rifle/m49a, VENDOR_ITEM_REGULAR),
		list("M37A2 Pump Shotgun", floor(scale * 15), /obj/item/weapon/gun/shotgun/pump, VENDOR_ITEM_REGULAR),
		list("M39 Submachine Gun", floor(scale * 30), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A Pulse Rifle MK2", floor(scale * 30), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("PRIMARY AMMUNITION", -1, null, null),
		list("Box of Flechette Shells (12g)", floor(scale * 4), /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("Box of Buckshot Shells (12g)", floor(scale * 10), /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("Box of Shotgun Slugs (12g)", floor(scale * 10), /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M49A Magazine (10x24mm)", floor(scale * 15), /obj/item/ammo_magazine/rifle/m49a, VENDOR_ITEM_REGULAR),
		list("M39 HV Magazine (10x20mm)", floor(scale * 25), /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A Magazine (10x24mm)", floor(scale * 25), /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("VP70 Combat Pistol", floor(scale * 25), /obj/item/weapon/gun/pistol/vp70, VENDOR_ITEM_REGULAR),
		list("M44 Combat Revolver", floor(scale * 25), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 Service Pistol", floor(scale * 25), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", floor(scale * 10), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("VP70 Magazine (9mm)", floor(scale * 25), /obj/item/ammo_magazine/pistol/vp70, VENDOR_ITEM_REGULAR),
		list("M44 Speedloader (.44)", floor(scale * 20), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3 Magazine (9mm)", floor(scale * 25), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", -1, null, null),
		list("M39 Folding Stock", floor(scale * 10), /obj/item/attachable/stock/smg/collapsible, VENDOR_ITEM_REGULAR),
		list("M41A Folding Stock", floor(scale * 10), /obj/item/attachable/stock/rifle/collapsible, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", floor(scale * 25), /obj/item/attachable/flashlight, VENDOR_ITEM_RECOMMENDED),
		list("Underbarrel Flashlight Grip", floor(scale * 10), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),
		list("Underslung Grenade Launcher", floor(scale * 25), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR), //They already get these as on-spawns, might as well formalize some spares.

		list("UTILITIES", -1, null, null),
		list("M13 Fighting Knife", floor(scale * 25), /obj/item/weapon/knife/marine, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", floor(scale * 10), /obj/item/storage/box/flare, VENDOR_ITEM_RECOMMENDED)
	)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial
	name = "\improper ColMarTech Automated Weapons Rack"
	desc = "An automated weapon rack hooked up to a big storage of standard-issue weapons."
	icon_state = "guns"
	req_access = list(ACCESS_TUTORIAL_LOCKED)
	req_one_access = list()
	hackable = FALSE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial/populate_product_list(scale)
	listed_products = list(
		list("PRIMARY FIREARMS", -1, null, null),
		list("M41A Pulse Rifle MK2", 1, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("PRIMARY AMMUNITION", -1, null, null),
		list("M41A Magazine (10x24mm)", 1, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_RECOMMENDED),
	)

/// Called if the tutorial mob somehow uses an entire magazine without the xeno dying
/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/tutorial/proc/load_ammo()
	listed_products = list(
		list("PRIMARY FIREARMS", -1, null, null),
		list("M41A Pulse Rifle MK2", 0, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("PRIMARY AMMUNITION", -1, null, null),
		list("M41A Magazine (10x24mm)", 99, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_RECOMMENDED),
	)

//------------SQUAD PREP UNIFORM VENDOR---------------


/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep
	name = "\improper ColMarTech Surplus Uniform Vendor"
	desc = "An automated supply rack hooked up to a small storage of standard marine uniforms."
	icon_state = "uscm_gear"
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list()
	listed_products = list()
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Marine Combat Boots", floor(scale * 15), /obj/item/clothing/shoes/marine/knife, VENDOR_ITEM_REGULAR),
		list("Marine Uniform, Camo Conforming", floor(scale * 15), /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR),
		list("Marine Uniform, Jungle BDU", floor(scale * 15), /obj/item/clothing/under/marine/standard, VENDOR_ITEM_REGULAR),
		list("Marine Combat Gloves", floor(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("Marine Radio Headset", floor(scale * 15), /obj/item/device/radio/headset/almayer/marine/solardevils, VENDOR_ITEM_REGULAR),
		list("M5 Pattern Camera Headset", floor(scale * 15), /obj/item/device/overwatch_camera, VENDOR_ITEM_REGULAR),
		list("Utility Cap, Jungle", floor(scale * 15), /obj/item/clothing/head/cmcap, VENDOR_ITEM_REGULAR),
		list("Utility Cap, Snow", floor(scale * 15), /obj/item/clothing/head/cmcap/snow, VENDOR_ITEM_REGULAR),
		list("Utility Cap, Desert", floor(scale * 15), /obj/item/clothing/head/cmcap/desert, VENDOR_ITEM_REGULAR),
		list("Operations Cap, Green", floor(scale * 15), /obj/item/clothing/head/cmcap/bridge, VENDOR_ITEM_REGULAR),
		list("Operations Cap, Tan", floor(scale * 15), /obj/item/clothing/head/cmcap/bridge/tan, VENDOR_ITEM_REGULAR),
		list("Boonie Hat, Jungle", floor(scale * 15), /obj/item/clothing/head/cmcap/boonie, VENDOR_ITEM_REGULAR),
		list("Boonie Hat, Desert", floor(scale * 15), /obj/item/clothing/head/cmcap/boonie/tan, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("M3 Pattern Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Magazine Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3/mag, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Shotgun Shell Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3/shotgun, VENDOR_ITEM_REGULAR),
		list("M3 Pattern M40 Webbing", 0.75, /obj/item/clothing/accessory/storage/webbing/m3/m40, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Small Pouch Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3/small, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", 4, /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Leg Pouch", 4, /obj/item/clothing/accessory/storage/smallpouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("M10 Pattern Marine Helmet", floor(scale * 15), /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR),
		list("Standard M3 Pattern Armor Set", round(scale * 15), /obj/item/storage/box/guncase/m3armor, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Chestpiece", round(scale * 10), /obj/item/clothing/suit/marine, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Ridged Chestpiece", round(scale * 10), /obj/item/clothing/suit/marine/lines, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Smooth Chestpiece", round(scale * 10), /obj/item/clothing/suit/marine/smooth, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Pauldrons", round(scale * 10), /obj/item/clothing/accessory/pads, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Lap Panel", round(scale * 10), /obj/item/clothing/accessory/pads/groin, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Greaves", round(scale * 15), /obj/item/clothing/accessory/pads/greaves, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Kneepads", round(scale * 15), /obj/item/clothing/accessory/pads/kneepads, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Vambraces", round(scale * 10), /obj/item/clothing/accessory/pads/bracers, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Gorget", round(scale * 15), /obj/item/clothing/accessory/pads/neckguard, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Lightweight IMP Backpack", floor(scale * 15), /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
		list("Technician Backpack", floor(scale * 15), /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("USCM Satchel", floor(scale * 15), /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR),
		list("USCM Technical Satchel", floor(scale * 15), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),

		list("RESTRICTED BACKPACKS", -1, null, null),
		list("Radio Telephone Backpack", 0.75, /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", floor(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", floor(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", floor(scale * 15), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Revolver Holster Rig", floor(scale * 15), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", floor(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", floor(scale * 15), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch", floor(scale * 15), /obj/item/storage/pouch/firstaid, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", floor(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", floor(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", floor(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", floor(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", floor(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", 1.25, /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", 1.25, /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch", 2.5, /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", floor(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", 1.25, /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", 1.25, /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),
		list("Incinerator Fuel Tank Pouch", 1.25, /obj/item/storage/pouch/flamertank, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", 1.25, /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("M5 Gas Mask", floor(scale * 15), /obj/item/clothing/mask/gas/military, VENDOR_ITEM_REGULAR),
		list("Tactical Wrap", floor(scale * 10), /obj/item/clothing/mask/rebreather/scarf/tacticalmask, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", floor(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("Ballistic goggles, sun-shaded", round(scale * 10), /obj/item/clothing/glasses/mgoggles/black, VENDOR_ITEM_REGULAR),
		list("Ballistic goggles, laser-shaded (brown)", round(scale * 10), /obj/item/clothing/glasses/mgoggles/orange, VENDOR_ITEM_REGULAR),
		list("Ballistic goggles, laser-shaded (green)", round(scale * 10), /obj/item/clothing/glasses/mgoggles/green, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Jungle Cover", round(scale * 10), /obj/item/prop/helmetgarb/camocover, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Snow Cover", round(scale * 10), /obj/item/prop/helmetgarb/camocover/snow, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Desert Cover", round(scale * 10), /obj/item/prop/helmetgarb/camocover/desert, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Netting", round(scale * 10), /obj/item/prop/helmetgarb/netting, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Rain Cover", round(scale * 10), /obj/item/prop/helmetgarb/raincover, VENDOR_ITEM_REGULAR),
		list("Solar Devils Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/devils, VENDOR_ITEM_REGULAR),
		list("USCM Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("LRRP Bedroll", round(scale * 15), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		list("Marine Issue Compass", round(scale * 15), /obj/item/prop/helmetgarb/compass, VENDOR_ITEM_REGULAR),
		)

/obj/item/storage/box/guncase/m3armor //forgive me, father
	name = "\improper M3 Pattern Armor case"
	desc = "A case containing the standard issue parts of the M3 Pattern Armor set of the USCMC. No parts sold separately."
	can_hold = list(/obj/item/clothing/suit/marine, /obj/item/clothing/accessory/pads/groin, /obj/item/clothing/accessory/pads, /obj/item/clothing/accessory/pads/greaves)
	storage_slots = 5

/obj/item/storage/box/guncase/m3armor/fill_preset_inventory()
	new /obj/item/clothing/suit/marine(src)
	new /obj/item/clothing/accessory/pads(src)
	new /obj/item/clothing/accessory/pads/groin(src)
	new /obj/item/clothing/accessory/pads/greaves(src)
	new /obj/item/clothing/accessory/pads/kneepads(src)
/obj/effect/essentials_set/m3
	spawned_gear_list = list(
		/obj/item/clothing/suit/marine,
		/obj/item/clothing/accessory/pads/greaves,
		/obj/item/clothing/accessory/pads/groin,
	)


/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/upp
	name = "\improper UnTech Surplus Uniform Vendor"
	desc = "An automated supply rack hooked up to a small storage of standard UPP uniforms."
	icon_state = "upp_gear"
	req_access = list(ACCESS_UPP_GENERAL)
	req_one_access = list()
	listed_products = list()
	hackable = TRUE
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/upp/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Military Combat Boots", round(scale * 15), /obj/item/clothing/shoes/marine/upp, VENDOR_ITEM_REGULAR),
		list("Naval Infantry Uniform", round(scale * 15), /obj/item/clothing/under/marine/veteran/UPP, VENDOR_ITEM_REGULAR),
		list("Combat Gloves", round(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("Radio Headset", round(scale * 15), /obj/item/device/radio/headset/almayer/marine/solardevils/upp, VENDOR_ITEM_REGULAR),
		list("1PN77M \"Periskop\" Camera Unit", floor(scale * 15), /obj/item/device/overwatch_camera/upp, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Type 90 Pattern Magazine Webbing", round(scale * 10), /obj/item/clothing/accessory/storage/webbing/m3/uppmags, VENDOR_ITEM_REGULAR),
		list("Type 78 Pattern Small Pouch Webbing", round(scale * 10), /obj/item/clothing/accessory/storage/webbing/m3/uppsmall, VENDOR_ITEM_REGULAR),
		list("Type 77 Pattern Pouch Webbing", round(scale * 10), /obj/item/clothing/accessory/storage/webbing/m3/uppgeneral, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 2))), /obj/item/clothing/accessory/storage/droppouch/upp, VENDOR_ITEM_REGULAR),
		list("Leg Pouch", 4, /obj/item/clothing/accessory/storage/smallpouch/upp, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("6b82 Combat Helmet (Green)", round(scale * 15), /obj/item/clothing/head/helmet/upp, VENDOR_ITEM_REGULAR),
		list("6b82 Combat Helmet (Brown)", round(scale * 15), /obj/item/clothing/head/helmet/upp/alt, VENDOR_ITEM_REGULAR),
		list("6B72-03 Pattern Vest", round(scale * 10), /obj/item/clothing/suit/marine/faction/UPP/light, VENDOR_ITEM_REGULAR),
		list("6B90 Pattern Cuirass", round(scale * 15), /obj/item/clothing/suit/marine/faction/UPP, VENDOR_ITEM_REGULAR),
		list("6B90 Crotch Guard", round(scale * 15), /obj/item/clothing/accessory/upppads/crotch, VENDOR_ITEM_REGULAR),
		list("6B90 Leg Guards", round(scale * 15), /obj/item/clothing/accessory/upppads/legs, VENDOR_ITEM_REGULAR),
		list("6B90 Arm Plates", round(scale * 15), /obj/item/clothing/accessory/upppads, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("UPP Satchel", round(scale * 15), /obj/item/storage/backpack/lightpack/upp, VENDOR_ITEM_REGULAR),

		list("RESTRICTED BACKPACKS", -1, null, null),
		list("Radio Telephone Backpack", round(max(1,(scale * 0.5))), /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("Type 41 Pattern Ammo Load Rig", round(scale * 15), /obj/item/storage/belt/marine/upp, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("Type 47 Pattern General Pistol Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/type47, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("Type 48 General Utility Pouch", round(scale * 15), /obj/item/storage/backpack/general_belt/upp, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch", floor(scale * 15), /obj/item/storage/pouch/firstaid, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", floor(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", floor(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", round(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", floor(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", floor(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", floor(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),
		list("Type 50 E-Tool Pouch", round(scale * 15), /obj/item/storage/pouch/etool, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", round(scale * 1.25), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", round(scale * 1.25), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch (Empty)", round(scale * 2.5), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", round(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", round(scale * 1.25), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", round(scale * 1.25), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("ShMB/4 Gas Mask", round(scale * 15), /obj/item/clothing/mask/gas/military/upp, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/upp, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/upp/prescription, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("UPP Naval Infantry Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/upp/naval, VENDOR_ITEM_REGULAR),
		list("UPPAC Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/upp, VENDOR_ITEM_REGULAR),
		list("Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		list("Canteen", round(scale * 20), /obj/item/reagent_container/food/drinks/flask/canteen, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/pmc
	name = "\improper PMC Uniform Vendor"
	icon_state = "pmc_gear"
	req_access = list(ACCESS_WY_GENERAL)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/pmc/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Combat Boots", round(scale * 10), /obj/item/clothing/shoes/marine/civilian/knife, VENDOR_ITEM_REGULAR),
		list("PMC Uniform", round(scale * 10), /obj/item/clothing/under/marine/veteran/pmc, VENDOR_ITEM_REGULAR),
		list("Combat Gloves", round(scale * 10), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("PMC Radio Headset", round(scale * 10), /obj/item/device/radio/headset/distress/pmc/platoon, VENDOR_ITEM_REGULAR),
		list("Mk3 TOCU Headcam", floor(scale * 10), /obj/item/device/overwatch_camera/pmc, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Black Webbing Vest", round(scale * 4), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Small Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/smallpouch/rmc, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),
		list("Waist Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster/waist, VENDOR_ITEM_REGULAR),

		list("ARMOR WEBBINGS", -1, null, null),
		list("Tactical Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing/m3/uppsmall/pmc, VENDOR_ITEM_REGULAR),
		list("Tactical Magazine Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc, VENDOR_ITEM_REGULAR),
		list("Tactical Grenade Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing/m3/m40/pmc, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("Tactical Helmet", round(scale * 10), /obj/item/clothing/head/helmet/marine/veteran/pmc, VENDOR_ITEM_REGULAR),
		list("Tactical Armor", round(scale * 10), /obj/item/clothing/suit/marine/veteran/pmc, VENDOR_ITEM_REGULAR),
		list("Tactical Light Armor", round(scale * 5), /obj/item/clothing/suit/marine/veteran/pmc/light, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Lightweight Combat Pack", round(scale * 5), /obj/item/storage/backpack/lightpack/five_slot, VENDOR_ITEM_REGULAR),
		list("UA Technical Satchel", floor(scale * 5), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),
		list("UA Technician Backpack", floor(scale * 5), /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("TWE Lightweight Rucksack", round(scale * 5), /obj/item/storage/backpack/rmc/light, VENDOR_ITEM_REGULAR),
		list("TWE Heavy-Duty Rucksack", round(scale * 5), /obj/item/storage/backpack/rmc/heavy, VENDOR_ITEM_REGULAR),

		list("RESTRICTED BACKPACKS", -1, null, null),
		list("Radio Telephone Backpack", round(max(1,(scale * 0.5))), /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", round(scale * 5), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("L70 Pattern Ammo Load Rig", round(scale * 5), /obj/item/storage/belt/marine/rmc, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 2), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M44 Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("L165 Pattern Pistol Gunbelt", round(scale * 5), /obj/item/storage/belt/gun/l905, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 2), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", round(scale * 5), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),
		list("L26 Pattern General Utility Belt", round(scale * 5), /obj/item/storage/backpack/general_belt/rmc, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch", floor(scale * 10), /obj/item/storage/pouch/firstaid, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", floor(scale * 10), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", floor(scale * 5), /obj/item/storage/pouch/magazine/large, VENDOR_ITEM_REGULAR),
		list("General Pouch", floor(scale * 5), /obj/item/storage/pouch/general/large, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", floor(scale * 5), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", floor(scale * 10), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", 1.25, /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", 1.25, /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch", 2.5, /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", 1.25, /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", 1.25, /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),
		list("Incinerator Fuel Tank Pouch", 1.25, /obj/item/storage/pouch/flamertank, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("Filtration Mask", round(scale * 10), /obj/item/clothing/mask/gas/pmc, VENDOR_ITEM_REGULAR),
		list("Balaclava", round(scale * 15), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("PMC Cap", round(scale * 15), /obj/item/clothing/head/cmcap/weyyu, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/pmc/suits
	name = "\improper PMC Bussinesswear Vendor"
	icon_state = "pmc_gear"

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/pmc/suits/populate_product_list(scale)
	listed_products = list(
		list("SUITS AND UNDERSHIRTS", 0, null, null, null),
		list("Black Suit Pants", 15, /obj/item/clothing/under/liaison_suit/black, VENDOR_ITEM_RECOMMENDED),
		list("Blue Suit Pants", 15, /obj/item/clothing/under/liaison_suit/blue, VENDOR_ITEM_REGULAR),
		list("Brown Suit Pants", 15, /obj/item/clothing/under/liaison_suit/brown, VENDOR_ITEM_REGULAR),
		list("White Suit Pants", 15, /obj/item/clothing/under/liaison_suit/corporate_formal, VENDOR_ITEM_REGULAR),
		list("Liaison's Tan Suit", 15, /obj/item/clothing/under/liaison_suit, VENDOR_ITEM_REGULAR),
		list("Liaison's Charcoal Suit", 15, /obj/item/clothing/under/liaison_suit/charcoal, VENDOR_ITEM_REGULAR),
		list("Liaison's White Suit", 15, /obj/item/clothing/under/liaison_suit/formal, VENDOR_ITEM_REGULAR),
		list("Liaison's Blue Blazer", 15, /obj/item/clothing/under/liaison_suit/blazer, VENDOR_ITEM_REGULAR),
		list("Liaison's Suspenders", 15, /obj/item/clothing/under/liaison_suit/suspenders, VENDOR_ITEM_REGULAR),
		list("Liaison's Skirt", 15, /obj/item/clothing/under/blackskirt, VENDOR_ITEM_REGULAR),
		list("Trainee's Uniform", 15, /obj/item/clothing/under/suit_jacket/trainee, VENDOR_ITEM_REGULAR),
		list("Country Club Outfit", 15, /obj/item/clothing/under/liaison_suit/ivy, VENDOR_ITEM_REGULAR),
		list("Orange Outfit", 15, /obj/item/clothing/under/liaison_suit/orange, VENDOR_ITEM_REGULAR),
		list("Corporate Casual", 15, /obj/item/clothing/under/liaison_suit/field, VENDOR_ITEM_REGULAR),
		list("Grey Workwear", 15, /obj/item/clothing/under/colonist/workwear, VENDOR_ITEM_REGULAR),
		list("Khaki Workwear", 15, /obj/item/clothing/under/colonist/workwear/khaki, VENDOR_ITEM_REGULAR),
		list("Pink Workwear", 15, /obj/item/clothing/under/colonist/workwear/pink, VENDOR_ITEM_REGULAR),
		list("Green Workwear", 15, /obj/item/clothing/under/colonist/workwear/green, VENDOR_ITEM_REGULAR),

		list("SUIT", 0, null, null, null),
		list("Black Suit Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/corporate/black, VENDOR_ITEM_RECOMMENDED),
		list("Khaki Suit Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/corporate, VENDOR_ITEM_REGULAR),
		list("Brown Suit Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/corporate/brown, VENDOR_ITEM_REGULAR),
		list("Blue Suit Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/corporate/blue, VENDOR_ITEM_REGULAR),
		list("Formal Suit Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/corporate/formal, VENDOR_ITEM_REGULAR),
		list("Grey Bomber Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/bomber/grey, VENDOR_ITEM_REGULAR),
		list("Red Bomber Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/bomber/red, VENDOR_ITEM_REGULAR),
		list("Khaki Bomber Jacket", 15, /obj/item/clothing/suit/storage/jacket/marine/bomber, VENDOR_ITEM_REGULAR),
		list("Brown Bomber Jacket", 15, /obj/item/clothing/suit/storage/bomber, VENDOR_ITEM_REGULAR),
		list("Black Bomber Jacket", 15, /obj/item/clothing/suit/storage/bomber/alt, VENDOR_ITEM_REGULAR),
		list("Liaison's Winter Coat", 15, /obj/item/clothing/suit/storage/snow_suit/liaison, VENDOR_ITEM_REGULAR),
		list("Labcoat", 15, /obj/item/clothing/suit/storage/labcoat, VENDOR_ITEM_REGULAR),
		list("Grey Vest", 15, /obj/item/clothing/suit/storage/jacket/marine/vest/grey, VENDOR_ITEM_REGULAR),
		list("Brown Vest", 15, /obj/item/clothing/suit/storage/jacket/marine/vest, VENDOR_ITEM_REGULAR),
		list("Tan Vest", 15, /obj/item/clothing/suit/storage/jacket/marine/vest/tan, VENDOR_ITEM_REGULAR),

		list("TIES", 0, null, null, null),
		list("Black Tie", 15, /obj/item/clothing/accessory/black, VENDOR_ITEM_RECOMMENDED),
		list("Red Tie", 15, /obj/item/clothing/accessory/red, VENDOR_ITEM_REGULAR),
		list("Purple Tie", 15, /obj/item/clothing/accessory/purple, VENDOR_ITEM_REGULAR),
		list("Blue Tie", 15, /obj/item/clothing/accessory/blue, VENDOR_ITEM_REGULAR),
		list("Green Tie", 15, /obj/item/clothing/accessory/green, VENDOR_ITEM_REGULAR),
		list("Gold Tie", 15, /obj/item/clothing/accessory/gold, VENDOR_ITEM_REGULAR),
		list("Special Tie", 15, /obj/item/clothing/accessory/horrible, VENDOR_ITEM_REGULAR),

		list("GLASSES", 0, null, null, null),
		list("BiMex Shades", 15, /obj/item/clothing/glasses/sunglasses/big, VENDOR_ITEM_RECOMMENDED),
		list("Aviator Shades", 15, /obj/item/clothing/glasses/sunglasses/aviator, VENDOR_ITEM_REGULAR),
		list("Sunglasses", 15, /obj/item/clothing/glasses/sunglasses, VENDOR_ITEM_REGULAR),
		list("Prescription Sunglasses", 15, /obj/item/clothing/glasses/sunglasses/prescription, VENDOR_ITEM_REGULAR),
		list("Prescription Glasses", 15, /obj/item/clothing/glasses/regular/hipster, VENDOR_ITEM_REGULAR),

		list("GLOVES", 0, null, null, null),
		list("Black Gloves", 15, /obj/item/clothing/gloves/black, VENDOR_ITEM_RECOMMENDED),
		list("Dress Gloves", 15, /obj/item/clothing/gloves/marine/dress, VENDOR_ITEM_REGULAR),

		list("SHOES", 0, null, null, null),
		list("Laceup Shoes, Black", 15, /obj/item/clothing/shoes/laceup, VENDOR_ITEM_RECOMMENDED),
		list("Laceup Shoes, Brown", 15, /obj/item/clothing/shoes/laceup/brown, VENDOR_ITEM_REGULAR),
		list("Sneakers, Black", 15, /obj/item/clothing/shoes/black, VENDOR_ITEM_REGULAR),
		list("Corporate Boots", 15, /obj/item/clothing/shoes/marine/civilian, VENDOR_ITEM_REGULAR),

		list("HATS", 0, null, null, null),
		list("Black Beret", 15, /obj/item/clothing/head/beret/cm/black/civilian, VENDOR_ITEM_REGULAR),
		list("White Beret", 15, /obj/item/clothing/head/beret/cm/white/civilian, VENDOR_ITEM_REGULAR),
		list("Fedora", 15, /obj/item/clothing/head/fedora, VENDOR_ITEM_REGULAR),

)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/forecon
	name = "\improper ColMarTech FORECON Uniform Vendor"
	icon_state = "forecon_gear"

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/forecon/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Marine Combat Boots", floor(scale * 15), /obj/item/clothing/shoes/marine/jungle/knife, VENDOR_ITEM_REGULAR),
		list("Marine Uniform", floor(scale * 15), /obj/item/clothing/under/marine/standard, VENDOR_ITEM_REGULAR),
		list("Marine Black Gloves", round(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("Marine Brown Gloves", round(scale * 15), /obj/item/clothing/gloves/marine/brown, VENDOR_ITEM_REGULAR),
		list("Marine Radio Headset", round(scale * 15), /obj/item/device/radio/headset/almayer/marine/solardevils/forecon, VENDOR_ITEM_REGULAR),
		list("M5 Pattern Camera Headset", floor(scale * 15), /obj/item/device/overwatch_camera, VENDOR_ITEM_REGULAR),
		list("Patrol Cap, Jungle BDU", floor(scale * 15), /obj/item/clothing/head/cmcap, VENDOR_ITEM_REGULAR),
		list("Patrol Cap, Snow", floor(scale * 15), /obj/item/clothing/head/cmcap/snow, VENDOR_ITEM_REGULAR),
		list("Patrol Cap, Desert", floor(scale * 15), /obj/item/clothing/head/cmcap/desert, VENDOR_ITEM_REGULAR),
		list("Patrol Cap, Khaki", round(scale * 5), /obj/item/clothing/head/cmcap/khaki, VENDOR_ITEM_REGULAR),
		list("Boonie Hat, Jungle", floor(scale * 15), /obj/item/clothing/head/cmcap/boonie, VENDOR_ITEM_REGULAR),
		list("Boonie Hat, Desert", floor(scale * 15), /obj/item/clothing/head/cmcap/boonie/tan, VENDOR_ITEM_REGULAR),
		list("Boonie Hat, Snow", floor(scale * 15), /obj/item/clothing/head/cmcap/boonie/snow, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("M3-R Pattern Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3/recon, VENDOR_ITEM_REGULAR),
		list("M3-R Pattern Shotgun Shell Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3/recon/shotgun, VENDOR_ITEM_REGULAR),
		list("M3-R Pattern M40 Webbing", 2, /obj/item/clothing/accessory/storage/webbing/m3/recon/m40, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", 3, /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("M3-R Pattern Recon Armor", round(scale * 10), /obj/item/clothing/suit/marine/rto/forecon, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Vambraces", round(scale * 10), /obj/item/clothing/accessory/pads/bracers/standard, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Greaves", round(scale * 10), /obj/item/clothing/accessory/pads/greaves/standard, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Kneepads", round(scale * 10), /obj/item/clothing/accessory/pads/kneepads/standard, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Lightweight IMP Backpack", round(scale * 15), /obj/item/storage/backpack/marine/standard, VENDOR_ITEM_REGULAR),
		list("USCM Satchel", round(scale * 15), /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR),
		list("USCM Technical Satchel", floor(scale * 15), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", round(scale * 15), /obj/item/storage/belt/marine/standard, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m4a3/standard, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Revolver Holster Rig", floor(scale * 15), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", round(scale * 15), /obj/item/storage/backpack/general_belt/standard, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch", floor(scale * 15), /obj/item/storage/pouch/firstaid, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", floor(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", floor(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", floor(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", floor(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", floor(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", 1.25, /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", 1.25, /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch", 2.5, /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", floor(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", 1.25, /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", 1.25, /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),
		list("Incinerator Fuel Tank Pouch", 1.25, /obj/item/storage/pouch/flamertank, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", 1.25, /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("M5 Gas Mask", floor(scale * 15), /obj/item/clothing/mask/gas/military, VENDOR_ITEM_REGULAR),
		list("Tactical Wrap", floor(scale * 10), /obj/item/clothing/mask/rebreather/scarf/tacticalmask, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", floor(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),

		list("ADDITIONAL CLOTHING", -1, null, null),
		list("Poncho, Green", round(scale * 10), /obj/item/clothing/accessory/poncho/green, VENDOR_ITEM_REGULAR),
		list("Poncho, Brown", round(scale * 10), /obj/item/clothing/accessory/poncho/brown, VENDOR_ITEM_REGULAR),
		list("Poncho, Black", round(scale * 10), /obj/item/clothing/accessory/poncho/black, VENDOR_ITEM_REGULAR),
		list("Bandana, Jungle", round(scale * 5), /obj/item/clothing/head/cmbandana, VENDOR_ITEM_REGULAR),
		list("Bandana, Desert", round(scale * 5), /obj/item/clothing/head/cmbandana/tan, VENDOR_ITEM_REGULAR),
		list("Beanie, Jungle", round(scale * 5), /obj/item/clothing/head/beanie/green, VENDOR_ITEM_REGULAR),
		list("Beanie, Urban", round(scale * 5), /obj/item/clothing/head/beanie/gray, VENDOR_ITEM_REGULAR),
		list("Beanie, Desert", round(scale * 5), /obj/item/clothing/head/beanie/tan, VENDOR_ITEM_REGULAR),
		list("Durag, Black", round(scale * 5), /obj/item/clothing/head/durag/black, VENDOR_ITEM_REGULAR),
		list("Durag, Camo Conforming", round(scale * 5), /obj/item/clothing/head/durag, VENDOR_ITEM_REGULAR),
		list("Expedition Cap, Jungle", round(scale * 5), /obj/item/clothing/head/cmcap/flap, VENDOR_ITEM_REGULAR),
		list("Expedition Cap, Desert", round(scale * 5), /obj/item/clothing/head/cmcap/flap/desert, VENDOR_ITEM_REGULAR),
		list("Expedition Cap, Snow", round(scale * 5), /obj/item/clothing/head/cmcap/flap/snow, VENDOR_ITEM_REGULAR),
		list("USCM Headset", round(scale * 5), /obj/item/clothing/head/headset/, VENDOR_ITEM_REGULAR),
		list("Headband, Brown", round(scale * 5), /obj/item/clothing/head/headband/brown, VENDOR_ITEM_REGULAR),
		list("Headband, Gray", round(scale * 5), /obj/item/clothing/head/headband/brown, VENDOR_ITEM_REGULAR),
		list("Headband, Red", round(scale * 5), /obj/item/clothing/head/headband/red, VENDOR_ITEM_REGULAR),
		list("Headband, Green", round(scale * 5), /obj/item/clothing/head/headband, VENDOR_ITEM_REGULAR),
		list("Headband, Tan", round(scale * 5), /obj/item/clothing/head/headband/tan, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("Ballistic goggles, sun-shaded", round(scale * 10), /obj/item/clothing/glasses/mgoggles/black, VENDOR_ITEM_REGULAR),
		list("Ballistic goggles, laser-shaded (brown)", round(scale * 10), /obj/item/clothing/glasses/mgoggles/orange, VENDOR_ITEM_REGULAR),
		list("Ballistic goggles, laser-shaded (green)", round(scale * 10), /obj/item/clothing/glasses/mgoggles/green, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("FORECON Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/forecon, VENDOR_ITEM_REGULAR),
		list("USCM Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("LRRP Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		list("Marine Issue Compass", round(scale * 20), /obj/item/prop/helmetgarb/compass, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/rmc
	name = "\improper WeyTech Surplus Uniform Vendor"
	desc = "An automated supply rack hooked up to a small storage of standard RMC uniforms."
	icon_state = "rmc_gear"
	req_access = list(ACCESS_TWE_COMMANDO)
	req_one_access = list()
	listed_products = list()
	hackable = TRUE
	vendor_theme = VENDOR_THEME_COMPANY

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/rmc/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Combat Boots", round(scale * 10), /obj/item/clothing/shoes/marine/rmc/knife, VENDOR_ITEM_REGULAR),
		list("Royal Marine Uniform", round(scale * 10), /obj/item/clothing/under/marine/veteran/royal_marine, VENDOR_ITEM_REGULAR),
		list("Combat Gloves", round(scale * 10), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("Mk16 Tactical Helmet", round(scale * 10), /obj/item/clothing/head/helmet/marine/veteran/pmc/gunner/rmc, VENDOR_ITEM_REGULAR),
		list("Tactical Beanie", round(scale * 10), /obj/item/clothing/head/beanie/royal_marine, VENDOR_ITEM_REGULAR),
		list("Radio Headset", round(scale * 10), /obj/item/device/radio/headset/almayer/marine/solardevils/rmc, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("82 Pattern Magazine Webbing", round(scale * 10), /obj/item/clothing/accessory/storage/webbing/m3/uppmags/rmc, VENDOR_ITEM_REGULAR),
		list("67 Pattern Webbing", round(scale * 10), /obj/item/clothing/accessory/storage/webbing/m3/uppsmall/rmc, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(scale * 4), /obj/item/clothing/accessory/storage/droppouch/rmc, VENDOR_ITEM_RECOMMENDED),
		list("Small Pouch", round(scale * 4), /obj/item/clothing/accessory/storage/smallpouch/rmc, VENDOR_ITEM_REGULAR),
		list("Waist Holster", round(scale * 2), /obj/item/clothing/accessory/storage/holster/waist, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("Kestrel Armoured Cuirass", round(scale * 10), /obj/item/clothing/suit/marine/veteran/royal_marine, VENDOR_ITEM_REGULAR),
		list("Kestrel Shoulder Pads", round(scale * 10), /obj/item/clothing/accessory/twepads, VENDOR_ITEM_REGULAR),
		list("Kestrel Leg Guards", round(scale * 10), /obj/item/clothing/accessory/twepads/legs, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Heavy-duty Backpack", round(scale * 5), /obj/item/storage/backpack/rmc/heavy, VENDOR_ITEM_REGULAR),
		list("Standard Backpack", round(scale * 10), /obj/item/storage/backpack/rmc/medium, VENDOR_ITEM_RECOMMENDED),
		list("Lightweight Backpack", round(scale * 5), /obj/item/storage/backpack/rmc/light, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("L70 Pattern Ammo Load Rig", round(scale * 10), /obj/item/storage/belt/marine/rmc, VENDOR_ITEM_RECOMMENDED),
		list("L26 Pattern General Utility Belt", round(scale * 10), /obj/item/storage/backpack/general_belt/rmc, VENDOR_ITEM_REGULAR),
		list("L165 Gunbelt", round(scale * 10), /obj/item/storage/belt/gun/l905, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First Responder Pouch", floor(scale * 5), /obj/item/storage/pouch/first_responder/rmc, VENDOR_ITEM_REGULAR), //Only the FRP so they can store the ATKs & ABKs
		list("Flare Pouch (Full)", floor(scale * 5), /obj/item/storage/pouch/flare/rmc/full, VENDOR_ITEM_REGULAR),
		list("Large Magazine Pouch", floor(scale * 5), /obj/item/storage/pouch/magazine/large, VENDOR_ITEM_REGULAR),
		list("Large General Pouch", floor(scale * 5), /obj/item/storage/pouch/general/large, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", floor(scale * 5), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", floor(scale * 5), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", floor(scale * 2), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", floor(scale * 2), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("L7 gasmask", round(scale * 15), /obj/item/clothing/mask/gas/pmc/royal_marine, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/upp, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/upp/prescription, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("Royal Marine Commando Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/royal_marines, VENDOR_ITEM_REGULAR),
		list("TWE Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/twe, VENDOR_ITEM_REGULAR),
		list("Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		list("Canteen", round(scale * 20), /obj/item/reagent_container/food/drinks/flask/canteen, VENDOR_ITEM_REGULAR),
		)


//--------------SQUAD SPECIFIC VERSIONS--------------
//Those vendors aren't being used i will make them us the main vendor a parent to avoid having four different
// list with just the headset changed.

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/alpha
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_ALPHA, ACCESS_MARINE_DATABASE, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/bravo
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_BRAVO, ACCESS_MARINE_DATABASE, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/bravo/populate_product_list(scale)
	..()
	listed_products += list(
		list("HEADSET", -1, null, null),
		list("Marine Bravo Radio Headset", 10, /obj/item/device/radio/headset/almayer/marine/bravo, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/charlie
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DATABASE, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/charlie/populate_product_list(scale)
	..()
	listed_products += list(
		list("HEADSET", -1, null, null),
		list("Marine Charlie Radio Headset", 10, /obj/item/device/radio/headset/almayer/marine/charlie, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/delta
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_DELTA, ACCESS_MARINE_DATABASE, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/delta/populate_product_list(scale)
	..()
	listed_products += list(
		list("HEADSET", -1, null, null),
		list("Marine Delta Radio Headset", 10, /obj/item/device/radio/headset/almayer/marine/delta, VENDOR_ITEM_REGULAR),
		)

//--------------SQUAD MUNITION VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad
	name = "\improper ColMarTech Automated Munition Squad Vendor"
	desc = "An automated supply rack hooked up to a small storage of various ammunition types. Can be accessed by any Marine Rifleman."
	req_access = list(ACCESS_MARINE_ALPHA)
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

	vend_x_offset = 2

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state


/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad/populate_product_list(scale)
	listed_products = list(
		list("ARMOR-PIERCING AMMUNITION", -1, null, null),
		list("M49A AP Magazine (10x24mm)", 3.5, /obj/item/ammo_magazine/rifle/m49a/ap, VENDOR_ITEM_REGULAR),
		list("M39 AP Magazine (10x20mm)", floor(scale * 3), /obj/item/ammo_magazine/smg/m39/ap, VENDOR_ITEM_REGULAR),
		list("M41A AP Magazine (10x24mm)", floor(scale * 3), /obj/item/ammo_magazine/rifle/ap, VENDOR_ITEM_REGULAR),

		list("EXTENDED AMMUNITION", -1, null, null),
		list("M39 Extended Magazine (10x20mm)", 1.8, /obj/item/ammo_magazine/smg/m39/extended, VENDOR_ITEM_REGULAR),
		list("M41A Extended Magazine (10x24mm)", 1.9, /obj/item/ammo_magazine/rifle/extended, VENDOR_ITEM_REGULAR),

		list("SPECIAL AMMUNITION", -1, null, null),
		list("M56 Smartgun Drum", 1, /obj/item/ammo_magazine/smartgun, VENDOR_ITEM_REGULAR),
		list("M44 Heavy Speed Loader (.44)", floor(scale * 2), /obj/item/ammo_magazine/revolver/heavy, VENDOR_ITEM_REGULAR),
		list("M44 Marksman Speed Loader (.44)", floor(scale * 2), /obj/item/ammo_magazine/revolver/marksman, VENDOR_ITEM_REGULAR),

		list("RESTRICTED FIREARM AMMUNITION", -1, null, null),
		list("VP78 Magazine", floor(scale * 5), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("SU-6 Smartpistol Magazine (.45)", floor(scale * 5), /obj/item/ammo_magazine/pistol/smart, VENDOR_ITEM_REGULAR),
		list("M240 Incinerator Tank", floor(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR),
		list("M56D Drum Magazine", floor(scale * 2), /obj/item/ammo_magazine/m56d, VENDOR_ITEM_REGULAR),
		list("M2C Box Magazine", floor(scale * 2), /obj/item/ammo_magazine/m2c, VENDOR_ITEM_REGULAR),
		list("HIRR Baton Slugs", floor(scale * 6), /obj/item/explosive/grenade/slug/baton, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S Star Shell", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/starshell, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S Hornet Shell", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/hornet_shell, VENDOR_ITEM_REGULAR),
		)

//--------------SQUAD ARMAMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad
	name = "\improper ColMarTech Automated Utilities Squad Vendor"
	desc = "An automated supply rack hooked up to a small storage of various utilities and tools. Can be accessed by any Marine Rifleman."
	req_access = list()
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO, ACCESS_MARINE_PREP)
	hackable = TRUE

	vend_x_offset = 2
	vend_y_offset = 1
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("MRE", floor(scale * 5), /obj/item/storage/box/mre, VENDOR_ITEM_REGULAR),
		list("MRE Box", floor(scale * 1), /obj/item/ammo_box/magazine/misc/mre, VENDOR_ITEM_REGULAR),

		list("MEDICAL", -1, null, null),
		list("Gauze", round(scale * 15), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("Ointment", round(scale * 15), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("Splints", round(scale * 15), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),
		list("Emergency Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/emergency, VENDOR_ITEM_REGULAR),
		list("Bicaridine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, VENDOR_ITEM_REGULAR),
		list("Kelotane Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless, VENDOR_ITEM_REGULAR),
		list("Tricordrazine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, VENDOR_ITEM_REGULAR),
		list("Tramadol Injector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, VENDOR_ITEM_REGULAR),

		list("TOOLS", -1, null, null),
		list("Entrenching Tool (ET)", round(scale * 2), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("Screwdriver", round(scale * 5), /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),
		list("Wirecutters", round(scale * 5), /obj/item/tool/wirecutters, VENDOR_ITEM_REGULAR),
		list("Crowbar", round(scale * 5), /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("Wrench", round(scale * 5), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("Multitool", round(scale * 1), /obj/item/device/multitool, VENDOR_ITEM_REGULAR),
		list("Welding Tool", round(scale * 1), /obj/item/tool/weldingtool, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", -1, null, null),
		list("Plastic Explosives", round(scale * 2), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("Breaching Charge", round(scale * 2), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("FLARE AND LIGHT", -1, null, null),
		list("Combat Flashlight", round(scale * 5), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("Box of Flashlight", round(scale * 1), /obj/item/ammo_box/magazine/misc/flashlight, VENDOR_ITEM_REGULAR),
		list("Box of Flares", round(scale * 1), /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/flare, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/flare/signal, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("VP70 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/vp70/unloaded, VENDOR_ITEM_REGULAR),
		list("M4A3 Service Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/m4a3/unloaded, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", round(scale * 1), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Tactical Monocular", round(scale * 2), /obj/item/device/binoculars/range/monocular, VENDOR_ITEM_REGULAR),
		list("AN/PSQ-55 Sentry Console", round(scale * 1), /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit/advanced, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("Two-point Sling", round(scale * 5), /obj/item/attachable/sling, VENDOR_ITEM_REGULAR),
		list("M13 Fighting Knife", round(scale * 25), /obj/item/weapon/knife/marine, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/upp
	name = "\improper UnTech Automated Utilities Squad Vendor"
	desc = "An automated supply rack hooked up to a small storage of various utilities and tools. Can be accessed by any UPP Rifleman."
	req_access = list()
	req_one_access = list(ACCESS_UPP_GENERAL)
	hackable = TRUE

	vend_x_offset = 2
	vend_y_offset = 1
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/upp/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("Individual Meal Ration", round(scale * 15), /obj/item/storage/box/mre/upp, VENDOR_ITEM_REGULAR),
		list("IMR Box", floor(scale * 1), /obj/item/ammo_box/magazine/misc/mre/upp, VENDOR_ITEM_REGULAR),

		list("MEDICAL", -1, null, null),
		list("Gauze", round(scale * 15), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("Ointment", round(scale * 15), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("Splints", round(scale * 15), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),
		list("Emergency Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/emergency, VENDOR_ITEM_REGULAR),
		list("Bicaridine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, VENDOR_ITEM_REGULAR),
		list("Kelotane Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless, VENDOR_ITEM_REGULAR),
		list("Tricordrazine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, VENDOR_ITEM_REGULAR),
		list("Tramadol Injector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, VENDOR_ITEM_REGULAR),

		list("TOOLS", -1, null, null),
		list("Type 50 Entrenching Tool", round(scale * 2), /obj/item/tool/shovel/etool/upp/folded, VENDOR_ITEM_REGULAR),
		list("Screwdriver", round(scale * 5), /obj/item/tool/screwdriver/tactical, VENDOR_ITEM_REGULAR),
		list("Wirecutters", round(scale * 5), /obj/item/tool/wirecutters/tactical, VENDOR_ITEM_REGULAR),
		list("Crowbar", round(scale * 5), /obj/item/tool/crowbar/tactical, VENDOR_ITEM_REGULAR),
		list("Wrench", round(scale * 5), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("Multitool", round(scale * 1), /obj/item/device/multitool/upp, VENDOR_ITEM_REGULAR),
		list("Welding Tool", round(scale * 1), /obj/item/tool/weldingtool, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", -1, null, null),
		list("Plastic Explosives", round(scale * 2), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("Breaching Charge", round(scale * 2), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("FLARE AND LIGHT", -1, null, null),
		list("Box of R52 Flare Packs", round(scale * 1), /obj/item/ammo_box/magazine/misc/flares/upp, VENDOR_ITEM_REGULAR),
		list("R52 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/flare/upp, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("NP92 Standard Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/np92/unloaded, VENDOR_ITEM_REGULAR),
		list("Type 73 Service Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/t73/unloaded, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/arnold/weak, VENDOR_ITEM_REGULAR),
		list("Laser Designator", round(scale * 2), /obj/item/device/binoculars/range/designator/upp, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit/advanced, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("Type 80 Bayonet", round(scale * 5), /obj/item/attachable/bayonet/upp, null, VENDOR_ITEM_REGULAR),
		list("Type 83 Grenade Launcher", 3, /obj/item/attachable/attached_gun/grenade/type71, null, VENDOR_ITEM_REGULAR),

		list("CLOTHING", -1, null, null),
		list("Balaclava", round(scale * 5), /obj/item/clothing/mask/rebreather/scarf/tan, VENDOR_ITEM_REGULAR),
		list("Balaclava", round(scale * 5), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("Scarf", round(scale * 5), /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan, VENDOR_ITEM_REGULAR),
		list("Scarf", round(scale * 5), /obj/item/clothing/mask/rebreather/scarf/tacticalmask/black, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/forecon/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("Extended Patrol MRE", round(scale * 5), /obj/item/storage/box/mre/fsr, VENDOR_ITEM_REGULAR),
		list("MRE Box", round(scale * 1), /obj/item/ammo_box/magazine/misc/mre/fsr, VENDOR_ITEM_REGULAR),

		list("MEDICAL", -1, null, null),
		list("Gauze", round(scale * 15), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("Ointment", round(scale * 15), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("Splints", round(scale * 15), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),
		list("Emergency Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/emergency, VENDOR_ITEM_REGULAR),
		list("Bicaridine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, VENDOR_ITEM_REGULAR),
		list("Kelotane Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless, VENDOR_ITEM_REGULAR),
		list("Tricordrazine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, VENDOR_ITEM_REGULAR),
		list("Tramadol Injector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, VENDOR_ITEM_REGULAR),

		list("TOOLS", -1, null, null),
		list("Entrenching Tool (ET)", round(scale * 2), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("Screwdriver", round(scale * 5), /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),
		list("Wirecutters", round(scale * 5), /obj/item/tool/wirecutters, VENDOR_ITEM_REGULAR),
		list("Crowbar", round(scale * 5), /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("Wrench", round(scale * 5), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("Multitool", round(scale * 1), /obj/item/device/multitool, VENDOR_ITEM_REGULAR),
		list("Welding Tool", round(scale * 1), /obj/item/tool/weldingtool, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", -1, null, null),
		list("Plastic Explosives", round(scale * 2), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("Breaching Charge", round(scale * 2), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("FLARE AND LIGHT", -1, null, null),
		list("Combat Flashlight", round(scale * 5), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("Box of Flashlights", round(scale * 1), /obj/item/ammo_box/magazine/misc/flashlight, VENDOR_ITEM_REGULAR),
		list("Box of Flares", round(scale * 1), /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/flare, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/flare/signal, VENDOR_ITEM_REGULAR),
		list("M72A2 HIPF Starshell Grenade Packet", round(scale * 3), /obj/item/storage/box/packet/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null), //forecon loves their pistols
		list("M48A4 Service Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/m1911/socom, VENDOR_ITEM_REGULAR),
		list("VP70 Combat Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/vp70, VENDOR_ITEM_REGULAR),
		list("M44 Combat Revolver", round(scale * 5), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 Service Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("VP78 pistol", round(scale * 5), /obj/item/weapon/gun/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", round(scale * 3), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("M1911 Magazine (.45)", round(scale * 20), /obj/item/ammo_magazine/pistol/m1911, VENDOR_ITEM_REGULAR),
		list("VP70 Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/vp70, VENDOR_ITEM_REGULAR),
		list("M44 Speedloader (.44)", round(scale * 20), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3 Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("VP78 magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Binoculars", round(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit/advanced, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("Two-point Sling", round(scale * 5), /obj/item/attachable/sling, VENDOR_ITEM_REGULAR),
		list("M13 Fighting Knife", round(scale * 5), /obj/item/weapon/knife/marine, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/pmc
	name = "\improper PMC Automated Utilities Squad Vendor"
	desc = "An automated supply rack hooked up to a small storage of various utilities and tools. Can be accessed by any PMC Operator."
	req_access = list(ACCESS_WY_GENERAL)
	req_one_access = list()

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/pmc/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("Premium MRE", round(scale * 5), /obj/item/storage/box/mre/pmc, VENDOR_ITEM_REGULAR),
		list("MRE Box", round(scale * 1), /obj/item/ammo_box/magazine/misc/mre/pmc, VENDOR_ITEM_REGULAR),

		list("MEDICAL", -1, null, null),
		list("Gauze", round(scale * 15), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("Ointment", round(scale * 15), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("Splints", round(scale * 15), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),
		list("Emergency Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/emergency, VENDOR_ITEM_REGULAR),
		list("Bicaridine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, VENDOR_ITEM_REGULAR),
		list("Kelotane Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/kelotane/skillless, VENDOR_ITEM_REGULAR),
		list("Tricordrazine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, VENDOR_ITEM_REGULAR),
		list("Tramadol Injector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless, VENDOR_ITEM_REGULAR),

		list("TOOLS", -1, null, null),
		list("Entrenching Tool (ET)", round(scale * 2), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("Screwdriver", round(scale * 5), /obj/item/tool/screwdriver, VENDOR_ITEM_REGULAR),
		list("Wirecutters", round(scale * 5), /obj/item/tool/wirecutters, VENDOR_ITEM_REGULAR),
		list("Crowbar", round(scale * 5), /obj/item/tool/crowbar, VENDOR_ITEM_REGULAR),
		list("Wrench", round(scale * 5), /obj/item/tool/wrench, VENDOR_ITEM_REGULAR),
		list("Multitool", round(scale * 1), /obj/item/device/multitool, VENDOR_ITEM_REGULAR),
		list("Welding Tool", round(scale * 1), /obj/item/tool/weldingtool, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", -1, null, null),
		list("Plastic Explosives", round(scale * 2), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("Breaching Charge", round(scale * 2), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("FLARE AND LIGHT", -1, null, null),
		list("Combat Flashlight", round(scale * 5), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("Box of Flashlight", round(scale * 1), /obj/item/ammo_box/magazine/misc/flashlight, VENDOR_ITEM_REGULAR),
		list("Box of Flares", round(scale * 1), /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/flare, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/flare/signal, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("VP70 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/vp70/unloaded, VENDOR_ITEM_REGULAR),
		list("VP78 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/vp78/unloaded, VENDOR_ITEM_REGULAR),
		list("ES4 Electrostatic Pistol", round(scale * 3), /obj/item/weapon/gun/pistol/es4/unloaded, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("VP70 Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/vp70, VENDOR_ITEM_REGULAR),
		list("VP78 magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("ES4 Stun Magazine (9mm)", round(scale * 10), /obj/item/ammo_magazine/pistol/es4, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Laser Designator", round(scale * 2), /obj/item/device/binoculars/range/designator, VENDOR_ITEM_REGULAR),
		list("AN/PSQ-55 Sentry Console", round(scale * 1), /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit/advanced, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("Two-point Sling", round(scale * 5), /obj/item/attachable/sling, VENDOR_ITEM_REGULAR),
		list("Fairbairn-Sykes Fighting Knife", round(scale * 25), /obj/item/weapon/knife/marine/sas, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/rmc
	name = "\improper WeyTech Automated Utilities Section Vendor"
	desc = "An automated supply rack hooked up to a small storage of various utilities and tools. Can be accessed by any Royal Marine."
	req_access = list(ACCESS_TWE_COMMANDO)
	req_one_access = list()

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/rmc/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("Operation Ration Pack", round(scale * 5), /obj/item/storage/box/mre/twe, VENDOR_ITEM_REGULAR),
		list("Operation Ration Pack Box", round(scale * 1), /obj/item/ammo_box/magazine/misc/mre/twe, VENDOR_ITEM_REGULAR),

//Everyone has medical skill, so no need for the skillless injectors.
//ATK & ABK's as standard so the little shits don't empty the medics vendor too, because I KNOW they will otherwise
//Gauze & ointment are in there for handling low-damage wounds if they choose to pack them. 5-brute bleeding wounds, my beloathed.
//Don't be gentle with them. >:3
		list("MEDICAL", -1, null, null),
		list("Gauze", round(scale * 10), /obj/item/stack/medical/bruise_pack, VENDOR_ITEM_REGULAR),
		list("Ointment", round(scale * 10), /obj/item/stack/medical/ointment, VENDOR_ITEM_REGULAR),
		list("Trauma Treatment Pack", round(scale * 15), /obj/item/stack/medical/advanced/bruise_pack, VENDOR_ITEM_REGULAR),
		list("Burn Treatment Pack", round(scale * 15), /obj/item/stack/medical/advanced/ointment, VENDOR_ITEM_REGULAR),
		list("Splints", round(scale * 15), /obj/item/stack/medical/splint, VENDOR_ITEM_REGULAR),
		list("Emergency Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/emergency, VENDOR_ITEM_REGULAR),
		list("Bicaridine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/bicaridine, VENDOR_ITEM_REGULAR),
		list("Kelotane Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/kelotane, VENDOR_ITEM_REGULAR),
		list("Tricordrazine Autoinjector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tricord, VENDOR_ITEM_REGULAR),
		list("Tramadol Injector", round(scale * 15), /obj/item/reagent_container/hypospray/autoinjector/tramadol, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", -1, null, null),
		list("Plastic Explosives", round(scale * 1), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("Breaching Charge", round(scale * 1), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("FLARE AND LIGHT", -1, null, null),
		list("Combat Flashlight", round(scale * 10), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("L96 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/flare/rmc, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("VP70 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/vp70/unloaded, VENDOR_ITEM_REGULAR),
		list("L54A2 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/l54/unloaded, VENDOR_ITEM_REGULAR),
		list("L165A1 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/vp78/rmc/unloaded, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Fire Extinguisher (Portable)", round(scale * 2), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("2155 Pattern Entrenching Tool", round(scale * 2), /obj/item/tool/shovel/etool/rmc/folded, VENDOR_ITEM_REGULAR),
		list("Binoculars", round(scale * 2), /obj/item/device/binoculars/civ, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("Two-point Sling", round(scale * 2), /obj/item/attachable/sling, VENDOR_ITEM_REGULAR),
		list("Fairbairn-Sykes Fighting Knife", round(scale * 25), /obj/item/weapon/knife/marine/sas, VENDOR_ITEM_REGULAR),
		)


//--------------SQUAD ATTACHMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/attachments/squad
	name = "\improper Armat Systems Squad Attachments Vendor"
	desc = "An automated supply rack hooked up to a small storage of weapons attachments. Can be accessed by any Marine Rifleman."
	req_access = list(ACCESS_MARINE_ALPHA)
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_STOCK_DYNAMIC

	vend_y_offset = 1

/obj/structure/machinery/cm_vending/sorted/attachments/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/attachments/squad/populate_product_list(scale)
	listed_products = list(
		list("BARREL", -1, null, null),
		list("Extended Barrel", 2.5, /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("Recoil Compensator", 2.5, /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("Suppressor", 2.5, /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),

		list("RAIL", -1, null, null),
		list("B8 Smart-Scope", 1.5, /obj/item/attachable/scope/mini_iff, VENDOR_ITEM_REGULAR),
		list("Magnetic Harness", 4, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("S4 2x Telescopic Mini-Scope", 2, /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 Red-Dot Sight", 3, /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S6 Reflex Sight", 3, /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4x Telescopic Scope", 2, /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("UNDERBARREL", -1, null, null),
		list("Angled Grip", 2.5, /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("Bipod", 2.5, /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("Burst Fire Assembly", 1.5, /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("Gyroscopic Stabilizer", 1.5, /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 3, /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("Mini Flamethrower", 1.5, /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 Flamer Nozzle", 1.5, /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 Underbarrel Shotgun", 1.5, /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("Underbarrel Extinguisher", 1.5, /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 3, /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),

		list("STOCK", -1, null, null),
		list("M37 Wooden Stock", 1.5, /obj/item/attachable/stock/shotgun, VENDOR_ITEM_REGULAR),
		list("M39 Arm Brace", 1.5, /obj/item/attachable/stock/smg/collapsible/brace, VENDOR_ITEM_REGULAR),
		list("M39 Stock", 1.5, /obj/item/attachable/stock/smg, VENDOR_ITEM_REGULAR),
		list("M41A Solid Stock", 1.5, /obj/item/attachable/stock/rifle, VENDOR_ITEM_REGULAR),
		list("M44 Magnum Sharpshooter Stock", 1.5, /obj/item/attachable/stock/revolver, VENDOR_ITEM_REGULAR)
		)

//------------ESSENTIAL SETS---------------
/obj/effect/essentials_set/random/uscm_light_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/marine/light/lines,
		/obj/item/clothing/suit/marine/light/smooth,
	)

/obj/effect/essentials_set/random/uscm_heavy_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/marine/heavy/lines,
		/obj/item/clothing/suit/marine/heavy/smooth,
	)

//------------MARINE CIVILIAN CLOTHING---------------

GLOBAL_LIST_INIT(cm_vending_clothing_marine_snowflake, list(
	list("SHIRTS AND UNIFORMS", 0, null, null, null),
	list("White T-Shirt and Brown Jeans", 12, /obj/item/clothing/under/tshirt/w_br, null, VENDOR_ITEM_REGULAR),
	list("Gray T-Shirt and Blue Jeans", 12, /obj/item/clothing/under/tshirt/gray_blu, null, VENDOR_ITEM_REGULAR),
	list("Red T-Shirt and Black Jeans", 12, /obj/item/clothing/under/tshirt/r_bla, null, VENDOR_ITEM_REGULAR),
	list("Frontier Jumpsuit", 12, /obj/item/clothing/under/rank/synthetic/frontier, null, VENDOR_ITEM_REGULAR),
	list("UA Grey Jumpsuit", 12, /obj/item/clothing/under/colonist/ua_civvies, null, VENDOR_ITEM_REGULAR),
	list("UA Brown Jumpsuit", 12, /obj/item/clothing/under/colonist/wy_davisone, null, VENDOR_ITEM_REGULAR),
	list("UA Green Utility Uniform", 12, /obj/item/clothing/under/rank/synthetic/utility, null, VENDOR_ITEM_REGULAR),
	list("Grey Utilities", 12, /obj/item/clothing/under/rank/synthetic/utility/yellow, null, VENDOR_ITEM_REGULAR),
	list("Grey Utilities and Blue Jeans", 12, /obj/item/clothing/under/rank/synthetic/utility/red, null, VENDOR_ITEM_REGULAR),
	list("Blue Utilities and Brown Jeans", 12, /obj/item/clothing/under/rank/synthetic/utility/blue, null, VENDOR_ITEM_REGULAR),
	list("White Service Uniform", 12, /obj/item/clothing/under/colonist/white_service, null, VENDOR_ITEM_REGULAR),
	list("Steward Clothes", 12, /obj/item/clothing/under/colonist/wy_joliet_shopsteward, null, VENDOR_ITEM_REGULAR),
	list("Red Dress Skirt", 12, /obj/item/clothing/under/blackskirt, null, VENDOR_ITEM_REGULAR),
	list("Blue Suit Pants", 12, /obj/item/clothing/under/liaison_suit/blue, null, VENDOR_ITEM_REGULAR),
	list("Brown Suit Pants", 12, /obj/item/clothing/under/liaison_suit/brown, null, VENDOR_ITEM_REGULAR),
	list("White Suit Pants", 12, /obj/item/clothing/under/liaison_suit/corporate_formal, null, VENDOR_ITEM_REGULAR),
	list("Working Joe Uniform", 36, /obj/item/clothing/under/rank/synthetic/joe, null, VENDOR_ITEM_REGULAR),

	list("GLASSES", 0, null, null, null),
	list("Marine RPG Glasses", 12, /obj/item/clothing/glasses/regular, null, VENDOR_ITEM_REGULAR),
	list("Sunglasses", 12, /obj/item/clothing/glasses/sunglasses, null, VENDOR_ITEM_REGULAR),

	list("SHOES", 0, null, null, null),
	list("Boots", 12, /obj/item/clothing/shoes/marine, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Black", 12, /obj/item/clothing/shoes/black, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Blue", 12, /obj/item/clothing/shoes/blue, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Brown", 12, /obj/item/clothing/shoes/brown, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Green", 12, /obj/item/clothing/shoes/green, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Purple", 12, /obj/item/clothing/shoes/purple, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Red", 12, /obj/item/clothing/shoes/red, null, VENDOR_ITEM_REGULAR),
	list("Shoes, White", 12, /obj/item/clothing/shoes/white, null, VENDOR_ITEM_REGULAR),
	list("Shoes, Yellow", 12, /obj/item/clothing/shoes/yellow, null, VENDOR_ITEM_REGULAR),

	list("HEADWEAR", 0, null, null, null),
	list("Beanie", 12, /obj/item/clothing/head/beanie, null, VENDOR_ITEM_REGULAR),
	list("Beret, Engineering", 12, /obj/item/clothing/head/beret/eng, null, VENDOR_ITEM_REGULAR),
	list("Beret, Purple", 12, /obj/item/clothing/head/beret/jan, null, VENDOR_ITEM_REGULAR),
	list("Beret, Red", 12, /obj/item/clothing/head/beret/cm/red, null, VENDOR_ITEM_REGULAR),
	list("Beret, Standard", 12, /obj/item/clothing/head/beret/cm, null, VENDOR_ITEM_REGULAR),
	list("Beret, Tan", 12, /obj/item/clothing/head/beret/cm/tan, null, VENDOR_ITEM_REGULAR),
	list("Beret, Green", 12, /obj/item/clothing/head/beret/cm, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
	list("Beret, Black", 12, /obj/item/clothing/head/beret/cm/black, null, VENDOR_ITEM_REGULAR),
	list("Beret, White", 12, /obj/item/clothing/head/beret/cm/white, null, VENDOR_ITEM_REGULAR),
	list("Ushanka", 12, /obj/item/clothing/head/ushanka, null, VENDOR_ITEM_REGULAR),
	list("Cap", 12, /obj/item/clothing/head/cmcap, null, VENDOR_ITEM_REGULAR),
	list("Fedora", 12, /obj/item/clothing/head/fedora, null, VENDOR_ITEM_REGULAR),

	list("SUIT", 0, null, null, null),
	list("Bomber Jacket, Brown", 12, /obj/item/clothing/suit/storage/bomber, null, VENDOR_ITEM_REGULAR),
	list("Bomber Jacket, Black", 12, /obj/item/clothing/suit/storage/bomber/alt, null, VENDOR_ITEM_REGULAR),
	list("External Webbing", 12, /obj/item/clothing/suit/storage/webbing, null, VENDOR_ITEM_REGULAR),
	list("Utility Vest", 12, /obj/item/clothing/suit/storage/utility_vest, null, VENDOR_ITEM_REGULAR),
	list("Hazard Vest(Orange)", 12, /obj/item/clothing/suit/storage/hazardvest, null, VENDOR_ITEM_REGULAR),
	list("Hazard Vest(Blue)", 12, /obj/item/clothing/suit/storage/hazardvest/blue, null, VENDOR_ITEM_REGULAR),
	list("Hazard Vest(Yellow)", 12, /obj/item/clothing/suit/storage/hazardvest/yellow, null, VENDOR_ITEM_REGULAR),
	list("Hazard Vest(Black)", 12, /obj/item/clothing/suit/storage/hazardvest/black, null, VENDOR_ITEM_REGULAR),
	list("USCM Service Jacket", 12, /obj/item/clothing/suit/storage/jacket/marine/service, null, VENDOR_ITEM_REGULAR),
	list("Windbreaker, Brown", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_brown, null, VENDOR_ITEM_REGULAR),
	list("Windbreaker, Grey", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_gray, null, VENDOR_ITEM_REGULAR),
	list("Windbreaker, Green", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_green, null, VENDOR_ITEM_REGULAR),
	list("Windbreaker, First Responder", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_fr, null, VENDOR_ITEM_REGULAR),
	list("Windbreaker, Exploration", 12, /obj/item/clothing/suit/storage/windbreaker/windbreaker_covenant, null, VENDOR_ITEM_REGULAR),
	list("Black Suit Jacket", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/black, null, VENDOR_ITEM_REGULAR),
	list("Brown Suit Jacket", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/brown, null, VENDOR_ITEM_REGULAR),
	list("Blue Suit Jacket", 12, /obj/item/clothing/suit/storage/jacket/marine/corporate/blue, null, VENDOR_ITEM_REGULAR),
	list("Brown Vest", 12, /obj/item/clothing/suit/storage/jacket/marine/vest, null, VENDOR_ITEM_REGULAR),
	list("Tan Vest", 12, /obj/item/clothing/suit/storage/jacket/marine/vest/tan, null, VENDOR_ITEM_REGULAR),
	list("Grey Vest", 12, /obj/item/clothing/suit/storage/jacket/marine/vest/grey, null, VENDOR_ITEM_REGULAR),

	list("BACKPACK", 0, null, null, null),
	list("Backpack, Industrial", 12, /obj/item/storage/backpack/industrial, null, VENDOR_ITEM_REGULAR),
	list("Satchel, Leather", 12, /obj/item/storage/backpack/satchel, null, VENDOR_ITEM_REGULAR),
	list("Satchel, Medical", 12, /obj/item/storage/backpack/satchel/med, null, VENDOR_ITEM_REGULAR),

	list("OTHER", 0, null, null, null),
	list("Red Armband", 6, /obj/item/clothing/accessory/armband, null, VENDOR_ITEM_REGULAR),
	list("Purple Armband", 6, /obj/item/clothing/accessory/armband/science, null, VENDOR_ITEM_REGULAR),
	list("Yellow Armband", 6, /obj/item/clothing/accessory/armband/engine, null, VENDOR_ITEM_REGULAR),
	list("Green Armband", 6, /obj/item/clothing/accessory/armband/medgreen, null, VENDOR_ITEM_REGULAR),
	list("Dress Gloves", 6, /obj/item/clothing/gloves/marine/dress, null, VENDOR_ITEM_REGULAR),

))

/obj/structure/machinery/cm_vending/clothing/marine/snowflake
	name = "\improper Personal Civilian Clothing Storage Unit"
	desc = "The vendor where all of your personal civilian clothing is stored while you are on-duty."
	icon_state = "snowflake"
	show_points = TRUE
	use_snowflake_points = TRUE
	vendor_theme = VENDOR_THEME_COMPANY
	req_access = list()
	vendor_role = list()

	vend_delay = 1 SECONDS

/obj/structure/machinery/cm_vending/clothing/marine/snowflake/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_marine_snowflake
