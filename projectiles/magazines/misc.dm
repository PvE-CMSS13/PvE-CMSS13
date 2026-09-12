

//Minigun

/obj/item/ammo_magazine/minigun
	name = "rotating ammo drum (7.62x51mm)"
	desc = "A huge ammo drum for a huge gun."
	caliber = "7.62x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	icon_state = "painless" //PLACEHOLDER

	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/minigun
	max_rounds = 300
	reload_delay = 24 //Hard to reload.
	gun_type = /obj/item/weapon/gun/minigun
	w_class = SIZE_MEDIUM

/obj/item/ammo_magazine/minigun/upp
	default_ammo = /datum/ammo/bullet/minigun/upp

//-------------------------------------------------------
//M41AE2 HEAVY PULSE RIFLE

/obj/item/ammo_magazine/hpr_box
	name = "\improper M41AE2 ammo box (10x24mm)"
	desc = "A magazine of rounds for the M41AE2 Heavy Pulse Rifle."
	caliber = "10x24mm"
	icon_state = "m41ae2"
	default_ammo = /datum/ammo/bullet/rifle/tracer
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/rifle/lmg
	flags_magazine = AMMUNITION_REFILLABLE|AMMUNITION_SLAP_TRANSFER
	ammo_band_icon = "+m41ae2_band"
	ammo_band_icon_empty = "+m41ae2_band_e"
	w_class = SIZE_MEDIUM
	reload_delay = 5

/obj/item/ammo_magazine/hpr_box/holo_target
	name = "\improper M41AE2 ammo box (10x24mm holo-target)"
	desc = "A magazine of holo-target rounds for the M41AE2 Heavy Pulse Rifle."
	default_ammo = /datum/ammo/bullet/rifle/holo_target/tracer
	max_rounds = 300
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING


/obj/item/ammo_magazine/hpr_box/ap
	name = "\improper M41AE2 AP ammo box (10x24mm)"
	desc = "A magazine of steelcore armor piercing rounds for the M41AE2 Heavy Pulse Rifle."
	default_ammo = /datum/ammo/bullet/rifle/ap/tracer
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/rifle/lmg
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/hpr_box/heap
	name = "\improper M41AE2 HEAP ammo box (10x24mm)"
	desc = "A magazine of M903 armor piercing high explosive rounds for the M41AE2 Heavy Pulse Rifle."
	default_ammo = /datum/ammo/bullet/rifle/heap/tracer
	max_rounds = 300
	gun_type = /obj/item/weapon/gun/rifle/lmg
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/hpr_box/recon
	icon_state = "m41ae2_recon"
	bonus_overlay = "m41ae2_recon_overlay"

//M60

/obj/item/ammo_magazine/m60
	name = "Mk70 belt box (7.62x51mm)"
	desc = "Limited production run by Henjin-Garcia of old Earth weapons. A 100rnd belt box for their Mk70 reproduction of the M60 GPMG."
	caliber = "7.62x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "m60" //PLACEHOLDER

	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/m60
	max_rounds = 100
	reload_delay = 8
	gun_type = /obj/item/weapon/gun/m60

/obj/item/ammo_magazine/pkp
	name = "QYJ-72 ammo box (10x27mm HEAP)"
	desc = "A 250 round box of HEAP ammunition for the UPP's standard GPMG, the QYJ-72. Chambered in 10x27mm."
	caliber = "10x27mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "qjy72"
	ammo_band_icon = "+qjy72_band"
	ammo_band_icon = "+qjy72_band_e"
	matter = list("metal" = 10000)
	default_ammo = /datum/ammo/bullet/rifle/upp/heap/tracer
	max_rounds = 250
	reload_delay = 12
	gun_type = /obj/item/weapon/gun/pkp

/obj/item/ammo_magazine/pkp/verb/turn_into_regular()
	set name = "Turn into a 10x27mm HEAP box"
	set category = "Object"
	set src in usr
	if(current_rounds < 1)
		var/obj/item/ammo_magazine/pkp/empty_mag = new /obj/item/ammo_magazine/pkp(usr.loc)
		empty_mag.current_rounds = 0
		empty_mag.update_icon()
		qdel(src)
		to_chat(usr, "You configure the springs inside the [src] for reloading with HEAP 10x27mm rounds")
	else
		to_chat(usr, "The [src] needs to be empty before you can configure it for reloading with HEAP 10x27mm rounds")

/obj/item/ammo_magazine/pkp/standard_fmj
	name = "QYJ-72 ammo box (10x27mm)"
	desc = "A 250 round box of ammunition for the UPP's standard GPMG, the QYJ-72. Chambered in 10x27mm."
	default_ammo = /datum/ammo/bullet/rifle/upp/tracer

/obj/item/ammo_magazine/pkp/super_tracer
	name = "QYJ-72 ammo box (10x27mm magnesium tracer HEAP)"
	desc = "A 250 round box of HEAP ammunition with magnesium tracers for the UPP's standard GPMG, the QYJ-72. Leaves a lingering light source where the bullet hits. Chambered in 10x27mm."
	default_ammo = /datum/ammo/bullet/rifle/upp/heap/tracer/super_tracer
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/pkp/penetrating
	name = "QYJ-72 ammo box (10x27mm wall-penetrating)"
	desc = "A 250 round box of wall-penetrating ammunition for the UPP's standard GPMG, the QYJ-72. Chambered in 10x27mm."
	default_ammo = /datum/ammo/bullet/rifle/upp/heap/tracer/penetrating
	reload_delay = 6
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

//rocket launchers

/obj/item/ammo_magazine/rifle/grenadespawner
	AUTOWIKI_SKIP(TRUE)

	name = "\improper GRENADE SPAWNER AMMO"
	desc = "OH GOD OH FUCK"
	default_ammo = /datum/ammo/grenade_container/rifle
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/rifle/huggerspawner
	AUTOWIKI_SKIP(TRUE)

	name = "\improper HUGGER SPAWNER AMMO"
	desc = "OH GOD OH FUCK"
	default_ammo = /datum/ammo/hugger_container
	ammo_band_color = AMMO_BAND_COLOR_SUPER
