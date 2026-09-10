/obj/item/tank/jetpack
	name = "Jetpack (Empty)"
	desc = "A tank of compressed gas for use as propulsion in zero-gravity areas. Use with caution."
	icon_state = "jetpack-on"
	w_class = SIZE_LARGE
	item_state = "jetpack"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	var/datum/effect_system/ion_trail_follow/ion_trail
	var/on = 1
	var/stabilization_on = 0
	var/volume_rate = 500   //Needed for borg jetpack transfer
	pressure = 0
	actions_types = list(/datum/action/item_action/jetpack/toggle_stablization)

/datum/action/item_action/jetpack/toggle_stablization/New(Target, obj/item/holder)
	. = ..()
	name = "Toggle Jetpack Stablization"
	action_icon_state = "smartpack_immobile"
	button.alpha = 128
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/mob/hud/actions.dmi', button, action_icon_state)

/datum/action/item_action/jetpack/toggle_stablization/action_activate()
	. = ..()
	var/obj/item/tank/jetpack/jet_pack = holder_item
	jet_pack.toggle_jetpack(usr)

/datum/action/item_action/jetpack/toggle_stablization/proc/update_icon()
	if(!holder_item)
		return
	var/obj/item/tank/jetpack/jet_pack = holder_item
	if(jet_pack.stabilization_on)
		button.icon_state = "template_on"
	else
		button.icon_state = "template"


/obj/item/tank/jetpack/Initialize()
	. = ..()
	src.ion_trail = new /datum/effect_system/ion_trail_follow()
	src.ion_trail.set_up(src)

/obj/item/tank/jetpack/Destroy()
	QDEL_NULL(ion_trail)
	return ..()


/obj/item/tank/jetpack/verb/toggle_rockets()
	set name = "Toggle Jetpack Stabilization"
	set category = "Object"
	set src in usr
	if (ismob(usr))
		toggle_jetpack(FALSE)

/obj/item/tank/jetpack/verb/toggle()
	set name = "Toggle Jetpack"
	set category = "Object"
	set src in usr

	if (ismob(usr))
		toggle_jetpack(TRUE)


/obj/item/tank/jetpack/proc/toggle_jetpack(turn_off_instead_of_stabilization = TRUE)
	if(turn_off_instead_of_stabilization == TRUE)
		on = !on
		if(on)
			icon_state = "[icon_state]-on"

		else
			icon_state = initial(icon_state)
	else
		src.stabilization_on = !(src.stabilization_on)
		to_chat(usr, "You toggle the stabilization [stabilization_on? "on":"off"].")
		var/datum/action/item_action/jetpack/toggle_stablization/TS = locate(/datum/action/item_action/jetpack/toggle_stablization) in actions
		TS.update_icon()


/obj/item/tank/jetpack/proc/allow_thrust(num = STD_BREATH_VOLUME/5, mob/living/user)
	if(!(src.on))
		return 0

	if(pressure > 5)
		remove_air_volume(num)
		return 1
	else
		//ion_trail.stop()
		return 0

/obj/item/tank/jetpack/air
	name = "Jetpack (Air)"
	desc = "A tank of compressed air for use as propulsion in zero-gravity areas. Use with caution. Can be used as an air supply, but requires a distribution pressure of 1 ATM."
	icon_state = "jetpack-white"
	item_state = "jetpack-white"
	gas_type = GAS_TYPE_AIR
	volume = 30
	pressure = ONE_ATMOSPHERE*5

/obj/item/tank/jetpack/oxygen
	name = "Jetpack (Oxygen)"
	desc = "A tank of compressed oxygen for use as propulsion in zero-gravity areas. Use with caution. Can be used as an air supply"
	icon_state = "jetpack"
	item_state = "jetpack"
	gas_type = GAS_TYPE_OXYGEN
	volume = 30
	pressure = ONE_ATMOSPHERE*5

/obj/item/tank/jetpack/carbondioxide
	name = "Jetpack (Carbon Dioxide)"
	desc = "A tank of compressed carbon dioxide for use as propulsion in zero-gravity areas. Painted black to indicate that it should not be used as a source for internals."
	distribute_pressure = 0
	icon_state = "jetpack-black"
	item_state =  "jetpack-black"
	volume = 60
	pressure = ONE_ATMOSPHERE*5
