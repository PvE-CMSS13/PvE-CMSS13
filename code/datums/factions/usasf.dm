/datum/faction/navy
	name = "United States AeroSpace Force"
	faction_tag = FACTION_NAVY

/datum/faction/navy/modify_hud_holder(image/holder, mob/living/carbon/human/H)
	var/hud_icon_state
	var/obj/item/card/id/ID = H.get_idcard()
	var/_role
	if(H.mind)
		_role = H.job
	else if(ID)
		_role = ID.rank
	switch(_role)
		if(JOB_NAVY_CREWMAN)
			hud_icon_state = "crew"
		if(JOB_NAVY_MP)
			hud_icon_state = "mp"
		if(JOB_NAVY_SF)
			hud_icon_state = "sf"
		if(JOB_NAVY_SFL)
			hud_icon_state = "sfl"
		if(JOB_NAVY_MEDIC)
			hud_icon_state = "doc"
		if(JOB_NAVY_ENGI)
			hud_icon_state = "mt"
		if(JOB_NAVY_SKITTLE)
			hud_icon_state = "skittle"
		if(JOB_NAVY_JTAC)
			hud_icon_state = "jfo"
		if(JOB_NAVY_PARA_TECH)
			hud_icon_state = "parat"
		if(JOB_NAVY_PARA_MED)
			hud_icon_state = "param"
		if(JOB_NAVY_PARA_LEAD)
			hud_icon_state = "paral"
		if(JOB_NAVY_SYNTH)
			hud_icon_state = "syn"
		if(JOB_NAVY_PILOT)
			hud_icon_state = "pilot"
		if(JOB_NAVY_CHIEF_ENGINEER)
			hud_icon_state = "ce"
		if(JOB_NAVY_FLIGHT_BOSS)
			hud_icon_state = "prifly"
		if(JOB_NAVY_SO)
			hud_icon_state = "so"
		if(JOB_NAVY_CO)
			hud_icon_state = "co"
	if(hud_icon_state)
		holder.overlays += image('icons/mob/hud/marine_hud.dmi', H, "navy_[hud_icon_state]")
