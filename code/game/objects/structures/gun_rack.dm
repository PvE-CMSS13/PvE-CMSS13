/obj/structure/gun_rack
	name = "gun rack"
	desc = "Nice rack!"
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
		to_chat(user, SPAN_WARNING("\The [src] is empty."))
		return

	var/obj/Obj = contents[contents.len]
	contents -= Obj
	user.put_in_hands(Obj)
	to_chat(user, SPAN_NOTICE("You grab \a [Obj] from \the [src]."))
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
	max_stored = 6
	initial_stored = 6
	allowed_type = /obj/item/weapon/gun/rifle/type71
