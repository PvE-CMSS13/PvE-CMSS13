/datum/equipment_preset/uscm
	name = "USCM"
	faction = FACTION_MARINE
	faction_group = FACTION_LIST_MARINE
	languages = list(LANGUAGE_ENGLISH)
	idtype = /obj/item/card/id/dogtag

	utility_under = list(/obj/item/clothing/under/marine)
	utility_hat = list(/obj/item/clothing/head/cmcap)
	utility_gloves = list(/obj/item/clothing/gloves/marine)
	utility_shoes = list(/obj/item/clothing/shoes/marine)
	utility_extra = list(/obj/item/clothing/head/beret/cm, /obj/item/clothing/head/beret/cm/tan)

	service_under = list(/obj/item/clothing/under/marine/officer/bridge)
	service_over = list(/obj/item/clothing/suit/storage/jacket/marine/service, /obj/item/clothing/suit/storage/jacket/marine/service/mp)
	service_hat = list(/obj/item/clothing/head/cmcap)
	service_shoes = list(/obj/item/clothing/shoes/dress)

	dress_under = list(/obj/item/clothing/under/marine/dress)
	dress_over = list(/obj/item/clothing/suit/storage/jacket/marine/dress)
	dress_hat = list(/obj/item/clothing/head/marine/peaked)
	dress_gloves = list(/obj/item/clothing/gloves/marine/dress)
	dress_shoes = list(/obj/item/clothing/shoes/dress)
	var/auto_squad_name
	///Allows the squad to be set even if spawned on admin z level
	var/ert_squad = FALSE

/datum/equipment_preset/uscm/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = rand(NUTRITION_VERYLOW, NUTRITION_LOW)

/datum/equipment_preset/uscm/load_preset(mob/living/carbon/human/new_human, randomise, count_participant)
	. = ..()
	if(!auto_squad_name || (is_admin_level(new_human.z) && !ert_squad))
		return
	if(!GLOB.data_core.manifest_modify(new_human.real_name, WEAKREF(new_human), assignment, rank))
		GLOB.data_core.manifest_inject(new_human)

	var/obj/item/card/id/ID = new_human.wear_id
	var/datum/money_account/acct = create_account(new_human, rand(30, 50), GLOB.paygrades[ID.paygrade])
	ID.associated_account_number = acct.account_number

	var/datum/squad/auto_squad = get_squad_by_name(auto_squad_name)
	if(auto_squad)
		transfer_marine_to_squad(new_human, auto_squad, new_human.assigned_squad, new_human.wear_id)
	if(!ert_squad && !auto_squad.active)
		auto_squad.engage_squad(FALSE)

	if(!auto_squad)
		transfer_marine_to_squad(new_human, pick(RoleAuthority.squads), new_human.assigned_squad, new_human.wear_id)

	new_human.marine_buyable_categories[MARINE_CAN_BUY_EAR] = 0
	new_human.sec_hud_set_ID()
	new_human.hud_set_squad()

	if(new_human.wear_l_ear)
		if(istype(new_human.wear_l_ear, /obj/item/device/radio/headset/almayer/marine))
			var/obj/item/device/radio/headset/almayer/marine/equipped_headset = new_human.wear_l_ear
			equipped_headset.add_hud_tracker(new_human)
	else if(new_human.wear_r_ear)
		if(istype(new_human.wear_r_ear, /obj/item/device/radio/headset/almayer/marine))
			var/obj/item/device/radio/headset/almayer/marine/equipped_headset = new_human.wear_r_ear
			equipped_headset.add_hud_tracker(new_human)

/datum/equipment_preset/uscm/proc/spawn_marine_fluff_items(mob/living/carbon/human/new_human)
	var/obj/item/helmet_accessory = pick(GLOB.allowed_helmet_items)
	new_human.equip_to_slot_or_del(new helmet_accessory, WEAR_IN_HELMET)
	if(prob(50))
		var/obj/item/helmet_accessory_two = pick(GLOB.allowed_helmet_items)
		new_human.equip_to_slot_or_del(new helmet_accessory_two, WEAR_IN_HELMET)
	var/list/possible_masks = list(/obj/item/clothing/mask/gas) + subtypesof(/obj/item/clothing/mask/rebreather) + subtypesof(/obj/item/clothing/mask/tornscarf)
	if(prob(50))
		var/obj/item/clothing/mask/new_mask = pick(possible_masks)
		new_human.equip_to_slot_or_del(new new_mask, WEAR_FACE)

	var/list/possible_glasses = list(/obj/item/clothing/glasses/regular, /obj/item/clothing/glasses/regular/hipster, /obj/item/clothing/glasses/sunglasses, /obj/item/clothing/glasses/sunglasses/aviator, /obj/item/clothing/glasses/sunglasses/big) + subtypesof(/obj/item/clothing/glasses/mgoggles)
	if(prob(50))
		var/obj/item/clothing/mask/new_glasses = pick(possible_glasses)
		new_human.equip_to_slot_or_del(new new_glasses, WEAR_EYES)

/datum/equipment_preset/uscm/proc/spawn_marine_armor(mob/living/carbon/human/new_human)
	if(prob(66))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium, WEAR_JACKET)
	else if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/light, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/heavy, WEAR_JACKET)

/datum/equipment_preset/uscm/proc/spawn_marine_backpack(mob/living/carbon/human/new_human)
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel, WEAR_BACK)
	else
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine, WEAR_BACK)

/datum/equipment_preset/uscm/proc/spawn_marine_sidearm(mob/living/carbon/human/new_human)
	return

//*****************************************************************************************************/
/datum/equipment_preset/uscm/pfc
	name = "USCM Squad Rifleman"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrade = "ME2"
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"

/datum/equipment_preset/uscm/pfc/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/pfc/lesser_rank
	paygrade = "ME1"

/datum/equipment_preset/uscm/pfc/upp
	name = "UPP Squad Rifleman"
	paygrade = "UE2"
	access = list(ACCESS_UPP_GENERAL)
	languages = list(LANGUAGE_RUSSIAN)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/pfc/upp/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/lightpack/upp
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/pfc/upp/lesser_rank
	paygrade = "UE1"

/datum/equipment_preset/uscm/pfc/forecon
	name = "FORECON Squad Rifleman"
	paygrade = "ME3"
	skills = /datum/skills/pfc/recon

/datum/equipment_preset/uscm/pfc/forecon/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/standard
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/standard

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)


/datum/equipment_preset/uscm/pfc/forecon/lesser_rank
	paygrade = "ME2"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/sg
	name = "USCM Squad Smartgunner"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_SQUAD_SMARTGUN
	rank = JOB_SQUAD_SMARTGUN
	paygrade = "ME4"
	role_comm_title = "SG"
	skills = /datum/skills/smartgunner

	minimap_icon = "smartgunner"

/datum/equipment_preset/uscm/sg/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)


/datum/equipment_preset/uscm/sg/lesser_rank
	paygrade = "ME3"

/datum/equipment_preset/uscm/sg/upp
	name = "UPP Squad Machinegunner"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MACHINEGUN)
	assignment = "Machinegunner"
	paygrade = "UE4"
	role_comm_title = "MG"
	languages = list(LANGUAGE_RUSSIAN)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/sg/upp/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/lightpack/upp
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/sg/upp/lesser_rank
	paygrade = "UE3"

/datum/equipment_preset/uscm/sg/forecon
	name = "FORECON Squad Smartgunner"
	paygrade = "ME5"
	skills = /datum/skills/smartgunner/recon

/datum/equipment_preset/uscm/sg/forecon/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/standard
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/standard

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/sg/forecon/lesser_rank
	paygrade = "ME4"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/sg/full
	name = "USCM Squad Smartgunner"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

/datum/equipment_preset/uscm/sg/full/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/specrag(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

/datum/equipment_preset/uscm/sg/full/load_status(mob/living/carbon/human/new_human)
	return //No cryo munchies

/datum/equipment_preset/uscm/rto
	name = "USCM Radio Telephone Operator"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = JOB_SQUAD_RTO
	rank = JOB_SQUAD_RTO
	paygrade = "ME4"
	role_comm_title = "RTO"
	skills = /datum/skills/pfc

	minimap_icon = "rto"

/datum/equipment_preset/uscm/rto/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/rto/lesser_rank
	paygrade = "ME3"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tank
	name = "USCM Vehicle Crewman (CRMN) (Cryo)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(
		ACCESS_MARINE_PREP,
		ACCESS_MARINE_CREWMAN,
		ACCESS_MARINE_ALPHA,
		ACCESS_MARINE_BRAVO,
		ACCESS_MARINE_CHARLIE,
		ACCESS_MARINE_DELTA,
	)
	assignment = JOB_CREWMAN
	rank = JOB_CREWMAN
	paygrade = "ME4"
	role_comm_title = "CRMN"
	minimum_age = 30
	skills = /datum/skills/tank_crew

	minimap_icon = "vc"

/datum/equipment_preset/uscm/tank/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/vc(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/tanker(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/service/tanker, WEAR_JACKET)

/datum/equipment_preset/uscm/tank/load_status(mob/living/carbon/human/new_human)
	return

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tank/full
	name = "USCM Vehicle Crewman (CRMN)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	utility_under = list(/obj/item/clothing/under/marine/officer/tanker)

/datum/equipment_preset/uscm/tank/full/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/vc(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/tanker(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/mod88(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/tanker(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tank(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/tech/tanker(new_human), WEAR_HEAD)

	spawn_weapon(/obj/item/weapon/gun/smg/m39, /obj/item/ammo_magazine/smg/m39/extended, new_human, 0, 3)

/*****************************************************************************************************/

/datum/equipment_preset/uscm/tank/recon
	name = "USCM Reconnaissance Vehicle Operator (CRMN)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	assignment = "Reconnaissance Vehicle Operator"
	role_comm_title = "RVO"
	paygrade = "ME5"

	utility_under = list(/obj/item/clothing/under/marine/officer/tanker)

/datum/equipment_preset/uscm/tank/recon/load_gear(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/officer/tanker/uniform = new()
	var/obj/item/clothing/accessory/patch/patch_uscm = new()
	var/obj/item/clothing/accessory/patch/forecon/patch_forecon = new()
	uniform.attach_accessory(new_human,patch_uscm)
	uniform.attach_accessory(new_human,patch_forecon)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m44/gunslinger/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/tanker(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/simple(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/standard(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/snacks/packaged_burger(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/snacks/wy_chips/pepper(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/snacks/wrapped/chunk(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/cans/cola(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/cans/cola(new_human), WEAR_IN_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/welder_chestrig(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldpack/minitank(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sandbags_empty/full(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tank(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/pistol/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/marksman(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/marksman(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/marksman(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/marksman(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/marksman(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/marksman(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/cigarette/ucigarette(new_human), WEAR_FACE)

/*****************************************************************************************************/

/datum/equipment_preset/uscm/spec
	name = "USCM (Cryo) Squad Weapons Specialist"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = JOB_SQUAD_SPECIALIST
	rank = JOB_SQUAD_SPECIALIST
	paygrade = "ME3"
	role_comm_title = "Spc"
	skills = /datum/skills/specialist

	minimap_icon = "spec"

/datum/equipment_preset/uscm/spec/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/specrag(new_human), WEAR_HEAD)

/datum/equipment_preset/uscm/spec/cryo
	name = "USCM Cryo Squad Weapons Specialist"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/spec/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/spec_kit/cryo, WEAR_R_HAND)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/spec/full_armor
	name = "USCM Weapons Specialist (B18 Armor)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

/datum/equipment_preset/uscm/spec/full_armor/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/specialist(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/specialist(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/specialist(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/uscm/spec/full_armor/load_status(mob/living/carbon/human/new_human)
	return //No cryo munchies

//*****************************************************************************************************/

/datum/equipment_preset/uscm/medic
	name = "USCM Squad Hospital Corpsman"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_SQUAD_MEDIC
	rank = JOB_SQUAD_MEDIC
	paygrade = "ME4"
	role_comm_title = "HM"
	skills = /datum/skills/combat_medic

	minimap_icon = "medic"

	utility_under = list(/obj/item/clothing/under/marine/medic)

/datum/equipment_preset/uscm/medic/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/medic
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/medic

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/medic/lesser_rank
	paygrade = "ME3"

/datum/equipment_preset/uscm/medic/upp
	name = "UPP Sanitar"
	paygrade = "UE4"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MEDPREP, ACCESS_UPP_MEDICAL)
	assignment = "Sanitar"
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/medic/upp/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/lightpack/upp
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/medic/upp

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/medic/upp/lesser_rank
	paygrade = "UE3"

/datum/equipment_preset/uscm/medic/forecon
	name = "FORECON Squad Corpsman"
	assignment = "Squad Corpsman"
	paygrade = "ME5"
	skills = /datum/skills/combat_medic/recon

/datum/equipment_preset/uscm/medic/forecon/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/medic/standard
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/medic/standard

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/medic/forecon/lesser_rank
	paygrade = "ME4"

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl
	name = "USCM Squad Sergeant"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_TEAM_LEADER
	rank = JOB_SQUAD_TEAM_LEADER
	paygrade = "ME5"
	role_comm_title = "SqSgt"
	skills = /datum/skills/tl
	minimap_icon = "tl"

/datum/equipment_preset/uscm/tl/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/tl/upp
	name = "UPP Squad Sergeant"
	paygrade = "UE5"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_TLPREP)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH, LANGUAGE_CHINESE)
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/tl/upp/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/lightpack/upp
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/tl/forecon
	name = "FORECON Assistant Squad Leader"
	assignment = "Assistant Squad Leader"
	paygrade = "ME6"
	role_comm_title = "aSL"
	skills = /datum/skills/tl/recon

/datum/equipment_preset/uscm/tl/forecon/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/standard
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/standard

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/*****************************************************************************************************/

/datum/equipment_preset/uscm/engineer
	name = "USCM Squad Combat Technician"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)
	assignment = JOB_SQUAD_ENGI
	rank = JOB_SQUAD_ENGI
	paygrade = "ME3"
	role_comm_title = "ComTech"
	skills = /datum/skills/combat_engineer

	minimap_icon = "engi"

	utility_under = list(/obj/item/clothing/under/marine/engineer)

/datum/equipment_preset/uscm/engineer/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/tech
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/tech

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/engineer/cryo
	name = "USCM Cryo Squad Combat Technician"
	auto_squad_name = SQUAD_MARINE_CRYO

/datum/equipment_preset/uscm/engineer/cryo/load_gear(mob/living/carbon/human/new_human)
	..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/engi(new_human), WEAR_L_EAR)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader
	name = "USCM Platoon Sergeant"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE
	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_LEADER
	rank = JOB_SQUAD_LEADER
	paygrade = "ME7"
	role_comm_title = "PltSgt"
	minimum_age = 27
	skills = /datum/skills/SL

	minimap_icon = "leader"

/datum/equipment_preset/uscm/leader/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/leader/lesser_rank
	paygrade = "ME6"

/datum/equipment_preset/uscm/leader/upp
	name = "UPP Platoon Sergeant"
	access = list(ACCESS_UPP_GENERAL, ACCESS_UPP_LEADERSHIP, ACCESS_UPP_FLIGHT)
	languages = list(LANGUAGE_RUSSIAN, LANGUAGE_ENGLISH) //ground commander and stuff
	paygrade = "UE7"
	faction_group = list(FACTION_UPP)
	faction = FACTION_UPP

/datum/equipment_preset/uscm/leader/upp/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/lightpack/upp
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/leader/upp/lesser_rank
	paygrade = "UE6"

/datum/equipment_preset/uscm/leader/forecon
	name = "FORECON Squad Leader"
	assignment = "Squad Leader"
	paygrade = "ME8"
	role_comm_title = "SL"

/datum/equipment_preset/uscm/leader/forecon/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/standard
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/standard

	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

/datum/equipment_preset/uscm/leader/forecon/lesser_rank
	paygrade = "ME7"

//*****************************************************************************************************/
// ERT members that spawn with full gear from DEFCON

/datum/equipment_preset/uscm/private_equipped
	name = "USCM Squad Rifleman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP)
	assignment = JOB_SQUAD_MARINE
	rank = JOB_SQUAD_MARINE
	paygrade = "ME2"
	role_comm_title = "RFN"
	skills = /datum/skills/pfc

	minimap_icon = "private"

/datum/equipment_preset/uscm/private_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/private_equipped/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) < JOB_PLAYTIME_TIER_1)
			return "ME1"
	return paygrade

/datum/equipment_preset/uscm/private_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/uscm/private_equipped/random
	name = "USCM Squad Rifleman (Equipped Random)"

/datum/equipment_preset/uscm/private_equipped/random/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	spawn_marine_armor(new_human)
	spawn_marine_backpack(new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	spawn_marine_fluff_items(new_human)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/leader_equipped
	name = "USCM Platoon Sergeant (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_DROPSHIP)
	assignment = JOB_SQUAD_LEADER
	rank = JOB_SQUAD_LEADER
	paygrade = "ME7"
	role_comm_title = "PltSgt"
	minimum_age = 27
	skills = /datum/skills/SL

	minimap_icon = "leader"

/datum/equipment_preset/uscm/leader_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/leader_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/leader(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/lead(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/leader(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/uscm/leader_equipped/random
	name = "USCM Platoon Sergeant (Equipped Random)"

/datum/equipment_preset/uscm/leader_equipped/random/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	spawn_marine_armor(new_human)
	spawn_marine_backpack(new_human)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/leader(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/lead(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	spawn_marine_fluff_items(new_human)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/smartgunner_equipped
	name = "USCM Squad Smartgunner (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SMARTPREP)
	assignment = JOB_SQUAD_SMARTGUN
	rank = JOB_SQUAD_SMARTGUN
	paygrade = "ME3"
	role_comm_title = "SG"
	skills = /datum/skills/smartgunner

	minimap_icon = "smartgunner"

/datum/equipment_preset/uscm/smartgunner_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/smartgunner_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/smartgunner/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)


	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)

/datum/equipment_preset/uscm/smartgunner_equipped/random
	name = "USCM Squad Smartgunner (Equipped Random)"

/datum/equipment_preset/uscm/smartgunner_equipped/random/spawn_marine_fluff_items(mob/living/carbon/human/new_human)
	var/obj/item/helmet_accessory = pick(GLOB.allowed_helmet_items)
	new_human.equip_to_slot_or_del(new helmet_accessory, WEAR_IN_HELMET)
	if(prob(50))
		var/obj/item/helmet_accessory_two = pick(GLOB.allowed_helmet_items)
		new_human.equip_to_slot_or_del(new helmet_accessory_two, WEAR_IN_HELMET)
	var/list/possible_masks = list(/obj/item/clothing/mask/gas) + subtypesof(/obj/item/clothing/mask/rebreather) + subtypesof(/obj/item/clothing/mask/tornscarf)
	if(prob(50))
		var/obj/item/clothing/mask/new_mask = pick(possible_masks)
		new_human.equip_to_slot_or_del(new new_mask, WEAR_FACE)

/datum/equipment_preset/uscm/smartgunner_equipped/random/spawn_marine_sidearm(mob/living/carbon/human/new_human)
	var/sidearm = pick("m4a3", "mod88", "vp78", "m44")
	switch(sidearm)
		if("m4a3")
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_ACCESSORY)
		if("mod88")
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/mod88(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/mod88(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/mod88(new_human), WEAR_IN_ACCESSORY)
		if("vp78")
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp78(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp78(new_human), WEAR_IN_ACCESSORY)
		if("m44")
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/m44(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver(new_human), WEAR_IN_ACCESSORY)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver(new_human), WEAR_IN_ACCESSORY)

/datum/equipment_preset/uscm/smartgunner_equipped/random/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster(new_human), WEAR_ACCESSORY)
	spawn_marine_sidearm(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/smartgunner(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smartgun(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_JACKET)
	spawn_marine_fluff_items(new_human)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/engineer_equipped
	name = "USCM Squad Combat Technician (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_ENGPREP, ACCESS_CIVILIAN_ENGINEERING)
	assignment = JOB_SQUAD_ENGI
	rank = JOB_SQUAD_ENGI
	paygrade = "ME3"
	role_comm_title = "ComTech"
	skills = /datum/skills/combat_engineer

	minimap_icon = "engi"

	utility_under = list(/obj/item/clothing/under/marine/engineer)

/datum/equipment_preset/uscm/engineer_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/engineer_equipped/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/engineer(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/tech(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/engi(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/insulated(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_R_HAND)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/uscm/engineer_equipped/cryo
	name = "USCM Cryo Squad Combat Technician (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

//*****************************************************************************************************/

/datum/equipment_preset/uscm/medic_equipped
	name = "USCM Squad Hospital Corpsman (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_MEDBAY)
	assignment = JOB_SQUAD_MEDIC
	rank = JOB_SQUAD_MEDIC
	paygrade = "ME4"
	role_comm_title = "HM"
	skills = /datum/skills/combat_medic

	minimap_icon = "medic"

	utility_under = list(/obj/item/clothing/under/marine/medic)

/datum/equipment_preset/uscm/medic_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/medic_equipped/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/medic(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/med(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	if(new_human.disabilities & NEARSIGHTED)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health/prescription(new_human), WEAR_EYES)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)

/datum/equipment_preset/uscm/medic_equipped/random
	name = "USCM Squad Hospital Corpsman (Equipped Random)"

/datum/equipment_preset/uscm/medic_equipped/random/spawn_marine_fluff_items(mob/living/carbon/human/new_human)
	var/obj/item/helmet_accessory = pick(GLOB.allowed_helmet_items)
	new_human.equip_to_slot_or_del(new helmet_accessory, WEAR_IN_HELMET)
	if(prob(50))
		var/obj/item/helmet_accessory_two = pick(GLOB.allowed_helmet_items)
		new_human.equip_to_slot_or_del(new helmet_accessory_two, WEAR_IN_HELMET)

	if(prob(50))
		var/list/possible_masks = list(/obj/item/clothing/mask/gas) + subtypesof(/obj/item/clothing/mask/rebreather) + subtypesof(/obj/item/clothing/mask/tornscarf)
		if(prob(25))
			var/obj/item/clothing/mask/new_mask = pick(possible_masks)
			new_human.equip_to_slot_or_del(new new_mask, WEAR_FACE)
		else
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/surgical(new_human), WEAR_FACE)

/datum/equipment_preset/uscm/medic_equipped/random/load_gear(mob/living/carbon/human/new_human)
	spawn_marine_backpack(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/medic(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/medic(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/med(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/medium(new_human), WEAR_JACKET)
	spawn_marine_fluff_items(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/lifesaver/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medkit/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human.back), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)


//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped
	name = "USCM Squad Weapons Specialist (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_SPECPREP)
	assignment = JOB_SQUAD_SPECIALIST
	rank = JOB_SQUAD_SPECIALIST
	paygrade = "ME3"
	role_comm_title = "Spc"
	skills = /datum/skills/specialist

	minimap_icon = "spec"

/datum/equipment_preset/uscm/specialist_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/specialist_equipped/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/m39/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/attachable/magnetic_harness(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/spec_kit, WEAR_R_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/pmc_m39(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

/datum/equipment_preset/uscm/specialist_equipped/cryo
	name = "USCM Cryo Squad Weapons Specialist (Equipped)"
	auto_squad_name = SQUAD_MARINE_CRYO

//*****************************************************************************************************/

/datum/equipment_preset/uscm/specialist_equipped/sniper
	name = "USCM Sniper Specialist (Equipped)"

/datum/equipment_preset/uscm/specialist_equipped/sniper/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m42_night_goggles(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/ghillie(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/ghillie(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/smock(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/m39/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large/pmc_m39(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/incendiary(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/flak(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/flak(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

	spawn_weapon(/obj/item/weapon/gun/rifle/sniper/M42A, /obj/item/ammo_magazine/sniper, new_human, 0, 5)

//*****************************************************************************************************/

/datum/equipment_preset/uscm/tl_equipped
	name = "USCM Squad Sergeant (Equipped)"
	flags = EQUIPMENT_PRESET_EXTRA|EQUIPMENT_PRESET_MARINE

	access = list(ACCESS_MARINE_PREP, ACCESS_MARINE_TL_PREP)
	assignment = JOB_SQUAD_TEAM_LEADER
	rank = JOB_SQUAD_TEAM_LEADER
	paygrade = "ME5"
	role_comm_title = "SqSgt"
	skills = /datum/skills/tl

	minimap_icon = "tl"

/datum/equipment_preset/uscm/tl_equipped/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/tl_equipped/load_gear(mob/living/carbon/human/new_human)
	//TODO: add backpacks and satchels
	var/obj/item/clothing/under/marine/rto/U = new(new_human)
	var/obj/item/clothing/accessory/storage/webbing/W = new()
	U.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(U, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/vp78(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo/tl(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/rto(src), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(src), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars(new_human), WEAR_L_HAND)

	new_human.back.pickup(new_human)

/datum/equipment_preset/uscm/tl_equipped/random
	name = "USCM Squad Sergeant (Equipped Random)"

/datum/equipment_preset/uscm/tl_equipped/random/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/rto(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine(new_human), WEAR_BODY)
	spawn_marine_armor(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/rto(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/cryo(new_human), WEAR_L_EAR)

	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine(new_human), WEAR_HANDS)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/MRE(new_human), WEAR_IN_BACK)

	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
	spawn_marine_fluff_items(new_human)



//############ Marine Raiders #############
//Operator
/datum/equipment_preset/uscm/marsoc
	name = "Marine Raider (!DEATHSQUAD!)"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = "Marine Raider"
	rank = JOB_MARINE_RAIDER
	role_comm_title = "Op."
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_TSL)
	skills = /datum/skills/commando/deathsquad
	auto_squad_name = SQUAD_SOF
	ert_squad = TRUE
	paygrade = "ME6"

	minimap_icon = "private"

/datum/equipment_preset/uscm/marsoc/load_status(mob/living/carbon/human/new_human)
	new_human.nutrition = NUTRITION_NORMAL

/datum/equipment_preset/uscm/marsoc/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/uscm/marsoc/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/marsoc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/super, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/super, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/super, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/health/ceramic_plate, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/marsoc, WEAR_FACE)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/sof, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_HELMET)
	//uniform
	var/obj/item/clothing/under/marine/veteran/marsoc/M = new()
	var/obj/item/clothing/accessory/storage/black_vest/W = new()
	M.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(M, WEAR_BODY)
	for(var/i in 1 to W.hold.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	//jacket
	var/obj/item/clothing/suit/storage/marine/sof/armor = new()
	new_human.equip_to_slot_or_del(armor, WEAR_JACKET)
	for(var/i in 1 to armor.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm40/heap, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a/elite/xm40, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/combat/marsoc, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/full, WEAR_R_STORE)

/datum/equipment_preset/uscm/marsoc/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_2)
			return "ME7"
	return paygrade

//Covert Raiders
/datum/equipment_preset/uscm/marsoc/covert
	name = "Marine Raiders (!DEATHSQUAD! Covert)"
	uses_special_name = TRUE
/datum/equipment_preset/uscm/marsoc/covert/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = MALE
	new_human.change_real_name(new_human, "[pick(nato_phonetic_alphabet)]")
	new_human.age = rand(20,30)
/datum/equipment_preset/uscm/marsoc/covert/load_rank(mob/living/carbon/human/new_human)
	return "O"

//Team Leader
/datum/equipment_preset/uscm/marsoc/sl
	name = "Marine Raider Team Leader (!DEATHSQUAD!)"
	assignment = JOB_MARINE_RAIDER_SL
	rank = JOB_MARINE_RAIDER_SL
	role_comm_title = "TL."
	paygrade = "MO1"
	skills = /datum/skills/commando/deathsquad/leader

	minimap_icon = "leader"

/datum/equipment_preset/uscm/marsoc/sl/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_2)
			return "MO2"
	return paygrade

//Codenamed Team Leader
/datum/equipment_preset/uscm/marsoc/sl/covert
	name = "Marine Raider Team Leader (!DEATHSQUAD! Covert)"
	uses_special_name = TRUE
/datum/equipment_preset/uscm/marsoc/sl/covert/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = MALE
	new_human.change_real_name(new_human, "[pick(nato_phonetic_alphabet)]")
	new_human.age = rand(20,30)
/datum/equipment_preset/uscm/marsoc/sl/covert/load_rank(mob/living/carbon/human/new_human)
	return "O"
//Officer
/datum/equipment_preset/uscm/marsoc/cmd
	name = "Marine Raider Officer (!DEATHSQUAD!)"
	assignment = JOB_MARINE_RAIDER_CMD
	rank = JOB_MARINE_RAIDER_CMD
	role_comm_title = "CMD."
	paygrade = "MO3"
	skills = /datum/skills/commando/deathsquad/officer

/datum/equipment_preset/uscm/marsoc/cmd/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_3)
			return "MO4"
	return paygrade

/datum/equipment_preset/uscm/marsoc/low_threat
	name = "Marine Raider"

/datum/equipment_preset/uscm/marsoc/low_threat/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/marsoc, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/phosphorus, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/sof, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/pmc/marsoc, WEAR_FACE)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/sof, WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/helmet_nvg/marsoc, WEAR_IN_HELMET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_HELMET)
	//uniform
	var/obj/item/clothing/under/marine/veteran/marsoc/uniform = new()
	var/obj/item/clothing/accessory/storage/black_vest/accessory = new()
	uniform.attach_accessory(new_human, accessory)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	for(var/i in 1 to accessory.hold.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_ACCESSORY)
	//jacket
	var/obj/item/clothing/suit/storage/marine/sof/armor = new()
	new_human.equip_to_slot_or_del(armor, WEAR_JACKET)
	for(var/i in 1 to armor.storage_slots)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm40, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41a/elite/xm40/ap, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/combat/marsoc, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/medical/socmed/not_op, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/tactical/full, WEAR_R_STORE)

/datum/equipment_preset/uscm/marsoc/low_threat/sl
	name = "Marine Raider Team Leader"
	assignment = JOB_MARINE_RAIDER_SL
	rank = JOB_MARINE_RAIDER_SL
	role_comm_title = "TL."
	paygrade = "MO1"
	skills = /datum/skills/commando/deathsquad/leader

	minimap_icon = "leader"

/datum/equipment_preset/uscm/marsoc/sl/load_rank(mob/living/carbon/human/new_human)
	if(new_human.client)
		if(get_job_playtime(new_human.client, rank) > JOB_PLAYTIME_TIER_2)
			return "MO2"
	return paygrade
