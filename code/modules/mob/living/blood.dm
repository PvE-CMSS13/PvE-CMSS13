/*
				BLOOD SYSTEM
*/

//Makes a blood drop, leaking amt units of blood from the mob
/mob/living/carbon/proc/drip(amt)
	if(!blood_volume)
		return

	blood_volume = max(blood_volume - amt, 0)
	if(isturf(src.loc)) //Blood loss still happens in locker, floor stays clean
		if(amt >= 10)
			add_splatter_floor(loc)
		else
			add_splatter_floor(loc, TRUE)

/mob/living/carbon/human/drip(amt)
	if(in_stasis) // stasis now stops bloodloss
		return
	if((species.flags & NO_BLOOD) && !(species.flags & IS_SYNTHETIC))
		return
	..()


/mob/living/proc/restore_blood()
	blood_volume = initial(blood_volume)

/mob/living/carbon/human/restore_blood()
	blood_volume = BLOOD_VOLUME_NORMAL


/*
				BLOOD TRANSFERS
*/
//Transfers blood from container to mob
/mob/living/carbon/proc/inject_blood(obj/item/reagent_container/container, amount)
	var/b_id = get_blood_id()
	if(!b_id)
		return

	for(var/datum/reagent/blood/B in container.reagents.reagent_list)
		if(B.id == b_id)
			if(b_id == "blood" && B.data_properties && !(B.data_properties["blood_type"] in get_safe_blood(blood_type)))
				reagents.add_reagent("toxin", amount * 0.5)
			else
				blood_volume = min(blood_volume + round(amount, 0.1), limit_blood)
		else
			reagents.add_reagent(B.id, amount, B.data_properties)
			reagents.update_total()

		container.reagents.remove_reagent(B.id, amount)
		return


//Transfers blood from container to human, respecting blood types compatability.
/mob/living/carbon/human/inject_blood(obj/item/reagent_container/container, amount)
	var/datum/reagent/blood/B = locate() in container.reagents.reagent_list

	if(species && species.flags & NO_BLOOD)
		reagents.add_reagent(B.id, amount, B.data_properties)
		reagents.update_total()
		container.reagents.remove_reagent(B.id, amount)
		return

	..()


//Gets blood from mob to the container, preserving all data in it.
/mob/living/carbon/proc/take_blood(obj/O, amount)
	if(!O.reagents || amount <= 0 || blood_volume <= 0)
		return

	if(blood_volume < amount)
		amount = blood_volume

	var/b_id = get_blood_id()
	if(!b_id)
		return

	var/list/data = get_blood_data()

	O.reagents.add_reagent(b_id, amount, data)

	blood_volume = max(0, blood_volume - amount) // Removes blood if human
	return 1

/*Gets blood from mob to the container, preserving all data in it.
/mob/living/carbon/proc/take_blood_and_other_reagents(obj/O, amount)
	if(!O.reagents || amount <= 0 || blood_volume <= 0)
		return

	if(blood_volume < amount)
		amount = blood_volume

	var/b_id = get_blood_id()
	if(!b_id)
		return

	var/list/data = get_blood_data()

	O.reagents.add_reagent(b_id, amount, data)

	blood_volume = max(0, blood_volume - amount) // Removes blood if human
	return 1
*/

/mob/living/carbon/human/take_blood(obj/O, amount)
	if(species && species.flags & NO_BLOOD)
		return

	. = ..()

/mob/living/carbon/xenomorph/take_blood(obj/O, amount)
	if(!O.reagents || amount <= 0 || blood_volume <= 0)
		return

	if(blood_volume < amount)
		amount = blood_volume

	var/b_id = get_blood_id()
	if(!b_id)
		return

	var/list/plasmas = list(b_id)
	for(var/plasma in plasma_types)
		plasmas += plasma

	for(var/plasma in plasmas)
		//An even amount of each plasma and blood type
		if(plasma == PLASMA_EGG)
			//Preserve hive_number for the possible larva
			O.reagents.add_reagent(plasma, amount / length(plasmas), list("hive_number" = hivenumber))
		else
			O.reagents.add_reagent(plasma, amount / length(plasmas))

	blood_volume = max(0, blood_volume - amount)
	return 1


//////////////////////////////
//returns the data to give to the blood reagent this mob gives
/mob/living/proc/get_blood_data()
	if(!get_blood_id())
		return

	var/list/blood_data = list()

	blood_data["blood_type"] = get_blood_type()

	blood_data["blood_color"] = get_blood_color()
	blood_data["viruses"] = list()

	return blood_data


/mob/living/carbon/get_blood_data()
	var/list/blood_data = ..()
	if(!blood_data)
		return

	for(var/datum/disease/D in viruses)
		blood_data["viruses"] += D.Copy()

	if(LAZYLEN(resistances))
		blood_data["resistances"] = resistances.Copy()

	return blood_data


//returns the mob's blood type.
/mob/living/proc/get_blood_type()
	if(!get_blood_id())
		return
	return "C-"

/mob/living/carbon/get_blood_type()
	var/b_id = get_blood_id()
	if(!b_id)
		return

	switch(b_id)
		if("blood")
			return blood_type
		if("whiteblood")
			return "S*"
		if("greyblood")
			return "Z*"
		if("greenblood")
			return "Y*"
		if("xenoblood")
			return "X*"


//returns the color of the mob's blood
/mob/living/proc/get_blood_color()
	return BLOOD_COLOR_HUMAN

/mob/living/carbon/xenomorph/get_blood_color()
	if(caste && caste.royal_caste)
		return BLOOD_COLOR_XENO_ROYAL
	return BLOOD_COLOR_XENO

/mob/living/carbon/human/get_blood_color()
	return species.blood_color


//get the id of the substance this mob uses as blood.
/mob/proc/get_blood_id()
	return

/mob/living/carbon/xenomorph/get_blood_id()
	if(special_blood)
		return special_blood
	if(caste.royal_caste)
		return "xenobloodroyal"
	else
		return "xenoblood"

/mob/living/carbon/human/get_blood_id()
	if(species.flags & NO_BLOOD)
		return
	if(special_blood)
		return special_blood
	if(species.name == "Yautja")
		return "greenblood"
	if(species.flags & IS_SYNTHETIC)
		return "whiteblood"
	if(species.name == SPECIES_ZOMBIE)
		return "greyblood"
	return "blood"

/mob/living/simple_animal/mouse/get_blood_id()
	return "blood"

/mob/living/simple_animal/cat/get_blood_id()
	return "blood"

/mob/living/simple_animal/cow/get_blood_id()
	return "blood"

/mob/living/simple_animal/parrot/get_blood_id()
	return "blood"

/mob/living/simple_animal/corgi/get_blood_id()
	return "blood"

/mob/living/simple_animal/hostile/retaliate/goat/get_blood_id()
	return "blood"


// This is has more potential uses, and is probably faster than the old proc.
/proc/get_safe_blood(bloodtype)
	. = list()
	if(!bloodtype)
		return
	switch(bloodtype)
		if("A-")
			return list("A-", "O-")
		if("A+")
			return list("A-", "A+", "O-", "O+")
		if("B-")
			return list("B-", "O-")
		if("B+")
			return list("B-", "B+", "O-", "O+")
		if("AB-")
			return list("A-", "B-", "O-", "AB-")
		if("AB+")
			return list("A-", "A+", "B-", "B+", "O-", "O+", "AB-", "AB+")
		if("O-")
			return list("O-")
		if("O+")
			return list("O-", "O+")


/////////////////// add_splatter_floor ////////////////////////////////////////
//to add a splatter of blood or other mob liquid.
/mob/living/proc/add_splatter_floor(turf/T, small_drip, b_color)
	if(!T)
		T = get_turf(src)

	if(!T.can_bloody)
		return
	if(small_drip)
		// Only a certain number of drips (or one large splatter) can be on a given turf.
		var/obj/effect/decal/cleanable/blood/drip/drop = locate() in T
		if(drop)
			if(drop.drips < 1)
				drop.drips++
				drop.overlays |= pick(drop.random_icon_states)
				return
			else
				qdel(drop)//the drip is replaced by a bigger splatter
		else
			drop = new(T, b_color)
			return

	// Find a blood decal or create a new one.
	var/obj/effect/decal/cleanable/blood/B = locate() in T
	if(!B)
		B = new /obj/effect/decal/cleanable/blood/splatter(T, b_color)


/mob/living/carbon/human/add_splatter_floor(turf/T, small_drip, b_color)
	if(isnull(b_color))
		b_color = species.blood_color

	..()

/mob/living/carbon/xenomorph/add_splatter_floor(turf/T, small_drip, b_color)
	if(!T)
		T = get_turf(src)

	if(!T.can_bloody)
		return

	var/obj/effect/decal/cleanable/blood/xeno/XB = locate() in T.contents
	if(!XB)
		XB = new(T)
		XB.color = get_blood_color()


/mob/living/silicon/robot/add_splatter_floor(turf/T, small_drip, b_color)
	if(!T)
		T = get_turf(src)

	if(!T.can_bloody)
		return

	var/obj/effect/decal/cleanable/blood/oil/O = locate() in T.contents
	if(!O)
		O = new(T)

/mob/living/carbon/human/proc/spray_blood(spray_angle_offset, limb)
	var/angle = 0
	var/obj/limb/O = limb
	var/newdir = src.dir

	if(O.body_part == BODY_FLAG_ARM_LEFT || O.body_part == BODY_FLAG_LEG_LEFT || O.body_part == BODY_FLAG_HAND_LEFT || O.body_part == BODY_FLAG_FOOT_LEFT)
		newdir = turn(dir, 90) // Turn left
	else if(O.body_part == BODY_FLAG_ARM_RIGHT || O.body_part == BODY_FLAG_LEG_RIGHT || O.body_part == BODY_FLAG_HAND_RIGHT || O.body_part == BODY_FLAG_FOOT_RIGHT)
		newdir = turn(dir, -90) // Turn right

	angle = ((dir2angle(newdir)+90)+spray_angle_offset) % 360
	newdir = angle2dir(angle)

	visible_message(\
			SPAN_WARNING("You see a gush of blood spray from [src]'s [O.display_name]!"),
			SPAN_HIGHDANGER("Blood sprays from your [O.display_name]!"),
			SPAN_HIGHDANGER("You hear something fleshy gush!"))
	for(var/i = 1 to (floor(src.blood_volume / 160)))
		var/reverse_odd_numbered_decals
		if(i % 2 != 0)
			reverse_odd_numbered_decals = 1
		else
			reverse_odd_numbered_decals = -1
		// total pixel shift
		var/decal_pixel_y = 32 * sin(angle) * (i)
		var/decal_pixel_x = (((32 * cos(angle)) * reverse_odd_numbered_decals * (i)) * reverse_odd_numbered_decals) * -1

		// it gets weird if it is at 31.1 or so pixels, goes a tile more than needed // fix later
		var/tile_offset_x = 0
		if( abs(decal_pixel_x) > 31 )
			tile_offset_x = (decal_pixel_x >= 0 ? floor(decal_pixel_x / world.icon_size) : ceil(decal_pixel_x / world.icon_size))

		var/tile_offset_y = 0
		if( abs(decal_pixel_y) > 31 )
			tile_offset_y = (decal_pixel_y >= 0 ? floor(decal_pixel_y / world.icon_size) : ceil(decal_pixel_y / world.icon_size))

		var/turf/new_turf = get_turf(locate(src.x + tile_offset_x, src.y + tile_offset_y, src.z))

		if(new_turf.density)
			break
		for(var/mob/living/carbon/human/sprayed_with_blood in new_turf.contents)
			if(ishuman_strict(sprayed_with_blood))
				if(sprayed_with_blood != src)
					if(!sprayed_with_blood.body_position == LYING_DOWN)
						sprayed_with_blood.add_mob_blood(src)
						if(sprayed_with_blood.dir in get_related_directions(get_dir(sprayed_with_blood, src)))
							var/total_eye_protection = 0
							for(var/obj/item/clothing/glasses in list(sprayed_with_blood.glasses, sprayed_with_blood.wear_mask, sprayed_with_blood.head))
								if(glasses && (glasses.flags_armor_protection & BODY_FLAG_EYES) || sprayed_with_blood.get_eye_protection())
									total_eye_protection++
							if(total_eye_protection)
								to_chat(sprayed_with_blood, SPAN_HIGHDANGER("Blood sprays against your eyewear!"))
								sprayed_with_blood.EyeBlur(2)
							else
								to_chat(sprayed_with_blood, SPAN_HIGHDANGER("You are sprayed in the eyes with blood!"))
								sprayed_with_blood.EyeBlur(14)
						sprayed_with_blood.visible_message(SPAN_WARNING("[sprayed_with_blood] is hit by the spray of blood!")	)
						break

		// remainder within the tile.
		var/obj/effect/decal/cleanable/blood/squirt/blood_spraying = new /obj/effect/decal/cleanable/blood/squirt(new_turf)
		blood_spraying.pixel_x = decal_pixel_x % world.icon_size
		blood_spraying.pixel_y = decal_pixel_y % world.icon_size
		blood_spraying.apply_transform(turn(transform, angle))

		if(src.body_position == LYING_DOWN) // I don't know why it turns 90° when the human is down. Don't ask
			blood_spraying.apply_transform(turn(transform, angle+90))

		if(i == floor((src.blood_volume / 170)))
			blood_spraying.icon_state = "spatter4"
		else
			blood_spraying.icon_state = "squirt4"
		blood_spraying.color = get_blood_color()
		blood_spraying.pixel_x = blood_spraying.pixel_x + rand(-1, 1)
		blood_spraying.pixel_y = blood_spraying.pixel_y + rand(-1, 1)
		playsound(src, 'sound/effects/blood_squirt.ogg', 40, TRUE)


/obj/effect/decal/cleanable/blood/squirt
	allow_this_to_overlap = TRUE

