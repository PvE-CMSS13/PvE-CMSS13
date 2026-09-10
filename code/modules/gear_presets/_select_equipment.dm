#define EQUIPMENT_PRESET_STUB 0
#define EQUIPMENT_PRESET_START_OF_ROUND (1<<0)
#define EQUIPMENT_PRESET_EXTRA (1<<1)
#define EQUIPMENT_PRESET_START_OF_ROUND_WO (1<<2)
#define EQUIPMENT_PRESET_MARINE (1<<3)
#define AMERICAN_ETHNICITY "American"
#define LATIN_AMERICAN_ETHNICITY "Latin-American"
#define JAPANESE_ETHNICITY "Japanese"
#define UPP_ETHNICITY "Progressive"
#define CHINESE_ETHNICITY "Chinese"
#define BRAZILIAN_ETHNICITY "Brazilian"

/datum/equipment_preset
	var/name = "Preset"
	var/flags = EQUIPMENT_PRESET_STUB
	var/uses_special_name = FALSE //For equipment that loads special name, aka Synths, Yautja, Death Squad, etc.
	var/ethnicity = AMERICAN_ETHNICITY
	var/list/languages = list(LANGUAGE_ENGLISH)
	var/skills
	var/idtype = /obj/item/card/id
	var/list/access = list()
	var/assignment
	var/rank
	var/list/paygrades = list("???")
	var/role_comm_title
	var/minimum_age
	var/faction = FACTION_NEUTRAL
	var/list/faction_group
	var/origin_override

	var/minimap_icon = "private"
	var/minimap_background = MINIMAP_ICON_BACKGROUND_USCM
	var/always_minimap_visible = TRUE

	//Uniform data
	var/utility_under = null
	var/utility_over = null
	var/utility_gloves = null
	var/utility_shoes = null
	var/utility_hat = null
	var/utility_extra = null

	var/service_under = null
	var/service_over = null
	var/service_shoes = null
	var/service_hat = null
	var/service_gloves = null
	var/service_extra = null

	var/dress_under = null
	var/dress_over = null
	var/dress_shoes = null
	var/dress_hat = null
	var/dress_gloves = null
	var/dress_extra = null

	var/list/uniform_sets = null



/datum/equipment_preset/New()
	uniform_sets = list(
		UNIFORM_VEND_UTILITY_UNIFORM = utility_under,
		UNIFORM_VEND_UTILITY_JACKET = utility_over,
		UNIFORM_VEND_UTILITY_HEAD = utility_hat,
		UNIFORM_VEND_UTILITY_GLOVES = utility_gloves,
		UNIFORM_VEND_UTILITY_SHOES = utility_shoes,
		UNIFORM_VEND_UTILITY_EXTRA = utility_extra,

		UNIFORM_VEND_SERVICE_UNIFORM = service_under,
		UNIFORM_VEND_SERVICE_JACKET = service_over,
		UNIFORM_VEND_SERVICE_HEAD = service_hat,
		UNIFORM_VEND_SERVICE_GLOVES = service_gloves,
		UNIFORM_VEND_SERVICE_SHOES = service_shoes,
		UNIFORM_VEND_SERVICE_EXTRA = service_extra,

		UNIFORM_VEND_DRESS_UNIFORM = dress_under,
		UNIFORM_VEND_DRESS_JACKET = dress_over,
		UNIFORM_VEND_DRESS_HEAD = dress_hat,
		UNIFORM_VEND_DRESS_GLOVES = dress_gloves,
		UNIFORM_VEND_DRESS_SHOES = dress_shoes,
		UNIFORM_VEND_DRESS_EXTRA = dress_extra
	)

	if(!faction_group)
		faction_group = list(faction)

	//load_appearance()
/datum/equipment_preset/proc/load_race(mob/living/carbon/human/new_human, client/mob_client)
	return

/datum/equipment_preset/proc/load_name(mob/living/carbon/human/new_human, randomise, client/mob_client)
	var/random_name
	var/first_name
	var/last_name
	new_human.gender = pick(60;MALE,40;FEMALE)
	switch(ethnicity)
		if(LATIN_AMERICAN_ETHNICITY)
			new_human.skin_color = pick(45;"Tan 3",10;"Tan 2",15;"Dark 1",10;"Dark 3",10;"Melanated",5;"Pale 3",5;"Pale 2")
			random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male_spanish : GLOB.first_names_female_spanish)) + " " + capitalize(pick(GLOB.last_names_spanish))
			var/static/list/colors = list("BLACK" = list(15, 15, 10), "BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
			var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
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
			if(new_human.gender == MALE)
				new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")
				new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
			else
				new_human.h_style = pick("Undercut, Top", "CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right", "Scully", "Pvt. Redding", "Bun", "Short Bangs")
			new_human.change_real_name(new_human, random_name)
		if(JAPANESE_ETHNICITY)
			new_human.skin_color = pick(50;"Pale 1",50;"Tan 1")
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
			random_name = "[first_name] [last_name]"
			new_human.change_real_name(new_human, random_name)
		if(AMERICAN_ETHNICITY)
			random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
			var/datum/preferences/A = new
			A.randomize_appearance(new_human)
			var/static/list/colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
			var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
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
			if(new_human.gender == MALE)
				new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")
				new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
			else
				new_human.h_style = pick("Undercut, Top", "CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right", "Scully", "Pvt. Redding", "Bun", "Short Bangs")
			new_human.change_real_name(new_human, random_name)
		if(UPP_ETHNICITY)
			var/datum/preferences/A = new()
			A.randomize_appearance(new_human)
			//gender checks
			if(new_human.gender == MALE)
				if(prob(40))
					first_name = "[capitalize(randomly_generate_chinese_word(1))]"
				else
					first_name = "[pick(GLOB.first_names_male_upp)]"
				new_human.f_style = pick("3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache")
			else
				if(prob(40))
					first_name = "[capitalize(randomly_generate_chinese_word(1))]"
				else
					first_name = "[pick(GLOB.first_names_female_upp)]"
			//surname
			if(prob(35))
				last_name = "[capitalize(randomly_generate_chinese_word(pick(20;1, 80;2)))]"
			else
				last_name = "[pick(GLOB.last_names_upp)]"
			//put them together
			random_name = "[first_name] [last_name]"
			new_human.change_real_name(new_human, random_name)
			var/static/list/colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
			var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
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
			if(new_human.gender == MALE)
				new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")
				new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
			else
				new_human.h_style = pick("Undercut, Top", "CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right", "Scully", "Pvt. Redding", "Bun", "Short Bangs")
		if(CHINESE_ETHNICITY)
			new_human.skin_color = pick(50;"Pale 1",50;"Tan 1")
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
				first_name = "[capitalize(randomly_generate_chinese_word(rand(1, 3)))]"
				new_human.h_style = pick("CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right")
				new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "5 O'clock Shadow", "7 O'clock Shadow",)
			else
				first_name = "[capitalize(randomly_generate_chinese_word(rand(1, 3)))]"
				new_human.h_style = pick("CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right","Bun", "Short Bangs")
			//surname
			last_name = "[capitalize(randomly_generate_chinese_word(rand(1, 4)))]"
			random_name = "[first_name] [last_name]"
			new_human.change_real_name(new_human, random_name)
		if(BRAZILIAN_ETHNICITY)
			new_human.skin_color = pick(45;"Tan 3",10;"Tan 2",15;"Dark 1",10;"Dark 3",10;"Melanated",5;"Pale 3",5;"Pale 2")
			random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male_brazilian : GLOB.first_names_female_brazilian)) + " " + capitalize(pick(GLOB.last_names_brazilian))
			var/static/list/colors = list("BLACK" = list(15, 15, 10), "BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
			var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
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
			if(new_human.gender == MALE)
				new_human.h_style = pick("Undercut, Top", "Partly Shaved", "CIA", "Mulder", "Medium Fade", "High Fade", "Pixie Cut Left", "Pixie Cut Right", "Coffee House Cut")
				new_human.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
			else
				new_human.h_style = pick("Undercut, Top", "CIA", "Mulder", "Pixie Cut Left", "Pixie Cut Right", "Scully", "Pvt. Redding", "Bun", "Short Bangs")
			new_human.change_real_name(new_human, random_name)
	new_human.age = rand(18,55)

/datum/equipment_preset/proc/load_age(mob/living/carbon/human/new_human, client/mob_client)
	if(minimum_age && new_human.age < minimum_age)
		new_human.age = minimum_age

/datum/equipment_preset/proc/load_rank(mob/living/carbon/human/new_human, client/mob_client)//Beagle-Code
	if(paygrades.len == 1)
		return paygrades[1]
	var/playtime
	if(!mob_client)
		playtime = JOB_PLAYTIME_TIER_1
	else
		playtime = get_job_playtime(mob_client, rank)
		if((playtime >= JOB_PLAYTIME_TIER_1) && !mob_client.prefs.playtime_perks)
			playtime = JOB_PLAYTIME_TIER_1
	var/final_paygrade
	for(var/current_paygrade as anything in paygrades)
		var/required_time = paygrades[current_paygrade]
		if(required_time - playtime > 0)
			break
		final_paygrade = current_paygrade
	if(rank == JOB_SQUAD_MARINE && final_paygrade == PAY_SHORT_ME3)
		if(GLOB.data_core.leveled_riflemen > GLOB.data_core.leveled_riflemen_max)
			return PAY_SHORT_ME2
		else
			GLOB.data_core.leveled_riflemen++
			return final_paygrade
	if(!final_paygrade)
		. = "???"
		CRASH("[key_name(new_human)] spawned with no valid paygrade.")

	return final_paygrade

/datum/equipment_preset/proc/load_gear(mob/living/carbon/human/new_human, client/mob_client)
	return

/datum/equipment_preset/proc/load_status(mob/living/carbon/human/new_human, client/mob_client)
	return

/datum/equipment_preset/proc/load_skills(mob/living/carbon/human/new_human, client/mob_client)
	new_human.set_skills(skills)

/datum/equipment_preset/proc/load_id(mob/living/carbon/human/new_human, client/mob_client)
	if(!idtype)
		return
	if(!mob_client)
		mob_client = new_human.client
	var/obj/item/card/id/ID = new idtype()
	ID.name = "[new_human.real_name]'s [ID.card_name]"
	if(get_assignment(new_human))
		ID.name += " ([get_assignment(new_human)])"
	ID.access = access.Copy(1, 0)
	ID.faction = faction
	ID.faction_group = faction_group.Copy()
	ID.assignment = get_assignment(new_human)
	ID.rank = rank
	ID.registered_name = new_human.real_name
	ID.registered_ref = WEAKREF(new_human)
	ID.registered_gid = new_human.gid
	ID.blood_type = new_human.blood_type
	ID.paygrade = load_rank(new_human, mob_client) || ID.paygrade
	var/datum/money_account/acct = create_account(new_human, rand(30, 50), GLOB.paygrades[ID.paygrade])
	ID.associated_account_number = acct.account_number
	ID.uniform_sets = uniform_sets
	new_human.equip_to_slot_or_del(ID, WEAR_ID)
	new_human.faction = faction
	new_human.faction_group = faction_group.Copy()
	if(new_human.mind)
		new_human.mind.name = new_human.real_name
		// Bank account details handled in generate_money_account()
	new_human.job = rank
	new_human.title = assignment
	new_human.comm_title = role_comm_title

/datum/equipment_preset/proc/get_assignment(mob/living/carbon/human/new_human)
	return assignment

/datum/equipment_preset/proc/load_languages(mob/living/carbon/human/new_human, client/mob_client)
	new_human.set_languages(languages)

/datum/equipment_preset/proc/load_preset(mob/living/carbon/human/new_human, randomise = FALSE, count_participant = FALSE, client/mob_client, show_job_gear = TRUE, late_join)
	if(!new_human.hud_used)
		new_human.create_hud()

	load_race(new_human, mob_client)
	if(randomise || uses_special_name)
		load_name(new_human, randomise, mob_client)
	else if(origin_override)
		var/datum/origin/origin = GLOB.origins[origin_override]
		new_human.name = origin.correct_name(new_human.name, new_human.gender)
	if(origin_override)
		new_human.origin = origin_override
	load_skills(new_human, mob_client) //skills are set before equipment because of skill restrictions on certain clothes.
	load_languages(new_human, mob_client)
	load_age(new_human, mob_client)
	load_id(new_human, mob_client)
	if(show_job_gear)
		load_gear(new_human, mob_client)
	load_status(new_human, mob_client)
	INVOKE_NEXT_TICK(src, PROC_REF(do_vanity), new_human, mob_client)

	load_traits(new_human, mob_client)
	if(GLOB.round_statistics && count_participant)
		GLOB.round_statistics.track_new_participant(faction)

	new_human.assigned_equipment_preset = src

	new_human.regenerate_icons()

	handle_late_join(new_human, late_join)

	new_human.marine_points = MARINE_TOTAL_BUY_POINTS //resetting buy points
	new_human.marine_snowflake_points = MARINE_TOTAL_SNOWFLAKE_POINTS
	new_human.marine_buyable_categories = MARINE_CAN_BUY_ALL
	new_human.hud_set_squad()
	new_human.add_to_all_mob_huds()

	// Every AI with a preset should appraise inventory on spawn
	var/datum/human_ai_brain/ai_brain = new_human.get_ai_brain()
	if(ai_brain)
		ai_brain.appraise_inventory()

/datum/equipment_preset/proc/do_vanity(mob/living/carbon/human/new_human, client/mob_client)
	var/turf/T = get_turf(new_human)
	if(!T)
		return
	if(is_mainship_level(T.z))
		spawn_vanity_in_personal_lockers(new_human, mob_client)
	else
		load_vanity(new_human, mob_client)

	EquipCustomItems(new_human)

/datum/equipment_preset/proc/load_vanity(mob/living/carbon/human/new_human, client/mob_client)
	if(!new_human.client || !new_human.client.prefs || !new_human.client.prefs.gear)
		return//We want to equip them with custom stuff second, after they are equipped with everything else.
	for(var/gear_name in new_human.client.prefs.gear)
		var/datum/gear/current_gear = GLOB.gear_datums_by_name[gear_name]
		if(current_gear)
			if(current_gear.allowed_roles && !(assignment in current_gear.allowed_roles))
				to_chat(new_human, SPAN_WARNING("Custom gear [current_gear.display_name] cannot be equipped: Invalid Role"))
				return
			if(current_gear.allowed_origins && !(new_human.origin in current_gear.allowed_origins))
				to_chat(new_human, SPAN_WARNING("Custom gear [current_gear.display_name] cannot be equipped: Invalid Origin"))
				return
			if(!current_gear.special_conditions())
				to_chat(new_human, SPAN_WARNING("Custom gear [current_gear.display_name] cannot be equipped: Special conditions not met."))
				return
			if(!(current_gear.slot && new_human.equip_to_slot_or_del(new current_gear.path, current_gear.slot)))
				var/obj/equipping_gear = new current_gear.path
				new_human.equip_to_slot_or_del(equipping_gear, WEAR_IN_BACK)

	//Gives ranks to the ranked
	var/current_rank = paygrades[1]
	var/obj/item/card/id/I = new_human.get_idcard()
	if(I)
		current_rank = I.paygrade
	if(new_human.w_uniform && current_rank)
		var/rankpath = get_rank_pins(current_rank)
		if(rankpath)
			var/obj/item/clothing/accessory/ranks/R = new rankpath()
			if(new_human.wear_suit && new_human.wear_suit.can_attach_accessory(R))
				new_human.wear_suit.attach_accessory(new_human, R, TRUE)
			else if(new_human.w_uniform && new_human.w_uniform.can_attach_accessory(R))
				new_human.w_uniform.attach_accessory(new_human, R, TRUE)
			else
				qdel(R)

	if(flags & EQUIPMENT_PRESET_MARINE)
		var/playtime = get_job_playtime(new_human.client, rank)
		var/medal_type

		switch(playtime)
			if(JOB_PLAYTIME_TIER_1 to JOB_PLAYTIME_TIER_2)
				medal_type = /obj/item/clothing/accessory/medal/bronze/service
			if(JOB_PLAYTIME_TIER_2 to JOB_PLAYTIME_TIER_3)
				medal_type = /obj/item/clothing/accessory/medal/silver/service
			if(JOB_PLAYTIME_TIER_3 to JOB_PLAYTIME_TIER_4)
				medal_type = /obj/item/clothing/accessory/medal/gold/service
			if(JOB_PLAYTIME_TIER_4 to INFINITY)
				medal_type = /obj/item/clothing/accessory/medal/platinum/service

		if(!new_human.client.prefs.playtime_perks)
			medal_type = null

		if(medal_type)
			var/obj/item/clothing/accessory/medal/medal = new medal_type()
			medal.recipient_name = new_human.real_name
			medal.recipient_rank = assignment

			if(new_human.wear_suit && new_human.wear_suit.can_attach_accessory(medal))
				new_human.wear_suit.attach_accessory(new_human, medal, TRUE)
			else if(new_human.w_uniform && new_human.w_uniform.can_attach_accessory(medal))
				new_human.w_uniform.attach_accessory(new_human, medal, TRUE)
			else
				if(!new_human.equip_to_slot_if_possible(medal, WEAR_IN_BACK, disable_warning = TRUE))
					if(!new_human.equip_to_slot_if_possible(medal, WEAR_L_HAND))
						if(!new_human.equip_to_slot_if_possible(medal, WEAR_R_HAND))
							medal.forceMove(new_human.loc)


	//Gives glasses to the vision impaired
	if(new_human.disabilities & NEARSIGHTED)
		var/obj/item/clothing/glasses/regular/P = new /obj/item/clothing/glasses/regular()
		if(!new_human.equip_to_slot_if_possible(P, WEAR_EYES))
			if(istype(new_human.glasses, /obj/item/clothing/glasses))
				var/obj/item/clothing/glasses/EYES = new_human.glasses
				if(EYES.prescription) //if they already have prescription glasses they don't need new ones
					return
			if(!new_human.equip_to_slot_if_possible(P, WEAR_IN_BACK))
				if(!new_human.equip_to_slot_if_possible(P, WEAR_L_HAND))
					if(!new_human.equip_to_slot_if_possible(P, WEAR_R_HAND))
						P.forceMove(new_human.loc)

GLOBAL_LIST_EMPTY(personal_closets)

/datum/equipment_preset/proc/spawn_vanity_in_personal_lockers(mob/living/carbon/human/new_human, client/mob_client)
	var/obj/structure/closet/secure_closet/marine_personal/closet_to_spawn_in
	if(!new_human?.client?.prefs?.gear)
		return//We want to equip them with custom stuff second, after they are equipped with everything else.
	for(var/obj/structure/closet/secure_closet/marine_personal/closet in GLOB.personal_closets)
		if(closet.owner)
			continue
		if(closet.linked_spawn_turf)
			if(new_human.loc != closet.linked_spawn_turf)
				continue
		else if(new_human.job != closet.job)
			continue

		closet.owner = new_human.real_name
		closet_to_spawn_in = closet
		closet_to_spawn_in.name = "[closet_to_spawn_in.owner]'s personal locker"
		break
	if(!closet_to_spawn_in)
		load_vanity(new_human, mob_client)
		return

	for(var/gear_name in new_human.client.prefs.gear)
		var/datum/gear/current_gear = GLOB.gear_datums_by_name[gear_name]
		if(current_gear)
			if(current_gear.allowed_roles && !(assignment in current_gear.allowed_roles))
				to_chat(new_human, SPAN_WARNING("Custom gear [current_gear.display_name] cannot be equipped: Invalid Role"))
				return
			if(current_gear.allowed_origins && !(new_human.origin in current_gear.allowed_origins))
				to_chat(new_human, SPAN_WARNING("Custom gear [current_gear.display_name] cannot be equipped: Invalid Origin"))
				return
			if(!current_gear.special_conditions())
				to_chat(new_human, SPAN_WARNING("Custom gear [current_gear.display_name] cannot be equipped: Special conditions not met."))
				return
			new current_gear.path(closet_to_spawn_in)

	//Gives ranks to the ranked
	var/current_rank = paygrades[1]
	var/obj/item/card/id/I = new_human.get_idcard()
	if(I)
		current_rank = I.paygrade
	if(current_rank)
		var/rankpath = get_rank_pins(current_rank)
		if(rankpath)
			new rankpath(closet_to_spawn_in)

	if(flags & EQUIPMENT_PRESET_MARINE)
		var/playtime = get_job_playtime(new_human.client, assignment)
		var/medal_type

		switch(playtime)
			if(JOB_PLAYTIME_TIER_1 to JOB_PLAYTIME_TIER_2)
				medal_type = /obj/item/clothing/accessory/medal/bronze/service
			if(JOB_PLAYTIME_TIER_2 to JOB_PLAYTIME_TIER_3)
				medal_type = /obj/item/clothing/accessory/medal/silver/service
			if(JOB_PLAYTIME_TIER_3 to JOB_PLAYTIME_TIER_4)
				medal_type = /obj/item/clothing/accessory/medal/gold/service
			if(JOB_PLAYTIME_TIER_4 to INFINITY)
				medal_type = /obj/item/clothing/accessory/medal/platinum/service

		if(!new_human.client.prefs.playtime_perks)
			medal_type = null

		if(medal_type)
			var/obj/item/clothing/accessory/medal/medal = new medal_type(closet_to_spawn_in)
			medal.recipient_name = new_human.real_name
			medal.recipient_rank = current_rank


	//Gives glasses to the vision impaired
	if(new_human.disabilities & NEARSIGHTED)
		new /obj/item/clothing/glasses/regular(closet_to_spawn_in)

	for(var/datum/view_record/medal_view/medal as anything in DB_VIEW(/datum/view_record/medal_view, DB_COMP("player_id", DB_EQUALS, new_human.client.player_data.id)))
		if(!medal)
			return
		if(medal.recipient_name != new_human.real_name)
			continue
		if(medal.recipient_role != new_human.job)
			continue
		var/obj/item/clothing/accessory/medal/given_medal
		switch(medal.medal_type)
			if(MARINE_CONDUCT_MEDAL)
				given_medal = new /obj/item/clothing/accessory/medal/bronze/conduct(closet_to_spawn_in)
			if(MARINE_BRONZE_HEART_MEDAL)
				given_medal = new /obj/item/clothing/accessory/medal/bronze/heart(closet_to_spawn_in)
			if(MARINE_VALOR_MEDAL)
				given_medal = new /obj/item/clothing/accessory/medal/silver/valor(closet_to_spawn_in)
			if(MARINE_HEROISM_MEDAL)
				given_medal = new /obj/item/clothing/accessory/medal/gold/heroism(closet_to_spawn_in)
			else
				return FALSE
		given_medal.recipient_name = medal.recipient_name
		given_medal.recipient_rank = medal.recipient_role
		given_medal.medal_citation = medal.citation

/datum/equipment_preset/proc/load_traits(mob/living/carbon/human/new_human, client/mob_client)
	var/client/real_client = mob_client || new_human.client
	if(!real_client?.prefs?.traits)
		return

	for(var/trait in real_client.prefs.traits)
		var/datum/character_trait/CT = GLOB.character_traits[trait]
		CT.apply_trait(new_human, src)

/datum/equipment_preset/proc/get_minimap_icon(mob/living/carbon/human/user)
	var/image/background = mutable_appearance('icons/ui_icons/map_blips.dmi', "background")
	if(user.assigned_squad)
		background.color = user.assigned_squad.minimap_color
	else if(minimap_background)
		background.color = minimap_background
	else
		background.color = MINIMAP_ICON_BACKGROUND_CIVILIAN

	if(islist(minimap_icon))
		for(var/icons in minimap_icon)
			var/iconstate = icons ? icons : "unknown"
			var/mutable_appearance/icon = image('icons/ui_icons/map_blips.dmi', icon_state = iconstate)
			icon.appearance_flags = RESET_COLOR

			if(minimap_icon[icons])
				icon.color = minimap_icon[icons]
			background.overlays += icon
	else
		var/iconstate = minimap_icon ? minimap_icon : "unknown"
		var/mutable_appearance/icon = image('icons/ui_icons/map_blips.dmi', icon_state = iconstate)
		icon.appearance_flags = RESET_COLOR
		background.overlays += icon

	return background

/datum/equipment_preset/proc/handle_late_join(mob/living/carbon/human/new_human, late_join)
	return

/datum/equipment_preset/strip //For removing all equipment
	name = "*strip*"
	flags = EQUIPMENT_PRESET_EXTRA
	idtype = null


/datum/equipment_preset/proc/add_rebel_ua_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/uniformpath = pick(
		/obj/item/clothing/under/colonist/boilersuit/darkblue,
		/obj/item/clothing/under/colonist/boilersuit/cyan,
		/obj/item/clothing/under/colonist/boilersuit/khaki,
		/obj/item/clothing/under/colonist/boilersuit/khaki,
		/obj/item/clothing/under/colonist/boilersuit/grey,
		/obj/item/clothing/under/colonist/boilersuit/grey,
		/obj/item/clothing/under/colonist/boilersuit/grey,
		/obj/item/clothing/under/colonist/workwear/blue,
		/obj/item/clothing/under/colonist/workwear/khaki,
		/obj/item/clothing/under/marine,
		/obj/item/clothing/under/marine,
		/obj/item/clothing/under/colonist/workwear/green,
		)
	var/obj/item/clothing/under/uniform = new uniformpath
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_rebel_twe_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/uniformpath = pick(
		/obj/item/clothing/under/colonist/boilersuit,
		/obj/item/clothing/under/colonist/boilersuit,
		/obj/item/clothing/under/colonist/boilersuit/cyan,
		/obj/item/clothing/under/colonist/boilersuit/cyan,
		/obj/item/clothing/under/colonist/boilersuit/khaki,
		/obj/item/clothing/under/colonist/boilersuit/khaki,
		/obj/item/clothing/under/colonist/boilersuit/white,
		/obj/item/clothing/under/colonist/boilersuit/white,
		/obj/item/clothing/under/colonist/boilersuit/white,
		/obj/item/clothing/under/colonist/workwear/blue,
		/obj/item/clothing/under/colonist/workwear/khaki,
		/obj/item/clothing/under/marine/veteran/UPP,
		)
	var/obj/item/clothing/under/uniform = new uniformpath
	var/random_uniform = rand(1,2)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)


/datum/equipment_preset/proc/add_rebel_ua_suit(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/suitpath = pick(
		/obj/item/clothing/suit/marine,
		/obj/item/clothing/suit/marine/guard,
		/obj/item/clothing/suit/marine/lamp,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/suit/armor/vest/pilot,
		/obj/item/clothing/suit/armor/vest/ballistic,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_green,
		)
	new_human.equip_to_slot_or_del(new suitpath, WEAR_JACKET)

/datum/equipment_preset/proc/add_rebel_twe_suit(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/suitpath = pick(
		/obj/item/clothing/suit/marine/lamp,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_brown,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_blue,
		/obj/item/clothing/suit/marine/veteran/royal_marine,
		/obj/item/clothing/suit/armor/bulletproof,
		/obj/item/clothing/suit/armor/vest/ballistic,
		)
	new_human.equip_to_slot_or_del(new suitpath, WEAR_JACKET)


/datum/equipment_preset/proc/add_rebel_ua_helmet(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/helmetpath = pick(
		/obj/item/clothing/head/durag/black,
		/obj/item/clothing/head/durag,
		/obj/item/clothing/head/skullcap,
		/obj/item/clothing/head/cmcap,
		/obj/item/clothing/head/cmcap/khaki,
		/obj/item/clothing/head/cmcap/bridge,
		/obj/item/clothing/head/cmcap/boonie,
		/obj/item/clothing/head/cmcap/boonie/tan,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/tan,
		/obj/item/clothing/head/headband/tan,
		/obj/item/clothing/head/headband,
		/obj/item/clothing/head/headband,
		/obj/item/clothing/head/cowboy,
		/obj/item/clothing/head/cowboy,
		/obj/item/clothing/head/cowboy/light,
		/obj/item/clothing/head/cowboy/light,
		/obj/item/clothing/head/helmet/marine,
		/obj/item/clothing/head/helmet/marine,
		/obj/item/clothing/head/helmet/marine/veteran/ua_riot,
		/obj/item/clothing/head/helmet/marine/veteran/ua_riot,
		/obj/item/clothing/head/helmet/marine/veteran/ua_riot,
		/obj/item/clothing/head/helmet/marine/veteran/ua_riot,
		/obj/item/clothing/head/helmet/upp/marinepilot,
		/obj/item/clothing/head/helmet/upp/marinepilot/tex,
		)
	new_human.equip_to_slot_or_del(new helmetpath, WEAR_HEAD)

/datum/equipment_preset/proc/add_rebel_twe_helmet(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/helmetpath = pick(
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/uppcap/beret/guerilla,
		/obj/item/clothing/head/helmet/marine/veteran/royal_marine,
		)
	new_human.equip_to_slot_or_del(new helmetpath, WEAR_HEAD)


/datum/equipment_preset/proc/add_rebel_ua_shoes(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/shoespath = pick(
		/obj/item/clothing/shoes/marine/civilian,
		/obj/item/clothing/shoes/marine/civilian/brown,
		/obj/item/clothing/shoes/marine/knife,
		/obj/item/clothing/shoes/marine/jungle/knife,
		)
	new_human.equip_to_slot_or_del(new shoespath, WEAR_FEET)

/datum/equipment_preset/proc/add_rebel_twe_shoes(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/shoespath = pick(
		/obj/item/clothing/shoes/marine/civilian,
		/obj/item/clothing/shoes/marine/civilian/brown,
		/obj/item/clothing/shoes/marine/rmc,
		)
	new_human.equip_to_slot_or_del(new shoespath, WEAR_FEET)

/datum/equipment_preset/proc/add_rebel_gloves(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/glovespath = pick(
		/obj/item/clothing/gloves/marine,
		/obj/item/clothing/gloves/marine/brown,
		/obj/item/clothing/gloves/light_brown,
		/obj/item/clothing/gloves/yellow,
		)
	new_human.equip_to_slot_or_del(new glovespath, WEAR_HANDS)


/datum/equipment_preset/proc/add_rebel_belt(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/beltpath = pick(
		/obj/item/storage/belt/utility/full,
		/obj/item/storage/belt/knifepouch,
		/obj/item/storage/belt/gun/flaregun/full,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/katana/full,
		/obj/item/storage/large_holster/machete/full,
		/obj/item/storage/belt/marine)
	new_human.equip_to_slot_or_del(new beltpath, WEAR_WAIST)

/datum/equipment_preset/proc/add_rebel_specialist_weapon(atom/M, ammo_amount = 4)
	if(!M)
		return

	var/list/rebel_gunner_firearms = list(
		/obj/item/weapon/gun/m60 = /obj/item/ammo_magazine/m60,
		/obj/item/weapon/gun/rifle/mar40/lmg = /obj/item/ammo_magazine/rifle/mar40/lmg,
		)

	var/gunpath = pick(rebel_gunner_firearms)
	var/ammopath = rebel_gunner_firearms[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

//*****************************************************************************************************/

//TWE GUNS
GLOBAL_LIST_INIT(rebel_twe_shotguns, list(
	/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = /obj/item/ammo_magazine/handful/shotgun/buckshot,
	/obj/item/weapon/gun/shotgun/double/upp = /obj/item/ammo_magazine/handful/shotgun/buckshot,
	))

GLOBAL_LIST_INIT(rebel_twe_smgs, list(
	/obj/item/weapon/gun/smg/bizon/upp = /obj/item/ammo_magazine/smg/bizon,
	/obj/item/weapon/gun/smg/bizon/upp = /obj/item/ammo_magazine/smg/bizon,
	/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
	/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39,
	/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39,
	))

GLOBAL_LIST_INIT(rebel_twe_rifles, list(
	/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
	/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
	/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
	/obj/item/weapon/gun/rifle/rmc_f90 = /obj/item/ammo_magazine/rifle/rmc_f90,
	/obj/item/weapon/gun/rifle/rmc_f90 = /obj/item/ammo_magazine/rifle/rmc_f90,
	/obj/item/weapon/gun/rifle/rmc_f90/a_grip = /obj/item/ammo_magazine/rifle/rmc_f90,
	))

GLOBAL_LIST_INIT(rebel_twe_pistols, list(
	/obj/item/weapon/gun/pistol/l54 = /obj/item/ammo_magazine/pistol/l54,
	/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower
	))

/datum/equipment_preset/proc/add_rebel_twe_smg(atom/M, ammo_amount = 4)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_twe_smgs)
	var/ammopath = GLOB.rebel_twe_smgs[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

/datum/equipment_preset/proc/add_rebel_twe_shotgun(atom/M, ammo_amount = 6)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_twe_shotguns)
	var/ammopath = GLOB.rebel_twe_shotguns[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

/datum/equipment_preset/proc/add_rebel_twe_rifle(atom/M, ammo_amount = 4)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_twe_rifles)
	var/ammopath = GLOB.rebel_twe_rifles[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

/datum/equipment_preset/proc/add_rebel_twe_pistol(atom/M, ammo_amount = 4)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_twe_pistols)
	var/ammopath = GLOB.rebel_twe_pistols[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

//*****************************************************************************************************/

//UA GUNS

GLOBAL_LIST_INIT(rebel_ua_shotguns, list(
	/obj/item/weapon/gun/shotgun/combat = /obj/item/ammo_magazine/handful/shotgun/slug,
	/obj/item/weapon/gun/shotgun/pump = /obj/item/ammo_magazine/handful/shotgun/buckshot,
	/obj/item/weapon/gun/shotgun/pump = /obj/item/ammo_magazine/handful/shotgun/buckshot,
	/obj/item/weapon/gun/rifle/xm51/withstock = /obj/item/ammo_magazine/rifle/xm51,
	))

GLOBAL_LIST_INIT(rebel_ua_rifles, list(
	/obj/item/weapon/gun/rifle/m20a = /obj/item/ammo_magazine/rifle/m20a,
	/obj/item/weapon/gun/rifle/m20a = /obj/item/ammo_magazine/rifle/m20a,
	/obj/item/weapon/gun/rifle/m20a = /obj/item/ammo_magazine/rifle/m20a,
	/obj/item/weapon/gun/rifle/m20a = /obj/item/ammo_magazine/rifle/m20a,
	/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39,
	/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39,
	/obj/item/weapon/gun/smg/m39 = /obj/item/ammo_magazine/smg/m39,
	/obj/item/weapon/gun/rifle/m41aMK1 = /obj/item/ammo_magazine/rifle/m41aMK1
	))

GLOBAL_LIST_INIT(rebel_ua_pistols, list(
	/obj/item/weapon/gun/pistol/m4a3 = /obj/item/ammo_magazine/pistol,
	/obj/item/weapon/gun/pistol/m4a3 = /obj/item/ammo_magazine/pistol,
	/obj/item/weapon/gun/pistol/m4a3 = /obj/item/ammo_magazine/pistol,
	/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
	/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
	/obj/item/weapon/gun/pistol/vp70 = /obj/item/ammo_magazine/pistol/vp70
	))

/datum/equipment_preset/proc/add_rebel_ua_shotgun(atom/M, ammo_amount = 6)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_ua_shotguns)
	var/ammopath = GLOB.rebel_ua_shotguns[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

/datum/equipment_preset/proc/add_rebel_ua_rifle(atom/M, ammo_amount = 4)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_ua_rifles)
	var/ammopath = GLOB.rebel_ua_rifles[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

/datum/equipment_preset/proc/add_rebel_ua_pistol(atom/M, ammo_amount = 4)
	if(!M)
		return

	var/gunpath = pick(GLOB.rebel_ua_pistols)
	var/ammopath = GLOB.rebel_ua_pistols[gunpath]

	spawn_weapon(gunpath, ammopath, M, FALSE, ammo_amount)

	return TRUE

//*****************************************************************************************************/

//MERC SHIT
/datum/equipment_preset/proc/add_merc_helmet(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/helmetpath = pick(
		/obj/item/clothing/head/freelancer,
		/obj/item/clothing/head/skullcap,
		/obj/item/clothing/head/bandana,
		/obj/item/clothing/head/cmbandana,
		/obj/item/clothing/head/cmbandana/tan,
		/obj/item/clothing/head/beanie,
		/obj/item/clothing/head/headband,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/tan,
	)
	new_human.equip_to_slot_or_del(new helmetpath, WEAR_HEAD)


/datum/equipment_preset/proc/add_merc_weapon(atom/M, sidearm = 0, ammo_amount = 12)
	if(!M)
		return

	var/list/merc_sidearms = list(
		/obj/item/weapon/gun/pistol/heavy = /obj/item/ammo_magazine/pistol/heavy,
		/obj/item/weapon/gun/pistol/m1911 = /obj/item/ammo_magazine/pistol/m1911,
		/obj/item/weapon/gun/pistol/kt42 = /obj/item/ammo_magazine/pistol/kt42,
		/obj/item/weapon/gun/pistol/holdout = /obj/item/ammo_magazine/pistol/holdout,
		/obj/item/weapon/gun/pistol/highpower = /obj/item/ammo_magazine/pistol/highpower,
		/obj/item/weapon/gun/smg/mp27 = /obj/item/ammo_magazine/smg/mp27,
		/obj/item/weapon/gun/smg/mac15 = /obj/item/ammo_magazine/smg/mac15,
		/obj/item/weapon/gun/smg/mac15 = /obj/item/ammo_magazine/smg/mac15/extended)

	var/list/merc_firearms = list(
		/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/m41aMK1 = /obj/item/ammo_magazine/rifle/m41aMK1,
		/obj/item/weapon/gun/smg/fp9000 = /obj/item/ammo_magazine/smg/fp9000,
		/obj/item/weapon/gun/smg/bizon = /obj/item/ammo_magazine/smg/bizon,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16)

	var/gunpath = sidearm? pick(merc_sidearms) : pick(merc_firearms)
	var/ammopath = sidearm? merc_sidearms[gunpath] : merc_firearms[gunpath]

	spawn_weapon(gunpath, ammopath, M, sidearm, ammo_amount)

	return TRUE

/datum/equipment_preset/proc/add_merc_shotgun(atom/M, ammo_amount = 24)
	if(!M)
		return

	var/list/merc_shotguns = list(
		/obj/item/weapon/gun/shotgun/merc = pick(GLOB.shotgun_handfuls_12g_reasonable),
		/obj/item/weapon/gun/shotgun/combat = pick(GLOB.shotgun_handfuls_12g_reasonable),
		/obj/item/weapon/gun/shotgun/double/with_stock = pick(GLOB.shotgun_handfuls_12g_reasonable),
		/obj/item/weapon/gun/shotgun/pump/dual_tube/cmb = pick(GLOB.shotgun_handfuls_12g_reasonable))

	var/gunpath = pick(merc_shotguns)
	var/ammopath = merc_shotguns[gunpath]

	spawn_weapon(gunpath, ammopath, M, 0, ammo_amount)

/datum/equipment_preset/proc/add_merc_rifle(atom/M, ammo_amount = 12)
	if(!M)
		return

	var/list/merc_rifles = list(
		/obj/item/weapon/gun/rifle/mar40 = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/mar40/carbine = /obj/item/ammo_magazine/rifle/mar40,
		/obj/item/weapon/gun/rifle/m41aMK1 = /obj/item/ammo_magazine/rifle/m41aMK1,
		/obj/item/weapon/gun/smg/fp9000 = /obj/item/ammo_magazine/smg/fp9000,
		/obj/item/weapon/gun/rifle/m16 = /obj/item/ammo_magazine/rifle/m16)

	var/gunpath = pick(merc_rifles)
	var/ammopath = merc_rifles[gunpath]

	spawn_weapon(gunpath, ammopath, M, 0, ammo_amount)

/datum/equipment_preset/proc/add_merc_elite_weapon(atom/M, ammo_amount = 12, shotgun_chance = 50, add_belt = 1)
	if(!M)
		return

	var/list/elite_merc_rifles = list(
	/obj/item/weapon/gun/smg/m39/elite = /obj/item/ammo_magazine/smg/m39/ap,
	/obj/item/weapon/gun/rifle/m41aMK1 = /obj/item/ammo_magazine/rifle/m41aMK1,
	/obj/item/weapon/gun/rifle/m41aMK1/elite = /obj/item/ammo_magazine/rifle/m41aMK1)

	var/list/elite_merc_shotguns = list(
	/obj/item/weapon/gun/shotgun/merc = pick(GLOB.shotgun_handfuls_12g_reasonable),
	/obj/item/weapon/gun/shotgun/combat = pick(GLOB.shotgun_handfuls_12g_reasonable),
	/obj/item/weapon/gun/shotgun/type23 = pick(GLOB.shotgun_handfuls_8g_reasonable))

	if(prob(shotgun_chance))
		var/gunpath = pick(elite_merc_shotguns)
		var/ammopath = elite_merc_shotguns[gunpath]
		if(add_belt)
			if(ishuman(M))
				var/mob/living/carbon/human/new_human = M
				new_human.equip_to_slot_or_del(new /obj/item/storage/belt/shotgun, WEAR_WAIST)
			ammo_amount = 24
		spawn_weapon(gunpath, ammopath, M, 0, ammo_amount)
	else
		var/gunpath = pick(elite_merc_rifles)
		var/ammopath = elite_merc_rifles[gunpath]
		if(add_belt)
			if(ishuman(M))
				var/mob/living/carbon/human/new_human = M
				new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine, WEAR_WAIST)
		spawn_weapon(gunpath, ammopath, M, 0, ammo_amount)


/datum/equipment_preset/proc/spawn_weapon(gunpath, ammopath, atom/M, sidearm = 0, ammo_amount = 4)

	var/atom/spawnloc = M
	var/obj/item/weapon/gun/gun

	if(gunpath)
		gun = new gunpath(spawnloc)
		if(ishuman(spawnloc))
			var/mob/living/carbon/human/new_human = spawnloc
			new_human.equip_to_slot_or_del(gun, sidearm? pick(WEAR_L_HAND, WEAR_R_HAND) : WEAR_J_STORE)
			if(ammopath && ammo_amount)
				for(var/i in 0 to ammo_amount-1)
					if(!new_human.equip_to_appropriate_slot(new ammopath))
						break
		else if(ammopath)
			spawnloc = get_turf(spawnloc)
			for(var/i in 0 to ammo_amount-1)
				new ammopath(spawnloc)


/datum/equipment_preset/proc/generate_random_marine_primary_for_wo(mob/living/carbon/human/new_human, shuffle = rand(0,10))
	switch(shuffle)
		if(0 to 4)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle(new_human), WEAR_IN_BACK)
		if(5,7)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m39(new_human), WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39(new_human), WEAR_IN_BACK)
		else
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/shotgun/full(new_human), WEAR_WAIST)
	return

/datum/equipment_preset/proc/add_common_wo_equipment(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/almayer/marine/self_setting(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre(new_human), WEAR_IN_BACK)

/datum/equipment_preset/proc/add_ice_colony_survivor_equipment(mob/living/carbon/human/new_human)
	if((SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD]) && (SSmapping.configs[GROUND_MAP].map_name != MAP_CORSAT))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(new_human), WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit/survivor(new_human), WEAR_JACKET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf(new_human), WEAR_FACE)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
		new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(new_human), WEAR_HANDS)

/datum/equipment_preset/proc/add_random_synth_infiltrator_equipment(mob/living/carbon/human/new_human) //To mitigate people metaing infiltrators on the spot
	var/random_gear = rand(0,4)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/tshirt/w_br(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(new_human), WEAR_FEET)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(new_human), WEAR_EYES)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/tshirt/gray_blu(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(new_human), WEAR_FEET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/tshirt/r_bla(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/suit_jacket/trainee(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/colonist/boilersuit/cyan(new_human), WEAR_BODY)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/knife(new_human), WEAR_FEET)

/datum/equipment_preset/proc/add_random_survivor_medical_gear(mob/living/carbon/human/new_human) // Randomized medical gear. Survivors wont have their gear all kitted out once the outbreak began much like a doctor on a coffee break wont carry their instruments around. This is a generation of items they may or maynot get when the outbreak happens
	var/random_gear = rand(0,4)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/robust(new_human), WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/robust(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/robust(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/surgical(new_human.back), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/hud/health(new_human), WEAR_EYES)

/datum/equipment_preset/proc/add_random_survivor_research_gear(mob/living/carbon/human/new_human) // Randomized medical gear. Survivors wont have their gear all kitted out once the outbreak began much like a doctor on a coffee break wont carry their instruments around. This is a generation of items they may or maynot get when the outbreak happens
	var/random_gear = rand(0,3)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector(new_human), WEAR_IN_BACK)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/custom/metal_foam(new_human), WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/structure/closet/bodybag/tarp/reactive(new_human), WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/custom/antiweed(new_human), WEAR_IN_BACK)


/datum/equipment_preset/proc/add_random_cl_survivor_loot(mob/living/carbon/human/new_human) // Loot Generation associated with CL survivor. Makes them a little more valuable and not a useless pick.
	var/random_gear = rand(0,2)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/paper/research_notes/grant/high(new_human.back), WEAR_IN_BACK)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/paper/research_notes/grant(new_human.back), WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/paper/research_notes/good(new_human.back), WEAR_IN_BACK)

/datum/equipment_preset/proc/add_random_kutjevo_survivor_uniform(mob/living/carbon/human/new_human) // Kutjevo Survivor Clothing Randomizer
	var/random_gear = rand(0,1)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/kutjevo/drysuit(new_human), WEAR_BODY)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/under/kutjevo(new_human), WEAR_BODY)

/datum/equipment_preset/proc/add_random_kutjevo_survivor_equipment(mob/living/carbon/human/new_human) // Kutjevo Survivor Clothing Randomizer
	var/random_gear = rand(0,2)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/kutjevo(new_human), WEAR_EYES)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/kutjevo(new_human), WEAR_HEAD)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/kutjevo(new_human), WEAR_FACE)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/kutjevo(new_human), WEAR_HEAD)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/kutjevo(new_human), WEAR_FACE)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/kutjevo(new_human), WEAR_EYES)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/kutjevo(new_human), WEAR_HEAD)

/datum/equipment_preset/proc/add_random_survivor_equipment(mob/living/carbon/human/new_human) // Think of this gear as something a survivor of an outbreak might get before shortly taking shelter I.E spawn.
	var/random_gear = rand(0,5)
	switch(random_gear)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/molotov(new_human), WEAR_IN_BACK)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare(new_human), WEAR_IN_BACK)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/nailgun(new_human), WEAR_IN_BACK)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/twohanded/fireaxe(new_human), WEAR_IN_BACK)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/tool/weldingtool/largetank(new_human), WEAR_IN_BACK)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(new_human.back), WEAR_IN_BACK)

// Random Survivor Weapon Spawners
/datum/equipment_preset/proc/add_survivor_weapon_pistol(mob/living/carbon/human/new_human) // Pistols a survivor might come across in a colony. They may have gotten it from a code red gun cabinet or simply have one becuase of hostile natives.
	var/random_weapon = rand(0,4)
	switch(random_weapon)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m4a3(new_human.back), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol(new_human), WEAR_IN_BACK)

		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead(new_human), WEAR_IN_BACK)

		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/highpower(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower(new_human), WEAR_IN_BACK)

		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/m1911(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/m1911(new_human), WEAR_IN_BACK)

		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/m44(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver(new_human), WEAR_IN_BACK)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver(new_human), WEAR_IN_BACK)


/datum/equipment_preset/proc/add_pmc_survivor_weapon(mob/living/carbon/human/new_human) // Random Weapons a WY PMC may have during a deployment on a colony. They are not equiped with the elite weapons than their space station counterparts but they do bear some of the better weapons the outer rim has to offer.
	var/random_weapon = rand(0,6)
	switch(random_weapon)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/mp5(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/mp5(new_human), WEAR_WAIST)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/fp9000(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/fp9000(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/shotgun_ammo, WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/nsg23(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/nsg23(new_human), WEAR_WAIST)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/carbine(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/mar40(new_human), WEAR_WAIST)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/merc(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/shotgun_ammo, WEAR_WAIST)
		if(6)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m41amk1(new_human), WEAR_WAIST)

/**
 * Randomizes the primary weapon a survivor might find at the start of the outbreak in a gun cabinet.
 * For the most part you will stil get a shotgun but there is an off chance you get something unique.
 * If you dont like the weapon deal with it. Cursed ammo for shotguns is intentional for scarcity reasons.
 * Some weapons may not appear at all in a colony so they will need the extra ammo.
 * MERC, and DB needed a handfull of shells to compete with the normal CMB.
 */

/datum/equipment_preset/proc/add_survivor_weapon_security(mob/living/carbon/human/new_human) // Randomizes the primary weapon a survivor might find at the start of the outbreak in a gun cabinet.

	var/random_weapon = rand(0, 3)
	switch(random_weapon)
		if(0)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/carbine(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/mar40(new_human), WEAR_WAIST)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/mp5(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/mp5(new_human), WEAR_WAIST)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/shotgun_ammo, WEAR_WAIST)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m16(new_human), WEAR_L_HAND)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/m16(new_human), WEAR_WAIST)



/////////////// Antag Vendor Equipment ///////////////
/datum/equipment_preset/proc/get_antag_clothing_equipment()
	return list(
		list("STANDARD EQUIPMENT (TAKE ALL)", 0, null, null, null),
		list("CLF Shoes (Random)", 0, /obj/effect/essentials_set/random/clf_shoes, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),
		list("CLF Uniform", 0, /obj/item/clothing/under/colonist/clf, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("CLF Armor (Random)", 0, /obj/effect/essentials_set/random/clf_armor, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("CLF Gloves (Random)", 0, /obj/effect/essentials_set/random/clf_gloves, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("CLF Belt (Random)", 0, /obj/effect/essentials_set/random/clf_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),
		list("CLF Head Gear (Random)", 0, /obj/effect/essentials_set/random/clf_head, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_MANDATORY),
		list("Headset", 0, /obj/item/device/radio/headset/distress/dutch, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("Flashlight", 0, /obj/item/device/flashlight, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Combat Pack", 0, /obj/item/storage/backpack/lightpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("POUCHES (CHOOSE 2)", 0, null, null, null),
		list("Bayonet Sheath", 0, /obj/item/storage/pouch/bayonet/upp, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", 0, /obj/item/storage/pouch/explosive, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Refillable Injectors)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("First-Aid Pouch (Splints, Gauze, Ointment)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Pill Packets)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Flare Pouch (Full)", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Large Magazine Pouch", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Pistol Magazine Pouch", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Pistol Pouch", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS (CHOOSE 1)", 0, null, null, null),
		list("Angled Grip", 0, /obj/item/attachable/angledgrip, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Extended Barrel", 0, /obj/item/attachable/extended_barrel, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Gyroscopic Stabilizer", 0, /obj/item/attachable/gyro, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 0, /obj/item/attachable/lasersight, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Masterkey Shotgun", 0, /obj/item/attachable/attached_gun/shotgun, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Recoil Compensator", 0, /obj/item/attachable/compensator, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Red-Dot Sight", 0, /obj/item/attachable/reddot, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Reflex Sight", 0, /obj/item/attachable/reflex, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Suppressor", 0, /obj/item/attachable/suppressor, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 0, /obj/item/attachable/verticalgrip, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_REGULAR),

		list("MASK (CHOOSE 1)", 0, null, null, null),
		list("Gas Mask", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Heat Absorbent Coif", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR)
	)

/datum/equipment_preset/proc/get_antag_gear_equipment()
	return list(
		list("ENGINEERING SUPPLIES", 0, null, null, null),
		list("Entrenching Tool", 2, /obj/item/tool/shovel/etool, null, VENDOR_ITEM_RECOMMENDED),
		list("Sandbags x25", 5, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_RECOMMENDED),

		list("SPECIAL AMMUNITION", 0, null, null, null),
		list("M16 AP Magazine (5.56x45mm)", 10, /obj/item/ammo_magazine/rifle/m16/ap, null, VENDOR_ITEM_REGULAR),
		list("MAR Extended Magazine (7.62x39mm)", 10, /obj/item/ammo_magazine/rifle/mar40/extended, null, VENDOR_ITEM_REGULAR),
		list("Shotgun Incendiary Shells (Handful)", 15, /obj/item/ammo_magazine/handful/shotgun/incendiary, null, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES", 0, null, null, null),
		list("EMP Grenade", 10, /obj/item/explosive/grenade/empgrenade, null, VENDOR_ITEM_REGULAR),
		list("Improvised Explosive Device", 15, /obj/item/explosive/grenade/custom/ied, null, VENDOR_ITEM_REGULAR),
		list("Improvised Firebomb", 10, /obj/item/explosive/grenade/incendiary/molotov, null, VENDOR_ITEM_REGULAR),
		list("Incendiary IED", 15, /obj/item/explosive/grenade/custom/ied_incendiary, null, VENDOR_ITEM_REGULAR),
		list("Improvised Phosphorus Bomb", 20, /obj/item/explosive/grenade/phosphorus/clf, null, VENDOR_ITEM_REGULAR),
		list("Smoke Grenade", 5, /obj/item/explosive/grenade/smokebomb, null, VENDOR_ITEM_REGULAR),

		list("UTILITIES", 0, null, null, null),
		list("Fire Extinguisher (Portable)", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Large General Pouch", 10, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("Random Useful (Or Not) Item", 5, /obj/effect/essentials_set/random/clf_bonus_item, null, VENDOR_ITEM_REGULAR),
		list("Shoulder Holster", 10, /obj/item/clothing/accessory/storage/holster, null, VENDOR_ITEM_REGULAR),
		list("Webbing", 10, /obj/item/clothing/accessory/storage/webbing, null, VENDOR_ITEM_REGULAR)
	)

/datum/equipment_preset/proc/add_random_satchel(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_satchel = pick(
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/satchel/black,
		/obj/item/storage/backpack/satchel/blue,
	)
	new_human.equip_to_slot_or_del(new random_satchel, WEAR_BACK)

	//Civilian

/datum/equipment_preset/proc/add_civilian_shoe(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_civilian_shoes = pick(
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/shoes/white,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/shoes/marine/civilian/brown,
		/obj/item/clothing/shoes/marine/civilian,
		/obj/item/clothing/shoes/laceup/brown,
		/obj/item/clothing/shoes/stompers,
	)
	new_human.equip_to_slot_or_del(new random_civilian_shoes, WEAR_FEET)

/datum/equipment_preset/proc/add_civilian_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_civilian_uniform = pick(
		/obj/item/clothing/under/colonist/boilersuit/khaki,
		/obj/item/clothing/under/colonist/boilersuit/cyan,
		/obj/item/clothing/under/colonist/boilersuit/grey,
		/obj/item/clothing/under/colonist/workwear/blue,
		/obj/item/clothing/under/colonist/workwear/khaki,
		/obj/item/clothing/under/colonist/workwear/pink,
		/obj/item/clothing/under/liaison_suit/brown,
		/obj/item/clothing/under/liaison_suit/blue,
	)
	new_human.equip_to_slot_or_del(new random_civilian_uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_civilian_jacket(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_civilian_jacket = pick(
		/obj/item/clothing/suit/storage/jacket/marine/corporate/brown,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/blue,
		/obj/item/clothing/suit/storage/jacket/marine/corporate,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_yellow,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_brown,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_blue,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_green,
		/obj/item/clothing/suit/storage/jacket/marine/vest,
		/obj/item/clothing/suit/storage/jacket/marine/vest/grey,
		/obj/item/clothing/suit/storage/jacket/marine/vest/tan,
		/obj/item/clothing/suit/storage/apron/overalls,
		/obj/item/clothing/suit/storage/apron/overalls/tan,
	)
	new_human.equip_to_slot_or_del(new random_civilian_jacket, WEAR_JACKET)

//Workers

/datum/equipment_preset/proc/add_worker_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_worker_uniform = pick(
		/obj/item/clothing/under/colonist/boilersuit/khaki,
		/obj/item/clothing/under/colonist/boilersuit/cyan,
		/obj/item/clothing/under/colonist/boilersuit/grey,
		/obj/item/clothing/under/colonist/workwear/blue,
		/obj/item/clothing/under/colonist/workwear/khaki,
		/obj/item/clothing/under/colonist/workwear/pink,
		/obj/item/clothing/under/colonist/workwear/green,
	)
	new_human.equip_to_slot_or_del(new random_worker_uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_worker_jacket(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_worker_jacket = pick(
		/obj/item/clothing/suit/storage/apron/overalls,
		/obj/item/clothing/suit/storage/apron/overalls/tan,
		/obj/item/clothing/suit/storage/windbreaker/windbreaker_yellow,
		/obj/item/clothing/suit/storage/hazardvest,
	)
	new_human.equip_to_slot_or_del(new random_worker_jacket, WEAR_JACKET)

/datum/equipment_preset/proc/add_worker_shoe(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_worker_shoe = rand(1,2)
	switch(random_worker_shoe)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian/brown(new_human), WEAR_FEET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian(new_human), WEAR_FEET)

/datum/equipment_preset/proc/add_worker_gloves(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_workgloves = pick(
		/obj/item/clothing/gloves/brown,
		/obj/item/clothing/gloves/light_brown,
		/obj/item/clothing/gloves/yellow,
	)
	new_human.equip_to_slot_or_del(new random_workgloves, WEAR_HANDS)

/datum/equipment_preset/proc/add_business_outfit(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_business_suit = pick(
		/obj/item/clothing/under/liaison_suit/brown,
		/obj/item/clothing/under/liaison_suit/blue,
		/obj/item/clothing/under/liaison_suit/black,
		/obj/item/clothing/under/liaison_suit/grey,
	)
	new_human.equip_to_slot_or_del(new random_business_suit, WEAR_BODY)
	var/random_business_jacket = pick(
		/obj/item/clothing/suit/storage/jacket/marine/corporate/brown,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/blue,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/black,
		/obj/item/clothing/suit/storage/jacket/marine/corporate/grey,
	)
	new_human.equip_to_slot_or_del(new random_business_jacket, WEAR_JACKET)

/datum/equipment_preset/proc/add_professionalwear(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_professionalwear = pick(
		/obj/item/clothing/under/liaison_suit/brown,
		/obj/item/clothing/under/liaison_suit/blue,
		/obj/item/clothing/under/liaison_suit/black,
		/obj/item/clothing/under/liaison_suit/grey,
	)
	new_human.equip_to_slot_or_del(new random_professionalwear, WEAR_BODY)

/datum/equipment_preset/proc/add_dress_shoes(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_professional_shoe = rand(1,2)
	switch(random_professional_shoe)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup/brown(new_human), WEAR_FEET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(new_human), WEAR_FEET)

/datum/equipment_preset/proc/add_tie(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_tie = pick(
		/obj/item/clothing/accessory/black,
		/obj/item/clothing/accessory/blue,
		/obj/item/clothing/accessory/green,
		/obj/item/clothing/accessory/purple,
		/obj/item/clothing/accessory/red,
	)
	new_human.equip_to_slot_or_del(new random_tie, WEAR_ACCESSORY)

/datum/equipment_preset/proc/add_boilersuit(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_boilersuit = pick(
		/obj/item/clothing/under/colonist/boilersuit,
		/obj/item/clothing/under/colonist/boilersuit/cyan,
		/obj/item/clothing/under/colonist/boilersuit/grey,
		/obj/item/clothing/under/colonist/boilersuit/khaki,
	)
	new_human.equip_to_slot_or_del(new random_boilersuit, WEAR_BODY)

/datum/equipment_preset/proc/add_facewrap(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_face_wrap = rand(1,6)
	switch(random_face_wrap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/tan(new_human), WEAR_FACE)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/red(new_human), WEAR_FACE)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask(new_human), WEAR_FACE)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/green(new_human), WEAR_FACE)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf/tacticalmask/black(new_human), WEAR_FACE)

/datum/equipment_preset/proc/add_neckerchief(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_face_wrap = rand(1,5)
	switch(random_face_wrap)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/black(new_human), WEAR_FACE)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/gray(new_human), WEAR_FACE)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief(new_human), WEAR_FACE)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/neckerchief/green(new_human), WEAR_FACE)

	//UPP
/datum/equipment_preset/proc/add_upp_head(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/maybeberet = pick(
		/obj/item/clothing/head/helmet/upp,
		/obj/item/clothing/head/helmet/upp/alt,
		/obj/item/clothing/head/uppcap/beret/naval,
	)
	new_human.equip_to_slot_or_del(new maybeberet, WEAR_HEAD)

/datum/equipment_preset/proc/add_upp_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/obj/item/clothing/under/marine/veteran/UPP/uniform = new()
	var/random_uniform = rand(1,4)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2 to 3)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp/naval, WEAR_ACCESSORY)

/datum/equipment_preset/proc/add_money_poor(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/obj/item/spacecash/bundle/money = new /obj/item/spacecash/bundle
	money.worth = 50
	money.update_icon()
	new_human.equip_to_slot_or_del(money, WEAR_IN_BACK)

/datum/equipment_preset/proc/add_forecon_surv_uniform(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/reconnaissance/uniform = new()
	var/random_uniform = rand(1,3)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	var/obj/item/clothing/accessory/patch/patch_uscm = new()
	var/obj/item/clothing/accessory/patch/forecon/patch_forecon = new()
	uniform.attach_accessory(new_human,pouch)
	uniform.attach_accessory(new_human,patch_uscm)
	uniform.attach_accessory(new_human,patch_forecon)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_forecon_uniform(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/standard/uniform = new() //Survivor presets are the 'seen some shit' sort, these guys are fresher
	var/random_uniform = rand(1,3)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	var/obj/item/clothing/accessory/storage/droppouch/pouch = new()
	var/obj/item/clothing/accessory/patch/patch_uscm = new()
	var/obj/item/clothing/accessory/patch/forecon/patch_forecon = new()
	uniform.attach_accessory(new_human,pouch)
	uniform.attach_accessory(new_human,patch_uscm)
	uniform.attach_accessory(new_human,patch_forecon)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_uscm_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/obj/item/clothing/under/marine/uniform = new()
	var/random_uniform = rand(1,4)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2 to 3)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_uscm_uniform_standard(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/obj/item/clothing/under/marine/standard/uniform = new()
	var/random_uniform = rand(1,4)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2 to 3)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_uscm_cover(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_cover = rand(1,5)
	switch(random_cover)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/camocover, WEAR_IN_HELMET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/netting, WEAR_IN_HELMET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/raincover, WEAR_IN_HELMET)

/datum/equipment_preset/proc/add_uscm_goggles(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/add_uscm_goggles = rand(1,7)
	switch(add_uscm_goggles)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles, WEAR_IN_HELMET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles/black, WEAR_IN_HELMET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles/orange, WEAR_IN_HELMET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/mgoggles/green, WEAR_IN_HELMET)

/datum/equipment_preset/proc/add_combat_gloves(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/add_combat_gloves = rand(1,5)
	switch(add_combat_gloves)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine, WEAR_HANDS)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown, WEAR_HANDS)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/fingerless, WEAR_HANDS)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown/fingerless, WEAR_HANDS)

/datum/equipment_preset/proc/add_helmet_cigarettes(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/add_helmet_cigarettes = rand(1,10)
	switch(add_helmet_cigarettes)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/kpack, WEAR_IN_HELMET)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/lucky_strikes, WEAR_IN_HELMET)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/spirit, WEAR_IN_HELMET)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/spirit/yellow, WEAR_IN_HELMET)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/wypacket, WEAR_IN_HELMET)
		if(6)
			new_human.equip_to_slot_or_del(new /obj/item/storage/fancy/cigarettes/arcturian_ace, WEAR_IN_HELMET)


/datum/equipment_preset/proc/add_rmc_uniform(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/veteran/royal_marine/uniform = new()
	var/random_uniform = rand(1,10)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

/datum/equipment_preset/proc/add_rmc_lt_uniform(mob/living/carbon/human/new_human)
	var/obj/item/clothing/under/marine/veteran/royal_marine/lt/uniform = new()
	var/random_uniform = rand(1,10)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/royal_marines, WEAR_ACCESSORY)

/datum/equipment_preset/proc/add_rmc_md(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/md_chance = rand(1,3)
	switch(md_chance)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector/hacked/twe(new_human), WEAR_IN_BACK)

/datum/equipment_preset/proc/add_canc_uniform(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/obj/item/clothing/under/marine/veteran/canc/uniform = new()
	var/random_uniform = rand(1,3)
	switch(random_uniform)
		if(1)
			uniform.roll_suit_jacket(new_human)
		if(2)
			uniform.roll_suit_sleeves(new_human)
	new_human.equip_to_slot_or_del(uniform, WEAR_BODY)

/datum/equipment_preset/proc/add_canc_rifle(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_canc_rifle = rand(1,5)
	switch(random_canc_rifle)
		if(1, 2, 3)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/lw317(new_human), WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/lw317, WEAR_IN_BELT)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/carbine, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
		if(5)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)

/datum/equipment_preset/proc/add_canc_rifle_newblood(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/random_canc_rifle_newblood = rand(1,2)
	switch(random_canc_rifle_newblood)
		if(1)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
		if(2)
			new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mar40/carbine, WEAR_J_STORE)
			new_human.equip_to_slot_or_del(new /obj/item/storage/belt/marine/upp, WEAR_WAIST)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)
			new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mar40, WEAR_IN_BELT)

/datum/equipment_preset/proc/add_rebel_upp_helmet(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/helmetpath = pick(
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/helmet/construction,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/headband/rebel,
		/obj/item/clothing/head/uppcap/beret/guerilla,
		/obj/item/clothing/head/helmet/marine/veteran/UPP/old,
		)
	new_human.equip_to_slot_or_del(new helmetpath, WEAR_HEAD)


/datum/equipment_preset/proc/add_army_helmet_accessory(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/helmetaccessorypath = pick(
		/obj/item/prop/helmetgarb/camocover,
		/obj/item/prop/helmetgarb/netting,
		/obj/item/prop/helmetgarb/raincover,
		/obj/item/prop/helmetgarb/gunoil,
		/obj/item/prop/helmetgarb/spent_buckshot,
		/obj/item/prop/helmetgarb/compass,
		/obj/item/prop/helmetgarb/family_photo,
		/obj/item/prop/helmetgarb/flair_initech,
		/obj/item/prop/helmetgarb/flair_peace,
		/obj/item/clothing/head/headband,
		/obj/item/clothing/head/headband/red,
		/obj/item/clothing/head/headband/delta,
		/obj/item/clothing/head/headband/tan,
		/obj/item/prop/helmetgarb/lucky_feather,
		/obj/item/prop/helmetgarb/spacejam_tickets,
		/obj/item/prop/helmetgarb/helmet_nvg/cosmetic,
	)
	new_human.equip_to_slot_or_del(new helmetaccessorypath, WEAR_IN_HELMET)

/datum/equipment_preset/proc/add_army_helmet_eyewear(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/helmeteyewearpath = pick(
		/obj/item/clothing/glasses/mgoggles,
		/obj/item/clothing/glasses/mgoggles/black,
		/obj/item/clothing/glasses/mgoggles/orange,
		/obj/item/clothing/glasses/mgoggles/green,
		/obj/item/clothing/glasses/sunglasses,
		/obj/item/clothing/glasses/sunglasses/aviator,
	)
	new_human.equip_to_slot_or_del(new helmeteyewearpath, WEAR_IN_HELMET)

/datum/equipment_preset/proc/add_army_eyewear(mob/living/carbon/human/new_human)
	if(!istype(new_human))
		return
	var/eyewearpath = rand(1,8)
	switch(eyewearpath)
		if(1, 2, 3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/orange, WEAR_EYES)
		if(4, 5)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big, WEAR_EYES)
		if(6)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/classic, WEAR_EYES)
		if(7)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator, WEAR_EYES)
		if(8)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses, WEAR_EYES)
