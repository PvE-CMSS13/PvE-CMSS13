/mob/living/simple_animal/lizard
	name = "Lizard"
	desc = "A cute tiny lizard."
	icon = 'icons/mob/critter.dmi'
	icon_state = "lizard"
	icon_living = "lizard"
	icon_dead = "lizard-dead"
	mob_size = MOB_SIZE_SMALL
	speak_emote = list("hisses")
	health = 5
	maxHealth = 5
	attacktext = "bites"
	attacktext = "bites"
	melee_damage_lower = 1
	melee_damage_upper = 2
	response_help  = "pets"
	response_disarm = "shoos"
	response_harm   = "stomps on"
	black_market_value = 50
	dead_black_market_value = 0
	squeeze_under = TRUE

/mob/living/simple_animal/lizard/lexi
	name = "Lexi"
	desc = "The Apostay's pet, and a reminder of W-Y's wealth. A tiny lizard that, a few years ago, had one leg replaced with a delicate-looking prosthetic after an illness. If they can splurge this hard on your company pet, what can they give you? Will probably outlive your natural lifespan."
	icon_state = "lexi"
	icon_living = "lexi"
