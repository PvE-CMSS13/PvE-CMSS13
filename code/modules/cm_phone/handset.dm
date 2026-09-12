
#define HANDSET_RANGE 7

/obj/item/handset
	name = "telephone"
	icon = 'icons/obj/items/misc.dmi'
	icon_state = "rpb_phone"

	w_class = SIZE_LARGE

	flags_atom = FPRINT|USES_HEARING

	var/datum/component/phone/phone_component

	var/atom/holder

	var/datum/effects/tethering/tether_effect

	var/raised = FALSE
	var/zlevel_transfer = FALSE
	var/zlevel_transfer_timer = TIMER_ID_NULL
	var/zlevel_transfer_timeout = 5 SECONDS

/obj/item/handset/Initialize(mapload, phone_component, holder)
	. = ..()

	src.phone_component = phone_component
	src.holder = holder
	attach_to(src.holder)

/obj/item/handset/Destroy()
	phone_component = null
	holder = null
	remove_attached()
	return ..()

/obj/item/handset/hear_talk(mob/living/talker, message, verb="says", datum/language/message_language, italics = 0)
	. = ..()

	if(!phone_component)
		return

	if(talker == loc)
		phone_component.handle_speak(message, message_language, talker, direct_talking = TRUE)
		return

	var/distance = get_dist(src, talker)

	if(distance > 1)
		return

	message = stars(message, (100 - (distance * 40 + rand(-15, 15))))

	phone_component.handle_speak(message, message_language, talker, direct_talking = FALSE)

/obj/item/handset/proc/attach_to(atom/to_attach)
	if(!istype(to_attach))
		return

	remove_attached()

	holder = to_attach

/obj/item/handset/proc/remove_attached()
	holder = null
	reset_tether()

/obj/item/handset/proc/reset_tether()
	SIGNAL_HANDLER
	if (tether_effect)
		UnregisterSignal(tether_effect, COMSIG_PARENT_QDELETING)
		if(!QDESTROYING(tether_effect))
			qdel(tether_effect)
		tether_effect = null
	if(!do_zlevel_check())
		on_beam_removed()

/obj/item/handset/attack_hand(mob/user)
	if(holder && get_dist(user, holder) > HANDSET_RANGE)
		return FALSE
	return ..()

/obj/item/handset/proc/on_beam_removed()
	if(!holder)
		return

	if(!loc)
		return

	if(get_dist(holder, src) > HANDSET_RANGE)
		phone_component.recall_handset()

	var/atom/tether_to = get_atom_on_turf(src)

	var/atom/tether_from = get_atom_on_turf(holder)

	if(tether_from == tether_to)
		return

	var/list/tether_effects = apply_tether(tether_from, tether_to, range = HANDSET_RANGE, icon = "wire", always_face = FALSE)
	tether_effect = tether_effects["tetherer_tether"]
	RegisterSignal(tether_effect, COMSIG_PARENT_QDELETING, PROC_REF(reset_tether))

/obj/item/handset/attack_self(mob/user)
	..()

	if(raised)
		set_raised(FALSE, user)
		to_chat(user, SPAN_NOTICE("You lower [src]."))
	else
		set_raised(TRUE, user)
		to_chat(user, SPAN_NOTICE("You raise [src] to your ear."))

/obj/item/handset/proc/set_raised(to_raise, mob/living/carbon/human/user)
	if(!istype(user))
		return

	if(!to_raise)
		raised = FALSE
		item_state = icon_state
	else
		raised = TRUE
		item_state = "[icon_state]_ear"

	user.update_inv_r_hand()
	user.update_inv_l_hand()

/obj/item/handset/dropped(mob/user)
	. = ..()
	set_raised(FALSE, user)
	reset_tether()

/obj/item/handset/on_enter_storage(obj/item/storage/S)
	. = ..()
	if(phone_component)
		phone_component.recall_handset()

/obj/item/handset/forceMove(atom/dest)
	. = ..()
	if(.)
		reset_tether()

/obj/item/handset/moveToNullspace()
	. = ..()
	if(.)
		reset_tether()

/obj/item/handset/proc/do_zlevel_check()
	if(!holder || !loc?.z || !holder.z)
		return FALSE

	if(zlevel_transfer)
		if(loc.z == holder.z)
			zlevel_transfer = FALSE
			if(zlevel_transfer_timer)
				deltimer(zlevel_transfer_timer)
			UnregisterSignal(holder, COMSIG_MOVABLE_MOVED)
			return FALSE
		return TRUE

	if(holder && loc.z != holder.z)
		zlevel_transfer = TRUE
		zlevel_transfer_timer = addtimer(CALLBACK(src, PROC_REF(try_doing_tether)), zlevel_transfer_timeout, TIMER_UNIQUE|TIMER_STOPPABLE)
		RegisterSignal(holder, COMSIG_MOVABLE_MOVED, PROC_REF(transmitter_move_handler))
		return TRUE
	return FALSE

/obj/item/handset/proc/transmitter_move_handler(datum/source)
	SIGNAL_HANDLER
	zlevel_transfer = FALSE
	if(zlevel_transfer_timer)
		deltimer(zlevel_transfer_timer)
	UnregisterSignal(holder, COMSIG_MOVABLE_MOVED)
	reset_tether()

/obj/item/handset/proc/try_doing_tether()
	zlevel_transfer_timer = TIMER_ID_NULL
	zlevel_transfer = FALSE
	UnregisterSignal(holder, COMSIG_MOVABLE_MOVED)
	reset_tether()

/obj/item/handset/upp
	icon_state = "upp_rpb_phone"
#undef HANDSET_RANGE
