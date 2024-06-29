/obj/structure/coatrack
	name = "coat rack"
	desc = "Rack that holds coats."
	icon = 'icons/obj/structures/props/misc.dmi'
	icon_state = "coatrack0"
	unslashable = TRUE
	var/obj/item/clothing/suit/current_suit
	var/list/allowed_suits
	var/image/overlay_image

/obj/structure/coatrack/Initialize()
	. = ..()
	overlay_image = new(src)
	allowed_suits = list(
		/obj/item/clothing/suit/storage/jacket,
		/obj/item/clothing/suit/storage/labcoat,
		/obj/item/clothing/suit/storage/windbreaker,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/suit/storage/det_suit,
		/obj/item/clothing/suit/storage/bomber,
		/obj/item/clothing/suit/storage/CMB,
		/obj/item/clothing/suit/storage/RO,
		/obj/item/clothing/suit/storage/forensics,
		/obj/item/clothing/suit/storage/lawyer,
		/obj/item/clothing/suit/storage/manager,
	)

/obj/structure/coatrack/Destroy()
	. = ..()
	QDEL_NULL(current_suit)
	QDEL_NULL(overlay_image)

/obj/structure/coatrack/update_icon(obj/item/clothing/suit/storage/new_suit)
	if(new_suit)
		current_suit = new_suit
		current_suit.pixel_x = 0 // Important to reset these, so that the sprite is not misaligned.
		current_suit.pixel_y = 0
		overlay_image.appearance = current_suit.appearance
		overlay_image.pixel_y += 5 // Pixel offsets are part of visual appearance. So the above line resets the offsets on our image.
		overlay_image.pixel_x -= 3
		// Can't use add_filter as images are not regular atoms and do not have that proc. Maybe convert this into a vis_contents in the future if more features are added.
		overlay_image.filters += filter(type="alpha", icon=src.icon) // This applies a basic mask to fake a hanging coat. Kind of crude, may need replacement if the icons change.
		overlays += overlay_image
	else
		overlays -= overlay_image
		current_suit = null

/obj/structure/coatrack/attack_hand(mob/user)
	if(current_suit)
		user.visible_message(SPAN_NOTICE("[user] takes [current_suit] off [src]."), SPAN_NOTICE("You take [current_suit] off the [src]."))
		user.put_in_hands(current_suit)
		playsound(src, "rustle", 20, TRUE)
		update_icon()

/obj/structure/coatrack/attackby(obj/item/attacking_object, mob/user)
	if(current_suit)
		to_chat(user, SPAN_WARNING("[current_suit] is already hanging on [src]!"))
	else
		for(var/path in allowed_suits)
			if(istype(attacking_object, path)) // A little expensive, but it's such a niche object.
				user.drop_inv_item_to_loc(attacking_object, src)
				user.visible_message(SPAN_NOTICE("[user] hangs [attacking_object] on [src]."), SPAN_NOTICE("You hang [attacking_object] on the [src]."))
				playsound(src, "rustle", 20, TRUE)
				update_icon(attacking_object)
				return TRUE
		to_chat(user, SPAN_WARNING("You cannot hang [attacking_object] on [src]!"))
	return ..()

/obj/structure/coatrack/Crossed(atom/movable/movable_atom)
	. = ..()
	if(!current_suit && istype(movable_atom, /obj/item/clothing/suit/storage)) // A little safety before we go into a loop of typechecking a bunch of stuff.
		for(var/path in allowed_suits)
			if(istype(movable_atom, path))
				visible_message(SPAN_NOTICE("[movable_atom] lands on [src]."))
				movable_atom.forceMove(src)
				playsound(src, "rustle", 20, TRUE)
				update_icon(movable_atom)
				return TRUE

// I don't want to go through CPU cycles in order to typecheck against everything in a tile, so we're just hard-spawning them in.
/obj/structure/coatrack/bridge_coat/Initialize()
	. = ..()
	var/obj/item/clothing/suit/storage/jacket/marine/dress/bridge_coat_grey/to_spawn = new(src)
	update_icon(to_spawn)

/obj/structure/coatrack/labcoat/Initialize()
	. = ..()
	var/obj/item/clothing/suit/storage/labcoat/to_spawn = new(src)
	update_icon(to_spawn)

/obj/structure/coatrack/labcoat_officer/Initialize()
	. = ..()
	var/obj/item/clothing/suit/storage/labcoat/officer/to_spawn = new(src)
	update_icon(to_spawn)
