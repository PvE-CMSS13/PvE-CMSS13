/obj/item/puzzle/keycard
	name = "security keycard"
	desc = "This feels like it belongs to a door."
	icon = 'void-marines/icons/puzzle_things.dmi'
	icon_state = "keycard"
	force = 0
	throwforce = 0
	throw_speed = 1
	throw_range = 7
	var/unlock_tag

/obj/structure/machinery/puzzle/keycard_panel
	name = "keycard panel"
	desc = "A panel that controls something nearby. This one requires a keycard."
	needs_power = FALSE
	icon = 'void-marines/icons/puzzle_things.dmi'
	icon_state = "panel_keycard"
	var/list/to_open = list()
	var/id_tag

/obj/structure/machinery/door/airlock/puzzle
	name = "locked door"
	desc = "This door only opens under certain conditions. It looks virtually indestructible."
	icon = 'void-marines/icons/puzzle_things.dmi'
	no_panel = TRUE
	not_weldable = TRUE
	needs_power = FALSE
	autoclose = FALSE
	locked = TRUE
	icon_state = "door_locked"
	stat = 0
	heavy = TRUE
	masterkey_resist = TRUE
	unacidable = TRUE

/obj/structure/machinery/door/airlock/puzzle/Initialize()
	. = ..()
	for(var/obj/structure/machinery/puzzle/keycard_panel/P in world)
		if(P.id_tag == id_tag)
			P.to_open += src

/obj/structure/machinery/door/airlock/multi_tile/puzzle
	name = "locked door"
	desc = "This door only opens under certain conditions. It looks virtually indestructible."
	icon = 'void-marines/icons/puzzle_things.dmi'
	no_panel = TRUE
	not_weldable = TRUE
	needs_power = FALSE
	autoclose = FALSE
	locked = TRUE
	icon_state = "door_locked"
	stat = 0
	heavy = TRUE
	masterkey_resist = TRUE
	unacidable = TRUE

/obj/structure/machinery/door/airlock/multi_tile/puzzle/Initialize()
	. = ..()
	for(var/obj/structure/machinery/puzzle/keycard_panel/P in world)
		if(P.id_tag == id_tag)
			P.to_open += src

/obj/structure/machinery/puzzle/keycard_panel/attackby(obj/item/I,mob/user)
	if(istype(I,/obj/item/puzzle/keycard))
		var/obj/item/puzzle/keycard/K = I
		if(K.unlock_tag != id_tag)
			to_chat(user, "Access Denied")
			playsound(user.loc, 'sound/machines/terminal_error.ogg', 25, 0)
			return
		flick("panel_keycard", src)
		playsound(user.loc, 'sound/machines/ping.ogg', 25, 0)
		for(var/obj/structure/machinery/door/airlock/A in to_open)
			if(A.locked)
				A.unlock()
			else
				A.lock()
		to_chat(user, "You swipe the keycard.")

//****************
//***test shit****
//****************

/obj/structure/machinery/puzzle/keycard_panel/medical
	name = "Medical Department Keycard Panel"
	id_tag = "medical"

/obj/structure/machinery/door/airlock/puzzle/medical
	name = "Medical Department"
	id_tag = "medical"
	icon = 'icons/obj/structures/doors/medidoor.dmi'

/obj/structure/machinery/door/airlock/multi_tile/puzzle/medical
	name = "Medical Department"
	id_tag = "medical"
	icon = 'icons/obj/structures/doors/2x1medidoor.dmi'

/obj/item/puzzle/keycard/medical
	name = "medical keycard"
	desc = "This feels like it belongs to a door. Judging by the color, this one seems to belong to the medical section."
	icon_state = "keycard4"
	unlock_tag = "medical"

/obj/structure/machinery/puzzle/keycard_panel/engineering
	name = "Engineering Department Keycard Panel"
	id_tag = "engineering"

/obj/structure/machinery/door/airlock/puzzle/engineering
	name = "Engineering Department"
	id_tag = "engineering"
	icon = 'icons/obj/structures/doors/engidoor.dmi'

/obj/structure/machinery/door/airlock/multi_tile/puzzle/engineering
	name = "Engineering Department"
	id_tag = "engineering"
	icon = 'icons/obj/structures/doors/2x1engidoor.dmi'

/obj/item/puzzle/keycard/engineering
	name = "engineering keycard"
	desc = "This feels like it belongs to a door. Judging by the color, this one seems to belong to the engineering section."
	icon_state = "keycard3"
	unlock_tag = "engineering"

/obj/structure/machinery/puzzle/keycard_panel/security
	name = "Security Department Keycard Panel"
	id_tag = "security"

/obj/structure/machinery/door/airlock/puzzle/security
	name = "Security Department"
	id_tag = "security"
	icon = 'icons/obj/structures/doors/secdoor.dmi'

/obj/structure/machinery/door/airlock/multi_tile/puzzle/security
	name = "Security Department"
	id_tag = "security"
	icon = 'icons/obj/structures/doors/2x1secdoor.dmi'

/obj/item/puzzle/keycard/security
	name = "security keycard"
	desc = "This feels like it belongs to a door. Judging by the color, this one seems to belong to the security section."
	icon_state = "keycard2"
	unlock_tag = "security"

/obj/structure/machinery/puzzle/keycard_panel/science
	name = "Science Department Keycard Panel"
	id_tag = "science"

/obj/structure/machinery/door/airlock/puzzle/science
	name = "Science Department"
	id_tag = "science"
	icon = 'icons/obj/structures/doors/medidoor_plain.dmi'

/obj/structure/machinery/door/airlock/multi_tile/puzzle/science
	name = "Science Department"
	id_tag = "science"
	icon = 'icons/obj/structures/doors/2x1generic_solid.dmi'

/obj/item/puzzle/keycard/science
	name = "science keycard"
	desc = "This feels like it belongs to a door. Judging by the color, this one seems to belong to the science section."
	icon_state = "keycard5"
	unlock_tag = "science"

/obj/structure/machinery/puzzle/keycard_panel/vault
	name = "High Security Department Keycard Panel"
	id_tag = "vault"

/obj/structure/machinery/door/airlock/puzzle/vault
	name = "High Security Department"
	id_tag = "vault"
	icon = 'icons/obj/structures/doors/vault.dmi'

/obj/structure/machinery/door/airlock/multi_tile/puzzle/vault
	name = "High Security Department"
	id_tag = "vault"
	icon = 'icons/obj/structures/doors/2x1almayerdoor.dmi'

/obj/item/puzzle/keycard/vault
	name = "high Security keycard"
	desc = "This feels like it belongs to a door. Judging by the color, this one seems to belong to the science section."
	icon_state = "keycard1"
	unlock_tag = "vault"
