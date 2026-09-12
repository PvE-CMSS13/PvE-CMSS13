/obj/structure/sign
	icon = 'icons/obj/structures/props/decals.dmi'
	anchored = TRUE
	opacity = FALSE
	density = FALSE
	unslashable = TRUE
	layer = WALL_OBJ_LAYER

/obj/structure/sign/ex_act(severity)
	deconstruct(FALSE)
	return

/obj/structure/sign/attackby(obj/item/tool as obj, mob/user as mob) //deconstruction
	if(HAS_TRAIT(tool, TRAIT_TOOL_SCREWDRIVER) && !istype(src, /obj/structure/sign/double))
		to_chat(user, "You unfasten the sign with your [tool].")
		var/obj/item/sign/S = new(src.loc)
		S.name = name
		S.desc = desc
		S.icon_state = icon_state
		S.sign_state = icon_state
		S.icon = icon
		deconstruct(FALSE)
	else ..()

/obj/item/sign
	name = "sign"
	desc = ""
	icon = 'icons/obj/structures/props/decals.dmi'
	w_class = SIZE_MEDIUM //big
	var/sign_state = ""

/obj/item/sign/attackby(obj/item/tool as obj, mob/user as mob) //construction
	if(HAS_TRAIT(tool, TRAIT_TOOL_SCREWDRIVER) && isturf(user.loc))
		var/direction = tgui_input_list(usr, "In which direction?", "Select direction.", list("North", "East", "South", "West", "Cancel"))
		if(direction == "Cancel") return
		var/obj/structure/sign/S = new(user.loc)
		switch(direction)
			if("North")
				S.pixel_y = 32
			if("East")
				S.pixel_x = 32
			if("South")
				S.pixel_y = -32
			if("West")
				S.pixel_x = -32
			else return
		S.name = name
		S.desc = desc
		S.icon_state = sign_state
		S.icon = icon
		to_chat(user, "You fasten \the [S] with your [tool].")
		qdel(src)
	else ..()

//=====================//
// Miscellaneous Signs //
//=====================//

/obj/structure/sign/nosmoking_1
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking"

/obj/structure/sign/nosmoking_2
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking2"

/obj/structure/sign/goldenplaque
	name = "The Most Robust Men Award for Robustness"
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	icon_state = "goldenplaque"

/obj/structure/sign/kiddieplaque
	name = "AI developers plaque"
	desc = "Next to the extremely long list of names and job titles, there is a drawing of a little child. Beneath the image, someone has scratched the word \"PACKETS\""
	icon_state = "kiddieplaque"

/obj/structure/sign/arcturianstopsign
	name = "\improper Arcturian stop sign"
	desc = "This is the Arcturian stop sign that some Bravos from First Platoon stole on the last shore leave."
	icon_state = "arcturian_stop_sign"

/obj/structure/sign/double/maltesefalcon //The sign is 64x32, so it needs two tiles. ;3
	name = "The Maltese Falcon"
	desc = "The Maltese Falcon, Space Bar and Grill."

/obj/structure/sign/double/maltesefalcon/left
	icon_state = "maltesefalcon-left"

/obj/structure/sign/double/maltesefalcon/right
	icon_state = "maltesefalcon-right"

//============//
//  Banners  //
//==========//

/obj/structure/sign/banners
	icon = 'icons/obj/structures/props/banners.dmi'

/obj/structure/sign/banners/happybirthdaysteve
	name = "\improper Happy Birthday Steve banner"
	desc = "A depressing looking paper banner wishing someone named Steve a happy birth ay."
	icon_state = "birthdaysteve"

/obj/structure/sign/banners/maximumeffort
	name = "\improper Maximum Effort banner"
	desc = "This banner depicts Delta Squad's motto. The Marines of Delta Squad adopted it after picking an old bomber movie for movie night a while back."
	icon_state = "maximumeffort"

/obj/structure/sign/banners/united_americas_flag
	name = "\improper United Americas flag"
	desc = "A flag of the United Americas. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "uaflag"
/obj/structure/sign/banners/united_americas_worn
	name = "\improper United Americas flag"
	desc = "A very worn flag of the United Americas. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "uaflag_worn"
//============//
//  Flags    //
//==========//

/obj/structure/sign/flag
	icon = 'icons/obj/structures/props/flags.dmi'

/obj/structure/sign/flag/upp
	name = "\improper Union of Progressive Peoples Flag"
	desc = "Unity through Strength, Freedom through Unity"
	icon_state = "upp_flag"

/obj/structure/sign/banners/colonial_marines_flag
	name = "\improper United States Colonial Marine Corps flag"
	desc = "A flag of the United States Colonial Marine Corps. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "cmflag"
/obj/structure/sign/banners/colonial_marines_flag_worn
	name = "\improper Worn United States Colonial Marine Corps flag"
	desc = "A very worn flag of the United States Colonial Marine Corps. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "cmflag_worn"
/obj/structure/sign/banners/twe_flag
	name = "\improper Three World Empire flag"
	desc = "A flag of the Three World Empire. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "tweflag"
/obj/structure/sign/banners/twe_worn
	name = "\improper Worn Three World Empire flag"
	desc = "A very worn flag of the Three World Empire. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "tweflag_worn"
/obj/structure/sign/banners/upp_flag
	name = "\improper Union of Progressive Peoples flag"
	desc = "A flag of the Union of Progressive Peoples. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "uppflag"
/obj/structure/sign/banners/upp_worn
	name = "\improper Worn Union of Progressive Peoples flag"
	desc = "A very worn flag of the Union of Progressive Peoples. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "uppflag_worn"
/obj/structure/sign/banners/usa_flag
	name = "\improper Worn United States of America flag"
	desc = "A flag of the United States of America. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "usaflag"
/obj/structure/sign/banners/usa_worn
	name = "\improper Worn United States of America flag"
	desc = "A very worn flag of the United States of America. Inspires patriotism, fear, or revulsion depending on the viewer's political leanings."
	icon_state = "usaflag_worn"
/obj/structure/sign/banners/brazil_flag
	name = "\improper Brazil flag"
	desc = "A flag of Brazil. Inspires patriotism, fear, but not revulsion, everybody likes Brazil."
	icon_state = "brazilflag"
/obj/structure/sign/banners/brazil_worn
	name = "\improper Worn Brazil flag"
	desc = "A flag of Brazil. Inspires patriotism, fear, but not revulsion, everybody likes Brazil."
	icon_state = "brazilflag_worn"
//=====================//
// SEMIOTIC STANDARD  //
//===================//

/obj/structure/sign/safety
	name = "sign"
	icon = 'icons/obj/structures/props/semiotic_standard.dmi'
	desc = "A sign denoting Semiotic Standard. The Interstellar Commerce Commission requires that these symbols be placed pretty much everywhere for your safety."
	anchored = TRUE
	opacity = FALSE
	density = FALSE

/obj/structure/sign/safety/airlock
	name = "airlock semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an airlock."
	icon_state = "airlock"

/obj/structure/sign/safety/ammunition
	name = "ammunition storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an ammunition storage."
	icon_state = "ammo"

/obj/structure/sign/safety/analysis_lab
	name = "analysis laboratory semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an analysis laboratory."
	icon_state = "analysislab"

/obj/structure/sign/safety/autodoc
	name = "autodoc semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an autodoc."
	icon_state = "autodoc"

/obj/structure/sign/safety/autoopenclose
	name = "automatic opener/closer semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an automatic shutoff valve."
	icon_state = "autoopenclose"

/obj/structure/sign/safety/bathmens
	name = "men's bathroom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a men's bathroom."
	icon_state = "bathmens"

/obj/structure/sign/safety/bathunisex
	name = "unisex bathroom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a unisex bathroom."
	icon_state = "bathunisex"

/obj/structure/sign/safety/bathwomens
	name = "women's bathroom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a women's bathroom."
	icon_state = "bathwomens"

/obj/structure/sign/safety/biohazard
	name = "biohazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a biohazard."
	icon_state = "biohazard"

/obj/structure/sign/safety/biolab
	name = "biological laboratory semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a biological laboratory."
	icon_state = "biolab"

/obj/structure/sign/safety/bridge
	name = "bridge semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a starship's bridge."
	icon_state = "bridge"

/obj/structure/sign/safety/bulkhead_door
	name = "bulkhead door semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a bulkhead door."
	icon_state = "bulkheaddoor"

/obj/structure/sign/safety/chem_lab
	name = "chemical laboratory semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a chemical laboratory."
	icon_state = "chemlab"

/obj/structure/sign/safety/coffee
	name = "coffee semiotic"
	desc = "Semiotic Standard denoting the nearby presence of coffee: the lifeblood of any starship crew."
	icon_state = "coffee"

/obj/structure/sign/safety/commline_connection
	name = "point of connection for a communication line semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a comm line connection."
	icon_state = "commlineconnection"

/obj/structure/sign/safety/conference_room
	name = "conference room semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a conference room."
	icon_state = "confroom"

/obj/structure/sign/safety/cryo
	name = "cryogenic vault semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a cryogenics vault."
	icon_state = "cryo"

/obj/structure/sign/safety/debark_lounge
	name = "debarkation lounge semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a debarkation lounge."
	icon_state = "debarkationlounge"

/obj/structure/sign/safety/distribution_pipes
	name = "distribution pipes semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a distribution pipeline."
	icon_state = "distpipe"

/obj/structure/sign/safety/east
	name = "\improper East semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the East."
	icon_state = "east"

/obj/structure/sign/safety/electronics
	name = "astronic systems semiotic"
	desc = "Semiotic Standard denoting the nearby presence of astronic systems. That's a fancy way of saying electrical systems."
	icon_state = "astronics"

/obj/structure/sign/safety/elevator
	name = "elevator semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an elevator."
	icon_state = "elevator"

/obj/structure/sign/safety/escapepod
	name = "escape pod semiotic"
	desc = "Semiotic Standard denoting an escape pod."
	icon_state = "escapepod"

/obj/structure/sign/safety/exhaust
	name = "exhaust semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an engine or generator exhaust."
	icon_state = "exhaust"

/obj/structure/sign/safety/fire_haz
	name = "fire hazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a fire hazard."
	icon_state = "firehaz"

/obj/structure/sign/safety/firingrange
	name = "firing range semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a live ammunition firing range."
	icon_state = "firingrange"

/obj/structure/sign/safety/food_storage
	name = "organic storage (foodstuffs) semiotic"
	desc = "Semiotic Standard denoting the nearby presence of unrefrigerated food storage."
	icon_state = "foodstorage"

/obj/structure/sign/safety/galley
	name = "galley semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a galley."
	icon_state = "galley"

/obj/structure/sign/safety/hazard
	name = "hazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a hazard. Watch out!"
	icon_state = "hazard"

/obj/structure/sign/safety/high_rad
	name = "high radioactivity semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a highly radioactive area."
	icon_state = "highrad"

/obj/structure/sign/safety/high_voltage
	name = "high voltage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a high voltage electrical current."
	icon_state = "highvoltage"

/obj/structure/sign/safety/hvac
	name = "\improper HVAC semiotic"
	desc = "Semiotic Standard denoting the nearby presence of...an HVAC system. This sign must have been updated to the new standard."
	icon_state = "hvac"

/obj/structure/sign/safety/hvac_old
	name = "\improper HVAC semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an HVAC system. This sign is still using the old standard."
	icon_state = "hvacold"

/obj/structure/sign/safety/intercom
	name = "intercom semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an intercom."
	icon_state = "comm"

/obj/structure/sign/safety/ladder
	name = "ladder semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a ladder."
	icon_state = "ladder"

/obj/structure/sign/safety/laser
	name = "laser semiotic"
	desc = "Semiotic Standard denoting the nearby presence of lasers. It's usually not as cool as it sounds."
	icon_state = "laser"

/obj/structure/sign/safety/life_support
	name = "life support system semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a life support system."
	icon_state = "lifesupport"

/obj/structure/sign/safety/maint
	name = "maintenance semiotic"
	desc = "Semiotic Standard denoting the nearby presence of maintenance access."
	icon_state = "maint"

/obj/structure/sign/safety/manualopenclose
	name = "manual opener/closer semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a manual shutoff valve."
	icon_state = "manualopenclose"

/obj/structure/sign/safety/med_cryo
	name = "medical cryostasis vault semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a medical cryostasis vault."
	icon_state = "medcryo"

/obj/structure/sign/safety/med_life_support
	name = "medical life support semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a life support system for a medbay."
	icon_state = "medlifesupport"

/obj/structure/sign/safety/medical
	name = "medical semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a medbay."
	icon_state = "medical"

/obj/structure/sign/safety/nonpress
	name = "non-pressurized area beyond semiotic"
	desc = "Semiotic Standard denoting that the area beyond isn't pressurized."
	icon_state = "nonpressarea"

/obj/structure/sign/safety/nonpress_ag
	name = "artificial gravity area, non-pressurized, suit required semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an area with artificial gravity lacking in pressurization."
	icon_state = "nonpressag"

/obj/structure/sign/safety/nonpress_0g
	name = "non-pressurized area, no gravity, suit required semiotic"
	desc = "Semiotic Standard denoting that the area beyond isn't pressurized and has no artificial gravity."
	icon_state = "nonpresszerog"

/obj/structure/sign/safety/north
	name = "\improper North semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the North."
	icon_state = "north"

/obj/structure/sign/safety/opens_up
	name = "opens upwards semiotic"
	desc = "Semiotic Standard denoting the nearby door opens upwards."
	icon_state = "opensup"

/obj/structure/sign/safety/outpatient
	name = "outpatient clinic semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an outpatient clinic."
	icon_state = "outpatient"

/obj/structure/sign/safety/fibre_optics
	name = "photonics systems (fibre optics) semiotic"
	desc = "Semiotic Standard denoting the nearby presence of fibre optics lines."
	icon_state = "fibreoptic"

/obj/structure/sign/safety/press_area_ag
	name = "pressurized with artificial gravity semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a pressurized area without artificial gravity."
	icon_state = "pressareaag"

/obj/structure/sign/safety/press_area
	name = "pressurized area semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a pressurized area."
	icon_state = "pressarea"

/obj/structure/sign/safety/rad_haz
	name = "radiation hazard semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a radiation hazard."
	icon_state = "radhaz"

/obj/structure/sign/safety/rad_shield
	name = "area shielded from radiation semiotic"
	desc = "Semiotic Standard denoting the nearby presence of an area shielded from radiation."
	icon_state = "radshield"

/obj/structure/sign/safety/radio_rad
	name = "radiation of radio waves semiotic"
	desc = "Semiotic Standard denoting the nearby presence of radiation from a radio tower."
	icon_state = "radiorad"

/obj/structure/sign/safety/reception
	name = "reception semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a reception area."
	icon_state = "reception"

/obj/structure/sign/safety/reduction
	name = "reduction dilation of area semiotic"
	desc = "Semiotic Standard denoting that the area gets smaller ahead."
	icon_state = "reduction"

/obj/structure/sign/safety/ref_bio_storage
	name = "refrigerated biological storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of refrigerated biological storage."
	icon_state = "refbiostorage"

/obj/structure/sign/safety/ref_chem_storage
	name = "refrigerated chemical storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of refrigerated chemical storage."
	icon_state = "refchemstorage"

/obj/structure/sign/safety/restrictedarea
	name = "restricted area semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a restricted area."
	icon_state = "restrictedarea"

/obj/structure/sign/safety/fridge
	name = "refrigerated storage (organic foodstuffs) semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a fridge."
	icon_state = "fridge"

/obj/structure/sign/safety/refridgeration
	name = "refrigeration semiotic"
	desc = "Semiotic Standard denoting the nearby presence of non-food refrigeration."
	icon_state = "refridgeration"

/obj/structure/sign/safety/rewire
	name = "rewire system semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a rewire system."
	icon_state = "rewire"

/obj/structure/sign/safety/security
	name = "security semiotic"
	desc = "Semiotic Standard denoting the nearby presence of law enforcement or a security force."
	icon_state = "security"

/obj/structure/sign/safety/south
	name = "\improper South semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the South."
	icon_state = "south"

/obj/structure/sign/safety/stairs
	name = "stairs semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a staircase."
	icon_state = "stairs"

/obj/structure/sign/safety/storage
	name = "storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a general dry storage room."
	icon_state = "storage"

/obj/structure/sign/safety/suit_storage
	name = "pressure suit locker semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a pressure suit storage locker."
	icon_state = "suitstorage"

/obj/structure/sign/safety/synth_storage
	name = "synthetic storage semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a synthetic unit storage room."
	icon_state = "synthstorage"

/obj/structure/sign/safety/terminal
	name = "computer terminal semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a computer terminal."
	icon_state = "terminal"

/obj/structure/sign/safety/tram
	name = "tram line semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a tram line."
	icon_state = "tramline"

/obj/structure/sign/safety/twilight_zone_terminator
	name = "twilight zone terminator semiotic"
	desc = "Semiotic Standard denoting the nearby presence of a twilight zone terminator. It's way less cool than it sounds."
	icon_state = "twilightzoneterminator"

/obj/structure/sign/safety/water
	name = "water semiotic"
	desc = "Semiotic Standard denoting the nearby presence of water."
	icon_state = "water"

/obj/structure/sign/safety/waterhazard
	name = "water hazard semiotic"
	desc = "Semiotic Standard denoting a water hazard. Keep electronics away."
	icon_state = "waterhaz"

/obj/structure/sign/safety/west
	name = "\improper West semiotic"
	desc = "Semiotic Standard denoting the nearby presence of something to the West."
	icon_state = "west"

/obj/structure/sign/safety/zero_g
	name = "artificial gravity absent semiotic"
	desc = "Semiotic Standard denoting the nearby lack of artificial gravity."
	icon_state = "zerog"

/obj/structure/sign/safety/flightcontrol
	name = "\improper flight control semiotic"
	desc = "Semiotic Standard denoting an area used by or for flight control systems."
	icon_state = "flightcontrol"

/obj/structure/sign/safety/airtraffictower
	name = "\improper air traffic tower semiotic"
	desc = "Semiotic Standard denoting an air traffic tower nearby."
	icon_state = "airtraffictower"

/obj/structure/sign/safety/luggageclaim
	name = "\improper luggage claim semiotic"
	desc = "Semiotic Standard denoting the presecense of a luggage claim area nearby."
	icon_state = "luggageclaim"

/obj/structure/sign/safety/landingzone
	name = "\improper landing zone semiotic"
	desc = "Semiotic Standard denoting the presecense of a landing zone nearby."
	icon_state = "landingzone"

/obj/structure/sign/safety/zero
	name = "zero semiotic"
	desc = "Semiotic Standard denoting the number zero."
	icon_state = "0"

/obj/structure/sign/safety/one
	name = "one semiotic"
	desc = "Semiotic Standard denoting the number one."
	icon_state = "1"

/obj/structure/sign/safety/two
	name = "two semiotic"
	desc = "Semiotic Standard denoting the number two."
	icon_state = "2"

/obj/structure/sign/safety/three
	name = "three semiotic"
	desc = "Semiotic Standard denoting the number three."
	icon_state = "3"

/obj/structure/sign/safety/four
	name = "four semiotic"
	desc = "Semiotic Standard denoting the number four."
	icon_state = "4"

/obj/structure/sign/safety/five
	name = "five semiotic"
	desc = "Semiotic Standard denoting the number five."
	icon_state = "5"

/obj/structure/sign/safety/six
	name = "six semiotic"
	desc = "Semiotic Standard denoting the number six."
	icon_state = "6"

/obj/structure/sign/safety/seven
	name = "seven semiotic"
	desc = "Semiotic Standard denoting the number seven."
	icon_state = "7"

/obj/structure/sign/safety/eight
	name = "eight semiotic"
	desc = "Semiotic Standard denoting the number eight."
	icon_state = "8"

/obj/structure/sign/safety/nine
	name = "nine semiotic"
	desc = "Semiotic Standard denoting the number nine."
	icon_state = "9"

//===================//
//   Marine signs   //
//=================//

/obj/structure/sign/ROsign
	name = "\improper USCM Requisitions Office Guidelines"
	desc = " 1. You are not entitled to service or equipment. Attachments are a privilege, not a right.\n 2. You must be fully dressed to obtain service. Cryosleep underwear is non-permissible.\n 3. The Quartermaster has the final say and the right to decline service. Only the Acting Commanding Officer may override their decisions.\n 4. Please treat your Requsitions staff with respect. They work hard."
	icon_state = "roplaque"

/obj/structure/sign/ROcreed
	name = "\improper QMC Creed Plaque"
	desc = "The short version of the Quartermaster Creed made by the US Quartermaster Corps, this on is purely decorative and ceremonial version which is much shorter and doesn't include more modern edits."
	desc_lore = {"I am Quartermaster
		My story is enfolded in the history of this nation.
		Sustainer of Armies...

		My forges burned at Valley Forge.
		Down frozen, rutted roads my oxen hauled
		the meager foods a bankrupt Congress sent me...
		Scant rations for the cold and starving troops,
		Gunpowder, salt, and lead.

		In 1812 we sailed to war in ships my boatwrights built.
		I fought beside you in the deserts of our great Southwest.
		My pack mules perished seeking water holes,
		And I went on with camels.
		I gave flags to serve.
		The medals and crest you wear are my design.

		Since 1862, I have sought our fallen brothers
		from Private to President.
		In war or peace I bring them home
		And lay them gently down in fields of honor.

		Provisioner, transporter.
		In 1898 I took you to Havana Harbor and the Philippines.
		I brought you tents, your khaki cloth for uniforms.
		When yellow fever struck, I brought the mattresses you lay upon.

		In 1917, we crossed the ocean to fight in the trenches and fields of France,
		New weapons, training, technologies, and tactics for the Great War.
		But always the need for food, water, ammunition, and now fuel.

		We shed first blood together at Pearl Harbor and Corregidor.
		Then begin the long march to Victory - Guadalcanal and North Africa, Sicily and the Solomons.
		I was there with you at Omaha Beach on D-Day and even the night before from Glider and Parachute.
		Across Europe and the Pacific, I drove and dug and fought till the job was done.

		When war came to the Peninsula in 1950, it was my 'chutes that filled the grey Korean skies.
		From the perimeter at Pusan to the cold roads of the Chosin, I was there.
		In 1965, I established the fire bases and depots across South Vietnam,
		The Hueys and Chinooks carried my supplies forward.

		I AM QUARTERMASTER.
		I can shape the course of combat,
		Change the outcome of battle.
		Look to me: Sustainer of Armies...Since 1775.

		I AM QUARTERMASTER. I AM PROUD."}
	icon_state = "rocreed"

/obj/structure/sign/prop1
	name = "\improper USCM Poster"
	desc = "The symbol of the United States Colonial Marines corps."
	icon_state = "prop1"

/obj/structure/sign/prop2
	name = "\improper USCM Poster"
	desc = "A deeply faded poster of a group of glamorous Colonial Marines in uniform. Probably taken pre-Alpha."
	icon_state = "prop2"

/obj/structure/sign/prop3
	name = "\improper USCM Poster"
	desc = "An old recruitment poster for the USCM. Looking at it floods you with a mixture of pride and sincere regret."
	icon_state = "prop3"


/obj/structure/sign/catclock
	name = "cat clock"
	desc = "An unbelievably creepy cat clock that surveys the room with every tick and every tock."
	icon = 'icons/obj/structures/props/catclock.dmi'
	icon_state = "cat_clock_motion"

//torch

/obj/structure/sign/double/map
	name = "map"
	desc = "A framed map."


/obj/structure/sign/double/map/left
	icon_state = "map-left"

/obj/structure/sign/double/map/right
	icon_state = "map-right"

/obj/structure/sign/monkey_painting
	name = "\improper Mr. Deempisi portrait"
	desc = "Under the painting a plaque reads: 'While the meat grinder may not have spared you, fear not. Not one part of you has gone to waste... You were delicious.'"
	icon_state = "monkey_painting"

/obj/structure/sign/warning
	name = "\improper WARNING"
	icon_state = "securearea"

/obj/structure/sign/warning/detailed
	icon_state = "securearea2"

/obj/structure/sign/warning/New()
	..()
	desc = "A warning sign which reads '[sanitize(name)]'."

/obj/structure/sign/thera
	icon_state = "thera"
	name = "\improper THERA SAFE ROOM"
	desc = "A detailed sign that reads 'Temporary Housing for Emergency, Radioactive, Atmospheric. This location is unsuitable for extended Habitation. Do not shelter here beyond immediate need.'"

/obj/structure/sign/warning/airlock
	name = "\improper EXTERNAL AIRLOCK"
	icon_state = "doors"

/obj/structure/sign/warning/biohazard
	name = "\improper BIOHAZARD"
	icon_state = "bio"

/obj/structure/sign/warning/bomb_range
	name = "\improper BOMB RANGE"
	icon_state = "blast"

/obj/structure/sign/warning/caution
	name = "\improper CAUTION"

/obj/structure/sign/warning/toxic_material
	name = "\improper TOXIC MATERIAL"
	icon_state = "toxic_material"

/obj/structure/sign/warning/compressed_gas
	name = "\improper COMPRESSED GAS"
	icon_state = "hikpa"

/obj/structure/sign/warning/deathsposal
	name = "\improper DISPOSAL LEADS TO SPACE"
	icon_state = "deathsposal"

/obj/structure/sign/warning/docking_area
	name = "\improper KEEP CLEAR: DOCKING AREA"

/obj/structure/sign/warning/engineering_access
	name = "\improper ENGINEERING ACCESS"

/obj/structure/sign/warning/fall
	name = "\improper FALL HAZARD"
	icon_state = "falling"

/obj/structure/sign/warning/fire
	name = "\improper DANGER: FIRE"
	icon_state = "fire"

/obj/structure/sign/warning/high_voltage
	name = "\improper HIGH VOLTAGE"
	icon_state = "shock"

/obj/structure/sign/warning/hot_exhaust
	name = "\improper HOT EXHAUST"
	icon_state = "fire"

/obj/structure/sign/warning/internals_required
	name = "\improper INTERNALS REQUIRED"

/obj/structure/sign/warning/lethal_turrets
	name = "\improper LETHAL TURRETS"
	icon_state = "turrets"

/obj/structure/sign/warning/lethal_turrets/New()
	..()
	desc += " Enter at own risk!"

/obj/structure/sign/warning/mail_delivery
	name = "\improper MAIL DELIVERY"
	icon_state = "mail"

/obj/structure/sign/warning/moving_parts
	name = "\improper MOVING PARTS"
	icon_state = "movingparts"

/obj/structure/sign/warning/nosmoking_1
	name = "\improper NO SMOKING"
	icon_state = "nosmoking"

/obj/structure/sign/warning/nosmoking_2
	name = "\improper NO SMOKING"
	icon_state = "nosmoking2"

/obj/structure/sign/warning/nosmoking_burned
	name = "\improper NO SMOKING"
	icon_state = "nosmoking2_b"

/obj/structure/sign/warning/nosmoking_burned/Initialize()
	. = ..()
	desc += " It looks charred."

/obj/structure/sign/warning/smoking
	name = "\improper SMOKING"
	icon_state = "smoking"

/obj/structure/sign/warning/smoking/Initialize()
	. = ..()
	desc += " Hell yeah."

/obj/structure/sign/warning/pods
	name = "\improper ESCAPE PODS"
	icon_state = "podsnorth"

/obj/structure/sign/warning/pods/south
	name = "\improper ESCAPE PODS"
	icon_state = "podssouth"

/obj/structure/sign/warning/pods/east
	name = "\improper ESCAPE PODS"
	icon_state = "podseast"

/obj/structure/sign/warning/pods/west
	name = "\improper ESCAPE PODS"
	icon_state = "podswest"

/obj/structure/sign/warning/radioactive
	name = "\improper RADIOACTIVE AREA"
	icon_state = "radiation"

/obj/structure/sign/warning/secure_area
	name = "\improper SECURE AREA"

/obj/structure/sign/warning/secure_area/armory
	name = "\improper ARMORY"
	icon_state = "armory"

/obj/structure/sign/warning/server_room
	name = "\improper SERVER ROOM"
	icon_state = "server"

/obj/structure/sign/warning/siphon_valve
	name = "\improper SIPHON VALVE"

/obj/structure/sign/warning/vacuum
	name = "\improper HARD VACUUM AHEAD"
	icon_state = "space"

/obj/structure/sign/warning/vent_port
	name = "\improper EJECTION/VENTING PORT"

/obj/structure/sign/redcross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "redcross"

/obj/structure/sign/greencross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "greencross"

/obj/structure/sign/bluecross_1
	name = "infirmary"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "bluecross"

/obj/structure/sign/bluecross_2
	name = "infirmary"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "bluecross2"

/obj/structure/sign/goldenplaque
	name = "The Most Robust Men Award for Robustness"
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	icon_state = "goldenplaque"

/obj/structure/sign/goldenplaque/security
	name = "motivational plaque"
	desc = "A plaque engraved with a generic motivational quote and picture. ' Greater love hath no man than this, that a man lay down his life for his friends. John 15:13 "

/obj/structure/sign/goldenplaque/medical
	name = "medical certificate"
	desc = "A picture next to a long winded description of medical certifications and degrees."

/obj/structure/sign/kiddieplaque
	name = "\improper AI developers plaque"
	desc = "An extremely long list of names and job titles and a picture of the design team responsible for building this AI Core."
	icon_state = "kiddieplaque"

/obj/structure/sign/atmosplaque
	name = "\improper engineering memorial plaque"
	desc = "This plaque memorializes those engineers and technicians who made the ultimate sacrifice to save their vessel and its crew."
	icon_state = "atmosplaque"

/obj/structure/sign/emergonly
	name = "\improper EMERGENCY ONLY"
	desc = "A warning sign which reads 'EMERGENCY ONLY!'."
	icon_state = "emerg"

/obj/structure/sign/noidle
	name = "\improper NO IDLING"
	desc = "A warning sign which reads 'NO IDLING!'."
	icon_state = "noidle"

/obj/structure/sign/double/maltesefalcon	//The sign is 64x32, so it needs two tiles. ;3
	name = "The Maltese Falcon"
	desc = "The Maltese Falcon, Space Bar and Grill."

/obj/structure/sign/double/maltesefalcon/left
	icon_state = "maltesefalcon-left"

/obj/structure/sign/double/maltesefalcon/right
	icon_state = "maltesefalcon-right"

/obj/structure/sign/warning/science
	name = "\improper SCIENCE!"
	icon_state = "science"

/obj/structure/sign/warning/science/anomalous_materials
	name = "\improper ANOMALOUS MATERIALS"

/obj/structure/sign/warning/science/mass_spectrometry
	name = "\improper MASS SPECTROMETRY"

/obj/structure/sign/science_1
	name = "\improper RESEARCH WING"
	desc = "A sign labelling the research wing."
	icon_state = "science"

/obj/structure/sign/science_2
	name = "\improper RESEARCH"
	desc = "A sign labelling an area where research is performed."
	icon_state = "science2"

/obj/structure/sign/xenobio_1
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon_state = "xenobio"

/obj/structure/sign/xenobio_2
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon_state = "xenobio2"

/obj/structure/sign/xenobio_3
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon_state = "xenobio3"

/obj/structure/sign/xenobio_4
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon_state = "xenobio4"

/obj/structure/sign/xenoarch
	name = "\improper XENOARCHAEOLOGY"
	desc = "A sign labelling an area as a place where xenoarchaeological finds are researched."
	icon_state = "xenobio4"

/obj/structure/sign/chemistry
	name = "\improper CHEMISTRY"
	desc = "A sign labelling an area containing chemical equipment."
	icon_state = "chemistry"

/obj/structure/sign/xenoflora
	name = "\improper XENOFLORA"
	desc = "A sign labelling an area as a place where xenobiological plants are researched."
	icon_state = "hydro4"

/obj/structure/sign/botany
	name = "\improper BOTANY"
	desc = "A warning sign which reads 'BOTANY!'."
	icon_state = "hydro3"

/obj/structure/sign/hydro
	name = "\improper HYDROPONICS"
	desc = "A sign labelling an area as a place where plants are grown."
	icon_state = "hydro"

/obj/structure/sign/hydrostorage
	name = "\improper HYDROPONICS STORAGE"
	desc = "A sign labelling an area as a place where plant growing supplies are kept."
	icon_state = "hydro3"

/obj/structure/sign/directions
	name = "direction sign"
	desc = "A direction sign, claiming to know the way."
	icon_state = "direction"

/obj/structure/sign/directions/New()
	..()
	desc = "A direction sign, pointing out which way \the [src] is."

/obj/structure/sign/directions/science
	name = "\improper Research Division"
	icon_state = "direction_sci"

/obj/structure/sign/directions/janitor
	name = "\improper Custodial Closet"
	icon_state = "direction_jan"

/obj/structure/sign/directions/engineering
	name = "\improper Engineering Bay"
	icon_state = "direction_eng"

/obj/structure/sign/directions/security
	name = "\improper Security Wing"
	icon_state = "direction_sec"

/obj/structure/sign/directions/medical
	name = "\improper Medical Bay"
	icon_state = "direction_med"

/obj/structure/sign/directions/evac
	name = "\improper Evacuation Wing"
	icon_state = "direction_evac"

/obj/structure/sign/directions/bridge
	name = "\improper Bridge"
	icon_state = "direction_bridge"

/obj/structure/sign/directions/supply
	name = "\improper Supply Office"
	icon_state = "direction_supply"

/obj/structure/sign/directions/infirmary
	name = "\improper Infirmary"
	icon_state = "direction_infirm"

/obj/structure/sign/directions/examroom
	name = "\improper Exam Room"
	icon_state = "examroom"

/obj/structure/sign/directions/infm
	name = "\improper Infirmary"
	icon_state = "infm"

/obj/structure/sign/directions/med
	name = "\improper Medbay"
	icon_state = "med"

/obj/structure/sign/deck/bridge
	name = "\improper Bridge Deck"
	icon_state = "deck-b"

/obj/structure/sign/deck/first
	name = "\improper First Deck"
	icon_state = "deck-1"

/obj/structure/sign/deck/second
	name = "\improper Second Deck"
	icon_state = "deck-2"

/obj/structure/sign/deck/third
	name = "\improper Third Deck"
	icon_state = "deck-3"

/obj/structure/sign/deck/fourth
	name = "\improper Fourth Deck"
	icon_state = "deck-4"

/obj/structure/sign/deck/fifth
	name = "\improper Fifth Deck"
	icon_state = "deck-5"
