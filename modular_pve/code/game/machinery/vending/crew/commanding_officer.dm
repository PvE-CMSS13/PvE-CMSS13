GLOBAL_LIST_INIT(cm_vending_clothing_outpost_commanding_officer, list(
		list("COMMANDING OFFICER ESSENTIALS KIT", 0, null, null, null),
		list("Commanding Officer Essentials Kit", 0, /obj/effect/essentials_set/commanding_officer, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("Uniform (CHOOSE 1)", 0, null, null, null),
		list("Service Uniform", 0, /obj/item/clothing/under/marine/officer/bridge, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("Operations Uniform", 0, /obj/item/clothing/under/marine/officer/boiler, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_RECOMMENDED),

		list("JACKET (CHOOSE 1)", 0, null, null, null),
		list("Service Jacket", 0, /obj/item/clothing/suit/storage/jacket/marine/service, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("Bridge Jacket", 0, /obj/item/clothing/suit/storage/jacket/marine/dress/bridge_coat_grey, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("Bomber Jacket", 0, /obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),

		list("HAT (CHOOSE 1)", 0, null, null, null),
		list("Beret, Green", 0, /obj/item/clothing/head/beret/cm, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Beret, Tan", 0, /obj/item/clothing/head/beret/cm/tan, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Patrol Cap", 0, /obj/item/clothing/head/cmcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Operations Cap", 0, /obj/item/clothing/head/cmcap/bridge, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Service Peaked Cap", 0, /obj/item/clothing/head/marine/peaked/service, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),

		list("BAGS (CHOOSE 1)", 0, null, null, null),
		list("Commanding Officer Backpack", 0, /obj/item/storage/backpack/mcommander, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("Secure Satchel", 0, /obj/item/storage/backpack/satchel/lockable, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("COMBAT EQUIPMENT", 0, null, null, null),
		list("Commanding Officer's M3 Armor", 0, /obj/item/clothing/suit/marine/light, MARINE_CAN_BUY_COMBAT_ARMOR, VENDOR_ITEM_MANDATORY),
		list("Commanding Officer's M10 Helmet", 0, /obj/item/clothing/head/helmet/marine/rto, MARINE_CAN_BUY_COMBAT_HELMET, VENDOR_ITEM_MANDATORY),
		list("Combat Gloves", 0, /obj/item/clothing/gloves/marine, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Marine Combat Boots", 0, /obj/item/clothing/shoes/marine/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("ACCESSORIES (CHOOSE 1)", 0, null, null, null),
		list("Brown Webbing Vest", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Black Webbing Vest", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Tactical Waistcoat", 0, /obj/item/clothing/accessory/storage/black_vest/waistcoat, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Webbing", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Drop Pouch", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("First-Aid Pouch (Refillable Injectors)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Medical Kit Pouch", 0, /obj/item/storage/pouch/medkit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Autoinjector Pouch", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large General Pouch", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large Magazine Pouch", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Sidearm Pouch", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Large Shotgun Shell Pouch", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Tools Pouch (Full)", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/commanding_officer/uscm_ground
	name = "\improper ColMarTech OutpostCommanding Officer Equipment Rack"
	vendor_role = list(JOB_USCM_GROUND_CO)

/obj/structure/machinery/cm_vending/clothing/commanding_officer/uscm_ground/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_outpost_commanding_officer
