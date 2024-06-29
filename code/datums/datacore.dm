GLOBAL_DATUM_INIT(data_core, /datum/datacore, new)

/datum/datacore
	var/medical[] = list()
	var/general[] = list()
	var/security[] = list()
	//This list tracks characters spawned in the world and cannot be modified in-game. Currently referenced by respawn_character().
	var/locked[] = list()

/datum/datacore/New()
	. = ..()

	RegisterSignal(SSdcs, COMSIG_GLOB_PLATOON_NAME_CHANGE, PROC_REF(rename_platoon))

/datum/datacore/proc/rename_platoon(datum/source, new_name, old_name)
	SIGNAL_HANDLER

	for(var/datum/data/record/cycled_data_record in general)
		if(cycled_data_record.fields["squad"] == old_name)
			cycled_data_record.fields["squad"] = new_name

/datum/datacore/proc/get_manifest(monochrome, OOC, nonHTML)
	var/list/manifest_out = list() //This will be our final compiled list.
	var/name //Iterator for the person's name.
	var/rank //Iterator for the person's rank.
	var/real_rank //What their real rank is.
	var/squad_name //What their squad is called.
	var/datum/job/current_job //Referenced through their mob job to pull up where their role is sorted.
	var/datum/data/record/current_record

	//Returns a list and not HTML itself. Used by the id card computer.
	if(nonHTML)
		var/category
		for(current_record as anything in GLOB.data_core.general)
			name = current_record.fields["name"]
			rank = current_record.fields["rank"]
			real_rank = current_record.fields["real_rank"]
			squad_name = current_record.fields["squad"]
			if(!name || !rank)
				continue

			/*
			* Structural pitfall here. roles_by_name expects a real rank, so if the individual has a different rank, if they were re-assigned,
			* it will still list them under the real rank's job category, which isn't always desired.
			* This also means that anything that doesn't have a job datum will be listed as JOB_CATEGORY_OTHER.
			* Ideally records would keep a running tally of job category, so that it can be listed appropriately if a job change takes place.
			* Something to look into if properly refactoring records in the future. Not really worth a workaround for right now.
			*/
			current_job = RoleAuthority.roles_by_name[real_rank]
			if(!current_job)
				if(current_record.fields["ref"])
					category = JOB_CATEGORY_OTHER // Probably a real person.
				else
					continue
			else
				category = squad_name || current_job.category

			if(!manifest_out[category])
				manifest_out[category] = list()
			manifest_out[category] += list(list(
				"name" = name,
				"rank" = rank
			))

		return manifest_out

	//Returns an HTML table with the manifest.
	var/list/isactive = list()
	var/even = 0 //For prettier lines.
	var/category_list[] //To simplify lookup.
	var/category

	var/dat = {"
	<div align='center'>
	<head><style>
		.manifest {border-collapse:collapse;}
		.manifest td, th {border:1px solid [monochrome?"black":"#DEF; background-color:white; color:black"]; padding:.25em}
		.manifest th {height: 2em; [monochrome?"border-top-width: 3px":"background-color: #48C; color:white"]}
		.manifest tr.head th { [monochrome?"border-top-width: 1px":"background-color: #488;"] }
		.manifest td:first-child {text-align:right}
		.manifest tr.alt td {[monochrome?"border-top-width: 2px":"background-color: #DEF"]}
	</style></head>
	<table class="manifest">
	<tr class='head'><th>Name</th><th>Rank</th><th>Activity</th></tr>
	"}

	for(current_record as anything in GLOB.data_core.general)
		name = current_record.fields["name"]
		rank = current_record.fields["rank"]
		real_rank = current_record.fields["real_rank"]
		squad_name = current_record.fields["squad"]

		if(!name || !rank || !real_rank) //If something is missing, we ignore them.
			continue

		if(OOC) //This returns a more accurate estimate of whether or not they are active.
			isactive[name] = "Inactive"
			for(var/mob/active_mob as anything in GLOB.player_list)
				if(active_mob.real_name == name && active_mob.client && active_mob.client.inactivity <= 10 * 60 * 10)
					isactive[name] = "Active"
					break
		else
			isactive[name] = current_record.fields["p_stat"]
			//cael - to prevent multiple appearances of a player/job combination, add a continue after each line

		current_job = RoleAuthority.roles_by_name[real_rank]
		//They should have a job datum with their real rank, but they may not have a job datum defined for their gear preset.

		if(!current_job) // They don't have a job datum.
			if(current_record.fields["ref"])
				category = JOB_CATEGORY_OTHER // They do have a reference to a mob, likely means they were added manually by an admin.
			else
				continue // If they do not, skip them.
		else
			category = current_job.category // If we know their datum, grab the category.

		LAZYINITLIST(manifest_out[category]) //Initialize each individual category.
		if(category == JOB_CATEGORY_COMBAT)
			if(!squad_name)
				continue //If they are a combat role but have no squad, we skip them.
			LAZYINITLIST(manifest_out[category][squad_name]) //Initializes the squad itself.
			LAZYSET(manifest_out[category][squad_name][GET_SQUAD_ROLE_MAP(real_rank)], name, rank) //Initializes the person's information for that squad. We get their mapped role for sorting later. real_rank isn't shown in the manifest, it's backend only.
		else
			LAZYSET(manifest_out[category][real_rank], name, rank) //Initializes the job category as per normal.

	for(category in JOB_CATEGORY_ALL) //This keeps the list in the same order every time.
		category_list = manifest_out[category]
		if(!length(category_list))
			continue //Should not have empty lists, but it is possible for squads.
		dat += "<tr><th colspan=3>[category]</th></tr>" //We add this after we've established that we have the category listed.
		if(category == JOB_CATEGORY_COMBAT)
			for(var/datum/squad/current_squad as anything in RoleAuthority.squads)
				if(!category_list[current_squad.name])
					continue //Only if the squad is actually listed.
				dat += "<tr><th colspan=3>[current_squad.name]</th></tr>"
				for(real_rank in JOB_SQUAD_ROLES_LIST) //Again, here we have a static ordered list to properly sort every name.
					if(category_list[current_squad.name][real_rank])//May not exist.
						for(name in category_list[current_squad.name][real_rank]) //This nesting gets confusing. But it's manifest_out -> squad name -> real rank they are -> name = rank
							dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[category_list[current_squad.name][real_rank][name]]</td><td>[isactive[name]]</td></tr>"
							even = !even

		else
			//Who is sorted first or second will depend on when they were added to the data_core, priority to who is listed first. Small issue that can be addressed if there is a need for it.
			//Requires a sorting category list like is done for general sorting and squads. Trickier though.
			for(real_rank in category_list)
				for(name in category_list[real_rank])
					dat += "<tr[even ? " class='alt'" : ""]><td>[name]</td><td>[manifest_out[category][real_rank][name]]</td><td>[isactive[name]]</td></tr>"
					even = !even

	dat += "</table></div>"
	dat = replacetext(dat, "\n", "") // so it can be placed on paper correctly
	dat = replacetext(dat, "\t", "")
	return dat

/**
 * Adds all humans to manifest at round start provided they should be on the manifest.
 *
 * This fires at round start to add all humans to the manifest, those that should be added at least. It was previously possible to latejoin and be added twice, but I fixed that.
 * This previously took all of these lists: ROLES_CIC + ROLES_AUXIL_SUPPORT + ROLES_MISC + ROLES_POLICE + ROLES_ENGINEERING + ROLES_REQUISITION + ROLES_MEDICAL + ROLES_MARINES
 * And checked every mob for a role in that combined list. I was baffled by this, so I changed it. It checks only the roles that should have access to the manifest, dynamically.
 */
/datum/datacore/proc/manifest(nosleep = 0)
	spawn()
		if(!nosleep)
			sleep(40)

		var/roles_to_inject[] = GET_MANIFEST_ROLES //At the time of writing it takes (roundstart roles - blacklisted manifest roles) | additional roles added manually.

		for(var/mob/living/carbon/human/current_human as anything in GLOB.human_mob_list)
			if(!is_admin_level(current_human.z) && (current_human.job in roles_to_inject))
				manifest_inject(current_human)

/datum/datacore/proc/manifest_modify(name, datum/weakref/weak_ref, assignment, rank, p_stat, faction)

	var/datum/data/record/current_record
	if(istype(weak_ref))
		for(current_record as anything in general)
			if(current_record.fields["ref"] == weak_ref)
				if(assignment)
					current_record.fields["rank"] = assignment
				if(rank)
					current_record.fields["real_rank"] = rank
				if(p_stat)
					current_record.fields["p_stat"] = p_stat
				if(name)
					current_record.fields["name"] = name
				if(faction)
					current_record.fields["mob_faction"] = faction
				. = TRUE
				break
		if(name) // The rest only matters if we are changing their name.
			// To do: revise how records operate. It's silly that you have to iterate all of them and they are not connected to the reference.
			for(var/category in list(medical, security, locked))
				for(current_record as anything in category)
					if(current_record.fields["ref"] == weak_ref)
						current_record.fields["name"] = name
						break
	else
		for(current_record as anything in general)
			if(current_record.fields["name"] == name)
				if(assignment)
					current_record.fields["rank"] = assignment
				if(rank)
					current_record.fields["real_rank"] = rank
				if(p_stat)
					current_record.fields["p_stat"] = p_stat
				if(faction)
					current_record.fields["mob_faction"] = faction
				. = TRUE
				break

/datum/datacore/proc/manifest_inject(mob/living/carbon/human/H)
	var/datum/weak_ref = WEAKREF(H)
	for(var/datum/data/record/existing_record as anything in GLOB.data_core.general) //So they are not added to the manifest twice. Double records mess up reporting.
		if(existing_record.fields["ref"] == weak_ref)
			return FALSE //Already have a record for this human. Abort.

	var/assignment = GET_HUMAN_DEFAULT_ASSIGNMENT(H)

	var/id = add_zero(num2hex(H.gid), 6) //this was the best they could come up with? A large random number? *sigh*
	//var/icon/front = new(get_id_photo(H), dir = SOUTH)
	//var/icon/side = new(get_id_photo(H), dir = WEST)

	//General Record
	var/datum/data/record/G = new()
	G.fields["id"] = id
	G.fields["name"] = H.real_name
	G.fields["real_rank"] = H.job
	G.fields["rank"] = assignment
	G.fields["squad"] = H.assigned_squad ? H.assigned_squad.name : null
	G.fields["age"] = H.age
	G.fields["p_stat"] = H.species.manifest_alive
	G.fields["m_stat"] = "Stable"
	G.fields["sex"] = H.gender
	G.fields["species"] = H.get_species()
	G.fields["origin"] = H.origin
	G.fields["mob_faction"] = H.faction
	G.fields["religion"] = H.religion
	G.fields["ref"] = WEAKREF(H)
	//G.fields["photo_front"] = front
	//G.fields["photo_side"] = side

	if(H.gen_record && !jobban_isbanned(H, "Records"))
		G.fields["notes"] = H.gen_record
	else
		G.fields["notes"] = "No notes found."
	general += G

	//Medical Record
	var/datum/data/record/M = new()
	M.fields["id"] = id
	M.fields["name"] = H.real_name
	M.fields["b_type"] = H.blood_type
	M.fields["mi_dis"] = "None"
	M.fields["mi_dis_d"] = "No minor disabilities have been declared."
	M.fields["ma_dis"] = "None"
	M.fields["ma_dis_d"] = "No major disabilities have been diagnosed."
	M.fields["alg"] = "None"
	M.fields["alg_d"] = "No allergies have been detected in this patient."
	M.fields["cdi"] = "None"
	M.fields["cdi_d"] = "No diseases have been diagnosed at the moment."
	M.fields["last_scan_time"] = null
	M.fields["last_scan_result"] = "No scan data on record" // body scanner results
	M.fields["autodoc_data"] = list()
	M.fields["autodoc_manual"] = list()
	M.fields["ref"] = WEAKREF(H)

	if(H.med_record && !jobban_isbanned(H, "Records"))
		M.fields["notes"] = H.med_record
	else
		M.fields["notes"] = "No notes found."
	medical += M

	//Security Record
	var/datum/data/record/S = new()
	S.fields["id"] = id
	S.fields["name"] = H.real_name
	S.fields["criminal"] = "None"
	S.fields["incident"] = ""
	S.fields["ref"] = WEAKREF(H)

	if(H.sec_record && !jobban_isbanned(H, "Records"))
		var/new_comment = list("entry" = H.sec_record, "created_by" = list("name" = "\[REDACTED\]", "rank" = "Military Police"), "deleted_by" = null, "deleted_at" = null, "created_at" = "Pre-Deployment")
		S.fields["comments"] = list("1" = new_comment)
		S.fields["notes"] = H.sec_record
	security += S

	//Locked Record
	var/datum/data/record/L = new()
	L.fields["id"] = md5("[H.real_name][H.job]")
	L.fields["name"] = H.real_name
	L.fields["rank"] = H.job
	L.fields["age"] = H.age
	L.fields["sex"] = H.gender
	L.fields["b_type"] = H.b_type
	L.fields["species"] = H.get_species()
	L.fields["origin"] = H.origin

	L.fields["religion"] = H.religion
	L.fields["ref"] = WEAKREF(H)

	if(H.exploit_record && !jobban_isbanned(H, "Records"))
		L.fields["exploit_record"] = H.exploit_record
	else
		L.fields["exploit_record"] = "No additional information acquired."
	locked += L
	return TRUE

/// Removes all records attached it can find. Weakref only.
/datum/datacore/proc/manifest_erase(datum/weakref/weak_ref)

	if(istype(weak_ref)) // Make sure they're sending the right thing here.
		var/datum/data/record/current_record
		var/i
		for(var/list/category in list(general, medical, security, locked))

			for(i in category)
				current_record = i
				if(current_record.fields["ref"] == weak_ref)
					category -= current_record
					qdel(current_record)
					if(category == general)
						. = TRUE // So long as we got rid of the general record, we're good.
					break

/proc/get_id_photo(mob/living/carbon/human/H)
	var/icon/preview_icon = null

	//var/g = "m"
	//if (H.gender == FEMALE)
	// g = "f"

	var/icon/icobase = H.species.icobase
	var/icon/temp

	var/datum/skin_color/set_skin_color = GLOB.skin_color_list[H.skin_color]
	var/datum/body_type/set_body_type = GLOB.body_type_list[H.body_type]
	var/datum/body_size/set_body_size = GLOB.body_size_list[H.body_size]

	var/skin_color_icon
	var/body_type_icon
	var/body_size_icon

	if(!set_skin_color)
		skin_color_icon = "pale2"
	else
		skin_color_icon = set_skin_color.icon_name

	if(!set_body_type)
		body_type_icon = "lean"
	else
		body_type_icon = set_body_type.icon_name

	if(!set_body_size)
		body_size_icon = "avg"
	else
		body_size_icon = set_body_size.icon_name

	preview_icon = new /icon(icobase, get_limb_icon_name(H.species, body_size_icon, body_type_icon, H.gender, "torso", skin_color_icon))
	temp = new /icon(icobase, get_limb_icon_name(H.species, body_size_icon, body_type_icon, H.gender, "groin", skin_color_icon))
	preview_icon.Blend(temp, ICON_OVERLAY)
	temp = new /icon(icobase, get_limb_icon_name(H.species, body_size_icon, body_type_icon, H.gender, "head", skin_color_icon))
	preview_icon.Blend(temp, ICON_OVERLAY)

	for(var/obj/limb/E in H.limbs)
		if(E.status & LIMB_DESTROYED) continue
		temp = new /icon(icobase, get_limb_icon_name(H.species, body_size_icon, body_type_icon, H.gender, E.name, skin_color_icon))
		if(E.status & LIMB_ROBOT)
			temp.MapColors(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))
		preview_icon.Blend(temp, ICON_OVERLAY)

	//Tail
	if(H.species.tail)
		temp = new/icon("icon" = 'icons/effects/species.dmi', "icon_state" = "[H.species.tail]_s")
		preview_icon.Blend(temp, ICON_OVERLAY)


	var/icon/eyes_s = new/icon("icon" = 'icons/mob/humans/onmob/human_face.dmi', "icon_state" = H.species ? H.species.eyes : "eyes_s")

	eyes_s.Blend(rgb(H.r_eyes, H.g_eyes, H.b_eyes), ICON_ADD)

	var/datum/sprite_accessory/hair_style = GLOB.hair_styles_list[H.h_style]
	if(hair_style)
		var/icon/hair_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")
		hair_s.Blend(rgb(H.r_hair, H.g_hair, H.b_hair), ICON_ADD)
		eyes_s.Blend(hair_s, ICON_OVERLAY)

	var/datum/sprite_accessory/facial_hair_style = GLOB.facial_hair_styles_list[H.f_style]
	if(facial_hair_style)
		var/icon/facial_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_s")
		facial_s.Blend(rgb(H.r_facial, H.g_facial, H.b_facial), ICON_ADD)
		eyes_s.Blend(facial_s, ICON_OVERLAY)

	var/icon/clothes_s = null
	clothes_s = new /icon('icons/mob/humans/onmob/uniform_0.dmi', "marine_underpants_s")
	clothes_s.Blend(new /icon('icons/mob/humans/onmob/feet.dmi', "black"), ICON_UNDERLAY)
	preview_icon.Blend(eyes_s, ICON_OVERLAY)
	if(clothes_s)
		preview_icon.Blend(clothes_s, ICON_OVERLAY)
	qdel(eyes_s)
	qdel(clothes_s)

	return preview_icon

//These do not need to be global procs. They were who knows where before. Now they are here, where they belong.

/proc/CreateGeneralRecord(faction = FACTION_MARINE)
	var/datum/data/record/G = new /datum/data/record()
	G.fields["name"] = "New Record"
	G.fields["id"] = text("[]", add_zero(num2hex(rand(1, 1.6777215E7)), 6))
	G.fields["rank"] = "Unassigned"
	G.fields["real_rank"] = "Unassigned"
	G.fields["sex"] = "Male"
	G.fields["age"] = "Unknown"
	G.fields["ethnicity"] = "Unknown"
	G.fields["p_stat"] = "Alive"
	G.fields["m_stat"] = "Stable"
	G.fields["species"] = "Human"
	G.fields["origin"] = "Unknown"
	G.fields["mob_faction"] = faction
	G.fields["religion"] = "Unknown"
	GLOB.data_core.general += G
	return G

/proc/CreateSecurityRecord(name as text, id as text)
	var/datum/data/record/R = new /datum/data/record()
	R.fields["name"] = name
	R.fields["id"] = id
	R.name = text("Security Record #[id]")
	R.fields["incidents"] = "None"
	GLOB.data_core.security += R
	return R

/proc/create_medical_record(mob/living/carbon/human/H)
	var/datum/data/record/M = new /datum/data/record()
	M.fields["id"] = null
	M.fields["name"] = H.real_name
	M.fields["b_type"] = H.b_type
	M.fields["mi_dis"] = "None"
	M.fields["mi_dis_d"] = "No minor disabilities have been declared."
	M.fields["ma_dis"] = "None"
	M.fields["ma_dis_d"] = "No major disabilities have been diagnosed."
	M.fields["alg"] = "None"
	M.fields["alg_d"] = "No allergies have been detected in this patient."
	M.fields["cdi"] = "None"
	M.fields["cdi_d"] = "No diseases have been diagnosed at the moment."
	M.fields["last_scan_time"] = null
	M.fields["last_scan_result"] = "No scan data on record"
	M.fields["autodoc_data"] = list()
	M.fields["autodoc_manual"] = list()
	M.fields["ref"] = WEAKREF(H)
	GLOB.data_core.medical += M
	return M
