//Typechecks should be AVOIDED whenever possible. Instead of using them, try properties of what you're checking, such as the flags of clothing.

/*
* I don't know why these were checking for A?: since if ishuman(A) is TRUE, then A MUST exist, unless it's just a path.
* And I do wish more of these procs would read the above the comment. Avoid type checking, especially
* if procs calling the define already checks for type before calling. Cleaned these up just a bit.
* TODO: Get rid of ishuman(A) checks from all applicable. Clean this up even more.
*/
#define ishuman(A) (istype(A, /mob/living/carbon/human) )

//Check if the mob is an actual human (and not Yautja or Synth)
#define ishuman_strict(A) (ishuman(A) && istype(A:species, /datum/species/human))

//Check if the mob is an actual human or Synth
#define ishumansynth_strict(A)   (ishuman(A) && (istype(A:species, /datum/species/human) || A:species:flags & IS_SYNTHETIC))

#define iszombie(A) (ishuman(A) && istype(A:species, /datum/species/zombie))
#define ismonkey(A) (ishuman(A) && istype(A:species, /datum/species/monkey))
#define isyautja(A) (ishuman(A) && istype(A:species, /datum/species/yautja))
#define isresearcher(A) (ishuman(A) && A.job == "Researcher")
#define isSEA(A) (ishuman(A) && A.job == "Senior Enlisted Advisor")
#define issynth(A) (ishuman(A) && A:species:flags & IS_SYNTHETIC)
#define iscolonysynthetic(A) (ishuman(A) && istype(A:species, /datum/species/synthetic/colonial))
#define isworkingjoe(A) (iscolonysynthetic(A) && A.job == JOB_WORKING_JOE)
#define isinfiltratorsynthetic(A) (ishuman(A) && HAS_TRAIT(A, TRAIT_INFILTRATOR_SYNTH))

//Specic group checks, use instead of typechecks (but use traits instead)
#define issamespecies(A, B) (A.species?.group == B.species?.group)
#define isspecieshuman(A) (A.species?.group == SPECIES_HUMAN)
#define isspeciesmonkey(A) (A.species?.group == SPECIES_MONKEY)
#define isspeciesyautja(A) (A.species?.group == SPECIES_YAUTJA)
#define isspeciessynth(A) (A.species?.group == SPECIES_SYNTHETIC)

//Size checks for carbon to use instead of typechecks. (Hellhounds are deprecated)
#define iscarbonsizexeno(A) (A.mob_size >= MOB_SIZE_XENO_VERY_SMALL)
#define iscarbonsizehuman(A) (A.mob_size <= MOB_SIZE_HUMAN)

//job/role helpers
#define ismarinejob(J) (istype(J, /datum/job/marine))
#define issurvivorjob(J) (J == JOB_SURVIVOR)
