/obj/structure/phone_base
	name = "telephone receiver"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "wall_phone"
	desc = "It is a wall mounted telephone. The fine text reads: To log your details with the mainframe please insert your keycard into the slot below. Unfortunately the slot is jammed. You can still use the phone, however."
	unslashable = TRUE

	var/phone_category = "Uncategorised"
	var/phone_color = "white"
	var/phone_id = "Telephone"
	var/phone_icon

	/// Whether or not the phone is receiving calls or not. Varies between on/off or forcibly on/off.
	var/do_not_disturb = PHONE_DND_OFF

	var/list/networks_receive = list(FACTION_MARINE)
	var/list/networks_transmit = list(FACTION_MARINE)

/obj/structure/phone_base/Initialize(mapload, ...)
	. = ..()

	AddComponent(/datum/component/phone, phone_category, phone_color, phone_id, phone_icon, do_not_disturb, networks_receive, networks_transmit)
	RegisterSignal(src, COMSIG_ATOM_PHONE_PICKED_UP, PROC_REF(phone_picked_up))
	RegisterSignal(src, COMSIG_ATOM_PHONE_HUNG_UP, PROC_REF(phone_hung_up))
	RegisterSignal(src, COMSIG_ATOM_PHONE_RINGING, PROC_REF(phone_ringing))
	RegisterSignal(src, COMSIG_ATOM_PHONE_STOPPED_RINGING, PROC_REF(phone_stopped_ringing))

/obj/structure/phone_base/Destroy()
	networks_receive = null
	networks_transmit = null
	return ..()

/obj/structure/phone_base/proc/phone_picked_up()
	icon_state = PHONE_OFF_BASE_UNIT_ICON_STATE

/obj/structure/phone_base/proc/phone_hung_up()
	icon_state = PHONE_ON_BASE_UNIT_ICON_STATE

/obj/structure/phone_base/proc/phone_ringing()
	icon_state = PHONE_RINGING_ICON_STATE

/obj/structure/phone_base/proc/phone_stopped_ringing()
	if(icon_state == PHONE_OFF_BASE_UNIT_ICON_STATE)
		return
	icon_state = PHONE_ON_BASE_UNIT_ICON_STATE

/obj/structure/phone_base/hidden
	do_not_disturb = PHONE_DND_FORCED

/obj/structure/phone_base/no_dnd
	do_not_disturb = PHONE_DND_FORBIDDEN

//rotary desk phones (need a touch tone handset at some point)
/obj/structure/phone_base/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/phone_base/rotary/no_dnd
	do_not_disturb = PHONE_DND_FORBIDDEN

/obj/structure/phone_base/touchtone
	name = "touch-tone telephone"
	icon_state = "rotary_phone"//placeholder
	desc = "Ancient aliens, it's all true. I'm an expert just like you!"

/obj/structure/phone_base/colony_net
	networks_receive = list(FACTION_COLONIST)
	networks_transmit = list(FACTION_COLONIST)

/obj/structure/phone_base/colony_net/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/phone_base/upp_net
	networks_receive = list(FACTION_UPP)
	networks_transmit = list(FACTION_UPP)

/obj/structure/phone_base/upp_net/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/phone_base/clf_net
	networks_receive = list(FACTION_CLF)
	networks_transmit = list(FACTION_CLF)

/obj/structure/phone_base/clf_net/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/phone_base/wy_net
	networks_receive = list(FACTION_WY)
	networks_transmit = list(FACTION_WY)

/obj/structure/phone_base/wy_net/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/phone_base/toc
	name = "telephone receiver"
	icon = 'icons/obj/vehicles/interiors/movie.dmi'

/obj/item/phone
	name = "telephone"
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "rpb_phone"
