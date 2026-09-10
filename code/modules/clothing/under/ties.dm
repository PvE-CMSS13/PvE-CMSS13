/obj/item/clothing/accessory
	name = "tie"
	desc = "A neosilk clip-on tie."
	icon = 'icons/obj/items/clothing/ties.dmi'
	icon_state = "bluetie"
	w_class = SIZE_SMALL
	var/image/inv_overlay = null //overlay used when attached to clothing.
	var/obj/item/clothing/has_suit = null //the suit the tie may be attached to
	var/slot = ACCESSORY_SLOT_DECOR
	var/list/mob_overlay = list()
	var/overlay_state = null
	var/list/accessory_icons = list(WEAR_BODY = 'icons/mob/humans/onmob/ties.dmi', WEAR_JACKET = 'icons/mob/humans/onmob/ties.dmi')
	///Jumpsuit flags that cause the accessory to be hidden. format: "x" OR "(x|y|z)" (w/o quote marks).
	var/jumpsuit_hide_states
	var/high_visibility //if it should appear on examine without detailed view
	var/removable = TRUE
	flags_equip_slot = SLOT_ACCESSORY
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/ties_monkey.dmi')

/obj/item/clothing/accessory/Initialize()
	. = ..()
	inv_overlay = image("icon" = 'icons/obj/items/clothing/ties_overlay.dmi', "icon_state" = "[item_state? "[item_state]" : "[icon_state]"]")
	flags_atom |= USES_HEARING

/obj/item/clothing/accessory/Destroy()
	if(has_suit)
		has_suit.remove_accessory()
	inv_overlay = null
	. = ..()

/obj/item/clothing/accessory/proc/can_attach_to(mob/user, obj/item/clothing/C)
	return TRUE

//when user attached an accessory to S
/obj/item/clothing/accessory/proc/on_attached(obj/item/clothing/S, mob/living/user, silent)
	if(!istype(S))
		return
	has_suit = S
	forceMove(has_suit)
	has_suit.overlays += get_inv_overlay()

	if(user)
		if(!silent)
			to_chat(user, SPAN_NOTICE("You attach \the [src] to \the [has_suit]."))
		src.add_fingerprint(user)
	return TRUE

/obj/item/clothing/accessory/proc/on_removed(mob/living/user, obj/item/clothing/C)
	if(!has_suit)
		return
	has_suit.overlays -= get_inv_overlay()
	has_suit = null
	if(usr)
		usr.put_in_hands(src)
		src.add_fingerprint(usr)
	else
		src.forceMove(get_turf(src))
	return TRUE

//default attackby behaviour
/obj/item/clothing/accessory/attackby(obj/item/I, mob/user)
	..()

//default attack_hand behaviour
/obj/item/clothing/accessory/attack_hand(mob/user as mob)
	if(has_suit)
		return //we aren't an object on the ground so don't call parent. If overriding to give special functions to a host item, return TRUE so that the host doesn't continue its own attack_hand.
	..()

///Extra text to append when attached to another clothing item and the host clothing is examined.
/obj/item/clothing/accessory/proc/additional_examine_text()
	return "attached to it."

/obj/item/clothing/accessory/blue
	name = "blue tie"
	icon_state = "bluetie"

/obj/item/clothing/accessory/red
	name = "red tie"
	icon_state = "redtie"

/obj/item/clothing/accessory/green
	name = "green tie"
	icon_state = "greentie"

/obj/item/clothing/accessory/black
	name = "black tie"
	icon_state = "blacktie"

/obj/item/clothing/accessory/gold
	name = "gold tie"
	icon_state = "goldtie"

/obj/item/clothing/accessory/purple
	name = "purple tie"
	icon_state = "purpletie"

/obj/item/clothing/accessory/horrible
	name = "horrible tie"
	desc = "A neosilk clip-on tie. This one is disgusting."
	icon_state = "horribletie"

/obj/item/clothing/accessory/stethoscope
	name = "stethoscope"
	desc = "An outdated, but still useful, medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"

/obj/item/clothing/accessory/stethoscope/attack(mob/living/carbon/human/being, mob/living/user)
	if(!ishuman(being) || !isliving(user))
		return

	var/body_part = parse_zone(user.zone_selected)
	if(!body_part)
		return

	var/sound = null
	if(being.stat == DEAD || (being.status_flags & FAKEDEATH))
		sound = "can't hear anything at all, they must have kicked the bucket"
		user.visible_message("[user] places [src] against [being]'s [body_part] and listens attentively.", "You place [src] against [being.p_their()] [body_part] and... you [sound].")
		return

	switch(body_part)
		if("chest")
			if(skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC)) // only medical personnel can take advantage of it
				if(!ishuman(being))
					return // not a human; only humans have the variable internal_organs_by_name // "cast" it a human type since we confirmed it is one
				if(isnull(being.internal_organs_by_name))
					return // they have no organs somehow
				var/datum/internal_organ/heart/heart = being.internal_organs_by_name["heart"]
				if(heart)
					switch(heart.organ_status)
						if(ORGAN_LITTLE_BRUISED)
							sound = "hear <font color='yellow'>small murmurs with each heart beat</font>, it is possible that [being.p_their()] heart is <font color='yellow'>subtly damaged</font>"
						if(ORGAN_BRUISED)
							sound = "hear <font color='orange'>deviant heart beating patterns</font>, result of probable <font color='orange'>heart damage</font>"
						if(ORGAN_BROKEN)
							sound = "hear <font color='red'>irregular and additional heart beating patterns</font>, probably caused by impaired blood pumping, [being.p_their()] heart is certainly <font color='red'>failing</font>"
						else
							sound = "hear <font color='green'>normal heart beating patterns</font>, [being.p_their()] heart is surely <font color='green'>healthy</font>"
				var/datum/internal_organ/lungs/lungs = being.internal_organs_by_name["lungs"]
				if(lungs)
					if(sound)
						sound += ". You also "
					switch(lungs.organ_status)
						if(ORGAN_LITTLE_BRUISED)
							sound += "hear <font color='yellow'>some crackles when [being.p_they()] breath</font>, [being.p_they()] is possibly suffering from <font color='yellow'>a small damage to the lungs</font>"
						if(ORGAN_BRUISED)
							sound += "hear <font color='orange'>unusual respiration sounds</font> and noticeable difficulty to breath, possibly signalling <font color='orange'>ruptured lungs</font>"
						if(ORGAN_BROKEN)
							sound += "<font color='red'>barely hear any respiration sounds</font> and a lot of difficulty to breath, [being.p_their()] lungs are <font color='red'>heavily failing</font>"
						else
							sound += "hear <font color='green'>normal respiration sounds</font> aswell, that means [being.p_their()] lungs are <font color='green'>healthy</font>, probably"
				else
					sound = "can't hear. Really, anything at all, how weird"
			else
				sound = "hear a lot of sounds... it's quite hard to distinguish, really"
		if("eyes","mouth")
			sound = "can't hear anything. Maybe that isn't the smartest idea"
		else
			sound = "hear a sound here and there, but none of them give you any good information"
	user.visible_message("[user] places [src] against [being]'s [body_part] and listens attentively.", "You place [src] against [being.p_their()] [body_part] and... you [sound].")

//Medals
/obj/item/clothing/accessory/medal
	name = "medal"
	desc = "A medal."
	icon_state = "bronze"
	var/recipient_name //name of the person this is awarded to.
	var/recipient_rank
	var/medal_citation
	slot = ACCESSORY_SLOT_MEDAL
	high_visibility = TRUE
	jumpsuit_hide_states = UNIFORM_JACKET_REMOVED

/obj/item/clothing/accessory/medal/on_attached(obj/item/clothing/S, mob/living/user, silent)
	. = ..()
	if(.)
		RegisterSignal(S, COMSIG_ITEM_EQUIPPED, PROC_REF(remove_medal))

/obj/item/clothing/accessory/medal/proc/remove_medal(obj/item/clothing/C, mob/user, slot)
	SIGNAL_HANDLER
	if(user.real_name != recipient_name && (slot == WEAR_BODY || slot == WEAR_JACKET))
		C.remove_accessory(user, src)
		user.drop_held_item(src)

/obj/item/clothing/accessory/medal/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	if(.)
		UnregisterSignal(C, COMSIG_ITEM_EQUIPPED)

/obj/item/clothing/accessory/medal/attack(mob/living/carbon/human/H, mob/living/carbon/human/user)
	if(!(istype(H) && istype(user)))
		return ..()
	if(recipient_name != H.real_name)
		to_chat(user, SPAN_WARNING("[src] wasn't awarded to [H]."))
		return

	var/obj/item/clothing/U
	if(H.wear_suit && H.wear_suit.can_attach_accessory(src)) //Prioritises topmost garment, IE service jackets, if possible.
		U = H.wear_suit
	else
		U = H.w_uniform //Will be null if no uniform. That this allows medal ceremonies in which the hero is wearing no pants is correct and just.
	if(!U)
		if(user == H)
			to_chat(user, SPAN_WARNING("You aren't wearing anything you can pin [src] to."))
		else
			to_chat(user, SPAN_WARNING("[H] isn't wearing anything you can pin [src] to."))
		return

	if(user == H)
		user.visible_message(SPAN_NOTICE("[user] pins [src] to \his [U.name]."),
		SPAN_NOTICE("You pin [src] to your [U.name]."))

	else
		if(user.action_busy)
			return
		if(user.a_intent != INTENT_HARM)
			user.affected_message(H,
			SPAN_NOTICE("You start to pin [src] onto [H]."),
			SPAN_NOTICE("[user] starts to pin [src] onto you."),
			SPAN_NOTICE("[user] starts to pin [src] onto [H]."))
			if(!do_after(user, 20, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, H))
				return
			if(!(U == H.w_uniform || U == H.wear_suit))
				to_chat(user, SPAN_WARNING("[H] took off \his [U.name] before you could finish pinning [src] to it."))
				return
			user.affected_message(H,
			SPAN_NOTICE("You pin [src] to [H]'s [U.name]."),
			SPAN_NOTICE("[user] pins [src] to your [U.name]."),
			SPAN_NOTICE("[user] pins [src] to [H]'s [U.name]."))

		else
			user.affected_message(H,
			SPAN_ALERT("You start to pin [src] to [H]."),
			SPAN_ALERT("[user] starts to pin [src] to you."),
			SPAN_ALERT("[user] starts to pin [src] to [H]."))
			if(!do_after(user, 10, INTERRUPT_ALL, BUSY_ICON_HOSTILE, H))
				return
			if(!(U == H.w_uniform || U == H.wear_suit))
				to_chat(user, SPAN_WARNING("[H] took off \his [U.name] before you could finish pinning [src] to \him."))
				return
			user.affected_message(H,
			SPAN_DANGER("You slam the [src.name]'s pin through [H]'s [U.name] and into \his chest."),
			SPAN_DANGER("[user] slams the [src.name]'s pin through your [U.name] and into your chest!"),
			SPAN_DANGER("[user] slams the [src.name]'s pin through [H]'s [U.name] and into \his chest."))

			/*Some duplication from punch code due to attack message and damage stats.
			This does cut damage and awarding multiple medals like this to the same person will cause bleeding.*/
			H.last_damage_data = create_cause_data("macho bullshit", user)
			user.animation_attack_on(H)
			user.flick_attack_overlay(H, "punch")
			playsound(user.loc, "punch", 25, 1)
			H.apply_damage(5, BRUTE, "chest", 1)

			if(!H.stat && H.pain.feels_pain)
				if(prob(35))
					INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, emote), "pain")
				else
					INVOKE_ASYNC(H, TYPE_PROC_REF(/mob, emote), "me", 1, "winces.")

	if(U.can_attach_accessory(src) && user.drop_held_item())
		U.attach_accessory(H, src, TRUE)

/obj/item/clothing/accessory/medal/can_attach_to(mob/user, obj/item/clothing/C)
	if(user.real_name != recipient_name)
		return FALSE
	return TRUE

/obj/item/clothing/accessory/medal/get_examine_text(mob/user)
	. = ..()

	var/citation_to_read = ""
	if(medal_citation)
		citation_to_read = "The citation reads \'[medal_citation]\'."

	. += "Awarded to: \'[recipient_rank] [recipient_name]\'. [citation_to_read]"

/obj/item/clothing/accessory/medal/bronze
	name = "bronze medal"
	desc = "A bronze medal."

/obj/item/clothing/accessory/medal/bronze/conduct
	name = MARINE_CONDUCT_MEDAL
	desc = "A bronze medal awarded for distinguished conduct. Whilst a great honor, this is the most basic award given by the USCM"
	icon_state = "bronze_b"

/obj/item/clothing/accessory/medal/bronze/heart
	name = MARINE_BRONZE_HEART_MEDAL
	desc = "A bronze heart-shaped medal awarded for sacrifice. It is often awarded posthumously or for severe injury in the line of duty."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/bronze/science
	name = "nobel sciences award"
	desc = "A bronze medal which represents significant contributions to the field of science or engineering."

/obj/item/clothing/accessory/medal/silver
	name = "silver medal"
	desc = "A silver medal."
	icon_state = "silver_b"

/obj/item/clothing/accessory/medal/silver/valor
	name = MARINE_VALOR_MEDAL
	desc = "A silver medal awarded for acts of exceptional valor."

/obj/item/clothing/accessory/medal/silver/security
	name = "robust security award"
	desc = "An award for distinguished combat and sacrifice in defence of Wey-Yu's commercial interests. Often awarded to security staff."

/obj/item/clothing/accessory/medal/gold
	name = "gold medal"
	desc = "A prestigious golden medal."
	icon_state = "gold_b"

/obj/item/clothing/accessory/medal/gold/captain
	name = "medal of captaincy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of captain. It signifies the codified responsibilities of a captain to Wey-Yu, and their undisputable authority over their crew."

/obj/item/clothing/accessory/medal/gold/heroism
	name = MARINE_HEROISM_MEDAL
	desc = "An extremely rare golden medal awarded only by the USCM. To receive such a medal is the highest honor and as such, very few exist."

/obj/item/clothing/accessory/medal/platinum
	name = "platinum medal"
	desc = "A very prestigious platinum medal, only able to be handed out by generals due to special circumstances."
	icon_state = "platinum_b"

/obj/item/clothing/accessory/medal/bronze/service
	name = "bronze service medal"
	desc = "A bronze medal awarded for a marine's service within the USCM. It is a very common medal, and is typically the first medal a marine would receive."
	icon_state = "bronze"

/obj/item/clothing/accessory/medal/silver/service
	name = "silver service medal"
	desc = "A shiny silver medal awarded for a marine's service within the USCM. It is a somewhat common medal which signifies the amount of time a marine has spent in the line of duty."
	icon_state = "silver"
/obj/item/clothing/accessory/medal/gold/service
	name = "gold service medal"
	desc = "A prestigious gold medal awarded for a marine's service within the USCM. It is a rare medal which signifies the amount of time a marine has spent in the line of duty."
	icon_state = "gold"
/obj/item/clothing/accessory/medal/platinum/service
	name = "platinum service medal"
	desc = "The highest service medal that can be awarded to a marine; such medals are hand-given by USCM Generals to a marine. It signifies the sheer amount of time a marine has spent in the line of duty."
	icon_state = "platinum"

//Armbands
/obj/item/clothing/accessory/armband
	name = "red armband"
	desc = "A fancy red armband!"
	icon_state = "red"
	slot = ACCESSORY_SLOT_ARMBAND
	jumpsuit_hide_states = (UNIFORM_SLEEVE_CUT|UNIFORM_JACKET_REMOVED)

/obj/item/clothing/accessory/armband/cargo
	name = "cargo armband"
	desc = "An armband, worn by the crew to display which department they're assigned to. This one is brown."
	icon_state = "cargo"

/obj/item/clothing/accessory/armband/engine
	name = "engineering armband"
	desc = "An armband, worn by the crew to display which department they're assigned to. This one is orange with a reflective strip!"
	icon_state = "engie"

/obj/item/clothing/accessory/armband/science
	name = "science armband"
	desc = "An armband, worn by the crew to display which department they're assigned to. This one is purple."
	icon_state = "rnd"

/obj/item/clothing/accessory/armband/hydro
	name = "hydroponics armband"
	desc = "An armband, worn by the crew to display which department they're assigned to. This one is green and blue."
	icon_state = "hydro"

/obj/item/clothing/accessory/armband/med
	name = "medical armband"
	desc = "An armband, worn by the crew to display which department they're assigned to. This one is white."
	icon_state = "med"

/obj/item/clothing/accessory/armband/medgreen
	name = "EMT armband"
	desc = "An armband, worn by the crew to display which department they're assigned to. This one is white and green."
	icon_state = "medgreen"

/obj/item/clothing/accessory/armband/nurse
	name = "nurse armband"
	desc = "An armband, worn by the rookie nurses to display they are still not doctors. This one is dark red."
	icon_state = "nurse"

/obj/item/clothing/accessory/armband/mpsec
	name = "military police armband"
	desc = "An armband used by military police officers to denote their position."
	icon_state = "armband_mp"
	slot = ACCESSORY_SLOT_ARMBAND
	jumpsuit_hide_states = (UNIFORM_SLEEVE_CUT|UNIFORM_JACKET_REMOVED)

//patches
/obj/item/clothing/accessory/patch
	name = "USCM patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the United States Colonial Marines."
	icon_state = "uscmpatch"
	jumpsuit_hide_states = (UNIFORM_SLEEVE_CUT|UNIFORM_JACKET_REMOVED)

/obj/item/clothing/accessory/patch/falcon
	name = "USCM Falling Falcons patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the Falling Falcons, the 2nd battalion of the 4th brigade of the USCM."
	icon_state = "fallingfalconspatch"

/obj/item/clothing/accessory/patch/devils
	name = "USCM Solar Devils patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the 3rd Battalion 'Solar Devils', part of the USCM 2nd Division, 1st Regiment."
	icon_state = "solardevilspatch"

/obj/item/clothing/accessory/patch/forecon
	name = "USCM Force Reconnaissance patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of USCM FORECON. Swift, Silent, Deadly."
	icon_state = "forecon_patch"

/obj/item/clothing/accessory/patch/sapper
	name = "USCM Combat Engineering patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the 4th Combat Engineering Battalion, part of the USCM 2nd Colonial Support Group."
	icon_state = "sapper_patch"

/obj/item/clothing/accessory/patch/royal_marines
	name = "TWE Royal Marines Commando patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the Royal Marines Commando."
	icon_state = "rmcpatch"

/obj/item/clothing/accessory/patch/twe
	name = "Three World Empire patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women loyal to the Three World Empire, An older style symbol of the TWE."
	icon_state = "twepatch"

/obj/item/clothing/accessory/patch/upp
	name = "UPP patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the Union of Progressive Peoples Armed Collective."
	icon_state = "upppatch"

/obj/item/clothing/accessory/patch/upp/airborne
	name = "UPP Airborne Reconnaissance patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the 173rd Airborne Reconnaissance Platoon."
	icon_state = "vdvpatch"

/obj/item/clothing/accessory/patch/upp/naval
	name = "UPP Naval Infantry patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the UPP Naval Infantry."
	icon_state = "navalpatch"

/obj/item/clothing/accessory/patch/usasf
	name = "USASF patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the United States Aerospace Force."
	icon_state = "usasfpatch"

/obj/item/clothing/accessory/patch/usasf/helljumper
	name = "Para-Rescue patch"
	desc = "A fire-resistant shoulder patch, worn by the absolute badasses of the USASF 7th Para-Rescue Battalion. Feet first into hell!"
	icon_state = "helljumperpatch"

/obj/item/clothing/accessory/patch/army
	name = "US Army patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the United States Army."
	icon_state = "armypatch"

/obj/item/clothing/accessory/patch/army/infantry
	name = "Army Infantry patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the 1st Cavalry Division."
	icon_state = "infantrypatch"

/obj/item/clothing/accessory/patch/army/spook
	name = "Army Intelligence patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the 525th Army Intelligence Brigade."
	icon_state = "spookpatch"

/obj/item/clothing/accessory/patch/army/armor
	name = "Army Armor patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the 32nd Armor Brigade."
	icon_state = "armorpatch"

/obj/item/clothing/accessory/patch/cmb/brazil_police
	name = "Brazilian Colonial Military Police patch"
	desc = "A fire-resistant shoulder patch, worn by the men and women of the Brazilian Military Police."
	icon_state = "brazilpolicepatch"
//W-Y patches
/obj/item/clothing/accessory/patch/wy
	name = "Weyland-Yutani patch"
	desc = "A fire-resistant black shoulder patch featuring the Weyland-Yutani logo. A symbol of loyalty to the corporation, or perhaps ironic mockery, depending on your viewpoint."
	icon_state = "wypatch"

/obj/item/clothing/accessory/patch/wysquare
	name = "Weyland-Yutani Square patch"
	desc = "A fire-resistant black shoulder patch featuring the Weyland-Yutani logo. A symbol of loyalty to the corporation, or perhaps ironic mockery, depending on your viewpoint."
	icon_state = "wysquare"

/obj/item/clothing/accessory/patch/wy_faction
	name = "Weyland-Yutani Faction patch" // For WY factions like PMC's - on the right shoulder rather then left.
	desc = "A fire-resistant black shoulder patch featuring the Weyland-Yutani logo. A symbol of loyalty to the corporation."
	icon_state = "wypatch_faction"

/obj/item/clothing/accessory/patch/wy_white
	name = "Weyland-Yutani White patch"
	desc = "A fire-resistant white shoulder patch featuring the Weyland-Yutani logo. A symbol of loyalty to the corporation, or perhaps ironic mockery, depending on your viewpoint."
	icon_state = "wypatch_white"

/obj/item/clothing/accessory/patch/wyfury
	name = "Weyland-Yutani Fury '161' patch"
	desc = "A fire-resistant shoulder patch. Was worn by workers and then later prisoners on the Fiorina 'Fury' 161 facility, a rare relic, after the facility went dark in 2179."
	icon_state = "fury161patch"
//Merc patchs
/obj/item/clothing/accessory/patch/freelancer_patch
	name = "Freelancer's Guild patch"
	desc = "A fire-resistant circular patch featuring a white skull on a vertically split black and blue background. Worn by a skilled mercenary of the Freelancers, a well-equipped group for hire across the outer colonies, known for their professionalism and neutrality. This patch is a personal memento from the wearer’s time with the group, representing a life spent navigating the dangerous world of mercenary contracts."
	icon_state = "mercpatch"
	item_state_slots = list(WEAR_AS_GARB = "mercpatch")

/obj/item/clothing/accessory/patch/merc_patch
	name = "Old Freelancer's Guild patch"
	desc = "A faded old, worn fire-resistant circular patch featuring a white skull on a vertically split black and red background. Worn by a well-equipped mercenary group for hire across the outer colonies, known for their professionalism and neutrality. The current owner’s connection to the patch is unclear—whether it was once earned as part of service, kept as a memento, or simply found, disconnected from its original wearer."
	icon_state = "mercpatch_red"
	item_state_slots = list(WEAR_AS_GARB = "mercpatch_red")
//msf patch
/obj/item/clothing/accessory/patch/msf_patch
	name = "Marine Space Force Herculis patch"
	desc = "A fire-resistant shoulder patch, depicting the logo of Marine Space Force III, Herculis, deployed throughout the Anglo-Japanese arm from the outer veil to the ICSC Network, this patch is often worn by any general assigned to the MSF Herculis, US Space Command and UA Allied Command Generals often have their own patches."
	icon_state = "msfpatch"
//Flag patches
/obj/item/clothing/accessory/patch/ua
	name = "UA flag patch"
	desc = "A fire-resistant shoulder patch with the flag of the United Americas, a superpower composed by North and South America, and their interstellar colonies."
	icon_state = "uaflagpatch"

/obj/item/clothing/accessory/patch/brazil

	name = "Brazilian flag patch"
	desc = "A fire-resistant shoulder patch, with the flag of Brazil, a large South American nation of Earth."
	icon_state = "brazilpatch"

/obj/item/clothing/accessory/patch/usa
	name = "USA flag patch"
	desc = "A fire-resistant shoulder patch with the flag of the United States of America, a massive North American nation of Earth, and the leading superpower of the United Americas."
	icon_state = "usaflagpatch"

//Ribbons
/obj/item/clothing/accessory/patch/ribbon/topography
	name = "USCM Topography Ribbon"
	desc = "A fire-resistant ribbon, awarded to those marines who have completed selective training at the USCMC Topographic Navigation Course."
	icon_state = "topography"

/obj/item/clothing/accessory/patch/ribbon/topography/honor
	name = "USCM Honor Topography Ribbon"
	desc = "A fire-resistant ribbon, awarded to those marines who have completed selective training at the top of their class at the USCMC Topographic Navigation Course."
	icon_state = "topography_honor"

//misc

/obj/item/clothing/accessory/dogtags
	name = "Attachable Dogtags"
	desc = "A robust pair of dogtags to be worn around the neck of the United States Colonial Marines, however due to a combination of budget reallocation, Marines losing their dogtags, and multiple incidents of marines swallowing their tags, they now attach to the uniform or armor."
	icon_state = "dogtag"
	slot = ACCESSORY_SLOT_MEDAL

/obj/item/clothing/accessory/poncho
	name = "USCM Poncho"
	desc = "The standard USCM poncho has variations for every climate. Custom fitted to be attached to standard USCM armor variants it is comfortable, warming or cooling as needed, and well-fit. A marine couldn't ask for more. Affectionately referred to as a \"woobie\"."
	icon_state = "poncho"
	slot = ACCESSORY_SLOT_PONCHO
	var/has_variation = TRUE

/obj/item/clothing/accessory/poncho/Initialize()
	. = ..()
	if(has_variation)
		select_gamemode_skin(/obj/item/clothing/accessory/poncho)
		inv_overlay = image("icon" = 'icons/obj/items/clothing/ties_overlay.dmi', "icon_state" = "[icon_state]")
		update_icon()

/obj/item/clothing/accessory/poncho/green
	icon_state = "poncho"
	has_variation = FALSE

/obj/item/clothing/accessory/poncho/brown
	icon_state = "d_poncho"
	has_variation = FALSE

/obj/item/clothing/accessory/poncho/black
	icon_state = "u_poncho"
	has_variation = FALSE

/obj/item/clothing/accessory/poncho/blue
	icon_state = "c_poncho"
	has_variation = FALSE

/obj/item/clothing/accessory/poncho/purple
	icon_state = "s_poncho"
	has_variation = FALSE

/obj/item/clothing/accessory/poncho/green/army
	name = "Well-worn Poncho"
	desc = "The standard poncho has variations for every climate. Custom fitted to be attached to M3 & M4 armor variants, it is comfortable and warms or cools as needed. A trooper couldn't ask for more. Affectionately referred to as a \"woobie\"."

/obj/item/clothing/accessory/bomb //Suicide vesst
	name = "explosive vest"
	desc = "Used by absolute madmen to cause terror and fear against others, haphazardly put together with C4 and a standard webbing vest."
	icon_state = "bomb_vest"
	var/datum/action/item_action/activation
	var/mob/living/wearer
	slot = ACCESSORY_SLOT_UTILITY

/obj/item/clothing/accessory/bomb/Destroy()
	wearer = null
	if(!QDELETED(activation))
		QDEL_NULL(activation)
	. = ..()

/obj/item/clothing/accessory/bomb/on_attached(obj/item/clothing/S, mob/living/carbon/human/user)
	. = ..()
	wearer = user
	activation = new /datum/action/item_action/bomb/activate(src)
	activation.give_to(wearer)

/obj/item/clothing/accessory/bomb/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	QDEL_NULL(activation)

/datum/action/item_action/bomb/activate
	var/activated = FALSE

/datum/action/item_action/bomb/activate/New(mob/living/user, obj/item/holder)
	..()
	name = "Activate Bomb Vest"
	button.name = name
	button.overlays.Cut()
	button.overlays += image('icons/obj/items/clothing/ties.dmi', button, "bomb_vest")

/datum/action/item_action/bomb/activate/can_use_action()
	var/mob/living/carbon/human/H = owner
	if(!H || H.is_mob_incapacitated(TRUE)) //Can't activate if incapacitated

		return
	if(activated) //don't detonate twice
		return
	return TRUE

/datum/action/item_action/bomb/activate/action_activate()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.visible_message(SPAN_ALERTWARNING("[H] activates the bomb vest! GET DOWN!"), SPAN_ALERTWARNING("You activate the bomb vest! WITNESS ME!"))
	playsound(H, 'sound/items/bomb_vest.ogg', 100, 1)
	activated = TRUE

	addtimer(CALLBACK(src, PROC_REF(detonate), FALSE), 3 SECONDS)

/datum/action/item_action/bomb/activate/proc/detonate()
	var/mob/living/carbon/human/H = owner
	var/turf/epicenter = get_turf(H)
	target.ex_act(400, null, src, H, 100)
	cell_explosion(epicenter, 150, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, create_cause_data(initial(name), H))
	H.gib()
	qdel(src)

//Ties that can store stuff

/obj/item/storage/internal/accessory
	storage_slots = 3

/obj/item/clothing/accessory/storage
	name = "load bearing equipment"
	desc = "Used to hold things when you don't have enough hands."
	icon_state = "webbing"
	w_class = SIZE_LARGE //too big to store in other pouches
	var/obj/item/storage/internal/hold = /obj/item/storage/internal/accessory
	slot = ACCESSORY_SLOT_UTILITY
	high_visibility = TRUE

/obj/item/clothing/accessory/storage/Initialize()
	. = ..()
	hold = new hold(src)

/obj/item/clothing/accessory/storage/Destroy()
	QDEL_NULL(hold)
	return ..()

/obj/item/clothing/accessory/storage/clicked(mob/user, list/mods)
	if(mods[ALT_CLICK] && !isnull(hold) && loc == user && !user.get_active_hand()) //To pass quick-draw attempts to storage. See storage.dm for explanation.
		return
	. = ..()

/obj/item/clothing/accessory/storage/attack_hand(mob/user as mob, mods)
	if (!isnull(hold) && hold.handle_attack_hand(user, mods))
		..(user)
	return TRUE

/obj/item/clothing/accessory/storage/MouseDrop(obj/over_object as obj)
	if (has_suit || hold)
		return

	if (hold.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/accessory/storage/attackby(obj/item/W, mob/user)
	return hold.attackby(W, user)

/obj/item/clothing/accessory/storage/emp_act(severity)
	. = ..()
	hold.emp_act(severity)

/obj/item/clothing/accessory/storage/hear_talk(mob/M, msg)
	hold.hear_talk(M, msg)
	..()

/obj/item/clothing/accessory/storage/attack_self(mob/user)
	..()
	to_chat(user, SPAN_NOTICE("You empty [src]."))
	var/turf/T = get_turf(src)
	hold.storage_close(usr)
	for(var/obj/item/I in hold.contents)
		hold.remove_from_storage(I, T)
	src.add_fingerprint(user)

/obj/item/clothing/accessory/storage/on_attached(obj/item/clothing/C, mob/living/user, silent)
	. = ..()
	if(.)
		C.w_class = w_class //To prevent monkey business.
		C.verbs += /obj/item/clothing/suit/storage/verb/toggle_draw_mode

/obj/item/clothing/accessory/storage/on_removed(mob/living/user, obj/item/clothing/C)
	. = ..()
	if(.)
		C.w_class = initial(C.w_class)
		C.verbs -= /obj/item/clothing/suit/storage/verb/toggle_draw_mode

/obj/item/storage/internal/accessory/webbing
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/plasma,
	)

/obj/item/clothing/accessory/storage/webbing
	name = "webbing"
	desc = "A sturdy mess of synthcotton belts and buckles, ready to share your burden."
	icon_state = "webbing"
	hold = /obj/item/storage/internal/accessory/webbing

/obj/item/clothing/accessory/storage/webbing/black
	name = "black webbing"
	icon_state = "webbing_black"
	item_state = "webbing_black"

/obj/item/clothing/accessory/storage/webbing/five_slots
	hold = /obj/item/storage/internal/accessory/webbing/five_slots

/obj/item/storage/internal/accessory/webbing/five_slots
	storage_slots = 5

/obj/item/storage/internal/accessory/black_vest
	storage_slots = 5

/obj/item/clothing/accessory/storage/black_vest
	name = "black webbing vest"
	desc = "Robust black synthcotton vest with lots of pockets to hold whatever you need, but cannot hold in hands."
	icon_state = "vest_black"
	hold = /obj/item/storage/internal/accessory/black_vest

/obj/item/clothing/accessory/storage/black_vest/attackby(obj/item/W, mob/living/user)
	if(HAS_TRAIT(W, TRAIT_TOOL_WIRECUTTERS) && skillcheck(user, SKILL_RESEARCH, SKILL_RESEARCH_TRAINED))
		var/components = 0
		var/obj/item/reagent_container/glass/beaker/vial
		var/obj/item/cell/battery
		for(var/obj/item in hold.contents)
			if(istype(item, /obj/item/device/radio) || istype(item, /obj/item/stack/cable_coil) || istype(item, /obj/item/device/healthanalyzer))
				components++
			else if(istype(item, /obj/item/reagent_container/hypospray) && !istype(item, /obj/item/reagent_container/hypospray/autoinjector))
				var/obj/item/reagent_container/hypospray/H = item
				if(H.mag)
					vial = H.mag
				components++
			else if(istype(item, /obj/item/cell))
				battery = item
				components++
			else
				components--
		if(components == 5)
			var/obj/item/clothing/accessory/storage/black_vest/acid_harness/AH
			if(istype(src, /obj/item/clothing/accessory/storage/black_vest/brown_vest))
				AH = new /obj/item/clothing/accessory/storage/black_vest/acid_harness/brown(get_turf(loc))
			else
				AH = new /obj/item/clothing/accessory/storage/black_vest/acid_harness(get_turf(loc))
			if(vial)
				AH.vial = vial
				AH.hold.handle_item_insertion(vial)
			AH.battery = battery
			AH.hold.handle_item_insertion(battery)
			qdel(src)
			return
	. = ..()

/obj/item/clothing/accessory/storage/black_vest/brown_vest
	name = "brown webbing vest"
	desc = "Worn brownish synthcotton vest with lots of pockets to unload your hands."
	icon_state = "vest_brown"

/obj/item/clothing/accessory/storage/black_vest/waistcoat
	name = "tactical waistcoat"
	desc = "A stylish black waistcoat with plenty of discreet pouches, to be both utilitarian and fashionable without compromising looks."
	icon_state = "waistcoat"

/obj/item/clothing/accessory/storage/tool_webbing
	name = "Tool Webbing"
	desc = "A brown synthcotton webbing that is similar in function to civilian tool aprons, but is more durable for field usage."
	hold = /obj/item/storage/internal/accessory/tool_webbing

/obj/item/clothing/accessory/storage/tool_webbing/small
	name = "Small Tool Webbing"
	desc = "A brown synthcotton webbing that is similar in function to civilian tool aprons, but is more durable for field usage. This is the small low-budget version."
	hold = /obj/item/storage/internal/accessory/tool_webbing/small

/obj/item/storage/internal/accessory/tool_webbing
	storage_slots = 7
	can_hold = list(
		/obj/item/tool/screwdriver,
		/obj/item/tool/wrench,
		/obj/item/tool/weldingtool,
		/obj/item/tool/crowbar,
		/obj/item/tool/wirecutters,
		/obj/item/stack/cable_coil,
		/obj/item/device/multitool,
		/obj/item/tool/shovel/etool,
		/obj/item/weapon/gun/smg/nailgun/compact,
	)

/obj/item/storage/internal/accessory/tool_webbing/small
	storage_slots = 6

/obj/item/clothing/accessory/storage/tool_webbing/small/equipped
	hold = /obj/item/storage/internal/accessory/tool_webbing/small/equipped

/obj/item/storage/internal/accessory/tool_webbing/small/equipped/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/device/multitool(src)

/obj/item/clothing/accessory/storage/tool_webbing/equipped
	hold = /obj/item/storage/internal/accessory/tool_webbing/equipped

/obj/item/storage/internal/accessory/tool_webbing/equipped/fill_preset_inventory()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/device/multitool(src)

/obj/item/clothing/accessory/storage/tool_webbing/tactical
	hold = /obj/item/storage/internal/accessory/tool_webbing/tactical

/obj/item/storage/internal/accessory/tool_webbing/tactical/fill_preset_inventory()
	new /obj/item/tool/screwdriver/tactical(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool/largetank(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/tool/wirecutters/tactical(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/device/multitool(src)

/obj/item/storage/internal/accessory/surg_vest
	storage_slots = 14
	can_hold = list(
		/obj/item/tool/surgery,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/nanopaste,
	)

/obj/item/storage/internal/accessory/surg_vest/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/storage/surgical_tray))
		var/obj/item/storage/surgical_tray/ST = W
		if(!length(ST.contents))
			return
		if(length(contents) >= storage_slots)
			to_chat(user, SPAN_WARNING("The surgical webbing vest is already full."))
			return
		if(!do_after(user, 5 SECONDS * user.get_skill_duration_multiplier(SKILL_MEDICAL), INTERRUPT_ALL, BUSY_ICON_GENERIC))
			return
		for(var/obj/item/I in ST)
			if(length(contents) >= storage_slots)
				break
			ST.remove_from_storage(I)
			attempt_item_insertion(I, TRUE, user)
		user.visible_message("[user] transfers the tools from \the [ST] to the surgical webbing vest.", SPAN_NOTICE("You transfer the tools from \the [ST] to the surgical webbing vest."), max_distance = 3)
		return
	return ..()

/obj/item/storage/internal/accessory/surg_vest/equipped/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel/pict_system(src)
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/surgicaldrill(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/tool/surgery/surgical_line(src)
	new /obj/item/tool/surgery/synthgraft(src)

/obj/item/clothing/accessory/storage/surg_vest
	name = "surgical webbing vest"
	desc = "Greenish synthcotton vest purpose-made for holding surgical tools."
	icon_state = "vest_surg"
	hold = /obj/item/storage/internal/accessory/surg_vest

/obj/item/clothing/accessory/storage/surg_vest/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/blue
	name = "blue surgical webbing vest"
	desc = "A matte blue synthcotton vest purpose-made for holding surgical tools."
	icon_state = "vest_blue"

/obj/item/clothing/accessory/storage/surg_vest/blue/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_blue
	name = "blue surgical drop pouch"
	desc = "A matte blue synthcotton drop pouch purpose-made for holding surgical tools."
	icon_state = "drop_pouch_surgical_blue"

/obj/item/clothing/accessory/storage/surg_vest/drop_blue/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_green
	name = "green surgical drop pouch"
	desc = "A greenish synthcotton drop pouch purpose-made for holding surgical tools."
	icon_state = "drop_pouch_surgical_green"

/obj/item/clothing/accessory/storage/surg_vest/drop_green/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/surg_vest/drop_green/upp
	hold = /obj/item/storage/internal/accessory/surg_vest/drop_green/upp

/obj/item/storage/internal/accessory/surg_vest/drop_green/upp/fill_preset_inventory()
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/surgicaldrill(src)
	new /obj/item/tool/surgery/scalpel/pict_system(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/stack/medical/advanced/bruise_pack(src)
	new /obj/item/stack/nanopaste(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/reagent_container/blood/OMinus(src)

/obj/item/clothing/accessory/storage/surg_vest/drop_black
	name = "black surgical drop pouch"
	desc = "A tactical black synthcotton drop pouch purpose-made for holding surgical tools."
	icon_state = "drop_pouch_surgical_black"

/obj/item/clothing/accessory/storage/surg_vest/drop_black/equipped
	hold = /obj/item/storage/internal/accessory/surg_vest/equipped

/obj/item/clothing/accessory/storage/knifeharness
	name = "M272 pattern knife vest"
	desc = "An older generation M272 pattern knife vest once employed by the USCM. Can hold up to 5 knives. It is made of synthcotton."
	icon_state = "vest_knives"
	hold = /obj/item/storage/internal/accessory/knifeharness

/obj/item/clothing/accessory/storage/knifeharness/attack_hand(mob/user, mods)
	if(!mods || !mods[ALT_CLICK] || !length(hold.contents))
		return ..()

	hold.contents[length(contents)].attack_hand(user, mods)

/obj/item/storage/internal/accessory/knifeharness
	storage_slots = 5
	max_storage_space = 5
	can_hold = list(
		/obj/item/tool/kitchen/utensil/knife,
		/obj/item/tool/kitchen/utensil/pknife,
		/obj/item/tool/kitchen/knife,
		/obj/item/attachable/bayonet,
		/obj/item/weapon/throwing_knife,
	)
	storage_flags = STORAGE_ALLOW_QUICKDRAW|STORAGE_FLAGS_POUCH

	COOLDOWN_DECLARE(draw_cooldown)

/obj/item/storage/internal/accessory/knifeharness/fill_preset_inventory()
	for(var/i = 1 to storage_slots)
		new /obj/item/weapon/throwing_knife(src)

/obj/item/storage/internal/accessory/knifeharness/attack_hand(mob/user, mods)
	. = ..()

	if(!COOLDOWN_FINISHED(src, draw_cooldown))
		to_chat(user, SPAN_WARNING("You need to wait before drawing another knife!"))
		return FALSE

	if(length(contents))
		contents[length(contents)].attack_hand(user, mods)
		COOLDOWN_START(src, draw_cooldown, BAYONET_DRAW_DELAY)

/obj/item/storage/internal/accessory/knifeharness/_item_insertion(obj/item/inserted_item, prevent_warning = 0)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/storage/internal/accessory/knifeharness/_item_removal(obj/item/removed_item, atom/new_location)
	..()
	playsound(src, 'sound/weapons/gun_shotgun_shell_insert.ogg', 15, TRUE)

/obj/item/clothing/accessory/storage/knifeharness/duelling
	name = "decorated harness"
	desc = "A heavily decorated harness of sinew and leather with two knife-loops."
	icon_state = "unathiharness2"
	hold = /obj/item/storage/internal/accessory/knifeharness/duelling

/obj/item/storage/internal/accessory/knifeharness/duelling
	storage_slots = 2
	max_storage_space = 2
	can_hold = list(
		/obj/item/weapon/unathiknife,
	)

/obj/item/storage/internal/accessory/knifeharness/duelling/fill_preset_inventory()
	new /obj/item/weapon/unathiknife(src)
	new /obj/item/weapon/unathiknife(src)

/obj/item/clothing/accessory/storage/droppouch
	name = "drop pouch"
	desc = "A convenient pouch to carry loose items around."
	icon_state = "drop_pouch"
	hold = /obj/item/storage/internal/accessory/drop_pouch

/obj/item/clothing/accessory/storage/droppouch/upp
	icon_state = "upp_drop_pouch_alt"

/obj/item/clothing/accessory/storage/droppouch/rmc
	icon_state = "rmc_drop_pouch_alt"

/obj/item/clothing/accessory/storage/droppouch/wy
	icon_state = "wy_drop_pouch"

/obj/item/storage/internal/accessory/drop_pouch
	w_class = SIZE_LARGE //Allow storage containers that's medium or below
	storage_slots = null
	max_w_class = SIZE_MEDIUM
	max_storage_space = 8 //weight system like backpacks, hold enough for 2 medium (normal) size items, or 4 small items, or 8 tiny items
	cant_hold = list( //Prevent inventory powergame
		/obj/item/storage/firstaid,
		/obj/item/storage/bible,
		/obj/item/storage/toolkit,
		)
	storage_flags = NONE //no verb, no quick draw, no tile gathering

/obj/item/clothing/accessory/storage/smallpouch
	name = "small pouch"
	desc = "A small pouch to carry a few items, typically the contents of an IFAK."
	icon_state = "pouch"
	hold = /obj/item/storage/internal/accessory/smallpouch

/obj/item/clothing/accessory/storage/smallpouch/upp
	icon_state = "upp_pouch_alt"

/obj/item/clothing/accessory/storage/smallpouch/rmc
	icon_state = "rmc_pouch_alt"

/obj/item/clothing/accessory/storage/smallpouch/wy
	icon_state = "wy_pouch"

/obj/item/storage/internal/accessory/smallpouch
	w_class = SIZE_LARGE
	max_w_class = SIZE_SMALL
	storage_flags = NONE
	storage_slots = 4

/obj/item/clothing/accessory/storage/holster
	name = "shoulder holster"
	desc = "A handgun holster with an attached pouch, allowing two magazines or speedloaders to be stored along with it."
	icon_state = "holster"
	high_visibility = TRUE
	hold = /obj/item/storage/internal/accessory/holster

/obj/item/storage/internal/accessory/holster
	w_class = SIZE_LARGE
	max_w_class = SIZE_MEDIUM
	var/obj/item/weapon/gun/current_gun
	var/sheatheSound = 'sound/weapons/gun_pistol_sheathe.ogg'
	var/drawSound = 'sound/weapons/gun_pistol_draw.ogg'
	storage_flags = STORAGE_ALLOW_QUICKDRAW|STORAGE_FLAGS_POUCH
	can_hold = list(

//Can hold variety of pistols and revolvers together with ammo for them. Can also hold the flare pistol and signal/illumination flares.
	/obj/item/weapon/gun/pistol,
	/obj/item/weapon/gun/energy/taser,
	/obj/item/weapon/gun/revolver,
	/obj/item/ammo_magazine/pistol,
	/obj/item/ammo_magazine/revolver,
	/obj/item/weapon/gun/flare,
	/obj/item/device/flashlight/flare
	)

/obj/item/storage/internal/accessory/holster/on_stored_atom_del(atom/movable/AM)
	if(AM == current_gun)
		current_gun = null

/obj/item/clothing/accessory/storage/holster/attack_hand(mob/user, mods)
	var/obj/item/storage/internal/accessory/holster/H = hold
	if(H.current_gun && ishuman(user) && (loc == user || has_suit))
		if(mods && mods[ALT_CLICK] && length(H.contents) > 1) //Withdraw the most recently inserted magazine, if possible.
			var/obj/item/I = H.contents[length(H.contents)]
			if(isgun(I))
				I = H.contents[length(H.contents) - 1]
			I.attack_hand(user)
		else
			H.current_gun.attack_hand(user)
		return

	..()

/obj/item/storage/internal/accessory/holster/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE)
	if( ..() ) //If the parent did their thing, this should be fine. It pretty much handles all the checks.
		if(isgun(W))
			if(current_gun)
				if(!stop_messages)
					to_chat(usr, SPAN_WARNING("[src] already holds \a [W]."))
				return
		else //Must be ammo.
			var/ammo_slots = storage_slots - 1 //We have a slot reserved for the gun
			var/ammo_stored = length(contents)
			if(current_gun)
				ammo_stored--
			if(ammo_stored >= ammo_slots)
				if(!stop_messages)
					to_chat(usr, SPAN_WARNING("[src] can't hold any more magazines."))
				return
		return 1

/obj/item/storage/internal/accessory/holster/_item_insertion(obj/item/W)
	if(isgun(W))
		current_gun = W //If there's no active gun, we want to make this our gun
		playsound(src, sheatheSound, 15, TRUE)
	. = ..()

/obj/item/storage/internal/accessory/holster/_item_removal(obj/item/W)
	if(isgun(W))
		current_gun = null
		playsound(src, drawSound, 15, TRUE)
	. = ..()

/obj/item/clothing/accessory/storage/holster/armpit
	name = "shoulder holster"
	desc = "A worn-out handgun holster. Perfect for concealed carry"
	icon_state = "holster"

/obj/item/clothing/accessory/storage/holster/waist
	name = "waist holster"
	desc = "A handgun holster."
	icon_state = "holster_hip"
	item_state = "holster_hip"

//Knife sheath, for the really big kinds of knives you get in the loadout
//Butchered holster code

/obj/item/clothing/accessory/storage/sheath
	name = "large knife sheath"
	desc = "A well-made leather sheath, looks big enough to hold a proper knife in it, or even a machete at a push."
	icon_state = "holster_knife"
	high_visibility = TRUE
	hold = /obj/item/storage/internal/accessory/sheath

/obj/item/storage/internal/accessory/sheath
	storage_slots = 1
	w_class = SIZE_LARGE
	max_w_class = SIZE_LARGE
	var/obj/item/weapon/current_blade
	var/sheatheSound = 'sound/handling/holsterin.ogg'
	var/drawSound = 'sound/handling/holsterout.ogg'
	storage_flags = STORAGE_ALLOW_QUICKDRAW
	can_hold = list(
		/obj/item/weapon/knife/marine/bowie,
		/obj/item/weapon/knife/marine/bowie/kukri,
		/obj/item/weapon/sword/machete,
		/obj/item/weapon/sword/machete/arnold,
		/obj/item/weapon/sword/machete/arnold/weak,
	)

/obj/item/storage/internal/accessory/sheath/on_stored_atom_del(atom/movable/AM)
	if(AM == current_blade)
		current_blade = null

/obj/item/clothing/accessory/storage/sheath/attack_hand(mob/user, mods)
	var/obj/item/storage/internal/accessory/sheath/S = hold
	if(S.current_blade && ishuman(user) && (loc == user || has_suit))
		S.current_blade.attack_hand(user)
		return

	..()

/obj/item/storage/internal/accessory/sheath/can_be_inserted(obj/item/W, mob/user, stop_messages = FALSE)
	if( ..() ) //If the parent did their thing, this should be fine. It pretty much handles all the checks.
		if(isweapon(W))
			if(current_blade)
				if(!stop_messages)
					to_chat(usr, SPAN_WARNING("[src] already holds \a [W]."))
				return
		return 1

/obj/item/storage/internal/accessory/sheath/_item_insertion(obj/item/W)
	if(isweapon(W))
		current_blade = W //If there's no active gun, we want to make this our gun
		playsound(src, sheatheSound, 15, TRUE)
	. = ..()

/obj/item/storage/internal/accessory/sheath/_item_removal(obj/item/W)
	if(isweapon(W))
		current_blade = null
		playsound(src, drawSound, 15, TRUE)
	. = ..()

/*
	Holobadges are worn on the belt or neck, and can be used to show that the holder is an authorized
	Security agent - the user details can be imprinted on the badge with a Security-access ID card,
	or they can be emagged to accept any ID for use in disguises.
*/

/obj/item/clothing/accessory/holobadge

	name = "holobadge"
	desc = "This glowing blue badge marks the holder as THE LAW."
	icon_state = "holobadge"
	flags_equip_slot = SLOT_WAIST
	jumpsuit_hide_states = UNIFORM_JACKET_REMOVED

	var/stored_name = null

/obj/item/clothing/accessory/holobadge/cord
	icon_state = "holobadge-cord"
	flags_equip_slot = SLOT_FACE

/obj/item/clothing/accessory/holobadge/attack_self(mob/user)
	..()

	if(!stored_name)
		to_chat(user, "Waving around a badge before swiping an ID would be pretty pointless.")
		return
	if(isliving(user))
		user.visible_message(SPAN_DANGER("[user] displays their Wey-Yu Internal Security Legal Authorization Badge.\nIt reads: [stored_name], Wey-Yu Security."),SPAN_DANGER("You display your Wey-Yu Internal Security Legal Authorization Badge.\nIt reads: [stored_name], Wey-Yu Security."))

/obj/item/clothing/accessory/holobadge/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/card/id))

		var/obj/item/card/id/id_card = null

		if(istype(O, /obj/item/card/id))
			id_card = O

		if(ACCESS_MARINE_BRIG in id_card.access)
			to_chat(user, "You imprint your ID details onto the badge.")
			stored_name = id_card.registered_name
			name = "holobadge ([stored_name])"
			desc = "This glowing blue badge marks [stored_name] as THE LAW."
		else
			to_chat(user, "[src] rejects your insufficient access rights.")
		return
	..()

/obj/item/clothing/accessory/holobadge/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(SPAN_DANGER("[user] invades [M]'s personal space, thrusting [src] into their face insistently."),SPAN_DANGER("You invade [M]'s personal space, thrusting [src] into their face insistently. You are the law."))

/obj/item/storage/box/holobadge
	name = "holobadge box"
	desc = "A box claiming to contain holobadges."

/obj/item/storage/box/holobadge/New()
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge(src)
	new /obj/item/clothing/accessory/holobadge/cord(src)
	new /obj/item/clothing/accessory/holobadge/cord(src)
	..()
	return

/obj/item/clothing/accessory/storage/owlf_vest
	name = "\improper OWLF agent vest"
	desc = "This is a fancy-looking ballistics vest, meant to be attached to a uniform." //No stats for these yet, just placeholder implementation.
	icon = 'icons/obj/items/clothing/ties.dmi'
	icon_state = "owlf_vest"
	item_state = "owlf_vest"

/obj/item/clothing/accessory/flak
	name = "M67 flak vest"
	desc = "An older model of flak jacket worn by combat support personnel such as dropship crew, or occasionally by smartgunners. Much comfier than its M70 successor, and can be worn under most combat armor, however, the ballistic protection leaves much to be desired."
	icon_state = "flak"
	item_state = "flak"
	w_class = SIZE_MEDIUM
	var/tucked_in = FALSE

/obj/item/clothing/accessory/flak/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("You can wear it differently by <b>using it in hand</b>.")

/obj/item/clothing/accessory/flak/attack_self(mob/user)
	..()

	tucked_in = !tucked_in
	if(tucked_in)
		icon_state = "[initial(icon_state)]_slim"
		user.visible_message(SPAN_NOTICE("[user] tucks in [src]'s sleeves."), SPAN_NOTICE("You tuck in [src]'s sleeves."))
	else
		icon_state = initial(icon_state)
		user.visible_message(SPAN_NOTICE("[user] decides to keep [src] nice and puffy."), SPAN_NOTICE("You decide to keep [src] nice and puffy."))
	item_state = icon_state

/obj/item/clothing/accessory/flak/od
	icon_state = "flakod"
	item_state = "flakod"

//===========================//Wrist-worn accessories, just watches currently\\================================\\

/obj/item/clothing/accessory/wrist
	name = "bracelet"
	desc = "A simple bracelet made from a strip of fabric."
	icon_state = "bracelet"
	item_state = null
	slot = ACCESSORY_SLOT_WRIST_L
	var/which_wrist = "left wrist"

/obj/item/clothing/accessory/wrist/get_examine_text(mob/user)
	. = ..()

	switch(slot)
		if(ACCESSORY_SLOT_WRIST_L)
			which_wrist = "left wrist"
		if(ACCESSORY_SLOT_WRIST_R)
			which_wrist = "right wrist"
	. += "It will be worn on the [which_wrist]."

/obj/item/clothing/accessory/wrist/additional_examine_text()
	return "on the [which_wrist]."

/obj/item/clothing/accessory/wrist/attack_self(mob/user)
	..()

	switch(slot)
		if(ACCESSORY_SLOT_WRIST_L)
			slot = ACCESSORY_SLOT_WRIST_R
			to_chat(user, SPAN_NOTICE("[src] will be worn on the right wrist."))
		if(ACCESSORY_SLOT_WRIST_R)
			slot = ACCESSORY_SLOT_WRIST_L
			to_chat(user, SPAN_NOTICE("[src] will be worn on the left wrist."))

/obj/item/clothing/accessory/wrist/watch
	name = "Seiko Pulsemeter wristwatch"
	desc = "Model S234-501A, a durable quartz-based wristwatch issued to most Colonial Marines who pass through basic training."
	icon_state = "wristwatch_basic"
	item_state = "wristwatch_black"
	w_class = SIZE_SMALL
	flags_equip_slot = SLOT_HANDS

/obj/item/clothing/accessory/wrist/watch/get_examine_text(mob/user)
	. = ..()

	. += "It reads: [SPAN_NOTICE("[worldtime2text()]")]"

/obj/item/clothing/accessory/wrist/watch/additional_examine_text()
	. = ..()

	. += " It reads: [SPAN_NOTICE("[worldtime2text()]")]"

/obj/item/storage/box/watch_box
	name = "\improper Seiko Pulsemeter wristwatch storage case"
	desc = "A tough-wearing case to keep an expensive wristwatch safe when not being worn."
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "pdt_box"
	can_hold = list(/obj/item/clothing/accessory/wrist/watch)
	foldable = /obj/item/stack/sheet/cardboard
	storage_slots = 1
	w_class = SIZE_SMALL
	max_w_class = SIZE_SMALL

/obj/item/storage/box/watch_box/fill_preset_inventory()
	new /obj/item/clothing/accessory/wrist/watch(src)

/obj/item/clothing/accessory/wrist/watch/bishop
	name = "Seiko 7A28-6000 wristwatch"
	desc = "A fancy black-bodied wristwatch. Once set correctly, it always holds the right time. For the connoisseurs of precision."
	icon_state = "wristwatch_bishop"
	item_state = "wristwatch_black"

/obj/item/storage/box/watch_box/bishop
	name = "\improper Seiko 7A28-6000 wristwatch storage case"

/obj/item/storage/box/watch_box/bishop/fill_preset_inventory()
	new /obj/item/clothing/accessory/wrist/watch/bishop(src)

/obj/item/clothing/accessory/wrist/watch/ripley
	name = "Seiko 7A28-7000 wristwatch"
	desc = "With the pioneering design of analog quartz chronographs beating inside it, this asymetric wristwatch is perfect for anyone who can remain standing where others have all fallen."
	icon_state = "wristwatch_ripley"
	item_state = "wristwatch_silver"

/obj/item/storage/box/watch_box/ripley
	name = "\improper Seiko 7A28-7000 wristwatch storage case"

/obj/item/storage/box/watch_box/ripley/fill_preset_inventory()
	new /obj/item/clothing/accessory/wrist/watch/ripley(src)

/obj/item/clothing/accessory/wrist/watch/burke
	name = "Seiko H556-5050 wristwatch"
	desc = "A more upmarket wristwatch tailored towards junior executives & 'company guys' all across the galaxy. Flashy, but not horribly ostentatious."
	icon_state = "wristwatch_burke"
	item_state = "wristwatch_silver"

/obj/item/storage/box/watch_box/burke
	name = "\improper Seiko H556-5050 wristwatch storage case"

/obj/item/storage/box/watch_box/burke/fill_preset_inventory()
	new /obj/item/clothing/accessory/wrist/watch/burke(src)

/obj/item/clothing/accessory/wrist/watch/dallas
	name = "Samani E-125 wristwatch"
	desc = "Advertised as being 'A new dawn of precision digital watches', the E-125 became a popular hit with members of the civil aerospace industry."
	icon_state = "wristwatch_dallas"
	item_state = "wristwatch_fancy"

/obj/item/storage/box/watch_box/dallas
	name = "\improper Samani E-125 wristwatch storage case"

/obj/item/storage/box/watch_box/dallas/fill_preset_inventory()
	new /obj/item/clothing/accessory/wrist/watch/dallas(src)

//===========================//CUSTOM ARMOR COSMETIC PLATES\\================================\\

/obj/item/clothing/accessory/pads
	name = "\improper M3 Pauldrons"
	desc = "Attachable supplementary armor for the M3 armor system. Protects from glancing hits and covers the arm opening in the cuirass against shrapnel."
	icon_state = "pads"
	item_state = "pads"
	slot = ACCESSORY_SLOT_DECORARMOR

/obj/item/clothing/accessory/pads/Initialize(mapload)
	. = ..()
	if(!(flags_atom & NO_SNOW_TYPE))
		select_gamemode_skin(type)
	update_icon()

/obj/item/clothing/accessory/pads/bracers
	name = "\improper M3 Vambraces"
	desc = "Attachable supplementary armor for the M3 armor system. A pair of composite ballistic vambraces to shield the forearms, with straps to ensure it doesn't ride up or down."
	icon_state = "bracers"
	item_state = "bracers"
	slot = ACCESSORY_SLOT_DECORBRACER

/obj/item/clothing/accessory/pads/bracers/standard
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/pads/neckguard
	name = "\improper M3 Gorget"
	desc = "Attachable supplementary armor for the M3 armor system. A simple polymer ballistic plate to resist ricochets and shrapnel."
	icon_state = "neckguard"
	item_state = "neckguard"
	slot = ACCESSORY_SLOT_DECORNECK

/obj/item/clothing/accessory/pads/neckguard/uacg
	desc = "Attachable supplementary armor for the UACG's M3 armor system. A simple polymer ballistic plate to resist ricochets and shrapnel."
	icon_state = "neckguard_uacg"
	item_state = "neckguard_uacg"
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/pads/greaves
	name = "\improper M3 Greaves"
	desc = "Attachable supplementary armor for the M3 armor system. Lightweight polymer clamshell-style plates enclose the lower legs to provide shrapnel and pistol protection."
	icon_state = "shinguards"
	item_state = "shinguards"
	slot = ACCESSORY_SLOT_DECORSHIN

/obj/item/clothing/accessory/pads/greaves/standard
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/pads/kneepads
	name = "\improper M3 Kneepads"
	desc = "Attachable supplementary armor for the M3 armor system. High impact ruggedized outer shell and polymer internals protect from shrapnel as well as low power ballistics."
	icon_state = "thighguards"
	item_state = "thighguards"
	slot = ACCESSORY_SLOT_DECORKNEE

/obj/item/clothing/accessory/pads/kneepads/standard
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/pads/groin
	name = "\improper M3 Lap Panel"
	desc = "Attachable supplementary armor for the M3 armor system. Shear thickening liquid armor piece covering the abdomen and groin, with an additional ruggedized boron carbide strike face for the genitals. Clasps to the inside of the M3 cuirass."
	icon_state = "groinplate"
	item_state = "groinplate"
	slot = ACCESSORY_SLOT_DECORGROIN

/obj/item/clothing/accessory/pads/groin/uacg
	desc = "Attachable supplementary armor for the UACG's M3 armor system. Shear thickening liquid armor piece covering the abdomen and groin, with an additional ruggedized boron carbide strike face for the genitals. Clasps to the inside of the M3 cuirass."
	icon_state = "groinplate_uacg"
	item_state = "groinplate_uacg"
	slot = ACCESSORY_SLOT_DECORGROIN
	flags_atom = NO_SNOW_TYPE


//===========================//USASF CUSTOM ARMOR PLATES\\================================\\

/obj/item/clothing/accessory/pads/navy
	name = "\improper M4 Pauldrons"
	desc = "Attachable supplementary armor for the USASF M4 armor system. Protects from glancing hits and covers the arm opening in the cuirass against shrapnel."
	icon_state = "u_pads"
	item_state = "u_pads"
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/pads/greaves/navy
	name = "\improper M4 Greaves"
	desc = "Attachable supplementary armor for the M4 armor system. Lightweight polymer clamshell-style plates enclose the lower legs to provide shrapnel and pistol protection."
	icon_state = "u_shinguards"
	item_state = "u_shinguards"
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/pads/groin/navy
	name = "\improper M4 Lap Panel"
	desc = "Attachable supplementary armor for the USASF M4 armor system. Shear thickening liquid armor piece covering the abdomen and groin, with an additional ruggedized carbon-fibre composite strike face for the genitals. Clasps to the inside of the M3 cuirass."
	icon_state = "u_groinplate"
	item_state = "u_groinplate"
	slot = ACCESSORY_SLOT_DECORGROIN

//===========================//UPP CUSTOM ARMOR PLATES\\================================\\

/obj/item/clothing/accessory/upppads
	name = "\improper 6B90 Arm Plates"
	desc = "A set of arm plates designed for the 6B90 armor system."
	icon_state = "upp_arms"
	item_state = "upp_arms"
	slot = ACCESSORY_SLOT_DECORARMOR

/obj/item/clothing/accessory/upppads/legs
	name = "\improper 6B90 Leg Guards"
	desc = "A set of leg greaves designed for the 6B90 armor system."
	icon_state = "upp_greaves"
	item_state = "upp_greaves"
	slot = ACCESSORY_SLOT_DECORSHIN

/obj/item/clothing/accessory/upppads/crotch
	name = "\improper 6B90 Crotch Guard"
	desc = "A crotch plate designed for the 6B90 armor system."
	icon_state = "upp_crotch"
	item_state = "upp_crotch"
	slot = ACCESSORY_SLOT_DECORGROIN

//===========================//TWE CUSTOM ARMOR PLATES\\================================\\

/obj/item/clothing/accessory/twepads
	name = "\improper Kestrel Shoulder Pads"
	desc = "A set of ashoulder pads designed for the Kestrel armor system."
	icon_state = "rmc_arms"
	item_state = "rmc_arms"
	slot = ACCESSORY_SLOT_DECORARMOR

/obj/item/clothing/accessory/twepads/legs
	name = "\improper Kestrel Leg Guards"
	desc = "A set of leg greaves designed for the Kestrel armor system."
	icon_state = "rmc_greaves"
	item_state = "rmc_greaves"
	slot = ACCESSORY_SLOT_DECORSHIN

//===========================//CUSTOM ARMOR PAINT\\================================\\

/obj/item/clothing/accessory/paint
	name = "skull armor paint"
	desc = "A set of paint tones to etch a skull into a Marine's armor."
	icon_state = "skull"
	item_state = "skull"
	slot = ACCESSORY_SLOT_PAINT

/obj/item/clothing/accessory/paint/heart
	name = "heart armor paint"
	desc = "A set of paint tones to etch a heart into a Marine's armor."
	icon_state = "heart"
	item_state = "heart"

/obj/item/clothing/accessory/paint/medic
	name = "cross armor paint"
	desc = "A set of paint tones to etch a red cross into a Marine's armor."
	icon_state = "medic"
	item_state = "medic"

/obj/item/clothing/accessory/paint/medic/wy
	name = "Weyland-Yutani doctor patch"
	desc = "A patch worned on the armor by the PMC medics."
	icon_state = "medic_wy"
	item_state = "medic_wy"

/obj/item/clothing/accessory/paint/medic/wy/black
	name = "Weyland-Yutani black doctor patch"
	icon_state = "medic_wy_black"
	item_state = "medic_wy_black"

/obj/item/clothing/accessory/paint/uaflag
	name = "UA flag armor paint"
	desc = "A set of paint tones to etch the red, white, and black into a Marine's armor."
	icon_state = "uaflag"
	item_state = "uaflag"

/obj/item/clothing/accessory/paint/usflag
	name = "US flag armor paint"
	desc = "A set of paint tones to etch the red, white, and blue into a Marine's armor."
	icon_state = "usflag"
	item_state = "usflag"

/obj/item/clothing/accessory/paint/target
	name = "target armor paint"
	desc = "A set of paint tones to etch a target pattern into a Marine's armor."
	icon_state = "target"
	item_state = "target"

/obj/item/clothing/accessory/paint/alcoholism
	name = "smileyface armor paint"
	desc = "A set of paint tones to etch a happy face into a Marine's armor."
	icon_state = "smileyface"
	item_state = "smileyface"

/obj/item/clothing/accessory/paint/melancholy
	name = "neutralface armor paint"
	desc = "A set of paint tones to etch a happy face into a Marine's armor, though this one carries indifferent energy."
	icon_state = "neutralface"
	item_state = "neutralface"

/obj/item/clothing/accessory/paint/cross
	name = "cross armor paint"
	desc = "A set of paint tones to etch a religious symbol into a Marine's armor."
	icon_state = "cross"
	item_state = "cross"

/obj/item/clothing/accessory/paint/inscription
	name = "cross armor paint"
	desc = "A set of paint tones to etch a text phrase into a Marine's armor."
	icon_state = "inscription"
	item_state = "inscription"

/obj/item/clothing/accessory/paint/fire
	name = "flames armor paint"
	desc = "A set of paint tones to etch straight heat into a Marine's armor."
	icon_state = "mixtape"
	item_state = "mixtape"

/obj/item/clothing/accessory/paint/sg
	name = "camouflage paint"
	desc = "A set of paints for smartgunners to apply to their harnesses for a darker complextion."
	icon_state = "blacksg"
	item_state = "blacksg"
	slot = ACCESSORY_SLOT_SGPAINT

//===========================//CUSTOM ARMOR WEBBING\\================================\\

/obj/item/clothing/accessory/storage/webbing/m3
	name = "\improper M3 Pattern Webbing"
	desc = "A sturdy mess of synthcotton belts and buckles designed to attach to the M3 Pattern Marine armor standard for the USCMC. This one is the slimmed down model designed for general purpose storage."
	icon_state = "m3webbing"
	hold = /obj/item/storage/internal/accessory/webbing/m3generic
	slot = ACCESSORY_SLOT_M3UTILITY
	flags_atom = NO_SNOW_TYPE

/obj/item/clothing/accessory/storage/webbing/m3/Initialize(mapload)
	. = ..()
	if(!(flags_atom & NO_SNOW_TYPE))
		select_gamemode_skin(type)
	update_icon()


/obj/item/storage/internal/accessory/webbing/m3generic
	cant_hold = list(
		/obj/item/ammo_magazine/handful/shotgun,
		/obj/item/ammo_magazine/rifle,
	)

/obj/item/clothing/accessory/storage/webbing/m3/mag
	name = "\improper M3 Pattern Magazine Webbing"
	desc = "A variant of the M3 Pattern webbing that features pouches for pulse rifle magazines."
	icon_state = "m3webbingmag"
	hold = /obj/item/storage/internal/accessory/webbing/m3mag

/obj/item/storage/internal/accessory/webbing/m3mag
	can_hold = list(
		/obj/item/attachable/bayonet,
		/obj/item/weapon/knife,
		/obj/item/device/flashlight/flare,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/m60,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/handful,
		/obj/item/explosive/grenade,
		/obj/item/explosive/mine,
		/obj/item/reagent_container/food/snacks,
		/obj/item/ammo_magazine/plasma,
	)
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/plasma,
	)

//Partial Pre-load For Props

/obj/item/clothing/accessory/storage/webbing/m3/mag/mk1
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/mk1

/obj/item/storage/internal/accessory/webbing/m3mag/mk1/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)

//===

/obj/item/clothing/accessory/storage/webbing/m3/shotgun
	name = "\improper M3 Pattern Shell Webbing"
	desc = "A slightly modified variant of the M3 Pattern grenade webbing, fitted for 12 gauge shotgun shells."
	icon_state = "m3webbingshotgun"
	hold = /obj/item/storage/internal/accessory/black_vest/m3shotgun

/obj/item/storage/internal/accessory/black_vest/m3shotgun
	can_hold = list(
		/obj/item/ammo_magazine/handful,
	)

/obj/item/clothing/accessory/storage/webbing/m3/small
	name = "\improper M3 Pattern Small Pouch Webbing"
	desc = "A set of M3 pattern webbing fully outfitted with pouches and pockets to carry a whole array of small items."
	icon_state = "m3webbingsmall"
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic
	slot = ACCESSORY_SLOT_M3UTILITY

//Pre-load For Army Props
//===
/obj/item/clothing/accessory/storage/webbing/m3/small/army
	name = "\improper PBAS Webbing"
	desc = "A sturdy set of webbing designed to fit on the US Army's standard body armor system. Fully outfitted with pouches and pockets to carry a whole array of small items."
	icon_state = "armywebbing"
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic/army

/obj/item/storage/internal/accessory/black_vest/m3generic/army/fill_preset_inventory()
	new /obj/item/storage/box/mre(src)
	new /obj/item/reagent_container/food/drinks/flask/canteen(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/tool/shovel/etool(src)

/obj/item/clothing/accessory/storage/webbing/m3/small/army/alt
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic/armyalt

/obj/item/storage/internal/accessory/black_vest/m3generic/armyalt/fill_preset_inventory()
	new /obj/item/storage/box/mre(src)
	new /obj/item/reagent_container/food/drinks/flask/canteen(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/tool/shovel/etool(src)
	new /obj/item/explosive/plastic/breaching_charge(src)

/obj/item/clothing/accessory/storage/webbing/m3/small/army/leader
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic/armyleader

/obj/item/storage/internal/accessory/black_vest/m3generic/armyleader/fill_preset_inventory()
	new /obj/item/storage/box/mre(src)
	new /obj/item/reagent_container/food/drinks/flask/canteen(src)
	new /obj/item/tool/crowbar/tactical(src)
	new /obj/item/tool/shovel/etool(src)
	new /obj/item/device/binoculars/range/designator(src)

//===

/obj/item/clothing/accessory/storage/webbing/m3/m40
	name = "\improper M3 Pattern Grenade Webbing"
	desc = "A variation of the M3 Pattern webbing fitted with loops for storing M40-hull grenades."
	icon_state = "m3webbingm40"
	hold = /obj/item/storage/internal/accessory/black_vest/m3grenade

/obj/item/storage/internal/accessory/black_vest/m3grenade
	storage_slots = 7
	can_hold = list(
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive/super,
		/obj/item/explosive/grenade/high_explosive/airburst/canister,
		/obj/item/explosive/grenade/high_explosive/impact/heap,
		/obj/item/explosive/grenade/high_explosive/impact/tmfrag,
		/obj/item/explosive/grenade/high_explosive/impact/flare,
		/obj/item/explosive/grenade/high_explosive/training,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/smokebomb,
		/obj/item/explosive/grenade/smokebomb/green,
		/obj/item/explosive/grenade/smokebomb/red,
		/obj/item/explosive/grenade/metal_foam,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/slug/baton,
		/obj/item/explosive/grenade/tear/marine,
	)

/obj/item/clothing/accessory/storage/webbing/m3/recon
	name = "\improper M3-R Pattern Magazine Webbing"
	desc = "A set of magazine webbing made in an alternative configuration for standard M3 Pattern armor. This one is exclusively issued to Force Reconnoissance units."
	icon_state = "m3rwebbing"
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/recon

/obj/item/storage/internal/accessory/webbing/m3mag/recon
	storage_slots = 4

//Pre-load For Props
//===
/obj/item/clothing/accessory/storage/webbing/m3/recon/mk1
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/recon/mk1

/obj/item/storage/internal/accessory/webbing/m3mag/recon/mk1/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)

/obj/item/clothing/accessory/storage/webbing/m3/recon/m49
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/recon/m49

/obj/item/storage/internal/accessory/webbing/m3mag/recon/m49/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/m49a/ext(src)
	new /obj/item/ammo_magazine/rifle/m49a/ext(src)
	new /obj/item/ammo_magazine/rifle/m49a/heap(src)
	new /obj/item/ammo_magazine/rifle/m49a/heap(src)
//===

/obj/item/clothing/accessory/storage/webbing/m3/recon/m40
	name = "\improper M3-R Pattern Grenade Webbing"
	desc = "An alternative to the M3-R Pattern webbing fitted to store M40-hull grenades."
	icon_state = "m3rwebbingm40"
	hold = /obj/item/storage/internal/accessory/black_vest/m3grenade/recon

/obj/item/storage/internal/accessory/black_vest/m3grenade/recon
	storage_slots = 10

/obj/item/clothing/accessory/storage/webbing/m3/recon/shotgun
	name = "\improper M3-R Pattern Shell Webbing"
	desc = "A modified variant of the M3-R Pattern grenade webbing for FORECON units, this one accepting 12 gauge."
	icon_state = "m3rwebbingshotgun"
	hold = /obj/item/storage/internal/accessory/black_vest/m3shotgun/recon

/obj/item/storage/internal/accessory/black_vest/m3shotgun/recon
	storage_slots = 7

/obj/item/clothing/accessory/storage/webbing/m3/recon/medic
	name = "\improper M3-R Pattern Corpsman Webbing"
	desc = "A large pouch with M3-R Pattern webbing clips designed to house surgical tools for Corpsmen attached to FORECON units, where field hospitals are not readily available."
	icon_state = "m3rwebbingmedic"
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic/recon

/obj/item/storage/internal/accessory/black_vest/m3generic
	cant_hold = list(
		/obj/item/ammo_magazine/handful/shotgun,
		/obj/item/ammo_magazine/plasma,
	)

/obj/item/storage/internal/accessory/black_vest/m3generic/recon
	storage_slots = 6
	can_hold = list(
		/obj/item/storage/surgical_case/regular,
		/obj/item/reagent_container/blood,
		/obj/item/tool/surgery/surgical_line,
		/obj/item/tool/surgery/synthgraft,
		/obj/item/device/healthanalyzer,
	)

/obj/item/clothing/accessory/storage/webbing/m56
	name = "\improper Clip-on Pouch"
	desc = "A clip on synth-leather pouch designed to house a small collection of items for M56 weapon operators."
	icon_state = "m56pouch"
	hold = /obj/item/storage/internal/accessory/black_vest/m56
	slot = ACCESSORY_SLOT_M56UTILITY

/obj/item/clothing/accessory/storage/webbing/m56/Initialize(mapload)
	. = ..()
	if(!(flags_atom & NO_SNOW_TYPE))
		select_gamemode_skin(type)
	update_icon()

//Pre-load For Props

/obj/item/clothing/accessory/storage/webbing/m56/preset
	hold = /obj/item/storage/internal/accessory/black_vest/m56/preset

/obj/item/storage/internal/accessory/black_vest/m56
	storage_slots = 3

/obj/item/storage/internal/accessory/black_vest/m56/preset/fill_preset_inventory()
	new /obj/item/storage/box/mre(src)
	new /obj/item/tool/shovel/etool/folded(src)
	new /obj/item/reagent_container/food/drinks/flask/canteen(src)

//===

/obj/item/clothing/accessory/storage/webbing/m56/grenade
	name = "\improper Clip-on Grenade Band"
	desc = "A sturdy mess of synth-leather band designed to store a few grenades for M56 weapon operators."
	icon_state = "m56grenade"
	hold = /obj/item/storage/internal/accessory/black_vest/m56/grenade

/obj/item/storage/internal/accessory/black_vest/m56/grenade
	storage_slots = 4
	can_hold = list(
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive/super,
		/obj/item/explosive/grenade/high_explosive/airburst/canister,
		/obj/item/explosive/grenade/high_explosive/impact/heap,
		/obj/item/explosive/grenade/high_explosive/impact/tmfrag,
		/obj/item/explosive/grenade/high_explosive/impact/flare,
		/obj/item/explosive/grenade/high_explosive/training,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/smokebomb,
		/obj/item/explosive/grenade/smokebomb/green,
		/obj/item/explosive/grenade/smokebomb/red,
		/obj/item/explosive/grenade/metal_foam,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/slug/baton,
		/obj/item/explosive/grenade/tear/marine,
	)

//===========================//CUSTOM UPP ARMOR WEBBING\\================================\\

/obj/item/clothing/accessory/storage/webbing/m3/uppmags
	name = "\improper Type 90 Pattern Magazine Webbing"
	desc = "A set of UPP magazine webbing that can carry four magazines."
	icon_state = "upp_webbing_magazine"
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/upp
	flags_atom = NO_SNOW_TYPE
	slot = ACCESSORY_SLOT_M3UTILITY

/obj/item/storage/internal/accessory/webbing/m3mag/upp
	storage_slots = 4
	can_hold = list(
		/obj/item/attachable/bayonet,
		/obj/item/device/flashlight/flare,
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/m60,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/pistol,
		/obj/item/ammo_magazine/revolver,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/handful,
		/obj/item/explosive/grenade,
		/obj/item/explosive/mine,
		/obj/item/reagent_container/food/snacks,
		/obj/item/ammo_magazine/plasma,
	)
	bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/plasma,
	)

/obj/item/clothing/accessory/storage/webbing/m3/uppsmall
	name = "\improper Type 78 Pattern Small Pouch Webbing"
	desc = "A set of UPP webbing fully outfitted with pouches and pockets to carry a while array of small items."
	icon_state = "upp_webbing_small"
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic
	flags_atom = NO_SNOW_TYPE
	slot = ACCESSORY_SLOT_M3UTILITY

/obj/item/clothing/accessory/storage/webbing/m3/uppgeneral
	name = "\improper Type 78 Pattern Webbing"
	desc = "A sturdy mess of synthcotton belts and buckles designed to attach to UPP armor. This one is the slimmed down model designed for general purpose storage."
	icon_state = "upp_webbing_large"
	hold = /obj/item/storage/internal/accessory/webbing/m3generic
	flags_atom = NO_SNOW_TYPE
	slot = ACCESSORY_SLOT_M3UTILITY

//===========================//CUSTOM RMC ARMOR WEBBING\\================================\\

/obj/item/clothing/accessory/storage/webbing/m3/uppsmall/rmc
	name = "\improper 67 Pattern Webbing"
	icon_state = "rmc_webbing_small"
	desc = "A sturdy mess of synthcotton belts and buckles designed to attach to Royal Marine armor. This one is the slimmed down model designed for general purpose storage."

/obj/item/clothing/accessory/storage/webbing/m3/uppmags/rmc
	name = "\improper 82 Pattern Magazine Webbing"
	desc = "A set of webbing pouches that can carry four magazines. Comes with clips to mount to the standard armor system in use by the Royal Marines."
	icon_state = "rmc_webbing_magazine"
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/rmc

/obj/item/storage/internal/accessory/webbing/m3mag/rmc
	storage_slots = 4
	can_hold = list(
		/obj/item/ammo_magazine/rifle/nsg23,
		/obj/item/ammo_magazine/sniper,
		/obj/item/ammo_magazine/pistol/vp78,
		/obj/item/ammo_magazine/pistol/vp70,
		/obj/item/ammo_magazine/smg/m39,
	)

//Partial Pre-load For Props
//===
/obj/item/clothing/accessory/storage/webbing/m3/uppsmall/rmc/preset
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic/rmc

/obj/item/storage/internal/accessory/black_vest/m3generic/rmc/fill_preset_inventory()
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/ammo_magazine/pistol/vp78/rmc(src)
	new /obj/item/clothing/mask/gas/pmc/royal_marine(src)

//===========================// CUSTOM PMC ARMOR PLATES\\================================\\

/obj/item/clothing/accessory/pmcpads
	name = "\improper M4 Shoulder Pads"
	desc = "Attachable supplementary armor for the M4 armor system of Weyland Yutani PMC. Protects from glancing hits and covers the arm opening in the cuirass against shrapnel."
	icon_state = "pmc_arms"
	item_state = "pmc_arms"
	slot = ACCESSORY_SLOT_DECORARMOR

/obj/item/clothing/accessory/pmcpads/bracers
	name = "\improper M4 Vambraces"
	desc = "Attachable supplementary armor for the M4 armor system of Weyland Yutani PMC. A pair of composite ballistic vambraces to shield the forearms, with straps to ensure it doesn't ride up or down."
	icon_state = "pmc_bracers"
	item_state = "pmc_bracers"
	slot = ACCESSORY_SLOT_DECORBRACER

/obj/item/clothing/accessory/pmcpads/neckguard
	name = "\improper PMC Armor Neckerchief"
	desc = "A small neckerchief, for the Weyland Yutani PMC armor. Style is most important thing for contractor."
	icon_state = "pmc_neckerchief"
	item_state = "pmc_neckerchief"
	slot = ACCESSORY_SLOT_DECORNECK

/obj/item/clothing/accessory/pmcpads/greaves
	name = "\improper M4 Greaves"
	desc = "Attachable supplementary armor for the M4 armor system of Weyland Yutani PMC. Lightweight polymer clamshell-style plates enclose the lower legs to provide shrapnel and pistol protection."
	icon_state = "pmc_greaves"
	item_state = "pmc_greaves"
	slot = ACCESSORY_SLOT_DECORSHIN

/obj/item/clothing/accessory/pmcpads/kneepads
	name = "\improper M4 Kneepads"
	desc = "Attachable supplementary armor for the M4 armor system of Weyland Yutani PMC. High impact ruggedized outer shell and polymer internals protect from shrapnel as well as low power ballistics."
	icon_state = "pmc_kneepads"
	item_state = "pmc_kneepads"
	slot = ACCESSORY_SLOT_DECORKNEE

/obj/item/clothing/accessory/pmcpads/crotch
	name = "\improper M4 Lap Panel"
	desc = "Attachable supplementary armor for the M4 armor system of Weyland Yutani PMC. Shear thickening liquid armor piece covering the abdomen and groin, with an additional ruggedized boron carbide strike face for the genitals. Clasps to the inside of the M4 cuirass."
	icon_state = "pmc_crotch"
	item_state = "pmc_crotch"
	slot = ACCESSORY_SLOT_DECORGROIN

//===========================//CUSTOM PMC ARMOR WEBBING\\================================\\

/obj/item/clothing/accessory/storage/webbing/m3/uppsmall/pmc
	name = "\improper 67 Pattern Webbing"
	icon_state = "wy_webbing_small"
	desc = "A sturdy mess of synthcotton belts and buckles designed to attach to Weyland Yutani PMC armor. This one is the slimmed down model designed for general purpose storage of small items."

/obj/item/clothing/accessory/storage/webbing/m3/uppsmall/pmc/presetone
	hold = /obj/item/storage/internal/accessory/black_vest/m3generic/pmc/one

/obj/item/storage/internal/accessory/black_vest/m3generic/pmc/one/fill_preset_inventory()
	new /obj/item/ammo_magazine/pistol/vp78/incendiary(src)
	new /obj/item/ammo_magazine/pistol/vp78/incendiary(src)
	new /obj/item/smartgun_battery(src)

/obj/item/clothing/accessory/storage/webbing/m3/mag/pmc
	name = "\improper 82 Pattern Magazine Webbing"
	desc = "A set of webbing pouches that can carry five magazines. Comes with clips to mount to the standard armor system in use by the Weyland Yutani PMC."
	icon_state = "wy_webbing_magazine"
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/pmc

/obj/item/storage/internal/accessory/webbing/m3mag/pmc
	storage_slots = 5

//Partial Pre-load For Props
//===
/obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/preset
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/upp

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/one/fill_preset_inventory()
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/ap(src)
	new /obj/item/ammo_magazine/smg/m39/ap(src)

/obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presettwo
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/upp

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/two/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)
	new /obj/item/ammo_magazine/rifle/m41aMK1(src)

/obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presetthree
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/upp

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/three/fill_preset_inventory()
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)
	new /obj/item/ammo_magazine/sniper/elite/basic(src)

/obj/item/clothing/accessory/storage/webbing/m3/uppmags/pmc/presetfour
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/upp

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/four/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)
	new /obj/item/ammo_magazine/rifle/nsg23(src)

/obj/item/clothing/accessory/storage/webbing/m3/mag/pmc/presetfive
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/pmc/five

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/five/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/extended(src)
	new /obj/item/ammo_magazine/rifle/extended(src)
	new /obj/item/ammo_magazine/rifle/extended(src)
	new /obj/item/ammo_magazine/rifle/extended(src)
	new /obj/item/ammo_magazine/rifle/extended(src)

/obj/item/clothing/accessory/storage/webbing/m3/mag/pmc/presetsix
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/pmc/six

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/six/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/ap(src)
	new /obj/item/ammo_magazine/rifle/ap(src)
	new /obj/item/ammo_magazine/rifle/ap(src)
	new /obj/item/ammo_magazine/rifle/ap(src)
	new /obj/item/ammo_magazine/rifle/ap(src)

/obj/item/clothing/accessory/storage/webbing/m3/mag/pmc/presetseven
	hold = /obj/item/storage/internal/accessory/webbing/m3mag/pmc/seven

/obj/item/storage/internal/accessory/webbing/m3mag/pmc/seven/fill_preset_inventory()
	new /obj/item/ammo_magazine/rifle/heap(src)
	new /obj/item/ammo_magazine/rifle/heap(src)
	new /obj/item/ammo_magazine/rifle/heap(src)
	new /obj/item/ammo_magazine/rifle/heap(src)
	new /obj/item/ammo_magazine/rifle/heap(src)

/obj/item/clothing/accessory/storage/webbing/m3/recon/shotgun/pmc
	name = "\improper 41 Pattern Shell Webbing"
	desc = "A sturdy mess of synthcotton belts and buckles designed to attach to Weyland Yutani PMC armor. This webbing is fitted for 12 gauge shotgun shells."
	icon_state = "wy_webbing_shotgun"

/obj/item/clothing/accessory/storage/webbing/m3/pmc
	name = "\improper 68 Pattern Webbing"
	desc = "A sturdy mess of synthcotton belts and buckles with 3 large pouches designed to attach to Weyland Yutani PMC armor. This one is designed for general purpose storage of any normal sized item."
	icon_state = "wy_webbing_large"
	hold = /obj/item/storage/internal/accessory/webbing/m3general/pmc

/obj/item/storage/internal/accessory/webbing/m3general/pmc
	storage_slots = 3
	max_w_class = SIZE_MEDIUM
	can_hold = list(
		/obj/item, // First I wanted to make it an smartgun pouch, but why not just make it general storage for any normal size item then?
	)

/obj/item/clothing/accessory/storage/webbing/m3/pmc/synth_preset
	hold = /obj/item/storage/internal/accessory/webbing/m3general/pmc/synth_preset

/obj/item/storage/internal/accessory/webbing/m3general/pmc/synth_preset/fill_preset_inventory()
	new /obj/item/weapon/telebaton(src)
	new /obj/item/tool/crew_monitor/pmc(src)
	new /obj/item/roller/surgical(src)

/obj/item/clothing/accessory/storage/webbing/m3/m40/pmc
	name = "\improper 76 Pattern Grenade Webbing"
	desc = "A sturdy mess of synthcotton belts and buckles designed to attach to Weyland Yutani PMC armor. This webbing is fitted with loops for storing M40-hull grenades."
	icon_state = "wy_webbing_m40"
