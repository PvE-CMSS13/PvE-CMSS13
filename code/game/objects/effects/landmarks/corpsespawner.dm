///////////////////// LANDMARK CORPSE ///////


//These are meant for spawning on maps, namely Away Missions.

/obj/effect/landmark/corpsespawner
	name = "Unknown"
	icon_state = "corpse_spawner"
	var/equip_path = null

/obj/effect/landmark/corpsespawner/Initialize(mapload, ...)
	. = ..()
	GLOB.corpse_spawns += src

/obj/effect/landmark/corpsespawner/Destroy()
	GLOB.corpse_spawns -= src
	return ..()

///////////Civilians//////////////////////

/obj/effect/landmark/corpsespawner/bluecollar
	name = "Blue-Collar"
	equip_path = /datum/equipment_preset/corpse/bluecollar

/obj/effect/landmark/corpsespawner/bluecollar/burst
	name = "Burst Blue-Collar"
	equip_path = /datum/equipment_preset/corpse/bluecollar/burst

/obj/effect/landmark/corpsespawner/whitecollar
	name = "White-Collar"
	equip_path = /datum/equipment_preset/corpse/whitecollar

/obj/effect/landmark/corpsespawner/whitecollar/burst
	name = "Burst White-Collar"
	equip_path = /datum/equipment_preset/corpse/whitecollar/burst

/obj/effect/landmark/corpsespawner/researcher
	name = "Researcher"
	equip_path = /datum/equipment_preset/corpse/researcher

/obj/effect/landmark/corpsespawner/chef
	name = "Chef"
	equip_path = /datum/equipment_preset/corpse/chef

/obj/effect/landmark/corpsespawner/riot
	name = "Corpse - Security Guard, UA Colonial Guard"
	equip_path = /datum/equipment_preset/corpse/riot

/obj/effect/landmark/corpsespawner/researcher/burst
	name = "Burst Researcher"
	equip_path = /datum/equipment_preset/corpse/researcher/burst

/obj/effect/landmark/corpsespawner/doctor
	name = "Doctor"
	equip_path = /datum/equipment_preset/corpse/doctor

/obj/effect/landmark/corpsespawner/doctor/burst
	name = "Burst Doctor"
	equip_path = /datum/equipment_preset/corpse/doctor/burst

/obj/effect/landmark/corpsespawner/scrubs
	name = "Doctor, Scrubs"
	equip_path = /datum/equipment_preset/corpse/doctor/scrubs

/obj/effect/landmark/corpsespawner/scientist
	name = "Scientist"
	equip_path = /datum/equipment_preset/corpse/scientist

/obj/effect/landmark/corpsespawner/engineer
	name = "Engineer"
	equip_path = /datum/equipment_preset/corpse/engineer

/obj/effect/landmark/corpsespawner/security
	name = "Corpse - Security Guard, Wey-Yu"
	equip_path = /datum/equipment_preset/colonist/corpse/security

/obj/effect/landmark/corpsespawner/security/liaison
	name = "Corporate Liaison"
	equip_path = /datum/equipment_preset/corpse/liaison

/obj/effect/landmark/corpsespawner/administrator
	name = "Colony Administrator"
	equip_path = /datum/equipment_preset/corpse/administrator

/obj/effect/landmark/corpsespawner/clf
	name = "Colonial Liberation Front Soldier"
	equip_path = /datum/equipment_preset/corpse/clf

/obj/effect/landmark/corpsespawner/miner
	name = "Shaft Miner"
	equip_path = /datum/equipment_preset/corpse/miner

//FORECON
/obj/effect/landmark/corpsespawner/scrubs/burst
	name = "Burst Doctor, Scrubs"
	equip_path = /datum/equipment_preset/corpse/doctor/scrubs/burst

/obj/effect/landmark/corpsespawner/prisoner
	name = "Prisoner"
	equip_path = /datum/equipment_preset/corpse/prisoner

/obj/effect/landmark/corpsespawner/prisoner/burst
	name = "Burst Prisoner"
	equip_path = /datum/equipment_preset/corpse/prisoner/burst

/obj/effect/landmark/corpsespawner/guard
	name = "Security Guard, Prison"
	equip_path = /datum/equipment_preset/corpse/guard

/obj/effect/landmark/corpsespawner/guard/burst
	name = "Burst Security Guard, Prison"
	equip_path = /datum/equipment_preset/corpse/guard/burst

/obj/effect/landmark/corpsespawner/riot
	name = "Security Guard, UA Colonial Guard"
	equip_path = /datum/equipment_preset/corpse/riot

/obj/effect/landmark/corpsespawner/riot/burst
	name = "Burst Security Guard, UA Colonial Guard"
	equip_path = /datum/equipment_preset/corpse/riot/burst

/obj/effect/landmark/corpsespawner/security
	name = "Security Guard, Wey-Yu"
	equip_path = /datum/equipment_preset/corpse/security

/obj/effect/landmark/corpsespawner/security/burst
	name = "Burst Security Guard, Wey-Yu"
	equip_path = /datum/equipment_preset/corpse/security/burst

/obj/effect/landmark/corpsespawner/cmb
	name = "Colonial Marshals Deputy"
	equip_path = /datum/equipment_preset/corpse/cmb

/obj/effect/landmark/corpsespawner/cmb/burst
	name = "Burst Colonial Marshals Deputy"
	equip_path = /datum/equipment_preset/corpse/cmb/burst

//*****************************************************************************************************/
///////////Faction Specific Corpses//////////////////////
//*****************************************************************************************************/

/// UPP

/obj/effect/landmark/corpsespawner/upp
	name = "UPP Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/upp

/obj/effect/landmark/corpsespawner/upp/burst
	name = "Burst UPP Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/upp

/// TWE

/obj/effect/landmark/corpsespawner/rmc
	name = "TWE Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/royal_marine

/obj/effect/landmark/corpsespawner/rmc/burst
	name = "Burst TWE Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/royal_marine/burst

/// Freelancer

/obj/effect/landmark/corpsespawner/freelancer
	name = "Freelancer"
	equip_path = /datum/equipment_preset/corpse/freelancer

/obj/effect/landmark/corpsespawner/freelancer/burst
	name = "Burst Freelancer"
	equip_path = /datum/equipment_preset/corpse/freelancer/burst

/// USCM

/obj/effect/landmark/corpsespawner/uscm
	name = "USCM Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm

/obj/effect/landmark/corpsespawner/uscm/burst
	name = "Burst USCM Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm/burst

/obj/effect/landmark/corpsespawner/uscm_dp
	name = "USCM Dropship Pilot"
	equip_path = /datum/equipment_preset/corpse/uscm_dp

/obj/effect/landmark/corpsespawner/uscm_dp/burst
	name = "Burst USCM Dropship Pilot"
	equip_path = /datum/equipment_preset/corpse/uscm_dp/burst

/obj/effect/landmark/corpsespawner/uscm_unequipped
	name = "USCM Unequipped Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm_unequipped

/obj/effect/landmark/corpsespawner/uscm_unequipped/burst
	name = "Burst USCM Unequipped Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm_unequipped/burst

/// FORECON

/obj/effect/landmark/corpsespawner/scrubs/burst
	name = "Burst Doctor, Scrubs"
	equip_path = /datum/equipment_preset/corpse/doctor/scrubs/burst

/obj/effect/landmark/corpsespawner/prisoner
	name = "Prisoner"
	equip_path = /datum/equipment_preset/corpse/prisoner

/obj/effect/landmark/corpsespawner/prisoner/burst
	name = "Burst Prisoner"
	equip_path = /datum/equipment_preset/corpse/prisoner/burst

/obj/effect/landmark/corpsespawner/guard
	name = "Security Guard, Prison"
	equip_path = /datum/equipment_preset/corpse/guard

/obj/effect/landmark/corpsespawner/guard/burst
	name = "Burst Security Guard, Prison"
	equip_path = /datum/equipment_preset/corpse/guard/burst

/obj/effect/landmark/corpsespawner/riot
	name = "Security Guard, UA Colonial Guard"
	equip_path = /datum/equipment_preset/corpse/riot

/obj/effect/landmark/corpsespawner/riot/burst
	name = "Burst Security Guard, UA Colonial Guard"
	equip_path = /datum/equipment_preset/corpse/riot/burst

/obj/effect/landmark/corpsespawner/security
	name = "Security Guard, Wey-Yu"
	equip_path = /datum/equipment_preset/corpse/security

/obj/effect/landmark/corpsespawner/security/burst
	name = "Burst Security Guard, Wey-Yu"
	equip_path = /datum/equipment_preset/corpse/security/burst

/obj/effect/landmark/corpsespawner/cmb
	name = "Colonial Marshals Deputy"
	equip_path = /datum/equipment_preset/corpse/cmb

/obj/effect/landmark/corpsespawner/cmb/burst
	name = "Burst Colonial Marshals Deputy"
	equip_path = /datum/equipment_preset/corpse/cmb/burst

//*****************************************************************************************************/
///////////Faction Specific Corpses//////////////////////
//*****************************************************************************************************/

/// UPP

/obj/effect/landmark/corpsespawner/upp
	name = "UPP Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/upp

/obj/effect/landmark/corpsespawner/upp/burst
	name = "Burst UPP Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/upp

/// TWE

/obj/effect/landmark/corpsespawner/rmc
	name = "TWE Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/royal_marine

/obj/effect/landmark/corpsespawner/rmc/burst
	name = "Burst TWE Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/royal_marine/burst

/// Freelancer

/obj/effect/landmark/corpsespawner/freelancer
	name = "Freelancer"
	equip_path = /datum/equipment_preset/corpse/freelancer

/obj/effect/landmark/corpsespawner/freelancer/burst
	name = "Burst Freelancer"
	equip_path = /datum/equipment_preset/corpse/freelancer/burst

/// USCM

/obj/effect/landmark/corpsespawner/uscm
	name = "USCM Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm

/obj/effect/landmark/corpsespawner/uscm/burst
	name = "Burst USCM Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm/burst

/obj/effect/landmark/corpsespawner/uscm_dp
	name = "USCM Dropship Pilot"
	equip_path = /datum/equipment_preset/corpse/uscm_dp

/obj/effect/landmark/corpsespawner/uscm_dp/burst
	name = "Burst USCM Dropship Pilot"
	equip_path = /datum/equipment_preset/corpse/uscm_dp/burst

/obj/effect/landmark/corpsespawner/uscm_unequipped
	name = "USCM Unequipped Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm_unequipped

/obj/effect/landmark/corpsespawner/uscm_unequipped/burst
	name = "Burst USCM Unequipped Squad Rifleman"
	equip_path = /datum/equipment_preset/corpse/uscm_unequipped/burst

/// FORECON

/obj/effect/landmark/corpsespawner/forecon_spotter
	name = "USCM Reconnaissance Spotter"
	equip_path = /datum/equipment_preset/corpse/forecon_spotter


///////////////////////
/////// HYBRISA ///////
///////////////////////

//*****************************************************************************************************/

// Civilian

/obj/effect/landmark/corpsespawner/hybrisa/civilian
	name = "Corpse - Civilian"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian

/obj/effect/landmark/corpsespawner/hybrisa/civilian/burst
	name = "Corpse - Burst - Civilian"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian/burst

/obj/effect/landmark/corpsespawner/hybrisa/civilian_office
	name = "Corpse - Civilian - Office Worker"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian_office

/obj/effect/landmark/corpsespawner/hybrisa/civilian_office/burst
	name = "Corpse - Burst - Civilian - Office Worker"
	equip_path = /datum/equipment_preset/corpse/hybrisa/civilian_office/burst

/obj/effect/landmark/corpsespawner/wygoon
	name = "Weyland-Yutani Corporate Security Officer"
	equip_path = /datum/equipment_preset/corpse/pmc/goon

// Weymart

/obj/effect/landmark/corpsespawner/hybrisa/weymart
	name = "Corpse - Civilian - Weymart Employee"
	equip_path = /datum/equipment_preset/corpse/hybrisa/weymart

/obj/effect/landmark/corpsespawner/hybrisa/weymart/burst
	name = "Corpse - Burst - Civilian - Weymart Employee"
	equip_path = /datum/equipment_preset/corpse/hybrisa/weymart/burst

// Sanitation

/obj/effect/landmark/corpsespawner/hybrisa/sanitation
	name = "Corpse - Civilian - Material Reprocessing Technician"
	equip_path = /datum/equipment_preset/corpse/hybrisa/sanitation

/obj/effect/landmark/corpsespawner/hybrisa/sanitation/burst
	name = "Corpse - Burst - Civilian - Material Reprocessing Technician"
	equip_path = /datum/equipment_preset/corpse/hybrisa/sanitation/burst

// Pizza Galaxy

/obj/effect/landmark/corpsespawner/hybrisa/pizza_galaxy
	name = "Corpse - Civilian - Pizza Galaxy Delivery Driver"
	equip_path = /datum/equipment_preset/corpse/hybrisa/pizza_galaxy

/obj/effect/landmark/corpsespawner/hybrisa/pizza_galaxy/burst
	name = "Corpse - Burst - Civilian - Pizza Galaxy Delivery Driver"
	equip_path = /datum/equipment_preset/corpse/hybrisa/pizza_galaxy/burst

//*****************************************************************************************************/

// Colonial Marshals

/obj/effect/landmark/corpsespawner/hybrisa/nspa_constable
	name = "Corpse - NSPA Constable"
	equip_path = /datum/equipment_preset/corpse/hybrisa/nspa_constable

/obj/effect/landmark/corpsespawner/hybrisa/nspa_constable/burst
	name = "Corpse - Burst - NSPA Constable"
	equip_path = /datum/equipment_preset/corpse/hybrisa/nspa_constable/burst

//*****************************************************************************************************/

// KMCC Mining

/obj/effect/landmark/corpsespawner/hybrisa/kelland_miner
	name = "Corpse - KMCC - Miner"
	equip_path = /datum/equipment_preset/corpse/hybrisa/kelland_miner

/obj/effect/landmark/corpsespawner/hybrisa/kelland_miner/burst
	name = "Corpse - Burst - KMCC - Miner"
	equip_path = /datum/equipment_preset/corpse/hybrisa/kelland_miner/burst

//*****************************************************************************************************/

// Medical

/obj/effect/landmark/corpsespawner/hybrisa/medical_doctor_corpse

	name = "Corpse - Civilian - Medical Doctor"
	equip_path = /datum/equipment_preset/corpse/hybrisa/medical_doctor_corpse

/obj/effect/landmark/corpsespawner/hybrisa/medical_doctor_corpse/burst

	name = "Corpse - Burst - Civilian - Medical Doctor"
	equip_path = /datum/equipment_preset/corpse/hybrisa/medical_doctor_corpse/burst

//*****************************************************************************************************/

// Science

// Xenobiologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenobiologist

	name = "Corpse - Civilian - Xenobiologist"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenobiologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenobiologist/burst

	name = "Corpse - Burst - Civilian - Xenobiologist"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenobiologist/burst

// Xenoarchaeologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenoarchaeologist

	name = "Corpse - Civilian - Xenoarchaeologist"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenoarchaeologist

/obj/effect/landmark/corpsespawner/hybrisa/scientist_xenoarchaeologist/burst

	name = "Corpse - Burst - Civilian - Xenoarchaeologist"
	equip_path = /datum/equipment_preset/corpse/hybrisa/scientist_xenoarchaeologist/burst

//*****************************************************************************************************/

///US Army Corpses///

// Army Trooper //

/obj/effect/landmark/corpsespawner/tyrargo/us_army_trooper
	name = "Corpse - US Army - Trooper"
	equip_path = /datum/equipment_preset/corpse/tyrargo/us_army_trooper

/obj/effect/landmark/corpsespawner/tyrargo/us_army_trooper/burst
	name = "Corpse - Burst - US Army - Trooper"
	equip_path = /datum/equipment_preset/corpse/tyrargo/us_army_trooper/burst

/obj/effect/landmark/corpsespawner/tyrargo/us_army_medic
	name = "Corpse - US Army - Trooper"
	equip_path = /datum/equipment_preset/corpse/tyrargo/us_army_medic

/obj/effect/landmark/corpsespawner/tyrargo/us_army_medic/burst
	name = "Corpse - Burst - US Army - Trooper"
	equip_path = /datum/equipment_preset/corpse/tyrargo/us_army_medic/burst

///CM specific jobs///

/obj/effect/landmark/corpsespawner/colonist //default is a colonist
	name = "Colonist"
	equip_path = /datum/equipment_preset/corpse/colonist

/obj/effect/landmark/corpsespawner/colonist/burst
	name = "Burst Colonist"
	equip_path = /datum/equipment_preset/corpse/colonist/burst

/obj/effect/landmark/corpsespawner/colonist/kutjevo
	name = "Colonist Kutjevo"
	equip_path = /datum/equipment_preset/corpse/colonist/kutjevo

/obj/effect/landmark/corpsespawner/colonist/kutjevo/burst
	name = "Burst Colonist Kutjevo"
	equip_path = /datum/equipment_preset/corpse/colonist/kutjevo/burst

/obj/effect/landmark/corpsespawner/colonist/random
	name = "Colonist Random"
	equip_path = /datum/equipment_preset/corpse/colonist/random

/obj/effect/landmark/corpsespawner/colonist/random/burst
	name = "Burst Colonist Random"
	equip_path = /datum/equipment_preset/corpse/colonist/random/burst

/obj/effect/landmark/corpsespawner/ua_riot
	name = "UA Officer"
	equip_path = /datum/equipment_preset/corpse/ua_riot

/obj/effect/landmark/corpsespawner/ua_riot/burst
	name = "Burst UA Officer"
	equip_path = /datum/equipment_preset/corpse/ua_riot/burst

/obj/effect/landmark/corpsespawner/wy/manager
	name = "Corporate Supervisor"
	equip_path = /datum/equipment_preset/corpse/wy/manager

/obj/effect/landmark/corpsespawner/wy/manager/burst
	name = "Burst Corporate Supervisor"
	equip_path = /datum/equipment_preset/corpse/wy/manager/burst
