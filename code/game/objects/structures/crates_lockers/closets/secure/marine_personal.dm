/obj/structure/closet/secure_closet/marine_personal
	name = "personal locker"
	desc = "It's an immobile card-locked storage unit."
	icon_state = "secure1"
	can_be_stacked = TRUE
	var/owner
	var/has_cryo_gear = TRUE

	var/job = "DO NOT USE!!!"
	var/x_to_linked_spawn_turf
	var/y_to_linked_spawn_turf
	var/turf/linked_spawn_turf

/obj/structure/closet/secure_closet/marine_personal/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("It has a name tag[owner ? ": [owner]." : ". They are still in hypersleep..."]")

/obj/structure/closet/secure_closet/marine_personal/Initialize(mapload, ...)
	. = ..()
	GLOB.personal_closets += src

	if(x_to_linked_spawn_turf || y_to_linked_spawn_turf)
		linked_spawn_turf = locate(x + x_to_linked_spawn_turf, y + y_to_linked_spawn_turf, z)

	if(has_cryo_gear)
		spawn_gear()

/obj/structure/closet/secure_closet/marine_personal/Destroy()
	GLOB.personal_closets -= src
	return ..()

/obj/structure/closet/secure_closet/marine_personal/allowed(mob/M)
	if(owner == M.real_name)
		return TRUE
	return FALSE

// ==USCM Standard== //

/obj/structure/closet/secure_closet/marine_personal/proc/spawn_gear()
	new /obj/item/clothing/under/marine(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils(src)

/obj/structure/closet/secure_closet/marine_personal/rifleman
	job = JOB_SQUAD_MARINE

/obj/structure/closet/secure_closet/marine_personal/smartgunner
	job = JOB_SQUAD_SMARTGUN

/obj/structure/closet/secure_closet/marine_personal/corpsman
	job = JOB_SQUAD_MEDIC

/obj/structure/closet/secure_closet/marine_personal/squad_leader
	job = JOB_SQUAD_TEAM_LEADER

/obj/structure/closet/secure_closet/marine_personal/platoon_leader
	job = JOB_SQUAD_LEADER

/obj/structure/closet/secure_closet/marine_personal/platoon_leader/spawn_gear()
	new /obj/item/clothing/under/marine(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/seclead(src)

/obj/structure/closet/secure_closet/marine_personal/platoon_commander
	job = JOB_SO

/obj/structure/closet/secure_closet/marine_personal/platoon_commander/spawn_gear()
	new /obj/item/clothing/under/marine(src)
	new /obj/item/clothing/under/marine/officer/boiler(src)
	new /obj/item/clothing/head/cmcap/bridge(src)
	new /obj/item/clothing/suit/storage/jacket/marine/service(src)
	new /obj/item/clothing/under/marine/officer/bridge(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/head/marine/peaked/service(src)
	new /obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/pltco(src)

// ==UPP== //

/obj/structure/closet/secure_closet/marine_personal/upp/spawn_gear()
	new /obj/item/clothing/head/uppcap/beret/naval(src)
	new /obj/item/clothing/under/marine/veteran/UPP(src)
	new /obj/item/clothing/shoes/marine/upp(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/upp(src)

/obj/structure/closet/secure_closet/marine_personal/upp/rifleman
	job = JOB_SQUAD_MARINE

/obj/structure/closet/secure_closet/marine_personal/upp/smartgunner
	job = JOB_SQUAD_SMARTGUN

/obj/structure/closet/secure_closet/marine_personal/upp/corpsman
	job = JOB_SQUAD_MEDIC

/obj/structure/closet/secure_closet/marine_personal/upp/squad_leader
	job = JOB_SQUAD_TEAM_LEADER

/obj/structure/closet/secure_closet/marine_personal/upp/platoon_leader
	job = JOB_SQUAD_LEADER

/obj/structure/closet/secure_closet/marine_personal/upp/platoon_commander
	job = JOB_SO

/obj/structure/closet/secure_closet/marine_personal/upp/platoon_commander/spawn_gear()
	new /obj/item/clothing/head/uppcap/beret/naval(src)
	new /obj/item/clothing/under/marine/veteran/UPP/naval(src)
	new /obj/item/clothing/shoes/marine/upp(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/upp(src)
	new /obj/item/clothing/suit/storage/jacket/marine/upp/naval(src)
	new /obj/item/clothing/suit/storage/jacket/marine/upp(src)

// ==USCM FORECON== //

/obj/structure/closet/secure_closet/marine_personal/forecon/spawn_gear()
	new /obj/item/clothing/under/marine/standard(src)
	new /obj/item/clothing/shoes/marine/knife(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/forecon(src)

/obj/structure/closet/secure_closet/marine_personal/forecon/rifleman
	job = JOB_SQUAD_MARINE

/obj/structure/closet/secure_closet/marine_personal/forecon/smartgunner
	job = JOB_SQUAD_SMARTGUN

/obj/structure/closet/secure_closet/marine_personal/forecon/corpsman
	job = JOB_SQUAD_MEDIC

/obj/structure/closet/secure_closet/marine_personal/forecon/squad_leader
	job = JOB_SQUAD_TEAM_LEADER

/obj/structure/closet/secure_closet/marine_personal/forecon/platoon_leader
	job = JOB_SQUAD_LEADER

/obj/structure/closet/secure_closet/marine_personal/forecon/rto
	job = JOB_SQUAD_RTO

// ==WY PMC== //

/obj/structure/closet/secure_closet/marine_personal/pmc/spawn_gear()
	new /obj/item/clothing/under/marine/veteran/pmc(src)
	new /obj/item/device/radio/headset/distress/pmc/platoon(src)
	new /obj/item/clothing/shoes/marine/civilian/knife(src)

/obj/structure/closet/secure_closet/marine_personal/pmc/rifleman
	job = JOB_SQUAD_MARINE

/obj/structure/closet/secure_closet/marine_personal/pmc/smartgunner
	job = JOB_SQUAD_SMARTGUN

/obj/structure/closet/secure_closet/marine_personal/pmc/corpsman
	job = JOB_SQUAD_MEDIC

/obj/structure/closet/secure_closet/marine_personal/pmc/squad_leader
	job = JOB_SQUAD_TEAM_LEADER

/obj/structure/closet/secure_closet/marine_personal/pmc/platoon_leader
	job = JOB_SQUAD_LEADER

/obj/structure/closet/secure_closet/marine_personal/pmc/platoon_commander
	job = JOB_SO

/obj/structure/closet/secure_closet/marine_personal/pmc/platoon_commander/spawn_gear()
	new /obj/item/clothing/head/beret/pmc(src)
	new /obj/item/clothing/under/liaison_suit/formal(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/device/radio/headset/distress/pmc/platoon/cmd(src)
	new /obj/item/clothing/suit/storage/jacket/marine/corporate/formal(src)

// ==Royal Marines== //

/obj/structure/closet/secure_closet/marine_personal/rmc/spawn_gear()
	new /obj/item/clothing/head/cmcap/royal_marine(src)
	new /obj/item/clothing/under/marine/veteran/royal_marine(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/rmc(src)
	new /obj/item/clothing/shoes/marine/rmc/knife(src)

/obj/structure/closet/secure_closet/marine_personal/rmc/troop_commander/spawn_gear()
	new /obj/item/clothing/head/cmcap/royal_marine(src)
	new /obj/item/clothing/under/marine/veteran/royal_marine/lt(src)
	new /obj/item/clothing/accessory/ranks/rmc/o1(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/rmc(src)
	new /obj/item/clothing/shoes/marine/rmc/knife(src)

/obj/structure/closet/secure_closet/marine_personal/rmc/rifleman
	job = JOB_TWE_RMC_RIFLEMAN

/obj/structure/closet/secure_closet/marine_personal/rmc/smartgunner
	job = JOB_TWE_RMC_SMARTGUNNER

/obj/structure/closet/secure_closet/marine_personal/rmc/marksman
	job = JOB_TWE_RMC_MARKSMAN

/obj/structure/closet/secure_closet/marine_personal/rmc/medic
	job = JOB_TWE_RMC_MEDIC

/obj/structure/closet/secure_closet/marine_personal/rmc/engi
	job = JOB_TWE_RMC_ENGI

/obj/structure/closet/secure_closet/marine_personal/rmc/gunner
	job = JOB_TWE_RMC_BREACHER

/obj/structure/closet/secure_closet/marine_personal/rmc/team_leader
	job = JOB_TWE_RMC_TEAMLEADER

/obj/structure/closet/secure_closet/marine_personal/rmc/section_leader
	job = JOB_TWE_RMC_SECTIONLEADER

/obj/structure/closet/secure_closet/marine_personal/rmc/troop_leader
	job = JOB_TWE_RMC_TROOPLEADER

/obj/structure/closet/secure_closet/marine_personal/rmc/troop_commander
	job = JOB_TWE_RMC_LIEUTENANT

//UACG

/obj/structure/closet/secure_closet/marine_personal/uacg/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle1
	job = JOB_UACG_RIFLE

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle2
	job = JOB_UACG_RIFLE

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/white(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle3
	job = JOB_UACG_RIFLE

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle3/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/black(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle4
	job = JOB_UACG_RIFLE

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle4/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/inverted(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle1/security
	job = JOB_UACG_SCR_RIFLE

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle1/security/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/small(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/inverted(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/belt/security/MP/colonist(src)
	new /obj/item/prop/helmetgarb/riot_shield(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle1/armory
	job = JOB_UACG_ARMORY_LACKEY

/obj/structure/closet/secure_closet/marine_personal/uacg/rifle1/armory/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/pouch/tools/pfc(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/prop/helmetgarb/gunoil(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/zippo/gold(src)
	new /obj/item/storage/fancy/cigarettes/arcturian_ace(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/marksman1
	job = JOB_UACG_DM

/obj/structure/closet/secure_closet/marine_personal/uacg/marksman1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/device/binoculars(src)
	new /obj/item/storage/box/packet/smoke(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/marksman2
	job = JOB_UACG_DM

/obj/structure/closet/secure_closet/marine_personal/uacg/marksman2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/white(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/device/binoculars(src)
	new /obj/item/storage/box/packet/smoke(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/gunner1
	job = JOB_UACG_GNR

/obj/structure/closet/secure_closet/marine_personal/uacg/gunner1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/heavy(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/device/binoculars(src)
	new /obj/item/storage/box/packet/smoke(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/gunner2
	job = JOB_UACG_GNR

/obj/structure/closet/secure_closet/marine_personal/uacg/gunner2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/heavy/black(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/storage/pouch/magazine/pistol(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/gunner1/security
	job = JOB_UACG_SCR_GNR

/obj/structure/closet/secure_closet/marine_personal/uacg/gunner1/security/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/m40(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/heavy(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/belt/security/MP/colonist(src)
	new /obj/item/prop/helmetgarb/riot_shield(src)
	new /obj/item/device/binoculars(src)
	new /obj/item/storage/box/packet/smoke(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/medic1
	job = JOB_UACG_MEDIC

/obj/structure/closet/secure_closet/marine_personal/uacg/medic1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/medic(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/storage/smallpouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic(src)
	new /obj/item/storage/pouch/sling/medic(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/medic2
	job = JOB_UACG_MEDIC

/obj/structure/closet/secure_closet/marine_personal/uacg/medic2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/medic(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/storage/smallpouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic2(src)
	new /obj/item/storage/pouch/sling/medic(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/medic3
	job = JOB_UACG_MEDIC

/obj/structure/closet/secure_closet/marine_personal/uacg/medic3/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/secondsquad/medic(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/storage/smallpouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic(src)
	new /obj/item/storage/pouch/sling/medic(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/medic4
	job = JOB_UACG_MEDIC

/obj/structure/closet/secure_closet/marine_personal/uacg/medic4/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/secondsquad/medic(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/storage/smallpouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic2(src)
	new /obj/item/storage/pouch/sling/medic(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/triagemedic1
	job = JOB_UACG_MEDIC_TRIAGE

/obj/structure/closet/secure_closet/marine_personal/uacg/triagemedic1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/triage(src)
	new /obj/item/clothing/accessory/storage/smallpouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/small(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic(src)
	new /obj/item/storage/pouch/sling/medic(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/triagemedic2
	job = JOB_UACG_MEDIC_TRIAGE

/obj/structure/closet/secure_closet/marine_personal/uacg/triagemedic2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/triage(src)
	new /obj/item/clothing/accessory/storage/smallpouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/small(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic2(src)
	new /obj/item/storage/pouch/sling/medic(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/tech1
	job = JOB_UACG_TECH

/obj/structure/closet/secure_closet/marine_personal/uacg/tech1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/sapper(src)
	new /obj/item/storage/internal/accessory/smallpouch/full(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/tools/pfc(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard(src)
	new /obj/item/storage/pouch/etool/uacg/full(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/tech2
	job = JOB_UACG_TECH

/obj/structure/closet/secure_closet/marine_personal/uacg/tech2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/sapper(src)
	new /obj/item/storage/internal/accessory/smallpouch/full(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/tools/pfc(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/white(src)
	new /obj/item/storage/pouch/etool/uacg/full(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/tech3
	job = JOB_UACG_TECH

/obj/structure/closet/secure_closet/marine_personal/uacg/tech3/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/sapper(src)
	new /obj/item/storage/internal/accessory/smallpouch/full(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/tools/pfc(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/black(src)
	new /obj/item/storage/pouch/etool/uacg/full(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/tech4
	job = JOB_UACG_TECH

/obj/structure/closet/secure_closet/marine_personal/uacg/tech4/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/clothing/accessory/patch/army/sapper(src)
	new /obj/item/storage/internal/accessory/smallpouch/full(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/tools/pfc(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/inverted(src)
	new /obj/item/storage/pouch/etool/uacg/full(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/tech1/mortar1
	job = JOB_UACG_MORTAR

/obj/structure/closet/secure_closet/marine_personal/uacg/tech1/mortar1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/fires(src)
	new /obj/item/clothing/accessory/patch/army/mortar(src)
	new /obj/item/clothing/accessory/storage/smallpouch/full(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/tools/pfc(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard(src)
	new /obj/item/storage/pouch/etool/uacg/full(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/belt/gun/mortarbelt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/tech1/mortar2
	job = JOB_UACG_MORTAR

/obj/structure/closet/secure_closet/marine_personal/uacg/tech1/mortar2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/fires(src)
	new /obj/item/clothing/accessory/patch/army/mortar(src)
	new /obj/item/clothing/accessory/storage/smallpouch/full(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/tools/tactical/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/white(src)
	new /obj/item/storage/pouch/etool/uacg/full(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/belt/gun/mortarbelt(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/lead1
	job = JOB_UACG_LEAD

/obj/structure/closet/secure_closet/marine_personal/uacg/lead1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/lead2
	job = JOB_UACG_LEAD

/obj/structure/closet/secure_closet/marine_personal/uacg/lead2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/white(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/lead3
	job = JOB_UACG_LEAD

/obj/structure/closet/secure_closet/marine_personal/uacg/lead3/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/secondsquad(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/black(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/lead4
	job = JOB_UACG_LEAD

/obj/structure/closet/secure_closet/marine_personal/uacg/lead4/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/secondsquad(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/inverted(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/lead1/fires
	job = JOB_UACG_LEAD_FIRE

/obj/structure/closet/secure_closet/marine_personal/uacg/lead1/fires/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/fires/lead(src)
	new /obj/item/clothing/accessory/patch/army/mortar(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/lead1/triage
	job = JOB_UACG_LEAD_MED

/obj/structure/closet/secure_closet/marine_personal/uacg/lead1/triage/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/triage(src)
	new /obj/item/clothing/accessory/patch/medic(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/medic2(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel(src)
	new /obj/item/storage/belt/gun/m39(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/tool/lighter/random(src)
	new /obj/item/storage/fancy/cigarettes(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead1
	job = JOB_UACG_SENLEAD

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead1/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/senlead(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/senlead(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel/rto(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/device/binoculars/range/designator(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead2
	job = JOB_UACG_SENLEAD

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead2/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacg/secondsquad/senlead(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/holster/waist(src)
	new /obj/item/clothing/accessory/storage/webbing/m3/mag(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/senlead/black(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/backpack/marine/satchel/rto(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)
	new /obj/item/device/binoculars/range/designator(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead1/chaplain
	job = JOB_UACG_CHAPLAIN

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead1/chaplain/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacgofficer(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/droppouch(src)
	new /obj/item/clothing/accessory/storage/webbing/m3(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/box/guncase/uacg/standard/chaplain(src)
	new /obj/item/storage/pouch/flare(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/backpack/general_belt(src)
	new /obj/item/attachable/sling(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead1/armorer
	job = JOB_UACG_ARMORY

/obj/structure/closet/secure_closet/marine_personal/uacg/senlead1/armorer/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacgofficer(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/clothing/accessory/storage/droppouch(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/pouch/magazine/large(src)
	new /obj/item/clothing/suit/storage/jacket/marine/bomber/pretty(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/storage/pouch/flare(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/tool/lighter/zippo/gold(src)
	new /obj/item/storage/fancy/cigarettes/laika(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/officer
	job = JOB_UACG_OFFICER

/obj/structure/closet/secure_closet/marine_personal/uacg/officer/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacgofficer(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/clothing/suit/storage/jacket/marine/bomber(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/belt/gun/m4a3(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/officer/doctor
	job = JOB_UACG_DOCTOR

/obj/structure/closet/secure_closet/marine_personal/uacg/officer/doctor/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacgofficer/doctor(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/storage/pouch/medkit/full(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/clothing/suit/storage/labcoat(src)
	new /obj/item/storage/belt/gun/m4a3(src)
	new /obj/item/storage/pouch/sling/medic(src)

/obj/structure/closet/secure_closet/marine_personal/uacg/officer/mess
	job = JOB_UACG_MESS

/obj/structure/closet/secure_closet/marine_personal/uacg/officer/mess/spawn_gear()
	new /obj/item/clothing/glasses/mgoggles/uacg(src)
	new /obj/item/clothing/mask/rebreather/scarf(src)
	new /obj/item/device/radio/headset/almayer/marine/solardevils/uacgofficer(src)
	new /obj/item/clothing/accessory/patch/army/infantry(src)
	new /obj/item/storage/pouch/firstaid/full/alternate(src)
	new /obj/item/storage/box/mre(src)
	new /obj/item/device/flashlight/combat(src)
	new /obj/item/clothing/suit/storage/jacket/marine/vest(src)
	new /obj/item/storage/pouch/magazine(src)
	new /obj/item/storage/belt/gun/m4a3(src)
