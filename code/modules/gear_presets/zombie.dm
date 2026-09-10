/datum/equipment_preset/zombie
	name = "Zombie - Template do not use"
	flags = EQUIPMENT_PRESET_EXTRA
	rank = FACTION_ZOMBIE
	languages = list("Zombie")
	skills = null //no restrictions
	faction = FACTION_ZOMBIE
	paygrades = PAY_NONE
	assignment = JOB_COLONIST

/datum/equipment_preset/zombie/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE, FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(21,45)

/datum/equipment_preset/zombie/load_id(mob/living/carbon/human/new_human, client/mob_client)
	var/obj/item/clothing/under/uniform = new_human.w_uniform
	if(istype(uniform))
		uniform.has_sensor = UNIFORM_HAS_SENSORS
		uniform.sensor_faction = FACTION_COLONIST
	new_human.job = "Zombie"
	new_human.faction = faction
	return ..()

/datum/equipment_preset/zombie/load_race(mob/living/carbon/human/new_human)
	new_human.set_species(SPECIES_HUMAN) // Set back, so that we can get our claws again
	new_human.set_species(SPECIES_ZOMBIE)
	new_human.zombie_delimb_chance_multi = GLOB.gm_set_zombie_delimb_multi ? GLOB.gm_set_zombie_delimb_multi : null
	if(GLOB.gm_set_zombie_random_helmet)
		GLOB.gm_set_zombie_helmet_chance = clamp(GLOB.gm_set_zombie_helmet_chance,0, 100)
		if(prob(GLOB.gm_set_zombie_helmet_chance))
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/zombie(new_human), WEAR_HEAD)
	if(GLOB.gm_set_zombie_disable_auto_clean)
		new_human.zombie_disable_auto_clean = TRUE

// Zombies
/datum/equipment_preset/zombie/generic
	name = "Zombie - Generic"

/datum/equipment_preset/zombie/generic/load_gear(mob/living/carbon/human/new_human)
	var/uniform_path = pick(/obj/item/clothing/under/colonist, /obj/item/clothing/under/colonist/ua_civvies, /obj/item/clothing/under/colonist/wy_davisone, /obj/item/clothing/under/colonist/wy_joliet_shopsteward, /obj/item/clothing/under/marine/ua_riot, /obj/item/clothing/under/suit_jacket/manager, /obj/item/clothing/under/suit_jacket/director)
	new_human.equip_to_slot_or_del(new uniform_path, WEAR_BODY)
	var/shoe_path = pick(/obj/item/clothing/shoes/laceup, /obj/item/clothing/shoes/leather, /obj/item/clothing/shoes/jackboots)
	new_human.equip_to_slot_or_del(new shoe_path, WEAR_FEET)

//--\\

/datum/equipment_preset/zombie/ua_marine
	name = "Zombie - USCM Marine"
	assignment = JOB_SQUAD_MARINE

/datum/equipment_preset/zombie/ua_marine/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	add_uscm_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

//--\\

/datum/equipment_preset/zombie/ua_marine_eva
	name = "Zombie - USCM EVA Marine"
	assignment = JOB_SQUAD_MARINE

/datum/equipment_preset/zombie/ua_marine_eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	add_uscm_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/uscm(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	//--\\

/datum/equipment_preset/zombie/bluecollar
	name = "Zombie - Blue-Collar"

/datum/equipment_preset/zombie/bluecollar/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Class D Inhabitant"

	return "Class C Inhabitant"

/datum/equipment_preset/zombie/bluecollar/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	add_civilian_jacket(new_human)
	//limbs
	add_civilian_shoe(new_human)

//UPP

/datum/equipment_preset/zombie/upp_rifleman
	name = "Zombie - UPP Squad Rifleman"
	assignment = JOB_SQUAD_MARINE_UPP

/datum/equipment_preset/zombie/upp_rifleman/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/high_explosive/upp/impact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/upp, WEAR_L_EAR)
	add_upp_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/standard, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/machete/arnold/weak, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

/datum/equipment_preset/zombie/upp_eva
	name = "Zombie - UPP EVA Marine"
	assignment = JOB_SQUAD_MARINE_UPP

/datum/equipment_preset/zombie/upp_eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/high_explosive/upp/impact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/upp, WEAR_L_EAR)
	//uniform
	add_upp_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/upp, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/machete/arnold/weak, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

/datum/equipment_preset/zombie/upp_colonist
	name = "Zombie - UPP Civilian"
	idtype = /obj/item/card/id

/datum/equipment_preset/zombie/upp_colonist/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	add_civilian_jacket(new_human)
	//limbs
	var/random_civilian_shoe = rand(1,7)
	switch(random_civilian_shoe)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
		if(3 to 4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/brown(new_human), WEAR_FEET)
		if(6)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian(new_human), WEAR_FEET)
		if(7)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)

//W-Y

/datum/equipment_preset/zombie/pmc_standard
	name = "Zombie - PMC"
	assignment = JOB_PMC_STANDARD

/datum/equipment_preset/zombie/pmc_standard/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//uniform
	var/obj/item/clothing/under/marine/veteran/pmc/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/black_vest, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer, WEAR_IN_ACCESSORY)
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/pmc, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/pmc/light, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

/datum/equipment_preset/zombie/researcher
	name = "Zombie - Researcher"
	assignment = JOB_RESEARCHER

/datum/equipment_preset/zombie/researcher/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress, WEAR_L_EAR)
	//uniform
	add_professionalwear(new_human)
	var/random_tie= rand(1,5)
	switch(random_tie)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/black(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue(new_human), WEAR_ACCESSORY)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/green(new_human), WEAR_ACCESSORY)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/purple(new_human), WEAR_ACCESSORY)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/red(new_human), WEAR_ACCESSORY)
	//jacket
	var/random_researcher_suit = rand(1,5)
	switch(random_researcher_suit)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat(new_human), WEAR_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/tan(new_human), WEAR_JACKET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest(new_human), WEAR_JACKET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/vest/grey(new_human), WEAR_JACKET)
	//limb
	add_dress_shoes(new_human)

/datum/equipment_preset/zombie/cmb
	name = "Zombie - CMB"
	assignment = JOB_CMB

/datum/equipment_preset/zombie/cmb/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/lamp, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

/datum/equipment_preset/zombie/guard
	name = "Zombie - US Colonial Guard"
	assignment = JOB_UACG_RIFLE

/datum/equipment_preset/zombie/guard/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/guard, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/khaki, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e2, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)

/datum/equipment_preset/zombie/canc
	name = "Zombie - CANC"
	assignment = "Rifleman"

/datum/equipment_preset/zombie/canc/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	if(prob(65))
		add_neckerchief(new_human)
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/upp(new_human), WEAR_R_STORE)


/datum/equipment_preset/zombie/cbrn
	name = "Zombie - USCM CBRN"
	assignment = JOB_SQUAD_MARINE_UPP

/datum/equipment_preset/zombie/cbrn/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/cbrn(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/pve_mopp(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/cbrn(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/cbrn(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/mopp(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/five_slots(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert(new_human), WEAR_L_STORE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full/toxin(new_human), WEAR_L_STORE)

	switch(pick("flamethrower", "mk2"))
		if("flamethrower")
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/flamethrower/kit(new_human), WEAR_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank(new_human), WEAR_IN_BACK)

		if("mk2")
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ap(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/device/analyzer(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/device/reagent_scanner(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/prop/geiger_counter(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/reagent_container/spray/cleaner(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/bodybag(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/bodybag(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/bodybag(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/bodybag(new_human), WEAR_IN_BACK)
