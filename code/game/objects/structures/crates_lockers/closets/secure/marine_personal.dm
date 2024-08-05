/obj/structure/closet/secure_closet/marine_personal
	name = "personal locker"
	desc = "It's an immobile card-locked storage unit."
	icon_state = "secure1"
	can_be_stacked = TRUE
	var/owner
	var/job = "Rifleman"
	var/has_cryo_gear = TRUE

/obj/structure/closet/secure_closet/marine_personal/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("It has a name tag[owner ? ": [owner]." : ". They are still in hypersleep..."]")

/obj/structure/closet/secure_closet/marine_personal/Initialize(mapload, ...)
	. = ..()
	GLOB.personal_closets += src

/obj/structure/closet/secure_closet/marine_personal/Destroy()
	GLOB.personal_closets -= src
	return ..()

/obj/structure/closet/secure_closet/marine_personal/allowed(mob/M)
	if(owner == M.real_name)
		return TRUE
	return FALSE

/obj/structure/closet/secure_closet/marine_personal/Initialize()
	. = ..()
	if(has_cryo_gear)
		new /obj/item/clothing/under/marine(src)
		new /obj/item/clothing/shoes/marine/knife(src)
		new /obj/item/device/radio/headset/almayer/marine(src)

/obj/structure/closet/secure_closet/marine_personal/storm_breaker
	has_cryo_gear = FALSE

/obj/structure/closet/secure_closet/marine_personal/storm_breaker/Initialize()
	. = ..()
	new /obj/item/clothing/under/marine(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/device/radio/headset/almayer/marine/bravo(src)
