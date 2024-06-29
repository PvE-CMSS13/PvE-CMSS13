
/// Holds all of our phone components
GLOBAL_LIST_EMPTY_TYPED(phones, /datum/component/phone)

/datum/component/phone

	/// Our phone category which sorts us into tabs in the phone menu TGUI
	var/phone_category = "Uncategorised"

	/// Color of phone displayed in the phone menu
	var/phone_color = "white"

	/// The id of our phone which shows up when we talk
	var/phone_id = "Telephone"

	/// Our phone icon that is displayed in the phone menu TGUI
	var/phone_icon

	/// Our connected handset
	var/obj/item/handset/phone_handset

	/// What actually holds our phone, defaults to parent but may be set differently
	var/atom/holder

	/// A phone we are calling or has called us
	var/datum/component/phone/calling_phone

	/// Whether or not the phone is receiving calls or not. Varies between on/off or forcibly on/off.
	var/do_not_disturb = PHONE_DO_NOT_DISTURB_OFF

	/// The ID of our timer to cancel an attempted call and "go to voicemail"
	var/timeout_timer_id

	/// The time it takes for our timer to end to cancel an attempted call and "go to voicemail"
	var/timeout_duration = 30 SECONDS

	/// Networks that this phone can take calls from
	var/list/networks_receive = list()

	/// Networks that this phone can call
	var/list/networks_transmit = list()

	/// The looping ringing sound when the phone is called
	var/datum/looping_sound/phone_ringing/ringing_loop

	/// Whether the phone is able to be called or not
	var/enabled = TRUE

/datum/component/phone/Initialize(phone_category, phone_color, phone_id, phone_icon, do_not_disturb, list/networks_receive, list/networks_transmit, holder)
	. = ..()

	if(!istype(parent, /atom))
		return COMPONENT_INCOMPATIBLE

	if(!handle_initial_variables(arglist(args)))
		return COMPONENT_INCOMPATIBLE

	GLOB.phones += src

/datum/component/phone/Destroy()
	if(phone_handset)
		if(!phone_handset.loc)
			UnregisterSignal(phone_handset, COMSIG_PARENT_PREQDELETED)
			qdel(phone_handset)
		else
			phone_handset.phone_component = null
			phone_handset = null

	networks_receive = null
	networks_transmit = null
	QDEL_NULL(ringing_loop)

	GLOB.phones -= src
	SStgui.close_uis(src)

	reset_call()
	return ..()

/// Handles all of our variables usually set in Initialize(), needs to be a proc so virtual phones don't get incorrect signals or a handset
/datum/component/phone/proc/handle_initial_variables(phone_category, phone_color, phone_id, phone_icon, do_not_disturb, list/networks_receive, list/networks_transmit, holder)
	src.phone_category = isnull(phone_category) ? src.phone_category : phone_category
	src.phone_color = isnull(phone_color) ? src.phone_color : phone_color
	src.phone_id = isnull(phone_id) ? src.phone_id : phone_id
	src.phone_icon = isnull(phone_icon) ? src.phone_icon : phone_icon
	src.do_not_disturb = isnull(do_not_disturb) ? src.do_not_disturb : do_not_disturb
	src.networks_receive = isnull(networks_receive) ? src.networks_receive : networks_receive.Copy()
	src.networks_transmit = isnull(networks_transmit) ? src.networks_transmit : networks_transmit.Copy()
	src.holder = holder ? holder : parent

	phone_handset = new(null, src, src.holder)
	RegisterSignal(phone_handset, COMSIG_PARENT_PREQDELETED, PROC_REF(override_delete))

	RegisterSignal(src.holder, COMSIG_ATOM_MOB_ATTACKBY, PROC_REF(item_used_on_phone))
	RegisterSignal(src.holder, COMSIG_ATOM_BEFORE_HUMAN_ATTACK_HAND, PROC_REF(use_phone))

	if(istype(src.holder, /obj/item))
		RegisterSignal(src.holder, COMSIG_ITEM_PICKUP, PROC_REF(holder_picked_up))
		RegisterSignal(src.holder, COMSIG_ITEM_DROPPED, PROC_REF(holder_dropped))
		enabled = FALSE

	RegisterSignal(src.holder, COMSIG_MOVABLE_FORCEMOVED, PROC_REF(holder_forcemoved))

	ringing_loop = new(src.holder)

	return TRUE

/// Handles bringing our handset back in case something tries to delete it
/datum/component/phone/proc/override_delete()
	SIGNAL_HANDLER
	recall_handset()
	return COMPONENT_ABORT_QDEL

/// Handles any attackbys on our holder so we can hang up the phone
/datum/component/phone/proc/item_used_on_phone(atom/phone, obj/item/attacking_item, mob/user)
	SIGNAL_HANDLER

	if(attacking_item == phone_handset)
		recall_handset()
		return COMPONENT_CANCEL_ATTACKBY

/// When we initially interact with the phone, whether opening the menu to call someone or picking up the phone being called
/datum/component/phone/proc/use_phone(atom/phone, mob/living/carbon/human/user, click_parameters)
	SIGNAL_HANDLER

	if(!calling_phone)
		INVOKE_ASYNC(src, PROC_REF(tgui_interact), user)

		if(enabled)
			return COMPONENT_CANCEL_HUMAN_ATTACK_HAND
		return

	if(!phone_handset)
		return

	if(phone_handset.loc)
		return

	picked_up_call(user)
	calling_phone.other_phone_picked_up_call()

	return COMPONENT_CANCEL_HUMAN_ATTACK_HAND

/// Handles what we want to do when we pick up a phone
/datum/component/phone/proc/picked_up_call(mob/living/carbon/human/user)
	to_chat(user, SPAN_PURPLE("[icon2html(holder, user)] Picked up a call from [calling_phone.phone_id]."))
	playsound(get_turf(user), "rtb_handset")

	user.put_in_active_hand(phone_handset)
	SEND_SIGNAL(holder, COMSIG_ATOM_PHONE_PICKED_UP)
	ringing_loop.stop()

/// Handles what we want to do when a phone we are calling picks up
/datum/component/phone/proc/other_phone_picked_up_call()
	if(!calling_phone)
		return

	if(!phone_handset)
		return

	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	if(!ismob(phone_handset.loc))
		return

	var/mob/phone_user = phone_handset.loc
	to_chat(phone_user, SPAN_PURPLE("[icon2html(calling_phone.holder, phone_user)] [calling_phone.phone_id] has picked up."))

/// Handles setting a specific phone ID and enabling the phone when the holder is picked up
/datum/component/phone/proc/holder_picked_up(obj/item/picked_up_holder, mob/user)
	SIGNAL_HANDLER

	enabled = TRUE

	if(!ishuman(user))
		phone_id = "[user]"
		return

	var/mob/living/carbon/human/human_user = user
	phone_id = "[human_user.comm_title || GET_HUMAN_DEFAULT_ASSIGNMENT(human_user)] [human_user]"

	if(human_user.assigned_squad)
		phone_id += " ([human_user.assigned_squad.name])"

/// Handles disabling the phone when the holder is dropped
/datum/component/phone/proc/holder_dropped(obj/item/dropped_hold, mob/user)
	SIGNAL_HANDLER

	enabled = FALSE
	phone_id = "[holder]"

/// Tells our phone_handset that the holder has been forcemoved so the tether can be updated if need be
/datum/component/phone/proc/holder_forcemoved(atom/movable/moving_atom, atom/destination)
	SIGNAL_HANDLER

	if(!phone_handset)
		return

	phone_handset.reset_tether()

/// Gathers all phones that we can call from our phone, returns a list of those phones
/datum/component/phone/proc/get_phones()
	var/list/phone_list = list()

	for(var/possible_phone in GLOB.phones)
		var/datum/component/phone/target_phone = possible_phone

		if(!target_phone.phone_available())
			continue

		var/net_link = FALSE
		for(var/network in networks_transmit)
			if(network in target_phone.networks_receive)
				net_link = TRUE
				continue
		if(!net_link)
			continue

		var/id = target_phone.phone_id
		var/num_id = 1
		while(id in phone_list)
			id = "[target_phone.phone_id] [num_id]"
			num_id++

		target_phone.phone_id = id
		phone_list[id] = target_phone

	return phone_list

/// Whether or not our phone is available to be called from other phones, returns TRUE if callable, otherwise FALSE. Note: this does not account for network compatability
/datum/component/phone/proc/phone_available()
	if(calling_phone)
		return FALSE

	if(!phone_handset)
		return FALSE

	if(!enabled)
		return FALSE

	if(phone_handset.loc)
		return FALSE

	if(do_not_disturb == PHONE_DO_NOT_DISTURB_ON)
		return FALSE

	if(do_not_disturb == PHONE_DO_NOT_DISTURB_FORCED)
		return FALSE

	return TRUE

/// Whether or not clicking on our phone will bring up the phone menu, returns TRUE if it will, otherwise FALSE
/datum/component/phone/proc/phone_menu_usable()
	if(calling_phone)
		return FALSE

	if(!phone_handset)
		return FALSE

	if(!enabled)
		return FALSE

	if(phone_handset.loc)
		return

	return TRUE

/// Starts calling another phone, sets up connection between the phones
/datum/component/phone/proc/call_phone(mob/user, calling_phone_id)
	var/list/phones = get_phones()
	phones -= phone_id

	if(!length(phones) || !(calling_phone_id in phones))
		to_chat(user, SPAN_PURPLE("[icon2html(holder, user)] No phones could be located to call!"))
		return

	calling_phone = phones[calling_phone_id]
	if(!istype(calling_phone) || QDELETED(calling_phone))
		calling_phone = null
		CRASH("Qdelled/improper atom inside phones list! (istype returned: [istype(calling_phone)], QDELETED returned: [QDELETED(calling_phone)])")

	if(!calling_phone.phone_available())
		calling_phone = null
		return

	calling_phone.getting_call(src)

	post_call_phone(user, calling_phone_id)

/// What we do when our phone is receiving a call, called from incoming_call's call_phone()
/datum/component/phone/proc/getting_call(datum/component/phone/incoming_call)
	calling_phone = incoming_call
	SEND_SIGNAL(holder, COMSIG_ATOM_PHONE_RINGING)
	ringing_loop.start()

/// What we do after our call is set up from call_phone()
/datum/component/phone/proc/post_call_phone(mob/user, calling_phone_id)
	to_chat(user, SPAN_PURPLE("[icon2html(holder, user)] Dialing [calling_phone_id].."))
	timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), TRUE), timeout_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
	playsound(get_turf(user), "rtb_handset")

	user.put_in_active_hand(phone_handset)
	SEND_SIGNAL(holder, COMSIG_ATOM_PHONE_PICKED_UP)

/// Resets this phone's connection as well as anything we are connected to's connection, calls itself on any other connections
/datum/component/phone/proc/reset_call(timeout = FALSE, recursed = FALSE)
	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	if(!calling_phone)
		return

	if(!recursed)
		calling_phone.reset_call(timeout, recursed = TRUE)

	SEND_SIGNAL(holder, COMSIG_ATOM_PHONE_STOPPED_RINGING)

	ringing_loop?.stop()

	handle_reset_call_message(timeout, recursed)

	calling_phone = null

/// Handles any messaging we want when a call is reset
/datum/component/phone/proc/handle_reset_call_message(timeout = FALSE, recursed = FALSE)
	if(!phone_handset)
		return

	if(!ismob(phone_handset.loc))
		return

	var/mob/handset_user = phone_handset.loc
	if(recursed)
		to_chat(handset_user, SPAN_PURPLE("[icon2html(holder, handset_user)] [calling_phone.phone_id] has hung up on you."))
	else if(timeout)
		to_chat(handset_user, SPAN_PURPLE("[icon2html(holder, handset_user)] Your call to [calling_phone.phone_id] has reached voicemail, you immediately disconnect the line."))
	else
		to_chat(handset_user, SPAN_PURPLE("[icon2html(holder, handset_user)] You have hung up on [calling_phone.phone_id]."))

/// Recalls our handset back to holder and calls reset_call()
/datum/component/phone/proc/recall_handset()
	if(ismob(phone_handset.loc))
		var/mob/M = phone_handset.loc
		M.drop_held_item(phone_handset)
		playsound(get_turf(M), "rtb_handset", 100, FALSE, 7)

	phone_handset.moveToNullspace()
	reset_call()

	SEND_SIGNAL(holder, COMSIG_ATOM_PHONE_HUNG_UP)

/// Handles any messages that our handset 'hears' and passes to us. Passes the message to this phone and any connected phone via handle_hear()
/datum/component/phone/proc/handle_speak(message, datum/language/message_language, mob/speaker, direct_talking = TRUE)
	if(message_language?.flags & SIGNLANG)
		return

	if(!calling_phone)
		return

	if(direct_talking)
		handle_hear(message, message_language, speaker, direct_talking)

		log_say("TELEPHONE: [key_name(speaker)] on Phone '[phone_id]' to '[calling_phone.phone_id]' said '[message]'")

		var/comm_paygrade = speaker.get_paygrade()

		for(var/mob/dead/observer/cycled_observer in GLOB.player_list)
			if(cycled_observer == get_user() || cycled_observer == calling_phone.get_user())
				continue

			if((cycled_observer.client) && (cycled_observer.client.prefs) && (cycled_observer.client.prefs.toggles_chat & CHAT_GHOSTRADIO))
				var/ghost_message = "<span class='purple'><span class='name'>[comm_paygrade][speaker] (<a href='byond://?src=\ref[cycled_observer];track=\ref[speaker]'>F</a>)</span> on '[phone_id]' to '[calling_phone.phone_id]': <span class='body'>\"[message]\"</span></span>"
				cycled_observer.show_message(ghost_message, SHOW_MESSAGE_AUDIBLE)

	calling_phone.handle_hear(message, message_language, speaker, direct_talking)

/// Handles any messages passed from handle_speak() and serves them to the user
/datum/component/phone/proc/handle_hear(message, datum/language/message_language, mob/speaker, direct_talking)
	if(!phone_handset)
		return

	if(!calling_phone)
		return

	if(!ismob(phone_handset.loc))
		return

	var/loudness = 0
	if(phone_handset.raised)
		loudness = 3

	var/mob/hearing_mob = phone_handset.loc
	var/name_override = calling_phone.phone_id

	if(hearing_mob == speaker && direct_talking)
		name_override = phone_id

	hearing_mob.hear_radio(message, "says", message_language, part_a = "<span class='purple'><span class='name'>", part_b = "</span><span class='message'> ", vname = name_override, speaker = speaker, command = loudness, no_paygrade = TRUE)

/// Toggles do not disturb on or off, does not handle forced or unable do_not_disturb variables
/datum/component/phone/proc/toggle_do_not_disturb(mob/user)
	switch(do_not_disturb)
		if(PHONE_DO_NOT_DISTURB_ON)
			do_not_disturb = PHONE_DO_NOT_DISTURB_OFF
			to_chat(user, SPAN_NOTICE("Do Not Disturb has been disabled. You can now receive calls."))
		if(PHONE_DO_NOT_DISTURB_OFF)
			do_not_disturb = PHONE_DO_NOT_DISTURB_ON
			to_chat(user, SPAN_WARNING("Do Not Disturb has been enabled. No calls will be received."))
		else
			return FALSE
	return TRUE

/// Returns a mob that is using the phone or null if unable to find a user
/datum/component/phone/proc/get_user()
	return ismob(phone_handset.loc) ? phone_handset.loc : null

//TGUI section

/datum/component/phone/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(phone_menu_usable())
		return UI_INTERACTIVE

/datum/component/phone/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("call_phone")
			if(calling_phone)
				return TRUE
			call_phone(ui.user, params["phone_id"])
			return TRUE

		if("toggle_do_not_disturb")
			toggle_do_not_disturb(ui.user)
			return TRUE

/datum/component/phone/ui_data(mob/user)
	var/list/data = list()

	data["do_not_disturb"] = do_not_disturb

	return data

/datum/component/phone/ui_static_data(mob/user)
	. = list()

	.["available_phones"] = get_phones() - list(phone_id)
	var/list/phones = list()
	for(var/datum/component/phone/cycled_phone as anything in GLOB.phones)
		phones += list(list(
			"phone_category" = cycled_phone.phone_category,
			"phone_color" = cycled_phone.phone_color,
			"phone_id" = cycled_phone.phone_id,
			"phone_icon" = cycled_phone.phone_icon
		))

	.["phones"] = phones

/datum/component/phone/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PhoneMenu", phone_id)
		ui.open()


// Virtual phone section

/// Virtual phone used for situations where you want to be able to use a phone without a handset
/datum/component/phone/virtual
	/// If it is a virtual phone we need a virtual user
	var/client/virtual_user

/datum/component/phone/virtual/Destroy()
	virtual_user = null

	return ..()

/datum/component/phone/virtual/handle_initial_variables(phone_category, phone_color, phone_id, phone_icon, do_not_disturb, list/networks_receive, list/networks_transmit, holder, virtual_user)
	src.phone_category = isnull(phone_category) ? src.phone_category : phone_category
	src.phone_color = isnull(phone_color) ? src.phone_color : phone_color
	src.phone_id = isnull(phone_id) ? src.phone_id : phone_id
	src.phone_icon = isnull(phone_icon) ? src.phone_icon : phone_icon
	src.do_not_disturb = isnull(do_not_disturb) ? src.do_not_disturb : do_not_disturb
	src.networks_receive = isnull(networks_receive) ? src.networks_receive : networks_receive.Copy()
	src.networks_transmit = isnull(networks_transmit) ? src.networks_transmit : networks_transmit.Copy()
	src.holder = holder ? holder : parent

	if(!virtual_user)
		return FALSE
	src.virtual_user = virtual_user

	RegisterSignal(src.holder, COMSIG_ATOM_ATTACK_HAND, PROC_REF(use_phone))

	return TRUE

/datum/component/phone/virtual/use_phone(atom/phone, mob/living/carbon/human/user, click_parameters)
	INVOKE_ASYNC(src, PROC_REF(tgui_interact), user)

/datum/component/phone/virtual/picked_up_call(mob/living/carbon/human/user)
	to_chat(user, SPAN_PURPLE("[icon2html(holder, user)] Picked up a call from [calling_phone.phone_id]."))

	RegisterSignal(virtual_user.mob, COMSIG_DEAD_SPEAK, PROC_REF(handle_virtual_speak))

/datum/component/phone/virtual/other_phone_picked_up_call()
	if(!calling_phone)
		return

	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	RegisterSignal(virtual_user.mob, COMSIG_DEAD_SPEAK, PROC_REF(handle_virtual_speak))
	to_chat(virtual_user, SPAN_PURPLE("[icon2html(calling_phone.holder, virtual_user)] [calling_phone.phone_id] has picked up."))

/datum/component/phone/virtual/phone_available()
	if(calling_phone)
		return FALSE

	if(do_not_disturb == PHONE_DO_NOT_DISTURB_ON)
		return FALSE

	if(do_not_disturb == PHONE_DO_NOT_DISTURB_FORCED)
		return FALSE

	return TRUE

/datum/component/phone/virtual/reset_call(timeout = FALSE, recursed = FALSE)
	. = ..()
	if(!virtual_user?.mob)
		return

	UnregisterSignal(virtual_user.mob, COMSIG_DEAD_SPEAK)

/datum/component/phone/virtual/handle_reset_call_message(timeout = FALSE, recursed = FALSE)
	if(recursed)
		to_chat(virtual_user, SPAN_PURPLE("[icon2html(holder, virtual_user)] [calling_phone.phone_id] has hung up on you."))
	else if(timeout)
		to_chat(virtual_user, SPAN_PURPLE("[icon2html(holder, virtual_user)] Your call to [calling_phone.phone_id] has reached voicemail, you immediately disconnect the line."))
	else
		to_chat(virtual_user, SPAN_PURPLE("[icon2html(holder, virtual_user)] You have hung up on [calling_phone.phone_id]."))

/datum/component/phone/virtual/getting_call(datum/component/phone/incoming_call)
	calling_phone = incoming_call
	SEND_SIGNAL(holder, COMSIG_ATOM_PHONE_RINGING)
	playsound_client(virtual_user, 'sound/machines/telephone/telephone_ring.ogg', vol = 50)
	addtimer(CALLBACK(src, PROC_REF(delayed_client_sound)), (10 SECONDS))

/datum/component/phone/virtual/proc/delayed_client_sound()
	if(!calling_phone || !calling_phone.timeout_timer_id)
		return

	playsound_client(virtual_user, 'sound/machines/telephone/telephone_ring.ogg', vol = 50)

/datum/component/phone/virtual/post_call_phone(mob/user, calling_phone_id)
	to_chat(user, SPAN_PURPLE("[icon2html(holder, user)] Dialing [calling_phone_id].."))
	timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), TRUE), timeout_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

	playsound_client(user.client, "rtb_handset")

/datum/component/phone/virtual/recall_handset()
	reset_call() // I don't think this will be possible given like... we don't have a handset but just in case
	return

/datum/component/phone/virtual/handle_hear(message, datum/language/message_language, mob/speaker, direct_talking)
	if(!calling_phone)
		return

	var/name_override = calling_phone.phone_id

	if(virtual_user == speaker)
		name_override = phone_id

	if(!virtual_user.mob)
		return

	virtual_user.mob.hear_radio(message, "says", message_language, part_a = "<span class='purple'><span class='name'>", part_b = "</span><span class='message'> ", vname = name_override, speaker = speaker, command = 3, no_paygrade = TRUE)

/// Used to fake the other side of our phone connection as a virtual user
/datum/component/phone/virtual/proc/handle_virtual_speak(mob/speaker, message)
	SIGNAL_HANDLER

	if(!calling_phone)
		return

	handle_hear(message, null, speaker, TRUE)

	log_say("TELEPHONE: [key_name(speaker)] on Phone '[phone_id]' to '[calling_phone.phone_id]' said '[message]'")

	for(var/mob/dead/observer/cycled_observer in GLOB.player_list)
		if(cycled_observer == get_user() || cycled_observer == calling_phone.get_user())
			continue

		if((cycled_observer.client) && (cycled_observer.client.prefs) && (cycled_observer.client.prefs.toggles_chat & CHAT_GHOSTRADIO))
			var/ghost_message = "<span class='purple'><span class='name'>Game Master</span> on '[phone_id]' to '[calling_phone.phone_id]': <span class='body'>\"[message]\"</span></span>"
			cycled_observer.show_message(ghost_message, SHOW_MESSAGE_AUDIBLE)

	calling_phone.handle_hear(message, null, speaker, TRUE)

	return COMPONENT_OVERRIDE_DEAD_SPEAK

/datum/component/phone/virtual/get_user()
	return virtual_user.mob

// TGUI section

/datum/component/phone/virtual/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE

/datum/component/phone/virtual/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("hang_up")
			reset_call()
			return TRUE
		if("pick_up")
			if(!calling_phone)
				return
			picked_up_call(ui.user)
			calling_phone.other_phone_picked_up_call()
			return TRUE

/datum/component/phone/virtual/ui_data(mob/user)
	. = ..()

	.["virtual_phone"] = TRUE
	.["being_called"] = calling_phone?.timeout_timer_id ? TRUE : FALSE
	.["active_call"] = calling_phone ? TRUE : FALSE
	.["calling_phone_id"] = "[calling_phone?.phone_id]"
