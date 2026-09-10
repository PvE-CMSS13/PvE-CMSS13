#define TANK_MAX_RELEASE_PRESSURE (3*ONE_ATMOSPHERE)
#define TANK_DEFAULT_RELEASE_PRESSURE 24
#define TANK_MIN_RELEASE_PRESSURE 0

/obj/item/tank
	name = "tank"
	icon = 'icons/obj/items/tank.dmi'
	flags_atom = FPRINT|CONDUCT
	flags_equip_slot = SLOT_BACK
	w_class = SIZE_MEDIUM

	var/pressure_full = ONE_ATMOSPHERE*6

	var/pressure = ONE_ATMOSPHERE*6
	var/gas_type = GAS_TYPE_AIR
	var/temperature = T20C
	var/partially_empty = FALSE

	force = 5
	throwforce = 10
	throw_speed = SPEED_FAST
	throw_range = 4

	var/distribute_pressure = ONE_ATMOSPHERE
	var/integrity = 3
	var/volume = 180
	var/ignore_by_auto_toggle = FALSE
	var/manipulated_by = null //Used by _onclick/hud/screen_objects.dm internals to determine if someone has messed with our tank or not.
	//If they have and we haven't scanned it with the PDA or gas analyzer then we might just breath whatever they put in it.
	pickup_sound = 'sound/effects/metal_drum_pickup.ogg'
	drop_sound = 'sound/effects/metal_drum_drop.ogg'

/obj/item/tank/get_examine_text(mob/user)
	. = ..()
	if(pressure < 100 && loc==user)
		. += SPAN_DANGER("The meter on \the [src] indicates you are almost out of air!")
	var/standard_breath_rate = STD_BREATH_VOLUME // Air taken every cycle
	var/air_removal_rate = initial(distribute_pressure)*standard_breath_rate/(R_IDEAL_GAS_EQUATION*temperature)
	var/moles_in_tank = (pressure_full * src.volume) / (R_IDEAL_GAS_EQUATION * temperature)
	if(gas_type == GAS_TYPE_AIR)
		moles_in_tank = moles_in_tank*O2STANDARD
	var/remaining_cycles = moles_in_tank / air_removal_rate
	var/remaining_minutes = round((remaining_cycles*1.1) * 5 / 60, 0.1) //it runs every two deciseconds i think. Also the 1.1 is to compensate for this always being slightly wrong fnr
	. += SPAN_NOTICE("Assuming it is full, and either oxygen or air mixture, this tank has about [remaining_minutes] minutes of breathable air supply at [(gas_type == GAS_TYPE_OXYGEN) ? "21" : "104"]Kpa.")
	if(in_range(src, user))
		var/celsius_temperature = temperature-T0C
		var/descriptive
		switch(celsius_temperature)
			if(-280 to 0)
				descriptive = "freezing"
			if(0 to 17)
				descriptive = "cold"
			if(17 to 30)
				descriptive = "room temperature"
			if(30 to 50)
				descriptive = "lukewarm"
			if(50 to 80)
				descriptive = "warm"
			if(80 to 150)
				descriptive = "hot"
			else
				descriptive = "furiously hot"

		. += SPAN_NOTICE("\The [src] feels [descriptive]")


/obj/item/tank/attackby(obj/item/W as obj, mob/user as mob)
	..()

	if((istype(W, /obj/item/device/analyzer)) && get_dist(user, src) <= 1)
		for(var/mob/O in viewers(user, null))
			to_chat(O, SPAN_DANGER("[user] has used [W] on [icon2html(src, O)] [src]"))

		manipulated_by = user.real_name //This person is aware of the contents of the tank.

		to_chat(user, SPAN_NOTICE("Results of analysis of [icon2html(src, user)]"))
		if(pressure>0)
			to_chat(user, SPAN_NOTICE("Pressure: [round(pressure,0.1)] kPa"))
			to_chat(user, SPAN_NOTICE("[gas_type]: 100%"))
			to_chat(user, SPAN_NOTICE("Temperature: [floor(temperature-T0C)]&deg;C"))
		else
			to_chat(user, SPAN_NOTICE("Tank is empty!"))
		src.add_fingerprint(user)


/obj/item/tank/attack_self(mob/user)
	. = ..()
	if(ignore_by_auto_toggle)
		return
	tgui_interact(user)

/obj/item/tank/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Tank", name)
		ui.keep_open_if_within_distance = 1
		ui.open()

/obj/item/tank/ui_state(mob/user)
	return GLOB.inventory_state

/obj/item/tank/ui_data(mob/user)
	var/list/data = list()

	data["tankPressure"] = floor(pressure)
	data["tankMaxPressure"] = floor(pressure_full)
	data["ReleasePressure"] = floor(distribute_pressure)
	data["defaultReleasePressure"] = floor(TANK_DEFAULT_RELEASE_PRESSURE)
	data["maxReleasePressure"] = floor(TANK_MAX_RELEASE_PRESSURE)
	data["minReleasePressure"] = floor(TANK_MIN_RELEASE_PRESSURE)

	var/mask_connected = FALSE
	var/using_internal = FALSE

	if(istype(get_atom_on_turf(loc),/mob/living/carbon))
		var/mob/living/carbon/location = get_atom_on_turf(loc)
		if(location.internal == src)
			using_internal = TRUE
		if(location.internal == src || location.check_for_oxygen_mask())
			mask_connected = TRUE

	data["mask_connected"] = mask_connected
	data["valve_open"] = using_internal

	return data

/mob/living/carbon/proc/check_for_oxygen_mask()
	if(wear_mask && (wear_mask.flags_inventory & ALLOWINTERNALS))
		return TRUE
	if(ishuman(src))
		var/mob/living/carbon/human/human_check = src
		if(human_check.head && (human_check.head.flags_inventory & ALLOWINTERNALS))
			return TRUE
	return FALSE

/mob/living/carbon/human/proc/check_for_weather_protection()
	if(wear_suit)
		if(wear_suit && (wear_mask.flags_inventory & PROTECTFROMWEATHER))
			return TRUE
	if(w_uniform)
		if(w_uniform && (w_uniform.flags_inventory & PROTECTFROMWEATHER))
			return TRUE
	return FALSE

/obj/item/tank/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("pressure")
			var/tgui_pressure = params["pressure"]
			if(tgui_pressure == "reset")
				src.distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
			else if(tgui_pressure == "max")
				src.distribute_pressure = TANK_MAX_RELEASE_PRESSURE
			else if(tgui_pressure == "min")
				src.distribute_pressure = TANK_MIN_RELEASE_PRESSURE
			else if(text2num(tgui_pressure) != null)
				src.distribute_pressure = text2num(tgui_pressure)
			src.distribute_pressure = min(max(floor(src.distribute_pressure), 0), TANK_MAX_RELEASE_PRESSURE)
			. = TRUE

		if("valve")
			if(istype(get_atom_on_turf(loc),/mob/living/carbon/human))
				var/mob/living/carbon/human/location = get_atom_on_turf(loc)
				if(location.internal == src)
					location.eva_oxygen_beeping(force_off = TRUE)
					location.internal = null
					if(location != usr)
						location.visible_message(SPAN_NOTICE("[usr] closes [src] release valve on [location]."), SPAN_NOTICE("You close the [src] release valve on [location]."), SPAN_NOTICE("You hear a small valve being opened."), max_distance = 2)
						location.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has had their internals, a [src] closed by [key_name(usr)]</font>")
						usr.attack_log += text("\[[time_stamp()]\] <font color='red'>Has closed [key_name(src)]'s' internals, a [src].</font>")
					else
						to_chat(usr, SPAN_NOTICE("You close the [src] release valve."))
					playsound(src, 'sound/effects/internals_close.ogg', 60, TRUE)
				else
					if(location.check_for_oxygen_mask())
						location.internal = src
						if(location != usr)
							location.visible_message(SPAN_NOTICE("[usr] opens [src] release valve on [location]."), SPAN_NOTICE("You open the [src] release valve on [location]."), SPAN_NOTICE("You hear a small valve being closed."), max_distance = 2)
							location.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has had their internals, a [src], opened by [key_name(usr)]</font>")
							usr.attack_log += text("\[[time_stamp()]\] <font color='red'>Has opened [key_name(src)]'s' internals, a [src].</font>")
						else
							to_chat(usr, SPAN_NOTICE("You close the [src] release valve."))
						playsound(src, 'sound/effects/internals.ogg', 60, TRUE)
					else
						to_chat(usr, SPAN_NOTICE("You need something to connect to \the [src]."))
				. = TRUE

/obj/item/tank/return_air()
	var/proportion_is_oxygen = 0
	if(gas_type == GAS_TYPE_AIR)
		proportion_is_oxygen = 0.21
	else if(gas_type == GAS_TYPE_OXYGEN)
		proportion_is_oxygen = 1
	return list(gas_type, temperature, pressure, proportion_is_oxygen)

/obj/item/tank/proc/take_air()
	var/returned_moles = remove_air_volume()
	var/proportion_is_oxygen = 0
	if(gas_type == GAS_TYPE_AIR)
		proportion_is_oxygen = O2STANDARD
	else if(gas_type == GAS_TYPE_OXYGEN || gas_type == GAS_TYPE_N2O)
		proportion_is_oxygen = TRUE
	return list(gas_type, temperature, returned_moles, proportion_is_oxygen, distribute_pressure)

/obj/item/tank/return_pressure()
	return pressure

/obj/item/tank/return_temperature()
	return temperature

/obj/item/tank/return_gas()
	return gas_type

/obj/item/tank/proc/remove_air_volume(volume_to_return = STD_BREATH_VOLUME)
	if(pressure < distribute_pressure)
		distribute_pressure = pressure

	var/removed = distribute_pressure * volume_to_return / (R_IDEAL_GAS_EQUATION * temperature)

	var/volume_litres = src.volume

	// moles currently in the tank
	var/moles_in_tank = (pressure * volume_litres) / (R_IDEAL_GAS_EQUATION * temperature)

	moles_in_tank -= removed * GLOB.spacesuit_config.oxygen_usage_multiplier

	// Recalculate pressure from new mole count
	pressure = (max(0, moles_in_tank) * R_IDEAL_GAS_EQUATION * temperature) / volume_litres

	// legit moles
	return removed


/obj/item/tank/Initialize(mapload, ...)
	. = ..()
	if(partially_empty)
		pressure = pressure/rand(6, 12)
		name = "dented " + name
