/obj/item/weapon/gun/smg/m39/forecon/outpost
	desc = "Modified extensively from the FORECON armory it was taken from initially if the paintjob is anything to go by, this M39 has been tailored for one-handed firing, allowing the operator to use it alongside a ballistic shield."
	icon = 'icons/obj/items/weapons/guns/guns_by_map/jungle/guns_obj.dmi'
	current_mag = /obj/item/ammo_magazine/smg/m39/heap
	starting_attachment_types = list(/obj/item/attachable/stock/smg/collapsible/brace, /obj/item/attachable/reflex, /obj/item/attachable/lasersight, /obj/item/attachable/compensator)
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/items/weapons/guns/guns_by_map/jungle/guns_lefthand.dmi',
		WEAR_R_HAND = 'icons/obj/items/weapons/guns/guns_by_map/jungle/guns_righthand.dmi',
		WEAR_BACK = 'icons/obj/items/weapons/guns/guns_by_map/jungle/back.dmi',
		WEAR_J_STORE = 'icons/obj/items/weapons/guns/guns_by_map/jungle/suit_slot.dmi'
	)

/obj/item/weapon/gun/smg/m39/forecon/outpost/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult =  BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_7
