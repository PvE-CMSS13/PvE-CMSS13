/obj/structure/magazine_box/nade_box
	name = "\improper grenade box"
	desc = "A generic grenade box. If you're seeing this, something went wrong and you should contact a GM about it."
	icon = 'icons/obj/items/weapons/guns/ammo_boxes/boxes_and_lids.dmi'
	icon_state = "base_uscm_nade"
	limit_per_tile = 1
	holds_grenades = TRUE
	holds_ammo = FALSE

	var/grenades_icon = 'icons/obj/items/weapons/guns/ammo_boxes/grenades.dmi'
	flames_icon = 'icons/obj/items/weapons/guns/ammo_boxes/misc.dmi'

//---------------------GENERAL PROCS

/obj/structure/magazine_box/nade_box/Destroy()
	if(boom_box)
		qdel(boom_box)
		boom_box = null
	return ..()

/obj/structure/magazine_box/nade_box/update_icon()
	if(overlays)
		overlays.Cut()

	if(length(boom_box.contents) >= (boom_box.num_of_magazines/2))
		overlays += image(grenades_icon, icon_state = "[boom_box.overlay_grenade_type]")
	else if(length(boom_box.contents) > (boom_box.num_of_magazines/8))
		overlays += image(grenades_icon, icon_state = "[boom_box.overlay_grenade_type]_1")

/obj/structure/magazine_box/nade_box/attack_hand(mob/living/user)
	if(burning)
		to_chat(user, SPAN_DANGER("It's on fire and the grenades inside might explode at any time!"))
		return
	if(length(boom_box.contents))
		var/obj/item/explosive/grenade/nade = pick(boom_box.contents)
		boom_box.contents -= nade
		user.put_in_hands(nade)
		to_chat(user, SPAN_NOTICE("You retrieve \a [nade] from \the [src]."))
		update_icon()
	else
		to_chat(user, SPAN_NOTICE("\The [src] is empty."))

/obj/structure/magazine_box/nade_box/attackby(obj/item/W, mob/living/user)
	if(burning)
		to_chat(user, SPAN_DANGER("It's on fire and the grenades inside might explode at any time!"))
		return
	if(istypestrict(W,boom_box.magazine_type) || is_type_in_list(W, boom_box.allowed_magazines))
		if(istype(W, /obj/item/explosive/grenade))
			var/obj/item/explosive/grenade/nade = W
			if(nade.w_class == SIZE_HUGE)
				to_chat(user, SPAN_WARNING("[W] is armed! Don't be stupid!"))
				return
		if(length(boom_box.contents) < boom_box.num_of_magazines)
			user.drop_inv_item_to_loc(W, src)
			boom_box.contents += W
			to_chat(user, SPAN_NOTICE("You put \a [W] into [src]"))
			update_icon()
		else
			to_chat(user, SPAN_WARNING("[src] is full."))
	else
		to_chat(user, SPAN_WARNING("You don't want to mix different grenades in one box."))

//---------------------FIRE HANDLING PROCS

/obj/structure/magazine_box/nade_box/flamer_fire_act(damage, datum/cause_data/flame_cause_data)
	if(burning || !boom_box)
		return
	burning = TRUE
	boom_box.flamer_fire_act(damage, flame_cause_data)
	return
