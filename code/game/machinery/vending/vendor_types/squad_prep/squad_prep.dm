//------------SQUAD PREP VENDORS -------------------

//------------SQUAD PREP WEAPON RACKS---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep
	name = "\improper ColMarTech Automated Weapons Rack"
	desc = "An automated weapon rack hooked up to a big storage of standard-issue weapons."
	icon_state = "guns"
	req_access = list()
	req_one_access = list(ACCESS_MARINE_DATABASE, ACCESS_MARINE_PREP, ACCESS_MARINE_CARGO)
	hackable = TRUE
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/populate_product_list(scale)
	listed_products = list(
		list("PRIMARY FIREARMS", -1, null, null),
		list("M4RA Battle Rifle", round(scale * 10), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M37A2 Pump Shotgun", round(scale * 15), /obj/item/weapon/gun/shotgun/pump, VENDOR_ITEM_REGULAR),
		list("M39 Submachine Gun", round(scale * 30), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A Pulse Rifle MK2", round(scale * 30), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("PRIMARY AMMUNITION", -1, null, null),
		list("Box of Flechette Shells (12g)", round(scale * 4), /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("Box of Buckshot Shells (12g)", round(scale * 10), /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("Box of Shotgun Slugs (12g)", round(scale * 10), /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("M4RA Magazine (10x24mm)", round(scale * 15), /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("M39 HV Magazine (10x20mm)", round(scale * 25), /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A Magazine (10x24mm)", round(scale * 25), /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("88 Mod 4 Combat Pistol", round(scale * 25), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 Combat Revolver", round(scale * 25), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 Service Pistol", round(scale * 25), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", round(scale * 10), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("88M4 AP Magazine (9mm)", round(scale * 25), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 Speedloader (.44)", round(scale * 20), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3 Magazine (9mm)", round(scale * 25), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", -1, null, null),
		list("M39 Folding Stock", round(scale * 10), /obj/item/attachable/stock/smg/collapsible, VENDOR_ITEM_REGULAR),
		list("M41A Folding Stock", round(scale * 10), /obj/item/attachable/stock/rifle/collapsible, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 25), /obj/item/attachable/flashlight, VENDOR_ITEM_RECOMMENDED),
		list("Underbarrel Flashlight Grip", round(scale * 10), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),
		list("Underslung Grenade Launcher", round(scale * 25), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR), //They already get these as on-spawns, might as well formalize some spares.

		list("UTILITIES", -1, null, null),
		list("M5 Bayonet", round(scale * 25), /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	)

//------------SQUAD PREP UNIFORM VENDOR---------------


/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep
	name = "\improper ColMarTech Surplus Uniform Vendor"
	desc = "An automated supply rack hooked up to a small storage of standard marine uniforms."
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list()
	listed_products = list()
	hackable = TRUE

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Marine Combat Boots", round(scale * 15), /obj/item/clothing/shoes/marine/knife, VENDOR_ITEM_REGULAR),
		list("USCM Uniform", round(scale * 15), /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR),
		list("Marine Combat Gloves", round(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("M10 Pattern Marine Helmet", round(scale * 15), /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR),
		list("Marine Radio Headset", round(scale * 15), /obj/item/device/radio/headset/almayer/marine, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Brown Webbing Vest", round(scale * 1.25), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("Black Webbing Vest", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("M3 Pattern Carrier Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/carrier, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Padded Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/padded, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Padless Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/padless, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Ridged Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/padless_lines, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Skull Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/skull, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Smooth Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/smooth, VENDOR_ITEM_REGULAR),
		list("M3-EOD Pattern Heavy Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/heavy, VENDOR_ITEM_REGULAR),
		list("M3-L Pattern Light Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/light, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("USCM Technician Backpack", round(scale * 15), /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("Technician Chestrig", round(scale * 15), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),
		list("Shotgun Scabbard", round(scale * 5), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),

		list("RESTRICTED BACKPACKS", -1, null, null),
		list("Radio Telephone Backpack", round(max(1,(scale * 0.5))), /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", round(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M44 Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", round(scale * 15), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Injectors)", round(scale * 15), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", round(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", round(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", round(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", round(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", round(scale * 1.25), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", round(scale * 1.25), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch (Empty)", round(scale * 2.5), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", round(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", round(scale * 1.25), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", round(scale * 1.25), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("Gas Mask", round(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", round(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("Rebreather", round(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("Marine RPG glasses", round(scale * 10), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5 Integrated Gas Mask", round(scale * 10), /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Netting", round(scale * 10), /obj/item/prop/helmetgarb/netting, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Rain Cover", round(scale * 10), /obj/item/prop/helmetgarb/raincover, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("USCM Flair", round(scale * 15), /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("USCM Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("USCM The First Patch", round(scale * 15), /obj/item/clothing/accessory/patch/thefirst, VENDOR_ITEM_REGULAR),
		list("Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
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
		list("UPP Uniform", round(scale * 15), /obj/item/clothing/under/marine/veteran/UPP, VENDOR_ITEM_REGULAR),
		list("Combat Gloves", round(scale * 15), /obj/item/clothing/gloves/marine/veteran/upp, VENDOR_ITEM_REGULAR),
		list("UM4 Pattern Helmet", round(scale * 15), /obj/item/clothing/head/helmet/marine/veteran/UPP, VENDOR_ITEM_REGULAR),
		list("Radio Headset", round(scale * 15), /obj/item/device/radio/headset/distress/UPP, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Brown Webbing Vest", round(scale * 1.25), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("Black Webbing Vest", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("UM5 Personal Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/faction/UPP, VENDOR_ITEM_REGULAR),
		list("UL6 Personal Light Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/faction/UPP/support, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Lightweight IMP Backpack", round(scale * 15), /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
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
		list("First-Aid Pouch (Splints, Gauze, Ointment)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Injectors)", round(scale * 15), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", round(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", round(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", round(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", round(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", round(scale * 1.25), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", round(scale * 1.25), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch (Empty)", round(scale * 2.5), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", round(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", round(scale * 1.25), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", round(scale * 1.25), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("Gas Mask", round(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", round(scale * 10), /obj/item/clothing/mask/rebreather/scarf/tan, VENDOR_ITEM_REGULAR),
		list("Rebreather", round(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("Marine RPG glasses", round(scale * 10), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5 Integrated Gas Mask", round(scale * 10), /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Netting", round(scale * 10), /obj/item/prop/helmetgarb/netting, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Rain Cover", round(scale * 10), /obj/item/prop/helmetgarb/raincover, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("UPP Airborne Reconnaissance Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/upp/platoon, VENDOR_ITEM_REGULAR),
		list("UPPA Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/upp, VENDOR_ITEM_REGULAR),
		list("Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/forecon
	name = "\improper ColMarTech FORECON Uniform Vendor"

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/forecon/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Marine Combat Boots", round(scale * 15), /obj/item/clothing/shoes/marine/jungle/knife, VENDOR_ITEM_REGULAR),
		list("USCM Uniform", round(scale * 15), /obj/item/clothing/under/marine/standard, VENDOR_ITEM_REGULAR),
		list("Marine Black Gloves", round(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("Marine Brown Gloves", round(scale * 15), /obj/item/clothing/gloves/marine/brown, VENDOR_ITEM_REGULAR),
		list("Marine Radio Headset", round(scale * 15), /obj/item/device/radio/headset/almayer/sof/survivor_forecon, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Brown Webbing Vest", round(scale * 1.25), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("Black Webbing Vest", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("M3-R Pattern Recon Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/rto/forecon, VENDOR_ITEM_REGULAR),
		list("M3-L Pattern Light Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/light/standard, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Lightweight IMP Backpack", round(scale * 15), /obj/item/storage/backpack/marine/standard, VENDOR_ITEM_REGULAR),
		list("USCM Satchel", round(scale * 15), /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR),
		list("Shotgun Scabbard", round(scale * 5), /obj/item/storage/large_holster/m37/standard, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", round(scale * 15), /obj/item/storage/belt/marine/standard, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m4a3/standard, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M44 Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m44/standard, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", round(scale * 15), /obj/item/storage/backpack/general_belt/standard, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Injectors)", round(scale * 15), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", round(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", round(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", round(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", round(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", round(scale * 1.25), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", round(scale * 1.25), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch (Empty)", round(scale * 2.5), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", round(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", round(scale * 1.25), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", round(scale * 1.25), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("Gas Mask", round(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", round(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("Rebreather", round(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("Marine RPG glasses", round(scale * 10), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Netting", round(scale * 10), /obj/item/prop/helmetgarb/netting, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Rain Cover", round(scale * 10), /obj/item/prop/helmetgarb/raincover, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("USCM Flair", round(scale * 15), /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("FORECON Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch/forecon, VENDOR_ITEM_REGULAR),
		list("USCM Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
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
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Marine Combat Boots", round(scale * 15), /obj/item/clothing/shoes/marine/knife, VENDOR_ITEM_REGULAR),
		list("USCM Uniform", round(scale * 15), /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR),
		list("Marine Combat Gloves", round(scale * 15), /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR),
		list("M10 Pattern Marine Helmet", round(scale * 15), /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR),
		list("Marine Radio Headset", round(scale * 15), /obj/item/device/radio/headset/almayer/marine/bravo, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Brown Webbing Vest", round(scale * 1.25), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("Black Webbing Vest", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("M3 Pattern Carrier Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/carrier, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Padded Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/padded, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Padless Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/padless, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Ridged Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/padless_lines, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Skull Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/skull, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Smooth Marine Armor", round(scale * 15), /obj/item/clothing/suit/storage/marine/smooth, VENDOR_ITEM_REGULAR),
		list("M3-EOD Pattern Heavy Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/heavy, VENDOR_ITEM_REGULAR),
		list("M3-L Pattern Light Armor", round(scale * 10), /obj/item/clothing/suit/storage/marine/light, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("USCM Technician Backpack", round(scale * 15), /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR),
		list("Technician Chestrig", round(scale * 15), /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR),
		list("Shotgun Scabbard", round(scale * 5), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),

		list("RESTRICTED BACKPACKS", -1, null, null),
		list("Radio Telephone Backpack", round(max(1,(scale * 0.5))), /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", round(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M44 Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", round(scale * 15), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Injectors)", round(scale * 15), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", round(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", round(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", round(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", round(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", round(scale * 1.25), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", round(scale * 1.25), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch (Empty)", round(scale * 2.5), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", round(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", round(scale * 1.25), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", round(scale * 1.25), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("Gas Mask", round(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", round(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("Rebreather", round(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("Marine RPG glasses", round(scale * 10), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5 Integrated Gas Mask", round(scale * 10), /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Netting", round(scale * 10), /obj/item/prop/helmetgarb/netting, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Rain Cover", round(scale * 10), /obj/item/prop/helmetgarb/raincover, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		list("USCM Flair", round(scale * 15), /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("USCM Shoulder Patch", round(scale * 15), /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("USCM The First Patch", round(scale * 15), /obj/item/clothing/accessory/patch/thefirst, VENDOR_ITEM_REGULAR),
		list("Bedroll", round(scale * 20), /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/charlie
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DATABASE, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/charlie/populate_product_list(scale)
	listed_products += list(
		list("HEADSET", -1, null, null),
		list("Marine Charlie Radio Headset", 10, /obj/item/device/radio/headset/almayer/marine/charlie, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/delta
	req_access = list(ACCESS_MARINE_PREP)
	req_one_access = list(ACCESS_MARINE_DELTA, ACCESS_MARINE_DATABASE, ACCESS_MARINE_CARGO)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/delta/populate_product_list(scale)
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
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

	vend_x_offset = 2

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state


/obj/structure/machinery/cm_vending/sorted/cargo_ammo/squad/populate_product_list(scale)
	listed_products = list(
		list("ARMOR-PIERCING AMMUNITION", -1, null, null),
		list("M4RA AP Magazine (10x24mm)", round(scale * 3.5), /obj/item/ammo_magazine/rifle/m4ra/ap, VENDOR_ITEM_REGULAR),
		list("M39 AP Magazine (10x20mm)", round(scale * 3), /obj/item/ammo_magazine/smg/m39/ap, VENDOR_ITEM_REGULAR),
		list("M41A AP Magazine (10x24mm)", round(scale * 3), /obj/item/ammo_magazine/rifle/ap, VENDOR_ITEM_REGULAR),

		list("EXTENDED AMMUNITION", -1, null, null),
		list("M39 Extended Magazine (10x20mm)", round(scale * 1.8), /obj/item/ammo_magazine/smg/m39/extended, VENDOR_ITEM_REGULAR),
		list("M41A Extended Magazine (10x24mm)", round(scale * 1.9), /obj/item/ammo_magazine/rifle/extended, VENDOR_ITEM_REGULAR),

		list("SPECIAL AMMUNITION", -1, null, null),
		list("M56 Smartgun Drum", 1, /obj/item/ammo_magazine/smartgun, VENDOR_ITEM_REGULAR),
		list("M44 Heavy Speed Loader (.44)", round(scale * 2), /obj/item/ammo_magazine/revolver/heavy, VENDOR_ITEM_REGULAR),
		list("M44 Marksman Speed Loader (.44)", round(scale * 2), /obj/item/ammo_magazine/revolver/marksman, VENDOR_ITEM_REGULAR),

		list("RESTRICTED FIREARM AMMUNITION", -1, null, null),
		list("VP78 Magazine", round(scale * 5), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("SU-6 Smartpistol Magazine (.45)", round(scale * 5), /obj/item/ammo_magazine/pistol/smart, VENDOR_ITEM_REGULAR),
		list("M240 Incinerator Tank", round(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR),
		list("M56D Drum Magazine", round(scale * 2), /obj/item/ammo_magazine/m56d, VENDOR_ITEM_REGULAR),
		list("M2C Box Magazine", round(scale * 2), /obj/item/ammo_magazine/m2c, VENDOR_ITEM_REGULAR),
		list("HIRR Baton Slugs", round(scale * 6), /obj/item/explosive/grenade/slug/baton, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S Star Shell", round(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/starshell, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S Hornet Shell", round(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/hornet_shell, VENDOR_ITEM_REGULAR),
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
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("MRE", round(scale * 5), /obj/item/storage/box/MRE, VENDOR_ITEM_REGULAR),
		list("MRE Box", round(scale * 1), /obj/item/ammo_box/magazine/misc/mre, VENDOR_ITEM_REGULAR),

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
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("88 Mod 4 Combat Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 Combat Revolver", round(scale * 2), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 Service Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("VP78 pistol", round(scale * 2), /obj/item/weapon/gun/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", round(scale * 1), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("88M4 AP Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 Speedloader (.44)", round(scale * 20), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3 Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("VP78 magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Binoculars", round(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("AN/PSQ-55 Sentry Console", round(scale * 1), /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
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
		list("MRE", round(scale * 15), /obj/item/reagent_container/food/snacks/upp, VENDOR_ITEM_REGULAR),

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
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null),
		list("NP92 Standard Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/np92, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 Combat Revolver", round(scale * 2), /obj/item/weapon/gun/revolver/upp, VENDOR_ITEM_REGULAR),
		list("Type 73 Service Pistol", round(scale * 2), /obj/item/weapon/gun/pistol/t73, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", round(scale * 1), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("NP92 Magazine (9x18mm Makarov)", round(scale * 20), /obj/item/ammo_magazine/pistol/np92, VENDOR_ITEM_REGULAR),
		list("ZHNK-72 Speedloader (7.62x38mmR)", round(scale * 20), /obj/item/ammo_magazine/revolver/upp, VENDOR_ITEM_REGULAR),
		list("Type 73 Magazine (7.62x25mm Tokarev)", round(scale * 20), /obj/item/ammo_magazine/pistol/t73, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Binoculars", round(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),

		list("CLOTHING", -1, null, null),
		list("Cap", round(scale * 5), /obj/item/clothing/head/uppcap, VENDOR_ITEM_REGULAR),
		list("Cap (tan)", round(scale * 5), /obj/item/clothing/head/uppcap/civi, VENDOR_ITEM_REGULAR),
		list("Ushanka", round(scale * 5), /obj/item/clothing/head/uppcap/ushanka, VENDOR_ITEM_REGULAR),
		list("Ushanka (tan)", round(scale * 5), /obj/item/clothing/head/uppcap/ushanka/civi, VENDOR_ITEM_REGULAR),
		list("Beret", round(scale * 5), /obj/item/clothing/head/uppcap/beret, VENDOR_ITEM_REGULAR),
		list("Balaclava", round(scale * 5), /obj/item/clothing/mask/rebreather/scarf/tan, VENDOR_ITEM_REGULAR),
		list("Scarf", round(scale * 5), /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan, VENDOR_ITEM_REGULAR),
		list("Neck warmer", round(scale * 5), /obj/item/clothing/mask/tornscarf/green, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/forecon/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("MRE", round(scale * 5), /obj/item/storage/box/MRE, VENDOR_ITEM_REGULAR),
		list("MRE Box", round(scale * 1), /obj/item/ammo_box/magazine/misc/mre, VENDOR_ITEM_REGULAR),

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
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null), //forecon loves their pistols
		list("M48A4 Service Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/m1911/socom, VENDOR_ITEM_REGULAR),
		list("88 Mod 4 Combat Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 Combat Revolver", round(scale * 5), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("M4A3 Service Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("VP78 pistol", round(scale * 5), /obj/item/weapon/gun/pistol/vp78, VENDOR_ITEM_REGULAR),
		list("M82F Flare Gun", round(scale * 3), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("M1911 Magazine (.45)", round(scale * 20), /obj/item/ammo_magazine/pistol/m1911, VENDOR_ITEM_REGULAR),
		list("88M4 AP Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("M44 Speedloader (.44)", round(scale * 20), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("M4A3 Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("VP78 magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Binoculars", round(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),

		list("CLOTHING", -1, null, null),
		list("Poncho (green)", round(scale * 10), /obj/item/clothing/accessory/poncho/green, VENDOR_ITEM_REGULAR),
		list("Poncho (brown)", round(scale * 10), /obj/item/clothing/accessory/poncho/brown, VENDOR_ITEM_REGULAR),
		list("Poncho (black)", round(scale * 10), /obj/item/clothing/accessory/poncho/black, VENDOR_ITEM_REGULAR),
		list("Durag (black)", round(scale * 5), /obj/item/clothing/head/durag/black, VENDOR_ITEM_REGULAR),
		list("Durag (camo)", round(scale * 5), /obj/item/clothing/head/durag/black, VENDOR_ITEM_REGULAR),
		list("Bandana (green)", round(scale * 5), /obj/item/clothing/head/cmbandana, VENDOR_ITEM_REGULAR),
		list("Bandana (tan)", round(scale * 5), /obj/item/clothing/head/cmbandana/tan, VENDOR_ITEM_REGULAR),
		list("Beanie (green)", round(scale * 5), /obj/item/clothing/head/beanie/green, VENDOR_ITEM_REGULAR),
		list("Beanie (gray)", round(scale * 5), /obj/item/clothing/head/beanie/gray, VENDOR_ITEM_REGULAR),
		list("Beanie (tan)", round(scale * 5), /obj/item/clothing/head/beanie/tan, VENDOR_ITEM_REGULAR),
		list("Boonie Hat (olive)", round(scale * 5), /obj/item/clothing/head/cmcap/boonie, VENDOR_ITEM_REGULAR),
		list("Boonie Hat (tan)", round(scale * 5), /obj/item/clothing/head/cmcap/boonie/tan, VENDOR_ITEM_REGULAR),
		list("Cap", round(scale * 5), /obj/item/clothing/head/cmcap, VENDOR_ITEM_REGULAR),
		list("Headband (brown)", round(scale * 5), /obj/item/clothing/head/headband/brown, VENDOR_ITEM_REGULAR),
		list("Headband (gray)", round(scale * 5), /obj/item/clothing/head/headband/brown, VENDOR_ITEM_REGULAR),
		list("Headband (red)", round(scale * 5), /obj/item/clothing/head/headband/red, VENDOR_ITEM_REGULAR),
		list("Headband (green)", round(scale * 5), /obj/item/clothing/head/headband, VENDOR_ITEM_REGULAR),
		list("Headband (tan)", round(scale * 5), /obj/item/clothing/head/headband/tan, VENDOR_ITEM_REGULAR),
		)

//--------------SQUAD ATTACHMENTS VENDOR--------------

/obj/structure/machinery/cm_vending/sorted/attachments/squad
	name = "\improper Armat Systems Squad Attachments Vendor"
	desc = "An automated supply rack hooked up to a small storage of weapons attachments. Can be accessed by any Marine Rifleman."
	req_access = list(ACCESS_MARINE_ALPHA)
	req_one_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_RO)
	hackable = TRUE

	vend_y_offset = 1

/obj/structure/machinery/cm_vending/sorted/attachments/squad/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/attachments/squad/populate_product_list(scale)
	listed_products = list(
		list("BARREL", -1, null, null),
		list("Extended Barrel", round(scale * 2.5), /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("Recoil Compensator", round(scale * 2.5), /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("Suppressor", round(scale * 2.5), /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),

		list("RAIL", -1, null, null),
		list("B8 Smart-Scope", round(scale * 1.5), /obj/item/attachable/scope/mini_iff, VENDOR_ITEM_REGULAR),
		list("Magnetic Harness", round(scale * 4), /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("S4 2x Telescopic Mini-Scope", round(scale * 2), /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 Red-Dot Sight", round(scale * 3), /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S6 Reflex Sight", round(scale * 3), /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4x Telescopic Scope", round(scale * 2), /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("UNDERBARREL", -1, null, null),
		list("Angled Grip", round(scale * 2.5), /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("Bipod", round(scale * 2.5), /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("Burst Fire Assembly", round(scale * 1.5), /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("Gyroscopic Stabilizer", round(scale * 1.5), /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("Laser Sight", round(scale * 3), /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("Mini Flamethrower", round(scale * 1.5), /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 Flamer Nozzle", round(scale * 1.5), /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 Underbarrel Shotgun", round(scale * 1.5), /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("Underbarrel Extinguisher", round(scale * 1.5), /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", round(scale * 3), /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),

		list("STOCK", -1, null, null),
		list("M37 Wooden Stock", round(scale * 1.5), /obj/item/attachable/stock/shotgun, VENDOR_ITEM_REGULAR),
		list("M39 Arm Brace", round(scale * 1.5), /obj/item/attachable/stock/smg/collapsible/brace, VENDOR_ITEM_REGULAR),
		list("M39 Stock", round(scale * 1.5), /obj/item/attachable/stock/smg, VENDOR_ITEM_REGULAR),
		list("M41A Solid Stock", round(scale * 1.5), /obj/item/attachable/stock/rifle, VENDOR_ITEM_REGULAR),
		list("M44 Magnum Sharpshooter Stock", round(scale * 1.5), /obj/item/attachable/stock/revolver, VENDOR_ITEM_REGULAR)
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/vaipo
	name = "\improper Vanguard Arrow Automated Utilities Squad Vendor"
	desc = "An automated supply rack hooked up to a small storage of various utilities and tools. Can be accessed by any VAIPO Contractor."
	req_access = list()
	req_one_access = list()


/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad/vaipo/populate_product_list(scale)
	listed_products = list(
		list("FOOD", -1, null, null),
		list("MRE", round(scale * 5), /obj/item/storage/box/MRE, VENDOR_ITEM_REGULAR),
		list("MRE Box", round(scale * 1), /obj/item/ammo_box/magazine/misc/mre, VENDOR_ITEM_REGULAR),

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
		list("M94 Marking Flare Pack", round(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", round(scale * 1), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),

		list("SIDEARMS", -1, null, null), //forecon loves their pistols
		list("M48A4 Service Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/m1911/socom, VENDOR_ITEM_REGULAR),
		list("Beretta 92FS Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/b92fs, VENDOR_ITEM_REGULAR),
		list("Desert Eagle Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/heavy , VENDOR_ITEM_REGULAR),
		list("CZ-81 Machine Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/skorpion, VENDOR_ITEM_REGULAR),
		list("MK-44 Automagnum Pistol", round(scale * 5), /obj/item/weapon/gun/pistol/highpower/black, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", -1, null, null),
		list("M1911 Magazine (.45)", round(scale * 20), /obj/item/ammo_magazine/pistol/m1911, VENDOR_ITEM_REGULAR),
		list("92FS Magazine (9mm)", round(scale * 20), /obj/item/ammo_magazine/pistol/b92fs, VENDOR_ITEM_REGULAR),
		list("Desert Eagle Magazine (.50AE)", round(scale * 20), /obj/item/ammo_magazine/pistol/heavy, VENDOR_ITEM_REGULAR),
		list("CZ-81 Magazine (.32 ACP)", round(scale * 20), /obj/item/ammo_magazine/pistol/skorpion, VENDOR_ITEM_REGULAR),
		list("MK-45 Magazine (.45)", round(scale * 20), /obj/item/ammo_magazine/pistol/highpower/black, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Motion Detector", round(scale * 5), /obj/item/device/motiondetector/m717, VENDOR_ITEM_REGULAR),
		list("Extinguisher", round(scale * 5), /obj/item/tool/extinguisher, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", round(scale * 1), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Roller Bed", round(scale * 2), /obj/item/roller, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", round(scale * 5), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("Binoculars", round(scale * 1), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", round(scale * 3), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", round(scale * 5), /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/vaipo
	name = "\improper VAIPO Surplus Uniform Vendor"
	desc = "An automated supply rack hooked up to a small storage of standard mercenary uniforms."
	req_access = list()

/obj/structure/machinery/cm_vending/sorted/uniform_supply/squad_prep/vaipo/populate_product_list(scale)
	listed_products = list(
		list("STANDARD EQUIPMENT", -1, null, null, null),
		list("Combat Boots", round(scale * 15), /obj/item/clothing/shoes/marine/knife, VENDOR_ITEM_REGULAR),
		list("Combat Gloves", round(scale * 15), /obj/item/clothing/gloves/marine/veteran, VENDOR_ITEM_REGULAR),
		list("Operator Helmet", round(scale * 15), /obj/item/clothing/head/helmet/marine/veteran/royal_marine/vaipo, VENDOR_ITEM_REGULAR),
		list("Radio Headset", round(scale * 15), /obj/item/device/radio/headset/distress/contractor, VENDOR_ITEM_REGULAR),
		list("Gray T-shirt", round(scale * 15), /obj/item/clothing/under/tshirt/gray_blu, VENDOR_ITEM_REGULAR),
		list("Red T-shirt", round(scale * 15), /obj/item/clothing/under/tshirt/r_bla, VENDOR_ITEM_REGULAR),
		list("White T-shirt", round(scale * 15), /obj/item/clothing/under/tshirt/w_br, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Brown Webbing Vest", round(scale * 1.25), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("Black Webbing Vest", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Webbing", round(scale * 2), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", round(max(1,(scale * 0.5))), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),

		list("ARMOR", -1, null, null),
		list("M3-VL Pattern Armored Vest", round(scale * 10), /obj/item/clothing/suit/storage/marine/light/vest, VENDOR_ITEM_REGULAR),

		list("BACKPACK", -1, null, null, null),
		list("Combat Pack", round(scale * 15), /obj/item/storage/backpack/lightpack, VENDOR_ITEM_REGULAR),
		list("Shotgun Scabbard", round(scale * 5), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("M276 Pattern Ammo Load Rig", round(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M40 Grenade Rig", round(scale * 10), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 Pattern General Pistol Holster Rig", round(scale * 15), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 Pattern M82F Holster Rig", round(scale * 5), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 G8-A General Utility Pouch", round(scale * 15), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null, null),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/alternate, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", round(scale * 15), /obj/item/storage/pouch/firstaid/full/pills, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Injectors)", round(scale * 15), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", round(scale * 15), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", round(scale * 15), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", round(scale * 15), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", round(scale * 15), /obj/item/storage/pouch/magazine/pistol, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", round(scale * 15), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),

		list("RESTRICTED POUCHES", -1, null, null, null),
		list("Construction Pouch", round(scale * 1.25), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", round(scale * 1.25), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch (Empty)", round(scale * 2.5), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", round(scale * 2), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Tools Pouch", round(scale * 1.25), /obj/item/storage/pouch/tools, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", round(scale * 1.25), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),

		list("MASK", -1, null, null, null),
		list("Gas Mask", round(scale * 15), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", round(scale * 10), /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR),
		list("Rebreather", round(scale * 10), /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null, null),
		list("Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 Ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", round(scale * 10), /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("Marine RPG glasses", round(scale * 10), /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("Firearm Lubricant", round(scale * 15), /obj/item/prop/helmetgarb/gunoil, VENDOR_ITEM_REGULAR),
		)

/obj/structure/machinery/cm_vending/clothing/vaipo
	name = "\improper VAIPO Dress-a-Merc Vendor"
	desc = "All the drip a proper mercenary would ever need."
	icon_state = "snowflake"
	req_access = list()

/obj/structure/machinery/cm_vending/clothing/vaipo/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_vaipo_snowflake

GLOBAL_LIST_INIT(cm_vending_clothing_vaipo_snowflake, list(
		list("UNIFORM", 0, null, null, null),
		list("Gray T-shirt", 0, /obj/item/clothing/under/tshirt/gray_blu, null, VENDOR_ITEM_REGULAR),
		list("Red T-shirt", 0, /obj/item/clothing/under/tshirt/r_bla, null, VENDOR_ITEM_REGULAR),
		list("White T-shirt", 0, /obj/item/clothing/under/tshirt/w_br, null, VENDOR_ITEM_REGULAR),
		list("Frontier Jumpsuit", 0, /obj/item/clothing/under/rank/synthetic/frontier, null, VENDOR_ITEM_REGULAR),
		list("Green Utility Uniform", 0, /obj/item/clothing/under/rank/synthetic/utility, null, VENDOR_ITEM_REGULAR),
		list("Gray Utility Uniform", 0, /obj/item/clothing/under/rank/synthetic/utility/yellow, null, VENDOR_ITEM_REGULAR),
		list("UA Gray Utility Uniform", 0, /obj/item/clothing/under/colonist/ua_civvies, null, VENDOR_ITEM_REGULAR),
		list("Brown Utility Uniform", 0, /obj/item/clothing/under/rank/synthetic/utility/red, null, VENDOR_ITEM_REGULAR),
		list("UA Brown Utility Uniform", 0, /obj/item/clothing/under/colonist/wy_davisone, null, VENDOR_ITEM_REGULAR),
		list("Blue Utility Uniform", 0, /obj/item/clothing/under/rank/synthetic/utility/blue, null, VENDOR_ITEM_REGULAR),
		list("Gray Workwear", 0, /obj/item/clothing/under/colonist/workwear, null, VENDOR_ITEM_REGULAR),
		list("Khaki Workwear", 0, /obj/item/clothing/under/colonist/workwear/khaki, null, VENDOR_ITEM_REGULAR),
		list("Pink Workwear", 0, /obj/item/clothing/under/colonist/workwear/pink, null, VENDOR_ITEM_REGULAR),
		list("Blue Workwear", 0, /obj/item/clothing/under/colonist/workwear/blue, null, VENDOR_ITEM_REGULAR),
		list("Green Workwear", 0, /obj/item/clothing/under/colonist/workwear/green, null, VENDOR_ITEM_REGULAR),
		list("Blue Boiler", 0, /obj/item/clothing/under/colonist/ua_boiler, null, VENDOR_ITEM_REGULAR),
		list("ACCESSORIES", 0, null, null, null),
		list("Sunglasses", 0, /obj/item/clothing/glasses/sunglasses, null, VENDOR_ITEM_REGULAR),
		list("BiMex Sunglasses", 0, /obj/item/clothing/glasses/sunglasses/big, null, VENDOR_ITEM_REGULAR),
		list("Aviators", 0, /obj/item/clothing/glasses/sunglasses/aviator, null, VENDOR_ITEM_REGULAR),
		list("Brown Gloves", 0, /obj/item/clothing/gloves/marine/veteran/upp, null, VENDOR_ITEM_REGULAR),
))


//------------ESSENTIAL SETS---------------
/obj/effect/essentials_set/random/uscm_light_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/storage/marine/light/padded,
		/obj/item/clothing/suit/storage/marine/light/padless,
		/obj/item/clothing/suit/storage/marine/light/padless_lines,
		/obj/item/clothing/suit/storage/marine/light/carrier,
		/obj/item/clothing/suit/storage/marine/light/skull,
		/obj/item/clothing/suit/storage/marine/light/smooth,
	)

/obj/effect/essentials_set/random/uscm_heavy_armor
	spawned_gear_list = list(
		/obj/item/clothing/suit/storage/marine/heavy/padded,
		/obj/item/clothing/suit/storage/marine/heavy/padless,
		/obj/item/clothing/suit/storage/marine/heavy/padless_lines,
		/obj/item/clothing/suit/storage/marine/heavy/carrier,
		/obj/item/clothing/suit/storage/marine/heavy/skull,
		/obj/item/clothing/suit/storage/marine/heavy/smooth,
	)
