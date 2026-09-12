//M49A custom marksman rifle

/obj/item/weapon/gun/rifle/m49a_custom
	name = "\improper M49A5 battle rifle"
	desc = "This is a further improvement upon the already rock-solid M49A. Made by the USCM armorers on Chinook station - This variant of the M49A has a specifically milled magazine well to accept A19 rounds. It sports a light-weight titantium-alloy frame, better responsive to the heavy kick of the tailor-made A19 rounds."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m49a_custom"
	item_state = "m49a_custom"
	mouse_pointer = 'icons/effects/mouse_pointer/sniper_mouse.dmi'

	unacidable = TRUE
	indestructible = 1
	force = 26
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_SPECIALIST|GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER
	aim_slowdown = SLOWDOWN_ADS_QUICK
	flags_item = TWOHANDED|NO_CRYO_STORE

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
	)

	fire_sound = 'sound/weapons/gun_m49a.ogg'
	reload_sound = 'sound/weapons/handling/l42_reload.ogg'
	unload_sound = 'sound/weapons/handling/l42_unload.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/m49a/custom

	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Barrel
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/bayonet/co2,
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
		/obj/item/attachable/scope/mini/scout,
		/obj/item/attachable/bipod, // Under
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/attached_gun/shotgun,
		/obj/item/attachable/attached_gun/grenade/mk1,
		/obj/item/attachable/attached_gun/grenade/mk1/recon,
		/obj/item/attachable/lasersight, // Side Rail
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/rifle/m49a_custom/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 17,"rail_x" = 23, "rail_y" = 23, "under_x" = 30, "under_y" = 11, "stock_x" = 24, "stock_y" = 13, "side_rail_x" = 31, "side_rail_y" = 18, "special_x" = 37, "special_y" = 16)

/obj/item/weapon/gun/rifle/m49a_custom/handle_starting_attachment()
	..()
	var/obj/item/attachable/m49a_barrel_custom/integrated = new(src)
	var/obj/item/attachable/scope/mini/scout/integrated_scope = new(src)
	integrated.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated_scope.flags_attach_features &= ~ATTACH_REMOVABLE
	integrated.Attach(src)
	integrated_scope.Attach(src)
	update_attachable(integrated.slot)
	update_attachable(integrated_scope.slot)

/obj/item/weapon/gun/rifle/m49a_custom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_8
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
	recoil = RECOIL_AMOUNT_TIER_5
	damage_falloff_mult = 0

/obj/item/weapon/gun/rifle/m49a_custom/tactical
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/attached_gun/grenade/mk1/preloaded)
