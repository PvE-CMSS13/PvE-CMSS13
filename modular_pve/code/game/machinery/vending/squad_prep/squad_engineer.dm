GLOBAL_LIST_INIT(cm_vending_clothing_engi_outpost, list(
		list("BACKPACK (CHOOSE 1)", 0, null, null, null),
		list("Technician Welder-Satchel", 0, /obj/item/storage/backpack/marine/engineerpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Technician Welder Chestrig", 0, /obj/item/storage/backpack/marine/engineerpack/welder_chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("TOOL STORAGE (CHOOSE 1)", 0, null, null, null),
		list("Tool Webbing (Full)", 0, /obj/item/clothing/accessory/storage/tool_webbing/tactical, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 Toolbelt Rig (Full)", 0, /obj/item/storage/belt/utility/full/tactical, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),
		list("M277 Pattern Construction Rig", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("M276 Pattern Combat Toolbelt Rig", 0, /obj/item/storage/belt/gun/utility, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Small Pouch", 0, /obj/item/clothing/accessory/storage/smallpouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("HELMET (CHOOSE 1)", 0, null, null, null),
		list("M10 Technician Helmet", 0, /obj/item/clothing/head/helmet/marine/tech, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("M50 Tanker Helmet", 0, /obj/item/clothing/head/helmet/marine/tech/tanker, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Construction Pouch", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Electronics Pouch (Full)", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", 0, /obj/item/storage/pouch/explosive, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large Magazine Pouch", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Machete Pouch", 0, /obj/item/storage/pouch/machete/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Engineer kit Pouch", 0, /obj/item/storage/pouch/engikit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/engi/uscm_ground
	name = "\improper ColMarTech Outpost ComEng Equipment Rack"
	desc = "An automated rack hooked up to a large storage of combat engineer standard-issue equipment."
	icon_state = "uscm_gear"
	vendor_role = list(JOB_SQUAD_ENGI)
	req_access = list(ACCESS_MARINE_ENGPREP)

/obj/structure/machinery/cm_vending/clothing/engi/uscm_ground/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_engi_outpost

/obj/effect/essentials_set/outpost_engi
	spawned_gear_list = list(
		/obj/item/defenses/handheld/sentry,
		/obj/item/explosive/plastic,
		/obj/item/stack/sandbags_empty = 50,
		/obj/item/stack/sheet/metal/large_stack,
		/obj/item/circuitboard/apc,
		/obj/item/cell/high,
		/obj/item/tool/shovel/etool/folded,
	)

GLOBAL_LIST_INIT(cm_vending_gear_engi_outpost, list(
		list("ENGINEERING EQUIPMENT (MANDATORY)", 0, null, null, null),
		list("Essential Engineering EQUIPMENT", 0, /obj/effect/essentials_set/outpost_engi, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("ADDITIONAL ENGINEERING SUPPLIES", 0, null, null, null),
		list("Airlock Circuit Board", 1, /obj/item/circuitboard/airlock, null, VENDOR_ITEM_REGULAR),
		list("APC Circuit Board", 1, /obj/item/circuitboard/apc, null, VENDOR_ITEM_REGULAR),
		list("High-Capacity Power Cell", 2, /obj/item/cell/high, null, VENDOR_ITEM_REGULAR),
		list("Metal x20", 5, /obj/item/stack/sheet/metal/med_small_stack, null, VENDOR_ITEM_REGULAR),
		list("Plasteel x10", 5, /obj/item/stack/sheet/plasteel/small_stack, null, VENDOR_ITEM_REGULAR),
		list("Sandbags x50", 15, /obj/item/stack/sandbags/, null, VENDOR_ITEM_REGULAR),
		list("Super-Capacity Power Cell", 5, /obj/item/cell/super, null, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", 0, null, null, null),
		list("M77 HIAM Incendiary Grenade Packet (x5 grenades)", 10, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M60 WPSI Phosphorus Grenade Packet (x5 grenades)", 10, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("M20A2 Mine Box (x5 mines)", 10, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("G2 Electroshock Grenade Packet (x3 grenades)",  10, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/engi/uscm_ground
	name = "\improper ColMarTech Outpost ComEng Gear Rack"
	desc = "An automated gear rack for combat engineers."
	icon_state = "eng_gear"
	vendor_role = list(JOB_SQUAD_ENGI)
	req_access = list(ACCESS_MARINE_ENGPREP)

/obj/structure/machinery/cm_vending/gear/engi/uscm_ground/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_engi_outpost
