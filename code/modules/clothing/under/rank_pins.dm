//ranks
/obj/item/clothing/accessory/ranks
	name = "rank pins"
	gender = PLURAL
	desc = "A set of rank pins, used to denote the paygrade of someone within the military."
	icon_state = "ranks_enlisted"
	var/rank = "Private"
	var/rank_short = PAY_SHORT_ME1
	slot = ACCESSORY_SLOT_RANK
	high_visibility = TRUE
	gender = PLURAL
	jumpsuit_hide_states = UNIFORM_JACKET_REMOVED

/obj/item/clothing/accessory/ranks/New()
	..()
	name = "[initial(name)] ([rank_short])"
	desc = "[initial(desc)] This one is for the rank <b>[get_paygrades(rank_short)]</b>."

/*################################################
################ MARINE  ###################
################################################*/
//ENLISTED
/obj/item/clothing/accessory/ranks/marine/e1

/obj/item/clothing/accessory/ranks/marine/e2
	rank_short = PAY_SHORT_ME2

/obj/item/clothing/accessory/ranks/marine/e3
	rank_short = PAY_SHORT_ME3

/obj/item/clothing/accessory/ranks/marine/e4
	rank_short = PAY_SHORT_ME4
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/marine/e5
	rank_short = PAY_SHORT_ME5
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/marine/e6
	rank_short = PAY_SHORT_ME6
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/marine/e7
	rank_short = PAY_SHORT_ME7
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/marine/e8
	rank_short = PAY_SHORT_ME8
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/marine/e8e
	rank_short = PAY_SHORT_ME8E
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/marine/e9
	rank_short = PAY_SHORT_ME9
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/marine/e9e
	rank_short = PAY_SHORT_ME9E
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/marine/e9c
	rank_short = PAY_SHORT_ME9C
	icon_state = "ranks_snco"

//WARRANT OFFICERS
/obj/item/clothing/accessory/ranks/marine/w1
	name = "rank boards"
	rank_short = PAY_SHORT_MW1
	icon_state = "ranks_juniorwarrant"

/obj/item/clothing/accessory/ranks/marine/w2
	name = "rank boards"
	rank_short = PAY_SHORT_MW2
	icon_state = "ranks_juniorwarrant"

/obj/item/clothing/accessory/ranks/marine/w3
	name = "rank boards"
	rank_short = PAY_SHORT_MW3
	icon_state = "ranks_warrant"

/obj/item/clothing/accessory/ranks/marine/w4
	name = "rank boards"
	rank_short = PAY_SHORT_MW4
	icon_state = "ranks_warrant"

/obj/item/clothing/accessory/ranks/marine/w5
	name = "rank boards"
	rank_short = PAY_SHORT_MW5
	icon_state = "ranks_seniorwarrant"

//OFFICERS
/obj/item/clothing/accessory/ranks/marine/o1
	rank_short = PAY_SHORT_MO1
	icon_state = "ranks_o1"

/obj/item/clothing/accessory/ranks/marine/o2
	rank_short = PAY_SHORT_MO2
	icon_state = "ranks_o2"

/obj/item/clothing/accessory/ranks/marine/o3
	rank_short = PAY_SHORT_MO3
	icon_state = "ranks_o3"

/obj/item/clothing/accessory/ranks/marine/o4
	name = "rank boards"
	rank_short = PAY_SHORT_MO4
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/marine/o5
	name = "rank boards"
	rank_short = PAY_SHORT_MO5
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/marine/o6
	name = "rank boards"
	rank_short = PAY_SHORT_MO6
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/marine/o6e
	name = "rank boards"
	rank_short = PAY_SHORT_MO6E
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/marine/o6c
	name = "rank boards"
	rank_short = PAY_SHORT_MO6C
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/marine/o7
	name = "rank boards"
	rank_short = PAY_SHORT_MO7
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/marine/o8
	name = "rank boards"
	rank_short = PAY_SHORT_MO8
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/marine/o9
	name = "rank boards"
	rank_short = PAY_SHORT_MO9
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/marine/o10
	name = "rank boards"
	rank_short = PAY_SHORT_MO10
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/marine/o10c
	name = "rank boards"
	rank_short = PAY_SHORT_MO10C
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/marine/o10s
	name = "rank boards"
	rank_short = PAY_SHORT_MO10S
	icon_state = "ranks_flagofficer"

/*################################################
################ NAVY  #####################
################################################*/
//ENLISTED
/obj/item/clothing/accessory/ranks/navy/e1
	rank_short = PAY_SHORT_NE1

/obj/item/clothing/accessory/ranks/navy/e2
	rank_short = PAY_SHORT_NE2

/obj/item/clothing/accessory/ranks/navy/e3
	rank_short = PAY_SHORT_NE3

/obj/item/clothing/accessory/ranks/navy/e4
	rank_short = PAY_SHORT_NE4
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/navy/e5
	rank_short = PAY_SHORT_NE5
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/navy/e6
	rank_short = PAY_SHORT_NE6
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/navy/e7
	rank_short = PAY_SHORT_NE7
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/navy/e8
	rank_short = PAY_SHORT_NE8
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/navy/e8c
	rank_short = PAY_SHORT_NE8C
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/navy/e9
	rank_short = PAY_SHORT_NE9
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/navy/e9c
	rank_short = PAY_SHORT_NE9C
	icon_state = "ranks_snco"

//WARRANT OFFICERS
/obj/item/clothing/accessory/ranks/navy/w1
	name = "rank boards"
	rank_short = PAY_SHORT_NW1
	icon_state = "ranks_juniorwarrant"

/obj/item/clothing/accessory/ranks/navy/w2
	name = "rank boards"
	rank_short = PAY_SHORT_NW2
	icon_state = "ranks_juniorwarrant"

/obj/item/clothing/accessory/ranks/navy/w3
	name = "rank boards"
	rank_short = PAY_SHORT_NW3
	icon_state = "ranks_warrant"

/obj/item/clothing/accessory/ranks/navy/w4
	name = "rank boards"
	rank_short = PAY_SHORT_NW4
	icon_state = "ranks_warrant"

/obj/item/clothing/accessory/ranks/navy/w5
	name = "rank boards"
	rank_short = PAY_SHORT_NW5
	icon_state = "ranks_seniorwarrant"

//OFFICERS
/obj/item/clothing/accessory/ranks/navy/o1
	name = "rank boards"
	rank_short = PAY_SHORT_NO1
	icon_state = "ranks_officer"

/obj/item/clothing/accessory/ranks/navy/o2
	name = "rank boards"
	rank_short = PAY_SHORT_NO2
	icon_state = "ranks_officer"

/obj/item/clothing/accessory/ranks/navy/o3
	name = "rank boards"
	rank_short = PAY_SHORT_NO3
	icon_state = "ranks_officer"

/obj/item/clothing/accessory/ranks/navy/o4
	name = "rank boards"
	rank_short = PAY_SHORT_NO4
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/navy/o5
	name = "rank boards"
	rank_short = PAY_SHORT_NO5
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/navy/o6
	name = "rank boards"
	rank_short = PAY_SHORT_NO6
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/navy/o6e
	name = "rank boards"
	rank_short = PAY_SHORT_NO6E
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/navy/o6c
	name = "rank boards"
	rank_short = PAY_SHORT_NO6C
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/navy/o7
	name = "rank boards"
	rank_short = PAY_SHORT_NO7
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/navy/o8
	name = "rank boards"
	rank_short = PAY_SHORT_NO8
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/navy/o9
	name = "rank boards"
	rank_short = PAY_SHORT_NO9
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/navy/o10
	name = "rank boards"
	rank_short = PAY_SHORT_NO10
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/navy/o10c
	name = "rank boards"
	rank_short = PAY_SHORT_NO10C
	icon_state = "ranks_flagofficer"

/*################################################
################ ARMY  #####################
################################################*/
//ENLISTED
/obj/item/clothing/accessory/ranks/army/e1
	rank_short = PAY_SHORT_AE1

/obj/item/clothing/accessory/ranks/army/e2
	rank_short = PAY_SHORT_AE2

/obj/item/clothing/accessory/ranks/army/e3
	rank_short = PAY_SHORT_AE3

/obj/item/clothing/accessory/ranks/army/e4
	rank_short = PAY_SHORT_AE4
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/army/e4e
	rank_short = PAY_SHORT_AE4E
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/army/e5
	rank_short = PAY_SHORT_AE5
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/army/e6
	rank_short = PAY_SHORT_AE6
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/army/e7
	rank_short = PAY_SHORT_AE7
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/army/e8
	rank_short = PAY_SHORT_AE8
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/army/e8e
	rank_short = PAY_SHORT_AE8E
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/army/e9
	rank_short = PAY_SHORT_AE9
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/army/e9e
	rank_short = PAY_SHORT_AE9E
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/army/e9c
	rank_short = PAY_SHORT_AE9C
	icon_state = "ranks_snco"

//WARRANT OFFICERS
/obj/item/clothing/accessory/ranks/army/w1
	name = "rank boards"
	rank_short = PAY_SHORT_AW1
	icon_state = "ranks_juniorwarrant"

/obj/item/clothing/accessory/ranks/army/w2
	name = "rank boards"
	rank_short = PAY_SHORT_AW2
	icon_state = "ranks_juniorwarrant"

/obj/item/clothing/accessory/ranks/army/w3
	name = "rank boards"
	rank_short = PAY_SHORT_AW3
	icon_state = "ranks_warrant"

/obj/item/clothing/accessory/ranks/army/w4
	name = "rank boards"
	rank_short = PAY_SHORT_AW4
	icon_state = "ranks_warrant"

/obj/item/clothing/accessory/ranks/army/w5
	name = "rank boards"
	rank_short = PAY_SHORT_AW5
	icon_state = "ranks_seniorwarrant"

//OFFICERS
/obj/item/clothing/accessory/ranks/army/o1
	name = "rank boards"
	rank_short = PAY_SHORT_AO1
	icon_state = "ranks_officer"

/obj/item/clothing/accessory/ranks/army/o2
	name = "rank boards"
	rank_short = PAY_SHORT_AO2
	icon_state = "ranks_officer"

/obj/item/clothing/accessory/ranks/army/o3
	name = "rank boards"
	rank_short = PAY_SHORT_AO3
	icon_state = "ranks_officer"

/obj/item/clothing/accessory/ranks/army/o4
	name = "rank boards"
	rank_short = PAY_SHORT_AO4
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/army/o5
	name = "rank boards"
	rank_short = PAY_SHORT_AO5
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/army/o6
	name = "rank boards"
	rank_short = PAY_SHORT_AO6
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/army/o6e
	name = "rank boards"
	rank_short = PAY_SHORT_AO6E
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/army/o6c
	name = "rank boards"
	rank_short = PAY_SHORT_AO6C
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/army/o7
	name = "rank boards"
	rank_short = PAY_SHORT_AO7
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/army/o8
	name = "rank boards"
	rank_short = PAY_SHORT_AO8
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/army/o9
	name = "rank boards"
	rank_short = PAY_SHORT_AO9
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/army/o10
	name = "rank boards"
	rank_short = PAY_SHORT_AO10
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/army/o10c
	name = "rank boards"
	rank_short = PAY_SHORT_AO10C
	icon_state = "ranks_flagofficer"

/*################################################
################ ROYAL MARINES  ###################
################################################*/
//ENLISTED
/obj/item/clothing/accessory/ranks/rmc/e1
	rank_short = PAY_SHORT_RMC1

/obj/item/clothing/accessory/ranks/rmc/e2e
	rank_short = PAY_SHORT_RMC2E

/obj/item/clothing/accessory/ranks/rmc/e2g
	rank_short = PAY_SHORT_RMC2G
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/rmc/e2n
	rank_short = PAY_SHORT_RMC2N

/obj/item/clothing/accessory/ranks/rmc/e2
	rank_short = PAY_SHORT_RMC2
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/rmc/e3
	rank_short = PAY_SHORT_RMC3
	icon_state = "ranks_nco"

/obj/item/clothing/accessory/ranks/rmc/e4
	rank_short = PAY_SHORT_RMC4
	icon_state = "ranks_snco"

/obj/item/clothing/accessory/ranks/rmc/e5
	rank_short = PAY_SHORT_RMC5
	icon_state = "ranks_snco"

//WARRANT OFFICERS
/obj/item/clothing/accessory/ranks/rmc/wo
	name = "rank boards"
	rank_short = PAY_SHORT_RMOW
	icon_state = "ranks_warrant"

//OFFICERS
/obj/item/clothing/accessory/ranks/rmc/o1
	rank_short = PAY_SHORT_RMO1
	icon_state = "ranks_o1"

/obj/item/clothing/accessory/ranks/rmc/o2
	rank_short = PAY_SHORT_RMO2
	icon_state = "ranks_o2"

/obj/item/clothing/accessory/ranks/rmc/o3
	rank_short = PAY_SHORT_RMO3
	icon_state = "ranks_o3"

/obj/item/clothing/accessory/ranks/rmc/o4
	name = "rank boards"
	rank_short = PAY_SHORT_RMO4
	icon_state = "ranks_seniorofficer"

/obj/item/clothing/accessory/ranks/rmc/o5
	name = "rank boards"
	rank_short = PAY_SHORT_RMO5
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/rmc/o6
	name = "rank boards"
	rank_short = PAY_SHORT_RMO6
	icon_state = "ranks_flagofficer"

/obj/item/clothing/accessory/ranks/rmc/o7
	name = "rank boards"
	rank_short = PAY_SHORT_RMO7
	icon_state = "ranks_flagofficer"

/*################################################
################# SPECIAL  #################
################################################*/
/obj/item/clothing/accessory/ranks/special/insp
	name = "rank boards"
	rank_short = "PvI"
	icon_state = "ranks_pvstofficer"

/obj/item/clothing/accessory/ranks/canc
	name = "CANC collar tabs"
	rank_short = null
	icon_state = "ranks_canc"

/obj/item/clothing/accessory/ranks/canc/e1
	rank_short = PAY_SHORT_CA1

/obj/item/clothing/accessory/ranks/canc/e2
	rank_short = PAY_SHORT_CA2

/obj/item/clothing/accessory/ranks/canc/e3
	rank_short = PAY_SHORT_CA3

/obj/item/clothing/accessory/ranks/canc/e4
	rank_short = PAY_SHORT_CA4

/obj/item/clothing/accessory/ranks/canc/e5
	rank_short = PAY_SHORT_CA5
