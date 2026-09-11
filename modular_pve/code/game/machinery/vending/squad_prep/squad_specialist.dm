GLOBAL_LIST_INIT(cm_vending_gear_spec_outpost, list(
		list("WEAPONS SPECIALIST SETS (Pick One)", 0, null, null, null),
		list("B18 Future Warrior Set", 0, /obj/item/storage/box/spec/B18/outpost, MARINE_CAN_BUY_KIT, VENDOR_ITEM_MANDATORY),
		list("Sonic Harpoon Operator Set", 0, /obj/item/storage/box/spec/sharp_operator, MARINE_CAN_BUY_KIT, VENDOR_ITEM_MANDATORY),
		list("Experimental Equipment Set", 0, /obj/item/storage/box/spec/plasma, MARINE_CAN_BUY_KIT, VENDOR_ITEM_MANDATORY),
		list("Bulwark Breacher Set", 0, /obj/item/storage/box/spec/bulwark, MARINE_CAN_BUY_KIT, VENDOR_ITEM_MANDATORY),

		list("SPARE MUNITIONS", 0, null, null, null),
		list("SU6 Magazine Box (x16)", 30, /obj/item/ammo_box/magazine/su6, null, VENDOR_ITEM_REGULAR),
		list("M39 Magazine Box (x12)", 30, /obj/item/ammo_box/magazine/m39/heap, null, VENDOR_ITEM_REGULAR),
		list("XM99A1 Battery Drum", 15, /obj/item/ammo_magazine/plasma, null, VENDOR_ITEM_REGULAR),
		list("9X-E Sticky Explosive Dart Magazine",  15, /obj/item/ammo_magazine/rifle/sharp/explosive, null, VENDOR_ITEM_REGULAR),
))

//A special...specialist vendor with actual inventory instead of points. We're old school here. Could maybe even rig it for tokens in the future.
/obj/structure/machinery/cm_vending/gear/spec/uscm_ground
	name = "\improper ColMarTech Specialist Field Testing Gear Rack"
	desc = "An automated gear rack for Outpost Weapons Specialists. Has a small selection of equipment meant for field testing or limited use."
	icon_state = "spec_gear"
	show_points = TRUE
	use_points = TRUE
	use_snowflake_points = FALSE
	vend_flags = VEND_TO_HAND|VEND_CATEGORY_CHECK|VEND_CLUTTER_PROTECTION
	vendor_role = list(JOB_SQUAD_SPECIALIST)
	req_access = list(ACCESS_MARINE_SPECPREP)

/obj/structure/machinery/cm_vending/gear/spec/uscm_ground/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_spec_outpost
