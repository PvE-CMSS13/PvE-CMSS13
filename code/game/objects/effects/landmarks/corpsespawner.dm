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
