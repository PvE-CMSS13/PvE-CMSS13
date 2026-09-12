//-----------------------AMMUNITION BOXES (LOOSE AMMO)-----------------------

//----------------10x24mm Ammunition Boxes (for M41 family, M49A, and L42)------------------

/obj/item/ammo_box/rounds/ap
	name = "\improper rifle ammunition box (10x24mm AP)"
	desc = "A 10x24mm armor-piercing ammunition box. Used to refill M41A MK2, and M49A AP magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_ap"
	default_ammo = /datum/ammo/bullet/rifle/ap

/obj/item/ammo_box/rounds/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/le
	name = "\improper rifle ammunition box (10x24mm LE)"
	desc = "A 10x24mm armor-shredding ammunition box. Used to refill M41A MK2 LE magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_le"
	default_ammo = /datum/ammo/bullet/rifle/le

/obj/item/ammo_box/rounds/le/empty
	empty = TRUE

/obj/item/ammo_box/rounds/incen
	name = "\improper rifle ammunition box (10x24mm Incen)"
	desc = "A 10x24mm incendiary ammunition box. Used to refill M41A MK2 and M49A incendiary magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_incen"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	bullet_amount = 400 //Incen is OP
	max_bullet_amount = 400

/obj/item/ammo_box/rounds/incen/empty
	empty = TRUE

/obj/item/ammo_box/rounds/heap
	name = "rifle ammunition box (10x24mm HEAP)"
	desc = "A 10x24mm high-explosive armor-piercing ammunition box. Used to refill magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_heap"
	default_ammo = /datum/ammo/bullet/rifle/heap

/obj/item/ammo_box/rounds/heap/empty
	empty = TRUE

//----------------10x28mm Ammunition Boxes (for smartguns)------------------

/obj/item/ammo_box/rounds/smartgun
	name = "\improper smartgun ammunition box (10x28mm)"
	icon_state = "base_m56rd"
	desc = "A 10x28mm ammunition box. Used to refill smartgun drum magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_reg"
	default_ammo = /datum/ammo/bullet/rifle/heavy/tracer
	caliber = "10x28mm"
	bullet_amount = 1000
	max_bullet_amount = 1000

/obj/item/ammo_box/rounds/smartgun/empty
	empty = TRUE

// RMC SG
/obj/item/ammo_box/rounds/smartgun/holo_target
	name = "\improper holo-targetting smartgun ammunition box (10x28mm)"
	desc = "An ammunition box full of 10x28mm holo-targetting rounds. Used to refill L58A3 smartgun drums. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_impact"
	default_ammo = /datum/ammo/bullet/rifle/heavy/holo_target

/obj/item/ammo_box/rounds/smartgun/holo_target/empty
	empty = TRUE

//----------------9mm Ammunition Boxes (for Viper 9 SMG)------------------

/obj/item/ammo_box/rounds/smg
	name = "\improper SMG ammunition box (9mm)"
	desc = "A 9mm ammunition box. It comes with a leather strap allowing to wear it on the back."
	caliber = "9mm"
	icon_state = "base_m39"
	overlay_content = "_hv"
	default_ammo = /datum/ammo/bullet/pistol

/obj/item/ammo_box/rounds/smg/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/ap
	name = "\improper SMG ammunition box (9mm AP)"
	desc = "A 9mm armor-piercing ammunition box. It comes with a leather strap allowing to wear it on the back."
	caliber = "9mm"
	overlay_content = "_ap"
	default_ammo = /datum/ammo/bullet/pistol/ap

/obj/item/ammo_box/rounds/smg/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/le
	name = "\improper SMG ammunition box (9mm LE)"
	desc = "A 9mm armor-shredding ammunition box. It comes with a leather strap allowing to wear it on the back."
	caliber = "9mm"
	overlay_content = "_le"
	default_ammo = /datum/ammo/bullet/pistol/le

/obj/item/ammo_box/rounds/smg/le/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/incen
	name = "\improper SMG ammunition box (9mm Incen)"
	desc = "A 9mm incendiary ammunition box. It comes with a leather strap allowing to wear it on the back."
	caliber = "9mm"
	overlay_content = "_incen"
	default_ammo = /datum/ammo/bullet/pistol/incendiary
	bullet_amount = 400 //Incen is OP
	max_bullet_amount = 400

/obj/item/ammo_box/rounds/smg/incen/empty
	empty = TRUE

/obj/item/ammo_box/rounds/smg/heap
	name = "SMG ammunition box (9mm HEAP)"
	desc = "A 9mm armor-piercing high-explosive ammunition box. It comes with a leather strap allowing to wear it on the back."
	caliber = "9mm"
	overlay_content = "_heap"
	default_ammo = /datum/ammo/bullet/smg/heap

/obj/item/ammo_box/rounds/smg/heap/empty
	empty = TRUE

//----------------10x27mm Ammunition Boxes (for UPP Type71 family)------------------

/obj/item/ammo_box/rounds/type71
	name = "\improper rifle ammunition box (10x27mm)"
	desc = "A 10x27mm ammunition box. Used to refill Type71 magazines. It comes with a leather strap allowing to wear it on the back."
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_type71"
	overlay_content = "_type71_reg"
	caliber = "10x27mm"
	default_ammo = /datum/ammo/bullet/rifle/upp

/obj/item/ammo_box/rounds/type71/empty
	empty = TRUE

/obj/item/ammo_box/rounds/type71/ap
	name = "\improper rifle ammunition box (10x27mm AP)"
	desc = "A 10x27mm armor-piercing ammunition box. Used to refill Type71 AP magazines. It comes with a leather strap allowing to wear it on the back."
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_type71"
	overlay_content = "_type71_ap"
	default_ammo = /datum/ammo/bullet/rifle/upp/ap

/obj/item/ammo_box/rounds/type71/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/type71/heap
	name = "rifle ammunition box (10x27mm HEAP)"
	desc = "A 10x27mm high-explosive armor-piercing ammunition box. Used to refill Type 71 and QYJ-72 HEAP magazines. It comes with a leather strap allowing to wear it on the back."
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_type71"
	overlay_content = "_type71_heap"
	default_ammo = /datum/ammo/bullet/rifle/upp/heap

/obj/item/ammo_box/rounds/type71/heap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pkp
	name = "large rifle ammunition box (10x27mm)"
	desc = "A 10x27mm machinegun ammunition box. Used to mostly to refill Type 71 and QYJ-72 box magazines. It comes with a leather strap allowing to wear it on the back."
	icon_state = "base_type71"
	overlay_gun_type = "_rounds_pkp"
	overlay_content = "_type71_heap"
	default_ammo = /datum/ammo/bullet/rifle/upp/heap/tracer
	bullet_amount = 1500
	max_bullet_amount = 1500
	caliber = "10x27mm"

//----------------9mm Pistol Ammunition Boxes (for mod88, M4A3 pistols)------------------

/obj/item/ammo_box/rounds/pistol
	name = "\improper pistol ammunition box (9mm)"
	desc = "A 9mm ammunition box. Used to refill M4A3 magazines. It comes with a leather strap allowing to wear it on the back."
	caliber = "9mm"
	icon_state = "base_m4a3"
	overlay_content = "_reg"
	default_ammo = /datum/ammo/bullet/pistol

/obj/item/ammo_box/rounds/pistol/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/ap
	name = "\improper pistol ammunition box (9mm AP)"
	desc = "A 9mm armor-piercing ammunition box. Used to refill mod88 and M4A3 magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_ap"
	default_ammo = /datum/ammo/bullet/pistol/ap

/obj/item/ammo_box/rounds/pistol/ap/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/hp
	name = "\improper pistol ammunition box (9mm HP)"
	desc = "A 9mm hollow-point ammunition box. Used to refill M4A3 magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_hp"
	default_ammo = /datum/ammo/bullet/pistol/hollow

/obj/item/ammo_box/rounds/pistol/hp/empty
	empty = TRUE

/obj/item/ammo_box/rounds/pistol/incen
	name = "\improper pistol ammunition box (9mm Incendiary)"
	desc = "A 9mm incendiary ammunition box. Used to refill M4A3 magazines. It comes with a leather strap allowing to wear it on the back."
	overlay_content = "_incen"
	default_ammo = /datum/ammo/bullet/pistol/incendiary

/obj/item/ammo_box/rounds/pistol/incen/empty
	empty = TRUE
