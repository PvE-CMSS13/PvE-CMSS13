/datum/paygrade/upp
	name = "UPP Paygrade"
	pay_multiplier = 0.8 //Less than UA forces, but not piddling quantities
	default_faction = FACTION_UPP


//UPP Enlisted

/datum/paygrade/upp/ue1
	paygrade = PAY_SHORT_UE1
	name = "Private"
	prefix = "Pvt."

/datum/paygrade/upp/ue2
	paygrade = PAY_SHORT_UE2
	name = "Senior Private"
	prefix = "SrPvt."
	pay_multiplier = 0.9

/datum/paygrade/upp/ue3
	paygrade = PAY_SHORT_UE3
	name = "Corporal"
	prefix = "Cpl."
	pay_multiplier = 1

/datum/paygrade/upp/ue4
	paygrade = PAY_SHORT_UE4
	name = "Junior Sergeant"
	prefix = "JrSgt."
	pay_multiplier = 1.1

/datum/paygrade/upp/ue5
	paygrade = PAY_SHORT_UE5
	name = "Sergeant"
	prefix = "Sgt."
	pay_multiplier = 1.2

/datum/paygrade/upp/ue6
	paygrade = PAY_SHORT_UE6
	name = "Senior Sergeant"
	prefix = "SrSgt."
	pay_multiplier = 1.4

/datum/paygrade/upp/ue7
	paygrade = PAY_SHORT_UE7
	name = "Sergeant Major"
	prefix = "SgtMaj."
	pay_multiplier = 1.5

//UPP Commandos
/datum/paygrade/upp/uk1
	paygrade = "UK1"
	name = "Junior Kommando"
	prefix = "JKdo."
	pay_multiplier = 1.5

/datum/paygrade/upp/uk2
	paygrade = "UK2"
	name = "2nd Kommando"
	prefix = "2ndKdo."
	pay_multiplier = 2
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uk3
	paygrade = "UK3"
	name = "1st Kommando"
	prefix = "1stKdo."
	pay_multiplier = 2.5
	officer_grade = GRADE_OFFICER

//UPP Officers
/datum/paygrade/upp/uo1
	paygrade = PAY_SHORT_UO1
	name = "Junior Lieutenant"
	prefix = "Jr. Lt."
	pay_multiplier = 1.6
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo2
	paygrade = PAY_SHORT_UO2
	name = "Senior Lieutenant"
	prefix = "Sr. LT."
	pay_multiplier = 1.7
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo3
	paygrade = PAY_SHORT_UO3
	name = "Captain"
	prefix = "Cpt."
	pay_multiplier = 2
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo4
	paygrade = PAY_SHORT_UO4
	name = "Major"
	prefix = "Mjr."
	pay_multiplier = 2.5
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo4p
	paygrade = PAY_SHORT_UO4P
	name = "Political Commissar"
	prefix = "Pol."
	pay_multiplier = 5
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo5
	paygrade = PAY_SHORT_UO5
	name = "Lieutenant Colonel"
	prefix = "Lt. Col."
	pay_multiplier = 3
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo6
	paygrade = PAY_SHORT_UO6
	name = "Colonel"
	prefix = "Col."
	pay_multiplier = 4
	officer_grade = GRADE_OFFICER

/datum/paygrade/upp/uo7
	paygrade = PAY_SHORT_UO7
	name = "Major General"
	prefix = "Maj. Gen."
	pay_multiplier = 5
	officer_grade = GRADE_FLAG

/datum/paygrade/upp/uo8
	paygrade = PAY_SHORT_UO8
	name = "Lieutenant General"
	prefix = "Lt. Gen."
	pay_multiplier = 6
	officer_grade = GRADE_FLAG

/datum/paygrade/upp/uo9
	paygrade = PAY_SHORT_UO9
	name = "Army General"
	prefix = "Gen."
	pay_multiplier = 7
	officer_grade = GRADE_FLAG

//UPP Colonists

/datum/paygrade/upp/militsiya
	paygrade = PAY_SHORT_UC1
	name = "Militsioner"
	prefix = "Milit."
	pay_multiplier = 0.3
