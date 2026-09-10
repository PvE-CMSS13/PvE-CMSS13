//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_medic, list(
		list("MEDICAL SET (MANDATORY)", 0, null, null, null),
		list("Essential Medical Set", 0, /obj/effect/essentials_set/medic, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("FIELD SUPPLIES", 0, null, null, null),
		list("Burn Kit", 2, /obj/item/stack/medical/advanced/ointment, null, VENDOR_ITEM_RECOMMENDED),
		list("Trauma Kit", 2, /obj/item/stack/medical/advanced/bruise_pack, null, VENDOR_ITEM_RECOMMENDED),
		list("Medical Splints", 1, /obj/item/stack/medical/splint, null, VENDOR_ITEM_RECOMMENDED),
		list("Gauze", 1, /obj/item/stack/medical/bruise_pack, null, VENDOR_ITEM_REGULAR),
		list("Ointment", 1, /obj/item/stack/medical/ointment, null, VENDOR_ITEM_REGULAR),
		list("Blood Bag (O-)", 4, /obj/item/reagent_container/blood/OMinus, null, VENDOR_ITEM_REGULAR),

		list("FIRSTAID KITS", 0, null, null, null),
		list("Advanced Firstaid Kit", 12, /obj/item/storage/firstaid/softpack/adv, null, VENDOR_ITEM_RECOMMENDED),
		list("Firstaid Kit", 5, /obj/item/storage/firstaid/softpack/regular, null, VENDOR_ITEM_REGULAR),
		list("Fire Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/fire, null, VENDOR_ITEM_REGULAR),
		list("Toxin Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/toxin, null, VENDOR_ITEM_REGULAR),
		list("Oxygen Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/o2, null, VENDOR_ITEM_REGULAR),
		list("Radiation Firstaid Kit", 6, /obj/item/storage/firstaid/softpack/rad, null, VENDOR_ITEM_REGULAR),

		list("AUTOINJECTORS", 0, null, null, null),
		list("Autoinjector (Bicaridine)", 1, /obj/item/reagent_container/hypospray/autoinjector/bicaridine, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Dexalin+)", 1, /obj/item/reagent_container/hypospray/autoinjector/dexalinp, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Inaprovaline)", 1, /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Kelotane)", 1, /obj/item/reagent_container/hypospray/autoinjector/kelotane, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Oxycodone)", 2, /obj/item/reagent_container/hypospray/autoinjector/oxycodone, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Tramadol)", 1, /obj/item/reagent_container/hypospray/autoinjector/tramadol, null, VENDOR_ITEM_REGULAR),
		list("Autoinjector (Tricord)", 1, /obj/item/reagent_container/hypospray/autoinjector/tricord, null, VENDOR_ITEM_REGULAR),

		list("PILL BOTTLES", 0, null, null, null),
		list("Pill Bottle (Bicaridine)", 5, /obj/item/storage/pill_bottle/bicaridine, null, VENDOR_ITEM_RECOMMENDED),
		list("Pill Bottle (Dexalin)", 5, /obj/item/storage/pill_bottle/dexalin, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Dylovene)", 5, /obj/item/storage/pill_bottle/antitox, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Inaprovaline)", 5, /obj/item/storage/pill_bottle/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Kelotane)", 5, /obj/item/storage/pill_bottle/kelotane, null, VENDOR_ITEM_RECOMMENDED),
		list("Pill Bottle (Peridaxon)", 5, /obj/item/storage/pill_bottle/peridaxon, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Tramadol)", 5, /obj/item/storage/pill_bottle/tramadol, null, VENDOR_ITEM_RECOMMENDED),

		list("MEDICAL UTILITIES", 0, null, null, null),
		list("Health Diagnostic Equipment", 4, /obj/item/device/healthanalyzer/soul, null, VENDOR_ITEM_REGULAR),
		list("Roller Bed", 4, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("Pressurized Reagent Canister Pouch (EMPTY)", 3, /obj/item/storage/pouch/pressurized_reagent_canister, null, VENDOR_ITEM_REGULAR),
		list("G8-A General Utility Pouch", 15, /obj/item/storage/backpack/general_belt, null, VENDOR_ITEM_REGULAR),
		list("MS-11 Smart Refill Tank", 6, /obj/item/reagent_container/glass/minitank, null, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", 0, null, null, null),
		list("M40 HEDP High Explosive Packet (x3 grenades)", 18, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("M40 HIDP Incendiary Packet (x3 grenades)", 18, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M40 WPDP White Phosphorus Packet (x3 grenades)", 18, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M40 HSDP Smoke Packet (x3 grenades)", 9, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("M20 Mine Box (x5 mines)", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("G2 Electroshock Grenade Packet (x3 grenades)",  16, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("PRIMARY AMMUNITION", 0, null, null, null),
		list("M49A AP Magazine (10x24mm)", 6, /obj/item/ammo_magazine/rifle/m49a/ap, null, VENDOR_ITEM_REGULAR),
		list("M39 AP Magazine (10x20mm)", 6, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("M39 Extended Magazine (10x20mm)", 6, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("M41A AP Magazine (10x24mm)", 6, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("M41A Extended Magazine (10x24mm)", 6, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("SIDEARM AMMUNITION", 0, null, null, null),
		list("M44 Heavy Speed Loader (.44)", 6, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("M44 Marksman Speed Loader (.44)", 6, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP Magazine", 3, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 AP Magazine", 3, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("VP78 Magazine", 3, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 Smartpistol Magazine (.45)", 6, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("ARMORS", 0, null, null, null),
		list("M3 B12 Pattern Marine Armor", 24, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),
		list("M4 Pattern Armor", 16, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("RESTRICTED FIREARMS", 0, null, null, null),
		list("VP78 Pistol", 8, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("SU-6 Smart Pistol", 12, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),

		list("CLOTHING ITEMS", 0, null, null, null),
		list("Machete Scabbard (Full)", 6, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Machete Pouch (Full)", 8, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("USCM Radio Telephone Pack", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("Fuel Tank Strap Pouch", 4, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("Welding Goggles", 3, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),

		list("UTILITIES", 0, null, null, null),
		list("Fire Extinguisher (Portable)", 3, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Motion Detector", 8, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("Whistle", 3, /obj/item/device/whistle, null, VENDOR_ITEM_REGULAR),

		list("BINOCULARS", 0, null, null, null),
		list("Binoculars", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("Range Finder", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("Laser Designator", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("HELMET OPTICS", 0, null, null, null),
		list("Welding Visor", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("PAMPHLETS", 0, null, null, null),
		list("JTAC Pamphlet", 15, /obj/item/pamphlet/skill/jtac, null, VENDOR_ITEM_REGULAR),
		list("Engineering Pamphlet", 15, /obj/item/pamphlet/skill/engineer, null, VENDOR_ITEM_REGULAR),

		list("RADIO KEYS", 0, null, null, null),
		list("Engineering Radio Encryption Key", 3, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("Intel Radio Encryption Key", 3, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("JTAC Radio Encryption Key", 3, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("Supply Radio Encryption Key", 3, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/medic
	name = "\improper ColMarTech Squad Medical Gear Rack"
	desc = "An automated gear rack for hospital corpsmen."
	icon_state = "med_gear"
	show_points = TRUE
	vendor_role = list(JOB_SQUAD_MEDIC)
	req_access = list(ACCESS_MARINE_MEDPREP)

/obj/structure/machinery/cm_vending/gear/medic/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_medic

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_medic, list(

		list("ARMOR PAINT (CHOOSE 1)", 0, null, null, null),
		list("Red Cross Paint", 0, /obj/item/clothing/accessory/paint/medic, MARINE_CAN_BUY_PAINT, VENDOR_ITEM_RECOMMENDED),

		list("HELMET (CHOOSE 1)", 0, null, null, null),
		list("M10 Helmet (Red Cross)", 0, /obj/item/clothing/head/helmet/marine/medic, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("M10 Helmet (Plain)", 0, /obj/item/clothing/head/helmet/marine/medic/plain, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),

		list("OVERWATCH & HUD EQUIPMENT (CHOOSE 1)", 0, null, null, null),
		list("Mark 2 Battle Medic sight", 0, /obj/item/clothing/glasses/night/medhud/no_nvg, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("BACKPACK (CHOOSE 1)", 0, null, null, null),
		list("Medical Backpack", 0, /obj/item/storage/backpack/marine/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Medical Satchel", 0, /obj/item/storage/backpack/marine/satchel/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("BELT (CHOOSE 1)", 0, null, null, null),
		list("M276 Lifesaver Bag (Full)", 0, /obj/item/storage/belt/medical/lifesaver/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 Medical Storage Rig (Full)", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Autoinjector Pouch", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Bicaridine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Kelotane)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Vial Pouch (Full)", 0, /obj/item/storage/pouch/vials/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("M3 Pattern Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Magazine Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/mag, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Shotgun Shell Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/shotgun, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3 Pattern M40 Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/m40, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3 Pattern Small Pouch Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/small, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Shoulder Holster", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/medic
	name = "\improper ColMarTech Squad Medical Equipment Rack"
	desc = "An automated rack hooked up to a colossal storage of hospital corpsman standard-issue equipment."
	req_access = list(ACCESS_MARINE_MEDPREP)
	vendor_role = list(JOB_SQUAD_MEDIC)

/obj/structure/machinery/cm_vending/clothing/medic/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_medic

/obj/structure/machinery/cm_vending/clothing/medic/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_MEDPREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha/med

/obj/structure/machinery/cm_vending/clothing/medic/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_MEDPREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo/med

/obj/structure/machinery/cm_vending/clothing/medic/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_MEDPREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie/med

/obj/structure/machinery/cm_vending/clothing/medic/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_MEDPREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta/med

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/medic
	spawned_gear_list = list(
		/obj/item/storage/firstaid/softpack/adv,
		/obj/item/storage/firstaid/softpack/adv,
		/obj/item/device/healthanalyzer/soul,
		/obj/item/roller,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/storage/surgical_case/regular,
		/obj/item/device/flashlight/pen,
		/obj/item/reagent_container/hypospray/autoinjector/adrenaline_concentrated,
		/obj/item/reagent_container/hypospray/autoinjector/adrenaline_concentrated,
	)

GLOBAL_LIST_INIT(cm_vending_clothing_upp_medic, list(
		list("MEDICAL SET (MANDATORY)", 0, null, null, null),
		list("Essential Medical Set", 0, /obj/effect/essentials_set/medic, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("BACKPACK (CHOOSE 1)", 0, null, null, null),
		list("Medical Backpack", 0, /obj/item/storage/backpack/marine/medic/upp, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Medical Satchel", 0, /obj/item/storage/backpack/lightpack/upp, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("BELT (CHOOSE 1)", 0, null, null, null),
		list("Type 41 Ammo Load Rig", 0, /obj/item/storage/belt/marine/upp, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Type 47 General Pistol Holster Rig", 0, /obj/item/storage/belt/gun/type47, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Type 41 Lifesaver Bag (Full)", 0, /obj/item/storage/belt/medical/lifesaver/upp/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Type 41 Medical Storage Rig (Full)", 0, /obj/item/storage/belt/medical/upp/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Autoinjector Pouch", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Bicaridine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Kelotane)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Vial Pouch (Full)", 0, /obj/item/storage/pouch/vials/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("Brown Webbing Vest", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Black Webbing Vest", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Webbing", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/medic/upp
	name = "\improper UnTech Squad Medical Equipment Rack"
	desc = "An automated rack hooked up to a colossal storage of hospital corpsman standard-issue equipment."
	icon_state = "upp_gear"
	req_access = list(ACCESS_UPP_MEDPREP)
	vendor_role = list(JOB_SQUAD_MEDIC)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/clothing/medic/upp/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_upp_medic

GLOBAL_LIST_INIT(cm_vending_clothing_forecon_medic, list(
		list("ARMOR PAINT (CHOOSE 1)", 0, null, null, null),
		list("Red Cross Paint", 0, /obj/item/clothing/accessory/paint/medic, MARINE_CAN_BUY_PAINT, VENDOR_ITEM_RECOMMENDED),

		list("OVERWATCH & HUD EQUIPMENT (CHOOSE 1)", 0, null, null, null),
		list("Mark 2 Battle Medic sight", 0, /obj/item/clothing/glasses/night/medhud/no_nvg, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("ARMOR (CHOOSE 1)", 0, null, null, null),
		list("M3-R Armor", 0, /obj/item/clothing/suit/marine/rto/forecon, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),

		list("BACKPACK (CHOOSE 1)", 0, null, null, null),
		list("Medical Backpack", 0, /obj/item/storage/backpack/marine/medic/standard, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Medical Satchel", 0, /obj/item/storage/backpack/marine/satchel/medic/standard, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("BELT (CHOOSE 1)", 0, null, null, null),
		list("M276 Lifesaver Bag (Full)", 0, /obj/item/storage/belt/medical/lifesaver/standard/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("M276 Medical Storage Rig (Full)", 0, /obj/item/storage/belt/medical/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Autoinjector Pouch", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Bicaridine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Kelotane)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Vial Pouch (Full)", 0, /obj/item/storage/pouch/vials/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("M3-R Pattern Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/recon, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3-R Pattern Shotgun Shell Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/recon/shotgun, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3-R Pattern M40 Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/recon/m40, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("M3-R Pattern Corpsman Webbing", 0, /obj/item/clothing/accessory/storage/webbing/m3/recon/medic, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/medic/forecon
	name = "\improper ColMarTech FORECON Medical Gear Rack"

/obj/structure/machinery/cm_vending/clothing/medic/forecon/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_forecon_medic

GLOBAL_LIST_INIT(cm_vending_clothing_pmc_medic, list(

		list("ARMOR PAINT (CHOOSE 1)", 0, null, null, null),
		list("Red Cross On White Paint", 0, /obj/item/clothing/accessory/paint/medic/wy, MARINE_CAN_BUY_PAINT, VENDOR_ITEM_RECOMMENDED),
		list("Red Cross On Black Paint", 0, /obj/item/clothing/accessory/paint/medic/wy/black, MARINE_CAN_BUY_PAINT, VENDOR_ITEM_RECOMMENDED),

		list("BELT", 0, null, null, null),
		list("M276 Lifesaver Bag (Full)", 0, /obj/item/storage/belt/medical/lifesaver/wy/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Autoinjector Pouch (Full)", 0, /obj/item/storage/pouch/autoinjector/full/wy, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch (Full)", 0, /obj/item/storage/pouch/medkit/wy/full_advanced, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Bicaridine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Kelotane)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Vial Pouch (Full)", 0, /obj/item/storage/pouch/vials/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("Small Pouch", 0, /obj/item/clothing/accessory/storage/smallpouch/wy, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR, VENDOR_ITEM_RECOMMENDED),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch/wy, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Waist Holster", 0, /obj/item/clothing/accessory/storage/holster/waist, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/medic/pmc
	name = "\improper PMC Medical Gear Rack"
	icon_state = "pmc_gear"
	vendor_theme = VENDOR_THEME_COMPANY

/obj/structure/machinery/cm_vending/clothing/medic/pmc/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_pmc_medic

// RMC med-vendor

/obj/effect/essentials_set/rmcmedic
	spawned_gear_list = list(
		/obj/item/storage/surgical_case/rmc_surgical_case/full,
		/obj/item/device/healthanalyzer/soul,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/device/flashlight/pen,
		/obj/item/clothing/accessory/stethoscope,
	)

GLOBAL_LIST_INIT(cm_vending_clothing_rmc_medic, list(
		list("MEDICAL SET (MANDATORY)", 0, null, null, null),
		list("Essential Medical Set", 0, /obj/effect/essentials_set/rmcmedic, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("BACKPACK (CHOOSE 1)", 0, null, null, null),
		list("Heavy-duty Medical Backpack", 0, /obj/item/storage/backpack/rmc/medic, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("BELT (CHOOSE 1)", 0, null, null, null),
		list("L75 Pattern Medical Storage Rig (Empty)", 0, /obj/item/storage/belt/medical/rmc, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("L26 Pattern General Utility Belt", 0, /obj/item/storage/backpack/general_belt/rmc, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Autoinjector Pouch", 0, /obj/item/storage/pouch/autoinjector, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Bicaridine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/bicaridine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Kelotane)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/kelotane, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Pressurized Reagent Canister Pouch (Tricordrazine)", 0, /obj/item/storage/pouch/pressurized_reagent_canister/tricordrazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Vial Pouch (Full)", 0, /obj/item/storage/pouch/vials/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch/rmc, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Small Pouch", 0, /obj/item/clothing/accessory/storage/smallpouch/rmc, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Waist Holster", 0, /obj/item/clothing/accessory/storage/holster/waist, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/medic/rmc
	name = "\improper WeyTech Section Medical Equipment Rack"
	desc = "An automated rack hooked up to a colossal storage of standard-issue medical equipment."
	icon_state = "rmc_gear"
	req_access = list(ACCESS_TWE_MEDPREP)
	vendor_role = list(JOB_TWE_RMC_MEDIC)
	vendor_theme = VENDOR_THEME_COMPANY

/obj/structure/machinery/cm_vending/clothing/medic/rmc/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_rmc_medic

// Chemical vendor

GLOBAL_LIST_INIT(cm_vending_chemical_medic, list(
		list("ESSENTIAL MEDICATION (CHOOSE 1)", 0, null, null, null),
		list("Pill Bottle (Imidazoline-Alkysine)", 0, /obj/item/storage/pill_bottle/imialk, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_RECOMMENDED),
		list("Liquid Bottle (Imidazoline-Alkysine)", 0, /obj/item/reagent_container/glass/bottle/imialk, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_RECOMMENDED),

		list("PILL BOTTLES", 0, null, null, null),
		list("Pill Bottle (Meralyne-Bicardine)", 60, /obj/item/storage/pill_bottle/merabica, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Kelotane-Dermaline)", 60, /obj/item/storage/pill_bottle/keloderm, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Nitrogen-Water)", 30, /obj/item/storage/pill_bottle/nitrogenwater, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Dexalin+)", 30, /obj/item/storage/pill_bottle/dexalinplus, null, VENDOR_ITEM_REGULAR),
		list("Pill Bottle (Iron)", 30, /obj/item/storage/pill_bottle/iron, null, VENDOR_ITEM_REGULAR),

		list("LIQUID BOTTLES", 0, null, null, null),
		list("Liquid Bottle (Meralyne-Bicardine)", 40, /obj/item/reagent_container/glass/bottle/merabica, null, VENDOR_ITEM_REGULAR),
		list("Liquid Bottle (Kelotane-Dermaline)", 40, /obj/item/reagent_container/glass/bottle/keloderm, null, VENDOR_ITEM_REGULAR),
		list("Liquid Bottle (Dexalin+)", 30, /obj/item/reagent_container/glass/bottle/dexalinplus, null, VENDOR_ITEM_REGULAR),

		list("INJECTORS", 0, null, null, null),
		list("Smart Refill Tank", 40, /obj/item/reagent_container/glass/minitank, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/medic_chemical
	name = "\improper ColMarTech Squad Medical Chemical Rack"
	desc = "An automated gear rack for specialized chemicals for the hospital corpsman."
	icon_state = "med_chem"
	show_points = TRUE
	use_snowflake_points = TRUE
	vendor_role = list(JOB_SQUAD_MEDIC)
	req_access = list(ACCESS_MARINE_MEDPREP)

/obj/structure/machinery/cm_vending/gear/medic_chemical/get_listed_products(mob/user)
	return GLOB.cm_vending_chemical_medic

/obj/structure/machinery/cm_vending/gear/medic_chemical/upp
	name = "\improper UnTech Squad Medical Chemical Rack"
	req_access = list(ACCESS_UPP_MEDPREP)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/gear/medic_chemical/rmc
	name = "\improper WeyTech Section Medical Chemical Rack"
	req_access = list(ACCESS_TWE_MEDPREP)
	vendor_theme = VENDOR_THEME_COMPANY
	vendor_role = list(JOB_TWE_RMC_MEDIC)
