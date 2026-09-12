//Base pistol for inheritance/
//--------------------------------------------------

/obj/item/weapon/gun/pistol
	icon_state = "" //should return the honk-error sprite if there's no assigned icon.
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	mouse_pointer = 'icons/effects/mouse_pointer/pistol_mouse.dmi'

	reload_sound = 'sound/weapons/flipblade.ogg'
	cocked_sound = 'sound/weapons/gun_pistol_cocked.ogg'
	empty_sound = 'sound/weapons/gun_empty.ogg'

	matter = list("metal" = 2000)
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_MEDIUM
	force = 6
	movement_onehanded_acc_penalty_mult = 3
	wield_delay = WIELD_DELAY_VERY_FAST //If you modify your pistol to be two-handed, it will still be fast to aim
	fire_sound = "m4a3"
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
	)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS //For easy reference.
	gun_category = GUN_CATEGORY_HANDGUN

/obj/item/weapon/gun/pistol/Initialize(mapload, spawn_empty)
	. = ..()
	if(current_mag && current_mag.current_rounds > 0)
		load_into_chamber()

/obj/item/weapon/gun/pistol/unique_action(mob/user)
		cock(user)

/obj/item/weapon/gun/pistol/set_gun_config_values()
	..()
	movement_onehanded_acc_penalty_mult = 3

//-------------------------------------------------------
//M4A3 PISTOL

/obj/item/weapon/gun/pistol/m4a3
	name = "\improper M4A3 service pistol"
	desc = "The recently replaced semi-automatic 9mm service pistol of the USCM. It remains popular among marines due to its light trigger and familiarity."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m4a3"
	item_state = "m4a3"
	fire_sound = "vp70"
	current_mag = /obj/item/ammo_magazine/pistol
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/burstfire_assembly,
	)

/obj/item/weapon/gun/pistol/m4a3/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17, "side_rail_x" = 19, "side_rail_y" = 15)


/obj/item/weapon/gun/pistol/m4a3/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT


/obj/item/weapon/gun/pistol/m4a3/training
	current_mag = /obj/item/ammo_magazine/pistol/rubber

/obj/item/weapon/gun/pistol/m4a3/unloaded
	current_mag = null

/obj/item/weapon/gun/pistol/m4a3/custom
	name = "\improper M4A3 custom pistol"
	desc = "Sporting a nickel finish and possibly faux ivory grips, this 9mm pistol has been customized by a well known gunsmith on Gateway Station. It offers no tactical advantages."
	icon_state = "m4a3c"
	item_state = "m4a3c"

/obj/item/weapon/gun/pistol/m4a3/custom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT


//L54A2, browning hi-power but in space

/obj/item/weapon/gun/pistol/l54
	name = "\improper L54A2 service pistol"
	desc = "Standard issue semi-automatic service pistol of the NSPA. Chambered in 9mm, it is comparable to the popular M4A3 pistol utilized by the USCM. Until recently, it was also the standard issue pistol for the RMC before being replace by the L165A1."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/twe_guns.dmi'
	icon_state = "l54"
	item_state = "l54"
	fire_sound = "vp70"
	current_mag = /obj/item/ammo_magazine/pistol/l54
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = null

/obj/item/weapon/gun/pistol/l54/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17, "side_rail_x" = 19, "side_rail_y" = 14)

/obj/item/weapon/gun/pistol/l54/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_10)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/l54/unloaded
	current_mag = null

//VP70

/obj/item/weapon/gun/pistol/vp70
	name = "\improper VP70 M5 service pistol"
	desc = "Standard issue semi-automatic USCM service pistol. Recently replacing the M4A3, it retains its predecessor's 9mm chambering but offers both a higher magazine capacity and a 3-round burst selector."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "vp70"
	item_state = "vp70"
	fire_sound = "vp70"
	reload_sound = 'sound/weapons/gun_vp70_reload.ogg'
	unload_sound = 'sound/weapons/gun_vp70_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/vp70
	force = 8
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/reddot,
		/obj/item/attachable/burstfire_assembly,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/grip,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/stock/vp70,
	)
	start_automatic = TRUE

/obj/item/weapon/gun/pistol/vp70/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 21,"rail_x" = 8, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 11, "stock_y" = 14, "side_rail_x" = 19, "side_rail_y" = 16)


/obj/item/weapon/gun/pistol/vp70/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/vp70/unloaded
	current_mag = null
/obj/item/weapon/gun/pistol/vp70/training
	current_mag = /obj/item/ammo_magazine/pistol/vp70/rubber


/obj/item/weapon/gun/pistol/vp70/flashlight/handle_starting_attachment()
	..()
	var/obj/item/attachable/flashlight/flashlight = new(src)
	flashlight.Attach(src)
	update_attachable(flashlight.slot)

//-------------------------------------------------------

/obj/item/weapon/gun/pistol/m1911
	name = "\improper M1911 pistol"
	desc = "Despite never being an official service pistol of the USCM, its .45 ACP chambering and cultural connection to the Corps's predecessor keeps it a popular pistol, enough so that a large quantity are kept on backorder."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "m4a345"
	item_state = "m4a3"
	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/m1911

/obj/item/weapon/gun/pistol/m1911/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17, "side_rail_x" = 19, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/m1911/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/m1911/socom
	name = "\improper M48A4 pistol"
	desc = "A timeless classic since the first World War, the M1911A1 has limited use with the USCM, and is often used as a sidearm by non-governmental bodies due to its reliability. This is a modernized version with an ammo counter and a polymer grip, designated M48A4. Chambered in .45 ACP."
	icon_state = "m4a345_s"
	item_state = "m4a3"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/pistol/m1911/socom/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_8
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5

/obj/item/weapon/gun/pistol/m1911/socom/equipped
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)

/obj/item/weapon/gun/pistol/m1911/socom/officer
	name = "\improper M48A5 pistol"
	desc = "A timeless classic since the first World War, the M1911A1 has limited use with the USCM, and is often used as a sidearm by non-governmental bodies due to its reliability. An adaptation of the M48A4, with a reinforced chamber, barrel and slide to handle higher pressure loads, designated the M48A5. Chambered in .45 Super, but can load normal .45 ACP also."
	starting_attachment_types = list(/obj/item/attachable/lasersight)
	current_mag = /obj/item/ammo_magazine/pistol/m1911/super

//.45 MARSHALS PISTOL //Inspired by the Browning Hipower
// rebalanced - singlefire, very strong bullets but slow to fire and heavy recoil
// redesigned - now rejected USCM sidearm model, utilized by Colonial Marshals and other stray groups.

/obj/item/weapon/gun/pistol/highpower
	name = "\improper HG 45 'Aguila' pistol"
	desc = "A semi-automatic Henjin-Garcia design chambered in .45 ACP that is slowly replacing the Office of the Colonial Marshals's Spearhead revolver."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "highpower"
	item_state = "highpower"
	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/highpower
	force = 15
	attachable_allowed = list(
		/obj/item/attachable/suppressor, // Barrel
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/upp/surplus,
		/obj/item/attachable/bayonet/upp,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot, // Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/gyro, // Under
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
	)

/obj/item/weapon/gun/pistol/highpower/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20,"rail_x" = 6, "rail_y" = 22, "under_x" = 20, "under_y" = 15, "stock_x" = 0, "stock_y" = 0, "side_rail_x" = 20, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/highpower/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_4
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/highpower/black
	name = "\improper HG 45 'Marina' pistol"
	current_mag = /obj/item/ammo_magazine/pistol/highpower/black
	icon_state = "highpower_b"
	item_state = "highpower_b"
	desc = "A semi-automatic Henjin-Garcia design chambered in .45 ACP that is slowly replacing the Office of the Colonial Marshals's Spearhead revolver. Unlike its more common siblings, this variant was marketed and successfully sold in small quantities to the USCM."

/obj/item/weapon/gun/pistol/highpower/automag
	name = "\improper HG 44 'Automag' pistol"
	desc = "A semi-automatic Henjin-Garcia design chambered in .44 Magnum that was largely discontinued in favour of the HG 45 configuration chambered in .45 ACP."
	current_mag = /obj/item/ammo_magazine/pistol/highpower/automag
	icon_state = "highpower_tac"
	item_state = "highpower_tac"
	fire_sound = 'sound/weapons/gun_kt42.ogg'
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/pistol/highpower/automag/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_6)
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT - BULLET_DAMAGE_MULT_TIER_3

/obj/item/weapon/gun/pistol/highpower/automag/tactical
	name = "\improper HG 44 'Automag' pistol"
	desc = "A semi-automatic Henjin-Garcia design chambered in .44 Magnum that was largely discontinued in favour of the HG 45 configuration chambered in .45 ACP."
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS

//-------------------------------------------------------
//NP92 pistol
//Its a makarov

/obj/item/weapon/gun/pistol/np92
	name = "\improper NP92 pistol"
	desc = "The standard issue sidearm of the UPP. Chambered in 9x18mm Makarov, The NP92 is a small versatile pistol."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "np92"
	item_state = "np92"
	fire_sound = "vp70"
	current_mag = /obj/item/ammo_magazine/pistol/np92
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/pistol/np92/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 21, "under_y" = 18, "stock_x" = 21, "stock_y" = 18, "side_rail_x" = 19, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/np92/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_3

/obj/item/weapon/gun/pistol/np92/suppressed
	name = "\improper NPZ92 pistol"
	desc = "The NPZ92 is a version of the NP92 that includes an integrated suppressor, issued sparingly to Kommando units."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "npz92"
	item_state = "npz92"
	inherent_traits = list(TRAIT_GUN_SILENCED)
	fire_sound = "gun_silenced"
	current_mag = /obj/item/ammo_magazine/pistol/np92/suppressed
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
	)

/obj/item/weapon/gun/pistol/np92/suppressed/tranq
	current_mag = /obj/item/ammo_magazine/pistol/np92/tranq

/obj/item/weapon/gun/pistol/np92/unloaded
	current_mag = null

//-------------------------------------------------------
//Type 73 pistol
//Its a TT

/obj/item/weapon/gun/pistol/t73
	name = "\improper Type 73 pistol"
	desc = "Once the standard issue sidearm of the UPP it has since been replaced by the smaller NP92. Chambered with 7.62x25mm Tokarev, it remains popular with veterans due to its extra firepower."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "tt"
	item_state = "tt"
	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'
//	fire_sound = 'sound/weapons/gun_tt.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/t73
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
	)

/obj/item/weapon/gun/pistol/t73/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 22, "under_y" = 15, "stock_x" = 21, "stock_y" = 18, "side_rail_x" = 22, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/t73/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4

/obj/item/weapon/gun/pistol/t73/unloaded
	current_mag = null

/obj/item/weapon/gun/pistol/t73/leader
	name = "\improper Type 74 pistol"
	desc = "The Type 74 is the designation for a specially modified Type 73 with an integrated laser sight system, multiple lightning cuts to reduce weight in order to allow a higher pressure round to be used with the same recoil sping, and a more comfortable grip. Due to the adoption of the NP92, the Type 74 was produced in limited numbers, because of this it is typically only issued on request to high-ranking officers."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/upp.dmi'
	icon_state = "ttb"
	item_state = "ttb"
	current_mag = /obj/item/ammo_magazine/pistol/t73_impact
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	accepted_ammo = list(
		/obj/item/ammo_magazine/pistol/t73,
		/obj/item/ammo_magazine/pistol/t73_impact,
	)

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/heavy_barrel,
	)

/obj/item/weapon/gun/pistol/t73/leader/handle_starting_attachment()
	..()
	var/obj/item/attachable/lasersight/TT = new(src)
	TT.flags_attach_features &= ~ATTACH_REMOVABLE
	TT.hidden = TRUE
	TT.Attach(src)
	update_attachable(TT.slot)

/obj/item/weapon/gun/pistol/t73/leader/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4

//-------------------------------------------------------
//KT-42 //Inspired by the .44 Auto Mag pistol
// rebalanced - slightly worse stats than the 88 mod, but uses heavy pistol bullets.

/obj/item/weapon/gun/pistol/kt42
	name = "\improper KT-42 automag"
	desc = "The KT-42 Automag is an archaic but reliable design, going back many decades. There have been many versions and variations, but the 42 is by far the most common. You can't go wrong with this handcannon."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "kt42"
	item_state = "kt42"
	fire_sound = 'sound/weapons/gun_kt42.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/kt42

/obj/item/weapon/gun/pistol/kt42/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 20,"rail_x" = 8, "rail_y" = 22, "under_x" = 22, "under_y" = 17, "stock_x" = 22, "stock_y" = 17, "side_rail_x" = 21, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/kt42/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_1
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_2
	scatter = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT


//-------------------------------------------------------

/obj/item/weapon/gun/pistol/holdout
	name = "holdout pistol"
	desc = "A tiny pistol meant for hiding in hard-to-reach areas. Best not ask where it came from."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "holdout"
	item_state = "holdout"

	fire_sound = 'sound/weapons/gun_pistol_holdout.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/holdout
	w_class = SIZE_TINY
	force = 2
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/burstfire_assembly,
	)


/obj/item/weapon/gun/pistol/holdout/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 25, "muzzle_y" = 20,"rail_x" = 12, "rail_y" = 22, "under_x" = 17, "under_y" = 15, "stock_x" = 22, "stock_y" = 17, "side_rail_x" = 17, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/holdout/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/holdout/flashlight/handle_starting_attachment()
	..()
	var/obj/item/attachable/flashlight/flashlight = new(src)
	flashlight.Attach(src)
	update_attachable(flashlight.slot)

//-------------------------------------------------------
//CLF HOLDOUT PISTOL
/obj/item/weapon/gun/pistol/clfpistol
	name = "Hummingbird pistol"
	desc = "Chambering .50 AE catridges this gun is as compact as it could possibly be. Rumored to be designed and produced by the UPP before being distributed into UA space for arming sleeper cells with throwaway weapons capable of penetrating standard M3 pattern armor."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "m43"
	item_state = "m43"
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	fire_sound = 'sound/weapons/gun_m43.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/clfpistol
	w_class = SIZE_TINY
	force = 5
	attachable_allowed = null

/obj/item/weapon/gun/pistol/clfpistol/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17, "side_rail_x" = 20, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/clfpistol/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_5
	scatter_unwielded = SCATTER_AMOUNT_TIER_8
	scatter = SCATTER_AMOUNT_TIER_9
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_10
	recoil = RECOIL_AMOUNT_TIER_2
	recoil_unwielded = RECOIL_AMOUNT_TIER_1

//-------------------------------------------------------

// ES-4 - Basically a CL-exclusive reskin of the 88 mod 4 that only uses less-lethal ammo.

/obj/item/weapon/gun/pistol/es4
	name = "\improper ES-4 electrostatic pistol"
	desc = "A Weyland Corp manufactured less-than-lethal pistol. Originally manufactured in the 2080s, the ES-4 electrostatic pistol fires electrically-charged bullets with high accuracy, though its cost and constant need for cleaning makes it a rare sight."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/wy.dmi'
	icon_state = "es4"
	item_state = "es4"
	fire_sound = 'sound/weapons/gun_es4.ogg'
	reload_sound = 'sound/weapons/gun_vp70_reload.ogg'
	unload_sound = 'sound/weapons/gun_vp70_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/es4
	force = 8
	muzzleflash_iconstate = "muzzle_flash_blue"
	muzzle_flash_color = COLOR_MUZZLE_BLUE
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/flashlight,
		/obj/item/attachable/reflex,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
	)

/obj/item/weapon/gun/pistol/es4/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 27, "muzzle_y" = 21, "rail_x" = 10, "rail_y" = 22, "under_x" = 25, "under_y" = 18, "stock_x" = 18, "stock_y" = 15, "side_rail_x" = 25, "side_rail_y" = 18)


/obj/item/weapon/gun/pistol/es4/set_gun_config_values()
	..()
	fire_delay = FIRE_DELAY_TIER_11
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_4

/obj/item/weapon/gun/pistol/es4/unloaded
	current_mag = null

//-------------------------------------------------------
//VP78 - High power pistol?

/obj/item/weapon/gun/pistol/vp78
	name = "\improper VP78 pistol"
	desc = "A massive, formidable semi-automatic handgun based on a Beretta Arms patented design and chambered in overpressured 9mm rounds. A common sight throughout both UA and 3WE space, often held by well-equipped Weyland-Yutani personnel."
	icon_state = "vp78"
	item_state = "b92fs"
	fire_sound = 'sound/weapons/gun_vp78_v2.ogg'
	reload_sound = 'sound/weapons/gun_vp78_reload.ogg'
	unload_sound = 'sound/weapons/gun_vp78_unload.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/vp78
	force = 8
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight/laser_light_combo,
		/obj/item/attachable/extended_barrel,
	)

/obj/item/weapon/gun/pistol/vp78/handle_starting_attachment()
	..()
	var/obj/item/attachable/flashlight/laser_light_combo/VP = new(src)
	VP.flags_attach_features &= ~ATTACH_REMOVABLE
	VP.hidden = FALSE
	VP.Attach(src)
	update_attachable(VP.slot)

/obj/item/weapon/gun/pistol/vp78/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 21,"rail_x" = 10, "rail_y" = 23, "under_x" = 22, "under_y" = 15, "stock_x" = 18, "stock_y" = 14, "side_rail_x" = 21, "side_rail_y" = 14)


/obj/item/weapon/gun/pistol/vp78/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_6
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_9
	burst_scatter_mult = SCATTER_AMOUNT_TIER_7
	scatter_unwielded = SCATTER_AMOUNT_TIER_5
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/vp78/unloaded
	current_mag = null

/obj/item/weapon/gun/pistol/vp78/rmc
	name = "\improper L165A1 service pistol"
	desc = "Service issue pistol to the Royal Marine Commandos. A sleek, modern, semi-automatic handgun specifically designed to chamber specialized 9x19mm explosive squash-head rounds. Based on a Beretta Arms patented design, this Weyland-Yutani modification has earned its place in the hands of the Three World Empire's best soldiers. Can load normal VP78 magazines with no issue too."
	current_mag = /obj/item/ammo_magazine/pistol/vp78/rmc
	start_automatic = TRUE

/obj/item/weapon/gun/pistol/vp78/rmc/unloaded
	current_mag = null

//-------------------------------------------------------
/*
Auto 9 The gun RoboCop uses. A better version of the VP78, with more rounds per magazine. Probably the best pistol around, but takes no attachments.
It is a modified Beretta 93R, and can fire three-round burst or single fire. Whether or not anyone else aside RoboCop can use it is not established.
*/

/obj/item/weapon/gun/pistol/auto9
	name = "\improper Auto-9 pistol"
	desc = "An advanced, select-fire machine pistol capable of three-round burst. Last seen cleaning up the mean streets of Detroit."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	icon_state = "auto9"
	item_state = "auto9"

	fire_sound = 'sound/weapons/gun_pistol_large.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/auto9
	force = 15

/obj/item/weapon/gun/pistol/auto9/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_7)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3


//-------------------------------------------------------
//Beretta 92FS, the gun McClane carries around in Die Hard. Very similar to the service pistol, all around.

/obj/item/weapon/gun/pistol/b92fs
	name = "\improper Beretta 92FS M9 pistol"
	desc = "Semi-automatic 9mm service pistol of the United States Army. Also enjoys popularity in the civilian market among law enforcement and private security."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "b92fs"
	item_state = "b92fs"
	fire_sound = "vp70"
	current_mag = /obj/item/ammo_magazine/pistol/b92fs

/obj/item/weapon/gun/pistol/b92fs/Initialize(mapload, spawn_empty)
	. = ..()
	if(prob(10))
		name = "\improper Beretta 93FR burst pistol"
		desc += " This specific pistol is a burst-fire, limited availability, police-issue 93FR type Beretta. Not too accurate, aftermarket modififcations are recommended."
		var/obj/item/attachable/burstfire_assembly/BFA = new(src)
		BFA.flags_attach_features &= ~ATTACH_REMOVABLE
		BFA.Attach(src)
		update_attachable(BFA.slot)
		add_firemode(GUN_FIREMODE_BURSTFIRE)

/obj/item/weapon/gun/pistol/b92fs/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 22, "under_x" = 21, "under_y" = 17, "stock_x" = 21, "stock_y" = 17, "side_rail_x" = 21, "side_rail_y" = 17)

/obj/item/weapon/gun/pistol/b92fs/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_5
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	burst_scatter_mult = SCATTER_AMOUNT_TIER_5
	scatter_unwielded = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT

/obj/item/weapon/gun/pistol/b92fs/modded
	starting_attachment_types = list(/obj/item/attachable/suppressor, /obj/item/attachable/lasersight, /obj/item/attachable/reflex)


//-------------------------------------------------------
//DEAGLE //This one is obvious.

/obj/item/weapon/gun/pistol/heavy
	name = "vintage Desert Eagle"
	desc = "A bulky 50 caliber pistol with a serious kick, probably taken from some museum somewhere. This one is engraved, 'Peace through superior firepower.'"
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "deagle"
	item_state = "deagle"
	fire_sound = 'sound/weapons/gun_DE50.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/heavy
	force = 13

	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/compensator,
	)


/obj/item/weapon/gun/pistol/heavy/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 20,"rail_x" = 17, "rail_y" = 21, "under_x" = 20, "under_y" = 17, "stock_x" = 20, "stock_y" = 17, "side_rail_x" = 20, "side_rail_y" = 17)


/obj/item/weapon/gun/pistol/heavy/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	set_burst_delay(FIRE_DELAY_TIER_8)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_5
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_1
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_3

/obj/item/weapon/gun/pistol/heavy/co
	name = "polished vintage Desert Eagle"
	desc = "The handcannon that needs no introduction, the .50-caliber Desert Eagle is expensive, unwieldy, and extremely heavy for a pistol. However, it makes up for it with its powerful shots capable of stopping a bear dead in its tracks. Iconic, glamorous, and above all, extremely deadly."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "c_deagle"
	item_state = "c_deagle"
	base_gun_icon = "c_deagle"
	current_mag = /obj/item/ammo_magazine/pistol/heavy/super/highimpact
	black_market_value = 100

/obj/item/weapon/gun/pistol/heavy/co/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_5)
	accuracy_mult = BASE_ACCURACY_MULT + HIT_ACCURACY_MULT_TIER_4
	accuracy_mult_unwielded = BASE_ACCURACY_MULT - HIT_ACCURACY_MULT_TIER_7
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_4
	scatter_unwielded = SCATTER_AMOUNT_TIER_3
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_8
	recoil = RECOIL_AMOUNT_TIER_3
	recoil_unwielded = RECOIL_AMOUNT_TIER_2

/obj/item/weapon/gun/pistol/heavy/co/gold
	name = "golden vintage Desert Eagle"
	desc = "A Desert Eagle anodized in gold and adorned with rosewood grips. The living definition of ostentatious, it's flashy, unwieldy, tremendously heavy, and kicks like a mule. But as a symbol of power, there's nothing like it."
	icon_state = "g_deagle"
	item_state = "g_deagle"
	base_gun_icon = "g_deagle"

//-------------------------------------------------------
//The first rule of monkey pistol is we don't talk about monkey pistol.

/obj/item/weapon/gun/pistol/chimp
	name = "\improper CHIMP70 pistol"
	desc = "A powerful sidearm issued mainly to highly trained elite assassin necro-cyber-agents."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/event.dmi'
	icon_state = "c70"
	item_state = "c70"

	current_mag = /obj/item/ammo_magazine/pistol/chimp
	fire_sound = 'sound/weapons/gun_chimp70.ogg'
	w_class = SIZE_MEDIUM
	force = 8
	flags_gun_features = GUN_AUTO_EJECTOR

/obj/item/weapon/gun/pistol/chimp/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_9)
	set_burst_delay(FIRE_DELAY_TIER_11)
	set_burst_amount(BURST_AMOUNT_TIER_2)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT


//-------------------------------------------------------
//Smartpistol. An IFF pistol, pretty much.

/obj/item/weapon/gun/pistol/smart
	name = "\improper SU-6 Smartpistol"
	desc = "The SU-6 Smartpistol is an IFF-based sidearm currently undergoing field testing in the Colonial Marines. Uses modified .45 ACP IFF bullets. Capable of firing in bursts."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/uscm.dmi'
	icon_state = "smartpistol"
	item_state = "smartpistol"
	force = 8
	current_mag = /obj/item/ammo_magazine/pistol/smart
	fire_sound = 'sound/weapons/gun_su6.ogg'
	reload_sound = 'sound/weapons/handling/gun_su6_reload.ogg'
	unload_sound = 'sound/weapons/handling/gun_su6_unload.ogg'
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AMMO_COUNTER|GUN_AUTO_EJECT_CASINGS

/obj/item/weapon/gun/pistol/smart/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 20,"rail_x" = 13, "rail_y" = 22, "under_x" = 24, "under_y" = 17, "stock_x" = 24, "stock_y" = 17, "side_rail_x" = 24, "side_rail_y" = 17)

/obj/item/weapon/gun/pistol/smart/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_12)
	set_burst_amount(BURST_AMOUNT_TIER_3)
	set_burst_delay(FIRE_DELAY_TIER_11)
	accuracy_mult = BASE_ACCURACY_MULT
	accuracy_mult_unwielded = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_6
	burst_scatter_mult = SCATTER_AMOUNT_TIER_6
	scatter_unwielded = SCATTER_AMOUNT_TIER_6
	damage_mult = BASE_BULLET_DAMAGE_MULT
	recoil = RECOIL_AMOUNT_TIER_5
	recoil_unwielded = RECOIL_AMOUNT_TIER_4

/obj/item/weapon/gun/pistol/smart/set_bullet_traits()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_iff)
	))

//-------------------------------------------------------
//SKORPION //Based on the same thing.

/obj/item/weapon/gun/pistol/skorpion
	name = "\improper CZ-81 machine pistol"
	desc = "A robust, 20th century firearm that's a combination of pistol and submachinegun. Fires .32ACP caliber rounds from a 20-round magazine."
	icon = 'icons/obj/items/weapons/guns/guns_by_faction/colony.dmi'
	icon_state = "skorpion"
	item_state = "skorpion"

	fire_sound = 'sound/weapons/gun_skorpion.ogg'
	current_mag = /obj/item/ammo_magazine/pistol/skorpion
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_CAN_POINTBLANK|GUN_ONE_HAND_WIELDED|GUN_AUTO_EJECT_CASINGS
	attachable_allowed = list(
		/obj/item/attachable/reddot, //Rail
		/obj/item/attachable/reflex,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/suppressor, //Muzzle
		/obj/item/attachable/compensator,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/lasersight, //Underbarrel
		/obj/item/attachable/burstfire_assembly,
	)
	start_semiauto = FALSE
	start_automatic = TRUE

/obj/item/weapon/gun/pistol/skorpion/set_gun_attachment_offsets()
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 18,"rail_x" = 16, "rail_y" = 21, "under_x" = 23, "under_y" = 15, "stock_x" = 23, "stock_y" = 15, "side_rail_x" = 23, "side_rail_y" = 15)

/obj/item/weapon/gun/pistol/skorpion/set_gun_config_values()
	..()
	set_fire_delay(FIRE_DELAY_TIER_11)
	fa_scatter_peak = 15 //shots
	fa_max_scatter = SCATTER_AMOUNT_TIER_5

	accuracy_mult = BASE_ACCURACY_MULT
	scatter = SCATTER_AMOUNT_TIER_7
	damage_mult = BASE_BULLET_DAMAGE_MULT + BULLET_DAMAGE_MULT_TIER_2
