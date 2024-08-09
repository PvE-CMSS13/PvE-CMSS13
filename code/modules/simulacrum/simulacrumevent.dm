// <p>The USS Rover has detected a distorted signal on the desert planet of LV-739. In accordance with standard procedure, ship has been taken out of FTL travel and crew awakened for possible distress signal. Signal is detected 73.8 meters at heading 98.6 degrees from landing zone.</p><br><p>ASRS malfunction occurred during FTL travel. Uniform attachments unavailable for use.</p>

/turf/open/floor/void
	name = "empty space"
	desc = "A dark surface with no reflection or sound. Darker than the black of the abyss."
	#ifdef CBT
	icon = null
	icon_state = ""
	color = "#000000"
	#else
	icon = 'icons/turf/floors/floors.dmi'
	icon_state = "floor"
	#endif

/turf/open/floor/void/get_examine_text(mob/user)
	. = list()
	if(desc)
		. += desc
	return .

/turf/closed/wall/indestructible/void
	name = "filled space"
	desc = "A dark, impermeable structure with no reflection or sound."
	#ifdef CBT
	icon = null
	icon_state = ""
	color = "#000000"
	#else
	icon = 'icons/turf/walls/walls.dmi'
	icon_state = "riveted"
	#endif

/turf/closed/wall/indestructible/void/get_examine_text(mob/user)
	. = list()
	if(desc)
		. += desc
	return .

/area/simulacrum
	name = "???"
	icon_state = "purple"
	requires_power = FALSE
	flags_area = AREA_NOTUNNEL|AREA_AVOID_BIOSCAN
	statistic_exempt = TRUE
	ceiling = CEILING_METAL
	unique = TRUE

	base_lighting_alpha = 255
	unlimited_power = TRUE

/area/simulacrum/desert
	name = "Barren Desert"
	ceiling = CEILING_NONE
	base_lighting_alpha = 230

/area/simulacrum/interior
	name = "Building Interior"
	base_lighting_alpha = 0

/area/simulacrum/interior/exterior
	name = "Building Exterior"
	icon_state = "blue"
	base_lighting_alpha = 0
	ceiling = CEILING_NONE

/obj/structure/simulacrum_device
	name = "strange device"
	icon = 'icons/artifacts.dmi'
	//bound_height = 64
	//bound_width = 64
	icon_state = ""
	desc = "An unknown monolith of dark metal, glowing with a curious light."
	light_color = "#aa23c5"
	light_power = 4
	light_range = 2
	pixel_x = -32
	pixel_y = -32
	indestructible = TRUE
	unacidable = TRUE
	density = TRUE
	opacity = TRUE
	var/overlay_iconstate = ""
	var/mutable_appearance/overlay_appearance

/obj/structure/simulacrum_device/Initialize(mapload, ...)
	. = ..()
	overlay_appearance = mutable_appearance(icon, overlay_iconstate)
	overlay_appearance.color = "#aa23c5"
	var/matrix/scale_matrix = new /matrix
	scale_matrix.Scale(3)
	//overlay_appearance.transform = scale_matrix
	transform = scale_matrix
	update_icon()

/obj/structure/simulacrum_device/update_icon()
	. = ..()
	overlays += overlay_appearance

/obj/structure/simulacrum_device/attack_alien(mob/living/carbon/xenomorph/M)
	return

/obj/structure/simulacrum_device/attackby(obj/item/O, mob/user)
	return

/obj/structure/simulacrum_device/attack_hand(mob/user)
	return

/obj/structure/simulacrum_device/tgui_interact(mob/user, datum/tgui/ui)
	return

/obj/structure/simulacrum_device/central
	icon_state = "ancient-4"
	overlay_iconstate = "ancient-4fx"

/obj/structure/simulacrum_device/central/destructable
	breakable = TRUE
	indestructible = FALSE
	unacidable = FALSE
	health = 4000
	debris = list(/obj/item/stack/sheet/mineral/chitin/metal)
	var/been_shot = FALSE

/obj/structure/simulacrum_device/central/destructable/get_examine_text(mob/user)
	. = ..()
	if(health > 3500)
		. += SPAN_BOLDNOTICE("It looks undamaged.")
	else if(health > 2500)
		. += SPAN_BOLDWARNING("It looks fairly damaged.")
	else if(health > 1000)
		. += SPAN_BOLDWARNING("It looks like it's falling apart!")

/obj/structure/simulacrum_device/central/destructable/bullet_act(obj/projectile/P)
	. = ..()
	health -= P.ammo.damage
	if(!been_shot)
		visible_message(SPAN_BOLDNOTICE("[src] lets out a small psychic groan as bullets chip away at its metal."))
		been_shot = TRUE
	if(health <= 0)
		handle_debris(0, 0)
		deconstruct(FALSE)

/obj/structure/simulacrum_device/central/destructable/handle_debris(severity = 0, direction = 0)
	visible_message(SPAN_NOTICE("[src] shatters to pieces, an unearthly low groan being the last noise it makes."))
	return ..()

/obj/structure/simulacrum_device/pillar
	icon_state = "ancient-2"
	overlay_iconstate = "ancient-2fx"


/obj/structure/vaultdoor
	name = "imposing door"
	desc = "An imposing vault door made out of a dark metal."
	icon = 'icons/obj/structures/doors/vault.dmi'
	icon_state = "door_valid"
	indestructible = TRUE
	unacidable = TRUE
	density = TRUE
	opacity = TRUE

/obj/structure/vaultdoor/attack_hand(mob/user)
	. = ..()
	to_chat(user, SPAN_NOTICE("You begin to go through the door..."))
	if(!do_after(user, 5 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		return

	to_chat(user, SPAN_NOTICE("You enter through the door into the pitch darkness. No going back now."))
	user.forceMove(locate(4, 165, 2))

/obj/structure/simulacrum_ladder
	name = "ladder"
	desc = "A sturdy metal ladder. There's sunshine coming down through the hole above."
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "ladder11"
	indestructible = TRUE
	unacidable = TRUE
	light_color = "#ffffff"
	light_power = 4
	light_range = 4

/obj/structure/simulacrum_ladder/attack_hand(mob/user)
	. = ..()
	to_chat(user, SPAN_NOTICE("You begin to go up the ladder..."))
	if(!do_after(user, 5 SECONDS, INTERRUPT_ALL, BUSY_ICON_GENERIC))
		return

	to_chat(user, SPAN_NOTICE("You go up the ladder, and out into the bright desert sun."))
	user.forceMove(locate(78, 106, 2))
