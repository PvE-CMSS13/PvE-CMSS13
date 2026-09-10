//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/randomize_appearance(mob/living/carbon/human/H)
	if(H)
		if(H.gender == MALE)
			gender = MALE
		else
			gender = FEMALE

	skin_color = random_skin_color()
	body_type = random_body_type()
	body_size = random_body_size()

	h_style = random_hair_style(gender, species)
	f_style = random_facial_hair_style(gender, species)
	randomize_hair_color("hair")
	randomize_hair_color("facial")
	randomize_eyes_color()
	randomize_skin_color()
	var/list/undershirt_options = gender == MALE ? GLOB.undershirt_m : GLOB.undershirt_f
	undershirt = pick(undershirt_options-GLOB.undershirt_restricted)
	var/list/underwear_options = gender == MALE ? GLOB.underwear_m : GLOB.underwear_f
	underwear = pick(underwear_options-GLOB.underwear_restricted)
	backbag = 2
	age = rand(AGE_MIN,AGE_MAX)
	if(H)
		copy_appearance_to(H,1)

/datum/preferences/proc/randomize_hair_color(target = "hair")
	if(prob (75) && target == "facial") // Chance to inherit hair color
		r_facial = r_hair
		g_facial = g_hair
		b_facial = b_hair
		return

	var/red
	var/green
	var/blue

	var/col = pick ("blonde", "black", "chestnut", "copper", "brown", "wheat", "old", "punk")
	switch(col)
		if("blonde")
			red = 255
			green = 255
			blue = 0
		if("black")
			red = 0
			green = 0
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 51
		if("copper")
			red = 255
			green = 153
			blue = 0
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("wheat")
			red = 255
			green = 255
			blue = 153
		if("old")
			red = rand (100, 255)
			green = red
			blue = red
		if("punk")
			red = rand (0, 255)
			green = rand (0, 255)
			blue = rand (0, 255)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	switch(target)
		if("hair")
			r_hair = red
			g_hair = green
			b_hair = blue
		if("facial")
			r_facial = red
			g_facial = green
			b_facial = blue

/datum/preferences/proc/randomize_eyes_color()
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	r_eyes = red
	g_eyes = green
	b_eyes = blue



/datum/preferences/proc/randomize_skin_color()
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	r_skin = red
	g_skin = green
	b_skin = blue

/datum/preferences/proc/update_preview_icon(refresh_limb_status)
	if(!owner)
		return

	var/J = job_pref_to_gear_preset()
	if(isnull(preview_dummy))
		preview_dummy = new()

	preview_dummy.blocks_emissive = FALSE
	preview_dummy.update_emissive_block()

	clear_equipment()
	if(refresh_limb_status)
		for(var/obj/limb/L in preview_dummy.limbs)
			L.status = LIMB_ORGANIC
	preview_dummy.set_species()
	copy_appearance_to(preview_dummy)
	preview_dummy.update_body()
	preview_dummy.update_hair()

	arm_equipment(preview_dummy, J, FALSE, FALSE, owner, show_job_gear)

	// If the dummy was equipped with marine armor.
	var/jacket = preview_dummy.get_item_by_slot(WEAR_JACKET)
	if(istype(jacket, /obj/item/clothing/suit/storage/marine))
		var/obj/item/clothing/suit/storage/marine/armor = jacket
		// If the armor has different sprite variants.
		if(armor.armor_variation)
			// Set its `icon_state` to the style the player picked as their 'Preferred Armor'.
			armor.set_armor_style(preferred_armor)
			armor.update_icon(preview_dummy)

	if(isnull(preview_front))
		preview_front = new()
		preview_front.vis_contents += preview_dummy
		preview_front.screen_loc = "preview:0,0"
	preview_front.icon_state = bg_state
	owner.add_to_screen(preview_front)

	if(isnull(rotate_left))
		rotate_left = new(null, preview_dummy)
		rotate_left.screen_loc = "preview:-1:16,0"
	owner.add_to_screen(rotate_left)

	if(isnull(rotate_right))
		rotate_right = new(null, preview_dummy)
		rotate_right.screen_loc = "preview:1:-16,0"
	owner.add_to_screen(rotate_right)

/datum/preferences/proc/job_pref_to_gear_preset()
	var/highest_priority_job
	var/highest_priority = LOW_PRIORITY

	for(var/job in job_preference_list)
		if(job_preference_list[job] == NEVER_PRIORITY)
			continue

		if(job_preference_list[job] < highest_priority)
			highest_priority_job = job
			highest_priority = job_preference_list[job]

	switch(highest_priority_job)
//USCM Section
		if(JOB_SQUAD_MARINE)
			return /datum/equipment_preset/uscm/private_equipped
		if(JOB_SQUAD_LEADER)
			return /datum/equipment_preset/uscm/leader_equipped
		if(JOB_SQUAD_MEDIC)
			return /datum/equipment_preset/uscm/medic_equipped
		if(JOB_SQUAD_SMARTGUN)
			return /datum/equipment_preset/uscm/smartgunner_equipped
		if(JOB_SQUAD_TEAM_LEADER)
			return /datum/equipment_preset/uscm/tl_equipped
		if(JOB_SO)
			return /datum/equipment_preset/uscm_ship/so_equipped
//USCM Aux forces (not part of pre-round role select normally)
		if(JOB_SQUAD_SPECIALIST)
			return /datum/equipment_preset/uscm/specialist_equipped
		if(JOB_SQUAD_ENGI)
			return /datum/equipment_preset/uscm/engineer_equipped
		if(JOB_TANK_CREW)
			return /datum/equipment_preset/uscm/tank
		if(JOB_DROPSHIP_PILOT)
			return /datum/equipment_preset/uscm_ship/dp
		if(JOB_DROPSHIP_CREW_CHIEF)
			return /datum/equipment_preset/uscm_ship/dcc
		if(JOB_CORPORATE_LIAISON)
			return /datum/equipment_preset/uscm_ship/liaison
		if(JOB_SYNTH)
			var/datum/job/J = GLOB.RoleAuthority.roles_by_name[JOB_SYNTH]
			return J.gear_preset_whitelist["[JOB_SYNTH][J.get_whitelist_status(owner)]"]
		if(JOB_DI)
			return /datum/equipment_preset/uscm_ship/di
//UPP Platoon
		if(JOB_SQUAD_MARINE_UPP)
			return /datum/equipment_preset/upp/rifleman
		if(JOB_SQUAD_LEADER_UPP)
			return /datum/equipment_preset/upp/navallead
		if(JOB_SQUAD_MEDIC_UPP)
			return /datum/equipment_preset/upp/sanitar
		if(JOB_SQUAD_SMARTGUN_UPP)
			return /datum/equipment_preset/upp/machinegunner
		if(JOB_SQUAD_TEAM_LEADER_UPP)
			return /datum/equipment_preset/upp/squadlead
		if(JOB_SO_UPP)
			return /datum/equipment_preset/uscm_ship/so/upp/equipped
//FORECON Squad
		if(JOB_SQUAD_TEAM_LEADER_FORECON)
			return /datum/equipment_preset/uscm/forecon/squad_leader
		if(JOB_SQUAD_LEADER_FORECON)
			return /datum/equipment_preset/uscm/forecon/squad_leader
		if(JOB_SQUAD_MEDIC_FORECON)
			return /datum/equipment_preset/uscm/forecon/tech //Not making corpsman & RTO equipped presets purely for this when the tech & rifleman work to convey them respectively as-is
		if(JOB_SQUAD_RTO)
			return /datum/equipment_preset/uscm/forecon/standard
		if(JOB_SQUAD_MARINE_FORECON)
			return /datum/equipment_preset/uscm/forecon/standard
		if(JOB_SQUAD_SMARTGUN_FORECON)
			return /datum/equipment_preset/uscm/forecon/smartgunner
//PMC Taskforce
		if(JOB_PMCPLAT_OW)
			return /datum/equipment_preset/uscm_ship/so/pmc/equipped
		if(JOB_PMCPLAT_LEADER)
			return /datum/equipment_preset/pmc/leader
		if(JOB_PMCPLAT_FTL)
			return /datum/equipment_preset/pmc/leader
		if(JOB_PMCPLAT_SG)
			return /datum/equipment_preset/pmc/gunner
		if(JOB_PMCPLAT_STANDARD)
			return /datum/equipment_preset/pmc/standard
		if(JOB_PMCPLAT_MEDIC)
			return /datum/equipment_preset/pmc/medic
//PMC Taskforce(small)
		if(JOB_PMCPLAT_SMALL_LEADER)
			return /datum/equipment_preset/pmc/leader
		if(JOB_PMCPLAT_SMALL_FTL)
			return /datum/equipment_preset/pmc/leader
		if(JOB_PMCPLAT_SMALL_SG)
			return /datum/equipment_preset/pmc/gunner
		if(JOB_PMCPLAT_SMALL_STANDARD)
			return /datum/equipment_preset/pmc/standard
		if(JOB_PMCPLAT_SMALL_MEDIC)
			return /datum/equipment_preset/pmc/doctor
		if(JOB_PMCPLAT_SMALL_ENGI)
			return /datum/equipment_preset/pmc/technician
//RMC Troop
		if(JOB_TWE_RMC_RIFLEMAN)
			return /datum/equipment_preset/royal_marine/standard
		if(JOB_TWE_RMC_MEDIC)
			return /datum/equipment_preset/royal_marine/medic
		if(JOB_TWE_RMC_ENGI)
			return /datum/equipment_preset/royal_marine/engi
		if(JOB_TWE_RMC_MARKSMAN)
			return /datum/equipment_preset/royal_marine/sniper/light
		if(JOB_TWE_RMC_SMARTGUNNER)
			return /datum/equipment_preset/royal_marine/machinegun
		if(JOB_TWE_RMC_BREACHER)
			return /datum/equipment_preset/royal_marine/mortar/light
		if(JOB_TWE_RMC_TEAMLEADER)
			return /datum/equipment_preset/royal_marine/leader/lesser_rank
		if(JOB_TWE_RMC_SECTIONLEADER)
			return /datum/equipment_preset/royal_marine/leader
		if(JOB_TWE_RMC_TROOPLEADER)
			return /datum/equipment_preset/royal_marine/troopsergeant
		if(JOB_TWE_RMC_LIEUTENANT)
			return /datum/equipment_preset/royal_marine/lieuteant

	return /datum/equipment_preset/uscm/private_equipped

/datum/preferences/proc/clear_equipment()
	for(var/obj/item/I in preview_dummy)
		qdel(I)
