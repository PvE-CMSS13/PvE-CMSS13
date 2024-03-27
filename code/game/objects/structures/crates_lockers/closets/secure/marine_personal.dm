/obj/structure/closet/secure_closet/marine_personal
	name = "personal locker"
	desc = "It's an immobile card-locked storage unit."
	icon_state = "secure1"
	can_be_stacked = TRUE
	var/owner
	var/job = "Rifleman"
	var/squad
	var/has_cryo_gear = TRUE
	var/headset_path = /obj/item/device/radio/headset/almayer/marine

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
	if(owner == M.name)
		return TRUE
	return FALSE

/obj/structure/closet/secure_closet/marine_personal/Initialize()
	. = ..()
	if(has_cryo_gear)
		new /obj/item/clothing/under/marine(src)
		new /obj/item/clothing/shoes/marine/knife(src)
		new headset_path(src)

/obj/structure/closet/secure_closet/marine_personal/uscm_ground
	density = FALSE
	has_cryo_gear = FALSE

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/marine
	has_cryo_gear = TRUE

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/marine/standard
	headset_path = /obj/item/device/radio/headset/uscm_ground/marine
	job = JOB_USCM_GROUND_SQUAD_MARINE

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/marine/gunner
	job = JOB_USCM_GROUND_SQUAD_SMARTGUNNER

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/marine/specialist
	job = JOB_USCM_GROUND_SQUAD_SPECIALIST

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/marine/medic
	headset_path = /obj/item/device/radio/headset/uscm_ground/marine/med
	job = JOB_USCM_GROUND_SQUAD_MEDIC

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/marine/team_leader
	headset_path = /obj/item/device/radio/headset/uscm_ground/marine/tl
	job = JOB_USCM_GROUND_SQUAD_TEAM_LEADER

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/platoon_lead
	job = JOB_USCM_GROUND_SQUAD_LEADER
	squad = SQUAD_USCM_GROUND_1
	headset_path = /obj/item/device/radio/headset/uscm_ground/marine/lead

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/platoon_lead/two
	squad = SQUAD_USCM_GROUND_2

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/platoon_lead/Initialize()
	. = ..()
	new /obj/item/weapon/gun/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/clothing/head/helmet/marine/leader(src)
	new /obj/item/device/binoculars/range/designator(src)
	new /obj/item/device/whistle(src)
	new /obj/item/device/flash(src)
	new /obj/item/clothing/head/drillhat(src)
	new headset_path(src)

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/captain
	job = JOB_USCM_GROUND_CO

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/captain/Initialize()
	. = ..()
	new /obj/item/handcuffs
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)
	new /obj/item/reagent_container/spray/pepper(src)

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/lieutenant
	job = JOB_USCM_GROUND_AO

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/lieutenant/Initialize()
	. = ..()
	new /obj/item/handcuffs
	new /obj/item/device/flash(src)
	new /obj/item/weapon/baton(src)

/obj/structure/closet/secure_closet/marine_personal/uscm_ground/civilian
	job = JOB_USCM_GROUND_CIVILIAN



