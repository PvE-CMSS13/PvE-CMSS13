//-------------------------------------------------------

/obj/item/weapon/gun/rifle
	reload_sound = 'sound/weapons/gun_rifle_reload.ogg'
	cocked_sound = 'sound/weapons/gun_cocked2.ogg'

	flags_equip_slot = SLOT_BACK
	w_class = SIZE_LARGE
	force = 5
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AUTO_EJECT_CASINGS
	gun_category = GUN_CATEGORY_RIFLE
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	wield_delay = WIELD_DELAY_NORMAL

/obj/item/weapon/gun/rifle/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0) load_into_chamber()

/obj/item/weapon/gun/rifle/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/unique_action(mob/user)
	cock(user)

//-------------------------------------------------------
//M41A PULSE RIFLE

/obj/item/weapon/gun/rifle/m41a
	name = "\improper M41A pulse rifle MK2"
	desc = "The standard issue rifle of the Colonial Marines. Commonly carried by most combat personnel. Uses 10x24mm caseless ammunition."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m41a"
	item_state = "m41a"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/rifle,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/stock/rifle/collapsible)
	map_specific_decoration = TRUE
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m41a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 26, "side_rail_y" = 16)


/obj/item/weapon/gun/rifle/m41a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/m41a/elite
	name = "\improper M41A2 pulse rifle MK2"
	desc = "A modified version M41A pulse rifle re-engineered for better weight and handling, and an high degree of accuracy brought about by a precise two-round burst system."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/wy.dmi'
	icon_state = "m41a2mk2"
	item_state = "m41a2mk2"
	current_mag = /obj/item/ammo_magazine/rifle/ap
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_FAST
	map_specific_decoration = FALSE
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible)

	random_spawn_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/attached_gun/flamer/advanced,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/extended_barrel,
	)
	random_spawn_chance = 100

/obj/item/weapon/gun/rifle/m41a/elite/set_gun_config_values()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/m41a/elite/commando //special version for commandos, has preset attachments.

	starting_attachment_types = list(/obj/item/attachable/stock/rifle, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight, /obj/item/attachable/angledgrip)

/obj/item/weapon/gun/rifle/m41a/elite/commando/deathsquad //special version for commandos, has preset attachments.

	starting_attachment_types = list(/obj/item/attachable/stock/rifle, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/lasersight, /obj/item/attachable/extended_barrel)
	current_mag = /obj/item/ammo_magazine/rifle/heap

/obj/item/weapon/gun/rifle/m41a/elite/unloaded
	current_mag = null

/obj/item/weapon/gun/rifle/m41a/elite/unloaded/platoon
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/sling,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
	)
	random_rail_chance = 50
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)
	random_under_chance = 100
	random_spawn_under = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/angledgrip,
	)
	random_muzzle_chance = 50
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
	)

/obj/item/weapon/gun/rifle/m41a/elite/whiteout //special version for whiteout, has preset attachments and HEAP mag loaded.
	current_mag = /obj/item/ammo_magazine/rifle/heap
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/magnetic_harness, /obj/item/attachable/angledgrip, /obj/item/attachable/suppressor)

/obj/item/weapon/gun/rifle/m41a/corporate
	desc = "A Weyland-Yutani creation, this M41A MK2 comes equipped in corporate white. Uses 10x24mm caseless ammunition."
	icon = 'icons/obj/items/weapons/guns/guns_by_map/snow/guns_obj.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/items/weapons/guns/guns_by_map/snow/guns_lefthand.dmi',
		WEAR_R_HAND = 'icons/obj/items/weapons/guns/guns_by_map/snow/guns_righthand.dmi',
		WEAR_BACK = 'icons/obj/items/weapons/guns/guns_by_map/snow/back.dmi',
		WEAR_J_STORE = 'icons/obj/items/weapons/guns/guns_by_map/snow/suit_slot.dmi'
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED
	map_specific_decoration = FALSE
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible)

/obj/item/weapon/gun/rifle/m41a/corporate/no_lock //for PMC nightmares.
	desc = "A Weyland-Yutani creation, this M41A MK2 comes equipped in corporate white. Uses 10x24mm caseless ammunition. This one had its IFF electronics removed."
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

/obj/item/weapon/gun/rifle/m41a/corporate/commando
	current_mag = /obj/item/ammo_magazine/rifle/ap
	starting_attachment_types = list(/obj/item/attachable/stock/rifle, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight, /obj/item/attachable/angledgrip)

/obj/item/weapon/gun/rifle/m41a/corporate/commando/regular
	current_mag = /obj/item/ammo_magazine/rifle/extended

/obj/item/weapon/gun/rifle/m41a/corporate/detainer //for chem ert
	current_mag = /obj/item/ammo_magazine/rifle
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/lasersight)

//variant without ugl attachment
/obj/item/weapon/gun/rifle/m41a/stripped
	starting_attachment_types = list()


/obj/item/weapon/gun/rifle/m41a/training
	current_mag = /obj/item/ammo_magazine/rifle/rubber


/obj/item/weapon/gun/rifle/m41a/tactical
	current_mag = /obj/item/ammo_magazine/rifle/ap
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/suppressor, /obj/item/attachable/angledgrip, /obj/item/attachable/stock/rifle/collapsible)

//-------------------------------------------------------
//NSG 23 ASSAULT RIFLE - RMC PRIMARY RIFLE

/obj/item/weapon/gun/rifle/nsg23
	name = "\improper NSG 23 pulse rifle"
	desc = "Pulse action 8.5x33mm caseless assault rifle in use by various W-Y personnel. Comparable performance with the ARMAT M41A series of rifles, with slightly better handling."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/wy.dmi'
	icon_state = "nsg23"
	item_state = "nsg23"
	fire_sound = "gun_nsg23"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	cocked_sound = 'sound/weapons/handling/nsg23_cocked.ogg'
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_VERY_FAST
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_WY_RESTRICTED
	start_automatic = TRUE
	current_mag = /obj/item/ammo_magazine/rifle/nsg23
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/bayonet/rmc,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/stock/nsg23,
		/obj/item/attachable/stock/nsg23/rmc,
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/scope/mini/nsg23/rmc,
		/obj/item/attachable/attached_gun/grenade/nsg,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun/af13,
		/obj/item/attachable/attached_gun/shotgun/af13b,
	)

	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/stock/nsg23,
	)

/obj/item/weapon/gun/rifle/nsg23/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 16,"rail_x" = 13, "rail_y" = 20, "under_x" = 19, "under_y" = 11, "stock_x" = 5, "stock_y" = 17, "side_rail_x" = 24, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/nsg23/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0
	fa_max_scatter = SCATTER_AMOUNT_TIER_7

/obj/item/weapon/gun/rifle/nsg23/no_lock
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER

/obj/item/weapon/gun/rifle/nsg23/no_lock/pve
	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23,
		/obj/item/attachable/stock/nsg23,
		/obj/item/attachable/attached_gun/flamer/advanced,
	)

/obj/item/weapon/gun/rifle/nsg23/no_lock/pve/heap
	current_mag = /obj/item/ammo_magazine/rifle/nsg23/heap

/obj/item/weapon/gun/rifle/nsg23/rmc
	name = "\improper NSG L23A1 pulse rifle"
	desc = "Pulse action 8.5x33mm caseless assault rifle of the Royal Marine Commandos, personal friend of any Marine Commando. Comes with semi-auto and burst-fire firemodes and features an integrated 30mm grenade launcher that can hold two grenades on backup with one in the chamber."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/twe_guns.dmi'
	icon_state = "rmc_nsg23"
	item_state = "rmc_nsg23"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	start_automatic = FALSE
	start_burstfire = TRUE
	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23/rmc,
		/obj/item/attachable/attached_gun/grenade/nsg,
		/obj/item/attachable/stock/nsg23/rmc,
	)

/obj/item/weapon/gun/rifle/nsg23/rmc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/nsg23/rmc/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0) load_into_chamber()

/obj/item/weapon/gun/rifle/nsg23/rmc/unloaded
	current_mag = null
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY

/obj/item/weapon/gun/rifle/nsg23/rmc/preloaded
	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23/rmc,
		/obj/item/attachable/attached_gun/grenade/nsg/preloaded,
		/obj/item/attachable/stock/nsg23/rmc,
	)

/obj/item/weapon/gun/rifle/nsg23/rmc/preloaded/tactical
	starting_attachment_types = list(
		/obj/item/attachable/scope/mini/nsg23/rmc,
		/obj/item/attachable/attached_gun/grenade/nsg/preloaded,
		/obj/item/attachable/stock/nsg23/rmc,
		/obj/item/attachable/suppressor,
	)


//M40-SD AKA SOF RIFLE FROM HELL (It's actually an M41A, don't tell!)

/obj/item/weapon/gun/rifle/m41aMK1/xm40
	name = "\improper XM40 pulse rifle"
	desc = "One of the experimental predecessors to the M41 line that never saw widespread adoption beyond elite marine units. Of the rifles in the USCM inventory that are still in production, this is the only one to feature an integrated suppressor. Extremely lethal in burstfire mode."
	icon_state = "m40sd"
	item_state = "m40sd"
	reload_sound = 'sound/weapons/handling/m40sd_reload.ogg'
	unload_sound = 'sound/weapons/handling/m40sd_unload.ogg'
	unacidable = TRUE
	indestructible = TRUE

	current_mag = /obj/item/ammo_magazine/rifle/xm40/heap
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_FAST
	map_specific_decoration = FALSE
	starting_attachment_types = list()
	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/xm40,
		/obj/item/ammo_magazine/rifle/xm40/heap,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor/xm40_integral,//no rail attachies
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/bipod,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/extinguisher,
		)

	random_spawn_chance = 0

/obj/item/weapon/gun/rifle/m41a/elite/xm40/handle_starting_attachment()
	..()
	var/obj/item/attachable/suppressor/xm40_integral/S = new(src)
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.hidden = FALSE
	S.Attach(src)
	update_attachable(S.slot)

	var/obj/item/attachable/magnetic_harness/H = new(src)//integrated mag harness, no rail attachies
	H.flags_attach_features &= ~ATTACH_REMOVABLE
	H.hidden = TRUE
	H.Attach(src)
	update_attachable(H.slot)

/obj/item/weapon/gun/rifle/m41a/elite/xm40/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 12, "rail_y" = 23, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 25, "side_rail_y" = 17)

/obj/item/weapon/gun/rifle/m41a/elite/xm40/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/m41a/elite/xm40/ap
	current_mag = /obj/item/ammo_magazine/rifle/xm40
//-------------------------------------------------------
//M41A TRUE AND ORIGINAL

/obj/item/weapon/gun/rifle/m41aMK1
	name = "\improper M41A pulse rifle"
	desc = "Pulse action 10x24mm caseless assault rifle of the USCMC, personal friend of any Marine. Features an integrated 30mm grenade launcher and ammo tube that can hold four grenades on backup."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m41amk1" //Placeholder.
	item_state = "m41amk1" //Placeholder.
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/sling,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1, /obj/item/attachable/stock/rifle/collapsible)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m41aMK1/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 23, "under_x" = 23, "under_y" = 13, "stock_x" = 24, "stock_y" = 14, "side_rail_x" = 23, "side_rail_y" = 16)


/obj/item/weapon/gun/rifle/m41aMK1/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_3
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	damage_falloff_mult = 0
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/m41aMK1/ap //for making it start with ap loaded
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/ap

/obj/item/weapon/gun/rifle/m41aMK1/unloaded //for making it start unloaded and with the safety on
	current_mag = null
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY

/obj/item/weapon/gun/rifle/m41aMK1/preloaded
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/preloaded, /obj/item/attachable/stock/rifle/collapsible)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

/obj/item/weapon/gun/rifle/m41aMK1/tactical
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/preloaded, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness, /obj/item/attachable/stock/rifle/collapsible)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

/obj/item/weapon/gun/rifle/m41aMK1/forecon
	desc = "Pulse action 10x24mm caseless assault rifle of the USCMC, personal friend of any Marine. This one is painted in a fresh coat of the newer Humbrol 76 camouflage and is used by Force Reconnaissance & MARSOC units."
	icon_state = "reconm41amk1"
	item_state = "reconm41amk1"
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/recon
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/recon, /obj/item/attachable/stock/rifle/collapsible)

/obj/item/weapon/gun/rifle/m41aMK1/forecon/preloaded
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/recon/preloaded, /obj/item/attachable/stock/rifle/collapsible)

/obj/item/weapon/gun/rifle/m41aMK1/forecon/unloaded
	current_mag = null

/obj/item/weapon/gun/rifle/m41aMK1/army
	desc = "Pulse action 10x24mm caseless assault rifle of the US Army, personal friend of any Trooper. Features an integrated 30mm grenade launcher and ammo tube that can hold four grenades on backup."
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/reddot, /obj/item/attachable/attached_gun/grenade/mk1/preloaded/army)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

/obj/item/weapon/gun/rifle/m41aMK1/army/masterkey
	desc = "Pulse action 10x24mm caseless assault rifle of the US Army, personal friend of any Trooper. This one has a U7 underbarrel shotgun strapped to it."
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/reddot, /obj/item/attachable/attached_gun/shotgun)

/obj/item/weapon/gun/rifle/m41aMK1/navy //m41amk1_navy
	name = "\improper GUU-71/A pulse rifle"
	desc = "A variant of the M41A pulse rifle adopted for use by USASF Security Forces personnel and Master-At-Arms. Features an integrated 30mm grenade launcher and ammo tube that can hold four grenades on backup."
	icon_state = "m41amk1_navy"
	item_state = "m41amk1_navy"
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/preloaded, /obj/item/attachable/stock/rifle/collapsible)
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

/obj/item/weapon/gun/rifle/m41aMK1/navy/tactical
	name = "\improper GUU-71/B pulse rifle"
	desc = "A variant of the M41A pulse rifle adopted for use by USASF personnel whose duties take them off ships frequently. Features an integrated 30mm grenade launcher, flash & sound suppressor, and a carry-handle mounted mag-clamp."
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/preloaded, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness, /obj/item/attachable/stock/rifle/collapsible)

/obj/item/weapon/gun/rifle/m41aMK1/elite
	name = "\improper M41A2 pulse rifle"
	desc = "A modified version M41A pulse rifle re-engineered for better weight and handling, and an high degree of accuracy brought about by a precise two-round burst system."
	icon_state = "m41a2"
	item_state = "m41a2"
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1
	aim_slowdown = SLOWDOWN_ADS_QUICK
	wield_delay = WIELD_DELAY_FAST
	map_specific_decoration = FALSE
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible,/obj/item/attachable/attached_gun/grenade/mk1)
	random_spawn_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)
/obj/item/weapon/gun/rifle/m41aMK1/elite/set_gun_config_values()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/m41aMK1/elite/unloaded
	current_mag = null

/obj/item/weapon/gun/rifle/m41aMK1/elite/unloaded/platoon
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/sling,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
	)
	random_rail_chance = 50
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)
	random_under_chance = 100
	random_spawn_under = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/angledgrip,
	)
	random_muzzle_chance = 50
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
	)

/obj/item/weapon/gun/rifle/m41aMK1/elite/whiteout
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1/heap
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/collapsible, /obj/item/attachable/magnetic_harness, /obj/item/attachable/lasersight, /obj/item/attachable/attached_gun/grenade/mk1)

//AG80 pulse rifle (UPP MK1 equivalent)
//=================================================
//=================================================

/obj/item/weapon/gun/rifle/ag80
	name = "\improper AG80 pulse rifle"
	desc = "Pulse action 9.7x16mm caseless assault rifle of the UPPAC Naval Infantry. Only recently entered service and has yet to see full integration. The design suggests that it is a carbine sibling to the Type-71's rifle role, rather than an outright replacement."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "ag80"
	item_state = "ag80"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/ag80
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot/upp,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex/upp,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/scope/upp,
		/obj/item/attachable/scope/mini/upp,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/attached_gun/grenade/type71/ag80,
		/obj/item/attachable/attached_gun/grenade/type71/ag80/preloaded,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/ag80/collapsible, /obj/item/attachable/attached_gun/grenade/type71/ag80)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/ag80/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 22, "under_x" = 21, "under_y" = 14, "stock_x" = 22, "stock_y" = 14)

/obj/item/weapon/gun/rifle/ag80/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_10
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/ag80/preloaded
	starting_attachment_types = list(/obj/item/attachable/stock/rifle/ag80/collapsible, /obj/item/attachable/attached_gun/grenade/type71/ag80/preloaded)

/obj/item/weapon/gun/rifle/ag80/unloaded
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY
	current_mag = null

//M20A Harrington rifle
//=================================================
//=================================================

/obj/item/weapon/gun/rifle/m20a
	name = "\improper M20A pulse rifle"
	desc = "A predecessor to the M41A pulse rifle still utilized by the UA's Colonial Guard and various other organizations. Aside from its 10x24mm chambering, the 'Harrington' rifle is largely considered to be in every metric the polar opposite of the M41A; featuring an obsolete three-round burst mode, lower magazine size, and it uses an integrated shotgun attachment."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m20a"
	item_state = "m20a"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = "gun_oldpulse"
	current_mag = /obj/item/ammo_magazine/rifle/m20a
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/m20a,
		/obj/item/attachable/attached_gun/shotgun,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_NORMAL
	aim_slowdown = SLOWDOWN_ADS_RIFLE
	starting_attachment_types = list(/obj/item/attachable/stock/m20a,/obj/item/attachable/attached_gun/shotgun/m20a)
	map_specific_decoration = FALSE

/obj/item/weapon/gun/rifle/m20a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 18, "under_y" = 15, "stock_x" = 22, "stock_y" = 15, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/m20a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/m20a/unloaded
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY
	current_mag = null
	starting_attachment_types = list(/obj/item/attachable/stock/m20a,/obj/item/attachable/attached_gun/shotgun/m20a/unloaded)

/obj/item/weapon/gun/rifle/m20a/merc
	name = "\improper M20CW pulse carbine"
	desc = "A heavily modified black market version of the M20A pulse rifle, often used for CQC scenarios where SMGs just aren't cutting it. Comes with an integrated grip instead of an underbarrel shotgun and downsized barrel, alongside the removed stock. It can also now shoot in automatic!"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "m20a_tactical"
	item_state = "m20a_tactical"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/sling,
	)
	starting_attachment_types = list(/obj/item/attachable/sling)
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/m20a/merc/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 14, "under_y" = 15, "stock_x" = 22, "stock_y" = 15, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/m20a/merc/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_8)
	set_burst_amount(BURST_AMOUNT_TIER_1)
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_9
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7

/obj/item/weapon/gun/rifle/m20a/merc/tactical
	starting_attachment_types = list(/obj/item/attachable/sling, /obj/item/attachable/suppressor, /obj/item/attachable/lasersight)

/obj/item/weapon/gun/rifle/m20a/merc/unloaded
	current_mag = null

//----------------------------------------------
//Experimental ARMAT side-grade to the M41A, not standard issue, only used by MARSOC

/obj/item/weapon/gun/rifle/m46c
	name = "\improper XM46A pulse rifle"
	desc = "An experimental improvement of the M41A from ARMAT, the XM46 incorporated a hexagonally rifled barrel, improved compensation, refined ergonomics, and the flagship offering, an intelligent fire control system. In trials it was judged to offer too little over the existing weapon at grossly higher cost, and suspiciously low parts interchange. Rarely seen outside of special mission unit service, and even then uncommon."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m46c"
	item_state = "m46c"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m41aMK1

	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/m41aMK1,
		/obj/item/ammo_magazine/rifle/m41aMK1/recon,
		/obj/item/ammo_magazine/rifle/m41aMK1/ap,
		/obj/item/ammo_magazine/rifle/m41aMK1/incendiary,
		/obj/item/ammo_magazine/rifle/m41aMK1/heap,
		/obj/item/ammo_magazine/rifle/m41aMK1/toxin,
		/obj/item/ammo_magazine/rifle/m41aMK1/penetrating,
		/obj/item/ammo_magazine/rifle/m41aMK1/tracer,
	)
	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Muzzle
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/sling,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip, // Under
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/attached_gun/grenade/mk1/recon,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/stock/rifle/collapsible, // Stock
		/obj/item/attachable/flashlight, // Side Rail
		/obj/item/attachable/lasersight,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	starting_attachment_types = list(/obj/item/attachable/attached_gun/grenade/mk1/recon, /obj/item/attachable/stock/rifle/collapsible)
	start_automatic = TRUE
	map_specific_decoration = FALSE

	var/iff_enabled = TRUE

/obj/item/weapon/gun/rifle/m46c/Initialize(mapload, ...)
	LAZYADD(actions_types, /datum/action/item_action/m46c/toggle_lethal_mode)
	. = ..()
	recalculate_attachment_bonuses()

/obj/item/weapon/gun/rifle/m46c/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff)
	))
	AddComponent(/datum/component/iff_fire_prevention)

/obj/item/weapon/gun/rifle/m46c/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17, "rail_x" = 11, "rail_y" = 19, "under_x" = 24, "under_y" = 12, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 26, "side_rail_y" = 17)

/obj/item/weapon/gun/rifle/m46c/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	fa_max_scatter = SCATTER_AMOUNT_TIER_8


//---ability actions--\\

/datum/action/item_action/m46c/action_activate()
	. = ..()
	var/obj/item/weapon/gun/rifle/m46c/smartrifle = holder_item
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/user = owner
	if(user.is_mob_incapacitated() || smartrifle.get_active_firearm(user, FALSE) != holder_item)
		return

/datum/action/item_action/m46c/update_button_icon()
	return

/datum/action/item_action/m46c/toggle_lethal_mode/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle IFF"
	action_icon_state = "iff_toggle_on"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/m46c/toggle_lethal_mode/action_activate()
	. = ..()
	var/obj/item/weapon/gun/rifle/m46c/smartrifle = holder_item
	smartrifle.toggle_iff(usr)
	if(smartrifle.iff_enabled)
		action_icon_state = "iff_toggle_on"
	else
		action_icon_state = "iff_toggle_off"
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

// -- ability actions procs -- \\

/obj/item/weapon/gun/rifle/m46c/proc/toggle_iff(mob/user)
	iff_enabled = !iff_enabled
	to_chat(usr, SPAN_NOTICE("[icon2html(src, usr)] You [iff_enabled? "enable": "disable"] the IFF on [src]."))
	playsound(loc,'sound/machines/click.ogg', 25, 1)

	if(iff_enabled)
		add_bullet_trait(BULLET_TRAIT_ENTRY_ID("iff", /datum/element/bullet_trait_iff))
	else
		remove_bullet_trait("iff")
	SEND_SIGNAL(src, COMSIG_GUN_IFF_TOGGLED, iff_enabled)

//-------------------------------------------------------
//MAR-40 AK CLONE //AK47 and FN FAL together as one.


/obj/item/weapon/gun/rifle/mar40
	name = "\improper MAR-40 battle rifle"
	desc = "A cheap, reliable assault rifle chambered in 8.8x29mm. Commonly found in the hands of criminals or mercenaries, or in the hands of the UPP or CLF."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "mar40"
	item_state = "mar40"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	reload_sound = 'sound/weapons/handling/gun_mar40_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_mar40_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/mar40
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/scope/slavic,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AUTO_EJECT_CASINGS
	start_automatic = TRUE



/obj/item/weapon/gun/rifle/mar40/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 17,"rail_x" = 16, "rail_y" = 20, "under_x" = 24, "under_y" = 15, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 25, "side_rail_y" = 17)


/obj/item/weapon/gun/rifle/mar40/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/mar40/tactical
	desc = "A cheap, reliable assault rifle chambered in 8.8x29mm. Commonly found in the hands of criminals or mercenaries, or in the hands of the UPP or CLF. This one has been equipped with an after-market ammo-counter."
	starting_attachment_types = list(/obj/item/attachable/angledgrip, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness)
	flags_gun_features = GUN_AMMO_COUNTER|GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/rifle/mar40/carbine
	name = "\improper MAR-30 battle carbine"
	desc = "A cheap, reliable carbine chambered in 8.8x29mm. Commonly found in the hands of criminals or mercenaries."
	icon_state = "mar30"
	item_state = "mar30"
	fire_sound = 'sound/weapons/gun_mar40.ogg'
	reload_sound = 'sound/weapons/handling/gun_mar40_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_mar40_unload.ogg'

	aim_slowdown = SLOWDOWN_ADS_QUICK //Carbine is more lightweight
	wield_delay = WIELD_DELAY_FAST
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
	)

/obj/item/weapon/gun/rifle/mar40/carbine/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/rifle/mar40/carbine/tactical
	desc = "A cheap, reliable carbine chambered in 8.8x29mm. Commonly found in the hands of criminals or mercenaries. This one has been equipped with an after-market ammo-counter."
	starting_attachment_types = list(/obj/item/attachable/verticalgrip, /obj/item/attachable/suppressor, /obj/item/attachable/magnetic_harness)
	flags_gun_features = GUN_AMMO_COUNTER|GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/rifle/mar40/lmg
	name = "\improper MAR-50 light machine gun"
	desc = "A cheap, reliable LMG chambered in 8.8x29mm. Commonly found in the hands of slightly better funded criminals."
	icon_state = "mar50"
	item_state = "mar50"
	mouse_pointer = 'icons/effects/mouse_pointer/lmg_mouse.dmi'

	fire_sound = 'sound/weapons/gun_mar40.ogg'
	reload_sound = 'sound/weapons/handling/gun_mar40_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_mar40_unload.ogg'

	starting_attachment_types = list(/obj/item/attachable/mar50barrel)

	current_mag = /obj/item/ammo_magazine/rifle/mar40/lmg
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/slavic,
	)
	random_spawn_chance = 38
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/slavic,
		/obj/item/attachable/magnetic_harness,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/rifle/mar40/lmg/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 16,"rail_x" = 16, "rail_y" = 20, "under_x" = 26, "under_y" = 16, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 25, "side_rail_y" = 17)

/obj/item/weapon/gun/rifle/mar40/lmg/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_5)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/mar40/lmg/tactical
	desc = "A cheap, reliable  chambered in 8.8x29mm. Commonly found in the hands of slightly better funded criminals. This one has been equipped with an after-market ammo-counter."
	starting_attachment_types = list(/obj/item/attachable/mar50barrel, /obj/item/attachable/bipod, /obj/item/attachable/magnetic_harness)
	flags_gun_features = GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY|GUN_AUTO_EJECT_CASINGS
//-------------------------------------------------------
//M16 RIFLE

/obj/item/weapon/gun/rifle/m16
	name = "\improper M16 rifle"
	desc = "The manufacturer claims that these are Classic 16 assault rifles. It's another one of the clonetypes you see on the Frontier since the AR-15 patent expired over a century ago. Chambered in 5.56x45mm, popular on the Frontier for home defense and hunting. The old cased rounds can also be used till they disintegrate, if you can be bothered to police the brass."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "m16"
	item_state = "m16"

	fire_sound = 'sound/weapons/gun_m16.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m16_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/m16
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/grenade,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/m16,
	)
	random_spawn_chance = 42
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex/,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/bipod,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
	)
	random_spawn_siderail = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ANTIQUE|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/rifle/m16/handle_starting_attachment()
	..()
	var/obj/item/attachable/stock/m16/S = new(src)
	S.hidden = FALSE
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/rifle/m16/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 9, "rail_y" = 20, "under_x" = 22, "under_y" = 14, "stock_x" = 15, "stock_y" = 14, "side_rail_x" = 25, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/m16/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_10
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/m16/grenadier
	name = "\improper M16 grenadier rifle"
	desc = "The little worn and faded sticker on the lower receiver claims that this is a Mustang Special, Little Friend Edition. Point is, it's an M16 repro with an irremovable M203 underslung. 40mm, careful where you point it."
	icon_state = "m16g"
	item_state = "m16"
	fire_sound = 'sound/weapons/gun_m16.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m16_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m16
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/attached_gun/grenade/m203,
	)
	random_spawn_chance = 42
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex/,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/m16/grenadier/handle_starting_attachment()
	..()
	var/obj/item/attachable/attached_gun/grenade/m203/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.hidden = FALSE
	integrated.Attach(src)
	update_attachable(integrated.slot)

//-------------------------------------------------------
//XM177 carbine
//awesome vietnam era special forces carbine version of the M16

/obj/item/weapon/gun/rifle/xm177
	name = "\improper XM177 carbine"
	desc = "5.56x45mm carbine. Either this is a really cheap replica of the old XM177, someone's crappy DIY modification, or somehow an actual genuine antique which probably is worth at least a couple grand to a museum. Who knows?"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "xm177"
	item_state = "m16"
	current_mag = /obj/item/ammo_magazine/rifle/m16

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ANTIQUE|GUN_AUTO_EJECT_CASINGS

	fire_sound = 'sound/weapons/gun_m16.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_m16_unload.ogg'
	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/m16,
		/obj/item/ammo_magazine/rifle/m16/ap,
	)

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/stock/m16/xm177,
	)

	random_spawn_chance = 75
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex/,
	)
	random_spawn_under = list(
		/obj/item/attachable/verticalgrip,
	)
	random_spawn_siderail = list(
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/rifle/xm177/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 18,"rail_x" = 9, "rail_y" = 20, "under_x" = 19, "under_y" = 13, "stock_x" = 15, "stock_y" = 14, "side_rail_x" = 21, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/xm177/handle_starting_attachment()
	..()
	var/obj/item/attachable/stock/m16/xm177/integrated = new(src)
	integrated.hidden = FALSE
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.Attach(src)
	update_attachable(integrated.slot)

/obj/item/weapon/gun/rifle/xm177/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_SMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

//-------------------------------------------------------
//AR10 rifle
//basically an early M16

/obj/item/weapon/gun/rifle/ar10
	name = "\improper AR10 rifle"
	desc = "An earlier version of the more widespread M16 rifle. Considered to be the father of the 20th century rifle. How one of these ended up here is a mystery of its own. It is chambered in 7.62x51mm."
	desc_lore = "The AR10 was initially manufactured by the Armalite corporation (bought by Weyland-Yutani in 2002) in the 1950s. It was the first production rifle to incorporate many new and innovative features, such as a gas operated bolt and carrier system. Only 10,000 were ever produced, and the only national entities to use them were Portugal and Sudan. Since the end of the 20th century, these rifles - alongside the far more common M16 and AR15 - have floated around the less civillised areas of space, littering jungles and colony floors with their uncommon cased ammunition - a rarity since the introduction of pulse munitions. This rifle has the word \"Salazar\" engraved on its side."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "ar10"
	item_state = "ar10"
	fire_sound = 'sound/weapons/gun_ar10.ogg'
	reload_sound = 'sound/weapons/handling/gun_m16_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_ar10_unload.ogg'
	cocked_sound = 'sound/weapons/handling/gun_ar10_cocked.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/ar10
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/stock/ar10,
	)
	random_spawn_chance = 10
	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex/,
		/obj/item/attachable/scope/mini,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/bipod,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_ANTIQUE|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/rifle/ar10/handle_starting_attachment()
	..()
	var/obj/item/attachable/stock/ar10/S = new(src)
	S.hidden = FALSE
	S.flags_attach_features &= ~ATTACH_REMOVABLE
	S.Attach(src)
	update_attachable(S.slot)

/obj/item/weapon/gun/rifle/ar10/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 8, "rail_y" = 20, "under_x" = 22, "under_y" = 14, "stock_x" = 15, "stock_y" = 14, "side_rail_x" = 27, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/ar10/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_7)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_8
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_10
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_9
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

//-------------------------------------------------------
//DUTCH'S GEAR

/obj/item/weapon/gun/rifle/m16/dutch
	name = "\improper Dutch's M16A1"
	desc = "A modified M16 employed by Dutch's Dozen mercenaries. It has 'CLOAKER KILLER' printed on a label on the side. Chambered in 5.56x45mm."
	icon_state = "m16a1"
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap
	starting_attachment_types = list(/obj/item/attachable/bayonet)

	random_spawn_rail = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex/,
	)
	random_spawn_under = list(
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/lasersight,
	)
	random_spawn_muzzle = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/m16/dutch/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/rifle/m16/grenadier/dutch
	name = "\improper Dutch's Grenadier M16A1"
	desc = "A modified M16 employed by Dutch's Dozen mercenaries. It has 'CLOAKER KILLER' printed on a label on the side. It is chambered in 5.56x45mm. This one has an irremovable M203 grenade launcher attached to it, holds one propriatary 40mm shell at a time, it lacks modern IFF systems and will impact the first target it hits; introduce your little friend."
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap
	starting_attachment_types = list(/obj/item/attachable/scope/mini, /obj/item/attachable/bayonet)

/obj/item/weapon/gun/rifle/m16/grenadier/dutch/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/rifle/xm177/dutch
	name = "\improper Dutch's XM177E2 Carbine"
	desc = "A modified XM177 employed by Dutch's Dozen mercenaries. It has 'CLOAKER KILLER' printed on a label on the side. It is chambered in 5.56x45mm. The short length inhibits the attachment of most underbarrel attachments, and the barrel moderator prohibits the attachment of all muzzle devices."
	desc_lore = "A carbine similar to the M16A1, with a collapsible stock and a distinct flash suppressor. A stamp on the receiver reads: 'COLT AR-15 - PROPERTY OF U.S. GOVT - XM177E2 - CAL 5.56MM', above the receiver is a crude sketching of some sort of mask? with the words 'CLOAKER KILLER' and seven tally marks etched on. \nA design originating from the Vietnam War, the XM177, also known as the Colt Commando or GAU-5/A, was an improvement on the CAR-15 Model 607, fixing multiple issues found with the limited service of the Model 607 with Special Forces. The XM177 saw primary use with Army Special Forces and Navy Seals operating as commandos. \nHow this got here is a mystery."
	icon_state = "xm177"
	current_mag = /obj/item/ammo_magazine/rifle/m16/ap

/obj/item/weapon/gun/rifle/xm177/dutch/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_SMG)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_3
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2


//-------------------------------------------------------
//M41AE2 HEAVY PULSE RIFLE

/obj/item/weapon/gun/rifle/lmg
	name = "\improper M41AE2 heavy pulse rifle"
	desc = "Heavy barreled higher capacity variant of the M41A. Greater sustained firepower and total ammunition carried, offset by removal of the grenade launcher and worsened handling."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m41ae2"
	item_state = "m41ae2"
	mouse_pointer = 'icons/effects/mouse_pointer/lmg_mouse.dmi'

	reload_sound = 'sound/weapons/handling/hpr_reload.ogg'
	unload_sound = 'sound/weapons/handling/hpr_unload.ogg'
	fire_sound = "gun_pulse"
	aim_slowdown = SLOWDOWN_ADS_LMG
	accepted_ammo = list(
		/obj/item/ammo_magazine/hpr_box,
		/obj/item/ammo_magazine/hpr_box/ap,
		/obj/item/ammo_magazine/hpr_box/heap,
		/obj/item/ammo_magazine/hpr_box/holo_target,
		/obj/item/ammo_magazine/hpr_box/recon,
		/obj/item/ammo_magazine/rifle/m41aMK1,
		/obj/item/ammo_magazine/rifle/m41aMK1/recon,
		/obj/item/ammo_magazine/rifle/m41aMK1/rubber,
		/obj/item/ammo_magazine/rifle/m41aMK1/ap,
		/obj/item/ammo_magazine/rifle/m41aMK1/incendiary,
		/obj/item/ammo_magazine/rifle/m41aMK1/heap,
		/obj/item/ammo_magazine/rifle/m41aMK1/toxin,
		/obj/item/ammo_magazine/rifle/m41aMK1/penetrating,
		/obj/item/ammo_magazine/rifle/m41aMK1/tracer,
	)
	current_mag = /obj/item/ammo_magazine/hpr_box
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/bipod/integral,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/sling,
	)
	starting_attachment_types = list(
		/obj/item/attachable/bipod/integral,
		/obj/item/attachable/stock/rifle/collapsible,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	gun_category = GUN_CATEGORY_HEAVY
	start_automatic = TRUE
	bonus_overlay_x = -1
	bonus_overlay_y = -1

/obj/item/weapon/gun/rifle/lmg/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 23, "under_x" = 26, "under_y" = 16, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 27, "side_rail_y" = 18)

/obj/item/weapon/gun/rifle/lmg/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SMG2)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	//hopefully, this will give it some reason to not just hold down trigger? Long lethal bursts.
	fa_scatter_peak = FULL_AUTO_SCATTER_PEAK_TIER_2
	fa_max_scatter = SCATTER_AMOUNT_TIER_1
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_4
	burst_scatter_mult = -SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_1
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_5
	aim_slowdown = SLOWDOWN_ADS_LMG
	wield_delay = WIELD_DELAY_SLOW

/obj/item/weapon/gun/rifle/lmg/tactical
	desc = "A modification of a modification. Swaps the bipod for a grip, returning it closer to its original assault rifle state."
	current_mag = /obj/item/ammo_magazine/hpr_box/ap
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/sling,
	)
	starting_attachment_types = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/angledgrip,
	)

/obj/item/weapon/gun/rifle/lmg/tactical/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2//equal to m41a dmg

/obj/item/weapon/gun/rifle/lmg/tactical/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 23, "under_x" = 26, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)

/obj/item/weapon/gun/rifle/lmg/army
	desc = "The US Army's adoption of the M41AE2 adds a longer barrel and improved retention system, operating in a more traditional machine gun role."
	current_mag = /obj/item/ammo_magazine/hpr_box/ap
	starting_attachment_types = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/bipod/integral,
	)

/obj/item/weapon/gun/rifle/lmg/army/set_gun_config_values()
	..()
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2//equal to m41a dmg

/obj/item/weapon/gun/rifle/lmg/recon
	desc = "Heavy barreled higher capacity variant of the M41A. Greater sustained firepower and total ammunition carried, offset by removal of the grenade launcher and worsened handling. This one is painted in a fresh coat of the newer Humbrol 76 camouflage and is used by Force Reconnaissance units, while sporting a vertical grip in place of an integrated bipod."
	icon_state = "m41ae2_recon"
	item_state = "m41ae2_recon"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/sling,
	)
	starting_attachment_types = list(
		/obj/item/attachable/stock/rifle/collapsible,
		/obj/item/attachable/verticalgrip,
	)

/obj/item/weapon/gun/rifle/lmg/recon/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 23, "under_x" = 24, "under_y" = 11, "stock_x" = 24, "stock_y" = 13)
//-------------------------------------------------------


//-------------------------------------------------------
//UPP TYPE 71 RIFLE

/obj/item/weapon/gun/rifle/type71
	name = "\improper Type 71 pulse rifle"
	desc = "The service rifle of the UPP, the Type 71 is an ergonomic, lightweight pulse rifle chambered in 10x27mm, packing a harder punch than the USCM M41A which balances out a lower firerate. Despite lackluster precision, an integrated recoil-dampening mechanism makes the rifle surprisingly controllable in bursts."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "type71"
	item_state = "type71"

	fire_sound = 'sound/weapons/gun_type71.ogg'
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/type71
	wield_delay = WIELD_DELAY_FAST
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness, // Rail
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/scope/upp,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/upp,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/upp,
		/obj/item/attachable/reflex,
		/obj/item/attachable/reflex/upp,
		/obj/item/attachable/suppressor, // Muzzle
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/verticalgrip, // Underbarrel
		/obj/item/attachable/verticalgrip/upp,
		/obj/item/attachable/flashlight/grip/upp,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/attached_gun/flamer,
		/obj/item/attachable/attached_gun/flamer/advanced,
		/obj/item/attachable/attached_gun/extinguisher,
		/obj/item/attachable/attached_gun/grenade/type71,
		/obj/item/attachable/attached_gun/grenade/type71/preloaded,
		/obj/item/attachable/lasersight, // Side Rail
		/obj/item/attachable/lasersight/upp,
		/obj/item/attachable/flashlight,
		)
	starting_attachment_types = list(/obj/item/attachable/stock/type71, /obj/item/attachable/attached_gun/grenade/type71)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	flags_equip_slot = SLOT_BACK
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/type71/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 17,"rail_x" = 10, "rail_y" = 23, "under_x" = 20, "under_y" = 13, "stock_x" = 11, "stock_y" = 13, "side_rail_x" = 23, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/type71/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(BURST_AMOUNT_TIER_4)
	set_burst_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_3


/obj/item/weapon/gun/rifle/type71/preloaded
	starting_attachment_types = list(/obj/item/attachable/stock/type71, /obj/item/attachable/attached_gun/grenade/type71/preloaded)

/obj/item/weapon/gun/rifle/type71/unloaded
	current_mag = null
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY

/obj/item/weapon/gun/rifle/type71/carbine
	name = "\improper Type 71 'Commando' pulse rifle"
	desc = "A much rarer variant of the Type 71, this version contains an integrated suppressor, integrated scope, and extensive fine-tuning. Many parts have been replaced, filed down, and improved upon. As a result, this variant is rarely seen outside of commando units."
	icon_state = "type73"
	item_state = "type73"
	fire_sound = "gun_silenced"
	wield_delay = 0 //Ends up being .5 seconds due to scope
	wield_delay = WIELD_DELAY_VERY_FAST
	inherent_traits = list(TRAIT_GUN_SILENCED)
	bonus_overlay_x = 2
	force = 20 //integrated melee mod from stock, which doesn't fit on the gun but is still clearly there on the sprite
	attachable_allowed = list(
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/verticalgrip/upp,
	)
	random_spawn_chance = 0
	random_spawn_rail = list()
	random_spawn_muzzle = list()
	bonus_overlay_x = 1
	bonus_overlay_y = 0
	starting_attachment_types = list(/obj/item/attachable/stock/type71, /obj/item/attachable/type73suppressor, /obj/item/attachable/scope/mini/upp)

/obj/item/weapon/gun/rifle/type71/carbine/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_7
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	scatter = SCATTER_AMOUNT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/rifle/type71/carbine/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 17,"rail_x" = 10, "rail_y" = 22, "under_x" = 23, "under_y" = 14, "stock_x" = 21, "stock_y" = 18, "side_rail_x" = 24, "side_rail_y" = 17)

/obj/item/weapon/gun/rifle/lw317
	name = "\improper LW-317 pulse carbine"
	desc = "Light Weapon, Type 317. Originating from Norcomm before the CANC's absorption, the Type 317 served the CANC's arsenals for close quarters battle. Also preferred for its ease of use among former CANC soldiers."
	desc_lore = "Despite UPP's best efforts to destroy leftover CANC weapon caches from the Dog War, Chinese weaponry frequently comes up on the black market, which makes it a solid choice for any rebel and even more so for revanchist CANC restoration supporters."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "lw317"
	item_state = "lw317"
	fire_sound = 'sound/weapons/gun_lw317.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/lw317
	attachable_allowed = list(
		/obj/item/attachable/scope, // Rail
		/obj/item/attachable/scope/upp,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/upp,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reddot/upp,
		/obj/item/attachable/reflex,
		/obj/item/attachable/reflex/upp,
		/obj/item/attachable/suppressor, // Muzzle
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/bayonet/canc,
		/obj/item/attachable/verticalgrip, // Underbarrel
		/obj/item/attachable/verticalgrip/upp,
		/obj/item/attachable/flashlight/grip/upp,
		)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	flags_equip_slot = SLOT_BACK
	start_automatic = TRUE

/obj/item/weapon/gun/rifle/lw317/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/rifle/lw317/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 17,"rail_x" = 16, "rail_y" = 23, "under_x" = 25, "under_y" = 12, "stock_x" = 21, "stock_y" = 18, "side_rail_x" = 24, "side_rail_y" = 17)

/obj/item/weapon/gun/rifle/lw317/dmr
	name = "\improper LW/RS-317 pulse carbine"
	desc = "Light Weapon, Rifle, Sniper, Type 317. Modification of Type 317 carbine, this unorthodox DMR was developed in order to provide long-range support to guerilla fighting groups. Modified internal mechanism allows for improved accuracy, but because of that rate of fire is impeded severely."
	current_mag = /obj/item/ammo_magazine/rifle/lw317/ap
	start_automatic = FALSE
	attachable_allowed = list(
		/obj/item/attachable/scope/variable_zoom/canc,
		/obj/item/attachable/lw317barrel,
		/obj/item/attachable/verticalgrip, // Underbarrel
		/obj/item/attachable/verticalgrip/upp,
		/obj/item/attachable/flashlight/grip/upp,
		)

/obj/item/weapon/gun/rifle/lw317/dmr/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_SNIPER)
	set_burst_amount(BURST_AMOUNT_TIER_1)
	accuracy_mult = BASE_ACCURACY_MULT * 3
	scatter = SCATTER_AMOUNT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/lw317/dmr/handle_starting_attachment()
	..()
	var/obj/item/attachable/barrel = new /obj/item/attachable/lw317barrel(src)
	barrel.flags_attach_features &= ~ATTACH_REMOVABLE
	barrel.Attach(src)
	update_attachable(barrel.slot)

	var/obj/item/attachable/scope/variable_zoom/canc/scope = new(src)
	scope.flags_attach_features &= ~ATTACH_REMOVABLE
	scope.Attach(src)
	update_attachable(scope.slot)

	//-------------------------------------------------------

//M49A Battle Rifle, standard USCM DMR

/obj/item/weapon/gun/rifle/m49a
	name = "\improper M49A battle rifle"
	desc = "The M49A battle rifle is a designated marksman rifle in service with the USCM. Sporting a bullpup configuration, the M49A battle rifle is perfect for reconnaissance and fire support teams.\nTakes *only* non-high-velocity M49A magazines."
	icon_state = "m49a"
	item_state = "m49a"
	mouse_pointer = 'icons/effects/mouse_pointer/sniper_mouse.dmi'

	fire_sound = 'sound/weapons/gun_m49a.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'

	current_mag = /obj/item/ammo_magazine/rifle/m49a
	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Barrel
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/army,
		/obj/item/attachable/scope/pve,
		/obj/item/attachable/scope/mini_iff,
		/obj/item/attachable/sling,
		/obj/item/attachable/bipod, // Under
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/attached_gun/grenade/mk1/recon,
		/obj/item/attachable/lasersight, // Side Rail
		/obj/item/attachable/flashlight,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	//map_specific_decoration = TRUE

/obj/item/weapon/gun/rifle/m49a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 21, "under_x" = 30, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 31, "side_rail_y" = 18, "special_x" = 37, "special_y" = 16)

/obj/item/weapon/gun/rifle/m49a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_4)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_4
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/m49a/handle_starting_attachment()
	..()
	var/obj/item/attachable/m49a_barrel/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.Attach(src)
	update_attachable(integrated.slot)

/obj/item/weapon/gun/rifle/m49a/training
	current_mag = /obj/item/ammo_magazine/rifle/m49a/rubber

/obj/item/weapon/gun/rifle/m49a/tactical
	current_mag = /obj/item/ammo_magazine/rifle/m49a/ext
	starting_attachment_types = list(/obj/item/attachable/magnetic_harness, /obj/item/attachable/suppressor, /obj/item/attachable/angledgrip)

/obj/item/weapon/gun/rifle/m49a/marksman
	starting_attachment_types = list(/obj/item/attachable/scope/variable_zoom, /obj/item/attachable/extended_barrel)

/obj/item/weapon/gun/rifle/m49a/army
	desc = "The M49A battle rifle is a designated marksman rifle used by multiple branches of the UA armed forces. Sporting a bullpup configuration, the M49A battle rifle is perfect for reconnaissance and fire support teams."
	current_mag = /obj/item/ammo_magazine/rifle/m49a/ap
	starting_attachment_types = list(/obj/item/attachable/scope/mini/army, /obj/item/attachable/extended_barrel, /obj/item/attachable/angledgrip)

/obj/item/weapon/gun/rifle/m49a/forecon
	name = "\improper M49A2 battle rifle"
	desc = "An early modification of the M49A marksman rifle, the A2 has a tweaked gas-system and fire-control-group, giving it better cyclic rate and a two round burst-fire mode. Fielded almost exclusively by FORECON units in the USCM. This one is painted in a fresh coat of the newer Humbrol 76 camouflage."
	current_mag = /obj/item/ammo_magazine/rifle/m49a/ext
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/extended_barrel, /obj/item/attachable/verticalgrip)
	map_specific_decoration = FALSE
	icon = 'icons/obj/items/weapons/guns/guns_by_map/jungle/guns_obj.dmi'
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/items/weapons/guns/guns_by_map/jungle/guns_lefthand.dmi',
		WEAR_R_HAND = 'icons/obj/items/weapons/guns/guns_by_map/jungle/guns_righthand.dmi',
		WEAR_BACK = 'icons/obj/items/weapons/guns/guns_by_map/jungle/back.dmi'
	)

/obj/item/weapon/gun/rifle/m49a/forecon/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_8)

/obj/item/weapon/gun/rifle/m49a/forecon/handle_starting_attachment()
	..()
	var/obj/item/attachable/m49a_barrel/forecon/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	var/obj/item/attachable/old_barrel = attachments[integrated.slot]
	if(old_barrel)
		old_barrel.Detach(detaching_gub = src, drop_attachment = FALSE)
		qdel(old_barrel)
	integrated.Attach(src)
	update_attachable(integrated.slot)

// pve - kinda weird icon usage, uses urban M49A sprite w/ custom attachie sprite
/obj/item/weapon/gun/rifle/m49a/pve
	name = "\improper M49A6 battle rifle"
	desc = "The M49A6 is a souped-up M49A, the result of an ARMAT upgrade program that didn't pan out in huge numbers. Its main attraction is the ability to chamber and fire devastating <b>A19 depleted uranium rounds,</b> infamous for their overpenetration abilities and toxic effects on anyone unfortunate enough to survive a hit. The thicker barrel, of course, also has no issue with standard & regular HV ammo."
	desc_lore = "The USCMC was not terribly enthusiastic about unproven hand-held plasma weaponry. Before the XM99A was eventually adopted into use, the USCMC instead sought out a traditional squad-portable, precision, armor-piercing weapon, and contracted ARMAT to upgrade their M49A platform to be capable of firing advanced AP rounds. They succeeded- sort of. <BR> <BR>  The A6 was rejected for several reasons. It's a killer, but also a piece of junk. It kicks hard enough that precision sights simply don't stay zeroed, and its oversized muzzle-device extends an already long barrel-length. Additionally, A19 ammo, already expensive, was driven to absurd highs by the ammunition's specs. Depleted uranium is expensive...and cutting the service life of the M49A's barrel in half is even more expensive. <BR> <BR> Those that were made, however, are still service-ready and were issued where the XM99A was unavailable due to its production only just starting."
	icon = 'icons/obj/items/weapons/guns/guns_by_map/urban/guns_obj.dmi'
	icon_state = "m49a"
	item_state = "m49a"
	fire_sound = 'sound/weapons/gun_m49a.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'

	accepted_ammo = list(
		/obj/item/ammo_magazine/rifle/m49a,
		/obj/item/ammo_magazine/rifle/m49a/ap,
		/obj/item/ammo_magazine/rifle/m49a/ext,
		/obj/item/ammo_magazine/rifle/m49a/rubber,
		/obj/item/ammo_magazine/rifle/m49a/incendiary,
		/obj/item/ammo_magazine/rifle/m49a/heap,
		/obj/item/ammo_magazine/rifle/m49a/penetrating,
		/obj/item/ammo_magazine/rifle/m49a/custom,
		/obj/item/ammo_magazine/rifle/m49a/custom/incendiary,
		/obj/item/ammo_magazine/rifle/m49a/custom/explosive,
		/obj/item/ammo_magazine/rifle/m49a/custom/pve,
	)

	current_mag = /obj/item/ammo_magazine/rifle/m49a/custom/pve

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	map_specific_decoration = FALSE

/obj/item/weapon/gun/rifle/m49a/pve/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_4)
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_1 //Chunky barrel for better muzzle velocity, but not as good as the custom one
	recoil_unwielded = RECOIL_AMOUNT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_3

// obnoxiously enough, need to do this manually...
	item_icons = list(
		WEAR_L_HAND = 'icons/obj/items/weapons/guns/guns_by_map/urban/guns_lefthand.dmi',
		WEAR_R_HAND = 'icons/obj/items/weapons/guns/guns_by_map/urban/guns_righthand.dmi',
		WEAR_BACK = 'icons/obj/items/weapons/guns/guns_by_map/urban/back.dmi'
	)

/obj/item/weapon/gun/rifle/m49a/pve/handle_starting_attachment()
	..()
	var/obj/item/attachable/m49a_barrel/pve/integrated = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	var/obj/item/attachable/old_barrel = attachments[integrated.slot]
	if(old_barrel)
		old_barrel.Detach(detaching_gub = src, drop_attachment = FALSE)
		qdel(old_barrel)
	integrated.Attach(src)
	update_attachable(integrated.slot)

/obj/item/weapon/gun/rifle/m49a/pve/unloaded
	current_mag = null
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_TRIGGER_SAFETY

//-------------------------------------------------------

//L42A Battle Rifle

/obj/item/weapon/gun/rifle/l42a
	name = "\improper L42A pulse rifle"
	desc = "The L42A pulse rifle, despite its age, remains a common 'sporting' rifle among UA citizens and a reliable alternative to more contemporary rifles for many mercenaries."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "l42mk1"
	item_state = "l42mk1"
	fire_sound = 'sound/weapons/gun_m39.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/l42a
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/carbine,
		/obj/item/attachable/stock/carbine/wood,
		/obj/item/attachable/bipod,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini_iff,
		/obj/item/attachable/flashlight/grip,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_VERY_FAST
	aim_slowdown = SLOWDOWN_ADS_QUICK
	starting_attachment_types = list(/obj/item/attachable/stock/carbine)
	map_specific_decoration = FALSE

/obj/item/weapon/gun/rifle/l42a/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 19,"rail_x" = 12, "rail_y" = 20, "under_x" = 18, "under_y" = 15, "stock_x" = 22, "stock_y" = 10, "side_rail_x" = 22, "side_rail_y" = 17)

/obj/item/weapon/gun/rifle/l42a/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(0)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	damage_falloff_mult = 0
	scatter = SCATTER_AMOUNT_TIER_8

/obj/item/weapon/gun/rifle/l42a/training
	current_mag = /obj/item/ammo_magazine/rifle/l42a/rubber

//-------------------------------------------------------
//-------------------------------------------------------
//ABR-40 hunting rifle

// Civilian version of the L42A, used for hunting, and also by undersupplied paramilitary groups.

/obj/item/weapon/gun/rifle/l42a/abr40
	name = "\improper ABR-40 hunting rifle"
	desc = "The civilian version of the L42A battle rifle. Almost identical and even cross-compatible with L42 magazines, just don't take the stock off.."
	desc_lore = "The ABR-40 was created along-side the L42A as a hunting rifle for civilians. Sporting faux wooden furniture and a legally-mandated 12 round magazine, it's still highly accurate and deadly, a favored pick of experienced hunters and retired Marines. However, it's very limited in attachment selection, only being able to fit rail attachments, and the differences in design from the L42 force an awkward pose when attempting to hold it one-handed. Removing the stock is not recommended."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "abr40"
	item_state = "abr40"
	current_mag = /obj/item/ammo_magazine/rifle/l42a/abr40
	attachable_allowed = list(
		//Barrel,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		//Rail,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/hunting,
		//Stock,
		/obj/item/attachable/stock/carbine,
		/obj/item/attachable/stock/carbine/wood,
		/obj/item/attachable/stock/carbine/wood/tactical,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER
	wield_delay = WIELD_DELAY_FAST
	starting_attachment_types = list(/obj/item/attachable/stock/carbine/wood, /obj/item/attachable/scope/mini/hunting)
	map_specific_decoration = FALSE
	civilian_usable_override = TRUE

// Identical to the L42 in stats, *except* for extra recoil and scatter that are nulled by keeping the stock on.
/obj/item/weapon/gun/rifle/l42a/abr40/set_gun_config_values()
	..()
	accuracy_mult = (BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5) - HIT_ACCURACY_MULT_TIER_10
	recoil = RECOIL_AMOUNT_TIER_4
	scatter = (SCATTER_AMOUNT_TIER_8) + SCATTER_AMOUNT_TIER_5


/obj/item/weapon/gun/rifle/l42a/abr40/tactical
	desc = "The civilian version of the L42A battle rifle that is often wielded by Marines. Almost identical and even cross-compatible with L42 magazines, just don't take the stock off. This rifle seems to have unique tacticool blue-black furniture alongside some miscellaneous aftermarket modding."
	desc_lore = "The ABR-40 was created after the striking popularity of the L42 battle rifle as a hunting rifle for civilians, and naturally fell into the hands of many underfunded paramilitary groups and insurrections in turn, due to its smooth and simple handling and cross-compatibility with L42A magazines."
	icon_state = "abr40_tac"
	item_state = "abr40_tac"
	current_mag = /obj/item/ammo_magazine/rifle/l42a/ap
	attachable_allowed = list(
		//Barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		//Rail,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/mini/hunting,
		//Under,
		/obj/item/attachable/flashlight/grip,
		//Stock,
		/obj/item/attachable/stock/carbine,
		/obj/item/attachable/stock/carbine/wood,
		/obj/item/attachable/stock/carbine/wood/tactical,
	)
	starting_attachment_types = list(/obj/item/attachable/stock/carbine/wood/tactical, /obj/item/attachable/suppressor)
	random_spawn_chance = 100
	random_spawn_rail = list(
		/obj/item/attachable/reflex,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini/hunting,
	)
	random_under_chance = 50
	random_spawn_under = list(/obj/item/attachable/flashlight/grip)

/obj/item/weapon/gun/rifle/l42a/abr40/tactical/assassin
	starting_attachment_types = list(/obj/item/attachable/stock/carbine/wood/tactical, /obj/item/attachable/scope/mini/hunting, /obj/item/attachable/suppressor)

//=OLD ROYAL MARINES RIFLES=\\

/obj/item/weapon/gun/rifle/rmc_f90
	name = "\improper F903A1 Rifle"
	desc = "The old standard-issue rifle of the royal marines, now commonly seen in the hands of private military contractors or insurgent groups. Prior to the adoption of the L23A1, the royal marines were the only modern military to not use a pulse weapon. Uses 10x24mm caseless ammunition."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/twe_guns.dmi'
	icon_state = "aug"
	item_state = "aug"
	fire_sound = "gun_pulse"
	reload_sound = 'sound/weapons/handling/m41_reload.ogg'
	unload_sound = 'sound/weapons/handling/m41_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/rmc_f90
	flags_equip_slot = NO_FLAGS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
		/obj/item/attachable/bayonet/wy,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/magnetic_harness,
	)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	map_specific_decoration = FALSE
	aim_slowdown = SLOWDOWN_ADS_QUICK

/obj/item/weapon/gun/rifle/rmc_f90/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16,"rail_x" = 15, "rail_y" = 21, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 25, "side_rail_y" = 16)


/obj/item/weapon/gun/rifle/rmc_f90/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_11
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/rifle/rmc_f90/a_grip
	name = "\improper F903A2 Rifle"
	desc = "A variant of the old standard-issue rifle of the royal marines, now commonly seen in the hands of private military contractors or insurgent groups. Prior to the adoption of the L23A1, the royal marines were the only modern military to not use a pulse weapon. Uses 10x24mm caseless ammunition."
	icon_state = "aug_com"
	item_state = "aug_com"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/rifle/rmc_f90/a_grip/handle_starting_attachment()
	..()
	var/obj/item/attachable/angledgrip/f90_agrip = new(src)
	f90_agrip.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_agrip.hidden = TRUE
	f90_agrip.Attach(src)
	update_attachable(f90_agrip.slot)

/obj/item/weapon/gun/rifle/rmc_f90/scope
	name = "\improper F903A1 Marksman Rifle"
	desc = "A variant of the old standard-issue rifle of the royal marines, now commonly seen in the hands of private military contractors or insurgent groups. Prior to the adoption of the L23A1, the royal marines were the only modern military to not use a pulse weapon. Only accepts smaller 20-round magazines of 10x24mm caseless ammunition."
	icon_state = "aug_dmr"
	item_state = "aug_dmr"
	attachable_allowed = null
	current_mag = /obj/item/ammo_magazine/rifle/rmc_f90/marksman

/obj/item/weapon/gun/rifle/rmc_f90/scope/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = 0
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_8
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/rmc_f90/scope/handle_starting_attachment()
	..()
	var/obj/item/attachable/scope/mini/f90/f90_scope = new(src)
	var/obj/item/attachable/angledgrip/f90_agrip = new(src)
	var/obj/item/attachable/f90_dmr_barrel/f90_dmr_barrel = new(src)
	f90_scope.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_agrip.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_dmr_barrel.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_scope.hidden = TRUE
	f90_agrip.hidden = TRUE
	f90_dmr_barrel.hidden = FALSE
	f90_agrip.Attach(src)
	f90_scope.Attach(src)
	f90_dmr_barrel.Attach(src)
	update_attachable(f90_agrip.slot)
	update_attachable(f90_scope.slot)
	update_attachable(f90_dmr_barrel.slot)

/obj/item/weapon/gun/rifle/rmc_f90/shotgun
	name = "\improper F903A1/B 'Breacher' Rifle"
	desc = "A variant of the old standard-issue rifle of the royal marines fitted with an underbarrel shotgun, now commonly seen in the hands of private military contractors or insurgent groups. Prior to the adoption of the L23A1, the royal marines were the only modern military to not use a pulse weapon. Uses 10x24mm caseless ammunition."
	icon_state = "aug_mkey"
	item_state = "aug_mkey"
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
	)

/obj/item/weapon/gun/rifle/rmc_f90/shotgun/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	burst_amount = BURST_AMOUNT_TIER_3
	burst_delay = FIRE_DELAY_TIER_11
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4 + 2*HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_2
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil_unwielded = RECOIL_OFF

/obj/item/weapon/gun/rifle/rmc_f90/shotgun/handle_starting_attachment()
	..()
	var/obj/item/attachable/attached_gun/shotgun/f90_shotgun = new(src)
	var/obj/item/attachable/f90_dmr_barrel/f90_shotgun_barrel = new(src)
	f90_shotgun.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_shotgun_barrel.flags_attach_features &= ~ATTACH_REMOVABLE
	f90_shotgun_barrel.hidden = FALSE
	f90_shotgun.hidden = TRUE
	f90_shotgun.Attach(src)
	f90_shotgun_barrel.Attach(src)
	update_attachable(f90_shotgun.slot)
	update_attachable(f90_shotgun_barrel.slot)

//Intermediate Support Rifle
//=================================================
//=================================================

/obj/item/weapon/gun/rifle/isr
	name = "\improper MK.7 ISR LMG"
	desc = "The Intermediate Support Rifle, or ISR, was developed after contractors operating the MAR platform of firearms complained about its deficiencies. Whilst it is technically just a step above the standard MAR... it's not by much."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "isr"
	item_state = "isr"
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	fire_sound = "gun_oldpulse"
	current_mag = /obj/item/ammo_magazine/rifle/isr
	starting_attachment_types = list(/obj/item/attachable/stock/isr, /obj/item/attachable/isr_barrel)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/isr_barrel,
		/obj/item/attachable/stock/isr,
	)

	flags_gun_features = GUN_CAN_POINTBLANK|GUN_WIELDED_FIRING_ONLY|GUN_AUTO_EJECT_CASINGS
	wield_delay = WIELD_DELAY_NORMAL
	map_specific_decoration = FALSE
	start_automatic = TRUE


/obj/item/weapon/gun/rifle/isr/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16,"rail_x" = 12, "rail_y" = 22, "under_x" = 24, "under_y" = 13, "stock_x" = 5, "stock_y" = 20, "side_rail_x" = 20, "side_rail_y" = 16)

/obj/item/weapon/gun/rifle/isr/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_LMG)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_LMG)
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_8
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_10
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4
	recoil_unwielded = RECOIL_AMOUNT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5

/obj/item/weapon/gun/rifle/isr/modded
	starting_attachment_types = list(/obj/item/attachable/stock/isr, /obj/item/attachable/isr_barrel, /obj/item/attachable/flashlight, /obj/item/attachable/reddot)
