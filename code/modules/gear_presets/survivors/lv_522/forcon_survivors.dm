///*****************************LV-522 Force Recon Survivors*******************************************************/
//Nanu told me to put them here so they dont clutter up survivors.dm
/datum/equipment_preset/survivor/forecon
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag
	role_comm_title = "FORECON"
	rank = JOB_SURVIVOR
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_UA
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(
		ACCESS_CIVILIAN_PUBLIC,
		ACCESS_CIVILIAN_ENGINEERING,
		ACCESS_CIVILIAN_LOGISTICS,
	)

	dress_shoes = list(/obj/item/clothing/shoes/laceup)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_under = list(/obj/item/clothing/under/marine/dress/blues/senior)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress/blues/nco)
	dress_hat = list(/obj/item/clothing/head/marine/dress_cover)

/datum/equipment_preset/survivor/forecon/load_gear(mob/living/carbon/human/new_human)
	//uniform and drop-pouch contents
	add_forecon_surv_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/marine(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/fsr(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_ACCESSORY)
	//pouches
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	//suit, suit store & bag
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	//extremities & eyes
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/forecon(new_human), WEAR_L_EAR)
	GLOB.character_traits[/datum/character_trait/skills/spotter].apply_trait(new_human)

/datum/equipment_preset/survivor/forecon/proc/add_forecon_surv_jacket(mob/living/carbon/human/new_human)
	var/random_gun = rand(1,3)
	switch(random_gun)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/lamp(new_human), WEAR_JACKET)
		if(2,3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/rto/forecon(new_human), WEAR_JACKET)

/datum/equipment_preset/survivor/forecon/proc/add_forecon_surv_weapon(mob/living/carbon/human/new_human)
	var/random_gun = rand(1,3)
	switch(random_gun)
		if(1,2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/forecon/preloaded(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1/recon(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1/recon(new_human), WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m49a/forecon(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/ext(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/ext(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/heap(new_human), WEAR_IN_BACK) //Basic model is not great with basic rounds, some HEAP makes it not quite as bad.
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/heap(new_human), WEAR_IN_BACK) //These going into the backpack means they might be short some mags, but fits for surv preset

/datum/equipment_preset/survivor/forecon/add_survivor_weapon_pistol(mob/living/carbon/human/new_human)
	return

/datum/equipment_preset/survivor/forecon/proc/add_forecon_surv_weapon_pistol(mob/living/carbon/human/new_human)
	var/random_pistol = rand(1,5)
	switch(random_pistol)
		if(1,2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3(new_human), WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911/socom(new_human), WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
		if(3,4)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m39/forecon, WEAR_WAIST)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector(new_human),WEAR_WAIST)

/datum/equipment_preset/survivor/forecon/add_random_survivor_equipment(mob/living/carbon/human/new_human)
	return

/datum/equipment_preset/survivor/forecon/proc/add_forecon_equipment(mob/living/carbon/human/new_human)
	var/random_equipment = rand(1,7)
	switch(random_equipment)
		if(1,2)
			new_human.equip_to_slot_or_del(new /obj/item/device/walkman(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/device/cassette_tape/indie(new_human), WEAR_IN_BACK)
		if(3,4)
			new_human.equip_to_slot_or_del(new /obj/item/toy/deck(new_human), WEAR_IN_ACCESSORY)
		if(5,6)
			var/forecon_gear = pick(
			/obj/item/storage/fancy/cigarettes/kpack,
				/obj/item/storage/fancy/cigarettes/lucky_strikes,
				/obj/item/storage/fancy/cigarettes/balaji,
				/obj/item/storage/fancy/cigarettes/emeraldgreen,
				/obj/item/storage/fancy/cigarettes/lady_finger,
				/obj/item/storage/fancy/cigarettes/arcturian_ace,
				/obj/item/storage/fancy/cigarettes/spirit,
				/obj/item/storage/fancy/cigarettes/spirit/yellow,
				/obj/item/storage/fancy/cigarettes/wypacket,
			)
			new_human.equip_to_slot_or_del(new forecon_gear, WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/tool/lighter/random, WEAR_IN_ACCESSORY)
		if(7)
			new_human.equip_to_slot_or_del(new /obj/item/facepaint/sniper(new_human), WEAR_IN_ACCESSORY)

/datum/equipment_preset/survivor/forecon/proc/spawn_random_headgear(mob/living/carbon/human/new_human)
	var/i = rand(1,10)
	switch(i)
		if (1,2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
		if (3,4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beanie/gray(new_human), WEAR_HEAD)
		if (5,6)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/durag(new_human), WEAR_HEAD)
		if (7,8)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/boonie/tan(new_human), WEAR_HEAD)
		if (9)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)

/datum/equipment_preset/survivor/forecon/standard
	name = "USCM Reconnaissance Marine (Survivor)"
	assignment = JOB_FORECON_RIFLEMAN
	rank = JOB_SQUAD_MARINE
	role_comm_title = "RFN"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_standard

/datum/equipment_preset/survivor/forecon/standard/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e3(new_human), WEAR_ACCESSORY)
	add_forecon_surv_jacket(new_human)
	add_forecon_surv_weapon_pistol(new_human)
	add_forecon_surv_weapon(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)
	add_combat_gloves(new_human)

///*****************************//

/datum/equipment_preset/survivor/forecon/radio
	name = "USCM Reconnaissance Radio Telephone Operator (Survivor)"
	assignment = JOB_FORECON_RTO
	rank = JOB_SQUAD_RTO
	role_comm_title = "RTO"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_radio

/datum/equipment_preset/survivor/forecon/radio/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto/small(new_human), WEAR_BACK)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/flaregun/full(new_human), WEAR_WAIST)
	add_forecon_surv_jacket(new_human)
	add_forecon_surv_weapon(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)
	add_combat_gloves(new_human)

///*****************************//

/datum/equipment_preset/survivor/forecon/tech
	name = "USCM Reconnaissance Support Technician (Survivor)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_FORECON_SUPPORT
	rank = JOB_SQUAD_TECH
	role_comm_title = "SuppTech"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_techician

/datum/equipment_preset/survivor/forecon/tech/load_gear(mob/living/carbon/human/new_human)
	//Back and other stuff we don't want missed
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/big(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e4(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot(new /obj/item/storage/pouch/medkit/full/army(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini(new_human), WEAR_IN_BELT)
	add_forecon_surv_jacket(new_human)
	add_forecon_surv_weapon(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)

///*****************************//

/datum/equipment_preset/survivor/forecon/corpsman
	name = "USCM Reconnaissance Corpsman (Survivor)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_FORECON_CORPSMAN
	rank = JOB_SQUAD_MEDIC
	role_comm_title = "SARC"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_corpsman

/datum/equipment_preset/survivor/forecon/corpsman/load_gear(mob/living/carbon/human/new_human)
	//Back and other stuff we don't want missed
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/big(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/surgical_case/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e4(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot(new /obj/item/storage/pouch/medkit/full/army(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full/forecon(new_human), WEAR_WAIST)
	add_forecon_surv_jacket(new_human)
	add_forecon_surv_weapon(new_human)
	spawn_random_headgear(new_human)
	add_combat_gloves(new_human)
	add_forecon_equipment(new_human)

///*****************************//

/datum/equipment_preset/survivor/forecon/marksman
	name = "USCM Reconnaissance Designated Marksman (Survivor)"
	assignment = JOB_FORECON_MARKSMAN
	rank = JOB_SQUAD_SPOTTER
	role_comm_title = "DM"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_sharpshooter

/datum/equipment_preset/survivor/forecon/marksman/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m49a_custom(new_human), WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/M49A(new_human), WEAR_EYES)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e3(new_human), WEAR_ACCESSORY)
	add_forecon_surv_jacket(new_human)
	add_combat_gloves(new_human)
	add_forecon_surv_weapon_pistol(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/custom(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/custom(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m49a/custom/incendiary(new_human), WEAR_IN_BACK)

///*****************************//

/datum/equipment_preset/survivor/forecon/smartgunner
	name = "USCM Reconnaissance Smartgunner (Survivor)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_FORECON_SMARTGUNNER
	rank = JOB_SQUAD_SMARTGUN
	role_comm_title = "SG"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_smartgunner

/datum/equipment_preset/survivor/forecon/smartgunner/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m56(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/smartgun_battery(new_human), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_ACCESSORY)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e4(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911/socom(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BELT)
	add_combat_gloves(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)

///*****************************//

/datum/equipment_preset/survivor/forecon/sniper
	name = "USCM Reconnaissance Scout-Sniper (Shooter) (Survivor)"
	paygrades = list(PAY_SHORT_ME3 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_FORECON_SNIPER
	rank = JOB_SQUAD_SPECIALIST
	role_comm_title = "SctSnpr"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_sharpshooter

/datum/equipment_preset/survivor/forecon/sniper/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot(new /obj/item/clothing/suit/storage/marine/ghillie/forecon(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/sniper/M42A/basic(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/basic(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/basic(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_J_STORE)
	..()
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)
	add_forecon_surv_weapon_pistol(new_human)
	add_combat_gloves(new_human)

///*****************************//

/datum/equipment_preset/survivor/forecon/spotter
	name = "USCM Reconnaissance Scout-Sniper (Spotter) (Survivor)"
	paygrades = list(PAY_SHORT_ME4 = JOB_PLAYTIME_TIER_0)
	assignment = JOB_FORECON_SPOTTER
	rank = JOB_SQUAD_SPOTTER
	role_comm_title = "SctSnpr"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_sharpshooter

/datum/equipment_preset/survivor/forecon/spotter/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/e4(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot(new /obj/item/clothing/suit/storage/marine/ghillie/forecon(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/basic(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/basic(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator/spotter(new_human), WEAR_IN_JACKET)
	..()
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)
	add_forecon_surv_weapon(new_human)
	add_forecon_surv_weapon_pistol(new_human)
	add_combat_gloves(new_human)

//---------------------------\\

/datum/equipment_preset/survivor/forecon/squad_leader
	name = "USCM Reconnaissance Squad Leader (Survivor)"
	assignment = JOB_FORECON_SL
	rank = JOB_SQUAD_LEADER
	role_comm_title = "SL"
	minimap_icon = ""
	skills = /datum/skills/military/survivor/forecon_squad_leader
	paygrades = list(PAY_SHORT_MO1 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/survivor/forecon/squad_leader/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/o1(new_human), WEAR_ACCESSORY)
	add_forecon_surv_jacket(new_human)
	add_combat_gloves(new_human)
	add_forecon_surv_weapon(new_human)
	add_forecon_surv_weapon_pistol(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)

//---------------------------\\

/datum/equipment_preset/survivor/forecon/major
	name = "USCM Reconnaissance Major (Survivor)"
	assignment = JOB_FORECON_CO
	rank = JOB_CO
	skills = /datum/skills/commander
	paygrades = list(PAY_SHORT_MO4 = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/dogtag
	role_comm_title = "FORECON CO"

/datum/equipment_preset/survivor/forecon/major/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber(new_human), WEAR_JACKET)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/o4(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/m1911/forecon_officer(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/cigarette/cigar(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/lighter/zippo/gold(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/bottle/davenport(new_human), WEAR_IN_BACK)

/datum/equipment_preset/survivor/forecon/officer
	name = "USCM Reconnaissance Captain (Survivor)"
	assignment = JOB_FORECON_XO
	rank = JOB_XO
	role_comm_title = "FORECON XO"
	minimap_icon = ""
	skills = /datum/skills/XO
	paygrades = list(PAY_SHORT_MO3 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/survivor/forecon/officer/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service(new_human), WEAR_JACKET)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/o3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_IN_BACK)
	add_combat_gloves(new_human)
	add_forecon_surv_weapon(new_human)
	add_forecon_surv_weapon_pistol(new_human)
	spawn_random_headgear(new_human)
	add_forecon_equipment(new_human)

//----------------------\\

/datum/equipment_preset/synth/survivor/forecon
	name = "Synthetic - USCM Reconnaissance Synth (Survivor)"
	assignment = JOB_FORECON_SYN
	rank = JOB_SYNTH
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_UA
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/gold

/datum/equipment_preset/synth/survivor/forecon/load_gear(mob/living/carbon/human/preset_human)
	var/obj/item/clothing/under/marine/reconnaissance/uniform = new()
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	var/obj/item/clothing/accessory/patch/patch_uscm = new()
	var/obj/item/clothing/accessory/patch/forecon/patch_forecon = new()
	uniform.attach_accessory(preset_human,pouch)
	uniform.attach_accessory(preset_human,patch_uscm)
	uniform.attach_accessory(preset_human,patch_forecon)
	preset_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	preset_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(preset_human), WEAR_BACK)
	preset_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(preset_human), WEAR_FEET)
	preset_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/utility_vest(preset_human), WEAR_JACKET)
	preset_human.equip_to_slot_or_del(new /obj/item/device/motiondetector(preset_human), WEAR_IN_J_STORE)
	preset_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(preset_human), WEAR_IN_BACK)
	preset_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(preset_human), WEAR_IN_BACK)
	preset_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(preset_human), WEAR_IN_BACK)
	preset_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(preset_human), WEAR_R_STORE)
	preset_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full(preset_human), WEAR_L_STORE)
	preset_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/forecon/synth(preset_human), WEAR_L_EAR)

/datum/equipment_preset/synth/survivor/forecon/ranked
	name = "Synthetic - USCM Reconnaissance Synth (Ranked) (Survivor)"
	paygrades = list(PAY_SHORT_MW2 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/synth/survivor/forecon/ranked/load_gear(mob/living/carbon/human/preset_human)
	..()
	preset_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/marine/w2(preset_human), WEAR_ACCESSORY)
