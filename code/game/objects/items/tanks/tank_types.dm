/* Types of tanks!
 * Contains:
 * Oxygen
 * Anesthetic
 * Air
 * Phoron
 * Emergency Oxygen
 */

/*
 * Oxygen
 */
/obj/item/tank/oxygen
	name = "oxygen tank"
	desc = "A tank of oxygen."
	icon_state = "oxygen"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	gas_type = GAS_TYPE_OXYGEN
	w_class = SIZE_LARGE

/obj/item/tank/oxygen/empty
	partially_empty = TRUE



/obj/item/tank/oxygen/yellow
	desc = "A tank of oxygen, this one is yellow."
	icon_state = "oxygen_f"

/obj/item/tank/oxygen/yellow/empty
	partially_empty = TRUE

/obj/item/tank/oxygen/red
	desc = "A tank of oxygen, this one is red."
	icon_state = "oxygen_fr"

/obj/item/tank/oxygen/red/empty
	partially_empty = TRUE


/*
 * Anesthetic
 */
/obj/item/tank/anesthetic
	name = "anesthetic tank"
	desc = "A tank with an N2O/O2 gas mix."
	icon_state = "anesthetic"
	item_state = "anesthetic"
	gas_type = GAS_TYPE_N2O


/*
 * Air
 */
/obj/item/tank/air
	name = "air tank"
	desc = "Mixed anyone?"
	icon_state = "oxygen"
	gas_type = GAS_TYPE_AIR

/obj/item/tank/air/empty
	partially_empty = TRUE

/*
 * Emergency Oxygen
 */
/obj/item/tank/emergency_oxygen
	name = "emergency oxygen tank"
	desc = "Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
	icon_state = "emergency"
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_WAIST
	w_class = SIZE_TINY
	force = 4
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	volume = 25 //Tiny. Real life equivalents only have 21 breaths of oxygen in them. They're EMERGENCY tanks anyway -errorage (dangercon 2011)
	gas_type = GAS_TYPE_OXYGEN
	pressure = 10*ONE_ATMOSPHERE
	pressure_full = 10*ONE_ATMOSPHERE

/obj/item/tank/emergency_oxygen/attack(mob/M as mob, mob/user as mob)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M

	//Address the integrated tank on Spacesuit on the person being targeted
		var/obj/item/clothing/suit/space/pressure/tank_to_replace = H.wear_suit
		if((istype(H.wear_suit, /obj/item/clothing/suit/space/pressure)))
			tank_to_replace.attackby(src, user)
			return

/obj/item/tank/emergency_oxygen/empty
	partially_empty = TRUE

/obj/item/tank/emergency_oxygen/engi
	name = "E-C emergency oxygen tank"
	desc = "An extended-capacity emergency oxygen tank. Used for emergencies. Contains very little oxygen, so try to conserve it until you actually need it."
	icon_state = "emergency_engi"
	w_class = SIZE_SMALL
	volume = 60
	pressure = 10*ONE_ATMOSPHERE
	pressure_full = 10*ONE_ATMOSPHERE

/obj/item/tank/emergency_oxygen/engi/empty
	partially_empty = TRUE

/obj/item/tank/emergency_oxygen/double
	name = "double E-C oxygen tank"
	desc = "Capable of sustaining a short EVA, but should not be solely depended on."
	icon_state = "emergency_double"
	w_class = SIZE_MEDIUM
	volume = 135
	pressure = 10*ONE_ATMOSPHERE
	pressure_full = 10*ONE_ATMOSPHERE

/obj/item/tank/emergency_oxygen/double/empty
	partially_empty = TRUE

/*
 * Nitrogen
 */
/obj/item/tank/nitrogen
	name = "nitrogen tank"
	desc = "A tank of nitrogen."
	icon_state = "oxygen_fr"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	gas_type = GAS_TYPE_NITROGEN

// Phoron, used for generators.
/obj/item/tank/phoron
	name = "phoron tank"
	desc = "A tank of liquid phoron. WARNING: Phumes are extremely dangerous."
	icon_state = "phoron"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	gas_type = GAS_TYPE_PHORON

/obj/item/tank/phoron/update_icon()
	. = ..()

	if(volume <= 0)
		icon_state = "phoron_empty"
	else
		icon_state = "phoron"
