/obj/item/device/radio/headset/almayer/mcom/synth/outpost
	name = "maintenance synth headset"
	desc = "Issued only to USCM maintenance synthetics. Channels are as follows: :v - marine command, :c - copperheads section, :d - rattlesnaeks section, :n - engineering, :m - medbay, :u - requisitions, :j - JTAC"
	icon_state = "ms_headset"
	initial_keys = list(/obj/item/device/encryptionkey/cmpcom/synth/uscm_ground)
	volume = RADIO_VOLUME_CRITICAL
	has_tracker = TRUE
	misc_tracking = TRUE
	has_hud = TRUE
	locate_setting = TRACKER_CO
	frequency = COLONY_FREQ

	inbuilt_tracking_options = list(
		"Outpost Commander" = TRACKER_CO,
		"Outpost Adjutant" = TRACKER_XO,
		"Copperheads Sct. Sergeant" = TRACKER_CSL,
		"Rattlesnakes Sct. Sergeant" = TRACKER_DSL,
		"Landing Zone" = TRACKER_LZ
	)

/obj/item/device/radio/headset/distress/outpost
	name = "outpost headset"
	desc = "A standard headset used by civillians."
	frequency = COLONY_FREQ


/obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground
	name = "marine radio headset"
	desc = "A standard marine radio headset. When worn, grants access to Squad Leader tracker. Click tracker with empty hand to open Squad Info window."
	icon_state = "uscm_headset"
	item_state = "uscm_headset"
	item_icons = list(
		WEAR_L_EAR = 'icons/mob/humans/onmob/ears.dmi',
		WEAR_R_EAR = 'icons/mob/humans/onmob/ears.dmi',
		)
	frequency = ALPHA_FREQ
	has_tracker = TRUE
	misc_tracking = TRUE //Left all the above visible in-case any of it needs changed in the near future
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY)
	initial_keys = list(/obj/item/device/encryptionkey/uscm_ground)

	inbuilt_tracking_options = list(
		"Outpost Commander" = TRACKER_CO,
		"Outpost Adjutant" = TRACKER_XO,
		"Copperheads Sct. Sergeant" = TRACKER_CSL,
		"Rattlesnakes Sct. Sergeant" = TRACKER_DSL,
		"Section Sergeant" = TRACKER_SL,
		"Squad Leader" = TRACKER_FTL,
		"Landing Zone" = TRACKER_LZ
	)

//==============================================================
//SELF SETTING PROC FOR MARINE HEADSETS

/obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground/proc/self_set()
	var/mob/living/carbon/human/H = loc
	if(istype(H, /mob/living/carbon/human))
		if(H.assigned_squad)
			switch(H.assigned_squad.name)
				if(SQUAD_MARINE_3)
					name = "[SQUAD_MARINE_3] section radio headset"
					desc = "This is used by [SQUAD_MARINE_3] section members."
					frequency = CHARLIE_FREQ
				if(SQUAD_MARINE_4)
					name = "[SQUAD_MARINE_4] section radio headset"
					desc = "This is used by [SQUAD_MARINE_4] section members."
					frequency = DELTA_FREQ

			switch(GET_DEFAULT_ROLE(H.job))
				if(JOB_SQUAD_LEADER)
					name = "SNCO " + name
					keys += new /obj/item/device/encryptionkey/uscm_ground/leader/senior(src)
					volume = RADIO_VOLUME_CRITICAL
				if(JOB_SQUAD_MEDIC)
					name = "corpsman " + name
					keys += new /obj/item/device/encryptionkey/uscm_ground/med(src)
				if(JOB_SQUAD_ENGI)
					name = "engineer " + name
					keys += new /obj/item/device/encryptionkey/uscm_ground/engi(src)
				if(JOB_SQUAD_TEAM_LEADER)
					name = "NCO " + name
					keys += new /obj/item/device/encryptionkey/uscm_ground/leader/senior(src)

			set_frequency(frequency)
			for(var/ch_name in channels)
				secure_radio_connections[ch_name] = SSradio.add_object(src, GLOB.radiochannels[ch_name],  RADIO_CHAT)
			recalculateChannels()
			if(H.mind && H.hud_used && H.hud_used.locate_leader) //make SL tracker visible
				H.hud_used.locate_leader.alpha = 255
				H.hud_used.locate_leader.mouse_opacity = MOUSE_OPACITY_ICON

/obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground/copperheads
	name = "copperheads section radio headset"
	frequency = CHARLIE_FREQ

/obj/item/device/radio/headset/almayer/marine/solardevils/uscm_ground/rattlesnakes
	name = "rattlesnakes section radio headset"
	frequency = DELTA_FREQ
