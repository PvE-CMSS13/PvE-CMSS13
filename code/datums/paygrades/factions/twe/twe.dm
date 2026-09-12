/datum/paygrade/twe
	name = "TWE Paygrade"
	pay_multiplier = 2 // less people = more to pay them
	rank_pin = /obj/item/clothing/accessory/ranks/rmc
	default_faction = FACTION_TWE

//RMC Emlisted
/datum/paygrade/twe/e1
	paygrade = PAY_SHORT_RMC1
	name = "Marine"
	prefix = "Mne"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e1

/datum/paygrade/twe/e2
	paygrade = PAY_SHORT_RMC2
	name = "Lance Corporal"
	prefix = "LCpl"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e2
	pay_multiplier = 2.1

/datum/paygrade/twe/e2n //RMC medics are attached naval personnel, don't see them forgoing this tradition even in the aliens universe
	paygrade = PAY_SHORT_RMC2N
	name = "Medical Assistant"
	prefix = "MA"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e2n
	pay_multiplier = 2.2

/datum/paygrade/twe/e2e //RMC gets combat engineering support from the army royal engineers, as above, don't see them changing that tradition
	paygrade = PAY_SHORT_RMC2E
	name = "Sapper"
	prefix = "Spr"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e2e
	pay_multiplier = 2

/datum/paygrade/twe/e2g //RMC also gets indirect fire support from the army royal artillery. Again, don't see them changing that tradition
	paygrade = PAY_SHORT_RMC2G
	name = "Lance Bombardier"
	prefix = "LBDR"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e2g
	pay_multiplier = 2

/datum/paygrade/twe/e3
	paygrade = PAY_SHORT_RMC3
	name = "Corporal"
	prefix = "Cpl"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e3
	pay_multiplier = 2.2

/datum/paygrade/twe/e4
	paygrade = PAY_SHORT_RMC4
	name = "Sergeant"
	prefix = "Sgt"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e4
	pay_multiplier = 2.3

/datum/paygrade/twe/e5
	paygrade = PAY_SHORT_RMC5
	name = "Colour Sergeant"
	prefix = "CSgt"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/e5
	pay_multiplier = 2.4

//RMC Warrant Officer - Different from US ones, equiv to US E8 & E9 technical & command track ranks for the brits
/datum/paygrade/twe/wo1
	paygrade = PAY_SHORT_RMOW
	name = "Warrant Officer"
	prefix = "WO"
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/wo
	pay_multiplier = 3.5

//RMC Officers
/datum/paygrade/twe/o1
	paygrade = PAY_SHORT_RMO1
	name = "Second Lieutenant"
	prefix = "2nd LT"
	pay_multiplier = 3
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o1
	officer_grade = GRADE_OFFICER

/datum/paygrade/twe/o2
	paygrade = PAY_SHORT_RMO2
	name = "Lieutenant"
	prefix = "LT"
	pay_multiplier = 3.25
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o2
	officer_grade = GRADE_OFFICER

/datum/paygrade/twe/o3
	paygrade = PAY_SHORT_RMO3
	name = "Captain"
	prefix = "Capt"
	pay_multiplier = 3.5
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o3
	officer_grade = GRADE_OFFICER

/datum/paygrade/twe/o4
	paygrade = PAY_SHORT_RMO4
	name = "Major"
	prefix = "Maj"
	pay_multiplier = 5
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o4
	officer_grade = GRADE_OFFICER

/datum/paygrade/twe/o5
	paygrade = PAY_SHORT_RMO5
	name = "Lieutenant Colonel"
	prefix = "Lt Col"
	pay_multiplier = 7
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o5
	officer_grade = GRADE_OFFICER

/datum/paygrade/twe/o6
	paygrade = PAY_SHORT_RMO6
	name = "Colonel"
	prefix = "Col"
	pay_multiplier = 9
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o6
	officer_grade = GRADE_FLAG

/datum/paygrade/twe/o7
	paygrade = PAY_SHORT_RMO7
	name = "Brigadier"
	prefix = "Brig"
	pay_multiplier = 10
	rank_pin = /obj/item/clothing/accessory/ranks/rmc/o7
	officer_grade = GRADE_FLAG
