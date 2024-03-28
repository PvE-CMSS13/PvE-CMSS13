/obj/structure/gun_rack
	name = "gun rack"
	desc = "ARMAT-produced gun rack for storage of long guns. While initial model was supposed to be extremely modifiable, USCM comissioned racks with fixed slots which only fit M41A rifles. Some say they were cheaper, and some say the main reason was marine's ability to easily break anything more complex than a tungsten ball."
	icon = 'icons/obj/structures/gun_racks.dmi'
	icon_state = "m41a"
	density = TRUE
	var/allowed_type
	var/max_stored = 5
	var/initial_stored = 5

/obj/structure/gun_rack/Initialize()
	. = ..()
	if(!allowed_type)
		icon_state = "m41a_0"
		return

	if(initial_stored)
		var/i = 0
		while(i < initial_stored)
			contents += new allowed_type(src)
			i++
	update_icon()

/obj/structure/gun_rack/attackby(obj/item/O, mob/user)
	if(istype(O, allowed_type) && contents.len < max_stored)
		user.drop_inv_item_to_loc(O, src)
		contents += O
		update_icon()

/obj/structure/gun_rack/attack_hand(mob/living/user)
	if(!contents.len)
		to_chat(user, SPAN_WARNING("[src] is empty."))
		return

	var/obj/stored_obj = contents[contents.len]
	contents -= stored_obj
	user.put_in_hands(stored_obj)
	to_chat(user, SPAN_NOTICE("You grab [stored_obj] from [src]."))
	playsound(src, "gunequip", 25, TRUE)
	update_icon()

/obj/structure/gun_rack/update_icon()
	if(contents.len)
		icon_state = "[initial(icon_state)]_[contents.len]"
	else
		icon_state = "[initial(icon_state)]_0"

/obj/structure/gun_rack/m41
	allowed_type = /obj/item/weapon/gun/rifle/m41aMK1

/obj/structure/gun_rack/type71
	icon_state = "type71"
	desc = "Some off-branded gun rack. Per SOF and UPPA regulations, weapons should be stored in secure safes and only given out when necessary. Of course, most (but not all!) units overlook this regulation, only storing their firearms in safes when inspection arrives."
	max_stored = 6
	initial_stored = 6
	allowed_type = /obj/item/weapon/gun/rifle/type71

/obj/structure/gun_rack/apc
	name = "APC ammo compartment"
	icon_state = "frontal"
	desc = "Uhoh. You shouldn't be seeing this."

/obj/structure/gun_rack/apc/frontal
	name = "frontal cannon ammo storage compartment"
	icon_state = "frontal"
	desc = "A small compartment that stores ammunition for the APC's 'Bleihagel RE-RE700 Frontal Cannon'."
	max_stored = 2
	initial_stored = 0
	allowed_type = /obj/item/ammo_magazine/hardpoint/m56_cupola/frontal_cannon

/obj/structure/gun_rack/apc/boyars
	name = "dual cannon ammo storage compartment"
	icon_state = "boyars"
	desc = "A small compartment that stores ammunition for the APC's 'PARS-159 Boyars Dualcannon'."
	max_stored = 2
	initial_stored = 0
	allowed_type = /obj/item/ammo_magazine/hardpoint/boyars_dualcannon

/obj/structure/gun_rack/xm40
	icon_state = "xm40"
	desc = "ARMAT-produced gun rack for storage of long guns. This one in particular is fitted to hold the advanced XM40SD series of rifles, one that never got slated for mass production and is now given out to select special forces units. Get tactical."
	max_stored = 6
	initial_stored = 6
	allowed_type = /obj/item/weapon/gun/rifle/m41a/elite/xm40/ap
