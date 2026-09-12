//Spacesuit
//Note: Everything in modules/clothing/spacesuits should have the entire suit grouped together.
//   Meaning the suit is defined directly after the corrisponding helmet. Just like below!
/obj/item/clothing/head/helmet/space
	name = "Space helmet"
	icon_state = "space"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment."
	item_state = "space"
	permeability_coefficient = 0.01
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_ULTRAHIGH
	armor_rad = CLOTHING_ARMOR_ULTRAHIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = COVEREYES|COVERMOUTH|NOPRESSUREDMAGE|BLOCKSHARPOBJ|PROTECTFROMWEATHER|ALLOWINTERNALS|BLOCKGASEFFECT
	flags_inv_hide = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEALLHAIR
	flags_armor_protection = BODY_FLAG_HEAD|BODY_FLAG_FACE|BODY_FLAG_EYES
	flags_cold_protection = BODY_FLAG_HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROT
	siemens_coefficient = 0.9
	eye_protection = EYE_PROTECTION_WELDING
	drag_unequip = TRUE
	var/datum/looping_sound/eva_oxygen/beep_loop

/obj/item/clothing/head/helmet/space/Initialize()
	. = ..()
	beep_loop = new(src)

/obj/item/clothing/head/helmet/space/Destroy()
	QDEL_NULL(beep_loop)
	return ..()

/obj/item/clothing/head/helmet/space/unequipped(mob/user, slot)
	. = ..()
	if(beep_loop)
		beep_loop.stop()

/obj/item/clothing/suit/space
	name = "Space suit"
	desc = "A suit that protects against low pressure environments."
	icon_state = "space"
	item_state = "s_suit"
	w_class = SIZE_LARGE//bulky item
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.02
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	allowed = list(/obj/item/device/flashlight,/obj/item/tank/emergency_oxygen,/obj/item/tool/crowbar)
	slowdown = SLOWDOWN_ARMOR_HEAVY
	movement_compensation = SLOWDOWN_ARMOR_LOWHEAVY
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_HIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW
	flags_inventory = BLOCKSHARPOBJ|NOPRESSUREDMAGE|BYPASSFORINJECTOR|PROTECTFROMWEATHER
	flags_inv_hide = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_LEGS|BODY_FLAG_FEET|BODY_FLAG_ARMS|BODY_FLAG_HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROT
	siemens_coefficient = 0.9
	drag_unequip = TRUE
	var/can_support_limbs = TRUE
	var/list/supporting_limbs = list()//If not-null, automatically splints breaks. Checked when removing the suit.

/obj/item/clothing/suit/space/Initialize()
	. = ..()
	base_name = "[name]"
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/space/process()
	if (!ishuman(loc))
		return
	var/mob/living/carbon/human/wearer = loc
	var/loc_temp = loc.return_temperature()
	if (loc_temp < wearer.bodytemperature) // Place is colder than we are
		var/thermal_protection = max(0, 1 - ((min_cold_protection_temperature + damage*SPACESUIT_COOLING_WHEN_DAMAGED_MULTIPLIER) - loc_temp) / 40)
		if (thermal_protection < 1)
			wearer.bodytemperature += (1 - thermal_protection) * ((loc_temp - wearer.bodytemperature) / 30)

/obj/item/clothing/suit/space/equipped(mob/M, put_into_slot)
	if(flags_equip_slot && slotdefine2slotbit(put_into_slot))
		INVOKE_NEXT_TICK(src, PROC_REF(check_limb_support), FALSE, M)
	..()

/obj/item/clothing/suit/space/unequipped(mob/M, slot)
	INVOKE_NEXT_TICK(src, PROC_REF(check_limb_support), TRUE, M)
	..()

// Some space suits are equipped with reactive membranes that support
// broken limbs - at the time of writing, only the ninja suit, but
// I can see it being useful for other suits as we expand them. ~ Z
// The actual splinting occurs in /obj/limb/proc/fracture()
/obj/item/clothing/suit/space/proc/check_limb_support(being_taken_off = FALSE, human)
	if(!can_support_limbs)
		return
	// If this isn't set, then we don't need to care.
	//if(!LAZYLEN(supporting_limbs))
	//	return

	var/mob/living/carbon/human/H = human

	// If this isn't set, then we don't need to care.
	if(!being_taken_off)
		for(var/obj/limb/O in H.limbs)
			if(!(O.status & LIMB_SPLINTED) && (O.status & LIMB_BROKEN))
				to_chat(H, SPAN_HELPFUL("You feel the internal cushioning of the [src] begin to inflate against your [O.display_name]."))
				if(do_after(H, 15 SECONDS, INTERRUPT_NONE))
					if(loc != H)
						return
					playsound(loc, 'sound/machines/hiss.ogg', 20, TRUE)
					to_chat(H, SPAN_HELPFUL("\The [src] constricts around your [O.display_name], supporting the fracture."))
					supporting_limbs += O.display_name
					O.status |= LIMB_SPLINTED
					O.status |= LIMB_SPLINTED_INDESTRUCTIBLE
	else
	// Otherwise, remove the splints.
		//playsound(loc, 'sound/machines/hiss.ogg', 20, TRUE)
		for(var/obj/limb/O in H.limbs)
			if((O.status & LIMB_SPLINTED) && (O.status & LIMB_BROKEN) && supporting_limbs.Find(O.display_name))
				O.status &= ~LIMB_SPLINTED
				O.status &= ~LIMB_SPLINTED_INDESTRUCTIBLE
		if(supporting_limbs.len)
			to_chat(H, SPAN_DANGER("\The [src] stops supporting your [jointext(supporting_limbs, ", ")]."))
		supporting_limbs.Cut()

/obj/item/clothing/suit/space/emergency
	name = "Emergency SoftSuit™"
	desc = "An off-brand emergency compression suit made from flexible material and tubing apart from the plastic chestplate, which sits a 16x2 LCD monochrome screen you have to crane your neck to see. Is quite fragile, does not offer protection against high heat, high pressure and sharp objects. Lacks equipment clippings."
	icon = 'icons/obj/items/clothing/cm_suits.dmi'
	icon_state = "softsuit_emergency"
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/suit_1.dmi'
	)
	w_class = SIZE_MEDIUM
	gas_transfer_coefficient = 0.05
	permeability_coefficient = 0.04
	slowdown = 2
	breach_vulnerability = SPACESUIT_BREACH_CIVILIAN
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW
	siemens_coefficient = 1.1
	can_support_limbs = FALSE

//folded version of the sadar
/obj/item/prop/folded_emergency_spacesuit
	name = "\improper emergency spacesuit and helmet (folded)"
	desc = "An off-brand emergency spacesuit and helmet, vacuum packed so that they can fit into a backpack. Not a proper substitue for pressure suits like the MK.35, and only protects you from the cold of space. Does not include an oxygen tank."
	icon = 'icons/obj/items/misc.dmi'
	icon_state = "spacesuit_bag"
	w_class = SIZE_MEDIUM

/obj/item/prop/folded_emergency_spacesuit/attack_self(mob/user)
	user.visible_message(SPAN_NOTICE("[user] begins to unfold \the [src]."), SPAN_NOTICE("You start to unfold and expand \the [src]."))
	playsound(src, 'sound/items/component_pickup.ogg', 20, TRUE, 5)

	if(!do_after(user, 4 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		to_chat(user, SPAN_NOTICE("You stop unfolding \the [src]"))
		return

	unfold(user)

	user.visible_message(SPAN_NOTICE("[user] finishes unfolding \the [src]."), SPAN_NOTICE("You finish unfolding \the [src]."))
	playsound(src, 'sound/items/component_pickup.ogg', 20, TRUE, 5)
	. = ..()

/obj/item/prop/folded_emergency_spacesuit/proc/unfold(mob/user)
	var/obj/item/prop/folded_emergency_spacesuit/suit = new /obj/item/clothing/suit/space/emergency(user.loc)
	transfer_label_component(suit)
	qdel(src)
	user.put_in_active_hand(suit)
	var/obj/helmet = new /obj/item/clothing/head/helmet/space(user.loc)
	transfer_label_component(helmet)
	user.put_in_any_hand_if_possible(helmet)
