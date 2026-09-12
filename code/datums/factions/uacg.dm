/datum/faction/uacg
	name = "United States Colonial Guard"
	faction_tag = FACTION_UACG

/datum/faction/uacg/modify_hud_holder(image/holder, mob/living/carbon/human/H)
	var/hud_icon_state
	var/obj/item/card/id/ID = H.get_idcard()
	var/_role
	if(H.mind)
		_role = H.job
	else if(ID)
		_role = ID.rank
	switch(_role)
		if(JOB_UACG_RIFLE)
			hud_icon_state = "trpr"
		if(JOB_UACG_GNR)
			hud_icon_state = "lmg"
		if(JOB_UACG_DM)
			hud_icon_state = "snpr"
		if(JOB_UACG_SCR_RIFLE)
			hud_icon_state = "trpr"
		if(JOB_UACG_SCR_GNR)
			hud_icon_state = "lmg"
		if(JOB_UACG_MORTAR)
			hud_icon_state = "mortar"
		if(JOB_UACG_TECH)
			hud_icon_state = "cet"
		if(JOB_UACG_ARMORY_LACKEY)
			hud_icon_state = "mt"
		if(JOB_UACG_MEDIC)
			hud_icon_state = "cmt"
		if(JOB_UACG_MEDIC_TRIAGE)
			hud_icon_state = "tmt"
		if(JOB_UACG_LEAD)
			hud_icon_state = "tl"
		if(JOB_UACG_LEAD_FIRE)
			hud_icon_state = "mortartl"
		if(JOB_UACG_LEAD_MED)
			hud_icon_state = "tsl"
		if(JOB_UACG_SENLEAD)
			hud_icon_state = "sl"
		if(JOB_UACG_CHAPLAIN)
			hud_icon_state = "chp"
		if(JOB_UACG_OFFICER)
			hud_icon_state = "co"
		if(JOB_UACG_MESS)
			hud_icon_state = "mess"
		if(JOB_UACG_DOCTOR)
			hud_icon_state = "doc"
		if(JOB_UACG_ARMORY)
			hud_icon_state = "qm"
	if(hud_icon_state)
		holder.overlays += image('icons/mob/hud/marine_hud.dmi', H, "army_[hud_icon_state]")

	var/datum/squad/squad = H.assigned_squad
	if(istype(squad, /datum/squad/marine/uacg))
		var/squad_clr = H.assigned_squad.equipment_color
		switch(GET_DEFAULT_ROLE(_role))
			if(JOB_UACG_RIFLE) hud_icon_state = "trpr"
			if(JOB_UACG_DM) hud_icon_state = "snpr"
			if(JOB_UACG_MEDIC) hud_icon_state = "med"
			if(JOB_UACG_TECH) hud_icon_state = "engi"
			if(JOB_UACG_GNR) hud_icon_state = "lmg"
			if(JOB_UACG_LEAD) hud_icon_state = "tl"
			if(JOB_UACG_SENLEAD) hud_icon_state = "sl"
		if(squad.fireteam_leaders["SQ1"] == H || squad.fireteam_leaders["SQ2"] == H || squad.fireteam_leaders["SQ3"] == H || squad.fireteam_leaders["SQ4"] == H)
			H.langchat_styles = "langchat_smaller_bolded"
		else
			H.langchat_styles = initial(H.langchat_styles)
		H.langchat_color = H.assigned_squad.chat_color

		if(!hud_icon_state) hud_icon_state = H.rank_fallback
		if(hud_icon_state)
			var/image/IMG = image('icons/mob/hud/marine_hud.dmi', H, "army")
			if(squad_clr)
				IMG.color = squad_clr
			else
				IMG.color = "#5A934A"
			holder.overlays += IMG
			holder.overlays += image('icons/mob/hud/marine_hud.dmi', H, "army_[hud_icon_state]")
		if(H.assigned_squad && H.assigned_fireteam)
			var/image/IMG2 = image('icons/mob/hud/marine_hud.dmi', H, "army_[H.assigned_fireteam]")
			IMG2.color = squad_clr
			holder.overlays += IMG2
			if(H.assigned_squad.fireteam_leaders[H.assigned_fireteam] == H)
				var/image/IMG3 = image('icons/mob/hud/marine_hud.dmi', H, "hudsquad_ftl")
				IMG3.color = squad_clr
				holder.overlays += IMG3
