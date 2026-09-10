/datum/equipment_preset/canc/remnant/old
	name = "CANC Reservist (Dog War)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Rifleman"

/datum/equipment_preset/canc/remnant/old/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	var/random_yummers = pick(/obj/item/reagent_container/food/drinks/cans/food/upp/soup, /obj/item/reagent_container/food/drinks/cans/food/upp/stew, /obj/item/reagent_container/food/drinks/cans/food/upp/speck)
	new_human.equip_to_slot_or_del(new random_yummers(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/random_neckwear_canc = rand(1,4)
	switch(random_neckwear_canc)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/red(new_human), WEAR_FACE)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red(new_human), WEAR_FACE)
	//head
	var/random_headwear = rand(1, 6)
	switch(random_headwear)
		if(1 to 4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc/old(new_human), WEAR_HEAD)
		if(5)
			var/random_hat = pick(/obj/item/clothing/head/uppcap/boonie/canc, /obj/item/clothing/head/cmcap/flap/canc, /obj/item/clothing/head/headband/red)
			new_human.equip_to_slot_or_del(new random_hat(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC/old(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_R_STORE)
	var/l_store = pick(/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless)
	new_human.equip_to_slot_or_del(new l_store, WEAR_L_STORE)
	if(prob(25))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l42a/abr40/canc/infantry(new_human), WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type40, WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type40, WEAR_IN_BELT)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/pps43/flashlight(new_human), WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/pps43, WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/pps43, WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/pps43, WEAR_IN_BELT)
	if(prob(30))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles/orange(new_human), WEAR_IN_HELMET)

/datum/equipment_preset/canc/remnant/old/leader
	name = "CANC Squad Leader (Dog War)"
	paygrades = list(PAY_SHORT_CA4 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/leader/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto/canc(new_human), WEAR_BACK)
	var/random_yummers = pick(/obj/item/reagent_container/food/drinks/cans/food/upp/soup, /obj/item/reagent_container/food/drinks/cans/food/upp/stew, /obj/item/reagent_container/food/drinks/cans/food/upp/speck)
	new_human.equip_to_slot_or_del(new random_yummers(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener/compact(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)

	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/random_neckwear_canc = rand(1,4)
	switch(random_neckwear_canc)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/red(new_human), WEAR_FACE)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red(new_human), WEAR_FACE)
	//head
	if(prob(25))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc(new_human), WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/canc(new_human), WEAR_IN_BACK)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/canc(new_human), WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc(new_human), WEAR_IN_BACK)

	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/upp, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/map, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e4(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_R_STORE)
	var/l_store = pick(/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless)
	new_human.equip_to_slot_or_del(new l_store, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lw317(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)

/datum/equipment_preset/canc/remnant/old/medic
	name = "CANC Reservist Medic (Dog War)"
	assignment = "Medic"
	paygrades = list(PAY_SHORT_CA2 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	var/random_yummers = pick(/obj/item/reagent_container/food/drinks/cans/food/upp/soup, /obj/item/reagent_container/food/drinks/cans/food/upp/stew, /obj/item/reagent_container/food/drinks/cans/food/upp/speck)
	var/random_yummers2 = pick(/obj/item/reagent_container/food/drinks/cans/food/upp/soup, /obj/item/reagent_container/food/drinks/cans/food/upp/stew, /obj/item/reagent_container/food/drinks/cans/food/upp/speck)
	new_human.equip_to_slot_or_del(new random_yummers(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new random_yummers2(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/blood/saline(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/blood/saline(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/random_neckwear_canc = rand(1,4)
	switch(random_neckwear_canc)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/red(new_human), WEAR_FACE)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red(new_human), WEAR_FACE)
	//head
	var/random_headwear = pick(/obj/item/clothing/head/helmet/marine/veteran/canc/old, /obj/item/clothing/head/cmcap/flap/canc)
	new_human.equip_to_slot_or_del(new random_headwear(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/armband/med(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC/old(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/advanced/bruise_pack, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/pps43/extended_mag(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/advanced/bruise_pack, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/advanced/ointment, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/splint, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/bicaridine, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/hypospray/autoinjector/tramadol, WEAR_IN_BELT)
	if(prob(30))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles/orange(new_human), WEAR_IN_HELMET)

/datum/equipment_preset/canc/remnant/old/marksman
	name = "CANC Reservist Marksman (Dog War)"
	assignment = "Marksman"
	paygrades = list(PAY_SHORT_CA2 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/marksman/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l42a/abr40/canc(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/random_neckwear_canc = rand(1,4)
	switch(random_neckwear_canc)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/red(new_human), WEAR_FACE)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red(new_human), WEAR_FACE)
	//head
	var/random_headwear = rand(1, 6)
	switch(random_headwear)
		if(1 to 5)
			var/random_hat = pick(/obj/item/clothing/head/uppcap/boonie/canc, /obj/item/clothing/head/cmcap/flap/canc, /obj/item/clothing/head/headband/red)
			new_human.equip_to_slot_or_del(new random_hat(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC/old(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_R_STORE)
	var/l_store = pick(/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless)
	new_human.equip_to_slot_or_del(new l_store, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/upp(new_human), WEAR_J_STORE)
	var/random_yummers = pick(/obj/item/reagent_container/food/drinks/cans/food/upp/soup, /obj/item/reagent_container/food/drinks/cans/food/upp/stew, /obj/item/reagent_container/food/drinks/cans/food/upp/speck)
	new_human.equip_to_slot_or_del(new random_yummers(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type40/ap, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type40/ap, WEAR_IN_BELT)
	if(prob(30))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles/orange(new_human), WEAR_IN_HELMET)

/datum/equipment_preset/canc/remnant/old/marksman/ghillie
	name = "CANC Reservist Marksman (Dog War, Ghillied Up)"
	assignment = "Marksman"
	paygrades = list(PAY_SHORT_CA3 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/marksman/ghillie/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/l42a/abr40/canc(new_human), WEAR_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/obj/item/facepaint/sniper/paint = new()
	paint.paint_face(new_human, new_human)
	qdel(paint)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc/ghillie(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch/upp, WEAR_ACCESSORY)
	var/random_yummers = pick(/obj/item/reagent_container/food/drinks/cans/food/upp/soup, /obj/item/reagent_container/food/drinks/cans/food/upp/stew, /obj/item/reagent_container/food/drinks/cans/food/upp/speck)
	new_human.equip_to_slot_or_del(new random_yummers(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/stack/medical/bruise_pack, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/ghillie/canc(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	var/l_store = pick(/obj/item/reagent_container/hypospray/autoinjector/tricord/skillless, /obj/item/reagent_container/hypospray/autoinjector/bicaridine/skillless, /obj/item/reagent_container/hypospray/autoinjector/tramadol/skillless)
	new_human.equip_to_slot_or_del(new l_store, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type40/ap, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type40/ap, WEAR_IN_R_STORE)

/datum/equipment_preset/canc/remnant/old/commando
	name = "CANC Commando (Dog War)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Commando"
	paygrades = list(PAY_SHORT_CA3 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/commando/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/canc_monoscope(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smock(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/obj/item/facepaint/sniper/paint = new()
	paint.paint_face(new_human, new_human)
	qdel(paint)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	var/pouch_type = pick(/obj/item/storage/pouch/firstaid/full/alternate, /obj/item/storage/pouch/firstaid/full)
	new_human.equip_to_slot_or_del(new pouch_type(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/t73, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lw317(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)


/datum/equipment_preset/canc/remnant/old/commando/leader
	name = "CANC Commando Leader (Dog War)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Leader"
	paygrades = list(PAY_SHORT_CA5 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/commando/leader/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/canc_monoscope(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto/canc(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/obj/item/facepaint/sniper/paint = new()
	paint.paint_face(new_human, new_human)
	qdel(paint)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/cm/canc/leader(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	var/pouch_type = pick(/obj/item/storage/pouch/firstaid/full/alternate, /obj/item/storage/pouch/firstaid/full)
	new_human.equip_to_slot_or_del(new pouch_type(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/t73, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lw317(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)

/datum/equipment_preset/canc/remnant/old/commando/machinegunner
	name = "CANC Commando Machinegunner (Dog War)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Commando Machinegunner"
	paygrades = list(PAY_SHORT_CA4 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/commando/machinegunner/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/canc_monoscope(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smock(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/obj/item/facepaint/sniper/paint = new()
	paint.paint_face(new_human, new_human)
	qdel(paint)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	var/pouch_type = pick(/obj/item/storage/pouch/firstaid/full/alternate, /obj/item/storage/pouch/firstaid/full)
	new_human.equip_to_slot_or_del(new pouch_type(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/t73, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pkp/standard_fmj(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pkp/standard_fmj, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pkp/standard_fmj, WEAR_IN_BELT)


/datum/equipment_preset/canc/remnant/old/commando/sniper
	name = "CANC Commando Sniper (Dog War)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Commando Machinegunner"
	paygrades = list(PAY_SHORT_CA4 = JOB_PLAYTIME_TIER_0)
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/canc/remnant/old/commando/sniper/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/canc_monoscope(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smock(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	var/obj/item/facepaint/sniper/paint = new()
	paint.paint_face(new_human, new_human)
	qdel(paint)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/smallpouch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard/canc(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	var/pouch_type = pick(/obj/item/storage/pouch/firstaid/full/alternate, /obj/item/storage/pouch/firstaid/full)
	new_human.equip_to_slot_or_del(new pouch_type(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/type47/t73, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lw317/dmr(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317/ap(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317/ap(new_human), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317/ap(new_human), WEAR_IN_R_STORE)

//////////////////////////
////AI PRESETS////////////
//////////////////////////

/datum/human_ai_equipment_preset/canc/dog_war_rifleman
	name = "CANC Reservist (Dog War)"
	desc = "CANC Reservist rifleman, SMG/battle rifle"
	path = /datum/equipment_preset/canc/remnant/old

/datum/human_ai_equipment_preset/canc/dog_war_leader
	name = "CANC Reservist Leader (Dog War)"
	desc = "CANC Reservist Leader, Better armor, LW-317."
	path = /datum/equipment_preset/canc/remnant/old/leader

/datum/human_ai_equipment_preset/canc/dog_war_medic
	name = "CANC Reservist Medic (Dog War)"
	desc = "CANC Reservist Medic, SMG."
	path = /datum/equipment_preset/canc/remnant/old/medic

/datum/human_ai_equipment_preset/canc/dog_war_marksman
	name = "CANC Reservist Marksman (Dog War)"
	desc = "CANC Reservist Marksman, Battle rifle"
	path = /datum/equipment_preset/canc/remnant/old/marksman

/datum/human_ai_equipment_preset/canc/dog_war_marksman_ghillie
	name = "CANC Reservist Marksman (Dog War, Ghillied Up)"
	desc = "CANC Reservist Marksman, Battle rifle, ghillied up"
	path = /datum/equipment_preset/canc/remnant/old/marksman/ghillie

/datum/human_ai_equipment_preset/canc/dog_war_commando
	name = "CANC Commando (Dog War)"
	desc = "CANC Commando, LW-317"
	path = /datum/equipment_preset/canc/remnant/old/commando

/datum/human_ai_equipment_preset/canc/dog_war_commando_leader
	name = "CANC Commando Leader (Dog War)"
	desc = "CANC Commando Leader, LW-317"
	path = /datum/equipment_preset/canc/remnant/old/commando/leader

/datum/human_ai_equipment_preset/canc/dog_war_commando_mg
	name = "CANC Commando MG (Dog War)"
	desc = "CANC Commando, Non-HEAP."
	path = /datum/equipment_preset/canc/remnant/old/commando/machinegunner

/datum/human_ai_equipment_preset/canc/dog_war_sniper
	name = "CANC Commando Sniper (Dog War)"
	desc = "CANC Commando Sniper"
	path = /datum/equipment_preset/canc/remnant/old/commando/sniper

//////////////////////////
////AI PRESETS////////////
//////////////////////////

/datum/human_ai_squad_preset/canc
	faction = "CANC"

/datum/human_ai_squad_preset/canc/patrol
	name = "CANC Reserve Forces, Patrol (Dog War)"
	desc = "2 soldiers, 1 leader."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old/leader = 1,
		/datum/equipment_preset/canc/remnant/old = 2,
	)

/datum/human_ai_squad_preset/canc/squad
	name = "CANC Reserve Forces, Squad (Dog War)"
	desc = "3 soldiers, 1 leader, 1 medic."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old/leader = 1,
		/datum/equipment_preset/canc/remnant/old = 3,
		/datum/equipment_preset/canc/remnant/old/medic = 1,
	)

/datum/human_ai_squad_preset/canc/squad_dmr
	name = "CANC Reserve Forces, Marksman Squad (Dog War)"
	desc = "3 soldiers, 1 leader, 1 marksman."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old/leader = 1,
		/datum/equipment_preset/canc/remnant/old = 3,
		/datum/equipment_preset/canc/remnant/old/marksman = 1,
	)

/datum/human_ai_squad_preset/canc/meatwave
	name = "CANC Reserve Forces, Assault Force (Dog War)"
	desc = "6 soldiers."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old = 6,
	)

/datum/human_ai_squad_preset/canc/commando
	name = "CANC Commandos, Squad (Dog War)"
	desc = "2 commandos, 1 leader."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old/commando/leader = 1,
		/datum/equipment_preset/canc/remnant/old/commando = 2,
	)

/datum/human_ai_squad_preset/canc/commando_mg_team
	name = "CANC Commandos, Machinegun Team (Dog War)"
	desc = "1 commando, 1 MG."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old/commando/machinegunner = 1,
		/datum/equipment_preset/canc/remnant/old/commando = 1,
	)

/datum/human_ai_squad_preset/canc/commando_dmr_team
	name = "CANC Commandos, Marksman Team (Dog War)"
	desc = "1 commando leader, 1 DMR."
	ai_to_spawn = list(
		/datum/equipment_preset/canc/remnant/old/commando/leader = 1,
		/datum/equipment_preset/canc/remnant/old/commando/sniper = 1,
	)