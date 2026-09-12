/client/proc/editappearplayer(mob/living/carbon/human/M as mob in GLOB.human_mob_list)
	set name = "Edit Appearance | Player"
	set category = null

	if(!check_rights(R_ADMIN)) return

	if(!istype(M, /mob/living/carbon/human))
		to_chat(usr, SPAN_DANGER("You can only do this to humans!"))
		return
	switch(alert("Are you sure you wish to edit this mob's appearance?",,"Yes","No"))
		if("No")
			return

	// Changing name \\

	var/newname = input(M, "What do you want to name them?", "Name:") as null|text
	if(!newname)
		return

	if(!M)
		to_chat(usr, "This mob no longer exists")
		return

	var/old_name = M.name
	M.change_real_name(M, newname)
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(H.wear_id)
			var/obj/item/card/id/card = H.wear_id
			card.name = "[H.real_name]'s ID Card"
			card.registered_name = "[H.real_name]"
			if(card.assignment)
				card.name += " ([card.assignment])"

	message_admins("[key_name(src)] changed name of [old_name] to [newname].")

	// Changing appear \\

	var/new_skin_color = tgui_input_list(M, "Choose your character's skin color:", "Character Preferences", GLOB.skin_color_list)
	if(new_skin_color)
		M.skin_color = new_skin_color

	var/new_facial = input(M, "Please select facial hair color.", "Character Generation") as color
	if(new_facial)
		M.r_facial = hex2num(copytext(new_facial, 2, 4))
		M.g_facial = hex2num(copytext(new_facial, 4, 6))
		M.b_facial = hex2num(copytext(new_facial, 6, 8))

	var/new_hair = input(M, "Please select hair color.", "Character Generation") as color
	if(new_facial)
		M.r_hair = hex2num(copytext(new_hair, 2, 4))
		M.g_hair = hex2num(copytext(new_hair, 4, 6))
		M.b_hair = hex2num(copytext(new_hair, 6, 8))

	var/new_eyes = input(M, "Please select eye color.", "Character Generation") as color
	if(new_eyes)
		M.r_eyes = hex2num(copytext(new_eyes, 2, 4))
		M.g_eyes = hex2num(copytext(new_eyes, 4, 6))
		M.b_eyes = hex2num(copytext(new_eyes, 6, 8))


	// hair
	var/new_hstyle = input(M, "Select a hair style", "Grooming")  as null|anything in GLOB.hair_styles_list
	if(new_hstyle)
		M.h_style = new_hstyle

	// facial hair
	var/new_fstyle = input(M, "Select a facial hair style", "Grooming")  as null|anything in GLOB.facial_hair_styles_list
	if(new_fstyle)
		M.f_style = new_fstyle

	var/new_gender = alert(M, "Please select gender.", "Character Generation", "Male", "Female")
	if (new_gender)
		if(new_gender == "Male")
			M.gender = MALE
		else
			M.gender = FEMALE
	M.update_hair()
	M.update_body()
