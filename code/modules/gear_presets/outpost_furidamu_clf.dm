///*****************************LV-522 Force Recon Survivors*******************************************************/
//Nanu told me to put them here so they dont clutter up survivors.dm

/datum/equipment_preset/survivor/furidamu_clf
	idtype = /obj/item/card/id/dogtag
	rank = JOB_SURVIVOR
	faction_group = list(FACTION_SURVIVOR)
	flags = EQUIPMENT_PRESET_START_OF_ROUND
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
	)

/datum/equipment_preset/survivor/furidamu_clf/load_gear(mob/living/carbon/human/H)
	var/obj/item/clothing/under/colonist/clf/uniform = new()
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	uniform.attach_accessory(H,pouch)
	H.equip_to_slot_or_del(uniform, WEAR_BODY)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/webbing(H), WEAR_JACKET)
	H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(H), WEAR_BACK)
	H.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(H), WEAR_R_STORE)
	H.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(H), WEAR_L_STORE)
	H.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(H), WEAR_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/facepaint/sniper(H), WEAR_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE(H), WEAR_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/device/flashlight(H), WEAR_J_STORE)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(H), WEAR_IN_JACKET)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(H), WEAR_FEET)
	H.equip_to_slot_or_del(new /obj/item/device/radio(H), WEAR_IN_BACK)

/datum/equipment_preset/survivor/furidamu_clf/add_survivor_weapon_security(mob/living/carbon/human/H)
	return

/datum/equipment_preset/survivor/furidamu_clf/proc/add_furidamu_weapon(mob/living/carbon/human/H)
	var/random_gun = rand(1,3)
	switch(random_gun)
		if(1 , 2)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a(H), WEAR_L_HAND)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle(H), WEAR_IN_BACK)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle(H), WEAR_IN_BACK)
		if(3)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/type71/rifleman(H), WEAR_L_HAND)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71(H), WEAR_IN_BACK)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71(H), WEAR_IN_BACK)

/datum/equipment_preset/survivor/furidamu_clf/add_survivor_weapon_pistol(mob/living/carbon/human/H)
	return

/datum/equipment_preset/survivor/furidamu_clf/proc/add_furidamu_weapon_secondary(mob/living/carbon/human/H)
	var/random_pistol = rand(1,5)
	switch(random_pistol)
		if(1 , 2)
			H.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3(H), WEAR_WAIST)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(H), WEAR_IN_BELT)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(H), WEAR_IN_BELT)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(H), WEAR_IN_BELT)
		if(3 , 4)
			H.equip_to_slot_or_del(new /obj/item/storage/large_holster/m39, WEAR_WAIST)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39(H), WEAR_IN_BELT)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended(H), WEAR_IN_BACK)
			H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/extended(H), WEAR_IN_BACK)
		if(5)
			H.equip_to_slot_or_del(new /obj/item/device/motiondetector(H),WEAR_WAIST)

/datum/equipment_preset/survivor/furidamu_clf/add_random_survivor_equipment(mob/living/carbon/human/H)
	return

/datum/equipment_preset/survivor/furidamu_clf/proc/add_furidamu_equipment(mob/living/carbon/human/H)
	var/random_equipment = rand(1,3)
	switch(random_equipment)
		if(1)
			H.equip_to_slot_or_del(new /obj/item/device/walkman(H), WEAR_IN_BACK)
			H.equip_to_slot_or_del(new /obj/item/device/cassette_tape/indie(H), WEAR_IN_BACK)
		if(2)
			H.equip_to_slot_or_del(new /obj/item/toy/deck(H), WEAR_IN_ACCESSORY)
		if(3)
			H.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes(H), WEAR_IN_ACCESSORY)

/datum/equipment_preset/survivor/furidamu_clf/proc/spawn_random_headgear(mob/living/carbon/human/H)
	var/i = rand(1,10)
	switch(i)
		if (1 , 2)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap(H), WEAR_HEAD)
		if (3 , 4)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/gray(H), WEAR_HEAD)
		if (5 , 6)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/skullcap(H), WEAR_HEAD)
		if (7 , 8)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/headband/rebel(H), WEAR_HEAD)
		if (9)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/upp(H), WEAR_HEAD)

/datum/equipment_preset/survivor/furidamu_clf/standard
	name = "Survivor - Furidamu CLF Standard"
	assignment = "Colonial Liberation Front Militiaman"
	skills = /datum/skills/clf

/datum/equipment_preset/survivor/forecon/standard/load_gear(mob/living/carbon/human/H)
	..()
	add_furidamu_weapon_secondary(H)
	add_furidamu_weapon(H)
	spawn_random_headgear(H)
	add_furidamu_equipment(H)

///*****************************//

/datum/equipment_preset/survivor/furidamu_clf/breacher
	name = "Survivor - Furidamu CLF Breacher"
	assignment = "Colonial Liberation Front Pointman"
	skills = /datum/skills/clf

/datum/equipment_preset/survivor/forecon/tech/load_gear(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/big(H), WEAR_BACK)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/insulated(H), WEAR_HANDS)
	H.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(H), WEAR_WAIST)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(H), WEAR_EYES)
	..()
	H.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(H), WEAR_WAIST)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini(H), WEAR_IN_BACK)
	H.equip_to_slot_or_del(new /obj/item/device/defibrillator(H), WEAR_IN_BACK)
	H.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(H), WEAR_IN_BACK)
	H.equip_to_slot_or_del(new /obj/item/device/healthanalyzer(H), WEAR_IN_BACK)
	add_furidamu_weapon(H)
	spawn_random_headgear(H)
	add_furidamu_equipment(H)

///*****************************//

/datum/equipment_preset/survivor/furidamu_clf/sniper
	name = "Survivor - Furidamu CLF Sniper"
	assignment = "Colonial Liberation Front Marksman"
	skills = /datum/skills/clf

/datum/equipment_preset/survivor/forecon/marksman/load_gear(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m4ra_custom(H), WEAR_L_HAND)
	..()
	add_furidamu_weapon_secondary(H)
	spawn_random_headgear(H)
	add_furidamu_equipment(H)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m4ra/custom(H), WEAR_IN_BACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m4ra/custom(H), WEAR_IN_BACK)

///*****************************//

/datum/equipment_preset/survivor/furidamu_clf/captain
	name = "Survivor - Furidamu CLF Captain"
	assignment = "Colonial Liberation Front Captain"
	skills = /datum/skills/clf

/datum/equipment_preset/survivor/forecon/smartgunner/load_gear(mob/living/carbon/human/H)
	H.equip_to_slot_or_del(new /obj/item/smartgun_powerpack(H), WEAR_R_HAND)
	..()
	H.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner(H), WEAR_WAIST)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(H), WEAR_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(H), WEAR_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(H), WEAR_IN_BELT)
	add_furidamu_weapon(H)
	spawn_random_headgear(H)
	add_furidamu_equipment(H)

//---------------------------\\

/datum/equipment_preset/survivor/furidamu_clf/spetsnaz/leader
	name = "Survivor CO - Furidamu UPP Advisor"
	assignment = "Furidamu Military Attache"
	skills = /datum/skills/upp/commander
	paygrade = "UO3"
	idtype = /obj/item/card/id/gold
	role_comm_title = "May."

/datum/equipment_preset/survivor/forecon/major/load_gear(mob/living/carbon/human/H)
	var/obj/item/clothing/under/marine/veteran/UPP/officer/uniform = new()
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	uniform.attach_accessory(H,pouch)
	H.equip_to_slot_or_del(uniform, WEAR_BODY)
	H.equip_to_slot_or_del(new /obj/item/storage/belt/gun/type47/pk9(H), WEAR_WAIST)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/beret(H), WEAR_HEAD)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/windbreaker/windbreaker_green(H), WEAR_JACKET)
	..()
//----------------------\\
