/obj/item/clothing/shoes/marine/magboots
	desc = "Magnetic boots, often used during extravehicular activity to ensure the user remains safely attached to the vehicle. This requires a battery to function."
	name = "magboots"
	icon_state = "magboots0"
	var/magpulse = FALSE
	var/auto_turn_off = FALSE
	var/turn_off_timer
	actions_types = list(/datum/action/item_action/toggle)
	allowed_items_typecache = null
	var/obj/item/cell/crap/battery

/obj/item/clothing/shoes/marine/magboots/Initialize()
	. = ..()
	battery = new(src)

/obj/item/clothing/shoes/marine/magboots/attackby(obj/item/W, mob/user)
	if(!can_insert_battery(user, W, battery))
		return ..()
	else
		battery = W
	return ..()

/obj/item/clothing/shoes/marine/magboots/attack_hand(mob/user)
	if(!can_remove_battery(user, battery, TRUE))
		return ..()
	else
		battery = null

/obj/item/clothing/shoes/marine/magboots/attack_self(mob/user)
	..()
	toggle(FALSE, user)



/obj/item/clothing/shoes/marine/magboots/get_examine_text(mob/user)
	. = ..()
	var/state = "disabled"
	if(flags_inventory&NOSLIPPING)
		state = "enabled"
	. += "Its mag-pulse traction system appears to be [state]."
	if(auto_turn_off)
		. += "This will automatically turn itself off after "
	if(battery)
		. += "\nThe charge meter reads <b>[floor(battery.percent() )]%</b>"

/obj/item/clothing/shoes/marine/magboots/proc/toggle(force_off = FALSE, mob/user)
	var/no_battery = FALSE
	if(battery != null)
		if(battery.charge < 1)
			no_battery = TRUE
			force_off = TRUE
	else
		no_battery = TRUE
		force_off = TRUE
	if(magpulse || force_off)
		flags_inventory &= ~NOSLIPPING
		slowdown = SHOES_SLOWDOWN
		magpulse = FALSE
		icon_state = "magboots0"
		to_chat(user, SPAN_NOTICE("[no_battery ? "The mag-pulse traction system shuts down due to lack of power." : "The mag-pulse traction system auto-shuts off."]"))
		if(no_battery)
			playsound(loc, 'sound/effects/zzzt.ogg', 10, TRUE)
		else
			playsound(loc, 'sound/effects/magnet.ogg', 10, TRUE)
	else
		if(battery && battery.charge > 0)
			flags_inventory |= NOSLIPPING
			slowdown = 0
			user.make_floating(0)
			magpulse = TRUE
			icon_state = "magboots1"
			to_chat(user, SPAN_NOTICE("You enable the mag-pulse traction system."))
			playsound(loc, 'sound/effects/magnet.ogg', 10, TRUE)
			if(auto_turn_off)
				turn_off_timer = addtimer(CALLBACK(src, PROC_REF(toggle), TRUE, user), 100, TIMER_UNIQUE|TIMER_OVERRIDE)
	user.update_inv_shoes() //so our mob-overlays update

	for(var/X in actions)
		var/datum/action/A = X
		A.update_button_icon()


/mob/living/carbon/human/proc/check_for_magboots(drain_power = 0.5, mob/user)
	if((istype(shoes, /obj/item/clothing/shoes/marine/magboots) && (shoes.flags_inventory & NOSLIPPING)))
		var/obj/item/clothing/shoes/marine/magboots/magnetic_boots = shoes
		if(magnetic_boots.battery != null)
			if(!magnetic_boots.battery.use(drain_power))
				magnetic_boots.toggle(FALSE, user)
				return FALSE
		else
			return FALSE
		return TRUE
	else
		return FALSE


/obj/item/clothing/shoes/magboots/New() //replacement
	new /obj/item/clothing/shoes/marine/magboots(loc)
	qdel(src)
