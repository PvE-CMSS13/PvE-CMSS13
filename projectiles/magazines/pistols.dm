
//-------------------------------------------------------
//M4A3 PISTOL

/obj/item/ammo_magazine/pistol
	name = "\improper M4A3 magazine (9x19mm)"
	desc = "A pistol magazine."
	caliber = "9x19mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "m4a3"
	max_rounds = 12
	w_class = SIZE_SMALL
	default_ammo = /datum/ammo/bullet/pistol
	gun_type = /obj/item/weapon/gun/pistol/m4a3
	ammo_band_icon = "+m4a3_band"
	ammo_band_icon_empty = "+m4a3_band_e"

/obj/item/ammo_magazine/pistol/hp
	name = "\improper M4A3 hollowpoint magazine (9x19mm)"
	desc = "A pistol magazine. This one contains hollowpoint bullets, which have noticeably higher stopping power on unarmored targets, and noticeably less on armored targets."
	default_ammo = /datum/ammo/bullet/pistol/hollow
	ammo_band_color = AMMO_BAND_COLOR_HOLLOWPOINT

/obj/item/ammo_magazine/pistol/ap
	name = "\improper M4A3 AP magazine (9x19mm)"
	desc = "A pistol magazine. This one contains armor-piercing bullets, which have noticeably higher stopping power on well-armored targets, and noticeably less on unarmored or lightly-armored targets."
	default_ammo = /datum/ammo/bullet/pistol/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/pistol/rubber
	name = "\improper M4A3 Rubber magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/pistol/incendiary
	name = "\improper M4A3 incendiary magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/penetrating
	name = "\improper M4A3 wall-penetrating magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/toxin
	name = "\improper M4A3 toxin magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/pistol/l54
	name = "\improper L54A2 magazine (9mm)"
	desc = "A pistol magazine."
	caliber = "9mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/twe_ammo.dmi'
	icon_state = "l54"
	max_rounds = 13
	w_class = SIZE_SMALL
	default_ammo = /datum/ammo/bullet/pistol
	gun_type = /obj/item/weapon/gun/pistol/l54
	ammo_band_icon = "+m4a3_band"
	ammo_band_icon_empty = "+m4a3_band_e"

//-------------------------------------------------------
//M4A3 45 //Inspired by the 1911

/obj/item/ammo_magazine/pistol/m1911
	name = "\improper M1911 magazine (.45)"
	default_ammo = /datum/ammo/bullet/pistol/heavy
	caliber = ".45"
	icon_state = "m1911"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/pistol/m1911
	ammo_band_icon = "+m1911_band"
	ammo_band_icon_empty = "+m1911_band_e"

/obj/item/ammo_magazine/pistol/m1911/super
	name = "\improper M1911 magazine (.45 Super)"
	default_ammo = /datum/ammo/bullet/pistol/heavy/special
	gun_type = /obj/item/weapon/gun/pistol/m1911/socom/officer
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT

//-------------------------------------------------------
//vp70 based off VP70


/obj/item/ammo_magazine/pistol/vp70
	name = "\improper VP70 Magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9x19mm"
	icon_state = "vp70"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/vp70
	ammo_band_icon = "+vp70_band"
	ammo_band_icon_empty = "+vp70_band_e"
	ammo_band_color = null

/obj/item/ammo_magazine/pistol/vp70/ap
	name = "\improper VP70 AP magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap
	caliber = "9x19mm"
	icon_state = "vp70"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/vp70
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/pistol/vp70/extended // Unused
	name = "\improper vp70 extended magazine (9x19mm)"
	icon_state = "vp70_mag_ex"
	default_ammo = /datum/ammo/bullet/pistol
	caliber = "9x19mm"

/obj/item/ammo_magazine/pistol/vp70/toxin
	name = "\improper vp70 toxic magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/pistol/vp70/penetrating
	name = "\improper vp70 wall-penetrating magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/vp70/incendiary
	name = "\improper vp70 incendiary magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pistol/vp70/rubber
	name = "\improper vp70 rubber magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

//-------------------------------------------------------
//ES-4

/obj/item/ammo_magazine/pistol/es4
	name = "\improper ES-4 stun magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/electrostatic
	caliber = "9x19mm"
	desc = "Holds 19 rounds of specialized Conductive 9x19mm. Electrostatic propulsion in the ES-4 functions by propelling an cV9x19mm round, at a proportionally slower velocity to maintain a higher kinetic energy transfer rate. All this turns a penetrative round into a less-than-lethal round."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/wy.dmi'
	icon_state = "es4"
	max_rounds = 19
	gun_type = /obj/item/weapon/gun/pistol/es4

//-------------------------------------------------------
//VP78

/obj/item/ammo_magazine/pistol/vp78
	name = "\improper VP78 +P magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/highpower
	caliber = "9x19mm"
	icon_state = "m4a3"
	max_rounds = 18
	gun_type = /obj/item/weapon/gun/pistol/vp78
	ammo_band_icon = "+m4a3_band"
	ammo_band_icon_empty = "+m4a3_band_e"

/obj/item/ammo_magazine/pistol/vp78/rmc
	name = "\improper L165A1 Squash-Head magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash
	gun_type = /obj/item/weapon/gun/pistol/vp78/rmc
	ammo_band_color = AMMO_BAND_COLOR_IMPACT

/obj/item/ammo_magazine/pistol/vp78/toxin
	name = "\improper VP78 toxic magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/pistol/vp78/penetrating
	name = "\improper VP78 wall-penetrating magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/pistol/vp78/incendiary
	name = "\improper VP78 incendiary magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

//-------------------------------------------------------
//Beretta 92FS, the gun McClane carries around in Die Hard. Very similar to the service pistol, all around.

/obj/item/ammo_magazine/pistol/b92fs
	name = "\improper Beretta 92FS magazine (9x19mm)"
	caliber = "9x19mm"
	icon_state = "m4a3" //PLACEHOLDER
	max_rounds = 15
	default_ammo = /datum/ammo/bullet/pistol
	gun_type = /obj/item/weapon/gun/pistol/b92fs


//-------------------------------------------------------
//DEAGLE //This one is obvious.

/obj/item/ammo_magazine/pistol/heavy
	name = "\improper Desert Eagle magazine (.50)"
	default_ammo = /datum/ammo/bullet/pistol/deagle
	caliber = ".50"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "deagle"
	max_rounds = 7
	gun_type = /obj/item/weapon/gun/pistol/heavy
	ammo_band_icon = "+deagle_band"
	ammo_band_icon_empty = "+deagle_band_e"

/obj/item/ammo_magazine/pistol/heavy/super //Commander's variant
	name = "\improper Heavy Desert Eagle magazine (.50)"
	desc = "Seven rounds of devastatingly powerful 50-caliber destruction."
	gun_type = /obj/item/weapon/gun/pistol/heavy/co
	default_ammo = /datum/ammo/bullet/pistol/heavy/super
	ammo_band_color = AMMO_BAND_COLOR_SUPER

/obj/item/ammo_magazine/pistol/heavy/super/highimpact
	name = "\improper High Impact Desert Eagle magazine (.50)"
	desc = "Seven rounds of devastatingly powerful 50-caliber destruction. The bullets are tipped with a synthesized osmium and lead alloy to stagger absolutely anything they hit. Point away from anything you value."
	default_ammo = /datum/ammo/bullet/pistol/heavy/super/highimpact
	ammo_band_color = AMMO_BAND_COLOR_HIGH_IMPACT

/obj/item/ammo_magazine/pistol/heavy/super/highimpact/ap
	name = "\improper High Impact Armor-Piercing Desert Eagle magazine (.50)"
	desc = "Seven rounds of devastatingly powerful 50-caliber destruction. Packs a devastating punch. The bullets are tipped with an osmium-tungsten carbide alloy to not only stagger but shred through any target's armor. Issued in few numbers due to the massive production cost and worries about hull breaches. Point away from anything you value."
	default_ammo = /datum/ammo/bullet/pistol/heavy/super/highimpact/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

//-------------------------------------------------------
//Type 31 pistol. //A makarov

/obj/item/ammo_magazine/pistol/np92
	name = "\improper NP92 magazine (9x18mm Makarov)"
	default_ammo = /datum/ammo/bullet/pistol/upp
	caliber = "9x18mm Makarov"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "np92mag"
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/pistol/np92

/obj/item/ammo_magazine/pistol/np92/suppressed
	name = "\improper NPZ92 magazine (9x18mm Makarov)"
	default_ammo = /datum/ammo/bullet/pistol/upp
	caliber = "9x18mm Makarov"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "npz92mag"
	max_rounds = 12

/obj/item/ammo_magazine/pistol/np92/tranq
	name = "\improper NPZ92 tranq magazine (9x18mm Makarov)"
	default_ammo = /datum/ammo/bullet/pistol/tranq
	caliber = "9x18mm Makarov"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "npz92tranqmag"
	max_rounds = 12

//-------------------------------------------------------
//Type 73 pistol. //A TT

/obj/item/ammo_magazine/pistol/t73
	name = "\improper Type 73 magazine (7.62x25mm Tokarev)"
	default_ammo = /datum/ammo/bullet/pistol/heavy
	caliber = "7.62x25mm Tokarev"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "ttmag"
	max_rounds = 9
	gun_type = /obj/item/weapon/gun/pistol/t73

/obj/item/ammo_magazine/pistol/t73_impact
	name = "\improper High Impact Type 74 magazine (7.62x25mm Tokarev)"
	default_ammo = /datum/ammo/bullet/pistol/heavy/super/highimpact/upp
	caliber = "7.62x25mm Tokarev"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "ttmag_impact"
	max_rounds = 9
	gun_type = /obj/item/weapon/gun/pistol/t73/leader

//-------------------------------------------------------
//KT-42 //Inspired by the .44 Auto Mag pistol

/obj/item/ammo_magazine/pistol/kt42
	name = "\improper KT-42 magazine (.44)"
	default_ammo = /datum/ammo/bullet/pistol/heavy
	caliber = ".44"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "kt42"
	max_rounds = 16
	gun_type = /obj/item/weapon/gun/pistol/kt42

//-------------------------------------------------------
//PIZZACHIMP PROTECTION

/obj/item/ammo_magazine/pistol/holdout
	name = "tiny pistol magazine (.22)"
	desc = "A surprisingly small magazine, holding .22 bullets. No Kolibri, but it's getting there."
	default_ammo = /datum/ammo/bullet/pistol/tiny
	caliber = ".22"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "holdout"
	max_rounds = 5
	w_class = SIZE_TINY
	gun_type = /obj/item/weapon/gun/pistol/holdout

//-------------------------------------------------------
//CLF HOLDOUT PISTOL
/obj/item/ammo_magazine/pistol/clfpistol
	name = "Type 18 magazine (.50)"
	default_ammo = /datum/ammo/bullet/pistol/heavy/super
	caliber = ".50"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "m4a3" // placeholder
	max_rounds = 3
	w_class = SIZE_TINY
	gun_type = /obj/item/weapon/gun/pistol/clfpistol

//-------------------------------------------------------
//.45 MARSHALS PISTOL //Inspired by the Browning Hipower
// rebalanced - singlefire, very strong bullets but slow to fire and heavy recoil
// redesigned - now rejected USCM sidearm model, utilized by Colonial Marshals and other stray groups.

/obj/item/ammo_magazine/pistol/highpower
	name = "\improper HG-45 'Aguila' magazine (.45)"
	default_ammo = /datum/ammo/bullet/pistol/highpower
	caliber = ".45"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "highpower"
	max_rounds = 11
	gun_type = /obj/item/weapon/gun/pistol/highpower

//comes in black, for the black variant of the highpower, better for military usage

/obj/item/ammo_magazine/pistol/highpower/black
	name = "\improper HG 45 'Marina' magazine (.45)"
	icon_state = "highpower_b"

/obj/item/ammo_magazine/pistol/highpower/automag
	name = "\improper HG 44 'Automag' magazine (.44)"
	icon_state = "highpower_b"
	max_rounds = 13
	default_ammo = /datum/ammo/bullet/revolver

//-------------------------------------------------------
/*
Auto 9 The gun RoboCop uses. A better version of the VP78, with more rounds per magazine. Probably the best pistol around, but takes no attachments.
It is a modified Beretta 93R, and can fire three-round burst or single fire. Whether or not anyone else aside RoboCop can use it is not established.
*/

/obj/item/ammo_magazine/pistol/auto9
	name = "\improper Auto-9 magazine (9x19mm)"
	default_ammo = /datum/ammo/bullet/pistol/squash
	caliber = "9x19mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "vp70" //PLACEHOLDER
	max_rounds = 50
	gun_type = /obj/item/weapon/gun/pistol/auto9



//-------------------------------------------------------
//The first rule of monkey pistol is we don't talk about monkey pistol.
/obj/item/ammo_magazine/pistol/chimp
	name = "\improper CHIMP70 magazine (.70M)"
	default_ammo = /datum/ammo/bullet/pistol/mankey
	caliber = ".70M"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	icon_state = "c70" //PLACEHOLDER

	matter = list("metal" = 3000)
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/pistol/chimp

//-------------------------------------------------------
//Smartpistol IFF magazine.

/obj/item/ammo_magazine/pistol/smart
	name = "\improper SU-6 Smartpistol magazine (.45)"
	default_ammo = /datum/ammo/bullet/pistol/smart
	caliber = ".45"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "smartpistol"
	max_rounds = 15
	gun_type = /obj/item/weapon/gun/pistol/smart

//-------------------------------------------------------
//SKORPION //Based on the same thing.

/obj/item/ammo_magazine/pistol/skorpion
	name = "\improper CZ-81 20-round magazine (.32ACP)"
	desc = "A .32ACP caliber magazine for the CZ-81."
	caliber = ".32ACP"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "skorpion" //PLACEHOLDER
	gun_type = /obj/item/weapon/gun/pistol/skorpion
	max_rounds = 20
