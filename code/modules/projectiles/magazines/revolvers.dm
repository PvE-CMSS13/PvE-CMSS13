
//external magazines

/obj/item/ammo_magazine/revolver
	name = "\improper M44 speed loader (.44)"
	desc = "A revolver speed loader for the M44 revolver."
	default_ammo = /datum/ammo/bullet/revolver
	flags_equip_slot = NO_FLAGS
	caliber = ".44"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "m44"
	item_state = "generic_speedloader"
	w_class = SIZE_SMALL
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/revolver/m44
	ammo_band_icon = "+m44_tip"
	ammo_band_icon_empty = "empty"

/obj/item/ammo_magazine/revolver/marksman
	name = "\improper M44 marksman speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/marksman
	caliber = ".44"
	ammo_band_color = REVOLVER_TIP_COLOR_MARKSMAN

/obj/item/ammo_magazine/revolver/heavy
	name = "\improper M44 heavy speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/heavy
	caliber = ".44"
	ammo_band_color = REVOLVER_TIP_COLOR_HEAVY

/obj/item/ammo_magazine/revolver/incendiary
	name = "\improper M44 incendiary speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/incendiary
	ammo_band_color = REVOLVER_TIP_COLOR_INCENDIARY

/obj/item/ammo_magazine/revolver/marksman/toxin
	name = "\improper M44 toxic speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/marksman/toxin
	ammo_band_color = REVOLVER_TIP_COLOR_TOXIN

/obj/item/ammo_magazine/revolver/penetrating
	name = "\improper M44 wall-penetrating speed loader (.44)"
	default_ammo = /datum/ammo/bullet/revolver/penetrating
	ammo_band_color = REVOLVER_TIP_COLOR_PENETRATING

/**
 * COLONY REVOLVERS
 */

/obj/item/ammo_magazine/revolver/pkd
	name = "\improper Plfager Katsuma stripper clip (.44)"
	desc = "Flip up the two side latches (three on PKL) and push after aligning with feed lips on blaster. Clip can be re-used."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "pkd_44"
	caliber = ".44 sabot"

/obj/item/ammo_magazine/revolver/upp
	name = "\improper ZHNK-72 speed loader (7.62x38mmR)"
	default_ammo = /datum/ammo/bullet/revolver/upp
	caliber = "7.62x38mmR"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "zhnk72loader"
	gun_type = /obj/item/weapon/gun/revolver/upp

/obj/item/ammo_magazine/revolver/upp/shrapnel
	name = "\improper ZHNK-72 shrapnel-shot speed loader (7.62x38mmR)"
	desc = "This speedloader contains seven 'shrapnel-shot' bullets, cheap recycled casings picked up off the ground and refilled with gunpowder and random scrap metal. Acts similarly to flechette."
	default_ammo = /datum/ammo/bullet/revolver/upp/shrapnel
	icon_state = "zhnk72loader_shrapnel"

/obj/item/ammo_magazine/revolver/small
	name = "\improper .38 overpressure speedloader (.38 +P)"
	desc = "A speedloader of 6 handloaded overpressure .38 bullets. Substantial impact, but suffers from accuracy issues compared to factory ammunition. Liable to damage firearms not built to handle the chamber pressure."
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = ".38 +P"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "38"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/small

/obj/item/ammo_magazine/revolver/cmb
	name = "\improper Spearhead hollowpoint speed loader (.357)"
	desc = "A speedloader of 6 hollowpoint .357 bullets, issued to Colonial Marshals to both prevent overpenetration and improve performance against unarmored criminals or wildlife. Less effective against hard targets, but what're the chances of encountering those?"
	default_ammo = /datum/ammo/bullet/revolver/small/hollowpoint
	caliber = ".357"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "cmb_hp"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/cmb

/obj/item/ammo_magazine/revolver/cmb/normalpoint //put these in the marshal ert - ok sure :)
	name = "\improper Spearhead speed loader (.357)"
	desc = "A speedloader of 6 FMJ .357 bullets, uncommonly issued to Colonial Marshals due to overpenetration risks but service standard for the USCM."
	default_ammo = /datum/ammo/bullet/revolver/small
	icon_state = "cmb"

/**
 * MATEBA REVOLVER
 */

/obj/item/ammo_magazine/revolver/mateba
	name = "\improper Mateba speed loader (.454)"
	desc = "A formidable .454 speedloader, made exclusively for the Mateba autorevolver. Packs a devastating punch. This standard-variant is optimized for anti-armor."
	default_ammo = /datum/ammo/bullet/revolver/mateba
	caliber = ".454"
	icon_state = "mateba"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/mateba

/obj/item/ammo_magazine/revolver/mateba/highimpact
	name = "\improper High Impact Mateba speed loader (.454)"
	desc = "A formidable .454 speedloader, made exclusively for the Mateba autorevolver. Packs a devastating punch. This high impact variant is optimized for anti-personnel. Don't point at anything you don't want to destroy."
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact
	ammo_band_color = REVOLVER_TIP_COLOR_HIGH_IMPACT

/obj/item/ammo_magazine/revolver/mateba/highimpact/ap
	name = "\improper High Impact Armor-Piercing Mateba speed loader (.454)"
	desc = "A formidable .454 speedloader, made exclusively for the Mateba autorevolver. Packs a devastating punch. This armor-piercing variant is optimized against armored targets at the cost of lower overall damage. Don't point at anything you don't want to destroy."
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/ap
	ammo_band_color = REVOLVER_TIP_COLOR_AP

/obj/item/ammo_magazine/revolver/mateba/highimpact/explosive
	name = "\improper Mateba explosive speed loader (.454)"
	desc = "A formidable .454 speedloader, made exclusively for the Mateba autorevolver. There's an impact charge built into the bullet tip. Firing this at anything will result in a powerful explosion. Use with EXTREME caution."
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/explosive
	ammo_band_color = REVOLVER_TIP_COLOR_EXPLOSIVE

/**
 * WEBLEY REVOLVER
*/

/obj/item/ammo_magazine/revolver/webley
	name = "\improper Webley speed loader (.455)"
	desc = ".455 Webley, the last decent pistol calibre. Loaded with Mk III dum-dum bullets, because Marines are not human and the Hague Conventions do not apply to them."
	default_ammo = /datum/ammo/bullet/revolver/webley
	caliber = ".455"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "357"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/m44/custom/webley

//INTERNAL MAGAZINES

//---------------------------------------------------

/obj/item/ammo_magazine/internal/revolver
	name = "revolver cylinder"
	default_ammo = /datum/ammo/bullet/revolver
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver

//-------------------------------------------------------
//M44 MAGNUM REVOLVER //Not actually cannon, but close enough.

/obj/item/ammo_magazine/internal/revolver/m44
	caliber = ".44"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/revolver/m44

/obj/item/ammo_magazine/internal/revolver/m44/pkd
	max_rounds = 8
	caliber = ".44 sabot"

/obj/item/ammo_magazine/internal/revolver/m44/marksman
	default_ammo = /datum/ammo/bullet/revolver/marksman //because the starting m44 custom revolver belt is full of marksman ammo, but your gun would have normal ammo loaded

//-------------------------------------------------------
//RUSSIAN REVOLVER //Based on the 7.62mm Russian revolvers.

/obj/item/ammo_magazine/internal/revolver/upp
	default_ammo = /datum/ammo/bullet/revolver/upp
	caliber = "7.62x38mmR"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/revolver/upp

/obj/item/ammo_magazine/internal/revolver/upp/shrapnel
	default_ammo = /datum/ammo/bullet/revolver/upp/shrapnel


//-------------------------------------------------------
//357 REVOLVER //Based on the generic S&W 357.

/obj/item/ammo_magazine/internal/revolver/small
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = ".357 Hotload"
	gun_type = /obj/item/weapon/gun/revolver/small

//-------------------------------------------------------
//BURST REVOLVER //Mateba is pretty well known. The cylinder folds up instead of to the side.

/obj/item/ammo_magazine/internal/revolver/mateba
	default_ammo = /datum/ammo/bullet/revolver
	caliber = ".454"
	gun_type = /obj/item/weapon/gun/revolver/mateba

/obj/item/ammo_magazine/internal/revolver/mateba/impact
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact

/obj/item/ammo_magazine/internal/revolver/mateba/ap
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/ap

/obj/item/ammo_magazine/internal/revolver/mateba/explosive
	default_ammo = /datum/ammo/bullet/revolver/mateba/highimpact/explosive

//-------------------------------------------------------
//MARSHALS REVOLVER //Spearhead exists in Alien cannon.

/obj/item/ammo_magazine/internal/revolver/cmb
	default_ammo = /datum/ammo/bullet/revolver/small
	caliber = ".357"
	max_rounds = 6
	gun_type = /obj/item/weapon/gun/revolver/cmb

/obj/item/ammo_magazine/internal/revolver/cmb/hollowpoint
	default_ammo = /datum/ammo/bullet/revolver/small/hollowpoint
	caliber = ".357"
	gun_type = /obj/item/weapon/gun/revolver/cmb

//-------------------------------------------------------
//BIG GAME HUNTER'S REVOLVER
/obj/item/ammo_magazine/internal/revolver/webley
	caliber = ".455"
	default_ammo = /datum/ammo/bullet/revolver/webley
	gun_type = /obj/item/weapon/gun/revolver/m44/custom/webley
