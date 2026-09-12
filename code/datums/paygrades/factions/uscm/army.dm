/datum/paygrade/army
	name = "Army Paygrade"
	rank_pin = /obj/item/clothing/accessory/ranks/army
	pay_multiplier = 1.4	//Army strong, army smash, meatheads get paid a lil' less 'cause they get decent kit
	default_faction = FACTION_ARMY

// ENLISTED PAYGRADES

/datum/paygrade/army/e1
	paygrade = PAY_SHORT_AE1
	name = "Private"
	prefix = "PV1"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e1
	ranking = 0
	pay_multiplier = 1.4

/datum/paygrade/army/e2
	paygrade = PAY_SHORT_AE2
	name = "Private"
	prefix = "PVT"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e2
	ranking = 1
	pay_multiplier = 1.5

/datum/paygrade/army/e3
	paygrade = PAY_SHORT_AE3
	name = "Private First Class"
	prefix = "PFC"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e3
	ranking = 2
	pay_multiplier = 1.6

/datum/paygrade/army/e4
	paygrade = PAY_SHORT_AE4
	name = "Corporal"
	prefix = "CPL"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e4
	ranking = 3
	pay_multiplier = 1.8

/datum/paygrade/army/e4e
	paygrade = PAY_SHORT_AE4E
	name = "Specialist"
	prefix = "SPC"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e4e
	ranking = 4
	pay_multiplier = 1.8

/datum/paygrade/army/e5
	paygrade = PAY_SHORT_AE5
	name = "Sergeant"
	prefix = "SGT"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e5
	ranking = 5
	pay_multiplier = 2

/datum/paygrade/army/e6
	paygrade = PAY_SHORT_AE6
	name = "Staff Sergeant"
	prefix = "SSG"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e6
	ranking = 6
	pay_multiplier = 2.2

/datum/paygrade/army/e7
	paygrade = PAY_SHORT_AE7
	name = "Sergeant First Class"
	prefix = "SFC"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e7
	ranking = 7
	pay_multiplier = 2.4

/datum/paygrade/army/e8
	paygrade = PAY_SHORT_AE8
	name = "Master Sergeant"
	prefix = "MSG"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e8
	ranking = 8
	pay_multiplier = 2.5

/datum/paygrade/army/e8e
	paygrade = PAY_SHORT_AE8E
	name = "First Sergeant"
	prefix = "1SG"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e8e
	ranking = 9
	pay_multiplier = 2.5

/datum/paygrade/army/e9
	paygrade = PAY_SHORT_AE9
	name = "Sergeant Major"
	prefix = "SGM"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e9
	ranking = 10
	pay_multiplier = 2.75

/datum/paygrade/army/e9e
	paygrade = PAY_SHORT_AE9E
	name = "Command Sergeant Major"
	prefix = "CSM"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e9e
	ranking = 11
	pay_multiplier = 2.75

/datum/paygrade/army/e9c
	paygrade = PAY_SHORT_AE9C
	name = "Sergeant Major of the Army"
	prefix = "SMA"
	rank_pin = /obj/item/clothing/accessory/ranks/army/e9c
	ranking = 12
	pay_multiplier = 2.8

// WARRANT OFFICER PAYGRADES

/datum/paygrade/army/w1
	paygrade = PAY_SHORT_AW1
	name = "Warrant Officer"
	prefix = "WO1"
	rank_pin = /obj/item/clothing/accessory/ranks/army/w1
	ranking = 13
	pay_multiplier = 2.4	//Pay on par with E7 to begin with

/datum/paygrade/army/w2
	paygrade = PAY_SHORT_AW2
	name = "Chief Warrant Officer 2"
	prefix = "CW2"
	rank_pin = /obj/item/clothing/accessory/ranks/army/w2
	ranking = 14
	pay_multiplier = 2.5

/datum/paygrade/army/w3
	paygrade = PAY_SHORT_AW3
	name = "Chief Warrant Officer 3"
	prefix = "CW3"
	rank_pin = /obj/item/clothing/accessory/ranks/army/w3
	ranking = 15
	pay_multiplier = 2.7

/datum/paygrade/army/w1
	paygrade = PAY_SHORT_AW4
	name = "Chief Warrant Officer 4"
	prefix = "CW4"
	rank_pin = /obj/item/clothing/accessory/ranks/army/w4
	ranking = 16
	pay_multiplier = 2.9

/datum/paygrade/army/w5
	paygrade = PAY_SHORT_AW5
	name = "Chief Warrant Officer 5"
	prefix = "CW5"
	rank_pin = /obj/item/clothing/accessory/ranks/army/w5
	ranking = 17
	pay_multiplier = 3

// COMMISSIONED PAYGRADES

/datum/paygrade/army/o1
	paygrade = PAY_SHORT_AO1
	name = "Second Lieutenant"
	prefix = "2LT"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o1
	ranking = 18
	pay_multiplier = 3
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o2
	paygrade = PAY_SHORT_AO2
	name = "First Lieutenant"
	prefix = "1LT"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o2
	ranking = 19
	pay_multiplier = 3.1
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o3
	paygrade = PAY_SHORT_AO3
	name = "Captain"
	prefix = "CPT"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o3
	ranking = 20
	pay_multiplier = 3.3
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o4
	paygrade = PAY_SHORT_AO4
	name = "Major"
	prefix = "MAJ"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o4
	ranking = 21
	pay_multiplier = 3.5
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o5
	paygrade = PAY_SHORT_AO5
	name = "Lieutenant Colonel"
	prefix = "LTC"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o5
	ranking = 22
	pay_multiplier = 3.7
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o6
	paygrade = PAY_SHORT_AO6
	name = "Colonel"
	prefix = "COL"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o6
	ranking = 23
	pay_multiplier = 3.9
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o6e
	paygrade = PAY_SHORT_AO6E
	name = "Senior Colonel"
	prefix = "SCL"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o6e
	ranking = 24
	pay_multiplier = 4.2
	officer_grade = GRADE_OFFICER

/datum/paygrade/army/o6c
	paygrade = PAY_SHORT_AO6C
	name = "Division Colonel"
	prefix = "DCL"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o6c
	ranking = 25
	pay_multiplier = 4.5
	officer_grade = GRADE_OFFICER

//High Command
/datum/paygrade/army/o7
	paygrade = PAY_SHORT_AO7
	name = "Brigadier General"
	prefix = "BG"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o7
	ranking = 26
	pay_multiplier = 6
	officer_grade = GRADE_FLAG

/datum/paygrade/army/o8
	paygrade = PAY_SHORT_AO8
	name = "Major General"
	prefix = "MG"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o8
	ranking = 27
	pay_multiplier = 6.1
	officer_grade = GRADE_FLAG

/datum/paygrade/army/o9
	paygrade = PAY_SHORT_AO9
	name = "Lieutenant General"
	prefix = "LTG"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o9
	ranking = 28
	pay_multiplier = 6.2
	officer_grade = GRADE_FLAG

/datum/paygrade/army/o10
	paygrade = PAY_SHORT_AO10
	name = "General"
	prefix = "GEN"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o10
	ranking = 29
	pay_multiplier = 6.5
	officer_grade = GRADE_FLAG

/datum/paygrade/army/o10c
	paygrade = PAY_SHORT_AO10C
	name = "General of the Army"
	prefix = "GEN.A"
	rank_pin = /obj/item/clothing/accessory/ranks/army/o10c
	ranking = 30
	pay_multiplier = 7
	officer_grade = GRADE_FLAG
