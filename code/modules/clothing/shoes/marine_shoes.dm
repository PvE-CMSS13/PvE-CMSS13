

/obj/item/clothing/shoes/marine
	name = "\improper USCM combat boots"
	desc = "A pair of standard issue black United States Colonial Marine combat boots."
	icon_state = "marine"
	item_state = "marine"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	siemens_coefficient = 0.7
	var/armor_stage = 0
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/holdout,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/tool/screwdriver,
		/obj/item/tool/surgery/scalpel,
		/obj/item/weapon/straight_razor,
		/obj/item/weapon/knife/marine,
	)
	drop_sound = "armorequip"

/obj/item/clothing/shoes/marine/update_icon()
	if(!armor_stage)
		if(stored_item)
			icon_state = "[initial(icon_state)]-1"
		else
			icon_state = initial(icon_state)

/obj/item/clothing/shoes/marine/knife
	spawn_item_type = /obj/item/weapon/knife/marine

/obj/item/clothing/shoes/marine/brown
	icon_state = "marine_brown"
	desc = "A pair of standard issue brown United States Colonial Marine combat boots."

/obj/item/clothing/shoes/marine/brown/knife
	spawn_item_type = /obj/item/weapon/knife/marine

/obj/item/clothing/shoes/marine/jungle
	icon_state = "marine_jungle"
	desc = "A pair of standard issue United States Colonial Marine jungle boots. Don't go walkin' slow, the devil's on the loose."

/obj/item/clothing/shoes/marine/jungle/knife
	spawn_item_type = /obj/item/weapon/knife/marine

/obj/item/clothing/shoes/marine/army
	name = "\improper US Army combat boots"
	desc = "A pair of standard issue black United States Army combat boots."

/obj/item/clothing/shoes/marine/army/knife
	spawn_item_type = /obj/item/weapon/knife/marine/baker

/obj/item/clothing/shoes/marine/upp
	name = "\improper UPP combat boots"
	desc = "A pair of standard issue black UPP Naval Infantry combat boots."
	spawn_item_type = /obj/item/attachable/bayonet/upp

/obj/item/clothing/shoes/marine/upp/guard
	desc = "A pair of standard issue brown UPP Territorial Guard combat boots."
	icon_state = "marine_brown"
	spawn_item_type = /obj/item/attachable/bayonet/upp

/obj/item/clothing/shoes/marine/upp/guard/canc
	spawn_item_type = /obj/item/attachable/bayonet/canc

/obj/item/clothing/shoes/marine/pve_mopp
	name = "\improper M2 MOPP boots"
	desc = "M2 MOPP boots excel at keeping viscera or other biological contaminants away from your feet."
	icon_state = "cbrn"
	item_state = "cbrn"
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS

/obj/item/clothing/shoes/veteran/pmc
	name = "polished shoes"
	desc = "The height of fashion, but these look to be woven with protective fiber."
	icon_state = "jackboots"
	item_state = "jackboots"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	flags_inventory = FPRINT|NOSLIPPING
	siemens_coefficient = 0.6
	allowed_items_typecache = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
		/obj/item/weapon/gun/pistol/clfpistol,
		/obj/item/weapon/straight_razor,
	)

/obj/item/clothing/shoes/veteran/pmc/update_icon()
	if(stored_item)
		icon_state = "[initial(icon_state)]-1"
	else
		icon_state = initial(icon_state)

/obj/item/clothing/shoes/veteran/pmc/knife
	spawn_item_type = /obj/item/attachable/bayonet/wy

/obj/item/clothing/shoes/veteran/pmc/commando
	name = "\improper W-Y commando boots"
	desc = "A pair of heavily armored, acid-resistant boots."

	armor_bio = CLOTHING_ARMOR_HIGH
	siemens_coefficient = 0.2
	unacidable = TRUE

/obj/item/clothing/shoes/veteran/pmc/commando/knife
	spawn_item_type = /obj/item/attachable/bayonet/wy

/obj/item/clothing/shoes/veteran/pmc/combat_android
	name = "\improper M7X greaves"
	desc = "A pair of heavily armored, acid-resistant boots, made to complete the M7X Apesuit."
	icon_state = "droid_boots"
	item_state = "droid_boots"
	armor_bio = CLOTHING_ARMOR_HIGH
	siemens_coefficient = 0.2
	unacidable = TRUE
	spawn_item_type = /obj/item/attachable/bayonet/wy

/obj/item/clothing/shoes/veteran/pmc/combat_android/dark
	name = "\improper M7X Mark II greaves"
	desc = "A pair of heavily armored, optical camouflaged, acid-resistant boots, made to complete the M7X Mark II Apesuit."
	icon_state = "invis_droid_boots"
	item_state = "invis_droid_boots"

/obj/item/clothing/shoes/marine/rmc
	name = "\improper RMC combat boots"
	desc = "A pair of standard issue black Royal Marine Commando combat boots."
	icon_state = "marine"

/obj/item/clothing/shoes/marine/rmc/knife
	spawn_item_type = /obj/item/weapon/knife/marine/sas

/obj/item/clothing/shoes/marine/civilian
	name = "rugged boots"
	desc = "A pair of black boots not so dissimilar from military combat boots, a likely culprit for their inspiration. They'll get the job done, whether that's hiking, or kicking in teeth."

/obj/item/clothing/shoes/marine/civilian/knife
	spawn_item_type = /obj/item/attachable/bayonet

/obj/item/clothing/shoes/marine/civilian/brown
	icon_state = "marine_brown"
	desc = "A pair of brown boots not so dissimilar from military combat boots, a likely culprit for their inspiration. They'll get the job done, whether that's hiking, or kicking in teeth."

/obj/item/clothing/shoes/marine/civilian/jungle
	icon_state = "marine_jungle"
	desc = "A pair of jungle boots not so dissimilar from military combat boots, a likely culprit for their inspiration. They'll get the job done, whether that's hiking, or kicking in teeth."

/obj/item/clothing/shoes/marine/joe
	name = "biohazard boots"
	desc = "A pair of utilitarian biohazard boots."
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW

/obj/item/clothing/shoes/marine/mopp
	name = "\improper M3 MOPP boots"
	desc = "M2 MOPP boots excel at keeping viscera or other biological contaminants away from your feet."
	icon_state = "cbrn"
	item_state = "cbrn"
	min_cold_protection_temperature = SHOE_MIN_COLD_PROT
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROT
	flags_cold_protection = BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_FEET
	armor_rad = CLOTHING_ARMOR_GIGAHIGHPLUS
	armor_bio = CLOTHING_ARMOR_GIGAHIGHPLUS

/obj/item/clothing/shoes/stompers
	name = "Reebok Stompers"
	desc = "A pair of sneakers designed to elicit a morale boosting response within anyone that witnesses them."
	icon_state = "stompers"
	flags_inventory = NOSLIPPING

/obj/item/clothing/shoes/cowboy
	name = "leather boots"
	desc = "A pair of leather cowboy boots."
	icon_state = "cowboy"

/obj/item/clothing/shoes/lizardskin
	name = "lizardskin boots"
	desc = "A pair of lizardskin cowboy boots. Get your disco on, baby."
	icon_state = "lizardskin"
