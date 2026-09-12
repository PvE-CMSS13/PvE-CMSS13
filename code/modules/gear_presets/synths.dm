/datum/equipment_preset/synth
	name = "Synth"
	uses_special_name = TRUE
	languages = ALL_SYNTH_LANGUAGES
	skills = /datum/skills/synthetic
	paygrades = list(PAY_SHORT_SYN = JOB_PLAYTIME_TIER_0)

	minimap_icon = "synth"

/datum/equipment_preset/synth/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/synth/load_race(mob/living/carbon/human/new_human)
	if(new_human.client?.prefs?.synthetic_type)
		new_human.set_species(new_human.client.prefs.synthetic_type)
		return
	new_human.set_species(SYNTH_GEN_THREE)

/datum/equipment_preset/synth/load_name(mob/living/carbon/human/new_human, randomise)
	var/final_name = "David"
	if(new_human.client && new_human.client.prefs)
		final_name = new_human.client.prefs.synthetic_name
		if(!final_name || final_name == "Undefined")
			final_name = "David"
	new_human.change_real_name(new_human, final_name)

/datum/equipment_preset/synth/load_skills(mob/living/carbon/human/new_human)
	. = ..()
	if(iscolonysynthetic(new_human) && !isworkingjoe(new_human))
		new_human.set_skills(/datum/skills/colonial_synthetic)

	new_human.allow_gun_usage = TRUE

//*****************************************************************************************************/

/datum/equipment_preset/synth/uscm
	name = "USCM Synthetic"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_MARINE
	idtype = /obj/item/card/id/gold
	assignment = JOB_SYNTH
	rank = "Synthetic"
	role_comm_title = "Syn"

/datum/equipment_preset/synth/uscm/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/industrial

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mcom/synth(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/synth/uscm/forecon
	name = "USCM Reconnaissance Synthetic"
	assignment = JOB_FORECON_SYN

/datum/equipment_preset/synth/uscm/forecon/load_gear(mob/living/carbon/human/new_human) //Bishop from Aliens
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/red(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/forecon(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/forecon/synth(new_human), WEAR_L_EAR)

//*****************************************************************************************************/

/datum/equipment_preset/synth/usasf
	name = "USASF Synthetic"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_NAVY
	faction_group = FACTION_LIST_UA
	idtype = /obj/item/card/id/gold
	assignment = JOB_NAVY_SYNTH
	rank = "Synthetic"
	role_comm_title = "USASF Syn"

/datum/equipment_preset/synth/usasf/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/industrial

	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/USASF/command(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/usasf, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/synth/survivor
	name = "Survivor - Synthetic - Classic Joe"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_SURVIVOR
	faction_group = list(FACTION_SURVIVOR)
	idtype = /obj/item/card/id/lanyard
	assignment = JOB_SYNTH
	rank = JOB_SYNTH_SURVIVOR
	skills = /datum/skills/colonial_synthetic

	var/list/equipment_to_spawn = list(
		WEAR_BODY = /obj/item/clothing/under/rank/synthetic/joe,
		WEAR_BACK = /obj/item/storage/backpack/marine/satchel,
		WEAR_IN_BACK = /obj/item/tool/weldingtool/hugetank,
		WEAR_WAIST = /obj/item/storage/belt/utility/full,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife,
		WEAR_L_HAND = /obj/item/maintenance_jack
	)

	var/survivor_variant = CIVILIAN_SURVIVOR

/datum/equipment_preset/synth/survivor/load_race(mob/living/carbon/human/new_human)
	//Switch to check client for synthetic generation preference, and set the subspecies of colonial synth
	var/generation_selection = SYNTH_COLONY_GEN_ONE
	if(new_human.client?.prefs?.synthetic_type)
		generation_selection = new_human.client.prefs.synthetic_type
	switch(generation_selection)
		if(SYNTH_GEN_THREE)
			new_human.set_species(SYNTH_COLONY)
		if(SYNTH_GEN_TWO)
			new_human.set_species(SYNTH_COLONY_GEN_TWO)
		if(SYNTH_GEN_ONE)
			new_human.set_species(SYNTH_COLONY_GEN_ONE)
		else
			new_human.set_species(SYNTH_COLONY)

/datum/equipment_preset/synth/survivor/New()
	. = ..()
	access = get_access(ACCESS_LIST_COLONIAL_ALL) + get_region_accesses(2) + get_region_accesses(4) + ACCESS_MARINE_RESEARCH //Access to civillians stuff + medbay stuff + engineering stuff + research

/datum/equipment_preset/synth/survivor/pmc/New()
	. = ..()
	name = "Survivor - Synthetic - PMC JOE ABSTRACT"
	access = get_access(ACCESS_LIST_WY_PMC)

/datum/equipment_preset/synth/survivor/wy
	flags = EQUIPMENT_PRESET_STUB

/datum/equipment_preset/synth/survivor/wy/New()
	. = ..()
	access = get_access(ACCESS_LIST_COLONIAL_ALL) + get_region_accesses(2) + get_region_accesses(4) + ACCESS_MARINE_RESEARCH + ACCESS_WY_GENERAL // for WY synths - admin building and wy fax machines access

/datum/equipment_preset/synth/survivor/load_gear(mob/living/carbon/human/new_human)
	for(var/equipment in equipment_to_spawn)
		var/equipment_path = islist(equipment_to_spawn[equipment]) ? pick(equipment_to_spawn[equipment]) : equipment_to_spawn[equipment]
		new_human.equip_to_slot_or_del(new equipment_path(new_human), equipment)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/synth/full(new_human), WEAR_L_STORE)

/datum/equipment_preset/synth/survivor/load_id(mob/living/carbon/human/new_human, client/mob_client)
	var/obj/item/clothing/under/uniform = new_human.w_uniform
	if(istype(uniform))
		uniform.has_sensor = UNIFORM_HAS_SENSORS
		uniform.sensor_faction = FACTION_COLONIST
	return ..()

/datum/equipment_preset/synth/survivor/medical_synth
	name = "Survivor - Synthetic - Medical Synth"
	equipment_to_spawn = list(
		WEAR_R_EAR = /obj/item/device/flashlight/pen,
		WEAR_FACE = /obj/item/clothing/mask/surgical,
		WEAR_EYES = /obj/item/clothing/glasses/hud/health,
		WEAR_BODY = /obj/item/clothing/under/rank/medical,
		WEAR_ACCESSORY = /obj/item/clothing/accessory/armband/medgreen,
		WEAR_BACK = /obj/item/storage/backpack/satchel/med,
		WEAR_IN_BACK = /obj/item/roller/surgical,
		WEAR_JACKET = /obj/item/clothing/suit/storage/hazardvest/blue,
		WEAR_R_HAND = /obj/item/device/healthanalyzer/soul,
		WEAR_WAIST = /obj/item/storage/belt/medical/lifesaver/full,
		WEAR_HANDS = /obj/item/clothing/gloves/latex,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

	survivor_variant = MEDICAL_SURVIVOR

/datum/equipment_preset/synth/survivor/emt_synth
	name = "Survivor - Synthetic - EMT Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/cmcap,
		WEAR_R_EAR = /obj/item/device/flashlight/pen,
		WEAR_FACE = /obj/item/clothing/mask/surgical,
		WEAR_EYES = /obj/item/clothing/glasses/hud/health,
		WEAR_BODY = /obj/item/clothing/under/colonist/ua_civvies,
		WEAR_ACCESSORY = /obj/item/clothing/accessory/armband/med,
		WEAR_BACK = /obj/item/storage/backpack/satchel/med,
		WEAR_IN_BACK = /obj/item/storage/firstaid/softpack/adv,
		WEAR_IN_BACK = /obj/item/tool/extinguisher/mini,
		WEAR_IN_BACK = /obj/item/roller,
		WEAR_JACKET = /obj/item/clothing/suit/storage/windbreaker/windbreaker_fr,
		WEAR_IN_JACKET = /obj/item/reagent_container/hypospray/autoinjector/adrenaline_concentrated,
		WEAR_WAIST = /obj/item/storage/belt/medical/full,
		WEAR_HANDS = /obj/item/clothing/gloves/latex,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife,
		WEAR_R_HAND = /obj/item/device/healthanalyzer/soul
	)

	survivor_variant = MEDICAL_SURVIVOR

/datum/equipment_preset/synth/survivor/scientist_synth
	name = "Survivor - Synthetic - Scientist Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/bio_hood,
		WEAR_FACE = /obj/item/clothing/mask/surgical,
		WEAR_EYES = /obj/item/clothing/glasses/hud/health,
		WEAR_BODY = /obj/item/clothing/under/rank/scientist,
		WEAR_BACK = /obj/item/storage/backpack/satchel/chem,
		WEAR_IN_BACK = /obj/item/reagent_container/glass/beaker/vial/random/good,
		WEAR_IN_BACK = /obj/item/paper/research_notes/good,
		WEAR_JACKET = /obj/item/clothing/suit/bio_suit,
		WEAR_IN_JACKET = /obj/item/evidencebag,
		WEAR_WAIST = /obj/item/storage/belt/medical/lifesaver/full,
		WEAR_HANDS = /obj/item/clothing/gloves/black,
		WEAR_R_HAND = /obj/item/device/motiondetector,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

	survivor_variant = SCIENTIST_SURVIVOR

/datum/equipment_preset/synth/survivor/archaeologist_synth
	name = "Survivor - Synthetic - Archaeologist Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/hardhat/orange,
		WEAR_BODY = /obj/item/clothing/under/rank/miner,
		WEAR_BACK = /obj/item/storage/backpack/satchel/eng,
		WEAR_IN_BACK = /obj/item/tool/shovel/spade,
		WEAR_JACKET = /obj/item/clothing/suit/storage/utility_vest,
		WEAR_IN_JACKET = /obj/item/explosive/plastic,
		WEAR_WAIST = /obj/item/device/flashlight/lantern,
		WEAR_R_HAND = /obj/item/stack/sandbags_empty/half,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

	survivor_variant = SCIENTIST_SURVIVOR

/datum/equipment_preset/synth/survivor/engineer_synth
	name = "Survivor - Synthetic - Engineer Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/hardhat,
		WEAR_BODY = /obj/item/clothing/under/rank/engineer,
		WEAR_ACCESSORY = /obj/item/clothing/accessory/armband/engine,
		WEAR_BACK = /obj/item/storage/backpack/satchel/eng,
		WEAR_IN_BACK = /obj/item/stack/sheet/metal/med_small_stack,
		WEAR_JACKET = /obj/item/clothing/suit/storage/hazardvest/yellow,
		WEAR_IN_JACKET = /obj/item/ammo_magazine/smg/nailgun,
		WEAR_J_STORE = /obj/item/weapon/gun/smg/nailgun/compact,
		WEAR_WAIST = /obj/item/storage/belt/utility/full,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife,
		WEAR_L_HAND = /obj/item/maintenance_jack
	)

	survivor_variant = ENGINEERING_SURVIVOR

/datum/equipment_preset/synth/survivor/corporate_synth
	name = "Survivor - Synthetic - Corporate Synth"

/datum/equipment_preset/synth/survivor/corporate_synth/load_gear(mob/living/carbon/human/new_human)
	..()
	add_random_cl_survivor_loot(new_human)

/datum/equipment_preset/synth/survivor/janitor_synth
	name = "Survivor - Synthetic - Janitor Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/soft/purple,
		WEAR_EYES = /obj/item/clothing/glasses/mgoggles,
		WEAR_BODY = /obj/item/clothing/under/rank/janitor,
		WEAR_ACCESSORY = /obj/item/clothing/accessory/armband/med,
		WEAR_BACK = /obj/item/storage/backpack/satchel/vir,
		WEAR_IN_BACK = /obj/item/reagent_container/glass/bucket,
		WEAR_IN_BACK = /obj/item/tool/wet_sign,
		WEAR_IN_BACK = /obj/item/storage/bag/trash,
		WEAR_JACKET = /obj/item/clothing/suit/storage/hazardvest,
		WEAR_IN_JACKET = /obj/item/reagent_container/spray/cleaner,
		WEAR_HANDS = /obj/item/clothing/gloves/purple,
		WEAR_R_HAND = /obj/item/tool/mop,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/galoshes
	)

/datum/equipment_preset/synth/survivor/chef_synth
	name = "Survivor - Synthetic - Chef Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/chefhat,
		WEAR_FACE = /obj/item/clothing/mask/surgical,
		WEAR_EYES = /obj/item/clothing/glasses/mgoggles,
		WEAR_BODY = /obj/item/clothing/under/rank/chef,
		WEAR_BACK = /obj/item/storage/backpack/satchel/vir,
		WEAR_IN_BACK = /obj/item/reagent_container/food/snacks/sliceable/lemoncake,
		WEAR_R_HAND = /obj/item/pizzabox/margherita,
		WEAR_JACKET = /obj/item/clothing/suit/chef,
		WEAR_HANDS = /obj/item/clothing/gloves/latex,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife,
		WEAR_L_HAND = /obj/item/tool/kitchen/knife/butcher
	)

/datum/equipment_preset/synth/survivor/teacher_synth
	name = "Survivor - Synthetic - Teacher Synth"
	equipment_to_spawn = list(
		WEAR_EYES = /obj/item/clothing/glasses/regular/hipster,
		WEAR_BODY = /obj/item/clothing/under/colonist/wy_davisone,
		WEAR_BACK = /obj/item/storage/backpack/satchel/norm,
		WEAR_IN_BACK = /obj/item/reagent_container/food/snacks/wy_chips/pepper,
		WEAR_IN_BACK = /obj/item/storage/box/pdt_kit,
		WEAR_JACKET = /obj/item/clothing/suit/storage/bomber/alt,
		WEAR_IN_JACKET = /obj/item/notepad,
		WEAR_WAIST = /obj/item/reagent_container/spray/cleaner,
		WEAR_R_HAND = /obj/item/storage/fancy/crayons,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

/datum/equipment_preset/synth/survivor/freelancer_synth
	name = "Survivor - Synthetic - Freelancer Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/welding,
		WEAR_FACE = /obj/item/clothing/mask/rebreather/scarf,
		WEAR_BODY = /obj/item/clothing/under/marine/veteran/freelancer,
		WEAR_BACK = /obj/item/storage/backpack/lightpack,
		WEAR_IN_BACK = /obj/item/tool/weldpack/minitank,
		WEAR_JACKET = /obj/item/clothing/suit/storage/utility_vest,
		WEAR_IN_JACKET = /obj/item/explosive/grenade/smokebomb,
		WEAR_WAIST = /obj/item/storage/belt/marine,
		WEAR_HANDS = /obj/item/clothing/gloves/marine/veteran,
		WEAR_R_HAND = /obj/item/storage/pouch/flare/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/upp
	)

/datum/equipment_preset/synth/survivor/surveyor_synth
	name = "Survivor - Synthetic - Surveyor Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/cmcap/flap,
		WEAR_FACE = /obj/item/clothing/mask/tornscarf,
		WEAR_BODY = /obj/item/clothing/under/rank/synthetic/utility,
		WEAR_BACK = /obj/item/storage/backpack/lightpack/five_slot,
		WEAR_IN_BACK = /obj/item/storage/box/flare,
		WEAR_JACKET = /obj/item/clothing/suit/storage/windbreaker/windbreaker_covenant,
		WEAR_IN_JACKET = /obj/item/device/binoculars,
		WEAR_WAIST = /obj/item/storage/backpack/general_belt,
		WEAR_IN_BELT = /obj/item/stack/flag/green,
		WEAR_HANDS = /obj/item/clothing/gloves/marine/veteran,
		WEAR_R_HAND = /obj/item/storage/box/lightstick,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

/datum/equipment_preset/synth/survivor/trucker_synth
	name = "Survivor - Synthetic - Trucker Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/soft/ferret,
		WEAR_BODY = /obj/item/clothing/under/rank/synthetic/frontier,
		WEAR_BACK = /obj/item/storage/backpack/satchel/norm,
		WEAR_IN_BACK = /obj/item/pamphlet/skill/powerloader,
		WEAR_R_HAND = /obj/item/tool/weldingtool/hugetank,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

/datum/equipment_preset/synth/survivor/bartender_synth
	name = "Survivor - Synthetic - Bartender Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/bowlerhat,
		WEAR_FACE = /obj/item/clothing/mask/gas/fake_mustache,
		WEAR_BODY = /obj/item/clothing/under/waiter,
		WEAR_BACK = /obj/item/storage/backpack/satchel,
		WEAR_IN_BACK = /obj/item/reagent_container/food/drinks/bottle/tequila,
		WEAR_IN_BACK = /obj/item/reagent_container/food/drinks/bottle/cognac,
		WEAR_IN_BACK = /obj/item/reagent_container/food/drinks/bottle/grenadine,
		WEAR_JACKET = /obj/item/clothing/suit/storage/wcoat,
		WEAR_IN_JACKET = /obj/item/reagent_container/food/drinks/bottle/rum,
		WEAR_HANDS = /obj/item/clothing/gloves/marine,
		WEAR_R_HAND = /obj/item/storage/beer_pack,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

/datum/equipment_preset/synth/survivor/atc_synth
	name = "Survivor - Synthetic - Landing Pad Attendant Synth"
	equipment_to_spawn = list(
		WEAR_R_EAR = /obj/item/clothing/ears/earmuffs,
		WEAR_HEAD = /obj/item/clothing/head/cmcap,
		WEAR_BODY = /obj/item/clothing/under/rank/synthetic/utility/yellow,
		WEAR_BACK = /obj/item/storage/backpack/satchel/norm,
		WEAR_IN_BACK = /obj/item/storage/box/flare,
		WEAR_JACKET = /obj/item/clothing/suit/storage/hazardvest,
		WEAR_IN_JACKET = /obj/item/device/binoculars,
		WEAR_WAIST = /obj/item/storage/backpack/general_belt,
		WEAR_IN_BELT = /obj/item/stack/flag/red,
		WEAR_HANDS = /obj/item/clothing/gloves/marine/veteran,
		WEAR_R_HAND = /obj/item/storage/box/lightstick/red,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

/datum/equipment_preset/synth/survivor/detective_synth
	name = "Survivor - Synthetic - Detective Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/fedora,
		WEAR_EYES = /obj/item/clothing/glasses/sunglasses/sechud,
		WEAR_BODY = /obj/item/clothing/under/det,
		WEAR_BACK = /obj/item/storage/backpack/satchel/sec,
		WEAR_IN_BACK = /obj/item/device/taperecorder,
		WEAR_JACKET = /obj/item/clothing/suit/storage/CMB/trenchcoat,
		WEAR_IN_JACKET = /obj/item/weapon/telebaton,
		WEAR_WAIST = /obj/item/storage/belt/security/MP/full/synth,
		WEAR_HANDS = /obj/item/clothing/gloves/black,
		WEAR_R_HAND = /obj/item/device/camera,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

	survivor_variant = SECURITY_SURVIVOR

/datum/equipment_preset/synth/survivor/wy/security_synth
	name = "Survivor - Synthetic - Corporate Security Synth"
	idtype = /obj/item/card/id/silver/cl
	role_comm_title = "WY Syn"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/soft/sec/corp,
		WEAR_L_EAR = /obj/item/device/radio/headset/distress/WY,
		WEAR_EYES = /obj/item/clothing/glasses/sunglasses/sechud,
		WEAR_BODY = /obj/item/clothing/under/colonist/white_service,
		WEAR_BACK = /obj/item/storage/backpack/satchel/sec,
		WEAR_IN_BACK = /obj/item/restraint/handcuffs,
		WEAR_IN_BACK = /obj/item/restraint/handcuffs,
		WEAR_JACKET = /obj/item/clothing/suit/storage/webbing,
		WEAR_WAIST = /obj/item/storage/belt/security/MP/full/synth,
		WEAR_IN_JACKET = /obj/item/weapon/telebaton,
		WEAR_HANDS = /obj/item/clothing/gloves/black,
		WEAR_R_STORE = /obj/item/storage/pouch/tools/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife
	)

	survivor_variant = SECURITY_SURVIVOR
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/synth/survivor/wy/protection_synth
	name = "Survivor - Synthetic - Corporate Protection Synth"
	idtype = /obj/item/card/id/pmc
	role_comm_title = "WY Syn"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/helmet/marine/veteran/pmc,
		WEAR_L_EAR = /obj/item/device/radio/headset/distress/pmc/hvh,
		WEAR_EYES = /obj/item/clothing/glasses/sunglasses/sechud,
		WEAR_BODY = /obj/item/clothing/under/marine/veteran/pmc,
		WEAR_ACCESSORY = /obj/item/clothing/accessory/storage/droppouch,
		WEAR_IN_ACCESSORY = /obj/item/explosive/grenade/flashbang,
		WEAR_BACK = /obj/item/storage/backpack/lightpack/five_slot,
		WEAR_IN_BACK = /obj/item/device/binoculars,
		WEAR_JACKET = /obj/item/clothing/suit/storage/hazardvest/black,
		WEAR_IN_JACKET = /obj/item/weapon/telebaton,
		WEAR_HANDS = /obj/item/clothing/gloves/marine/veteran/pmc,
		WEAR_FEET = /obj/item/clothing/shoes/marine/civilian
	)

	survivor_variant = SECURITY_SURVIVOR
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/synth/survivor/wy/corporate_synth
	name = "Survivor - Synthetic - Corporate Clerical Synth"
	idtype = /obj/item/card/id/data
	role_comm_title = "WY Syn"
	equipment_to_spawn = list(
		WEAR_L_EAR = /obj/item/device/radio/headset/distress/WY,
		WEAR_R_EAR = /obj/item/tool/pen/clicky,
		WEAR_BODY = /obj/item/clothing/under/suit_jacket/trainee,
		WEAR_BACK = /obj/item/storage/backpack/satchel/lockable,
		WEAR_IN_BACK = /obj/item/notepad,
		WEAR_IN_BACK = /obj/item/folder,
		WEAR_IN_BACK = /obj/item/paper/research_notes/good,
		WEAR_IN_BACK = /obj/item/device/taperecorder,
		WEAR_WAIST = /obj/item/storage/belt/utility/full,
		WEAR_HANDS = /obj/item/clothing/gloves/botanic_leather,
		WEAR_FEET = /obj/item/clothing/shoes/laceup,
		WEAR_R_HAND = /obj/item/clipboard
	)

	survivor_variant = CORPORATE_SURVIVOR
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/synth/survivor/icc_synth
	name = "Survivor - Synthetic - Interstellar Commerce Commission Synthetic"
	idtype = /obj/item/card/id/silver/cl
	role_comm_title = "ICC Syn"
	equipment_to_spawn = list(
		WEAR_L_EAR = /obj/item/device/radio/headset/distress/CMB/limited,
		WEAR_R_EAR = /obj/item/tool/pen/clicky,
		WEAR_HEAD = /obj/item/clothing/head/hardhat/white,
		WEAR_BODY = /obj/item/clothing/under/liaison_suit/black,
		WEAR_BACK = /obj/item/storage/backpack/satchel/lockable,
		WEAR_IN_BACK = /obj/item/notepad,
		WEAR_IN_BACK = /obj/item/folder,
		WEAR_IN_BACK = /obj/item/paper/research_notes/good,
		WEAR_WAIST = /obj/item/clipboard,
		WEAR_JACKET = /obj/item/clothing/suit/storage/hazardvest/yellow,
		WEAR_IN_JACKET = /obj/item/device/taperecorder,
		WEAR_FEET = /obj/item/clothing/shoes/laceup,
		WEAR_R_HAND = /obj/item/device/camera
	)

	survivor_variant = CORPORATE_SURVIVOR

/datum/equipment_preset/synth/survivor/radiation_synth
	name = "Survivor - Synthetic - Radiation Synth"
	equipment_to_spawn = list(
		WEAR_HEAD = /obj/item/clothing/head/radiation,
		WEAR_BODY = /obj/item/clothing/under/marine/officer/engi,
		WEAR_BACK = /obj/item/storage/backpack/satchel/eng,
		WEAR_IN_BACK = /obj/item/tool/weldingtool/hugetank,
		WEAR_JACKET = /obj/item/clothing/suit/radiation,
		WEAR_WAIST = /obj/item/tank/emergency_oxygen/double,
		WEAR_HANDS = /obj/item/clothing/gloves/yellow,
		WEAR_R_HAND = /obj/item/storage/pouch/electronics/full,
		WEAR_FEET = /obj/item/clothing/shoes/marine/knife,
		WEAR_L_HAND = /obj/item/maintenance_jack
	)

	survivor_variant = ENGINEERING_SURVIVOR

//*****************************************************************************************************/

/datum/equipment_preset/synth/working_joe
	name = "Synthetic - Working Joe"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_MARINE
	faction_group = list(FACTION_MARINE)
	assignment = JOB_WORKING_JOE
	rank = JOB_WORKING_JOE
	skills = /datum/skills/working_joe
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_APOLLO, LANGUAGE_RUSSIAN, LANGUAGE_JAPANESE, LANGUAGE_GERMAN, LANGUAGE_SPANISH, LANGUAGE_CHINESE)
	/// Used to set species when loading race
	var/joe_type = SYNTH_WORKING_JOE

/datum/equipment_preset/synth/working_joe/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/synth/working_joe/load_race(mob/living/carbon/human/new_human)
	. = ..()
	new_human.set_species(joe_type)
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"
	if(prob(5))
		new_human.grad_style = "None" //No gradients for Working Joes
		new_human.h_style = "Shoulder-length Hair" //Added the chance of hair as per Monkeyfist lore accuracy
	new_human.r_eyes = 0
	new_human.g_eyes = 0
	new_human.b_eyes = 0
	new_human.r_hair = 100
	new_human.g_hair = 88
	new_human.b_hair = 74
	new_human.r_facial = 255
	new_human.g_facial = 255
	new_human.b_facial = 255

/datum/equipment_preset/synth/working_joe/load_vanity(mob/living/carbon/human/new_human)
	return

/datum/equipment_preset/synth/working_joe/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = null
	new_human.underwear = null
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic/joe(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET) //don't remove shrap by yourself, go to android maintenance or have ARES call a human handler!
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mt(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/sling(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/working_joe_pda(new_human.back), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/spray/cleaner(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/spray/cleaner(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/glass/bucket(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/mop(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wet_sign(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/lights/mixed(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/bag/trash(new_human), WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/circuitboard/apc(new_human.back), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/circuitboard/airlock(new_human.back), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/cell(new_human.back), WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/device/lightreplacer(new_human.back), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/medium_stack(new_human.back), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/glass/reinforced/medium_stack(new_human.back), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/maintenance_jack(new_human), WEAR_J_STORE)


/datum/equipment_preset/synth/working_joe/engi
	name = "Synthetic - Hazmat Joe"
	joe_type = SYNTH_HAZARD_JOE

/datum/equipment_preset/synth/working_joe/engi/load_gear(mob/living/carbon/human/new_human)
	var/choice = rand(1,2)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/joe(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/mt(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/joe(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/inflatable/door(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/inflatable/door(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/hugetank, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/inflatable(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/inflatable(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher(new_human), WEAR_L_HAND)
	new_human.equip_to_slot_or_del(new /obj/item/maintenance_jack(new_human), WEAR_J_STORE)

	switch(choice)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic/joe/engi(new_human), WEAR_BODY)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic/joe/engi/overalls(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/sling(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/working_joe_pda(new_human.back), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/lightreplacer(new_human.back), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack(new_human.back), WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/stack/sheet/glass/reinforced/large_stack(new_human.back), WEAR_IN_R_STORE)


/datum/equipment_preset/synth/working_joe/engi/load_race(mob/living/carbon/human/new_human)
	. = ..()
	new_human.set_species(joe_type)
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"
	if(prob(5))
		new_human.grad_style = "None" //No gradients for Working Joes
		new_human.h_style = "Shoulder-length Hair" //Added the chance of hair as per Monkeyfist lore accuracy
	new_human.r_eyes = 0
	new_human.g_eyes = 0
	new_human.b_eyes = 0
	new_human.r_hair = 100
	new_human.g_hair = 88
	new_human.b_hair = 74
	new_human.r_facial = 255
	new_human.g_facial = 255
	new_human.b_facial = 255

/datum/equipment_preset/synth/working_joe/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.change_real_name(new_human, "Working Joe #[rand(100)][rand(100)]")

/datum/equipment_preset/synth/working_joe/upp
	name = "UPP Dzho Automaton"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UPP
	faction_group = list(FACTION_UPP)
	assignment = "Dzho Automaton"

/datum/equipment_preset/synth/working_joe/upp/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress(new_human), WEAR_L_EAR)
	var/random_overalls= rand(1,3)
	switch(random_overalls)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/apron/overalls/tan(new_human), WEAR_JACKET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/apron/overalls/red(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/white(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/joe(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/hugetank, WEAR_IN_JACKET)

	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/etool(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/upp/folded(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/lightreplacer(new_human.back), WEAR_IN_R_STORE)

/datum/equipment_preset/synth/working_joe/upp/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.change_real_name(new_human, "Dzho Automaton #[rand(100)][rand(100)]")

/datum/equipment_preset/synth/working_joe/upp/load_race(mob/living/carbon/human/new_human)
	. = ..()
	new_human.set_species(joe_type)
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"
	if(prob(25))
		new_human.grad_style = "None" //No gradients for Working Joes
		new_human.h_style = "Shoulder-length Hair" //Added the chance of hair as per Monkeyfist lore accuracy
	new_human.r_eyes = 0
	new_human.g_eyes = 0
	new_human.b_eyes = 0
	new_human.r_hair = 100
	new_human.g_hair = 88
	new_human.b_hair = 74
	new_human.r_facial = 255
	new_human.g_facial = 255
	new_human.b_facial = 255

//*****************************************************************************************************/

/datum/equipment_preset/synth/survivor/cultist_synth
	name = "Cultist - Xeno Cultist Synthetic"
	faction = FACTION_XENOMORPH

/datum/equipment_preset/synth/survivor/cultist_synth/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/medic
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/medic

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain/cultist(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/full/with_suture_and_graft(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)

	var/obj/item/clothing/head/cultist_hood/hood = new /obj/item/clothing/head/cultist_hood(new_human)
	hood.flags_item |= NODROP|DELONDROP
	new_human.equip_to_slot_or_del(hood, WEAR_HEAD)

//*****************************************************************************************************/

/datum/equipment_preset/synth/survivor/midwife
	name = "Fun - Xeno Cultist Midwife (Synthetic)"
	faction = FACTION_XENOMORPH

/datum/equipment_preset/synth/survivor/midwife/load_gear(mob/living/carbon/human/new_human)
	var/back_item = /obj/item/storage/backpack/marine/satchel/medic
	if (new_human.client && new_human.client.prefs && (new_human.client.prefs.backbag == 1))
		back_item = /obj/item/storage/backpack/marine/medic

	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/rank/synthetic/joe(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/latex(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new back_item(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/defibrillator, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/medical/full/with_suture_and_graft(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/device/healthanalyzer/soul(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/xenos(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/collectable/xenom(new_human), WEAR_HEAD)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/baton(new_human.back), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch(new_human), WEAR_L_EAR)


/datum/equipment_preset/synth/survivor/midwife/load_name(mob/living/carbon/human/new_human, randomise)
	var/final_name = "Midwife Joe"
	if(new_human.client && new_human.client.prefs)
		final_name = new_human.client.prefs.synthetic_name
		if(!final_name || final_name == "Undefined") //In case they don't have a name set or no prefs, there's a name.
			final_name = "Midwife Joe"
		else
			final_name = "Midwife [new_human.real_name]"
	new_human.change_real_name(new_human, final_name)

//*****************************************************************************************************/

/datum/equipment_preset/synth/infiltrator
	name = "Infiltrator Synthetic"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_NEUTRAL
	assignment = JOB_COLONIST
	rank = JOB_COLONIST
	skills = /datum/skills/infiltrator_synthetic
	idtype = /obj/item/card/id/lanyard
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/synth/infiltrator/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/synth/infiltrator/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(MALE,FEMALE)
	var/random_name
	var/first_name
	var/last_name
	var/datum/preferences/A = new()
	A.randomize_appearance(new_human)
	if(new_human.gender == MALE)
		first_name = "[pick(GLOB.first_names_male_colonist)]"
	else
		first_name ="[pick(GLOB.first_names_female_colonist)]"

	last_name ="[pick(GLOB.last_names_colonist)]"
	random_name = "[first_name] [last_name]"
	new_human.change_real_name(new_human, random_name)
	var/static/list/colors = list("BLACK" = list(15, 15, 25), "BROWN" = list(102, 51, 0), "AUBURN" = list(139, 62, 19))
	var/static/list/hair_colors = colors.Copy() + list("BLONDE" = list(197, 164, 30), "CARROT" = list(174, 69, 42))
	var/hair_color = pick(hair_colors)
	new_human.r_hair = hair_colors[hair_color][1]
	new_human.g_hair = hair_colors[hair_color][2]
	new_human.b_hair = hair_colors[hair_color][3]
	new_human.r_facial = hair_colors[hair_color][1]
	new_human.g_facial = hair_colors[hair_color][2]
	new_human.b_facial = hair_colors[hair_color][3]
	var/eye_color = pick(colors)
	new_human.r_eyes = colors[eye_color][1]
	new_human.g_eyes = colors[eye_color][2]
	new_human.b_eyes = colors[eye_color][3]

/datum/equipment_preset/synth/infiltrator/load_race(mob/living/carbon/human/new_human)
	new_human.set_species(SYNTH_INFILTRATOR)

/datum/equipment_preset/synth/infiltrator/load_skills(mob/living/carbon/human/new_human)
		new_human.set_skills(/datum/skills/infiltrator_synthetic)
		new_human.allow_gun_usage = TRUE

/datum/equipment_preset/synth/infiltrator/load_gear(mob/living/carbon/human/new_human)
	add_random_synth_infiltrator_equipment(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/nanopaste(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/nanopaste(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/stack/nanopaste(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/restraint/handcuffs/zip(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/tranquilizer(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/butterfly(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight(new_human), WEAR_IN_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/chloroform(new_human), WEAR_IN_L_STORE)

//*****************************************************************************************************/

//Combat Droids

/datum/equipment_preset/synth/working_joe/security_android
	name = "Synthetic - Security Android"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_MARINE
	faction_group = list(FACTION_MARINE)
	assignment = "Security Android"
	rank = JOB_WORKING_JOE
	skills = /datum/skills/pfc
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_APOLLO, LANGUAGE_RUSSIAN, LANGUAGE_JAPANESE, LANGUAGE_GERMAN, LANGUAGE_SPANISH, LANGUAGE_CHINESE)
	/// Used to set species when loading race

/datum/equipment_preset/synth/working_joe/security_android/New()
	. = ..()
	access = get_access(ACCESS_LIST_GLOBAL)

/datum/equipment_preset/synth/working_joe/security_android/load_race(mob/living/carbon/human/new_human)
	. = ..()
	new_human.set_species(joe_type)
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"
	if(prob(5))
		new_human.grad_style = "None" //No gradients for Working Joes
		new_human.h_style = "Shoulder-length Hair" //Added the chance of hair as per Monkeyfist lore accuracy
	new_human.r_eyes = 0
	new_human.g_eyes = 0
	new_human.b_eyes = 0
	new_human.r_hair = 100
	new_human.g_hair = 88
	new_human.b_hair = 74
	new_human.r_facial = 255
	new_human.g_facial = 255
	new_human.b_facial = 255

/datum/equipment_preset/synth/working_joe/security_android/load_vanity(mob/living/carbon/human/new_human)
	return

/datum/equipment_preset/synth/working_joe/security_android/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Marine Undershirt"
	new_human.underwear = "Marine Boxers"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/wirecutters(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/shovel/etool/folded(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/foxtrot(new_human), WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(new_human), WEAR_HEAD)
	add_uscm_cover(new_human)
	add_uscm_goggles(new_human)
	//uniform
	add_uscm_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/m3(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/preloaded(new_human), WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1(new_human), WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/jungle/knife(new_human), WEAR_FEET)
	add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

/datum/equipment_preset/synth/working_joe/security_android/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.change_real_name(new_human, "Security Android #[rand(100)][rand(100)]")

/datum/equipment_preset/synth/working_joe/upp/combat
	name = "UPP Dzho Automaton - Combat"
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_UPP
	faction_group = list(FACTION_UPP)
	assignment = "Dzho Automaton"
	skills = /datum/skills/pfc

/datum/equipment_preset/synth/working_joe/upp/combat/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "Naval Infantry Telnyashka"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/packet/high_explosive/upp/impact, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/upp, WEAR_L_EAR)
	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/upp, WEAR_HEAD)
	//uniform
	add_upp_uniform(new_human)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/standard, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/type71/preloaded, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/large_holster/machete/arnold/weak, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/type71, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)



/datum/equipment_preset/synth/working_joe/upp/combat/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.change_real_name(new_human, "Dzho Automaton #[rand(100)][rand(100)]")

/datum/equipment_preset/synth/working_joe/upp/combat/load_race(mob/living/carbon/human/new_human)
	. = ..()
	new_human.set_species(joe_type)
	new_human.h_style = "Bald"
	new_human.f_style = "Shaved"
	if(prob(25))
		new_human.grad_style = "None" //No gradients for Working Joes
		new_human.h_style = "Shoulder-length Hair" //Added the chance of hair as per Monkeyfist lore accuracy
	new_human.r_eyes = 0
	new_human.g_eyes = 0
	new_human.b_eyes = 0
	new_human.r_hair = 100
	new_human.g_hair = 88
	new_human.b_hair = 74
	new_human.r_facial = 255
	new_human.g_facial = 255
	new_human.b_facial = 255


/datum/equipment_preset/synth/working_joe/upp/combat/canc
	name = "CANC Dzho Automaton - Combat"
	faction = FACTION_CANC
	faction_group = list(FACTION_LIST_CANC)

/datum/equipment_preset/synth/working_joe/upp/combat/canc/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/upp(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/roller/bedroll(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/kitchen/can_opener(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/solardevils/canc(new_human), WEAR_L_EAR)
	if(prob(65))
		add_neckerchief(new_human)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/canc(new_human), WEAR_HEAD)
	//uniform
	add_canc_uniform(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/canc/e1(new_human), WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/faction/UPP/CANC(new_human), WEAR_JACKET)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/guard(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown(new_human), WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	add_canc_rifle(new_human)

/datum/equipment_preset/synth/working_joe/upp/combat/twe_rebel
	name = "TWE Rebel Dzho Automaton - Combat"
	faction = FACTION_TWE_REBEL
	faction_group = list(FACTION_LIST_TWE_REBEL)

/datum/equipment_preset/synth/working_joe/upp/combat/twe_rebel/load_gear(mob/living/carbon/human/new_human)
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
	if(prob(85))
		add_rebel_twe_helmet(new_human)
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_twe_suit(new_human)
	//waist
	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
	else
		new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/rmc(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	if(prob(75))
		add_rebel_twe_smg(new_human)
	else if(prob(85))
		add_rebel_twe_rifle(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)


/datum/equipment_preset/synth/working_joe/security_android/ua_rebel
	name = "Synthetic - Security Android - UA Rebel"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_UA_REBEL
	faction_group = list(FACTION_UA_REBEL)

/datum/equipment_preset/synth/working_joe/security_android/ua_rebel/load_gear(mob/living/carbon/human/new_human)
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

/datum/equipment_preset/synth/working_joe/security_android/freelancer
	name = "Synthetic - Security Android - Freelancer"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_FREELANCER
	faction_group = list(FACTION_FREELANCER)

/datum/equipment_preset/synth/working_joe/security_android/freelancer/load_gear(mob/living/carbon/human/new_human)
	//generic clothing
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/freelancer, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/faction/freelancer, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/pmc, WEAR_HANDS)
	add_merc_helmet(new_human)
	//storage and specific stuff, they all get an ERT medpouch.
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/dutch, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/ert, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/attachments(new_human), WEAR_IN_BACK)
	//storage items
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/explosive/upp, WEAR_R_STORE)
	add_merc_weapon(new_human)
	//backpack stuff
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/regular, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/stick, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/high_explosive/stick, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/regular, WEAR_IN_BACK)

/datum/equipment_preset/synth/working_joe/security_android/pmc
	name = "Synthetic - PMC Security Android"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_PMC
	faction_group = list(FACTION_PMC)

/datum/equipment_preset/synth/working_joe/security_android/pmc/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/pmc, WEAR_L_EAR)
	//head
	if(prob(45))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
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
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/rmc/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_R_STORE)

	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/tactical/ap, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine/large, WEAR_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39/ap, WEAR_IN_L_STORE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1/elite, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_L_STORE)

/datum/equipment_preset/synth/working_joe/security_android/wy
	name = "Synthetic - Weyland Security Android"
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	faction = FACTION_WY
	faction_group = list(FACTION_WY)

/datum/equipment_preset/synth/working_joe/security_android/wy/load_gear(mob/living/carbon/human/new_human)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/WY, WEAR_L_EAR)
	//head
	if(prob(25))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/weyyu, WEAR_HEAD)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/pmc/corporate, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/cyan, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/droppouch, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/ballistic, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39/solidstock, WEAR_J_STORE)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/colonist, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new 	/obj/item/ammo_magazine/pistol/vp70, WEAR_IN_BELT)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	add_worker_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/pistol/alt, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70, WEAR_IN_R_STORE)


//

/datum/equipment_preset/synth/working_joe/malf_synth
	name = "Synthetic - Working Joe - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/engi/malf_synth
	name = "Synthetic - Hazmat Joe - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/upp/malf_synth
	name = "UPP Dzho Automaton - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/security_android/freelancer/malf_synth
	name = "Synthetic - Security Android - Freelancer - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/security_android/wy/malf_synth
	name = "Synthetic - Weyland Security Android - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/security_android/pmc/malf_synth
	name = "Synthetic - PMC Security Android - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/security_android/ua_rebel/malf_synth
	name = "Synthetic - Security Android - UA Rebel - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/upp/combat/twe_rebel/malf_synth
	name = "TWE Rebel Dzho Automaton - Combat - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/upp/combat/canc/malf_synth
	name = "CANC Dzho Automaton - Combat - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/upp/combat/malf_synth
	name = "UPP Dzho Automaton - Combat - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)

/datum/equipment_preset/synth/working_joe/security_android/malf_synth
	name = "Synthetic - Security Android - Malfunction"
	faction = FACTION_MALF_SYNTH
	faction_group = list(FACTION_MALF_SYNTH)
