/datum/equipment_preset/clf
	name = "TWE Rebel"
	languages = list(LANGUAGE_JAPANESE)
	flags = EQUIPMENT_PRESET_EXTRA
	faction = FACTION_TWE_REBEL
	faction_group = FACTION_LIST_TWE_REBEL
	skills = /datum/skills/clf
	paygrades = list(PAY_SHORT_REB = JOB_PLAYTIME_TIER_0)
	origin_override = ORIGIN_CIVILIAN

/datum/equipment_preset/clf/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE)

/datum/equipment_preset/clf/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(50;MALE, 50;FEMALE)
	new_human.skin_color = "Pale 1"
	var/random_name
	var/first_name
	var/last_name
	var/static/list/colors = list("BLACK" = list(15, 15, 10), "BLACK" = list(15, 15, 10))
	var/static/list/hair_colors = list("BLACK" = list(15, 15, 10))
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
	//gender checks
	if(new_human.gender == MALE)
		if(prob(90))
			first_name = "[capitalize(randomly_generate_japanese_word(rand(1, 3)))]"
		else
			first_name = "[pick(GLOB.first_names_male_clf)]"
		new_human.h_style = pick("CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "5 O'clock Shadow", "7 O'clock Shadow",)
	else
		if(prob(90))
			first_name = "[capitalize(randomly_generate_japanese_word(rand(1, 3)))]"
		else
			first_name = "[pick(GLOB.first_names_female_clf)]"
		new_human.h_style = pick("CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right","Bun", "Short Bangs")
	//surname
	if(prob(90))
		last_name = "[capitalize(randomly_generate_japanese_word(rand(1, 4)))]"
	else
		last_name = "[pick(GLOB.last_names_clf)]"
	//put them together
	random_name = "[first_name] [last_name]"
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,45)


//*****************************************************************************************************/
/datum/equipment_preset/clf/guerilla
	name = "TWE Rebel, Guerilla"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/lanyard

/datum/equipment_preset/clf/guerilla/get_assignment(mob/living/carbon/human/new_human)
	if(prob(50))
		return "Class D Inhabitant"

	return "Class C Inhabitant"

/datum/equipment_preset/clf/guerilla/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	var/random_pistol = rand(0,1)
	switch(random_pistol)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/l54(new_human.back), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BACK)

		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/highpower(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	if(prob(95))
		add_civilian_jacket(new_human)
	//waist
	//limbs
	add_civilian_shoe(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/clf/guerilla_eva
	name = "TWE Rebel, Guerilla(EVA)"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_CIV = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/lanyard

/datum/equipment_preset/clf/guerilla_eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp(new_human), WEAR_IN_BACK)
	var/random_pistol = rand(0,2)
	switch(random_pistol)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/l54(new_human.back), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BACK)

		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70(new_human), WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/rebel_twe(new_human), WEAR_L_EAR)
	if(prob(65))
		add_facewrap(new_human)
	//head
	add_rebel_eva_helmet(new_human)
	//uniform
	add_civilian_uniform(new_human)
	//jacket
	add_rebel_eva_suit(new_human)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen, WEAR_WAIST)
	//limbs
	add_civilian_shoe(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/clf/engineer
	name = "TWE Rebel, Anti-Tank"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guardsman"
	skills = /datum/skills/clf/specialist

/datum/equipment_preset/clf/engineer/load_gear(mob/living/carbon/human/new_human)
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
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/utility_vest(new_human), WEAR_JACKET)
	//waist
	if(prob(85))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/upp/at(new_human), WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/upp/at(new_human), WEAR_IN_BELT)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/upp/at(new_human), WEAR_IN_BELT)
	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/launcher/rocket/upp(new_human), WEAR_J_STORE)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/clf/medic
	name = "TWE Rebel, Medic"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/clf/combat_medic
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guard Medic"

/datum/equipment_preset/clf/medic/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	add_random_satchel(new_human)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/canteen, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/surgical_line(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/surgery/synthgraft(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/regular(new_human), WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/softpack/adv(new_human), WEAR_IN_BACK)
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
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	if(prob(35))
		add_rebel_twe_pistol(new_human)
	else
		add_rebel_twe_smg(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)


//*****************************************************************************************************/

/datum/equipment_preset/clf/soldier
	name = "TWE Rebel, Soldier (Rifle)"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guardsman"

/datum/equipment_preset/clf/soldier/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) + list(ACCESS_CLF_ARMORY)

/datum/equipment_preset/clf/soldier/load_gear(mob/living/carbon/human/new_human)
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
	else
		add_rebel_twe_rifle(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)


/datum/equipment_preset/clf/soldier/shotgun
	name = "TWE Rebel, Soldier (Shotgun)"

/datum/equipment_preset/clf/soldier/shotgun/load_gear(mob/living/carbon/human/new_human)
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
	add_rebel_twe_shotgun(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/clf/soldier/machinegunner
	name = "TWE Rebel, Soldier (Machinegunner)"

/datum/equipment_preset/clf/soldier/machinegunner/load_gear(mob/living/carbon/human/new_human)
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
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/lmg, WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40/lmg, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40/lmg, WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40/lmg, WEAR_IN_BELT)
	//limbs
	add_rebel_twe_shoes(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/clf/soldier/flamer
	name = "TWE Rebel, Soldier (Incinerator)"
	skills = /datum/skills/clf/specialist

/datum/equipment_preset/clf/soldier/flamer/load_gear(mob/living/carbon/human/new_human)
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
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/weak, WEAR_IN_BELT)
	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/flamer/weak(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/flamer_tank/weak, WEAR_IN_R_STORE)

/datum/equipment_preset/clf/soldier/bolt
	name = "TWE Rebel, Sniper (Basira-Armstrong)"
	skills = /datum/skills/clf/sniper

/datum/equipment_preset/clf/soldier/bolt/load_gear(mob/living/carbon/human/new_human)
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

/datum/equipment_preset/clf/soldier/svd
	name = "TWE Rebel, Sniper (Type-88)"
	skills = /datum/skills/clf/sniper

/datum/equipment_preset/clf/soldier/svd/load_gear(mob/living/carbon/human/new_human)
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
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)

	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/rifle/sniper/svd(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/sniper/svd(new_human), WEAR_IN_BELT)

//*****************************************************************************************************/

/datum/equipment_preset/clf/leader
	name = "TWE Rebel, Leader"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/clf/leader
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Guard Team Leader"

/datum/equipment_preset/clf/leader/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_BASE) + list(ACCESS_CLF_ARMORY, ACCESS_CLF_LEADERSHIP, ACCESS_CLF_FLIGHT)

/datum/equipment_preset/clf/leader/load_gear(mob/living/carbon/human/new_human)
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
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/beret/guerilla(new_human), WEAR_HEAD)
	//uniform
	var/obj/item/clothing/under/marine/veteran/UPP/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/royal_marine(new_human), WEAR_JACKET)
	//waist
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	add_rebel_twe_rifle(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
//*****************************************************************************************************/

/datum/equipment_preset/clf/synth
	name = "TWE Rebel, Synthetic"
	flags = EQUIPMENT_PRESET_EXTRA
	languages = ALL_SYNTH_LANGUAGES
	skills = /datum/skills/colonial_synthetic
	assignment = JOB_CLF_SYNTH
	rank = JOB_CLF_SYNTH
	paygrades = list(PAY_SHORT_SYN = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/clf/synth/New()
	. = ..()
	access = get_access(ACCESS_LIST_CLF_ALL)

/datum/equipment_preset/clf/synth/load_race(mob/living/carbon/human/new_human)
	new_human.set_species(SYNTH_COLONY_GEN_ONE)

/datum/equipment_preset/clf/synth/load_skills(mob/living/carbon/human/new_human)
	. = ..()
	new_human.allow_gun_usage = FALSE

/datum/equipment_preset/clf/synth/load_gear(mob/living/carbon/human/new_human)
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
	//uniform
	add_rebel_twe_uniform(new_human)
	//jacket
	add_rebel_twe_suit(new_human)
	//waist
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

/datum/equipment_preset/clf/synth/combat
	name = "TWE Rebel, Synthetic (Combat)"
	flags = EQUIPMENT_PRESET_EXTRA

/datum/equipment_preset/clf/synth/combat/load_skills(mob/living/carbon/human/new_human)
	. = ..()
	new_human.allow_gun_usage = TRUE

/datum/equipment_preset/clf/synth/combat/load_gear(mob/living/carbon/human/new_human)
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
	if(prob(35))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	if(prob(35))
		add_rebel_twe_pistol(new_human)
	else if(prob(75))
		add_rebel_twe_smg(new_human)
	else if(prob(65))
		add_rebel_twe_rifle(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/clf/commander
	name = "TWE Rebel, Cell Commander"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/clf/commander
	idtype = /obj/item/card/id/dogtag
	assignment = "Revolutionary Commander"

/datum/equipment_preset/clf/commander/load_gear(mob/living/carbon/human/new_human)
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
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/beret/guerilla(new_human), WEAR_HEAD)
	//uniform
	var/obj/item/clothing/under/marine/veteran/UPP/uniform = new()
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/veteran/royal_marine/smartgun(new_human), WEAR_JACKET)
	//waist
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt/rmc(new_human), WEAR_WAIST)
	//limbs
	add_rebel_twe_shoes(new_human)
	new_human.put_in_active_hand(new /obj/item/weapon/gun/smartgun/clf(new_human))
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smartgun, WEAR_IN_R_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/night/m56_goggles/no_nightvision(new_human), WEAR_EYES)

