/obj/structure/gun_rack
	name = "gun rack"
	desc = "ARMAT-produced gun rack for storage of long guns. While initial model was supposed to be extremely modifiable, USCM comissioned racks with fixed slots which only fit M41A rifles. Some say they were cheaper, and some say the main reason was marine's ability to easily break anything more complex than a tungsten ball."
	icon = 'icons/obj/structures/gun_racks.dmi'
	icon_state = "m41a"
	density = TRUE
	health = 250
	var/allowed_type
	var/populate_type
	var/max_stored = 5
	var/initial_stored = 5

/obj/structure/gun_rack/Initialize()
	. = ..()

	debris = list(/obj/item/stack/rods, /obj/item/stack/sheet/metal) //Want to initialize lists here instead of defining them per item.

	if(initial_stored > 0 && populate_type)
		var/i = 0
		while(i++ < min(initial_stored, max_stored))
			new populate_type(src) //Automatically go into contents.

	update_icon()

/obj/structure/gun_rack/Destroy()
	dump_contents() //Dump everything available.
	return ..()

/obj/structure/gun_rack/ex_act(severity, direction)
	if(indestructible || !health)
		return //If it has no health or isn't supposed to be destroyed.

	health -= severity
	if(health <= 0)
		handle_debris(severity, direction)
		deconstruct(FALSE) //This will call dump_contents()
	else if(severity > EXPLOSION_THRESHOLD_LOW) //If it's greater than a small explosion, we want to dump one or two guns out.
		dump_contents(rand(1,2))

/obj/structure/gun_rack/update_icon()
	icon_state = "[initial(icon_state)]_[max(0, length(contents))]"

/obj/structure/gun_rack/attackby(obj/item/O, mob/user)
	if(istype(O, allowed_type) && length(contents) < max_stored)
		user.drop_inv_item_to_loc(O, src)
		update_icon()

/obj/structure/gun_rack/attack_hand(mob/living/user)
	var/len = length(contents)
	if(!len)
		to_chat(user, SPAN_WARNING("[src] is empty."))
		return

	var/obj/stored_obj = contents[len]
	user.put_in_hands(stored_obj)
	to_chat(user, SPAN_NOTICE("You grab [stored_obj] from [src]."))
	playsound(src, "gunequip", 25, TRUE)
	update_icon()

//Similar to closets, these can dump out their contents. Except in this case we dump a variable amount depending on what triggered the proc.
/obj/structure/gun_rack/proc/dump_contents(number_to_remove = max_stored)
	number_to_remove = min(length(contents), number_to_remove)
	for(var/obj/thing in src) //obj iteration should be pretty fast.
		if(number_to_remove-- <= 0)
			break
		thing.forceMove(loc)
		thing.pixel_x = 0 //Reset offsets so that it is centered properly on a tile.
		thing.pixel_y = 0

	update_icon()

/obj/structure/gun_rack/proc/empty_out(number_to_remove = max_stored)
	number_to_remove = min(length(contents), number_to_remove) //We don't want our specified mumber, if provided, to be greater than what is actually inside the rack.
	for(var/i in src)
		if(!number_to_remove--)
			break
		qdel(i)

	update_icon()

//===================================================

/obj/structure/gun_rack/m41
	allowed_type = /obj/item/weapon/gun/rifle/m41aMK1
	populate_type = /obj/item/weapon/gun/rifle/m41aMK1

/obj/structure/gun_rack/m41/unloaded
	populate_type = /obj/item/weapon/gun/rifle/m41aMK1/unloaded

/obj/structure/gun_rack/type71
	icon_state = "type71"
	desc = "Some off-branded gun rack. Per SOF and UPPA regulations, weapons should be stored in secure safes and only given out when necessary. Of course, most (but not all!) units overlook this regulation, only storing their firearms in safes when inspection arrives."
	max_stored = 6
	initial_stored = 6
	allowed_type = /obj/item/weapon/gun/rifle/type71
	populate_type = /obj/item/weapon/gun/rifle/type71

/obj/structure/gun_rack/type71/unloaded
	populate_type = /obj/item/weapon/gun/rifle/type71/unloaded

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

/obj/structure/gun_rack/m41/recon
	icon_state = "m41arecon"
	populate_type = /obj/item/weapon/gun/rifle/m41aMK1/forecon

/obj/structure/gun_rack/m41/recon/unloaded
	populate_type = /obj/item/weapon/gun/rifle/m41aMK1/forecon/unloaded
