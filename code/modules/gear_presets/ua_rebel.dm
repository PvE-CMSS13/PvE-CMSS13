/datum/equipment_preset/rebel
	name = "UA Rebel"
	languages = list(LANGUAGE_ENGLISH)
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UA_REBEL
	faction_group = FACTION_LIST_UA_REBEL
	skills = /datum/skills/clf
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	origin_override = ORIGIN_CIVILIAN

/datum/equipment_preset/rebel/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/rebel/guerilla
	name = "UA Rebel, Guerilla"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UA_REBEL
	faction_group = FACTION_LIST_UA_REBEL
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/rebel/guerilla/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	add_civilian_jacket(new_human)
	//limbs
	add_civilian_shoe(new_human)
	if(prob(90))
		add_survivor_weapon_pistol(new_human)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39(new_human), WEAR_L_HAND)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_BACK)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/rebel/soldier
	name = "UA Rebel, Soldier (Rifle)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/rebel/soldier/get_assignment(mob/living/carbon/human/new_human)
	return "Rifleman"

/datum/equipment_preset/rebel/soldier/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	if(prob(45))
		add_facewrap(new_human)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	if(prob(5))
		add_rebel_ua_pistol(new_human)
	else
		add_rebel_ua_rifle(new_human)

	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/rebel/soldier/shotgun
	name = "UA Rebel, Soldier (Shotgun)"

/datum/equipment_preset/rebel/soldier/shotgun/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	add_rebel_ua_shotgun(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/rebel/soldier/machinegunner
	name = "UA Rebel, Soldier (Machinegunner)"

/datum/equipment_preset/rebel/soldier/machinegunner/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/lmg, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40/lmg, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40/lmg, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40/lmg, WEAR_IN_BELT)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)


/datum/equipment_preset/rebel/soldier/flamer
	name = "UA Rebel, Soldier (Incinerator)"
	skills = /datum/skills/clf/specialist

/datum/equipment_preset/rebel/soldier/flamer/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/weak, WEAR_IN_BELT)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/flamer/weak(new_human), WEAR_J_STORE)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/weak, WEAR_IN_R_STORE)


/datum/equipment_preset/rebel/soldier/leader
	name = "UA Rebel, Soldier (Squad Leader)"
	skills = /datum/skills/clf/leader

/datum/equipment_preset/rebel/soldier/leader/get_assignment(mob/living/carbon/human/new_human)
	return "Squad Leader"

/datum/equipment_preset/rebel/soldier/leader/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/rifle/m41aMK1(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)


/datum/equipment_preset/rebel/medic
	name = "UA Rebel, Medic"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)
	skills = /datum/skills/clf/combat_medic

/datum/equipment_preset/rebel/medic/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Medic"
	return "Corpsman"

/datum/equipment_preset/rebel/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	if(prob(85))
		add_rebel_ua_pistol(new_human)
	else
		add_rebel_ua_rifle(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/rebel/at
	name = "UA Rebel, Anti-Tank"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)
	skills = /datum/skills/clf/specialist

/datum/equipment_preset/rebel/at/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Rifleman"
	return "Rocketeer"

/datum/equipment_preset/rebel/at/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/intel/chestrig(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/prop/folded_anti_tank_sadar(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/prop/folded_anti_tank_sadar(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/utility_vest(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable(new_human))


/datum/equipment_preset/rebel/commander
	name = "UA Rebel, Cell Commander"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)
	skills = /datum/skills/clf/commander

/datum/equipment_preset/rebel/commander/get_assignment(mob/living/carbon/human/new_human)
	return "Commander"

/datum/equipment_preset/rebel/commander/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	//uniform
	var/obj/item/clothing/under/marine/officer/boiler/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	//jacket
	if(prob(85))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/smartgunner(new_human), WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/smartgunner/black(new_human), WEAR_JACKET)

	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/smartgun/clf(new_human))

	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun, WEAR_IN_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)

/datum/equipment_preset/rebel/sniper
	name = "UA Rebel, Sniper (M42A)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	access = list(ACCESS_LIST_CLF_BASE)
	skills = /datum/skills/clf/sniper

/datum/equipment_preset/rebel/sniper/get_assignment(mob/living/carbon/human/new_human)
	if(prob(85))
		return "Sniper"
	return "Marksman"

/datum/equipment_preset/rebel/sniper/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/basic(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/basic(new_human), WEAR_IN_BACK)
	//face
	if(prob(45))
		add_facewrap(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_ua(new_human), WEAR_L_EAR)
	//head
	add_rebel_ua_helmet(new_human)
	//uniform
	add_rebel_ua_uniform(new_human)
	//jacket
	add_rebel_ua_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	//limbs
	add_rebel_ua_shoes(new_human)
	if(prob(35))
		add_rebel_gloves(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/rifle/sniper/M42A(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper(new_human), WEAR_IN_R_STORE)

//*****************************************************************************************************/
//EVA
//*****************************************************************************************************/
//They get "TWE" rebel guns because those on average have higher AP. Spacesuits have a little more bullet protection overall.
/datum/equipment_preset/rebel/soldier/eva
	name = "UA Rebel, Soldier (Rifle, EVA)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guardsman"

/datum/equipment_preset/rebel/soldier/eva/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) + list(ACCESS_CLF_ARMORY)

/datum/equipment_preset/rebel/soldier/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	var/random_webbing = rand(1,3)
	switch(random_webbing)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppsmall(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,3)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	if(prob(70))
		add_rebel_twe_rifle(new_human)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/ap, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_BELT)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

//*****************************************************************************************************/
/datum/equipment_preset/rebel/soldier/eva/machine_gun
	name = "UA Rebel, Soldier (Machine Gun, EVA)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guardsman"

/datum/equipment_preset/rebel/soldier/eva/machine_gun/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) + list(ACCESS_CLF_ARMORY)

/datum/equipment_preset/rebel/soldier/eva/machine_gun/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	var/random_webbing = rand(1,3)
	switch(random_webbing)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/mag(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppmags(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,3)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	var/random_gun = rand(1,3)
	switch(random_gun)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m16, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/ar10, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar10, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar10, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar10, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/ar10, WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/lmg, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)

	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

//*****************************************************************************************************/

//*****************************************************************************************************/
/datum/equipment_preset/rebel/soldier/eva/grenade
	name = "UA Rebel, Grenadier (M92 HE IED, EVA)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guardsman"

/datum/equipment_preset/rebel/soldier/eva/grenade/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) + list(ACCESS_CLF_ARMORY)

/datum/equipment_preset/rebel/soldier/eva/grenade/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/m40(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,2)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/l54(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	//nade lancher
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/grenade/m92/ied_he, WEAR_J_STORE)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/rebel/soldier/eva/grenade/incendiary
	name = "UA Rebel, Grenadier (M92 Incend IED, EVA)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guardsman"

/datum/equipment_preset/rebel/soldier/eva/grenade/incendiary/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) + list(ACCESS_CLF_ARMORY)

/datum/equipment_preset/rebel/soldier/eva/grenade/incendiary/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/m40(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,2)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/l54(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	//nade lancher
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/launcher/grenade/m92/ied_incendiary, WEAR_J_STORE)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/rebel/soldier/shotgun/eva
	name = "UA Rebel, Soldier (Shotgun, EVA)"

/datum/equipment_preset/rebel/soldier/shotgun/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/shotgun(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,3)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	add_rebel_twe_shoes(new_human)
	add_rebel_twe_shotgun(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/rebel/soldier/flamer/eva
	name = "UA Rebel, Soldier (Incinerator, EVA)"
	skills = /datum/skills/clf/specialist

/datum/equipment_preset/rebel/soldier/flamer/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	var/random_webbing = rand(1,3)
	switch(random_webbing)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/small(new_human), WEAR_ACCESSORY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/uppsmall(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,3)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/weak, WEAR_IN_BELT)
	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/flamer/weak(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/weak, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/rebel/soldier/bolt_eva
	name = "UA Rebel, Sniper (Basira-Armstrong, EVA)"
	skills = /datum/skills/clf/sniper

/datum/equipment_preset/rebel/soldier/bolt_eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	//waist
	var/random_belt = rand(1,3)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/boltaction(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/boltaction(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/boltaction(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/boltaction(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/boltaction(new_human), WEAR_IN_BELT)
	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/boltaction(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/boltaction(new_human), WEAR_IN_BELT)

//*****************************************************************************************************/

/datum/equipment_preset/rebel/sniper/eva
	name = "UA Rebel, Sniper (Type-88, EVA)"
	skills = /datum/skills/clf/sniper

/datum/equipment_preset/rebel/sniper/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3/recon(new_human), WEAR_ACCESSORY)
	//waist
	var/random_belt = rand(1,4)
	switch(random_belt)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd/pve(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd/pve(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd/pve(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd/pve(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd/pve(new_human), WEAR_IN_BELT)

	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/rifle/sniper/svd/pve(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)

//*****************************************************************************************************/
