/obj/item/prop
	name = "prop"
	desc = "Some kind of prop."

/// A prop that acts as a replacement for another item, mimicking their looks.
/// Mainly used in Reqs Tutorial to provide the full item selections without side effects.
/obj/item/prop/replacer
	/// The type that this object is taking the place of
	var/original_type

/obj/item/prop/replacer/Initialize(mapload, obj/original_type)
	if(!original_type)
		return INITIALIZE_HINT_QDEL
	. = ..()
	src.original_type = original_type
	var/obj/created_type = new original_type // Instancing this for the sake of assigning its appearance to the prop and nothing else
	name = initial(original_type.name)
	icon = initial(original_type.icon)
	icon_state = initial(original_type.icon_state)
	desc = initial(original_type.desc)
	if(ispath(original_type, /obj/item))
		var/obj/item/item_type = original_type
		item_state = initial(item_type.item_state)

	appearance = created_type.appearance
	qdel(created_type)

/obj/item/prop/laz_top
	name = "lazertop"
	icon = 'icons/obj/structures/props/server_equipment.dmi'
	icon_state = "laptop-gun"
	item_state = ""
	desc = "A Rexim RXF-M5 EVA pistol compressed down into a laptop! Also known as the Laz-top. Part of a line of discreet assassination weapons developed for Greater Argentina and the United States covert programs respectively."
	w_class = SIZE_SMALL
	garbage = TRUE

/obj/item/prop/geiger_counter
	name = "geiger counter"
	desc = "A geiger counter measures the radiation it receives. This type automatically records and transfers any information it reads, provided it has a battery, with no user input required beyond being enabled."
	icon = 'icons/obj/items/devices.dmi'
	icon_state = "geiger"
	item_state = ""
	w_class = SIZE_SMALL
	flags_equip_slot = SLOT_WAIST
	///Whether the geiger counter is on or off
	var/toggled_on = FALSE
	///Iconstate of geiger counter when on
	var/enabled_state = "geiger_on"
	///Iconstate of geiger counter when off
	var/disabled_state = "geiger"
	///New battery it will spawn with
	var/starting_battery = /obj/item/cell/crap
	///Battery inside geiger counter
	var/obj/item/cell/battery //It doesn't drain the battery, but it has a battery for emergency use

/obj/item/prop/geiger_counter/Initialize(mapload, ...)
	. = ..()
	if(!starting_battery)
		return
	battery = new starting_battery(src)

/obj/item/prop/geiger_counter/Destroy()
	. = ..()
	if(battery)
		qdel(battery)

/obj/item/prop/geiger_counter/attack_self(mob/user)
	. = ..()
	toggled_on = !toggled_on
	if(!battery)
		to_chat(user, SPAN_NOTICE("[src] is missing a battery."))
		return
	to_chat(user, SPAN_NOTICE("You [toggled_on ? "enable" : "disable"] [src]."))
	update_icon()

/obj/item/prop/geiger_counter/attackby(obj/item/attacking_item, mob/user)
	. = ..()
	if(!HAS_TRAIT(attacking_item, TRAIT_TOOL_SCREWDRIVER) && !HAS_TRAIT(attacking_item, TRAIT_TOOL_CROWBAR))
		return

	if(!battery)
		to_chat(user, SPAN_NOTICE("There is no battery for you to remove."))
		return
	to_chat(user, SPAN_NOTICE("You jam [battery] out of [src] with [attacking_item], prying it out irreversibly."))
	user.put_in_hands(battery)
	battery = null
	update_icon()

/obj/item/prop/geiger_counter/update_icon()
	. = ..()

	if(battery && toggled_on)
		icon_state = enabled_state
		return
	icon_state = disabled_state

/obj/item/prop/tableflag
	name = "United Americas table flag"
	icon = 'icons/obj/items/items.dmi'
	icon_state = "uaflag"
	force = 0.5
	w_class = SIZE_SMALL
	desc = "A miniature table flag of the United Americas, representing all of North, South, and Central America."

/obj/item/prop/tableflag/uscm
	name = "USCM table flag"
	icon_state = "uscmflag"
	desc = "A miniature table flag of the United States Colonial Marines. 'Semper Fi' is written on the flag's bottom."

/obj/item/prop/tableflag/uscm2
	name = "USCM historical table flag"
	icon_state = "uscmflag2"
	desc = "A miniature historical table flag of the United States Colonial Marines, in traditional scarlet and gold. The USCM logo sits in the center; an eagle is perched atop it and an anchor rests behind it."

/obj/item/prop/tableflag/upp
	name = "UPP table flag"
	icon_state = "uppflag"
	desc = "A miniature table flag of the Union of Progressive Peoples, consisting of 17 yellow stars, surrounding the bigger one in the middle on scarlet field."

/obj/item/prop/flower_vase
	name = "flower vase"
	icon_state = "flowervase"
	w_class = SIZE_SMALL
	desc = "An empty glass flower vase."

/obj/item/prop/flower_vase/bluewhiteflowers
	name = "vase of blue and white flowers"
	icon_state = "bluewhiteflowers"
	desc = "A flower vase filled with blue and white roses."

/obj/item/prop/flower_vase/redwhiteflowers
	name = "vase of red and white flowers"
	icon_state = "redwhiteflowers"
	desc = "A flower vase filled with red and white roses."

/obj/item/prop/colony/usedbandage
	name = "dirty bandages"
	desc = "Some used gauze."
	icon_state = "bandages_prop"
	icon = 'icons/monkey_icos.dmi'
	w_class = SIZE_TINY

/obj/item/prop/colony/folded_bedroll
	name = "folded bedroll"
	desc = "a folded up bedroll"
	icon_state = "bedroll"
	icon = 'icons/monkey_icos.dmi'

/obj/item/prop/colony/used_flare
	name = "flare"
	desc = "A used USCM issued flare. There are instructions on the side, it reads 'pull cord, make light'."
	icon_state = "flare-empty"
	icon = 'icons/obj/items/lighting.dmi'

/obj/item/prop/colony/canister
	name = "fuel can"
	desc = "A jerry can. In space! Or maybe a colony."
	icon_state = "canister"
	icon = 'icons/obj/items/tank.dmi'

/obj/item/prop/colony/proptag
	name = "information dog tag"
	desc = "A fallen marine's information dog tag. It reads,(BLANK)"
	icon_state = "dogtag_taken"
	icon = 'icons/obj/items/card.dmi'

/obj/item/prop/colony/game
	name = "portable game kit"
	desc = "A ThinkPad Systems Game-Bro Handheld (TSGBH, shortened). It can play chess, checkers, tri-d chess, and it also runs Byond! Except this one is out of batteries."
	icon_state = "game_kit"
	icon = 'icons/obj/items/items.dmi'

/obj/item/prop/gripper
	name = "magnetic gripper"
	desc = "A simple grasping tool for synthetic assets."
	icon_state = "gripper"
	icon = 'icons/obj/items/devices.dmi'

/obj/item/prop/matter_decompiler
	name = "matter decompiler"
	desc = "Eating trash, bits of glass, or other debris will replenish your stores."
	icon_state = "decompiler"
	icon = 'icons/obj/items/devices.dmi'

/// Xeno-specific props

/obj/item/prop/alien/hugger
	name = "????"
	desc = "It has some sort of a tube at the end of its tail. What the hell is this thing?"
	icon = 'icons/mob/xenos/effects.dmi'
	icon_state = "facehugger_impregnated"

//-----USS Almayer Props -----//
//Put any props that don't function properly, they could function in the future but for now are for looks. This system could be expanded for other maps too. ~Art

/obj/item/prop/almayer
	name = "GENERIC USS ALMAYER PROP"
	desc = "THIS SHOULDN'T BE VISIBLE, IF YOU SEE THIS THERE IS A PROBLEM IN THE PROP.DM FILE MAKE A BUG REPORT "
	icon = 'icons/obj/structures/props/almayer_props.dmi'
	icon_state = "hangarbox"

/obj/item/prop/almayer/box
	name = "metal crate"
	desc = "A metal crate used often for storing small electronics that go into dropships"
	icon_state = "hangarbox"
	w_class = SIZE_LARGE

/obj/item/prop/almayer/flight_recorder
	name = "\improper FR-112 flight recorder"
	desc = "A small red box that contains flight data from a dropship while it's on mission. Usually referred to as the black box, although this one comes in bloody red."
	icon_state = "flight_recorder"
	w_class = SIZE_MEDIUM

/obj/item/prop/almayer/flight_recorder/colony
	name = "\improper CIR-60 colony information recorder"
	desc = "A small red box that records colony announcements, colonist flatlines and other key readouts. Usually refered to the black box, although this one comes in bloody red."
	icon_state = "flight_recorder"

/obj/item/prop/almayer/flare_launcher
	name = "\improper MJU-77/C case"
	desc = "A flare launcher that usually gets mounted onto dropships to help survivability against infrared tracking missiles."
	icon_state = "flare_launcher"
	w_class = SIZE_SMALL

/obj/item/prop/almayer/chaff_launcher
	name = "\improper RR-247 Chaff case"
	desc = "A chaff launcher that usually gets mounted onto dropships to help survivability against radar tracking missiles."
	icon_state = "chaff_launcher"
	w_class = SIZE_MEDIUM

/obj/item/prop/almayer/handheld1
	name = "small handheld"
	desc = "A small piece of electronic doodads"
	icon_state = "handheld1"
	w_class = SIZE_SMALL

/obj/item/prop/almayer/comp_closed
	name = "dropship maintenance computer"
	desc = "A closed dropship maintenance computer that technicians and pilots use to find out what's wrong with a dropship. It has various outlets for different systems."
	icon_state = "hangar_comp"
	w_class = SIZE_LARGE

/obj/item/prop/almayer/comp_open
	name = "dropship maintenance computer"
	desc = "An opened dropship maintenance computer, it seems to be off however. It's used by technicians and pilots to find damaged or broken systems on a dropship. It has various outlets for different systems."
	icon_state = "hangar_comp_open"
	w_class = SIZE_LARGE

//lore fluff books and magazines

/obj/item/prop/magazine
	name = "generic prop magazine"
	desc = "A Magazine with a picture of a pretty girl on it..wait isn't that my mom?"
	icon = 'icons/obj/structures/props/posters.dmi'
	icon_state = "poster15"
	throw_speed = SPEED_FAST
	throw_range = 5
	w_class = SIZE_TINY
	attack_verb = list("bashed", "whacked", "educated")
	pickup_sound = "sound/handling/book_pickup.ogg"
	drop_sound = "sound/handling/book_pickup.ogg"
	black_market_value = 15

//random magazines
/obj/item/prop/magazine/dirty
	name = "Dirty Magazine"
	desc = "Wawaweewa."
	icon_state = "poster17"

/obj/item/prop/magazine/dirty/torn
	name = "\improper torn magazine page"
	desc = "Hubba hubba."

/obj/item/prop/magazine/dirty/torn/alt
	icon_state = "poster3"

/obj/item/prop/magazine/dropship
	name = "Aerospace International Magazine: Issue August 2181"
	desc = "A pretty cut and dry magazine about various aerospace craft that have just been put into service across multiple sectors. This one's got an article about the Three World Empire's latest acquisition."
	desc_lore = "DAA.4 'Nimrod' dropship <BR> <BR> Dropship, Aerospace Assault mk.4 <BR> <BR> Purchased in limited numbers by the RMC, the Cheyenne (or 'Nimrod' as it was designated in TWE service) was extensively modified by the Augusta-Westland corporation before entering field trials, the twin F29-L-13 turbines being replaced with quad Rolls Royce RBZ.435 linear aerospikes. An extensive system of thrust-vectoring units improves manoeuvrability; handling is crisp in forward axes up to Mach 1.4 and below Mach 2.7 it remains agile. <BR> <BR> This, and a general mass reduction to accommodate the doctrinal emphasis on rapid force staging, has left the DAA.4 without the heavy weapons load as seen on the Cheyenne. <BR> <BR> While a sensor profile reduction effort has seen the Nimrod become significantly stealthier than the UD-4, in heavily defended AORs it regularly equips a large fitting of the Fencer TSAM for self protection. The rotary autocannon is retained."
	icon_state = "poster26"

//books
/obj/item/prop/magazine/book
	name = "book"
	desc = "A generic hardcore novel. Really boring. Probably. Too bored to read."
	icon = 'icons/obj/items/books.dmi'
	icon_state = "book_blue"

/obj/item/prop/magazine/book/spacebeast
	name = "\improper Space Beast, by Robert Morse"
	desc = "An autobiography focusing on the events of 'Fury 161' in August 2179 following the arrival of 'Ellen Ripley' and an unknown alien creature known as 'The Dragon' the books writing is extremely crude and was book banned shorty after publication."

/obj/item/prop/magazine/book/borntokill
	name = "\improper Born to Kill"
	desc = "An autobiography penned by Derik A.W. Tomahawk it recounts his service in the USCM. The book was harshly criticised for its bland and uncreative writing and wasn't well received by the general public or members of the UA military. However, artificial soldiers typically value the information contained within."

/obj/item/prop/magazine/book/bladerunner
	name = "\improper Bladerunner: A True Detectives Story"
	desc = "In the dark undercity of Luna 2119, blade runner Richard Ford is called out of retirement to terminate a cult of replicants who have escaped Earth seeking the meaning of their existence."

/obj/item/prop/magazine/book/starshiptroopers
	name = "Starship Troopers"
	desc = "Written by Robert A. Heinlein, this book really missed the mark when it comes to the individual equipment it depicts 'troopers' having, but it's still issued to every marine in basic so it must have some value."

/obj/item/prop/magazine/book/theartofwar
	name = "The Art of War"
	desc = "A treatise on war written by Sun Tzu a great general, strategist, and philosopher from ancient Earth. This book is on the Commandant of the United States Colonial Marine Corps reading list and most officers can be found in possession of a copy. Most officers who've read it claim to know a little bit more about fighting than most enlisted but results may vary. "

/obj/item/prop/magazine/book/uppbooklet
	name = "\improper The People's Handbook"
	desc = "A booklet provided to the broad citizenry of the Union of Progressive Peoples. The first page is stamped with the Union Roundel and a dedication to the unity of its' member states and the collective working class under the State Councils' guidance. While an easily digestible summary of the collective ideology of the Union, the booklet also provides a succinct description of the UPP's history and summaries of its' member states, alongside various universal laws. Because of this, it is commonly distributed to new citizens upon entry into the UPP."
	icon_state = "book_upp"

/obj/item/prop/magazine/book/warisaracket
	name = "War is a Racket"
	desc = "A book critical of the United States Marine Corps by Marine Corps legend, Major General Smedley Butler. In short, the book outlines the function which the historical Marine Corps had in establishing and enforcing American global hegemony. Good thing its critiques have no contemporary application. Right?"

/obj/item/prop/magazine/book/littleredbook
	name = "Quotations from Chairman Mao Tse-tung"
	desc = "A tiny red book that fits in the palm of your hand. While not required reading, it provides the reader with easy access to- as the name implies- Quotations from Chairman Mao Tse-tung."
	icon_state = "littleredbook"

/obj/item/prop/magazine/book/communistmanifesto
	name = "Communist Manifesto"
	desc = "The bare minimum in communist reading."

/obj/item/prop/magazine/book/inframaterialism
	name = "A Brief Look at Infra-Materialism"
	desc = "A concise introduction to the esoteric communist theory of infra-materialism by Ignus Nilsen."

/obj/item/prop/magazine/sof
	name = "Soldier Of Fortune: Issue..."
	icon_state = "poster8"
	desc = "A copy of Soldier of Fortune magazine. It's been damaged with water. Damn."

/obj/item/prop/magazine/sof/n2182
	name = "Soldier Of Fortune: Issue March 2182"
	icon_state = "poster8"
	desc = "A copy of Soldier of Fortune magazine. On the cover is a stylized image of the M314 Motion Tracker in use, with the headline '22nd Century Battlespace Awareness'. The article covers advancements in ground sensor and countermeasure technologies for the modern army. Also on the cover, 'Exclusive: SOF Looks At The M41AE2' and 'The Future War: Advancements In Cyberdyne Systems Combat AI'. At the back of the magazine is an extensive pamphlet of advertisements for contractors and combat equipment."

/obj/item/prop/magazine/sof/n2181
	name = "Soldier Of Fortune: Issue December 2181"
	icon_state = "poster21"
	desc = "A copy of Soldier of Fortune magazine. On the cover is photo of a Marine in full MOPP gear, with the headline 'War At The Limits: Contaminated Combat Operations'. The main article discusses fighting in contaminated environments, spotlighting the changes made by the Marine 70 program. Secondary on the cover is 'Exclusive: SOF Fires XM99 Phased Plasma Rifle', and 'Remembering Tannhauser'. At the back of the magazine is an extensive pamphlet of advertisements for contractors and combat equipment."

/obj/item/prop/magazine/playboy
	name = "Playboy: Issue..."
	icon_state = "poster3"
	desc = "A copy of Playboy magazine. It's been damaged with water. Damn."

/obj/item/prop/magazine/playboy/n2182
	name = "Playboy Magazine: Issue March 2182"
	icon_state = "poster3"
	desc = "A copy of Playboy magazine. On the cover is photo of guitarist Sadie Summers, with the headline 'Sadie Summers tells ALL'. The article itself focuses on Sadie's many carnal exploits while on tour as well as her very public brawl at an LA nightclub that occured two years prior to the date of this issue. Flipping through the magazine you see article titles such as 'Jungle Mercenary: Life as an Ex-UPP commando' and 'The whys and hows of choosing synthetic girls'."

//boots magazine
/obj/item/prop/magazine/boots
	name = "generic Boots! magazine"
	desc = "The only official USCM magazine!"

/obj/item/prop/magazine/boots/n054
	name = "Boots!: Issue No.54, ARMAT Strikes Back"
	desc = "This edition's about the old lawsuit over the M41A being billed as being self-cleaning, supposedly. Specifically, ARMAT's response to the allegations."

/obj/item/prop/magazine/boots/n055
	name = "Boots!: Issue No.55, Veteran Pilot Tips"
	desc = "The subtitle reads 'TEN tips to keep your UD4 cockpit both safer and more relaxing.' Flipping through it quickly, most are baloney. The rest of the issue isn't that interesting either, except for a neat M3 Armor trick for improved comfort."

/obj/item/prop/magazine/boots/n056
	name = "Boots!: Issue No.56, Smart Smartgunning"
	desc = "This issue is somewhat infamous. Unfortunately, it's one of the reprints, which have had the offending 'Pancake Scandal' pages removed and replaced with an advisory for smartgun care."

/obj/item/prop/magazine/boots/n067
	name = "Boots!: Issue No.67, Make The Best Of It"
	desc= "Number 57's one of the issues where the Marine Corps really laid it on a little too thick. It's completely filled with advice on how to make the best of situations on the Frontier."

/obj/item/prop/magazine/boots/n117
	name = "Boots!: Issue No.117, STOP CANNING"
	desc = "A rapidly printed issue in the wake of the canning incident, with several pages dedicated to the dangers of marines throwing CN-20 Nerve Gas into bathrooms as a prank. It lists some other alternatives, which are all for wimps."

/obj/item/prop/magazine/boots/n150
	name = "Boots!: Issue No.150, UPP Rations, The Truth"
	desc = "The short paragraph further explains UPP field rations aren't standardized and are produced at a local level. Because of this, captured and confiscated UPP rations have included some odd choices such as duck liver, century eggs, lutefisk, pickled pig snout, canned tripe, and dehydrated candied radish snacks."

/obj/item/prop/magazine/boots/n160
	name = "Boots!: Issue No.160, Corporate Liason, Ten Years On"
	desc = "Featuring an interview with a Weyland Yutani corporate liason, after ten years with a marine unit. An insert features a redeemable survey card for... a fifty dollar MCX gift card."

/obj/item/prop/scrap
	name = "scrap metal"
	icon = 'icons/obj/items/fishing_atoms.dmi'
	icon_state = "sheet-scrap"
	item_state = ""
	desc = "A rusty piece of scrap metal."
	w_class = SIZE_SMALL

/obj/item/prop/rock
	name = "rock"
	icon = 'icons/obj/items/plush.dmi'
	icon_state = "rock"
	item_state = ""
	force = 30
	throwforce = 25
	desc = "The most ancient of tools."
	w_class = SIZE_TINY
	hitsound = 'sound/weapons/genhit3.ogg'

/obj/item/prop/deviltrap
	name = "devil trap"
	icon = 'icons/obj/items/misc.dmi'
	icon_state = "deviltrap"
	item_state = ""
	force = 0.5
	throwforce = 0.5
	desc = "An object crafted out of branches, twigs, and twine rope that seem to form a miniature pyramid. It leaves you with an ominous feeling."
	w_class = SIZE_LARGE


// Massive Digger by dimdimich1996

/obj/structure/prop/invuln/dense/excavator
	name = "Model 30 Light Excavator"
	desc = "Weyland-Yutani Corporation's Model 30 Light Excavator. Despite looking like a massive beast, the Model 30 is fairly light when compared to other W-Y terraforming excavators. It's designed to be able to be disassembled for transport and re-assembled on site. This one is a nice orange color."
	icon = 'icons/obj/structures/props/digger.dmi'
	icon_state = "digger_orange"
	layer = BIG_XENO_LAYER

/obj/structure/prop/invuln/dense/excavator/gray
	desc = "Weyland-Yutani Corporation's Model 30 Light Excavator. Despite looking like a massive beast, the Model 30 is fairly light when compared to other W-Y terraforming excavators. It's designed to be able to be disassembled for transport and re-assembled on site. This one is a nice gray color."
	icon_state = "digger_gray"

/obj/structure/prop/invuln/dense/excavator/Initialize()
	. = ..()
	if(dir & (SOUTH|NORTH))
		bound_height = 192
		bound_width = 96
	else
		bound_height = 96
		bound_width = 192

/obj/structure/prop/invuln/dense/cliff_wall
	name = "Cliff Wall"
	desc = "Massive cliff wall, seems impassable."
	icon = 'icons/obj/structures/props/natural/huge_canyon.dmi'
	icon_state = "canyon_wall"
	layer = OBJ_LAYER

/obj/structure/prop/invuln/dense/cliff_wall/alt
	icon_state = "canyon_wall_alt"

/obj/structure/prop/invuln/dense/cliff_wall/short
	icon_state = "canyon_wall_short"

/obj/structure/prop/invuln/dense/cliff_wall/short_alt
	icon_state = "canyon_wall_short_alt"

/obj/structure/prop/invuln/dense/cliff_wall/left_long
	icon_state = "canyon_wall_long_left"

/obj/structure/prop/invuln/dense/cliff_wall/left_short
	icon_state = "canyon_wall_short_left"

/obj/structure/prop/invuln/dense/cliff_wall/right_long
	icon_state = "canyon_wall_long_right"

/obj/structure/prop/invuln/dense/cliff_wall/right_short
	icon_state = "canyon_wall_short_right"

/obj/structure/prop/invuln/dense/cliff_wall/colorable
	icon = 'icons/obj/structures/props/natural/huge_canyon_colorable.dmi'
	icon_state = "canyon_wall"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/alt
	icon_state = "canyon_wall_alt"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/short
	icon_state = "canyon_wall_short"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/short_alt
	icon_state = "canyon_wall_short_alt"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/left_long
	icon_state = "canyon_wall_long_left"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/left_short
	icon_state = "canyon_wall_short_left"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/right_long
	icon_state = "canyon_wall_long_right"

/obj/structure/prop/invuln/dense/cliff_wall/colorable/right_short
	icon_state = "canyon_wall_short_right"

// Fake railings

/obj/structure/prop/fake/railing
	name = "handrail"
	desc = "A railing, for your hands. Woooow."
	icon = 'icons/obj/structures/handrail.dmi'
	icon_state = "handrail_strata"
	unslashable = TRUE
	unacidable = TRUE
	explo_proof = FALSE

/obj/structure/prop/fake/railing/update_icon()
	overlays.Cut()
	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
		if(NORTH)
			layer = initial(layer) - 0.01
		else
			layer = initial(layer)

/obj/structure/prop/fake/railing/strata
	icon_state = "handrail_strata"
