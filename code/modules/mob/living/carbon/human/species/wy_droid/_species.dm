// Synth used for W-Y Deathsquads
/datum/species/synthetic/colonial/wy_droid
	name = SYNTH_COMBAT
	name_plural = "WY Combat Androids"
	uses_skin_color = FALSE
	special_body_types = FALSE
	mob_inherent_traits = list(TRAIT_SUPER_STRONG, TRAIT_EMOTE_CD_EXEMPT, TRAIT_UNSTRIPPABLE) //No IRON_TEETH because they have no teeth (literally)

	burn_mod = 0.6 //made for combat
	total_health = 250 //made for combat

	hair_color = "#000000"
	icobase = 'icons/mob/humans/species/r_wy_combat_android.dmi'
	deform = 'icons/mob/humans/species/r_wy_combat_android.dmi'

	knock_down_reduction = 5
	stun_reduction = 5
	weed_slowdown_mult = 0 // no slowdown!

/datum/species/synthetic/colonial/wy_droid/handle_death(mob/living/carbon/human/dying_droid)
	playsound(get_turf(dying_droid),"wy_droid_death", 25, FALSE)

/datum/species/synthetic/colonial/wy_droid/handle_on_fire(humanoidmob)
	. = ..()
	INVOKE_ASYNC(humanoidmob, TYPE_PROC_REF(/mob, emote), "pain")

/datum/species/synthetic/colonial/wy_droid/cloaker
	name = "W-Y Combat Android Cloaker"

/datum/species/synthetic/colonial/wy_droid/cloaker/handle_death(mob/living/carbon/human/dying_droid)
	playsound(get_turf(dying_droid),"wy_droid_cloaker_death", 25, FALSE)

/datum/species/synthetic/colonial/wy_droid/non_deathsquad
	name = "W-Y Combat Android (Weaker)"
	burn_mod = 0.8
	brute_mod = 0.8
	total_health = 150

/datum/species/synthetic/colonial/wy_droid/cloaker/non_deathsquad
	name = "W-Y Combat Android Cloaker (Weaker)"
	burn_mod = 0.8
	brute_mod = 0.8
	total_health = 150
