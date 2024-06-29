//returns TRUE if this mob has sufficient access to use this object
//returns FALSE otherwise
/obj/proc/allowed(mob/M)
	//check if it doesn't require any access at all
	if(check_access() || isRemoteControlling(M))
		return TRUE

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		//if they are holding or wearing a card that has access, that works
		if(check_access(H.get_active_hand()) || check_access(H.wear_id))
			return TRUE
		return check_yautja_access(H)
	if(istype(M, /mob/living/carbon/xenomorph))
		var/mob/living/carbon/C = M
		if(check_access(C.get_active_hand()))
			return TRUE
		return FALSE

/obj/proc/check_yautja_access(mob/living/carbon/human/yautja)
	if(!istype(yautja))
		return FALSE
	var/obj/item/clothing/gloves/yautja/hunter/bracer = yautja.gloves
	if(!istype(bracer) || !bracer.embedded_id || !check_access(bracer.embedded_id))
		return FALSE
	return TRUE

/obj/item/proc/GetAccess() return list()

/obj/item/proc/GetID() return

/obj/proc/text2access(access_text)
	. = list()
	if(!access_text)
		return
	var/list/split = splittext(access_text,";")
	for(var/x in split)
		var/n = text2num(x)
		if(n)
			. += n

/obj/proc/gen_access()
	if(req_access_txt)
		req_access = list()
		for(var/a in text2access(req_access_txt))
			req_access += a
		req_access_txt = null
	if(!req_access)
		req_access = list()

	if(req_one_access_txt)
		req_one_access = list()
		for(var/a in text2access(req_one_access_txt))
			req_one_access += a
		req_one_access_txt = null
	if(!req_one_access)
		req_one_access = list()

/obj/proc/check_access(obj/item/I)
	//These generations have been moved out of /obj/New() because they were slowing down the creation of objects that never even used the access system.
	gen_access()
	if(!islist(req_access)) return 1//something's very wrong
	var/L[] = req_access
	if(!L.len && (!req_one_access || !req_one_access.len)) return 1//no requirements
	if(!I) return

	var/list/A = I.GetAccess()
	for(var/i in req_access)
		if(!(i in A))
			return FALSE//doesn't have this access

	if(req_one_access && req_one_access.len)
		for(var/i in req_one_access)
			if(i in A)
				return TRUE//has an access from the single access list
		return FALSE
	return TRUE

/obj/proc/check_access_list(L[])
	gen_access()
	if(!req_access  && !req_one_access) return 1
	if(!islist(req_access)) return 1
	if(!req_access.len && !islist(req_one_access))
		return TRUE
	if(!req_access.len && (!req_one_access || !req_one_access.len)) return 1
	if(!islist(L)) return
	var/i
	for(i in req_access)
		if(!(i in L)) return //doesn't have this access
	if(req_one_access && req_one_access.len)
		for(i in req_one_access)
			if(i in L) return 1//has an access from the single access list
		return
	return 1


/proc/get_access(access_list = ACCESS_LIST_GLOBAL)
	switch(access_list)
		if(ACCESS_LIST_GLOBAL)
			return list(ACCESS_ILLEGAL_PIRATE) + get_access(ACCESS_LIST_MARINE_ALL) + get_access(ACCESS_LIST_WY_ALL) + get_access(ACCESS_LIST_COLONIAL_ALL) + get_access(ACCESS_LIST_CLF_ALL) + get_access(ACCESS_LIST_UPP_ALL)
		if(ACCESS_LIST_MARINE_MAIN)
			return list(
				ACCESS_MARINE_SENIOR,
				ACCESS_MARINE_DATABASE,
				ACCESS_MARINE_COMMAND,
				ACCESS_MARINE_CMP,
				ACCESS_MARINE_BRIG,
				ACCESS_MARINE_ARMORY,
				ACCESS_MARINE_CMO,
				ACCESS_MARINE_MEDBAY,
				ACCESS_MARINE_CHEMISTRY,
				ACCESS_MARINE_MORGUE,
				ACCESS_MARINE_RESEARCH,
				ACCESS_MARINE_CE,
				ACCESS_MARINE_ENGINEERING,
				ACCESS_MARINE_MAINT,
				ACCESS_MARINE_OT,
				ACCESS_MARINE_RO,
				ACCESS_MARINE_CARGO,
				ACCESS_MARINE_PREP,
				ACCESS_MARINE_MEDPREP,
				ACCESS_MARINE_ENGPREP,
				ACCESS_MARINE_SMARTPREP,
				ACCESS_MARINE_LEADER,
				ACCESS_MARINE_SPECPREP,
				ACCESS_MARINE_TL_PREP,
				ACCESS_MARINE_ALPHA,
				ACCESS_MARINE_BRAVO,
				ACCESS_MARINE_CHARLIE,
				ACCESS_MARINE_DELTA,
				ACCESS_MARINE_PILOT,
				ACCESS_MARINE_DROPSHIP,
				ACCESS_MARINE_SEA,
				ACCESS_MARINE_KITCHEN,
				ACCESS_MARINE_SYNTH,
				ACCESS_MARINE_ASO,
				ACCESS_MARINE_CHAPLAIN,
				ACCESS_PRESS,
			)

		if(ACCESS_LIST_MARINE_ALL)
			return list(
				ACCESS_MARINE_CO,
				ACCESS_MARINE_AI,
				ACCESS_MARINE_AI_TEMP,
			) + get_access(ACCESS_LIST_MARINE_MAIN)

		if(ACCESS_LIST_MARINE_REGIONS)
			return list(
				"[MAIN_SHIP_NAME] Security" = list(ACCESS_MARINE_CMP, ACCESS_MARINE_BRIG, ACCESS_MARINE_ARMORY),
				"[MAIN_SHIP_NAME] Medbay" = list(ACCESS_MARINE_CMO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_MORGUE, ACCESS_MARINE_CHEMISTRY),
				"[MAIN_SHIP_NAME] Research" = list(ACCESS_MARINE_RESEARCH, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_MORGUE),
				"[MAIN_SHIP_NAME] Engineering" = list(ACCESS_MARINE_CE, ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_OT, ACCESS_MARINE_MAINT),
				"[MAIN_SHIP_NAME] Command" = list(ACCESS_MARINE_SENIOR, ACCESS_MARINE_DATABASE, ACCESS_MARINE_COMMAND, ACCESS_MARINE_RO, ACCESS_MARINE_CARGO, ACCESS_MARINE_SEA, ACCESS_MARINE_SYNTH,),
				"Marines" = list(ACCESS_MARINE_PREP, ACCESS_MARINE_MEDPREP, ACCESS_MARINE_ENGPREP, ACCESS_MARINE_SMARTPREP, ACCESS_MARINE_LEADER, ACCESS_MARINE_SPECPREP, ACCESS_MARINE_TL_PREP, ACCESS_MARINE_KITCHEN),
				"Squads" = list(ACCESS_MARINE_ALPHA, ACCESS_MARINE_BRAVO, ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DELTA),
				"Civilian" = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_MEDBAY, ACCESS_CIVILIAN_COMMAND),
			)

		if(ACCESS_LIST_USCM_GROUND_MAIN)
			return list(
				ACCESS_USCM_GROUND_GENERAL,
				ACCESS_USCM_GROUND_MAINT,
				ACCESS_USCM_GROUND_SYNTH,
				ACCESS_USCM_GROUND_MEDICAL,
				ACCESS_USCM_GROUND_ARMORY,
				ACCESS_USCM_GROUND_GUEST,
				ACCESS_USCM_GROUND_LOCKDOWN,
				ACCESS_USCM_GROUND_SMARTPREP,
				ACCESS_USCM_GROUND_MEDPREP,
				ACCESS_USCM_GROUND_SPECPREP,
				ACCESS_USCM_GROUND_TLPREP,
				ACCESS_USCM_GROUND_PLATOONL,
				ACCESS_USCM_GROUND_PLATOON_ONE,
				ACCESS_USCM_GROUND_PLATOON_TWO,
				ACCESS_USCM_GROUND_COMMAND,
				ACCESS_USCM_GROUND_WAREHOUSE,
				ACCESS_USCM_GROUND_CHECKPOINT,
			)


		if(ACCESS_LIST_USCM_GROUND_ALL)
			return list(
				ACCESS_USCM_GROUND_CO_OFFICE,
				ACCESS_USCM_GROUND_CO_QUARTERS,
				ACCESS_USCM_GROUND_LT,
			) + get_access(ACCESS_LIST_USCM_GROUND_MAIN)

		if(ACCESS_LIST_USCM_GROUND_REGIONS)
			return list(
				"Outpost Command" = list(ACCESS_USCM_GROUND_LOCKDOWN, ACCESS_USCM_GROUND_COMMAND, ACCESS_USCM_GROUND_CO_OFFICE, ACCESS_USCM_GROUND_CO_QUARTERS, ACCESS_USCM_GROUND_LT,),
				"Outpost Security" = list(ACCESS_USCM_GROUND_ARMORY, ACCESS_USCM_GROUND_CHECKPOINT,),
				"Outpost Support" = list(ACCESS_USCM_GROUND_MAINT, ACCESS_USCM_GROUND_SYNTH, ACCESS_USCM_GROUND_MEDICAL, ACCESS_USCM_GROUND_WAREHOUSE,),
				"Outpost Marines" = list(ACCESS_USCM_GROUND_GENERAL, ACCESS_USCM_GROUND_SMARTPREP, ACCESS_USCM_GROUND_MEDPREP, ACCESS_USCM_GROUND_SPECPREP, ACCESS_USCM_GROUND_TLPREP, ACCESS_USCM_GROUND_PLATOONL,),
				"Outpost Squads" = list(ACCESS_USCM_GROUND_PLATOON_ONE, ACCESS_USCM_GROUND_PLATOON_TWO,),
				"Outpost Guest" = list(ACCESS_USCM_GROUND_GUEST,),
			)

		if(ACCESS_LIST_EMERGENCY_RESPONSE)
			return list(
				ACCESS_MARINE_MAINT,
				ACCESS_MARINE_MEDBAY,
				ACCESS_MARINE_KITCHEN,
				ACCESS_PRESS,
			)

		if(ACCESS_LIST_UA)
			return get_access(ACCESS_LIST_MARINE_MAIN) + get_access(ACCESS_LIST_USCM_GROUND_ALL) + get_access(ACCESS_LIST_COLONIAL_ALL)

		if(ACCESS_LIST_MARINE_LIAISON)
			return list(
				ACCESS_WY_GENERAL,
				ACCESS_WY_COLONIAL,
				ACCESS_WY_FLIGHT,
				ACCESS_WY_RESEARCH,
				ACCESS_WY_EXEC,
				ACCESS_MARINE_COMMAND,
				ACCESS_MARINE_RESEARCH,
				ACCESS_MARINE_MEDBAY,
			) + get_access(ACCESS_LIST_COLONIAL_ALL)

		if(ACCESS_LIST_COLONIAL_ALL)
			return list(
				ACCESS_CIVILIAN_PUBLIC,
				ACCESS_CIVILIAN_RESEARCH,
				ACCESS_CIVILIAN_ENGINEERING,
				ACCESS_CIVILIAN_LOGISTICS,
				ACCESS_CIVILIAN_BRIG,
				ACCESS_CIVILIAN_MEDBAY,
				ACCESS_CIVILIAN_COMMAND,
			)

		if(ACCESS_LIST_COLONIAL_REGIONS)
			return list(
				"Civilian Security" = list(ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_PUBLIC),
				"Civilian Medbay" = list(ACCESS_CIVILIAN_MEDBAY),
				"Civilian Research" = list(ACCESS_CIVILIAN_RESEARCH),
				"Civilian Engineering" = list(ACCESS_CIVILIAN_ENGINEERING),
				"Civilian Command" = list(ACCESS_CIVILIAN_LOGISTICS, ACCESS_CIVILIAN_COMMAND),
			)

		if(ACCESS_LIST_CIVIL_LIAISON)
			return list(
				ACCESS_WY_GENERAL,
				ACCESS_WY_COLONIAL,
				ACCESS_WY_RESEARCH,
				ACCESS_WY_EXEC,
			) + get_access(ACCESS_LIST_COLONIAL_ALL)

		if(ACCESS_LIST_DELIVERY)
			return list(
				ACCESS_MARINE_COMMAND,
				ACCESS_MARINE_CARGO,
				ACCESS_CIVILIAN_PUBLIC,
				ACCESS_CIVILIAN_RESEARCH,
				ACCESS_CIVILIAN_ENGINEERING,
				ACCESS_CIVILIAN_LOGISTICS,
			)


		if(ACCESS_LIST_WY_ALL)
			return list(
				ACCESS_WY_GENERAL,
				ACCESS_WY_COLONIAL,
				ACCESS_WY_MEDICAL,
				ACCESS_WY_SECURITY,
				ACCESS_WY_ENGINEERING,
				ACCESS_WY_FLIGHT,
				ACCESS_WY_RESEARCH,
				ACCESS_WY_EXEC,
				ACCESS_WY_PMC,
				ACCESS_WY_PMC_TL,
				ACCESS_WY_ARMORY,
				ACCESS_WY_SECRETS,
				ACCESS_WY_LEADERSHIP,
				ACCESS_WY_SENIOR_LEAD,
			) + get_access(ACCESS_LIST_COLONIAL_ALL)

		if(ACCESS_LIST_WY_BASE)
			return list(
				ACCESS_WY_GENERAL,
				ACCESS_WY_COLONIAL,
				ACCESS_WY_MEDICAL,
			)

		if(ACCESS_LIST_WY_SENIOR)
			return list(
				ACCESS_WY_GENERAL,
				ACCESS_WY_COLONIAL,
				ACCESS_WY_MEDICAL,
				ACCESS_WY_SECURITY,
				ACCESS_WY_ENGINEERING,
				ACCESS_WY_FLIGHT,
				ACCESS_WY_RESEARCH,
				ACCESS_WY_EXEC,
				ACCESS_WY_PMC,
				ACCESS_WY_PMC_TL,
				ACCESS_WY_ARMORY,
				ACCESS_WY_LEADERSHIP,
				ACCESS_WY_SENIOR_LEAD,
			) + get_access(ACCESS_LIST_COLONIAL_ALL)

		if(ACCESS_LIST_WY_GOON)
			return list(
				ACCESS_WY_GENERAL,
				ACCESS_WY_COLONIAL,
				ACCESS_WY_MEDICAL,
				ACCESS_WY_SECURITY,
				ACCESS_WY_RESEARCH,
				ACCESS_WY_ARMORY,
			) + get_access(ACCESS_LIST_COLONIAL_ALL) + get_access(ACCESS_LIST_EMERGENCY_RESPONSE)

		if(ACCESS_LIST_WY_PMC)
			return list(
				ACCESS_WY_PMC,
				ACCESS_WY_ENGINEERING,
				ACCESS_WY_FLIGHT,
			) + get_access(ACCESS_LIST_WY_GOON)

		if(ACCESS_LIST_WY_REGIONS)
			return list(
				"WY Security" = list(ACCESS_WY_GENERAL, ACCESS_WY_COLONIAL, ACCESS_WY_SECURITY, ACCESS_WY_ARMORY,),
				"WY Medical" = list(ACCESS_WY_MEDICAL,),
				"WY Research" = list(ACCESS_WY_RESEARCH,),
				"WY Engineering" = list(ACCESS_WY_ENGINEERING,),
				"WY Management" = list(ACCESS_WY_EXEC, ACCESS_WY_SECRETS, ACCESS_WY_LEADERSHIP, ACCESS_WY_SENIOR_LEAD,),
			)

		if(ACCESS_LIST_PMC_REGIONS)
			return list(
				"WY Security" = list(ACCESS_CIVILIAN_BRIG, ACCESS_CIVILIAN_PUBLIC),
				"WY Medbay" = list(ACCESS_CIVILIAN_MEDBAY),
				"WY Research" = list(ACCESS_CIVILIAN_RESEARCH),
				"WY Engineering" = list(ACCESS_CIVILIAN_ENGINEERING),
				"WY PMC" = list(ACCESS_WY_PMC, ACCESS_WY_ENGINEERING, ACCESS_WY_FLIGHT,),
			)

		if(ACCESS_LIST_CLF_ALL)
			return list(
				ACCESS_CLF_SECURITY,
				ACCESS_CLF_ARMORY,
				ACCESS_CLF_LEADERSHIP,
				ACCESS_CLF_SENIOR_LEAD,
			) + get_access(ACCESS_LIST_CLF_BASE)

		if(ACCESS_LIST_CLF_BASE)
			return list(
				ACCESS_CLF_GENERAL,
				ACCESS_CLF_MEDICAL,
				ACCESS_CLF_ENGINEERING,
			) + get_access(ACCESS_LIST_COLONIAL_ALL) + get_access(ACCESS_LIST_EMERGENCY_RESPONSE)

		if(ACCESS_LIST_CLF_REGIONS)
			return list(
				"CLF Base" = list(ACCESS_CLF_GENERAL, ACCESS_CLF_MEDICAL, ACCESS_CLF_ENGINEERING,),
				"CLF Leadership" = list(ACCESS_CLF_SECURITY, ACCESS_CLF_ARMORY, ACCESS_CLF_LEADERSHIP, ACCESS_CLF_SENIOR_LEAD,),
			)

		if(ACCESS_LIST_UPP_ALL)
			return list(
				ACCESS_UPP_GENERAL,
				ACCESS_UPP_MEDICAL,
				ACCESS_UPP_ENGINEERING,
				ACCESS_UPP_SECURITY,
				ACCESS_UPP_ARMORY,
				ACCESS_UPP_FLIGHT,
				ACCESS_UPP_RESEARCH,
				ACCESS_UPP_COMMANDO,
				ACCESS_UPP_LEADERSHIP,
				ACCESS_UPP_SENIOR_LEAD,
			) + get_access(ACCESS_LIST_COLONIAL_ALL) + get_access(ACCESS_LIST_EMERGENCY_RESPONSE)

		if(ACCESS_LIST_UPP_PLATOON)
			return list(
				ACCESS_UPP_GENERAL,
				ACCESS_UPP_MEDICAL,
				ACCESS_UPP_FLIGHT,
				ACCESS_UPP_LEADERSHIP,
				ACCESS_UPP_SENIOR_LEAD,
				ACCESS_UPP_MEDPREP,
				ACCESS_UPP_TLPREP,
				ACCESS_UPP_MACHINEGUN
			)

		if(ACCESS_LIST_UPP_REGIONS)
			return list(
				"UPP General" = list(ACCESS_UPP_GENERAL, ACCESS_UPP_MEDICAL, ACCESS_UPP_ENGINEERING, ACCESS_UPP_RESEARCH,),
				"UPP Kommand" = list(ACCESS_UPP_SECURITY, ACCESS_UPP_ARMORY, ACCESS_UPP_FLIGHT, ACCESS_UPP_LEADERSHIP,),
				"UPP Senior Kommand" = list(ACCESS_UPP_SENIOR_LEAD,),
				"UPP Elite" = list(ACCESS_UPP_COMMANDO,),
			)


		if(ACCESS_LIST_TWE_ALL)
			return list(
				ACCESS_TWE_GENERAL,
				ACCESS_TWE_MEDICAL,
				ACCESS_TWE_ENGINEERING,
				ACCESS_TWE_SECURITY,
				ACCESS_TWE_ARMORY,
				ACCESS_TWE_FLIGHT,
				ACCESS_TWE_RESEARCH,
				ACCESS_TWE_COMMANDO,
				ACCESS_TWE_LEADERSHIP,
				ACCESS_TWE_SENIOR_LEAD,
			)

		if(ACCESS_LIST_UPP_REGIONS)
			return list(
				"TWE Base" = get_access(ACCESS_TWE_GENERAL, ACCESS_TWE_MEDICAL, ACCESS_TWE_ENGINEERING, ACCESS_TWE_RESEARCH,),
				"TWE Command" = get_access(ACCESS_TWE_SECURITY, ACCESS_TWE_ARMORY, ACCESS_TWE_FLIGHT, ACCESS_TWE_LEADERSHIP,),
				"TWE Senior Command" = list(ACCESS_TWE_SENIOR_LEAD,),
				"TWE Elite" = list(ACCESS_TWE_COMMANDO,),
			)


/proc/get_access_desc(A)
	switch(A)
		if(ACCESS_MARINE_CMP)
			return "CMP's Office"
		if(ACCESS_MARINE_BRIG)
			return "Brig"
		if(ACCESS_MARINE_ARMORY)
			return "Armory"
		if(ACCESS_MARINE_CMO)
			return "CMO's Office"
		if(ACCESS_MARINE_MEDBAY)
			return "[MAIN_SHIP_NAME] Medbay"
		if(ACCESS_MARINE_RESEARCH)
			return "[MAIN_SHIP_NAME] Research"
		if(ACCESS_MARINE_CHEMISTRY)
			return "[MAIN_SHIP_NAME] Chemistry"
		if(ACCESS_MARINE_MORGUE)
			return "[MAIN_SHIP_NAME] Morgue"
		if(ACCESS_MARINE_CE)
			return "CE's Office"
		if(ACCESS_MARINE_RO)
			return "RO's Office"
		if(ACCESS_MARINE_ENGINEERING)
			return "[MAIN_SHIP_NAME] Engineering"
		if(ACCESS_MARINE_OT)
			return "[MAIN_SHIP_NAME] Ordnance Workshop"
		if(ACCESS_MARINE_SENIOR)
			return "[MAIN_SHIP_NAME] Senior Command"
		if(ACCESS_MARINE_CO)
			return "Commander's Quarters"
		if(ACCESS_MARINE_DATABASE)
			return "[MAIN_SHIP_NAME]'s Database"
		if(ACCESS_MARINE_COMMAND)
			return "[MAIN_SHIP_NAME] Command"
		if(ACCESS_MARINE_CREWMAN)
			return "Vehicle Crewman"
		if(ACCESS_MARINE_PREP)
			return "Marine Prep"
		if(ACCESS_MARINE_ENGPREP)
			return "Marine Squad Engineering"
		if(ACCESS_MARINE_MEDPREP)
			return "Marine Squad Medical"
		if(ACCESS_MARINE_SPECPREP)
			return "Marine Weapons Specialist"
		if(ACCESS_MARINE_SMARTPREP)
			return "Marine Smartgunner"
		if(ACCESS_MARINE_TL_PREP)
			return "Marine Team Leader"
		if(ACCESS_MARINE_LEADER)
			return "Marine Leader"
		if(ACCESS_MARINE_ALPHA)
			return "Alpha Squad"
		if(ACCESS_MARINE_BRAVO)
			return "Bravo Squad"
		if(ACCESS_MARINE_CHARLIE)
			return "Charlie Squad"
		if(ACCESS_MARINE_DELTA)
			return "Delta Squad"
		if(ACCESS_MARINE_CARGO)
			return "Requisitions"
		if(ACCESS_MARINE_DROPSHIP)
			return "Dropship Piloting"
		if(ACCESS_MARINE_PILOT)
			return "Pilot Gear"
		if(ACCESS_MARINE_MAINT)
			return "[MAIN_SHIP_NAME] Maintenance"
		if(ACCESS_CIVILIAN_RESEARCH)
			return "Civilian Research"
		if(ACCESS_CIVILIAN_COMMAND)
			return "Civilian Command"
		if(ACCESS_CIVILIAN_MEDBAY)
			return "Civilian Medbay"
		if(ACCESS_CIVILIAN_LOGISTICS)
			return "Civilian Logistics"
		if(ACCESS_CIVILIAN_ENGINEERING)
			return "Civilian Engineering"
		if(ACCESS_CIVILIAN_BRIG)
			return "Civilian Brig"
		if(ACCESS_CIVILIAN_PUBLIC)
			return "Civilian"
		if(ACCESS_MARINE_SEA)
			return "SEA's Office"
		if(ACCESS_MARINE_KITCHEN)
			return "Kitchen"
		if(ACCESS_MARINE_SYNTH)
			return "Synthetic Storage"
		if(ACCESS_MARINE_AI)
			return "AI Core"
		if(ACCESS_MARINE_AI_TEMP)
			return "AI Access"
		if(ACCESS_ARES_DEBUG)
			return "AI Debug"

		//USCM Ground
		if(ACCESS_USCM_GROUND_GENERAL)
			return "Outpost General"
		if(ACCESS_USCM_GROUND_MAINT)
			return "Outpost Maintenance"
		if(ACCESS_USCM_GROUND_SYNTH)
			return "Outpost Synthetic"
		if(ACCESS_USCM_GROUND_MEDICAL)
			return "Outpost Sickbay"
		if(ACCESS_USCM_GROUND_ARMORY)
			return "Outpost Armory"
		if(ACCESS_USCM_GROUND_GUEST)
			return "Outpost Guesthouse"
		if(ACCESS_USCM_GROUND_LOCKDOWN)
			return "Outpost Lockdown"
		if(ACCESS_USCM_GROUND_SMARTPREP)
			return "Outpost Specialist"
		if(ACCESS_USCM_GROUND_MEDPREP)
			return "Outpost Corpsman"
		if(ACCESS_USCM_GROUND_SPECPREP)
			return "Outpost Specialist"
		if(ACCESS_USCM_GROUND_TLPREP)
			return "Outpost Squad Sergeant"
		if(ACCESS_USCM_GROUND_PLATOONL)
			return "Outpost Platoon Sergeant"
		if(ACCESS_USCM_GROUND_COMMAND)
			return "Outpost Command"
		if(ACCESS_USCM_GROUND_CO_OFFICE)
			return "Outpost Captain's Office"
		if(ACCESS_USCM_GROUND_CO_QUARTERS)
			return "Outpost Captain's Quarters"
		if(ACCESS_USCM_GROUND_LT)
			return "Outpost Lieutenant's Office"
		if(ACCESS_USCM_GROUND_WAREHOUSE)
			return "Outpost Supply Warehouse"
		if(ACCESS_USCM_GROUND_CHECKPOINT)
			return "Outpost Security Checkpoint"
		if(ACCESS_USCM_GROUND_PLATOON_ONE)
			return "Platoon [SQUAD_USCM_GROUND_1]"
		if(ACCESS_USCM_GROUND_PLATOON_TWO)
			return "Platoon [SQUAD_USCM_GROUND_2]"

		//WY
		if(ACCESS_WY_GENERAL)
			return "Wey-Yu General"
		if(ACCESS_WY_COLONIAL)
			return "Wey-Yu Colony"
		if(ACCESS_WY_MEDICAL)
			return "Wey-Yu Medical"
		if(ACCESS_WY_SECURITY)
			return "Wey-Yu Security"
		if(ACCESS_WY_ENGINEERING)
			return "Wey-Yu Engineering"
		if(ACCESS_WY_FLIGHT)
			return "Wey-Yu Flight Control"
		if(ACCESS_WY_RESEARCH)
			return "Wey-Yu Research"
		if(ACCESS_WY_EXEC)
			return "Wey-Yu Corporate"
		if(ACCESS_WY_PMC)
			return "Wey-Yu PMC"
		if(ACCESS_WY_PMC_TL)
			return "Wey-Yu PMC Lead"
		if(ACCESS_WY_ARMORY)
			return "Wey-Yu Armory"
		if(ACCESS_WY_SECRETS)
			return "Wey-Yu HighSec"
		if(ACCESS_WY_LEADERSHIP)
			return "Wey-Yu Leadership"
		if(ACCESS_WY_SENIOR_LEAD)
			return "Wey-Yu Senior Leadership"

		//UPP
		if(ACCESS_UPP_GENERAL)
			return "UPP Genral"
		if(ACCESS_UPP_MEDICAL)
			return "UPP Medical"
		if(ACCESS_UPP_ENGINEERING)
			return "UPP Engineering"
		if(ACCESS_UPP_SECURITY)
			return "UPP Security"
		if(ACCESS_UPP_ARMORY)
			return "UPP Armory"
		if(ACCESS_UPP_FLIGHT)
			return "UPP Flight Control"
		if(ACCESS_UPP_RESEARCH)
			return "UPP Research"
		if(ACCESS_UPP_SQUAD_ONE)
			return "UPP Squad One"
		if(ACCESS_UPP_SQUAD_TWO)
			return "UPP Squad Two"
		if(ACCESS_UPP_COMMANDO)
			return "UPP Kommando"
		if(ACCESS_UPP_LEADERSHIP)
			return "UPP Leadership"
		if(ACCESS_UPP_SENIOR_LEAD)
			return "UPP Senior Leadership"
		if(ACCESS_UPP_MEDPREP)
			return "UPP Medical Prep"
		if(ACCESS_UPP_MACHINEGUN)
			return "UPP Machinegunner Prep"
		if(ACCESS_UPP_TLPREP)
			return "UPP Squad Leader Prep"

		//CLF
		if(ACCESS_CLF_GENERAL)
			return "CLF General"
		if(ACCESS_CLF_MEDICAL)
			return "CLF Medical"
		if(ACCESS_CLF_ENGINEERING)
			return "CLF Engineering"
		if(ACCESS_CLF_SECURITY)
			return "CLF Security"
		if(ACCESS_CLF_ARMORY)
			return "CLF Armory"
		if(ACCESS_CLF_FLIGHT)
			return "CLF Flight Control"
		if(ACCESS_CLF_LEADERSHIP)
			return "CLF Leadership"
		if(ACCESS_CLF_SENIOR_LEAD)
			return "CLF Senior Leadership"

		//TWE
		if(ACCESS_TWE_GENERAL)
			return "TWE General"
		if(ACCESS_TWE_MEDICAL)
			return "TWE Medical"
		if(ACCESS_TWE_ENGINEERING)
			return "TWE Engineering"
		if(ACCESS_TWE_SECURITY)
			return "TWE Security"
		if(ACCESS_TWE_ARMORY)
			return "TWE Armory"
		if(ACCESS_TWE_FLIGHT)
			return "TWE Flight Control"
		if(ACCESS_TWE_RESEARCH)
			return "TWE Research"
		if(ACCESS_TWE_COMMANDO)
			return "TWE Commando"
		if(ACCESS_TWE_LEADERSHIP)
			return "TWE Leadership"
		if(ACCESS_TWE_SENIOR_LEAD)
			return "TWE Senior Leadership"



