#define LOW_MULTIBROADCAST_COOLDOWN 1 MINUTES
#define HIGH_MULTIBROADCAST_COOLDOWN 3 MINUTES

/obj/item/device/radio/headset
	name = "radio headset"
	desc = "An updated, modular intercom that fits over the head. Takes encryption keys."
	icon_state = "generic_headset"
	item_state = "headset"
	matter = list("metal" = 75)
	subspace_transmission = 1
	canhear_range = 0 // can't hear headsets from very far away


	flags_equip_slot = SLOT_EAR
	inherent_traits = list(TRAIT_ITEM_EAR_EXCLUSIVE)
	var/translate_apollo = FALSE
	var/translate_hive = FALSE
	var/maximum_keys = 3
	var/list/initial_keys //Typepaths of objects to be created at initialisation.
	var/list/keys //Actual objects.
	maxf = 1489

	var/list/inbuilt_tracking_options = list(
		"Platoon Commander" = TRACKER_PLTCO,
		"Section Sergeant" = TRACKER_SL,
		"Squad Leader" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ
	)
	var/list/tracking_options = list()

	var/list/volume_settings

	var/last_multi_broadcast = -999
	var/multibroadcast_cooldown = HIGH_MULTIBROADCAST_COOLDOWN


	has_hud = FALSE
	var/headset_hud_on = FALSE
	var/locate_setting = TRACKER_SL
	var/misc_tracking = FALSE
	///Tracker specific vars
	var/has_tracker = FALSE
	///Whether or not the headset will show them on the tac-map
	var/map_tracking = FALSE
	///What HUD it will display if present
	hud_type = MOB_HUD_FACTION_MARINE
	var/minimap_type = MINIMAP_FLAG_USCM
	var/default_freq
	var/mob/living/carbon/human/wearer

/obj/item/device/radio/headset/Initialize()
	. = ..()
	keys = list()
	for (var/key in initial_keys)
		keys += new key(src)
	recalculateChannels()

	if(length(volume_settings))
		verbs += /obj/item/device/radio/headset/proc/set_volume_setting

	if(has_hud)
		headset_hud_on = TRUE
		misc_tracking = TRUE
		verbs += /obj/item/device/radio/headset/proc/toggle_squadhud
		verbs += /obj/item/device/radio/headset/proc/switch_tracker_target

	if(frequency)
		for(var/cycled_channel in GLOB.radiochannels)
			if(GLOB.radiochannels[cycled_channel] == frequency)
				default_freq = cycled_channel

	RegisterSignal(SSdcs, COMSIG_GLOB_PLATOON_NAME_CHANGE, PROC_REF(rename_platoon))

	if(SQUAD_MARINE_1 == default_freq && SQUAD_MARINE_1 != GLOB.main_platoon_name)
		rename_platoon(null, GLOB.main_platoon_name, SQUAD_MARINE_1)

/obj/item/device/radio/headset/proc/rename_platoon(datum/source, new_name, old_name)
	SIGNAL_HANDLER

	set_frequency(frequency)

/obj/item/device/radio/headset/Destroy()
	wearer = null
	QDEL_NULL_LIST(keys)
	return ..()

/obj/item/device/radio/headset/proc/set_volume_setting()
	set name = "Set Headset Volume"
	set category = "Object"
	set src in usr

	var/static/list/text_to_volume = list(
		RADIO_VOLUME_QUIET_STR = RADIO_VOLUME_QUIET,
		RADIO_VOLUME_RAISED_STR = RADIO_VOLUME_RAISED,
		RADIO_VOLUME_IMPORTANT_STR = RADIO_VOLUME_IMPORTANT,
		RADIO_VOLUME_CRITICAL_STR = RADIO_VOLUME_CRITICAL
	)

	var/volume_setting = tgui_input_list(usr, "Select the volume you want your headset to transmit at.", "Headset Volume", volume_settings)
	if(!volume_setting)
		return
	volume = text_to_volume[volume_setting]
	to_chat(usr, SPAN_NOTICE("You set \the [src]'s volume to <b>[volume_setting]</b>."))

/obj/item/device/radio/headset/handle_message_mode(mob/living/M as mob, message, channel)
	if (channel == RADIO_CHANNEL_SPECIAL)
		if (translate_apollo)
			var/datum/language/apollo = GLOB.all_languages[LANGUAGE_APOLLO]
			apollo.broadcast(M, message)
		if (translate_hive)
			var/datum/language/hivemind = GLOB.all_languages[LANGUAGE_HIVEMIND]
			hivemind.broadcast(M, message)
		return null

	if(default_freq && channel == default_freq)
		return radio_connection

	return ..()

/obj/item/device/radio/headset/attack_self(mob/user as mob)
	on = TRUE //Turn it on if it was off
	. = ..()

/obj/item/device/radio/headset/receive_range(freq, level, aiOverride = 0)
	if (aiOverride)
		return ..(freq, level)
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.has_item_in_ears(src))
			return ..(freq, level)
	return -1

/obj/item/device/radio/headset/attack_hand(mob/user as mob)
	if(!ishuman(user) || loc != user)
		return ..()
	var/mob/living/carbon/human/H = user
	if (!H.has_item_in_ears(src))
		return ..()
	user.set_interaction(src)
	tgui_interact(user)

/obj/item/device/radio/headset/examine(mob/user as mob)
	if(ishuman(user) && loc == user)
		tgui_interact(user)
	return ..()

/obj/item/device/radio/headset/MouseDrop(obj/over_object as obj)
	if(!CAN_PICKUP(usr, src))
		return ..()
	if(!istype(over_object, /atom/movable/screen))
		return ..()
	if(loc != usr) //Makes sure that the headset is equipped, so that we can't drag it into our hand from miles away.
		return ..()

	switch(over_object.name)
		if("r_hand")
			if(usr.drop_inv_item_on_ground(src))
				usr.put_in_r_hand(src)
		if("l_hand")
			if(usr.drop_inv_item_on_ground(src))
				usr.put_in_l_hand(src)
	add_fingerprint(usr)

/obj/item/device/radio/headset/attackby(obj/item/W as obj, mob/user as mob)
// ..()
	user.set_interaction(src)
	if ( !(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER) || (istype(W, /obj/item/device/encryptionkey)) ))
		return

	if(HAS_TRAIT(W, TRAIT_TOOL_SCREWDRIVER))
		var/turf/T = get_turf(user)
		if(!T)
			to_chat(user, "You cannot do it here.")
			return
		var/removed_keys = FALSE
		for (var/obj/item/device/encryptionkey/key in keys)
			if(key.abstract)
				continue
			key.forceMove(T)
			keys -= key
			removed_keys = TRUE
		if(removed_keys)
			recalculateChannels()
			to_chat(user, SPAN_NOTICE("You pop out the encryption keys in \the [src]!"))
		else
			to_chat(user, SPAN_NOTICE("This headset doesn't have any encryption keys!  How useless..."))

	if(istype(W, /obj/item/device/encryptionkey/))
		var/keycount = 0
		for (var/obj/item/device/encryptionkey/key in keys)
			if(!key.abstract)
				keycount++
		if(keycount >= maximum_keys)
			to_chat(user, SPAN_WARNING("\The [src] can't hold another key!"))
			return
		if(user.drop_held_item())
			W.forceMove(src)
			keys += W
			to_chat(user, SPAN_NOTICE("You slot \the [W] into \the [src]!"))
			recalculateChannels()

	return


/obj/item/device/radio/headset/proc/recalculateChannels()
	for(var/ch_name in channels)
		SSradio.remove_object(src, GLOB.radiochannels[ch_name])
		secure_radio_connections[ch_name] = null
	channels = list()
	translate_apollo = FALSE
	translate_hive = FALSE

	tracking_options = length(inbuilt_tracking_options) ? inbuilt_tracking_options.Copy() : list()
	for(var/i in keys)
		var/obj/item/device/encryptionkey/key = i
		for(var/ch_name in key.channels)
			if(ch_name in channels)
				continue
			channels += ch_name
			channels[ch_name] = key.channels[ch_name]
		for(var/tracking_option in key.tracking_options)
			tracking_options[tracking_option] = key.tracking_options[tracking_option]
		if(key.translate_apollo)
			translate_apollo = TRUE
		if(key.translate_hive)
			translate_hive = TRUE

	if(length(tracking_options))
		var/list/tracking_stuff = list()
		for(var/tracking_fluff in tracking_options)
			tracking_stuff += tracking_options[tracking_fluff]
		if(!(locate_setting in tracking_stuff))
			locate_setting = tracking_stuff[1]
	else
		locate_setting = initial(locate_setting)

	for (var/ch_name in channels)
		secure_radio_connections[ch_name] = SSradio.add_object(src, GLOB.radiochannels[ch_name],  RADIO_CHAT)
	SStgui.update_uis(src)

/obj/item/device/radio/headset/set_frequency(new_frequency)
	..()
	if(frequency)
		for(var/cycled_channel in GLOB.radiochannels)
			if(GLOB.radiochannels[cycled_channel] == frequency)
				default_freq = cycled_channel

/obj/item/device/radio/headset/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(user.has_item_in_ears(src))
		RegisterSignal(user, list(
			COMSIG_LIVING_REJUVENATED,
			COMSIG_HUMAN_REVIVED,
		), PROC_REF(turn_on_map_tracking))
		wearer = user
		RegisterSignal(user, COMSIG_MOB_STAT_SET_ALIVE, PROC_REF(update_minimap_icon))
		RegisterSignal(user, COMSIG_MOB_LOGGED_IN, PROC_REF(add_hud_tracker))
		RegisterSignal(user, COMSIG_MOB_DEATH, PROC_REF(update_minimap_icon))
		RegisterSignal(user, COMSIG_HUMAN_SET_UNDEFIBBABLE, PROC_REF(update_minimap_icon))
		if(headset_hud_on)
			for(var/type in hud_type)
				var/datum/mob_hud/H = GLOB.huds[type]
				H.add_hud_to(user, src)
			//squad leader locator is no longer invisible on our player HUD.
			if(user.mind && (user.assigned_squad || misc_tracking) && user.hud_used && user.hud_used.locate_leader)
				user.show_hud_tracker()
			if(misc_tracking)
				SStracking.start_misc_tracking(user)
			INVOKE_NEXT_TICK(src, PROC_REF(update_minimap_icon), wearer)

/obj/item/device/radio/headset/dropped(mob/living/carbon/human/user)
	UnregisterSignal(user, list(
		COMSIG_LIVING_REJUVENATED,
		COMSIG_HUMAN_REVIVED,
		COMSIG_MOB_LOGGED_IN,
		COMSIG_MOB_DEATH,
		COMSIG_HUMAN_SET_UNDEFIBBABLE,
		COMSIG_MOB_STAT_SET_ALIVE
	))
	if(istype(user) && user.has_item_in_ears(src)) //dropped() is called before the inventory reference is update.
		for(var/type in hud_type)
			var/datum/mob_hud/H = GLOB.huds[type]
			H.remove_hud_from(user, src)
		//squad leader locator is invisible again
		if(user.hud_used && user.hud_used.locate_leader)
			user.hide_hud_tracker()
		if(misc_tracking)
			SStracking.stop_misc_tracking(user)
		SSminimaps.remove_marker(wearer)
	wearer = null
	..()

/obj/item/device/radio/headset/proc/add_hud_tracker(mob/living/carbon/human/user)
	SIGNAL_HANDLER

	if(headset_hud_on && user.mind && (user.assigned_squad || misc_tracking) && user.hud_used?.locate_leader)
		user.show_hud_tracker()

/obj/item/device/radio/headset/proc/turn_on_map_tracking()
	SIGNAL_HANDLER

/obj/item/device/radio/headset/proc/toggle_hudicons()
	if(!headset_hud_on)
		return
	else
		for(var/type in hud_type)
			var/datum/mob_hud/H = GLOB.huds[type]
			H.add_hud_to(usr, src)

/obj/item/device/radio/headset/proc/toggle_squadhud()
	set name = "Toggle Headset HUD"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return 0
	headset_hud_on = !headset_hud_on
	if(ishuman(usr))
		var/mob/living/carbon/human/user = usr
		if(user.has_item_in_ears(src)) //worn
			for(var/type in hud_type)
				var/datum/mob_hud/H = GLOB.huds[type]
				if(headset_hud_on)
					H.add_hud_to(usr, src)
					if(user.mind && (misc_tracking || user.assigned_squad) && user.hud_used?.locate_leader)
						user.show_hud_tracker()
					if(misc_tracking)
						SStracking.start_misc_tracking(user)
					update_minimap_icon()
				else
					H.remove_hud_from(usr, src)
					if(user.hud_used?.locate_leader)
						user.hide_hud_tracker()
					if(misc_tracking)
						SStracking.stop_misc_tracking(user)
					SSminimaps.remove_marker(wearer)
	to_chat(usr, SPAN_NOTICE("You toggle [src]'s headset HUD [headset_hud_on ? "on":"off"]."))
	playsound(src,'sound/machines/click.ogg', 20, 1)

/obj/item/device/radio/headset/proc/switch_tracker_target()
	set name = "Switch Tracker Target"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return

	handle_switching_tracker_target(usr)

/obj/item/device/radio/headset/proc/handle_switching_tracker_target(mob/living/carbon/human/user)
	var/new_track = tgui_input_list(user, "Choose a new tracking target.", "Tracking Selection", tracking_options)
	if(!new_track)
		return
	to_chat(user, SPAN_NOTICE("You set your headset's tracker to point to <b>[new_track]</b>."))
	locate_setting = tracking_options[new_track]

/obj/item/device/radio/headset/proc/update_minimap_icon()
	SIGNAL_HANDLER
	if(!has_hud)
		return

	if(!wearer)
		return

	SSminimaps.remove_marker(wearer)
	if(!wearer.assigned_equipment_preset || !wearer.assigned_equipment_preset.minimap_icon)
		return
	var/marker_flags = minimap_type
	var/turf/turf_gotten = get_turf(wearer)
	if(!turf_gotten)
		return
	var/z_level = turf_gotten.z

	if(wearer.assigned_equipment_preset.always_minimap_visible == TRUE || wearer.stat == DEAD) //We show to all marines if we have this flag, separated by faction
		if(hud_type == MOB_HUD_FACTION_MARINE)
			marker_flags = MINIMAP_FLAG_USCM
		else if(hud_type == MOB_HUD_FACTION_UPP)
			marker_flags = MINIMAP_FLAG_UPP
		else if(hud_type == MOB_HUD_FACTION_TWE)
			marker_flags = MINIMAP_FLAG_TWE
		else if(hud_type == MOB_HUD_FACTION_PMC)
			marker_flags = MINIMAP_FLAG_PMC
		else if(hud_type == MOB_HUD_FACTION_CLF)
			marker_flags = MINIMAP_FLAG_CLF

	if(wearer.undefibbable)
		set_undefibbable_on_minimap(z_level, marker_flags)
		return

	if(wearer.stat == DEAD)
		set_dead_on_minimap(z_level, marker_flags)
		return

	SSminimaps.add_marker(wearer, z_level, marker_flags, given_image = wearer.assigned_equipment_preset.get_minimap_icon(wearer))

///Change the minimap icon to a dead icon
/obj/item/device/radio/headset/proc/set_dead_on_minimap(z_level, marker_flags)
	SSminimaps.add_marker(wearer, z_level, marker_flags, given_image = wearer.assigned_equipment_preset.get_minimap_icon(wearer), overlay_iconstates = list("defibbable"))

///Change the minimap icon to a undefibbable icon
/obj/item/device/radio/headset/proc/set_undefibbable_on_minimap(z_level, marker_flags)
	SSminimaps.add_marker(wearer, z_level, marker_flags, given_image = wearer.assigned_equipment_preset.get_minimap_icon(wearer), overlay_iconstates = list("undefibbable"))

/obj/item/device/radio/headset/binary
	initial_keys = list(/obj/item/device/encryptionkey/binary)


/obj/item/device/radio/headset/ai_integrated //No need to care about icons, it should be hidden inside the AI anyway.
	name = "AI Subspace Transceiver"
	desc = "Integrated AI radio transceiver."
	icon = 'icons/obj/items/robot_component.dmi'
	icon_state = "radio"
	item_state = "headset"
	initial_keys = list(/obj/item/device/encryptionkey/ai_integrated)
	var/myAi = null // Atlantis: Reference back to the AI which has this radio.
	var/disabledAi = 0 // Atlantis: Used to manually disable AI's integrated radio via intellicard menu.

/obj/item/device/radio/headset/ai_integrated/receive_range(freq, level)
	if (disabledAi)
		return -1 //Transceiver Disabled.
	return ..(freq, level, 1)

//MARINE HEADSETS

/obj/item/device/radio/headset/almayer
	name = "marine radio headset"
	desc = "A standard military radio headset. Bulkier than combat models."
	icon_state = "generic_headset"
	item_state = "headset"
	frequency = PUB_FREQ
	has_hud = TRUE
	map_tracking = TRUE
	hud_type = list(MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_NAVY)

/obj/item/device/radio/headset/almayer/equipped(mob/living/carbon/human/user, slot)
	. = ..()

	if((user == user.assigned_squad?.fireteam_leaders["SQ1"] || user == user.assigned_squad?.fireteam_leaders["SQ2"]) && ("Section Sergeant" in tracking_options))
		locate_setting = tracking_options["Section Sergeant"]
		return

	if(((user in user.assigned_squad?.fireteams["SQ1"]) || (user in user.assigned_squad?.fireteams["SQ2"])) && ("Squad Leader" in tracking_options))
		locate_setting = tracking_options["Squad Leader"]
		return

/obj/item/device/radio/headset/almayer/verb/give_medal_recommendation()
	set name = "Give Medal Recommendation"
	set desc = "Send a medal recommendation for approval by the Commanding Officer"
	set category = "Object.Medals"
	set src in usr

	var/mob/living/carbon/human/wearer = usr
	if(!istype(wearer))
		return
	var/obj/item/card/id/id_card = wearer.get_idcard()
	if(!id_card)
		return

	var/datum/paygrade/paygrade_actual = GLOB.paygrades[id_card.paygrade]
	if(!paygrade_actual)
		return
	if(!istype(paygrade_actual, /datum/paygrade/marine)) //We only want marines to be able to recommend for medals
		return
	if(paygrade_actual.ranking < 3) //E1 starts at 0, so anyone above Corporal (ranking = 3) can recommend for medals
		to_chat(wearer, SPAN_WARNING("Only officers or NCO's (ME4+) can recommend medals!"))
		return
	if(add_medal_recommendation(usr))
		to_chat(usr, SPAN_NOTICE("Recommendation successfully submitted."))

/obj/item/device/radio/headset/almayer/ce
	name = "chief engineer's headset"
	desc = "The headset of the guy in charge of spooling engines, managing MTs, and tearing up the floor for scrap metal. Of robust and sturdy construction. Channels are as follows: :n - engineering, :v - marine command, :m - medical, :u - requisitions, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad."
	icon_state = "ce_headset"
	initial_keys = list(/obj/item/device/encryptionkey/ce)
	volume = RADIO_VOLUME_CRITICAL
	multibroadcast_cooldown = LOW_MULTIBROADCAST_COOLDOWN

/obj/item/device/radio/headset/almayer/cmo
	name = "chief medical officer's headset"
	desc = "A headset issued to the top brass of medical professionals. Channels are as follows: :m - medical, :v - marine command."
	icon_state = "cmo_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmo)
	volume = RADIO_VOLUME_CRITICAL
	multibroadcast_cooldown = LOW_MULTIBROADCAST_COOLDOWN

/obj/item/device/radio/headset/almayer/mt
	name = "engineering radio headset"
	desc = "Useful for coordinating maintenance bars and orbital bombardments. Of robust and sturdy construction. To access the engineering channel, use :n."
	icon_state = "eng_headset"
	initial_keys = list(/obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/chef
	name = "kitchen radio headset"
	desc = "Used by the onboard kitchen staff, filled with background noise of sizzling pots. Can coordinate with the supply channel, using :u and inform command of delivery service using :v."
	icon_state = "req_headset"
	initial_keys = list(/obj/item/device/encryptionkey/req/mst)

/obj/item/device/radio/headset/almayer/doc
	name = "medical radio headset"
	desc = "A headset used by the highly trained staff of the medbay. To access the medical channel, use :m."
	icon_state = "med_headset"
	initial_keys = list(/obj/item/device/encryptionkey/med)

/obj/item/device/radio/headset/almayer/research
	name = "researcher radio headset"
	desc = "A headset used by medbay's skilled researchers. Channels are as follows: :m - medical, :t - intel."
	icon_state = "med_headset"
	initial_keys = list(/obj/item/device/encryptionkey/medres)

/obj/item/device/radio/headset/almayer/ct
	name = "supply radio headset"
	desc = "Used by the lowly Cargo Technicians of the USCM, light weight and portable. To access the supply channel, use :u."
	icon_state = "req_headset"
	initial_keys = list(/obj/item/device/encryptionkey/req/ct)

/obj/item/device/radio/headset/almayer/qm
	desc = "A headset used by the quartermaster for controlling their slave(s). Channels are as follows: :u - requisitions, :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad."
	name = "requisition officer radio headset"
	icon_state = "ro_headset"
	initial_keys = list(/obj/item/device/encryptionkey/qm)
	volume = RADIO_VOLUME_CRITICAL
	multibroadcast_cooldown = LOW_MULTIBROADCAST_COOLDOWN

/obj/item/device/radio/headset/almayer/mmpo
	name = "marine military police radio headset"
	desc = "This is used by marine military police members. Channels are as follows: :p - military police, :v - marine command. :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad."
	icon_state = "sec_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mmpo)

/obj/item/device/radio/headset/almayer/marine/mp_honor
	name = "marine honor guard radio headset"
	desc = "This is used by members of the marine honor guard. Channels are as follows: :p - military police, :v - marine command. :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad."
	icon_override = 'icons/obj/items/radio.dmi'
	icon_state = "sec_headset"
	item_icons = list(
		WEAR_L_EAR = 'icons/mob/humans/onmob/ears.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/ears.dmi',
		)
	initial_keys = list(/obj/item/device/encryptionkey/mmpo)
	volume = RADIO_VOLUME_RAISED
	locate_setting = TRACKER_CO
	has_tracker = TRUE
	misc_tracking = TRUE

	inbuilt_tracking_options = list(
		"Commanding Officer" = TRACKER_CO,
		"Executive Officer" = TRACKER_XO
	)

/obj/item/device/radio/headset/almayer/cmpcom
	name = "marine chief MP radio headset"
	desc = "For discussing the purchase of donuts and arresting of hooligans. Channels are as follows: :v - marine command, :p - military police, :n - engineering, :m - medbay, :u - requisitions, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad."
	icon_state = "sec_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/mcom
	name = "marine command radio headset"
	desc = "Used by CIC staff and higher-ups, features a non-standard brace. Channels are as follows: :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel."
	icon_state = "mcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mcom)
	volume = RADIO_VOLUME_CRITICAL
	multibroadcast_cooldown = LOW_MULTIBROADCAST_COOLDOWN
	frequency = ALPHA_FREQ

/obj/item/device/radio/headset/almayer/mcom/alt
	initial_keys = list(/obj/item/device/encryptionkey/mcom/alt)

/obj/item/device/radio/headset/almayer/marine/mp_honor/com
	name = "marine honor guard command radio headset"
	desc = "Given to highly trusted marine honor guard only. It features a non-standard brace. Channels are as follows: :v - marine command, :p - military police, :n - engineering, :m - medbay, :u - requisitions, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad."
	icon_state = "mcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom)

/obj/item/device/radio/headset/almayer/po
	name = "marine pilot radio headset"
	desc = "Used by Pilot Officers. Channels are as follows: :v - marine command, :n - engineering, :m - medical, :j - JTAC, :t - intel."
	initial_keys = list(/obj/item/device/encryptionkey/po)
	volume = RADIO_VOLUME_CRITICAL
	multibroadcast_cooldown = LOW_MULTIBROADCAST_COOLDOWN

/obj/item/device/radio/headset/almayer/intel
	name = "marine intel radio headset"
	desc = "Used by Intelligence Officers. Channels are as follows: :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medical, :j - JTAC, :t - intel."
	initial_keys = list(/obj/item/device/encryptionkey/io)
	frequency = INTEL_FREQ

/obj/item/device/radio/headset/almayer/mcl
	name = "corporate liaison radio headset"
	desc = "Used by the CL to convince people to sign NDAs. Channels are as follows: :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel, :y for WY."
	icon_state = "wy_headset"
	maximum_keys = 5
	initial_keys = list(/obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/almayer/reporter
	name = "reporter radio headset"
	desc = "Used by the combat correspondent to get the scoop. Channels are as follows: :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel."
	initial_keys = list(/obj/item/device/encryptionkey/mcom)

/obj/item/device/radio/headset/almayer/rep
	name = "representative radio headset"
	desc = "This headset was the worst invention made, constant chatter comes from it."
	icon_state = "wy_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mcom/rep)

/obj/item/device/radio/headset/almayer/mcom/cdrcom
	name = "marine senior command headset"
	desc = "Issued only to senior command staff. Channels are as follows: :v - marine command, :p - military police, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC,  :t - intel"
	icon_state = "mco_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/cdrcom)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/mcom/sea
	name = "marine senior enlisted advisor headset"
	desc = "Issued only to senior enlisted advisors. Channels are as follows: :v - marine command, :p - military police, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC,  :t - intel"
	icon_state = "mco_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/cdrcom)
	volume = RADIO_VOLUME_CRITICAL
	has_tracker = TRUE
	misc_tracking = TRUE
	locate_setting = TRACKER_CO

	inbuilt_tracking_options = list(
		"Commanding Officer" = TRACKER_CO,
		"Executive Officer" = TRACKER_XO,
		"Chief MP" = TRACKER_CMP
	)

/obj/item/device/radio/headset/almayer/mcom/synth
	name = "marine synth headset"
	desc = "Issued only to USCM synthetics. Channels are as follows: :v - marine command, :p - military police, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC,  :t - intel"
	icon_state = "ms_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/synth)
	volume = RADIO_VOLUME_CRITICAL
	has_tracker = TRUE
	misc_tracking = TRUE
	has_hud = TRUE
	locate_setting = TRACKER_ASL

	inbuilt_tracking_options = list(
		"Platoon Commander" = TRACKER_PLTCO,
		"A-Section Sergeant" = TRACKER_ASL,
		"B-Section Sergeant" = TRACKER_BSL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/almayer/mcom/ai
	initial_keys = list(/obj/item/device/encryptionkey/mcom/ai)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine
	name = "marine radio headset"
	desc = "A standard marine radio headset. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "generic_headset"
	item_state = "headset"
	frequency = ALPHA_FREQ

//############################## VISIBLE HEADSETS ###############################
/obj/item/device/radio/headset/almayer/marine/solardevils
	name = "marine radio headset"
	desc = "A standard marine radio headset. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "uscm_headset"
	item_state = "uscm_headset"
	item_icons = list(
		WEAR_L_EAR = 'icons/mob/humans/onmob/ears.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/ears.dmi',
		)
	frequency = ALPHA_FREQ
	has_tracker = TRUE
	misc_tracking = TRUE
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY)

/obj/item/device/radio/headset/almayer/marine/solardevils/seclead
	initial_keys = list(/obj/item/device/encryptionkey/squadlead)

/obj/item/device/radio/headset/almayer/marine/solardevils/pltco
	initial_keys = list(/obj/item/device/encryptionkey/bravo, /obj/item/device/encryptionkey/squadlead)

/obj/item/device/radio/headset/almayer/marine/solardevils/forecon
	name = "USCM SOF headset"
	desc = "Issued exclusively to Marine Raiders and members of the USCM's Force Reconnaissance."
	frequency = SOF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/soc/forecon)
	volume = RADIO_VOLUME_QUIET

/obj/item/device/radio/headset/almayer/marine/solardevils/forecon/synth
	name = "USCM reconnaissance synth headset"
	desc = "Issued only to USCM synthetics attached to FORECON & MARSOC units."
	initial_keys = list(/obj/item/device/encryptionkey/po)
	volume = RADIO_VOLUME_CRITICAL
	has_tracker = TRUE
	misc_tracking = TRUE
	locate_setting = TRACKER_ASL

	inbuilt_tracking_options = list(
		"Squad Leader" = TRACKER_ASL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/almayer/marine/solardevils/rmc
	name = "Royal Marine Commando headset"
	desc = "A special headset used by the TWE's elite Royal Marine Commandos."
	icon_state = "rmc_headset"
	item_state = "rmc_headset"
	minimap_type = MINIMAP_FLAG_TWE
	frequency = RMC_FREQ
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)
	inbuilt_tracking_options = list(
		"Troop Commander" = TRACKER_PLTCO,
		"Section/Team Leader" = TRACKER_FTL,
	)
	locate_setting = TRACKER_PLTCO

/obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot
	frequency = CRYO_FREQ

/obj/item/device/radio/headset/almayer/marine/solardevils/upp
	name = "UPP Naval Infantry headset"
	desc = "A special headset used by UPP military."
	icon_state = "upp_headset"
	item_state = "upp_headset"
	frequency = UPP_FREQ
	minimap_type = MINIMAP_FLAG_UPP
	hud_type = list(MOB_HUD_FACTION_UPP)

/obj/item/device/radio/headset/almayer/marine/solardevils/upp/synth
	name = "UPP synth headset"
	desc = "A special headset used by various synthetics of the UPP military."
	volume = RADIO_VOLUME_IMPORTANT
	has_tracker = TRUE
	misc_tracking = TRUE
	locate_setting = TRACKER_ASL

	inbuilt_tracking_options = list(
		"Platoon Commander" = TRACKER_PLTCO,
		"Platoon Sergeant" = TRACKER_ASL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/almayer/marine/solardevils/upp/territorial
	name = "UPP Territorial Guard headset"
	desc = "A special headset used by the UPP's Territorial Guard. Lacks access to Naval Infantry channels. Also provides local colony comms. To access the colony channel use :o."
	frequency = UPP_GRD_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/almayer/marine/solardevils/upp/medic
	name = "UPP-MED headset"
	desc = "A special headset used by UPP military. Channels are as follows: #m - medical."
	frequency = UPP_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/upp/medic)

/obj/item/device/radio/headset/almayer/marine/solardevils/upp/command
	name = "UPP-CMD headset"
	desc = "A special headset used by UPP military. Channels are as follows: :o - colony, #j - combat controller, #n - engineering, #m - medical, #v - command, #u - UPP general."
	initial_keys = list(/obj/item/device/encryptionkey/upp/command)

/obj/item/device/radio/headset/almayer/marine/solardevils/canc
	name = "CANC headset"
	desc = "A special headset used by CANC military."
	icon_state = "upp_headset"
	item_state = "upp_headset"
	frequency = CLF_FREQ
	has_hud = FALSE //Until we get CANC stuff, this'll do

/obj/item/device/radio/headset/almayer/cia
	name = "radio headset"
	desc = "A radio headset."
	frequency = CIA_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/cia, /obj/item/device/encryptionkey/soc, /obj/item/device/encryptionkey/listening_bug/freq_a)


//############################## ALPHA ###############################
/obj/item/device/radio/headset/almayer/marine/alpha
	name = "marine alpha radio headset"
	desc = "This is used by Alpha squad members. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "alpha_headset"
	frequency = ALPHA_FREQ //default frequency is alpha squad channel, not PUB_FREQ

/obj/item/device/radio/headset/almayer/marine/alpha/lead
	name = "marine alpha leader radio headset"
	desc = "This is used by the marine Alpha squad leader. Channels are as follows: :v - marine command, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/squadlead)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine/alpha/tl
	name = "marine alpha team leader radio headset"
	desc = "This is used by the marine Alpha team leader. Channels are as follows: :u - requisitions, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/alpha/engi
	name = "marine alpha engineer radio headset"
	desc = "This is used by the marine Alpha combat engineers. To access the engineering channel, use :n. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/alpha/med
	name = "marine alpha corpsman radio headset"
	desc = "This is used by the marine Alpha combat medics. To access the medical channel, use :m. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/med)

//############################## BRAVO ###############################
/obj/item/device/radio/headset/almayer/marine/bravo
	name = "marine bravo radio headset"
	desc = "This is used by Bravo squad members. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "bravo_headset"
	frequency = BRAVO_FREQ

/obj/item/device/radio/headset/almayer/marine/bravo/lead
	name = "marine bravo leader radio headset"
	desc = "This is used by the marine Bravo squad leader. Channels are as follows: :v - marine command, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/squadlead)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine/bravo/tl
	name = "marine bravo team leader radio headset"
	desc = "This is used by the marine Bravo team leader. Channels are as follows: :u - requisitions, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/bravo/engi
	name = "marine bravo engineer radio headset"
	desc = "This is used by the marine Bravo combat engineers. To access the engineering channel, use :n. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/bravo/med
	name = "marine bravo corpsman radio headset"
	desc = "This is used by the marine Bravo combat medics. To access the medical channel, use :m. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/med)

//############################## CHARLIE ###############################
/obj/item/device/radio/headset/almayer/marine/charlie
	name = "marine charlie radio headset"
	desc = "This is used by Charlie squad members. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "charlie_headset"
	frequency = CHARLIE_FREQ

/obj/item/device/radio/headset/almayer/marine/charlie/lead
	name = "marine charlie leader radio headset"
	desc = "This is used by the marine Charlie squad leader. Channels are as follows: :v - marine command, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/squadlead)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine/charlie/tl
	name = "marine charlie team leader radio headset"
	desc = "This is used by the marine Charlie team leader. Channels are as follows: :u - requisitions, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/charlie/engi
	name = "marine charlie engineer radio headset"
	desc = "This is used by the marine Charlie combat engineers. To access the engineering channel, use :n. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/charlie/med
	name = "marine charlie corpsman radio headset"
	desc = "This is used by the marine Charlie combat medics. To access the medical channel, use :m. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/med)

//############################## DELTA ###############################
/obj/item/device/radio/headset/almayer/marine/delta
	name = "marine delta radio headset"
	desc = "This is used by Delta squad members. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "delta_headset"
	frequency = DELTA_FREQ

/obj/item/device/radio/headset/almayer/marine/delta/lead
	name = "marine delta leader radio headset"
	desc = "This is used by the marine Delta squad leader. Channels are as follows: :v - marine command, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/squadlead)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine/delta/tl
	name = "marine delta team leader radio headset"
	desc = "This is used by the marine Delta team leader. Channels are as follows: :u - requisitions, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/delta/engi
	name = "marine delta engineer radio headset"
	desc = "This is used by the marine Delta combat engineers. To access the engineering channel, use :n. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/delta/med
	name = "marine delta corpsman radio headset"
	desc = "This is used by the marine Delta combat medics. To access the medical channel, use :m. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/med)

//############################## ECHO ###############################
/obj/item/device/radio/headset/almayer/marine/echo
	name = "marine echo radio headset"
	desc = "This is used by Echo squad members. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "echo_headset"
	frequency = ECHO_FREQ

/obj/item/device/radio/headset/almayer/marine/echo/lead
	name = "marine echo leader radio headset"
	desc = "This is used by the marine Echo squad leader. Channels are as follows: :v - marine command, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/squadlead)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine/echo/tl
	name = "marine echo team leader radio headset"
	desc = "This is used by the marine Echo team leader. Channels are as follows: :u - requisitions, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/echo/engi
	name = "marine echo engineer radio headset"
	desc = "This is used by the marine Echo combat engineers. To access the engineering channel, use :n. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/echo/med
	name = "marine echo corpsman radio headset"
	desc = "This is used by the marine Echo combat medics. To access the medical channel, use :m. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/med)


//############################## CRYO ###############################
/obj/item/device/radio/headset/almayer/marine/cryo
	name = "marine foxtrot radio headset"
	desc = "This is used by Foxtrot squad members. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "cryo_headset"
	frequency = CRYO_FREQ

/obj/item/device/radio/headset/almayer/marine/cryo/lead
	name = "marine foxtrot leader radio headset"
	desc = "This is used by the marine Foxtrot squad leader. Channels are as follows: :v - marine command, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/squadlead)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/marine/cryo/tl
	name = "marine foxtrot team leader radio headset"
	desc = "This is used by the marine Foxtrot team leader. Channels are as follows: :u - requisitions, :j - JTAC. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/jtac)
	volume = RADIO_VOLUME_RAISED

/obj/item/device/radio/headset/almayer/marine/cryo/engi
	name = "marine foxtrot engineer radio headset"
	desc = "This is used by the marine Foxtrot combat engineers. To access the engineering channel, use :n. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/engi)

/obj/item/device/radio/headset/almayer/marine/cryo/med
	name = "marine foxtrot corpsman radio headset"
	desc = "This is used by the marine Foxtrot combat medics. To access the medical channel, use :m. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/med)

/obj/item/device/radio/headset/almayer/marine/mortar
	name = "mortar crew radio headset"
	desc = "This is used by the dust raider's bunker mortar crew to get feedback on how good the hits of that 80mm rain turned out. Comes with access to the engineering channel with :e, JTAC for coordinating with :j, Intel with :t, and request more shells supply with :u - this ain't Winchester Outpost!"
	icon_state = "ce_headset"
	initial_keys = list(/obj/item/device/encryptionkey/mortar)
	volume = RADIO_VOLUME_RAISED

//*************************************
//-----SELF SETTING MARINE HEADSET-----
//*************************************/
//For events. Currently used for WO only. After equipping it, self_set() will adapt headset to marine.

/obj/item/device/radio/headset/almayer/marine/self_setting/proc/self_set()
	var/mob/living/carbon/human/H = loc
	if(istype(H, /mob/living/carbon/human))
		if(H.assigned_squad)
			switch(H.assigned_squad.name)
				if(SQUAD_MARINE_2)
					name = "[SQUAD_MARINE_2] radio headset"
					desc = "This is used by [SQUAD_MARINE_2] squad members."
					icon_state = "bravo_headset"
					frequency = BRAVO_FREQ
				if(SQUAD_MARINE_3)
					name = "[SQUAD_MARINE_3] radio headset"
					desc = "This is used by [SQUAD_MARINE_3] squad members."
					icon_state = "charlie_headset"
					frequency = CHARLIE_FREQ
				if(SQUAD_MARINE_4)
					name = "[SQUAD_MARINE_4] radio headset"
					desc = "This is used by [SQUAD_MARINE_4] squad members."
					icon_state = "delta_headset"
					frequency = DELTA_FREQ
				if(SQUAD_MARINE_5)
					name = "[SQUAD_MARINE_5] radio headset"
					desc = "This is used by [SQUAD_MARINE_5] squad members."
					frequency = ECHO_FREQ
				if(SQUAD_MARINE_CRYO)
					name = "[SQUAD_MARINE_CRYO] radio headset"
					desc = "This is used by [SQUAD_MARINE_CRYO] squad members."
					frequency = CRYO_FREQ

			if(H.assigned_squad.name == GLOB.main_platoon_name)
				name = "[GLOB.main_platoon_name] radio headset"
				desc = "This is used by [GLOB.main_platoon_name] squad members."
				icon_state = "alpha_headset"
				frequency = ALPHA_FREQ

			switch(GET_DEFAULT_ROLE(H.job))
				if(JOB_SQUAD_LEADER)
					name = "marine leader " + name
					keys += new /obj/item/device/encryptionkey/squadlead(src)
					volume = RADIO_VOLUME_CRITICAL
				if(JOB_SQUAD_MEDIC)
					name = "marine hospital corpsman " + name
					keys += new /obj/item/device/encryptionkey/med(src)
				if(JOB_SQUAD_ENGI)
					name = "marine combat technician " + name
					keys += new /obj/item/device/encryptionkey/engi(src)
				if(JOB_SQUAD_TEAM_LEADER)
					name = "marine fireteam leader " + name
					keys += new /obj/item/device/encryptionkey/jtac(src)
				else
					name = "marine " + name

			set_frequency(frequency)
			for(var/ch_name in channels)
				secure_radio_connections[ch_name] = SSradio.add_object(src, GLOB.radiochannels[ch_name],  RADIO_CHAT)
			recalculateChannels()
			if(H.mind && H.hud_used && H.hud_used.locate_leader) //make SL tracker visible
				H.hud_used.locate_leader.alpha = 255
				H.hud_used.locate_leader.mouse_opacity = MOUSE_OPACITY_ICON

//Distress (ERT) headsets.

/obj/item/device/radio/headset/distress
	name = "colony headset"
	desc = "A standard headset used by colonists."
	frequency = COLONY_FREQ

/obj/item/device/radio/headset/distress/WY
	name = "WY corporate headset"
	desc = "A headset commonly worn by WY corporate personnel."
	frequency = WY_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY)

/obj/item/device/radio/headset/distress/dutch
	name = "Dutch's Dozen headset"
	desc = "A special headset used by small groups of trained operatives. Or terrorists. To access the colony channel, use :h."
	frequency = DUT_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	ignore_z = TRUE

/obj/item/device/radio/headset/distress/pmc
	name = "PMC headset"
	desc = "A special headset used by corporate personnel. Channels are as follows: :g - public, :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel, :y - Corporate."
	frequency = PMC_FREQ
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/mcom/cl)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_PMC, MOB_HUD_FACTION_WY, MOB_HUD_FACTION_TWE)

	misc_tracking = TRUE
	locate_setting = TRACKER_CL
	inbuilt_tracking_options = list(
		"Corporate Liaison" = TRACKER_CL
	)

/obj/item/device/radio/headset/distress/pmc/commando
	name = "W-Y commando headset"
	desc = "A special headset used by unidentified operatives. Channels are as follows: :g - public, :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel, :y - Corporate."
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/mcom/cl, /obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc)
	maximum_keys = 5

/obj/item/device/radio/headset/distress/pmc/commando/leader
	name = "W-Y commando leader headset"
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/mcom/cl, /obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc/command)

/obj/item/device/radio/headset/distress/pmc/platoon
	desc = "A special headset used by corporate PMCs.  Channels are as follows: #p - general, #y - WY."
	initial_keys = list(/obj/item/device/encryptionkey/pmc)
	locate_setting = TRACKER_SL
	inbuilt_tracking_options = list(
		"Overwatch" = TRACKER_PLTCO,
		"Operation Leader" = TRACKER_SL,
		"Team Leader" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/distress/pmc/platoon/synth
	name = "PMC synth headset"
	desc = "A headset & HUD unit issued to corporate support synthetics. Channels are as follows: #p - general, #y - WY,  #z - command, #f - medical, #e - engineering, #o - JTAC."
	initial_keys = list(/obj/item/device/encryptionkey/pmc/command)
	volume = RADIO_VOLUME_IMPORTANT
	has_tracker = TRUE
	misc_tracking = TRUE
	locate_setting = TRACKER_ASL

	inbuilt_tracking_options = list(
		"Overwatch" = TRACKER_PLTCO,
		"Operation Leader" = TRACKER_ASL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/distress/pmc/platoon/cmd
	name = "overwatch headset"
	desc = "A special headset & HUD unit used to PMC Overwatch.  Channels are as follows: #p - general, #y - WY,  #z - command, #f - medical, #e - engineering, #o - JTAC."
	initial_keys = list(/obj/item/device/encryptionkey/pmc/command)

/obj/item/device/radio/headset/distress/cbrn
	name = "\improper CBRN headset"
	desc = "A headset given to CBRN marines. Channels are as follows: :g - public, :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel"
	frequency = CBRN_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/mcom)
	ignore_z = TRUE
	has_hud = TRUE

/obj/item/device/radio/headset/distress/forecon
	name = "\improper Force Recon headset"
	desc = "A headset given to FORECON marines. Channels are as follows: :g - public, :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel"
	frequency = FORECON_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/mcom)
	ignore_z = TRUE
	has_hud = TRUE

/obj/item/device/radio/headset/distress/wy_android
	name = "W-Y android headset"
	desc = "A special headset used by unidentified androids. Channels are as follows: :o - colony :y - Corporate #pmc - PMC"
	frequency = WY_WO_FREQ
	icon_state = "ms_headset"
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/pmc/command)
	has_hud = TRUE

/obj/item/device/radio/headset/distress/pmc/hvh
	desc = "A special headset used by corporate personnel. Channels are as follows: :o - colony."
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/WY)
	misc_tracking = FALSE

/obj/item/device/radio/headset/distress/pmc/cct
	name = "PMC-CCT headset"
	desc = "A special headset used by corporate personnel. Channels are as follows: :o - colony, #e - engineering, #o - JTAC, #p - general"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/engi, /obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/distress/pmc/cct/hvh
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/engi)

/obj/item/device/radio/headset/distress/pmc/medic
	name = "PMC-MED headset"
	desc = "A special headset used by corporate personnel. Channels are as follows: :o - colony, #f - medical, #p - general"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/medic, /obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/distress/pmc/medic/hvh
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/medic)

/obj/item/device/radio/headset/distress/pmc/command
	name = "PMC-CMD headset"
	desc = "A special headset used by corporate personnel. Channels are as follows: :o - colony, #z - command, #f - medical, #e - engineering, #o - JTAC, #p - general"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command, /obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/distress/pmc/command/hvh
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command)

/obj/item/device/radio/headset/distress/pmc/command/director
	name = "WY director headset"
	desc = "A special headset used by corporate directors. Channels are as follows: :o - colony, #z - command, #f - medical, #e - engineering, #o - JTAC, #p - general"
	maximum_keys = 4
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command, /obj/item/device/encryptionkey/commando, /obj/item/device/encryptionkey/mcom/cl)

/obj/item/device/radio/headset/distress/pmc/command/director/hvh
	maximum_keys = 3
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/pmc/command, /obj/item/device/encryptionkey/commando)

//UPP Headsets
/obj/item/device/radio/headset/distress/UPP
	name = "UPP Naval Infantry headset"
	desc = "A special headset used by UPP military."
	frequency = UPP_FREQ
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_UPP)
	minimap_type = MINIMAP_FLAG_UPP

/obj/item/device/radio/headset/distress/UPP/territorial
	name = "UPP Territorial Guard headset"
	desc = "A special headset used by the UPP's Territorial Guard. Lacks access to Naval Infantry channels. Also provides local colony comms. To access the colony channel use :o."
	frequency = UPP_GRD_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/UPP/cct
	name = "UPP-CCT headset"
	desc = "A special headset used by UPP military. Channels are as follows: :o - colony, #j - combat controller, #n engineering."
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/engi)

/obj/item/device/radio/headset/distress/UPP/medic
	name = "UPP-MED headset"
	desc = "A special headset used by UPP military. Channels are as follows: :o - colony, #m - medical."
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/medic)

/obj/item/device/radio/headset/distress/UPP/command
	name = "UPP-CMD headset"
	desc = "A special headset used by UPP military. Channels are as follows: :o - colony, #j - combat controller, #n - engineering, #m - medical, #v - command, #u - UPP general."
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/command)

/obj/item/device/radio/headset/distress/UPP/kdo
	name = "UPP-Kdo headset"
	desc = "A specialist headset used by UPP kommandos. Channels are as follows: #j - combat controller, #u - UPP general, #T - kommandos."
	initial_keys = /obj/item/device/encryptionkey/upp/kdo

/obj/item/device/radio/headset/distress/UPP/kdo/medic
	name = "UPP-KdoM headset"
	desc = "A specialist headset used by UPP kommandos. Channels are as follows: :o - colony, #j - combat controller, #m - medical #u - UPP general, #T - kommandos."
	initial_keys = list(/obj/item/device/encryptionkey/upp/kdo, /obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/UPP/kdo/command
	name = "UPP-KdoC headset"
	desc = "A specialist headset used by UPP kommandos. Channels are as follows: :o - colony, #j - combat controller, #n - engineering, #m - medical, #v - command, #u - UPP general, #T - kommandos."
	initial_keys = list(/obj/item/device/encryptionkey/upp/kdo, /obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/upp/command)

//CLF Headsets
/obj/item/device/radio/headset/distress/CLF
	name = "colony headset"
	desc = "A standard headset used by colonists, but this one has been tampered with. To access the colony channel use :o."
	frequency = CLF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_CLF)

/obj/item/device/radio/headset/distress/CLF/cct
	name = "CLF-CCT headset"
	desc = "A special headset used by small groups of trained operatives. Or terrorists. Channels are as follows: :o - colony, #b - engineering"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/clf/engi)

/obj/item/device/radio/headset/distress/CLF/medic
	name = "CLF-MED headset"
	desc = "A special headset used by small groups of trained operatives. Or terrorists. Channels are as follows: :o - colony, #a - medical"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/clf/medic)

/obj/item/device/radio/headset/distress/CLF/command
	desc = "A special headset used by small groups of trained operatives. Or terrorists. Channels are as follows: :o - colony, #a - medical, #b - engineering, #c - command, #d - combat controller, #g clf general"
	initial_keys = list(/obj/item/device/encryptionkey/colony, /obj/item/device/encryptionkey/clf/command)

//WY Headsets
/obj/item/device/radio/headset/distress/commando
	name = "Commando headset"
	desc = "A special headset used by unidentified operatives. Channels are as follows: :g - public, :v - marine command, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel."
	frequency = WY_WO_FREQ
	icon_state = "pmc_headset"
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/mcom)

/obj/item/device/radio/headset/distress/contractor
	name = "VAI headset"
	desc = "A special headset used by Vanguard's Arrow Incorporated mercenaries, features a non-standard brace. Channels are as follows: :g - public, :v - marine command, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC, :t - intel."
	frequency = VAI_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/public, /obj/item/device/encryptionkey/contractor)
	has_hud = TRUE

/obj/item/device/radio/headset/distress/royal_marine
	name = "Royal Marine headset"
	desc = "A special headset used by the TWE's elite Royal Marine Commandos."
	frequency = RMC_FREQ
	icon_state = "vai_headset"
	initial_keys = list(/obj/item/device/encryptionkey/royal_marine)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY)
	volume = RADIO_VOLUME_IMPORTANT

//CMB Headsets
/obj/item/device/radio/headset/distress/CMB
	name = "\improper CMB earpiece"
	desc = "A low-profile earpiece used by the Colonial Marshal Bureau. Featured channels include: ; - CMB, :o - Colony, :g - public, :v - marine command, :m - medbay, :t - intel."
	frequency = CMB_FREQ
	icon_state = "cmb_headset"
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_MARSHAL)

/obj/item/device/radio/headset/distress/CMB/limited
	name = "\improper CMB earpiece"
	desc = "A low-profile earpiece used by the Colonial Marshal Bureau. The channels are: ; - CMB, :o - Colony."
	initial_keys = list(/obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/CMB/ICC
	name = "\improper ICC Liaison headset"
	desc = "An expensive headset used by The Interstellar Commerce Commission. This one in particular has a liaison chip with the CMB. Featured channels include: ; - CMB, :o - Colony, :g - public, :v - marine command, :m - medbay, :t - intel, :y - Weyland-Yutani."
	icon_state = "wy_headset"
	initial_keys = list(/obj/item/device/encryptionkey/WY, /obj/item/device/encryptionkey/cmb)

/obj/item/device/radio/headset/almayer/highcom
	name = "USCM High Command headset"
	desc = "Issued to members of USCM High Command and their immediate subordinates. Channels are as follows: :v - marine command, :p - military police, :a - alpha squad, :b - bravo squad, :c - charlie squad, :d - delta squad, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC,  :t - intel,  :z - HighCom"
	icon_state = "mhc_headset"
	frequency = HC_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/highcom)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/provost
	name = "USCM Provost headset"
	desc = "Issued to members of the USCM Provost Office and their immediate subordinates."
	icon_state = "pvst_headset"
	frequency = PVST_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/provost)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/almayer/sof
	name = "USCM SOF headset"
	desc = "Issued exclusively to Marine Raiders and members of the USCM's Force Reconnaissance."
	icon_state = "soc_headset"
	frequency = SOF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/soc)
	volume = RADIO_VOLUME_IMPORTANT

/obj/item/device/radio/headset/almayer/sof/survivor_forecon
	name = "USCM SOF headset"
	desc = "Issued exclusively to Marine Raiders and members of the USCM's Force Reconnaissance."
	icon_state = "soc_headset"
	frequency = SOF_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/soc/forecon)
	volume = RADIO_VOLUME_QUIET
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_NAVY)

/obj/item/device/radio/headset/almayer/mcom/vc
	name = "marine vehicle crew radio headset"
	desc = "Used by USCM vehicle crew, features a non-standard brace. Channels are as follows: :v - marine command, :n - engineering, :m - medbay, :u - requisitions"
	initial_keys = list(/obj/item/device/encryptionkey/vc)
	volume = RADIO_VOLUME_RAISED
	multibroadcast_cooldown = HIGH_MULTIBROADCAST_COOLDOWN

/obj/item/device/radio/headset/distress/UPP/recon
	name = "\improper UPP headset"
	desc = "A special headset used by recon elements of the UPP military."
	frequency = UPP_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/upp)
	volume = RADIO_VOLUME_QUIET
	ignore_z = FALSE
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_UPP)

/obj/item/device/radio/headset/distress/USASF
	name = "\improper USASF earpiece"
	desc = "A sleek headset used by members of the United States Aerospace Force, manufactured in Sol. Low profile and surprisngly comfortable. Featured channels include: ; - USASF, :o - Colony."
	frequency = ASF_FREQ
	icon_state = "nav_headset"
	initial_keys = list(/obj/item/device/encryptionkey/usasf)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_NAVY)

/obj/item/device/radio/headset/distress/USASF/attache
	desc = "A sleek headset used by members of the United States Aerospace Force, manufactured in Sol. Low profile and surprisngly comfortable. Featured channels include: ; - USASF, :o - Colony, :a Local USCM Forces."
	initial_keys = list(/obj/item/device/encryptionkey/usasf/attache)

/obj/item/device/radio/headset/distress/USASF/command
	name = "\improper USASF Command earpiece"
	desc = "A sleek headset used by officers of the United States Aerospace Force, manufactured in Sol. Low profile and surprisngly comfortable, this one has a reinforced brace. Featured channels include: ; - USASF, :o - Colony, :g - public, :v - command, :J - JTAC."
	icon_state = "navcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/usasf/command)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/distress/USASF/command/attache
	name = "\improper USASF Command earpiece"
	desc = "A sleek headset used by officers of the United States Aerospace Force, manufactured in Sol. Low profile and surprisngly comfortable, this one has a reinforced brace. Featured channels include: ; - USASF, :o - Colony, :g - public, :v - marine command, :J - JTAC, :a Local USCM Forces."
	icon_state = "navcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/usasf/command/attache)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/distress/army
	name = "\improper Army radio headset"
	desc = "A robust headset used by members of the United States Army. Built to outlast those it's issued to. Featured channels include: ; - US Army, :o - Colony."
	frequency = ARM_FREQ
	icon_state = "arm_headset"
	initial_keys = list(/obj/item/device/encryptionkey/army)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_NAVY)

/obj/item/device/radio/headset/distress/army/attache
	desc = "A robust headset used by members of the United States Army. Built to outlast those it's issued to. Featured channels include: ; - US Army, :o - Colony, :a Local USCM Forces."
	initial_keys = list(/obj/item/device/encryptionkey/army/attache)

/obj/item/device/radio/headset/distress/army/command
	name = "\improper Army Command headset"
	desc = "A robust headset used by officers of the United States Army. Built to outlast those it's issued to. This model features a reinforced brace complete with blinky light to make you seem even more important to the grunts you lead! Featured channels include: ; - US Army, :o - Colony, :v - command, :J - JTAC."
	icon_state = "armcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/army/command)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/distress/army/command/attache
	name = "\improper Army Command headset"
	desc = "A robust headset used by officers of the United States Army. Built to outlast those it's issued to. This model features a reinforced brace complete with blinky light to make you seem even more important to the grunts you lead! Featured channels include: ; - US Army, :o - Colony, :v - marine command, :J - JTAC, :a Local USCM Forces."
	icon_state = "armcom_headset"
	initial_keys = list(/obj/item/device/encryptionkey/army/command/attache)
	volume = RADIO_VOLUME_CRITICAL

/obj/item/device/radio/headset/distress/guard
	name = "\improper Colonial Guard radio headset"
	desc = "A robust headset used by members of the UA's Colonial Guard. Built to outlast those it's issued to. Featured channels include: #d - Colonial Guard, :o - Colony."
	frequency = GRD_FREQ
	icon_state = "generic_headset"
	initial_keys = list(/obj/item/device/encryptionkey/guard)
	has_hud = TRUE
	hud_type = list(MOB_HUD_FACTION_MARSHAL, MOB_HUD_FACTION_UACG)

/obj/item/device/radio/headset/distress/rebel_ua
	name = "colony headset"
	desc = "A standard headset used by colonists, but this one has been tampered with. To access the colony channel use :o."
	frequency = PFA_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/rebel_twe
	name = "colony headset"
	desc = "A standard headset used by colonists, but this one has been tampered with. To access the colony channel use :o."
	frequency = JSC_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)

/obj/item/device/radio/headset/distress/merc
	name = "mercenary headset"
	desc = "A civilian commercial headset, modified to work as a military one. Featured channels include: ; - Mercenary,  :o - Colony."
	frequency = MERC_FREQ
	initial_keys = list(/obj/item/device/encryptionkey/colony)
	ignore_z = TRUE
