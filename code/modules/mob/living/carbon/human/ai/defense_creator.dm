/datum/human_defense_creator_menu
	var/static/list/lazy_defense_dict = list()
	var/static/list/lazy_ui_data = list()

/datum/human_defense_creator_menu/New()
	if(!length(lazy_ui_data))
		for(var/datum/human_ai_defense/defense_type as anything in subtypesof(/datum/human_ai_defense))
			if(!defense_type::name)
				continue

			if(!lazy_ui_data[defense_type::category])
				lazy_ui_data[defense_type::category] = list()

			lazy_ui_data[defense_type::category] += list(list(
				"name" = defense_type::name,
				"path" = defense_type,
				"description" = defense_type::desc,
				"image" = defense_type::icon_state,
				"uses_faction" = defense_type::uses_faction,
				"uses_turned_on" = defense_type::uses_turned_on,
			))

/datum/human_defense_creator_menu/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HumanDefenseManager")
		ui.open()

/datum/human_defense_creator_menu/ui_state(mob/user)
	return GLOB.admin_state

/datum/human_defense_creator_menu/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/defense_menu),
	)

/datum/human_defense_creator_menu/ui_data(mob/user)
	var/list/data = list()

	return data

/datum/human_defense_creator_menu/ui_static_data(mob/user)
	var/list/data = list()

	data["defenses"] = lazy_ui_data
	data["valid_factions"] = list(FACTION_MARINE, FACTION_UA_REBEL, FACTION_UPP, FACTION_CANC, FACTION_WY, FACTION_FREELANCER, FACTION_TWE, FACTION_TWE_REBEL, FACTION_MERCENARY)

	return data

/datum/human_defense_creator_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("create_defense")
			if(!params["path"])
				return

			var/gotten_path = params["path"]
			if(!gotten_path)
				return

			if(!lazy_defense_dict[gotten_path])
				lazy_defense_dict[gotten_path] = new gotten_path()

			var/direction = ui.user.dir
			switch(params["place_dir"])
				if("North")
					direction = NORTH
				if("East")
					direction = EAST
				if("South")
					direction = SOUTH
				if("West")
					direction = WEST

			var/datum/human_ai_defense/defense_object = lazy_defense_dict[gotten_path]
			defense_object.spawn_object(get_turf(ui.user), direction, params["faction"], params["turned_on"])
			return TRUE

/client/proc/open_human_defense_creator_panel()
	set name = "Human Defense Creator Panel"
	set category = "Game Master.HumanAI"

	if(!check_rights(R_DEBUG))
		return

	if(human_defense_menu)
		human_defense_menu.tgui_interact(mob)
		return

	human_defense_menu = new /datum/human_defense_creator_menu(src)
	human_defense_menu.tgui_interact(mob)

/datum/human_ai_defense
	var/name = ""
	var/desc = ""
	var/category = "default"
	var/icon = 'icons/misc/human_defense_menu.dmi'
	var/icon_state
	var/uses_faction = TRUE
	var/uses_turned_on = TRUE
	var/path_to_spawn

/datum/human_ai_defense/proc/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	return

// Sentries

/datum/human_ai_defense/defense/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	var/obj/structure/machinery/defenses/defense = new path_to_spawn(loc_to_spawn)
	defense.setDir(dir_to_spawn)
	defense.placed = TRUE
	if(turned_on)
		defense.power_on()
	else
		defense.power_off()
	if(faction)
		defense.handle_iff(faction)

/datum/human_ai_defense/defense/sentry
	category = "Sentries"

/datum/human_ai_defense/defense/sentry/uscm
	name = "USCM Sentry"
	desc = /obj/structure/machinery/defenses/sentry::desc
	icon_state = "uscm_sentry"
	path_to_spawn = /obj/structure/machinery/defenses/sentry

/datum/human_ai_defense/defense/sentry/uscm/static_gun
	name = "USCM Sentry - Static"
	desc = /obj/structure/machinery/defenses/sentry/premade/deployable/almayer::desc
	path_to_spawn = /obj/structure/machinery/defenses/sentry/premade/deployable/almayer

/datum/human_ai_defense/defense/sentry/uscm/dmr
	name = "USCM Sentry - DMR"
	desc = /obj/structure/machinery/defenses/sentry/dmr::desc
	icon_state = "uscm_sentry_dmr"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/dmr

/datum/human_ai_defense/defense/sentry/uscm/shotgun
	name = "USCM Sentry - Shotgun"
	desc = /obj/structure/machinery/defenses/sentry/shotgun::desc
	icon_state = "uscm_sentry_shotgun"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/shotgun

/datum/human_ai_defense/defense/sentry/uscm/mini
	name = "USCM Sentry - Mini"
	desc = /obj/structure/machinery/defenses/sentry/mini::desc
	icon_state = "uscm_sentry_mini"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/mini

/datum/human_ai_defense/defense/sentry/uscm/flamer
	name = "USCM Sentry - Flamer"
	desc = /obj/structure/machinery/defenses/sentry/flamer::desc
	icon_state = "uscm_flamer"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/flamer

/datum/human_ai_defense/defense/sentry/uscm/flamer/mini
	name = "USCM Sentry - Mini Flamer"
	desc = /obj/structure/machinery/defenses/sentry/flamer/mini::desc
	icon_state = "uscm_flamer_mini"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/flamer/mini

/datum/human_ai_defense/defense/sentry/upp
	name = "UPP Sentry"
	desc = /obj/structure/machinery/defenses/sentry/upp::desc
	icon_state = "upp_sentry"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/upp

/datum/human_ai_defense/defense/sentry/upp/light
	name = "UPP Sentry - Light"
	desc = /obj/structure/machinery/defenses/sentry/upp/light::desc
	icon_state = "upp_sentry_light"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/upp/light

/datum/human_ai_defense/defense/sentry/upp/flamer
	name = "UPP Sentry - Flamer"
	desc = /obj/structure/machinery/defenses/sentry/flamer/upp::desc
	icon_state = "upp_flamer"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/flamer/upp

/datum/human_ai_defense/defense/sentry/wy
	name = "W-Y Sentry"
	desc = /obj/structure/machinery/defenses/sentry/wy::desc
	icon_state = "wy_sentry"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/wy

/datum/human_ai_defense/defense/sentry/wy/flamer
	name = "W-Y Sentry - Flamer"
	desc = /obj/structure/machinery/defenses/sentry/flamer/wy::desc
	icon_state = "wy_flamer"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/flamer/wy

/datum/human_ai_defense/defense/sentry/wy/static_gun
	name = "W-Y Sentry - Static"
	icon_state = "wy_sentry_static"

/datum/human_ai_defense/defense/sentry/wy/mini
	name = "W-Y Sentry - Mini Sentry"
	desc = /obj/structure/machinery/defenses/sentry/mini/wy::desc
	icon_state = "wy_sentry_mini"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/mini/wy

/datum/human_ai_defense/defense/sentry/wy/heavy
	name = "W-Y Sentry - Heavy"
	desc = /obj/structure/machinery/defenses/sentry/dmr/wy::desc
	icon_state = "wy_sentry_heavy"
	path_to_spawn = /obj/structure/machinery/defenses/sentry/dmr/wy

// Bell towers

/datum/human_ai_defense/defense/bell_tower
	name = "USCM Bell Tower"
	desc = /obj/structure/machinery/defenses/bell_tower::desc
	icon_state = "uscm_belltower"
	category = "Bell Towers"
	path_to_spawn = /obj/structure/machinery/defenses/bell_tower

/datum/human_ai_defense/defense/bell_tower/cloaked
	name = "USCM Bell Tower - Cloaked"
	desc = /obj/structure/machinery/defenses/bell_tower/cloaker::desc
	icon_state = "uscm_belltower_cloak"
	path_to_spawn = /obj/structure/machinery/defenses/bell_tower/cloaker

/datum/human_ai_defense/defense/bell_tower/md
	name = "USCM Bell Tower - MD"
	desc = /obj/structure/machinery/defenses/bell_tower/md::desc
	icon_state = "uscm_belltower_md"
	path_to_spawn = /obj/structure/machinery/defenses/bell_tower/md

// Flags

/datum/human_ai_defense/defense/flag
	category = "Planted Flags"

/datum/human_ai_defense/defense/flag/uscm
	name = "USCM Planted Flag"
	desc = /obj/structure/machinery/defenses/planted_flag::desc
	icon_state = "uscm_flag"
	path_to_spawn = /obj/structure/machinery/defenses/planted_flag

/datum/human_ai_defense/defense/flag/uscm/range
	name = "USCM Planted Flag - Range+"
	desc = /obj/structure/machinery/defenses/planted_flag/range::desc
	icon_state = "uscm_flag_range"
	path_to_spawn = /obj/structure/machinery/defenses/planted_flag/range

/datum/human_ai_defense/defense/flag/uscm/warbanner
	name = "USCM Planted Flag - Warbanner"
	desc = /obj/structure/machinery/defenses/planted_flag/warbanner::desc
	icon_state = "uscm_flag_warbanner"
	path_to_spawn = /obj/structure/machinery/defenses/planted_flag/warbanner

/datum/human_ai_defense/defense/flag/upp
	name = "UPP Planted Flag"
	desc = /obj/structure/machinery/defenses/planted_flag/upp::desc
	icon_state = "upp_flag"
	path_to_spawn = /obj/structure/machinery/defenses/planted_flag/upp

/datum/human_ai_defense/defense/flag/wy
	name = "W-Y Planted Flag"
	desc = /obj/structure/machinery/defenses/planted_flag/wy::desc
	icon_state = "wy_flag"
	path_to_spawn = /obj/structure/machinery/defenses/planted_flag/wy

// Teslas

/datum/human_ai_defense/defense/tesla
	name = "USCM Tesla Coil"
	desc = /obj/structure/machinery/defenses/tesla_coil::desc
	icon_state = "uscm_tesla"
	category = "Tesla Coils"
	path_to_spawn = /obj/structure/machinery/defenses/tesla_coil

/datum/human_ai_defense/defense/tesla/stun
	name = "USCM Tesla Coil - Overclocked"
	desc = /obj/structure/machinery/defenses/tesla_coil/stun::desc
	icon_state = "uscm_tesla_stun"
	path_to_spawn = /obj/structure/machinery/defenses/tesla_coil/stun

/datum/human_ai_defense/defense/tesla/micro
	name = "USCM Tesla Coil - Micro"
	desc = /obj/structure/machinery/defenses/tesla_coil/micro::desc
	icon_state = "uscm_tesla_micro"
	path_to_spawn = /obj/structure/machinery/defenses/tesla_coil/micro

// Mines

/datum/human_ai_defense/mine
	uses_turned_on = FALSE
	category = "Landmines"

/datum/human_ai_defense/mine/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	var/obj/item/explosive/mine/defense = new path_to_spawn(loc_to_spawn)
	defense.setDir(dir_to_spawn)
	if(faction)
		defense.iff_signal = faction

/datum/human_ai_defense/mine/claymore
	name = "Claymore"
	desc = /obj/item/explosive/mine/active::desc
	icon_state = "claymore"
	path_to_spawn = /obj/item/explosive/mine/active

/datum/human_ai_defense/mine/claymore/wy
	name = "Claymore - WY"
	desc = /obj/item/explosive/mine/pmc/active::desc
	icon_state = "claymore_wy"
	path_to_spawn = /obj/item/explosive/mine/pmc/active

/datum/human_ai_defense/mine/sebb
	name = "G2 Electroshock"
	desc = /obj/item/explosive/mine/sebb/active::desc
	icon_state = "sebb"
	path_to_spawn = /obj/item/explosive/mine/sebb/active

// Barricades

/datum/human_ai_defense/barricade
	uses_turned_on = FALSE
	uses_faction = FALSE
	category = "Barricades"

/datum/human_ai_defense/barricade/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	var/obj/structure/barricade/defense = new path_to_spawn(loc_to_spawn)
	defense.setDir(dir_to_spawn)

/datum/human_ai_defense/barricade/wooden
	name = "Wooden Barricade"
	desc = /obj/structure/barricade/wooden::desc
	icon_state = "wooden"
	path_to_spawn = /obj/structure/barricade/wooden

/datum/human_ai_defense/barricade/metal
	name = "Metal Barricade"
	desc = /obj/structure/barricade/metal::desc
	icon_state = "metal"
	path_to_spawn = /obj/structure/barricade/metal

/datum/human_ai_defense/barricade/metal/wired
	name = "Metal Barricade - Wired"
	desc = /obj/structure/barricade/metal/wired::desc
	icon_state = "metal_wired"
	path_to_spawn = /obj/structure/barricade/metal/wired

/datum/human_ai_defense/barricade/sandbag
	name = "Sandbags"
	desc = /obj/structure/barricade/sandbags/full::desc
	icon_state = "sandbag"
	path_to_spawn = /obj/structure/barricade/sandbags/full

/datum/human_ai_defense/barricade/plasteel_folding
	name = "Plasteel Folding Barricade"
	desc = /obj/structure/barricade/plasteel::desc
	icon_state = "plasteel_folding"
	path_to_spawn = /obj/structure/barricade/plasteel

/datum/human_ai_defense/barricade/plasteel_folding/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	var/obj/structure/barricade/plasteel/defense = new path_to_spawn(loc_to_spawn)
	defense.setDir(dir_to_spawn)
	defense.open() // closes it

/datum/human_ai_defense/barricade/plasteel_folding/wired
	name = "Plasteel Folding Barricade - Wired"
	desc = /obj/structure/barricade/plasteel/wired::desc
	icon_state = "plasteel_folding_wired"
	path_to_spawn = /obj/structure/barricade/plasteel/wired

/datum/human_ai_defense/barricade/metal_folding
	name = "Metal Folding Barricade"
	desc = /obj/structure/barricade/plasteel/metal::desc
	icon_state = "metal_folding"
	path_to_spawn =/obj/structure/barricade/plasteel/metal

/datum/human_ai_defense/barricade/metal_folding/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	var/obj/structure/barricade/plasteel/metal/defense = new path_to_spawn(loc_to_spawn)
	defense.setDir(dir_to_spawn)
	defense.open() // closes it

/datum/human_ai_defense/barricade/metal_folding/wired
	name = "Metal Folding Barricade - Wired"
	desc = /obj/structure/barricade/plasteel/metal/wired::desc
	icon_state = "metal_folding_wired"
	path_to_spawn = /obj/structure/barricade/plasteel/metal/wired

/datum/human_ai_defense/barricade/wooden
	name = "Wooden Barricade"
	desc = /obj/structure/barricade/wooden::desc
	icon_state = "wooden"
	path_to_spawn = /obj/structure/barricade/wooden

/datum/human_ai_defense/barricade/snow
	name = "Snow Barricade"
	desc = /obj/structure/barricade/snow::desc
	icon_state = "snow"
	path_to_spawn = /obj/structure/barricade/snow

/datum/human_ai_defense/barricade/plasteel
	name = "Plasteel Barricade"
	desc = /obj/structure/barricade/metal/plasteel::desc
	icon_state = "plasteel"
	path_to_spawn = /obj/structure/barricade/metal/plasteel

/datum/human_ai_defense/barricade/plasteel/wired
	name = "Plasteel Barricade - Wired"
	desc = /obj/structure/barricade/metal/plasteel/wired::desc
	icon_state = "plasteel_wired"
	path_to_spawn = /obj/structure/barricade/metal/plasteel/wired

/datum/human_ai_defense/barricade/deployable
	name = "Portable Barricade"
	desc = /obj/structure/barricade/deployable::desc
	icon_state = "folding_0"
	path_to_spawn = /obj/structure/barricade/deployable

/datum/human_ai_defense/misc_defences
	uses_turned_on = FALSE
	uses_faction = FALSE
	category = "Miscellaneous Defenses"

/datum/human_ai_defense/misc_defences/spawn_object(turf/loc_to_spawn, dir_to_spawn, faction, turned_on)
	var/obj/structure/barricade/defense = new path_to_spawn(loc_to_spawn)
	defense.setDir(dir_to_spawn)

/datum/human_ai_defense/misc_defences/barrier
	name = "Deployable Barrier"
	desc = /obj/structure/machinery/deployable/barrier::desc
	icon_state = "barrier0"
	path_to_spawn = /obj/structure/machinery/deployable/barrier

/datum/human_ai_defense/misc_defences/table
	name = "Table Barricade"
	desc = /obj/structure/barricade/table::desc
	icon_state = "metalflip"
	path_to_spawn = /obj/structure/barricade/table

/datum/human_ai_defense/misc_defences/table/wood
	name = "Wooden Table Barricade"
	desc = /obj/structure/barricade/table/wood::desc
	icon_state = "woodflip"
	path_to_spawn = /obj/structure/barricade/table/wood

/datum/human_ai_defense/misc_defences/table/poor
	name = "Poor Table Barricade"
	desc = /obj/structure/barricade/table/wood/poor::desc
	icon_state = "pwoodflip"
	path_to_spawn = /obj/structure/barricade/table/wood/poor

/datum/human_ai_defense/misc_defences/table/gambling
	name = "Gambling Table Barricade"
	desc = /obj/structure/barricade/table/wood/gambling::desc
	icon_state = "gameflip"
	path_to_spawn = /obj/structure/barricade/table/wood/gambling

/datum/human_ai_defense/misc_defences/table/reinforced
	name = "Reinforced Table Barricade"
	desc = /obj/structure/barricade/table/reinforced::desc
	icon_state = "reinfflip"
	path_to_spawn = /obj/structure/barricade/table/reinforced

/datum/human_ai_defense/misc_defences/table/almayer
	name = "Almayer Table Barricade"
	desc = /obj/structure/barricade/table/almayer::desc
	icon_state = "almflip"
	path_to_spawn = /obj/structure/barricade/table/almayer

/datum/human_ai_defense/misc_defences/table/prison
	name = "Prison Table Barricade"
	desc = /obj/structure/barricade/table/prison::desc
	icon_state = "prisonflip"
	path_to_spawn = /obj/structure/barricade/table/prison

/datum/human_ai_defense/misc_defences/razorwire
	name = "Razorwire"
	desc = /obj/structure/barricade/razorwire::desc
	icon_state = "barbed_wire"
	path_to_spawn = /obj/structure/barricade/razorwire
