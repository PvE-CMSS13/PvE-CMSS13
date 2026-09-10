/obj/item/clothing/suit/marine/M35
	name = "\improper M35 pyrotechnician armor"
	desc = "A custom set of M35 armor designed for use by USCM Pyrotechnicians. Prototype cooling and heat dissipation systems ensure the wearer is effectively fireproof, but leaves them more susceptible to overpressure waves."
	icon_state = "pyro_armor"
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_LOW
	light_range = 5
	fire_intensity_resistance = BURN_LEVEL_TIER_1
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROT
	valid_accessory_slots = list(ACCESSORY_SLOT_ARMBAND, ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_PONCHO, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PAINT)
	restricted_accessory_slots = list(ACCESSORY_SLOT_ARMBAND, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PAINT)
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	specialty = "M35 pyrotechnician"
	unacidable = TRUE
	var/shields_from_fire = TRUE

/obj/item/clothing/suit/marine/M35/equipped(mob/user, slot)
	if(slot == WEAR_JACKET)
		RegisterSignal(user, COMSIG_LIVING_FLAMER_CROSSED, PROC_REF(flamer_fire_callback))
	..()

/// This proc is solely so that IgniteMob() fails
/obj/item/clothing/suit/marine/M35/proc/fire_shield_is_on(mob/living/user)
	SIGNAL_HANDLER

	if(user.fire_reagent?.fire_penetrating)
		return

	return COMPONENT_CANCEL_IGNITION

/obj/item/clothing/suit/marine/M35/proc/flamer_fire_callback(mob/living/user, datum/reagent/burnystuff)
	SIGNAL_HANDLER

	if(burnystuff.fire_penetrating)
		return

	. = COMPONENT_NO_IGNITE
	if(shields_from_fire)
		. |= COMPONENT_NO_BURN

/obj/item/clothing/suit/marine/M35/dropped(mob/user)
	if (!istype(user))
		return
	UnregisterSignal(user, list(
		COMSIG_LIVING_PREIGNITION,
		COMSIG_LIVING_FLAMER_CROSSED,
		COMSIG_LIVING_FLAMER_FLAMED,
	))
	..()
