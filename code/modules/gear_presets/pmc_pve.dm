// new file - don't wanna cram this in with other pmc's, feels bloaty

// riflemen
/datum/equipment_preset/uscm/pmc
	name = "Tactical Unit"
	paygrade = "PMC-OP"
	role_comm_title = "TacUnit"
	access = list(ACCESS_WY_GENERAL)
	faction_group = FACTION_LIST_WY
	faction = FACTION_PMC
	idtype = /obj/item/card/id/pmc
	assignment = JOB_PMCPLAT_STANDARD
	rank = JOB_SQUAD_MARINE
	flags = EQUIPMENT_PRESET_START_OF_ROUND|EQUIPMENT_PRESET_MARINE
	skills = /datum/skills/pfc
	uses_special_name = TRUE

/datum/equipment_preset/uscm/pmc/load_name(mob/living/carbon/human/new_human, randomise)
	var/list/initial_name = splittext(new_human.real_name, " ")
	var/first_name = initial_name[1]
	var/last_name = initial_name[2]
	switch(first_name[1])
		if("A")
			first_name = pick("Alpha", "Aleph", "Alfa", "Azure", "Apricot")
		if("B")
			first_name = pick("Beta", "Bravo", "Brown", "Bronze", "Burgundy")
		if("C")
			first_name = pick("Charlie", "Carmine", "Celadon", "Crimson", "Cardinal")
		if("D")
			first_name = pick("Delta", "Denim", "Dalet", "Dodger", "Digamma", "Diamond")
		if("E")
			first_name = pick("Echo", "Epsilon", "Emerald", "Erin", "Electric")
		if("F")
			first_name = pick("Foxtrot", "Fuchsia", "Fire", "Five", "Flame")
		if("G")
			first_name = pick("Golf", "Gamma", "Gimel", "Gold", "Ghost")
		if("H")
			first_name = pick("Hotel", "Heta", "Heliotrope", "Hunter", "Houston")
		if("I")
			first_name = pick("India", "Iota", "Indigo", "Ivory", "Infra")
		if("J")
			first_name = pick("Juliett", "Jasmine", "Jet", "Jonquil", "Jungle")
		if("K")
			first_name = pick("Kilo", "Kappa", "Khaki", "Kaph", "Key")
		if("L")
			first_name = pick("Lima", "Lambda", "Lime", "Lavender", "Lamed")
		if("M")
			first_name = pick("Mike", "Mu", "Monday", "Magenta", "Mango")
		if("N")
			first_name = pick("November", "Nu", "Nanda", "Navy", "Neon")
		if("O")
			first_name = pick("Oscar", "Omicron", "Omega", "Onyx", "Olive")
		if("P")
			first_name = pick("Papa", "Pi", "Psi", "Purple", "Pink")
		if("Q")
			first_name = pick("Quebec", "Qoph", "Qoppa", "Queen", "Quicksilver")
		if("R")
			first_name = pick("Romeo", "Resh", "Red", "Raspberry", "Rocket")
		if("S")
			first_name = pick("Sierra", "Sigma", "Samekh", "Scarlet", "Shadow")
		if("T")
			first_name = pick("Tango", "Theta", "Tau", "Teal", "Turquoise")
		if("U")
			first_name = pick("Uniform", "Umbra", "Ultramarine", "Unity", "Ultima")
		if("V")
			first_name = pick("Victor", "Viridan", "Vermilion", "Violet", "Volt")
		if("W")
			first_name = pick("Whiskey", "Wolf", "White", "Winter", "Wine")
		if("X")
			first_name = pick("X-ray", "Xi", "Xanadu", "Xanthic", "Ex")
		if("Y")
			first_name = pick("Yankee", "Yodh", "Yellow", "York", "Yale")
		if("Z")
			first_name = pick("Zulu", "Zeta", "Zayin", "Zed", "Zaffre")
		else
			first_name = pick("Nadazero", "Unaone", "Terrathree", "Kartefour", "Pantafive", "Soxisix", "Setteseven", "Oktoeight", "Novenine")

	switch(last_name[1])
		if("A")
			last_name = pick("Alpha", "Aleph", "Alfa", "Azure", "Apricot")
		if("B")
			last_name = pick("Beta", "Bravo", "Brown", "Bronze", "Burgundy")
		if("C")
			last_name = pick("Charlie", "Carmine", "Celadon", "Crimson", "Cardinal")
		if("D")
			last_name = pick("Delta", "Denim", "Dalet", "Dodger", "Digamma", "Diamond")
		if("E")
			last_name = pick("Echo", "Epsilon", "Emerald", "Erin", "Electric")
		if("F")
			first_name = pick("Foxtrot", "Fuchsia", "Fire", "Five", "Flame")
		if("G")
			last_name = pick("Golf", "Gamma", "Gimel", "Gold", "Ghost")
		if("H")
			last_name = pick("Hotel", "Heta", "Heliotrope", "Hunter", "Houston")
		if("I")
			last_name = pick("India", "Iota", "Indigo", "Ivory", "Infra")
		if("J")
			last_name = pick("Juliett", "Jasmine", "Jet", "Jonquil", "Jungle")
		if("K")
			last_name = pick("Kilo", "Kappa", "Khaki", "Kaph", "Key")
		if("L")
			last_name = pick("Lima", "Lambda", "Lime", "Lavender", "Lamed")
		if("M")
			last_name = pick("Mike", "Mu", "Mem", "Magenta", "Mango")
		if("N")
			last_name = pick("November", "Nu", "Nun", "Navy", "Neon")
		if("O")
			last_name = pick("Oscar", "Omicron", "Omega", "Onyx", "Olive")
		if("P")
			last_name = pick("Papa", "Pi", "Psi", "Purple", "Pink")
		if("Q")
			last_name = pick("Quebec", "Qoph", "Qoppa", "Queen", "Quicksilver")
		if("R")
			first_name = pick("Romeo", "Resh", "Red", "Raspberry", "Rocket")
		if("S")
			last_name = pick("Sierra", "Sigma", "Samekh", "Scarlet", "Shadow")
		if("T")
			last_name = pick("Tango", "Theta", "Tau", "Teal", "Turquoise")
		if("U")
			last_name = pick("Uniform", "Umbra", "Ultramarine", "Unity", "Ultima")
		if("V")
			last_name = pick("Victor", "Viridan", "Vermilion", "Violet", "Volt")
		if("W")
			last_name = pick("Whiskey", "Waw", "White", "Winter", "Wine")
		if("X")
			last_name = pick("X-ray", "Xi", "Xanadu", "Xanthic", "Ex")
		if("Y")
			last_name = pick("Yankee", "Yodh", "Yellow", "York", "Yale")
		if("Z")
			last_name = pick("Zulu", "Zeta", "Zayin", "Zed", "Zaffre")
		else
			last_name = pick("Nadazero", "Unaone", "Terrathree", "Kartefour", "Pantafive", "Soxisix", "Setteseven", "Oktoeight", "Novenine")

	var/new_name = "[first_name] [last_name]"
	new_human.change_real_name(new_human, new_name)

/datum/equipment_preset/uscm/pmc/sl
	name = "Operations Leader"
	paygrade = "PMC-OL"
	role_comm_title = "OpLead"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_SENIOR_LEAD, ACCESS_WY_ARMORY)
	assignment = JOB_PMCPLAT_LEADER
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_LEADER
	skills = /datum/skills/pmc/director

/datum/equipment_preset/uscm/pmc/tl
	name = "Team Leader"
	paygrade = "PMC-TL"
	role_comm_title = "TeamLead"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_PMC_TL)
	assignment = JOB_PMCPLAT_FTL
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_TEAM_LEADER
	skills = /datum/skills/pmc/SL

/datum/equipment_preset/uscm/pmc/sg
	name = "Heavy Weapons Specialist"
	paygrade = "PMC-WS"
	role_comm_title = "HWS"
	access = list(ACCESS_WY_GENERAL, ACCESS_PMC_GUNNER)
	assignment = JOB_PMCPLAT_SG
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_SMARTGUN
	skills = /datum/skills/smartgunner

/datum/equipment_preset/uscm/pmc/med
	name = "Medical Specialist"
	paygrade = "PMC-MS"
	role_comm_title = "MS"
	access = list(ACCESS_WY_GENERAL, ACCESS_WY_MEDICAL)
	assignment = JOB_PMCPLAT_MEDIC
	idtype = /obj/item/card/id/pmc
	rank = JOB_SQUAD_MEDIC
	skills = /datum/skills/combat_medic
