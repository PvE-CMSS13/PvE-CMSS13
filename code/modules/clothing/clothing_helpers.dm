/obj/item/clothing/proc/reset_armor_melee_value()
	armor_melee = initial(armor_melee)

/obj/item/clothing/proc/reset_armor_bullet_value()
	armor_bullet = initial(armor_bullet)

/obj/item/clothing/proc/reset_armor_laser_value()
	armor_laser = initial(armor_laser)

/obj/item/clothing/proc/reset_armor_energy_value()
	armor_energy = initial(armor_energy)

/obj/item/clothing/proc/reset_armor_bomb_value()
	armor_bomb = initial(armor_bomb)

/obj/item/clothing/proc/reset_armor_bio_value()
	armor_bio = initial(armor_bio)

/obj/item/clothing/proc/reset_armor_rad_value()
	armor_rad = initial(armor_rad)

/obj/item/clothing/proc/reset_armor_internaldamage_value()
	armor_internaldamage = initial(armor_internaldamage)


/obj/item/clothing/under/proc/swap_with(obj/item/clothing/under/replacement)
	var/obj/item/clothing/under/the_uniform = new replacement(loc)
	if(ishuman(loc))
		var/mob/living/carbon/human/victim = loc
		INVOKE_NEXT_TICK(victim, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot_or_del), victim.l_store, WEAR_L_STORE)
		INVOKE_NEXT_TICK(victim, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot_or_del), victim.r_store, WEAR_R_STORE)
		INVOKE_NEXT_TICK(victim, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot_or_del), victim.belt, WEAR_WAIST)
		INVOKE_NEXT_TICK(victim, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot_or_del), the_uniform, WEAR_BODY)
		if(victim.wear_suit.uniform_restricted)
			INVOKE_NEXT_TICK(victim, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot_or_del), victim.wear_suit, WEAR_JACKET)
		var/list/accessories = victim.w_uniform.accessories
		//INVOKE_NEXT_TICK(victim, TYPE_PROC_REF(/mob/living/carbon/human, equip_to_slot_or_del), new /obj/item/clothing/mask/gas/pve_mopp, WEAR_FACE)
		for(var/obj/item/clothing/accessory/passing_accessory in accessories)
			LAZYREMOVE(accessories, passing_accessory)
			INVOKE_NEXT_TICK(the_uniform, TYPE_PROC_REF(/obj/item/clothing, attach_accessory), null, passing_accessory)
		qdel(victim.w_uniform)
