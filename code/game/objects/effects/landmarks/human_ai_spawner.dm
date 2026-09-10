///////////////////// LANDMARK HUMAN AI ///////


//These are meant for spawning on maps, namely Away Missions.

/obj/effect/landmark/humanaispawner
	name = "Unknown"
	icon_state = "x3"
	var/equip_path = null

/obj/effect/landmark/humanaispawner/Initialize(mapload, ...)
	. = ..()
	GLOB.human_ai_spawns += src

/obj/effect/landmark/humanaispawner/Destroy()
	GLOB.human_ai_spawns -= src
	return ..()

//*****************************************************************************************************/
/// USCM

/obj/effect/landmark/humanaispawner/uscm 			//Do not use, placeholder for SDMM subtype organization, HAI attacks immediately due to the lack of a faction

/obj/effect/landmark/humanaispawner/uscm/rifleman
	name = "USCM Squad Rifleman"
	desc = "Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	equip_path = /datum/equipment_preset/uscm/private_equipped

/obj/effect/landmark/humanaispawner/uscm/rifleman/eva
	name = "USCM Squad Rifleman EVA"
	desc = "Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	equip_path = /datum/equipment_preset/uscm/private_equipped/eva

/obj/effect/landmark/humanaispawner/uscm/smartgunner
	name = "USCM Squad Smartgunner"
	desc = "Armed with a M56A2 smartgun, carries a simple IFAK with gauze, ointment and an injector."
	equip_path = /datum/equipment_preset/uscm/smartgunner_equipped

/obj/effect/landmark/humanaispawner/uscm/medic
	name = "USCM Squad Corpsman"
	desc = "Able to stablize wounded. Armed with a M41A rifle, carries medical equipment."
	equip_path = /datum/equipment_preset/uscm/medic_equipped

/obj/effect/landmark/humanaispawner/uscm/squadleader
	name = "USCM Squad Leader"
	desc = "Functionally a rifleman. Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	equip_path = /datum/equipment_preset/uscm/tl_equipped

/obj/effect/landmark/humanaispawner/uscm/sectionleader
	name = "USCM Section Leader"
	desc = "Functionally a rifleman. Armed with a M41A rifle, carries a simple IFAK with gauze, ointment and an injector."
	equip_path = /datum/equipment_preset/uscm/leader_equipped

//

/obj/effect/landmark/humanaispawner/uscm/engineer
	name = "USCM Combat Engineer"
	desc = "A USCM Combat engineer, standard equipment with some engineering tools. Per the techmanual these guys are pretty fucking crazy, read it. It's cool."
	equip_path = /datum/equipment_preset/uscm/engineer_equipped

/obj/effect/landmark/humanaispawner/uscm/mortar_operator
	name = "USCM Mortar Operator"
	desc = "Amred with a pistol this guy operates mortars but doesn't actually have one, use for set dressing"
	equip_path = /datum/equipment_preset/uscm/mortar_operator_equipped

/obj/effect/landmark/humanaispawner/uscm/rpg_weapons_op
	name = "USCM RPG Weapons Operator"
	desc = "A USCM rocketeer, has an RPG"
	equip_path = /datum/equipment_preset/uscm/specialist_equipped

/obj/effect/landmark/humanaispawner/uscm/rpg_weapons_loader
	name = "USCM RPG Weapons Loader"
	desc = "USCM RPG assistant, armed with M41A"
	equip_path = /datum/equipment_preset/uscm/specialist_equipped/loader

/obj/effect/landmark/humanaispawner/uscm/b18_operator
	name = "USCM B18 Operator"
	desc = "USCM B18 Spec, armed with M41A"
	equip_path = /datum/equipment_preset/uscm/specialist_equipped/b18

/obj/effect/landmark/humanaispawner/uscm/sniper_operator
	name = "USCM Sniper Operator"
	desc = "USCM generic marine outfitted with an M42A"
	equip_path = /datum/equipment_preset/uscm/specialist_equipped/sniper

/obj/effect/landmark/humanaispawner/uscm/spotter_operator
	name = "USCM Spotter Operator"
	desc = "USCM generic marine spotter"
	equip_path = /datum/equipment_preset/uscm/specialist_equipped/spotter

/obj/effect/landmark/humanaispawner/uscm/tanker
	name = "USCM Tank Crewman"
	desc = "USCM Tank crewman, armed with a pistol"
	equip_path = /datum/equipment_preset/uscm/tank

/obj/effect/landmark/humanaispawner/uscm/marsoc
	name = "USCM MARSOC"
	desc = "USCM Special Forces MARSOC. Use sparingly"
	equip_path = /datum/equipment_preset/uscm/marsoc

//

/obj/effect/landmark/humanaispawner/uscm/combat_android
	name = "USCM Combat Android"
	desc = "You signed documents saying you wouldn't use these..."
	equip_path = /datum/equipment_preset/synth/working_joe/security_android

/obj/effect/landmark/humanaispawner/uscm/working_joe
	name = "USCM Working Joe"
	desc = "You always know a working joe"
	equip_path = /datum/equipment_preset/synth/working_joe

/obj/effect/landmark/humanaispawner/uscm/working_joe/engi
	name = "USCM Hazmat Joe"
	desc = "You always know a working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/engi

//*****************************************************************************************************/
/// UPP

/obj/effect/landmark/humanaispawner/upp

/obj/effect/landmark/humanaispawner/upp/militia
	name = "UPP People's Territorial Guardsman"
	desc = "The auxiliary troop of the UPP, armed with second hand equipment for more basic work."
	equip_path = /datum/equipment_preset/upp/militia

/obj/effect/landmark/humanaispawner/upp/militia/at
	name = "UPP People's Territorial Guardsman Anti-Tank"
	desc = "The auxiliary troop of the UPP, armed with second hand equipment for more basic work. This one has an AT launcher."
	equip_path = /datum/equipment_preset/upp/militia/at

/obj/effect/landmark/humanaispawner/upp/militia/medic
	name = "UPP People's Territorial Guardsman Sanitar"
	desc = "The auxiliary troop of the UPP, armed with second hand equipment for more basic work. This one is equipped with some more basic medical supplies and training."
	equip_path = /datum/equipment_preset/upp/militia/medic

/obj/effect/landmark/humanaispawner/upp/militia/tech
	name = "UPP People's Territorial Guardsman Technician"
	desc = "The auxiliary troop of the UPP, armed with second hand equipment for more basic work. This one is equipped with some more basic technican supplies and training."
	equip_path = /datum/equipment_preset/upp/militia/tech

/obj/effect/landmark/humanaispawner/upp/militia/nco
	name = "UPP People's Territorial Guardsman Sergeant"
	desc = "The auxiliary troop of the UPP, armed with second hand equipment for more basic work. This one leads the entire bundle of disorganised troops into battle."
	equip_path = /datum/equipment_preset/upp/militia/nco

/obj/effect/landmark/humanaispawner/upp/militia/officer
	name = "UPP People's Territorial Guardsman Officer"
	desc = "The auxiliary troop of the UPP, armed with second hand equipment for more basic work. This one manages the whole operation around the UPP Territorial Guard."
	equip_path = /datum/equipment_preset/upp/militia/officer

/obj/effect/landmark/humanaispawner/upp/rifleman
	name = "UPP Squad Rifleman"
	desc = "The standard UPP soldier. These guys are equipped well enough to fight most forces."
	equip_path = /datum/equipment_preset/upp/rifleman

/obj/effect/landmark/humanaispawner/upp/rifleman/ag80
	name = "UPP Squad Rifleman - AG80"
	desc = "The standard UPP soldier. These guys are equipped well enough to fight most forces."
	equip_path = /datum/equipment_preset/upp/rifleman/ag80

/obj/effect/landmark/humanaispawner/upp/rifleman/eva
	name = "UPP Squad Rifleman - EVA"
	desc = "The standard UPP soldier. These guys are equipped well enough to fight most forces. EVA equipped"
	equip_path = /datum/equipment_preset/upp/rifleman/eva

/obj/effect/landmark/humanaispawner/upp/machinegunner
	name = "UPP Squad Machinegunner"
	desc = "The UPP’s answer to the USCM’s smartgunner. About as strong, can gun down unaware marines easily. This one shoots standard 10x27mm."
	equip_path = /datum/equipment_preset/upp/machinegunner

/obj/effect/landmark/humanaispawner/upp/at
	name = "UPP Squad Anti-Tank"
	desc = "UPP RPG armed soldier, otherwise similarly equipped as standard"
	equip_path = /datum/equipment_preset/upp/rifleman/at

/obj/effect/landmark/humanaispawner/upp/combat_synth
	name = "UPP Synthetic Commando"
	desc = "A strong commando synthetic equipped with several weapons. Its durability and firepower lets it take on multiple marines at once."
	equip_path = /datum/equipment_preset/upp/synth/commando

/obj/effect/landmark/humanaispawner/upp/medic
	name = "UPP Squad Sanitar"
	desc = "The guy who tries to keep the rest of the team alive. Comes equipped with medical supplies, though they don’t always live long enough to do treatment."
	equip_path = /datum/equipment_preset/upp/sanitar

/obj/effect/landmark/humanaispawner/upp/sergeant
	name = "UPP Squad Sergeant"
	desc = "The leader of a UPP squad. Functionally very similar to squad riflemen."
	equip_path = /datum/equipment_preset/upp/squadlead

/obj/effect/landmark/humanaispawner/upp/platoon_sergeant
	name = "UPP Platoon Sergeant"
	desc = "The leader of a UPP Platoon. Functionally very similar to squad riflemen."
	equip_path = /datum/equipment_preset/upp/navallead

/obj/effect/landmark/humanaispawner/upp/military_police
	name = "UPP - Military Police"
	desc = "UPP - Military Police, armed with a T73."
	equip_path = /datum/equipment_preset/upp/military_police

/obj/effect/landmark/humanaispawner/upp/officer
	name = "UPP - Officer"
	desc = "UPP Lieutenant, armed with a clicky pen and Type73"
	equip_path = /datum/equipment_preset/upp/officer

/obj/effect/landmark/humanaispawner/upp/officer/kapitan
	name = "UPP - Officer Captain"
	desc = "UPP Captain, functionally similar to the officer"
	equip_path = /datum/equipment_preset/upp/officer/kapitan

/obj/effect/landmark/humanaispawner/upp/officer/kolonel
	name = "UPP - Officer Colonel"
	desc = "UPP Colonel, functionally similar to the officer"
	equip_path = /datum/equipment_preset/upp/officer/kolonel

/obj/effect/landmark/humanaispawner/upp/officer/lt_kolonel
	name = "UPP - Officer Lt Colonel"
	desc = "UPP LT Colonel, functionally similar to the officer"
	equip_path = /datum/equipment_preset/upp/officer/lt_kolonel

/obj/effect/landmark/humanaispawner/upp/officer/major
	name = "UPP - Officer Major"
	desc = "UPP Major, functionally similar to the officer"
	equip_path = /datum/equipment_preset/upp/officer/major

/obj/effect/landmark/humanaispawner/upp/officer/naval
	name = "UPP - Officer Naval Lieutenant"
	desc = "UPP Lieutenant, functionally similar to the officer"
	equip_path = /datum/equipment_preset/upp/officer/naval

/obj/effect/landmark/humanaispawner/upp/officer/senior
	name = "UPP - Officer Senior Lieutenant"
	desc = "UPP Senior lieutenant, functionally similar to the officer"
	equip_path = /datum/equipment_preset/upp/officer/senior

/obj/effect/landmark/humanaispawner/upp/support_synth
	name = "UPP Support Synthetic"
	desc = "A generic UPP Support synthetic"
	equip_path = /datum/equipment_preset/upp/synth

/obj/effect/landmark/humanaispawner/upp/combat_android
	name = "UPP Combat Android"
	desc = "The UPP never signed documents pretaining to the legality of combat androids but GMs should be mindful not to overuse them, Dressed like a standard"
	equip_path = /datum/equipment_preset/synth/working_joe/upp/combat

/obj/effect/landmark/humanaispawner/upp/synth_commando
	name = "UPP Synthetic Commando"
	desc = "The UPP never signed documents pretaining to the legality of combat androids but GMs should be mindful not to overuse them, This one is very deadly"
	equip_path = /datum/equipment_preset/upp/synth/commando

/obj/effect/landmark/humanaispawner/upp/commando
	name = "UPP - Commando"
	desc = "A UPP Special forces commando - Equipped with a cloak and a very deadly rifle"
	equip_path = /datum/equipment_preset/upp/commando

/obj/effect/landmark/humanaispawner/upp/commando/leader
	name = "UPP - Commando Leader"
	desc = "A UPP Special forces commando - Equipped with a cloak and a very deadly rifle, this one is a leader"
	equip_path = /datum/equipment_preset/upp/commando/leader

/obj/effect/landmark/humanaispawner/upp/tanker
	name = "UPP - Vehicle Crew"
	desc = "UPP generic vehicle crewman"
	equip_path = /datum/equipment_preset/upp/tank

/obj/effect/landmark/humanaispawner/upp/pilot
	name = "UPP - Pilot"
	desc = "UPP generic pilot"
	equip_path = /datum/equipment_preset/upp/pilot

/obj/effect/landmark/humanaispawner/upp/mil_doc
	name = "UPP - Military Doctor"
	desc = "UPP military doctor, unarmed but still a member of the military"
	equip_path = /datum/equipment_preset/upp/mildoctor

/obj/effect/landmark/humanaispawner/upp/sniper
	name = "UPP Sniper"
	desc = "UPP Marksman"
	equip_path = /datum/equipment_preset/upp/sniper

//Colonists

/obj/effect/landmark/humanaispawner/upp/colonist
	name = "UPP - Colonist"
	desc = "A generic UPP colonist, unarmed"
	equip_path = /datum/equipment_preset/upp/colonist

/obj/effect/landmark/humanaispawner/upp/colonist/researcher
	name = "UPP - Researcher"
	desc = "A civillian researcher for the UPP, Unarmed"
	equip_path = /datum/equipment_preset/upp/researcher

/obj/effect/landmark/humanaispawner/upp/colonist/doctor
	name = "UPP - Doctor"
	desc = "A civillian doctor for the UPP, unarmed"
	equip_path = /datum/equipment_preset/upp/doctor

/obj/effect/landmark/humanaispawner/upp/colonist/admin
	name = "UPP - Admin Tech"
	desc = "A civillian admin tech for the UPP, unarmed"
	equip_path = /datum/equipment_preset/upp/admin

/obj/effect/landmark/humanaispawner/upp/colonist/cargo
	name = "UPP - Cargo Tech"
	desc = "A civillian cargo tech for the UPP, unarmed"
	equip_path = /datum/equipment_preset/upp/cargo

/obj/effect/landmark/humanaispawner/upp/colonist/engineer
	name = "UPP - Engineer"
	desc = "A civillian engineer for the UPP, unarmed"
	equip_path = /datum/equipment_preset/upp/engineer

/obj/effect/landmark/humanaispawner/upp/colonist/operations
	name = "UPP - Operations Tech"
	desc = "A civillian operations tech for the UPP, unarmed"
	equip_path = /datum/equipment_preset/upp/operations

/obj/effect/landmark/humanaispawner/upp/colonist/police
	name = "UPP - Police"
	desc = "Police officer armed with a pistol"
	equip_path = /datum/equipment_preset/upp/police

/obj/effect/landmark/humanaispawner/upp/colonist/police/riot
	name = "UPP - Riot Police"
	desc = "Riot police officer armed with a shotgun and less than lethal beanbags"
	equip_path = /datum/equipment_preset/upp/police/riot

/obj/effect/landmark/humanaispawner/upp/colonist/prisoner
	name = "UPP - Prisoner"
	desc = "UPP prisoner, unarmed"
	equip_path = /datum/equipment_preset/upp/prisoner

/obj/effect/landmark/humanaispawner/upp/colonist/police/mss
	name = "UPP MSS Agent"
	desc = "A ministry of space security operative with a pistol"
	equip_path = /datum/equipment_preset/upp/police/mss

/obj/effect/landmark/humanaispawner/upp/colonist/dzho
	name = "UPP Dzho Automaton"
	desc = "You always know a legally distinct working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/upp

//*****************************************************************************************************/
/// PMC

/obj/effect/landmark/humanaispawner/pmc

/obj/effect/landmark/humanaispawner/pmc/standard
	name = "PMC Rifleman"
	desc = "The standard unit of any PMC operation. Plenty of variety in what they're armed with."
	equip_path = /datum/equipment_preset/pmc/standard

/obj/effect/landmark/humanaispawner/pmc/medic
	name = "PMC - Medic"
	desc = "Medical unit of any PMC operation. Simiar weapons to the rifleman"
	equip_path = /datum/equipment_preset/pmc/medic

/obj/effect/landmark/humanaispawner/pmc/leader
	name = "PMC - Leader"
	desc = "The leader element of any PMC operation. Simiar weapons to the rifleman"
	equip_path = /datum/equipment_preset/pmc/leader

/obj/effect/landmark/humanaispawner/pmc/gunner
	name = "PMC - Gunner"
	desc = "The heavy weapons element to any PMC operation. Armed with a smartgun, deadly."
	equip_path = /datum/equipment_preset/pmc/gunner

/obj/effect/landmark/humanaispawner/pmc/sniper
	name = "PMC - Sniper"
	desc = "The supporting fire element to any PMC operation. Armed with an Anti-mat rifle, very deadly"
	equip_path = /datum/equipment_preset/pmc/sniper

/obj/effect/landmark/humanaispawner/pmc/crewman
	name = "PMC - Crewman"
	desc = "Armed with an SMG this is the PMC analog of a vehicle crewman"
	equip_path = /datum/equipment_preset/pmc/crewman

/obj/effect/landmark/humanaispawner/pmc/xeno_handler
	name = "PMC - Xeno Handler"
	desc = "The xeno handler is essentially a PMC standard with a fancy name"
	equip_path = /datum/equipment_preset/pmc/xeno_handler

/obj/effect/landmark/humanaispawner/pmc/doctor
	name = "PMC - Doctor"
	desc = "A civillian doctor working alongside W-Y PMCs, unarmed"
	equip_path = /datum/equipment_preset/pmc/doctor

/obj/effect/landmark/humanaispawner/pmc/technician
	name = "PMC - Techician"
	desc = "An unarmed techician working alongside PMCs"
	equip_path = /datum/equipment_preset/pmc/technician

/obj/effect/landmark/humanaispawner/pmc/director
	name = "PMC - Director"
	desc = "PMC dicrector armed with a pistol"
	equip_path = /datum/equipment_preset/pmc/director

/obj/effect/landmark/humanaispawner/pmc/synth
	name = "PMC - Synthetic"
	desc = "A PMC support synthetic, unarmed"
	equip_path = /datum/equipment_preset/pmc/synth

/obj/effect/landmark/humanaispawner/pmc/synth_combat
	name = "PMC - Security Android"
	desc = "A highly illegal PMC security android. GMs should not be using this willynilly"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/pmc

//*****************************************************************************************************/
/// W-Y

/obj/effect/landmark/humanaispawner/wy

/obj/effect/landmark/humanaispawner/wy/security/weyland
	name = "WY - Security"
	desc = "Very Generic WY Security officer, pistol"
	equip_path = /datum/equipment_preset/colonist/security/weyland

/obj/effect/landmark/humanaispawner/wy/security/weyland/japanese
	name = "WY - Security Japanese"
	desc = "Very Generic WY Security officer, pistol, japanese"
	equip_path = /datum/equipment_preset/colonist/security/weyland/japanese

/obj/effect/landmark/humanaispawner/wy/security/weyland/tactical
	name = "WY - Tactical Security"
	desc = "Very Generic WY Security officer, smg"
	equip_path = /datum/equipment_preset/colonist/security/weyland/tactical

/obj/effect/landmark/humanaispawner/wy/security/weyland/tactical/japanese
	name = "WY - Tactical Security Japanese"
	desc = "Very Generic WY Security officer, smg, japense"
	equip_path = /datum/equipment_preset/colonist/security/weyland/tactical/japanese

/obj/effect/landmark/humanaispawner/wy/security/weyland/tactical/lead
	name = "WY - Tactical Security Lead"
	desc = "Very Generic WY Security officer, shotgun"
	equip_path = /datum/equipment_preset/colonist/security/weyland/tactical/lead

/obj/effect/landmark/humanaispawner/wy/security/weyland/tactical/lead/japanese
	name = "WY - Tactical Security Lead Japanese"
	desc = "Very Generic WY Security officer, shotgun, japanese"
	equip_path = /datum/equipment_preset/colonist/security/weyland/tactical/lead/japanese

/obj/effect/landmark/humanaispawner/wy/security_droid
	name = "WY - Security Droid"
	desc = "A combat security android built by WY, do not use these often they are illegal"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/wy

/obj/effect/landmark/humanaispawner/wy/trainee
	name = "WY - Trainee"
	desc = "A civillian WY employee, trainee"
	equip_path = /datum/equipment_preset/wy/trainee

/obj/effect/landmark/humanaispawner/wy/junior_exec
	name = "WY - Jr Executive"
	desc = "A civillian WY employee, Jr Executive"
	equip_path = /datum/equipment_preset/wy/junior_exec

/obj/effect/landmark/humanaispawner/wy/exec
	name = "WY - Executive"
	desc = "A civillian WY employee, Executive"
	equip_path = /datum/equipment_preset/wy/exec

/obj/effect/landmark/humanaispawner/wy/senior_exec
	name = "WY - Senior Executive"
	desc = "A civillian WY employee, Senior Executive, WOW"
	equip_path = /datum/equipment_preset/wy/senior_exec

/obj/effect/landmark/humanaispawner/wy/exec_spec
	name = "WY - Executive Spec"
	desc = "A civillian WY employee, Executive spec"
	equip_path = /datum/equipment_preset/wy/exec_spec

/obj/effect/landmark/humanaispawner/wy/exec_spec/lawyer
	name = "WY - Executive Spec Lawyer"
	desc = "A civillian WY employee, Executive Spec lawyer"
	equip_path = /datum/equipment_preset/wy/exec_spec/lawyer

/obj/effect/landmark/humanaispawner/wy/exec_supervisor
	name = "WY - Executive Supervisor"
	desc = "A civillian WY employee, Exectuve Supervisor"
	equip_path = /datum/equipment_preset/wy/exec_supervisor

/obj/effect/landmark/humanaispawner/wy/exec_supervisor/lawyer
	name = "WY - Supervisor Lawyer"
	desc = "A civillian WY employee, Supervistor Lawyer"
	equip_path = /datum/equipment_preset/wy/exec_supervisor/lawyer

/obj/effect/landmark/humanaispawner/wy/manager/assistant_manager
	name = "WY - Assistant Manager"
	desc = "A civillian WY employee, Assistant Manager"
	equip_path = /datum/equipment_preset/wy/manager/assistant_manager

/obj/effect/landmark/humanaispawner/wy/manager/division_manager
	name = "WY - Division Manager"
	desc = "A civillian WY employee, Division Manager"
	equip_path = /datum/equipment_preset/wy/manager/division_manager

/obj/effect/landmark/humanaispawner/wy/manger/chief_executive
	name = "WY - Chief Executive"
	desc = "A civillian WY employee, Executive"
	equip_path = /datum/equipment_preset/wy/manager/chief_executive

/obj/effect/landmark/humanaispawner/wy/manager/director
	name = "WY - Director"
	desc = "A civillian WY employee, Director"
	equip_path = /datum/equipment_preset/wy/manager/director

//*****************************************************************************************************/
/// CANC

/obj/effect/landmark/humanaispawner/canc

/obj/effect/landmark/humanaispawner/canc/newblood
	name = "CANC Colonist Recruit"
	desc = "CANC Remnant Force, Colonist recruit. Random Rifle."
	equip_path = /datum/equipment_preset/canc/newblood

/obj/effect/landmark/humanaispawner/canc/newblood_machinegunner
	name = "CANC Colonist Recruit - MAR LMG"
	desc = "CANC Remnant Force, Colonist recruit. MAR LMG."
	equip_path = /datum/equipment_preset/canc/newblood_machinegunner

/obj/effect/landmark/humanaispawner/canc/rifleman
	name = "CANC Squad Rifleman"
	desc = "CANC Remnant Force rifleman, Random Rifle"
	equip_path = /datum/equipment_preset/canc/remnant

/obj/effect/landmark/humanaispawner/canc/machinegunner
	name = "CANC Squad Machinegunner"
	desc = "CANC Remnant Force rifleman, QYJ-72-I."
	equip_path = /datum/equipment_preset/canc/machinegunner

/obj/effect/landmark/humanaispawner/canc/at
	name = "CANC Squad Anti-Tank"
	desc = "CANC Remnant Force rifleman, Rocket Launcher."
	equip_path = /datum/equipment_preset/canc/at

/obj/effect/landmark/humanaispawner/canc/medic
	name = "CANC Squad Medic"
	desc = "CANC Remnant Force Medic, Random Rifle"
	equip_path = /datum/equipment_preset/canc/medic

/obj/effect/landmark/humanaispawner/canc/leader
	name = "CANC Squad Leader"
	desc = "CANC Remnant Force squad leader, Random Rifle"
	equip_path = /datum/equipment_preset/canc/remnant/leader

/obj/effect/landmark/humanaispawner/canc/marksman
	name = "CANC Squad Marksman"
	desc = "Type 88 DMR and a dream, make them pay for the Dog War."
	equip_path = /datum/equipment_preset/canc/remnant/marksman

/obj/effect/landmark/humanaispawner/canc/combat_android
	name = "CANC Combat Android"
	desc = "A CANC Combat Android, these are illegal and should be used sparingly."
	equip_path = /datum/equipment_preset/synth/working_joe/upp/combat/canc

//*****************************************************************************************************/
/// UA Rebels

/obj/effect/landmark/humanaispawner/clf/ua

/obj/effect/landmark/humanaispawner/clf/ua/guerilla
	name = "UA Rebel, Soldier (Pistol)"
	desc = "UA Rebel soldier with a random pistol."
	equip_path = /datum/equipment_preset/rebel/guerilla

/obj/effect/landmark/humanaispawner/clf/ua/soldier
	name = "UA Rebel, Soldier (Rifle)"
	desc = "Armed with a M20A, L42A or very rarely a M41A. Even more rarely, will only be equipped with a M1911, M4A3 or VP70."
	equip_path = /datum/equipment_preset/rebel/soldier

/obj/effect/landmark/humanaispawner/clf/ua/machinegunner
	name = "UA Rebel, Soldier (Machinegunner)"
	desc = "Armed with a HPR."
	equip_path = /datum/equipment_preset/rebel/soldier/machinegunner

/obj/effect/landmark/humanaispawner/clf/ua/shotgunner
	name = "UA Rebel, Soldier (Shotgunner)"
	desc = "Armed with either a M120 combat shotgun or a Ithaca-37 pump-shotgun."
	equip_path = /datum/equipment_preset/rebel/soldier/shotgun

/obj/effect/landmark/humanaispawner/clf/ua/flamer
	name = "UA Rebel, Soldier (Incinerator)"
	desc = "Armed with a M240A1 incinerator unit."
	equip_path = /datum/equipment_preset/rebel/soldier/flamer

/obj/effect/landmark/humanaispawner/clf/ua/engineer
	name = "UA Rebel, Anti-Tank"
	desc = "Armed with a few M83 SADARs."
	equip_path = /datum/equipment_preset/rebel/at

/obj/effect/landmark/humanaispawner/clf/ua/medic
	name = "UA Rebel Medic"
	desc = "Armed with either a M1911, M4A3 or VP70. Rarely, will be armed with a M20A, L42A or very rarely a M41A"
	equip_path = /datum/equipment_preset/rebel/medic

/obj/effect/landmark/humanaispawner/clf/ua/leader
	name = "UA Rebel Leader"
	desc = "Armed with a M41A."
	equip_path = /datum/equipment_preset/rebel/soldier/leader

/obj/effect/landmark/humanaispawner/clf/ua/cell_commander
	name = "UA Rebel Cell Commander"
	desc = "Armed with a M56A2 smartgun."
	equip_path = /datum/equipment_preset/rebel/commander

/obj/effect/landmark/humanaispawner/clf/ua/security_android
	name = "UA Rebel Combat Android"
	desc = "An illegal combat android for the UA rebel faction. Use this sparingly."
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/ua_rebel

//*****************************************************************************************************/
/// CMB

/obj/effect/landmark/humanaispawner/marshal

/obj/effect/landmark/humanaispawner/marshal/deputy
	name = "CMB Marshals - Deputy"
	desc = "A CMB Deputy with a revolver"
	equip_path = /datum/equipment_preset/cmb/deputy

/obj/effect/landmark/humanaispawner/marshal/deputy/spanish
	name = "CMB Marshals - Deputy Hispanic"
	desc = "A Hispanic deputy with a revolver"
	equip_path = /datum/equipment_preset/cmb/deputy/spanish

/obj/effect/landmark/humanaispawner/marshal/deputy/brazilian
	name = "CMB Marshals - Deputy Brazilian"
	desc = "A Brazilian Colonial Policeman with a revolver"
	equip_path = /datum/equipment_preset/cmb/deputy/brazilian

/obj/effect/landmark/humanaispawner/marshal/deputy/emergency
	name = "CMB Marshals - Deputy Emergency"
	desc = "A more heavily armed deputy with an SMG"
	equip_path = /datum/equipment_preset/cmb/deputy/emergency

/obj/effect/landmark/humanaispawner/marshal/emergency/spanish
	name = "CMB Marshals - Deputy Emergency Hispanic"
	desc = "A more heavily armed deputy with an SMG, Hispanic"
	equip_path = /datum/equipment_preset/cmb/deputy/emergency/spanish

/obj/effect/landmark/humanaispawner/marshal/emergency/brazilian
	name = "CMB Marshals - Deputy Emergency Brazilian"
	desc = "A more heavily armed policeman with an SMG, Brazilian"
	equip_path = /datum/equipment_preset/cmb/deputy/emergency/brazilian

/obj/effect/landmark/humanaispawner/marshal/deputy/emergency/shotgunner
	name = "CMB Marshals - Deputy Emergency Shotgunner"
	desc = "A better equipped deputy with a shotgun"
	equip_path = /datum/equipment_preset/cmb/deputy/emergency/shotgunner

/obj/effect/landmark/humanaispawner/marshal/deputy/emergency/shotgunner/spanish
	name = "CMB Marshals - Deputy Emergency Shotgunner Hispanic"
	desc = "A better equipped deputy with a shotgun, Hispanic"
	equip_path = /datum/equipment_preset/cmb/deputy/emergency/shotgunner/spanish

/obj/effect/landmark/humanaispawner/marshal/deputy/emergency/shotgunner/brazilian
	name = "CMB Marshals - Deputy Emergency Shotgunner Brazilian"
	desc = "A better equipped deputy with a shotgun, Brazilian"
	equip_path = /datum/equipment_preset/cmb/deputy/emergency/shotgunner/brazilian

//

/obj/effect/landmark/humanaispawner/marshal/marshal
	name = "CMB Marshals - Marshal"
	desc = "CMB Marshal, armed with a revolver"
	equip_path = /datum/equipment_preset/cmb/marshal

/obj/effect/landmark/humanaispawner/marshal/marshal/spanish
	name = "CMB Marshals - Marshal Hispanic"
	desc = "CMB Marshal, armed with a revolver, Hispanic"
	equip_path = /datum/equipment_preset/cmb/marshal/spanish

/obj/effect/landmark/humanaispawner/marshal/marshal/brazilian
	name = "CMB Marshals - Marshal Brazilian"
	desc = "A Captain of the Brazilian Colonial Military Police, armed with a revolver"
	equip_path = /datum/equipment_preset/cmb/marshal/brazilian

/obj/effect/landmark/humanaispawner/marshal/synth
	name = "CMB Marshals - Synth"
	desc = "CMB Marshals General Purpose Synthetic"
	equip_path = /datum/equipment_preset/cmb/synth

//

/obj/effect/landmark/humanaispawner/marshal/liaison
	name = "CMB Marshals - ICC Liaison"
	desc = "An Interstellar Commerce Commission Liaison. Unarmed"
	equip_path = /datum/equipment_preset/cmb/liaison

/obj/effect/landmark/humanaispawner/marshal/observer
	name = "CMB Marshals - Human Rights Observer"
	desc = "CMB Marshals human rights observer. Unarmed"
	equip_path = /datum/equipment_preset/cmb/observer

//*****************************************************************************************************/
/// Contractor

/obj/effect/landmark/humanaispawner/contractor/duty

/obj/effect/landmark/humanaispawner/contractor/duty/standard
	name = "Contractor - Standard"
	desc = "A non W-Y PMC, this contractor can come equipped with a wide array of rifles or shotguns."
	equip_path = /datum/equipment_preset/contractor/duty/standard

/obj/effect/landmark/humanaispawner/contractor/duty/engi
	name = "Contractor - Engineer"
	desc = "A non W-Y PMC, this engineer is equipped with a wide array of rifles or shotguns along with engineering equipment."
	equip_path = /datum/equipment_preset/contractor/duty/engi

/obj/effect/landmark/humanaispawner/contractor/duty/heavy
	name = "Contractor - Heavy"
	desc = "A non W-Y PMC, this standard is equipped with either a MAR LMG or HPR."
	equip_path = /datum/equipment_preset/contractor/duty/heavy

/obj/effect/landmark/humanaispawner/contractor/duty/leader
	name = "Contractor - Leader"
	desc = "A non W-Y PMC, the squad leader is outfitted similarly to the standard."
	equip_path = /datum/equipment_preset/contractor/duty/leader

/obj/effect/landmark/humanaispawner/contractor/duty/medic
	name = "Contractor - Medic"
	desc = "A non W-Y PMC, this medic is equipped with similar gear to the standard alongside medical equipment."
	equip_path = /datum/equipment_preset/contractor/duty/medic

/obj/effect/landmark/humanaispawner/contractor/duty/synth
	name = "Contractor - Synth"
	desc = "A support synthetic for a generic non WY PMC."
	equip_path = /datum/equipment_preset/contractor/duty/synth

//

/obj/effect/landmark/humanaispawner/contractor/covert/standard
	name = "Contractor - Covert Standard"
	desc = "The covert wing of a generic military contractor, they are issued a wide set of rifles or shotguns."
	equip_path = /datum/equipment_preset/contractor/covert/standard

/obj/effect/landmark/humanaispawner/contractor/covert/engi
	name = "Contractor - Covert Engi"
	desc = "A simiarly outfitted covert element to the standard contractor but with engineering equipment."
	equip_path = /datum/equipment_preset/contractor/covert/engi

/obj/effect/landmark/humanaispawner/contractor/covert/heavy
	name = "Contractor - Covert Heavy"
	desc = "A covert generic PMC armed with a MAR LMG or HPR."
	equip_path = /datum/equipment_preset/contractor/covert/heavy

/obj/effect/landmark/humanaispawner/contractor/covert/leader
	name = "Contractor - Covert Leader"
	desc = "Covert PMC leader armed with similar set of guns to the standard but with squadleader equipment."
	equip_path = /datum/equipment_preset/contractor/covert/leader

/obj/effect/landmark/humanaispawner/contractor/covert/medic
	name = "Contractor - Covert Medic"
	desc = "A covert PMC medic, with a similar geatset to the standard but with more medical equipment."
	equip_path = /datum/equipment_preset/contractor/covert/medic

/obj/effect/landmark/humanaispawner/contractor/covert/synth
	name = "Contractor - Covert Synth"
	desc = "Covert PMC support synthetic."
	equip_path = /datum/equipment_preset/contractor/covert/synth

//*****************************************************************************************************/
/// Mercs

/obj/effect/landmark/humanaispawner/mercenaries

/obj/effect/landmark/humanaispawner/mercenaries/grunt
	name = "Black Dragoons Grunt (Technician)"
	desc = "A basic grunt of the Black Dragoons mercenary company, mainly used for auxiliary services such as logistics and engineering."
	equip_path = /datum/equipment_preset/mercenary/grunt

/obj/effect/landmark/humanaispawner/mercenaries/grunt/doctor
	name = "Black Dragoons Grunt (Doctor)"
	desc = "A basic grunt of the Black Dragoons mercenary company, mainly used for medical purposes."
	equip_path = /datum/equipment_preset/mercenary/grunt/doctor

/obj/effect/landmark/humanaispawner/mercenaries/pilot
	name = "Black Dragoons Pilot"
	desc = "A pilot for the Black Dragoons mercenary company, who drives/flies most of their vehicles."
	equip_path = /datum/equipment_preset/mercenary/pilot

/obj/effect/landmark/humanaispawner/mercenaries/pilot/driver
	name = "Black Dragoons Driver"
	desc = "A vehicle crewman for the Black Dragoons. Often rather rare due to the lack of larger vehicles within the Dragoon's range."
	equip_path = /datum/equipment_preset/mercenary/pilot/driver

/obj/effect/landmark/humanaispawner/mercenaries/sentinel
	name = "Black Dragoons Sentinel (Patrol, SMG)"
	desc = "The primary infantryman for the Black Dragoons, equipped with a modified FP9000 SMG and pistol."
	equip_path = /datum/equipment_preset/mercenary/sentinel

/obj/effect/landmark/humanaispawner/mercenaries/sentinel/response
	name = "Black Dragoons Sentinel (Response, SMG)"
	desc = "The primary infantryman for the Black Dragoons, equipped to act as a rapid response force against hostile action. Equipped with a modified FP9000 and pistol."
	equip_path = /datum/equipment_preset/mercenary/sentinel/response

/obj/effect/landmark/humanaispawner/mercenaries/sentinel/response/carbine
	name = "Black Dragoons Sentinel (Response, Carbine)"
	desc = "The primary infantryman for the Black Dragoons, equipped to act as a rapid response force against hostile action. Equipped with an M20CW Carbine and pistol."
	equip_path = /datum/equipment_preset/mercenary/sentinel/response/carbine

/obj/effect/landmark/humanaispawner/mercenaries/sentinel/response/medic
	name = "Black Dragoons Sentinel (Response, Medic)"
	desc = "The primary infantryman for the Black Dragoons, equipped to act as a rapid response force against hostile action. This one is equipped with medical supplies and to act as the squad's medic."
	equip_path = /datum/equipment_preset/mercenary/sentinel/response/medic

/obj/effect/landmark/humanaispawner/mercenaries/sentinel/response/space
	name = "Black Dragoons Sentinel (Space)"
	desc = "Some more better trained and equipped sentinels, equipped to do space operations and work."
	equip_path = /datum/equipment_preset/mercenary/sentinel/space

/obj/effect/landmark/humanaispawner/mercenaries/supervisor
	name = "Black Dragoons Supervisor (Unequipped)"
	desc = "An NCO for the Black Dragoons, mainly for small facility supervision and platoon leadership."
	equip_path = /datum/equipment_preset/mercenary/supervisor

/obj/effect/landmark/humanaispawner/mercenaries/supervisor/equipped
	name = "Black Dragoons Supervisor (Equipped)"
	desc = "An NCO for the Black Dragoons, armed and ready for some basic patrols and on-site incidents. Armed with an M20CW Carbine and revolver."
	equip_path = /datum/equipment_preset/mercenary/supervisor/patrol

/obj/effect/landmark/humanaispawner/mercenaries/supervisor/equipped/response
	name = "Black Dragoons Supervisor (Response)"
	desc = "An NCO for the Black Dragoons, armed and ready to lead their platoon to victory. Equipped with a modified M20CW Carbine and revolver."
	equip_path = /datum/equipment_preset/mercenary/supervisor/response

/obj/effect/landmark/humanaispawner/mercenaries/synth
	name = "Black Dragoons Synth (Patrol)"
	desc = "A standard Gen II Synthetic employed under the Black Dragoons. Not especially well equipped but able to continue their duties."
	equip_path = /datum/equipment_preset/mercenary/synth

/obj/effect/landmark/humanaispawner/mercenaries/synth/response
	name = "Black Dragoons Synth (Response)"
	desc = "A standard Gen II Synthetic employed under the Black Dragoons. This one is better equipped for it's duties as a QRF Support."
	equip_path = /datum/equipment_preset/mercenary/synth/response

/obj/effect/landmark/humanaispawner/mercenaries/bulwark
	name = "Black Dragoons Bulwark (Heavy Response Breacher)"
	desc = "A heavily armoured and well equipped operative meant to act as shock troops against hostiles that Sentinels are unable to handle. This one has a shotgun."
	equip_path = /datum/equipment_preset/mercenary/bulwark

/obj/effect/landmark/humanaispawner/mercenaries/bulwark/machinegun
	name = "Black Dragoons Bulwark (Heavy Response Suppressor)"
	desc = "A heavily armoured and well equipped operative meant to act as shock troops against hostiles that Sentinels are unable to handle. This one has a machinegun."
	equip_path = /datum/equipment_preset/mercenary/bulwark/machinegun

/obj/effect/landmark/humanaispawner/mercenaries/infiltrator
	name = "Black Dragoons Infiltrator"
	desc = "The Black Dragoons' only force of stealth operatives, equipped for maximum manuverability and to strike fear in anyone who gets in their way."
	equip_path = /datum/equipment_preset/mercenary/infiltrator

//*****************************************************************************************************/
/// Elite Mercs

/obj/effect/landmark/humanaispawner/elite_merc

/obj/effect/landmark/humanaispawner/elite_merc/standard
	name = "Elite Merc - Standard"
	desc = "Elite Merc Standard, these generic 'elite' PMCs are tough to kill, armed with M41As, Elite M39s and shotguns"
	equip_path = /datum/equipment_preset/other/elite_merc/standard

/obj/effect/landmark/humanaispawner/elite_merc/engineer
	name = "Elite Merc - Engineer"
	desc = "A simiarly outfitted generic 'elite' merc, this one should spawn only with shotguns and engineering gear"
	equip_path = /datum/equipment_preset/other/elite_merc/engineer

/obj/effect/landmark/humanaispawner/elite_merc/heavy
	name = "Elite Merc - Heavy"
	desc = "A generic 'elite' merc, be warned this one has a minigun"
	equip_path = /datum/equipment_preset/other/elite_merc/heavy

/obj/effect/landmark/humanaispawner/elite_merc/leader
	name = "Elite Merc - Leader"
	desc = "A squad leader with a similar gearset to the standard, will mostly spawn with a rifle"
	equip_path = /datum/equipment_preset/other/elite_merc/leader

/obj/effect/landmark/humanaispawner/elite_merc/medic
	name = "Elite Merc - Medic"
	desc = "An elite merc medic, will spawn with a rifle and medical equipment"
	equip_path = /datum/equipment_preset/other/elite_merc/medic

//*****************************************************************************************************/
/// Malf Synths

/obj/effect/landmark/humanaispawner/malfunctioning_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth
	name = "Working Joe - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/engi
	name = "Hazard Joe - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/engi/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/upp
	name = "Dzho Automaton - Malfunctioning"
	desc = "A damaged and hostile Dzho Automaton"
	equip_path = /datum/equipment_preset/synth/working_joe/upp/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/freelancer_combat
	name = "Freelancer Converted Combat Android - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/freelancer/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/wy_combat
	name = "W-Y Combat Android - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/wy/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/pmc_combat
	name = "W-Y PMC Combat Android - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/pmc/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/ua_rebel_combat
	name = "UA Rebel Converted Combat Joe - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/ua_rebel/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/twe_rebel_combat
	name = "TWE Rebel Converted Combat Joe - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/upp/combat/twe_rebel/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/canc_rebel_combat
	name = "CANC Combat Android - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/upp/combat/canc/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/upp_combat
	name = "UPP Combat Android - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/upp/combat/malf_synth

/obj/effect/landmark/humanaispawner/malfunctioning_synth/malf_synth/ua_combat
	name = "UA Combat Android - Malfunctioning"
	desc = "A damaged and hostile working joe"
	equip_path = /datum/equipment_preset/synth/working_joe/security_android/malf_synth

//*****************************************************************************************************/
/// Royal Marines

/obj/effect/landmark/humanaispawner/twe

/obj/effect/landmark/humanaispawner/twe/standard
	name = "TWE Royal Marines Commando - Standard"
	desc = "Standard Royal Marine armed with a rifle."
	equip_path = /datum/equipment_preset/royal_marine/standard

/obj/effect/landmark/humanaispawner/twe/machinegunner
	name = "TWE Royal Marines Commando - Machinegunner"
	desc = "Machinegunner, armed with a holotargeting smartgun."
	equip_path = /datum/equipment_preset/royal_marine/machinegun

/obj/effect/landmark/humanaispawner/twe/marksman
	name = "TWE Royal Marines Commando - Marksman"
	desc = "Marksman, armed with a scoped rifle. Very dangerous."
	equip_path = /datum/equipment_preset/royal_marine/sniper/light

/obj/effect/landmark/humanaispawner/twe/medic
	name = "TWE Royal Marines Commando - Medical Assistant"
	desc = "Unit medic armed with a rifle and equipped with ample medical supplies."
	equip_path = /datum/equipment_preset/royal_marine/medic

/obj/effect/landmark/humanaispawner/twe/engi
	name = "TWE Royal Marines Commando - Assault Engineer"
	desc = "Unit tech-specialist armed with a rifle and equipped with ample engineering supplies."
	equip_path = /datum/equipment_preset/royal_marine/engi

/obj/effect/landmark/humanaispawner/twe/teamleader
	name = "TWE Royal Marines Commando - Section Leader"
	desc = "Section leader, simiarly outfitted to the standard royal marine."
	equip_path = /datum/equipment_preset/royal_marine/leader

/obj/effect/landmark/humanaispawner/twe/lieutenant
	name = "TWE Royal Marines Commando - Lieutenant"
	desc = "Lieutenant, similarly outfitted to the section leader."
	equip_path = /datum/equipment_preset/royal_marine/lieuteant

//*****************************************************************************************************/
/// UACG

/obj/effect/landmark/humanaispawner/uacg

/obj/effect/landmark/humanaispawner/uacg/regular
	name = "UACG Trooper"
	desc = "The average UACG Trooper, somewhat trained and equipped enough to deal with most threats the Colonies the encounter."
	equip_path = /datum/equipment_preset/colonist/security/guard

/obj/effect/landmark/humanaispawner/uacg/regular/tech
	name = "UACG Technician"
	desc = "The UACG Technician, given some tools and supplies to do a bit more than just shoot n' pray."
	equip_path = /datum/equipment_preset/colonist/security/guard/tech

/obj/effect/landmark/humanaispawner/uacg/regular/medic
	name = "UACG Medic"
	desc = "The UACG Medic, given some supplies to tend to wounded and evacuate them to some real doctors."
	equip_path = /datum/equipment_preset/colonist/security/guard/medic

/obj/effect/landmark/humanaispawner/uacg/regular/lead
	name = "UACG Leader"
	desc = "The UACG Unit Leader, given some basic leadership training and more experienced than most troopers."
	equip_path = /datum/equipment_preset/colonist/security/guard/nco

/obj/effect/landmark/humanaispawner/uacg/regular/co
	name = "UACG Commander"
	desc = "The Commander of the UACG forces in a local area, normally previously veterans of other branches such as the Marines."
	equip_path = /datum/equipment_preset/colonist/security/guard/co

//*****************************************************************************************************/
/// Colonist

/obj/effect/landmark/humanaispawner/colonist

/obj/effect/landmark/humanaispawner/colonist/security
	name = "Colonist - Security"
	desc = "Colonist - Generic civillian security armed with a pistol"
	equip_path = /datum/equipment_preset/colonist/security

/obj/effect/landmark/humanaispawner/colonist/security/spanish
	name = "Colonist - Security Spanish"
	desc = "Colonist - Generic civillian security armed with a pistol, spanish"
	equip_path = /datum/equipment_preset/colonist/security/spanish

/obj/effect/landmark/humanaispawner/colonist/security/trijent
	name = "Colonist - Security Trijent"
	desc = "Colonist - Trijent security officer armed with a pistol"
	equip_path = /datum/equipment_preset/colonist/security/trijent

/obj/effect/landmark/humanaispawner/colonist/security/trijent/japanese
	name = "Colonist - Security Trijent Japanese"
	desc = "Colonist - Trijent security officer armed with a pistol, Japanese"
	equip_path = /datum/equipment_preset/colonist/security/trijent/japanese

/obj/effect/landmark/humanaispawner/colonist/security/prison
	name = "Colonist - Security Prison"
	desc = "Colonist - A US Federal prison guard armed with a pistol"
	equip_path = /datum/equipment_preset/colonist/security/prison

/obj/effect/landmark/humanaispawner/colonist/security/prison/spanish
	name = "Colonist - Security Prison Japanese"
	desc = "Colonist - A US Federal prison guard armed with a pistol, spanish"
	equip_path = /datum/equipment_preset/colonist/security/prison/spanish

/obj/effect/landmark/humanaispawner/colonist/security/colonial
	name = "Colonist - US Colonial Guard"
	desc = "Colonist - Also known as a UACG Militaman these are the rear echelon backbone of the UA, armed with an M20"
	equip_path = /datum/equipment_preset/colonist/security/guard

/obj/effect/landmark/humanaispawner/colonist/security/colonial/spanish
	name = "Colonist - US Colonial Guard Spanish"
	desc = "Colonist - Also known as a UACG Militaman these are the rear echelon backbone of the UA, armed with an M20, spanish"
	equip_path = /datum/equipment_preset/colonist/security/guard/spanish

/obj/effect/landmark/humanaispawner/colonist/bluecollar
	name = "Colonist - Bluecollar"
	desc = "Colonist - Bluecollar worker, unarmed"
	equip_path = /datum/equipment_preset/colonist/bluecollar

/obj/effect/landmark/humanaispawner/colonist/bluecollar/spanish
	name = "Latam Colonist - Bluecollar"
	desc = "Colonist - Bluecollar worker, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/bluecollar/spanish

/obj/effect/landmark/humanaispawner/colonist/bluecollar/japanese
	name = "TWE Colonist - Bluecollar"
	desc = "Colonist - Bluecollar worker, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/bluecollar/japanese

/obj/effect/landmark/humanaispawner/colonist/miner
	name = "Colonist - Miner"
	desc = "Colonist - Unarmed miner"
	equip_path = /datum/equipment_preset/colonist/miner

/obj/effect/landmark/humanaispawner/colonist/miner/japanese
	name = "TWE Colonist - Miner"
	desc = "Colonist - Unarmed miner, japanese"
	equip_path = /datum/equipment_preset/colonist/miner/japanese

/obj/effect/landmark/humanaispawner/colonist/miner/spanish
	name = "Latam Colonist - Miner"
	desc = "Colonist - unarmed latam colonist, spanish"
	equip_path = /datum/equipment_preset/colonist/miner/spanish

/obj/effect/landmark/humanaispawner/colonist/construction
	name = "Colonist - Construction"
	desc = "Colonist - unarmed construction worker"
	equip_path = /datum/equipment_preset/colonist/construction

/obj/effect/landmark/humanaispawner/colonist/construction/japanese
	name = "TWE Colonist - Construction"
	desc = "Colonist - unarmed construction worker, japanese"
	equip_path = /datum/equipment_preset/colonist/construction/japanese

/obj/effect/landmark/humanaispawner/colonist/construction/spanish
	name = "Latam Colonist - Construction"
	desc = "Colonist - unarmed construction worker, spanish"
	equip_path = /datum/equipment_preset/colonist/construction/spanish

/obj/effect/landmark/humanaispawner/colonist/roughneck
	name = "Colonist - Roughneck"
	desc = "Colonist - unarmed roughnecker, they are responsible for surveying uncharted worlds"
	equip_path = /datum/equipment_preset/colonist/roughneck

/obj/effect/landmark/humanaispawner/colonist/roughneck/japanese
	name = "TWE Colonist - Roughneck"
	desc = "Colonist - unarmed roughnecker, they are responsible for surveying uncharted worlds, japanse"
	equip_path = /datum/equipment_preset/colonist/roughneck/japanese

/obj/effect/landmark/humanaispawner/colonist/roughneck/spanish
	name = "Latam Colonist - Roughneck"
	desc = "Colonist - unarmed roughnecker, they are responsible for surveying uncharted worlds, spanish"
	equip_path = /datum/equipment_preset/colonist/roughneck/spanish

/obj/effect/landmark/humanaispawner/colonist/cook
	name = "Colonist - Cook"
	desc = "Colonist - A colonist cook, unarmed"
	equip_path = /datum/equipment_preset/colonist/cook

/obj/effect/landmark/humanaispawner/colonist/cook/japanese
	name = "TWE Colonist - Cook"
	desc = "Colonist - A colonist cook, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/cook/japanese

/obj/effect/landmark/humanaispawner/colonist/cook/spanish
	name = "Latam Colonist - Cook"
	desc = "Colonist - A colonist cook, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/cook/spanish

/obj/effect/landmark/humanaispawner/colonist/chef
	name = "Colonist - Chef"
	desc = "Colonist - A colonist chief, unarmed"
	equip_path = /datum/equipment_preset/colonist/chef

/obj/effect/landmark/humanaispawner/colonist/chef/spanish
	name = "Latam Colonist - Chef"
	desc = "Colonist - A colonist chief, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/chef/spanish

/obj/effect/landmark/humanaispawner/colonist/chef/japanese
	name = "TWE Colonist - Chef"
	desc = "Colonist - A colonist chief, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/chef/japanese

/obj/effect/landmark/humanaispawner/colonist/priest
	name = "Colonist - Priest"
	desc = "Colonist - A colonist priest, armed with faith alone"
	equip_path = /datum/equipment_preset/colonist/priest

/obj/effect/landmark/humanaispawner/colonist/priest/japanese
	name = "TWE Colonist - Priest"
	desc = "Colonist - A colonist priest, armed with faith alone, japanese"
	equip_path = /datum/equipment_preset/colonist/priest/japanese

/obj/effect/landmark/humanaispawner/colonist/priest/spanish
	name = "Latam Colonist - Priest"
	desc = "Colonist - A colonist priest, armed with faith alone, spanish"
	equip_path = /datum/equipment_preset/colonist/priest/spanish

/obj/effect/landmark/humanaispawner/colonist/whitecollar
	name = "Colonist - Whitecollar"
	desc = "Colonist - UA Whitecollar worker, armed with his pen and daily monotony"
	equip_path = /datum/equipment_preset/colonist/whitecollar

/obj/effect/landmark/humanaispawner/colonist/whitecollar/japanese
	name = "TWE Colonist - Whitecollar"
	desc = "Colonist - TWE Whitecollar worker, armed with his pen and daily monotony"
	equip_path = /datum/equipment_preset/colonist/whitecollar/japanese

/obj/effect/landmark/humanaispawner/colonist/whitecollar/spanish
	name = "Latam Colonist - Whitecollar"
	desc = "Colonist - Latam Whitecollar worker, armed with his pen and daily monotony"
	equip_path = /datum/equipment_preset/colonist/whitecollar/spanish

/obj/effect/landmark/humanaispawner/colonist/whitecollar/exec
	name = "Colonist - Executive"
	desc = "Colonist - Unarmed executive"
	equip_path = /datum/equipment_preset/colonist/whitecollar/exec

/obj/effect/landmark/humanaispawner/colonist/whitecollar/exac/japanse
	name = "TWE Colonist - Executive"
	desc = "Colonist - Unarmed executive, japanese"
	equip_path = /datum/equipment_preset/colonist/whitecollar/exec/japanese

/obj/effect/landmark/humanaispawner/colonist/whitecollar/exac/spanish
	name = "Latam Colonist - Executive"
	desc = "Colonist - Unarmed executive, spanish"
	equip_path = /datum/equipment_preset/colonist/whitecollar/exec/spanish

/obj/effect/landmark/humanaispawner/colonist/researcher
	name = "Colonist - Researcher"
	desc = "Colonist - Civillian Researcher, unarmed"
	equip_path = /datum/equipment_preset/colonist/researcher

/obj/effect/landmark/humanaispawner/colonist/researcher/japanese
	name = "TWE Colonist - Researcher"
	desc = "Colonist - Civillian Researcher, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/researcher/japanese

/obj/effect/landmark/humanaispawner/colonist/researcher/spanish
	name = "Latam Colonist - Researcher"
	desc = "Colonist - Civillian Researcher, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/researcher/spanish

/obj/effect/landmark/humanaispawner/colonist/doctor
	name = "Colonist - Doctor"
	desc = "Colonist - Civillian doctor, unarmed"
	equip_path = /datum/equipment_preset/colonist/doctor

/obj/effect/landmark/humanaispawner/colonist/doctor/spanish
	name = "Latam Colonist - Doctor"
	desc = "Colonist - Civillian doctor, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/doctor/spanish

/obj/effect/landmark/humanaispawner/colonist/doctor/japanese
	name = "TWE Colonist - Doctor"
	desc = "Colonist - Civillian doctor, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/doctor/japanese

/obj/effect/landmark/humanaispawner/colonist/doctor/scrubs
	name = "Colonist - Nurse"
	desc = "Colonist - Civillian nurse, unarmed"
	equip_path = /datum/equipment_preset/colonist/doctor/scrubs

/obj/effect/landmark/humanaispawner/colonist/doctor/scrubs/spanish
	name = "Latam Colonist - Nurse"
	desc = "Colonist - Civillian nurse, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/doctor/scrubs/spanish

/obj/effect/landmark/humanaispawner/colonist/doctor/scrubs/japanese
	name = "TWE Colonist - Nurse"
	desc = "Colonist - Civillian nurse, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/doctor/scrubs/japanese

/obj/effect/landmark/humanaispawner/colonist/admin
	name = "Colonist - Admin Tech"
	desc = "Colonist - A civillian administration technician,unarmed"
	equip_path = /datum/equipment_preset/colonist/admin

/obj/effect/landmark/humanaispawner/colonist/admin/japanese
	name = "TWE Colonist - Admin Tech"
	desc = "Colonist - A civillian administration technician, japanese,unarmed"
	equip_path = /datum/equipment_preset/colonist/admin/japanese

/obj/effect/landmark/humanaispawner/colonist/admin/spanish
	name = "Latam Colonist - Admin Tech"
	desc = "Colonist - A civillian administration technician, spanish,unarmed"
	equip_path = /datum/equipment_preset/colonist/admin/spanish

/obj/effect/landmark/humanaispawner/colonist/cargo
	name = "Colonist - Cargo"
	desc = "Colonist - Civillian cargo tech, unarmed"
	equip_path = /datum/equipment_preset/colonist/cargo

/obj/effect/landmark/humanaispawner/colonist/cargo/japanese
	name = "TWE Colonist - Cargo"
	desc = "Colonist - Civillian cargo tech, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/cargo/japanese

/obj/effect/landmark/humanaispawner/colonist/cargo/spanish
	name = "Latam Colonist - Cargo"
	desc = "Colonist - Civillian cargo tech, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/cargo/spanish

/obj/effect/landmark/humanaispawner/colonist/technician
	name = "Colonist - Technician"
	desc = "Colonist - Engineering technician, unarmed"
	equip_path = /datum/equipment_preset/colonist/technician

/obj/effect/landmark/humanaispawner/colonist/technician/spanish
	name = "Latam Colonist - Technician"
	desc = "Colonist - Engineering technician, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/technician/spanish

/obj/effect/landmark/humanaispawner/colonist/technician/japanese
	name = "TWE Colonist - Technician"
	desc = "Colonist - Engineering technician, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/technician/japanese

/obj/effect/landmark/humanaispawner/colonist/engineer
	name = "Colonist - Engineer"
	desc = "Colonist - A civillian engineer, unarmed"
	equip_path = /datum/equipment_preset/colonist/engineer

/obj/effect/landmark/humanaispawner/colonist/engineer/japanese
	name = "TWE Colonist - Engineer"
	desc = "Colonist - A civillian engineer, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/engineer/japanese

/obj/effect/landmark/humanaispawner/colonist/engineer/spanish
	name = "Latam Colonist - Engineer"
	desc = "Colonist - A civillian engineer, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/engineer/spanish

/obj/effect/landmark/humanaispawner/colonist/operations
	name = "Colonist - Operations Tech"
	desc = "Colonist - Operations techs work in colony operations centers, unarmed"
	equip_path = /datum/equipment_preset/colonist/operations

/obj/effect/landmark/humanaispawner/colonist/operations/japanese
	name = "TWE Colonist - Operations Tech"
	desc = "Colonist - Operations techs work in colony operations centers, unarmed, japanese"
	equip_path = /datum/equipment_preset/colonist/operations/japanese

/obj/effect/landmark/humanaispawner/colonist/operations/spanish
	name = "Latam Colonist - Operations Tech"
	desc = "Colonist - Operations techs work in colony operations centers, unarmed, spanish"
	equip_path = /datum/equipment_preset/colonist/operations/spanish

/obj/effect/landmark/humanaispawner/colonist/prisoner
	name = "Colonist - Prisoner"
	desc = "Colonist - A generic unarmed prisoner"
	equip_path = /datum/equipment_preset/colonist/prisoner

/obj/effect/landmark/humanaispawner/colonist/prisoner/japanese
	name = "TWE Colonist - Prisoner"
	desc = "Colonist - A generic unarmed prisoner, japanese"
	equip_path = /datum/equipment_preset/colonist/prisoner/japanese

/obj/effect/landmark/humanaispawner/colonist/prisoner/spanish
	name = "Latam Colonist - Prisoner"
	desc = "Colonist - A generic unarmed prisoner, spanish"
	equip_path = /datum/equipment_preset/colonist/prisoner/spanish

//*****************************************************************************************************/
/// Zombie

/obj/effect/landmark/humanaispawner/zombie

/obj/effect/landmark/humanaispawner/zombie/generic
	name = "Zombie - Generic"
	desc = "Brains"
	equip_path = /datum/equipment_preset/zombie/generic

/obj/effect/landmark/humanaispawner/zombie/ua_marine
	name = "Zombie - USCM Marine"
	desc = "Braaaaaains"
	equip_path = /datum/equipment_preset/zombie/ua_marine

/obj/effect/landmark/humanaispawner/zombie/ua_marine_eva
	name = "Zombie - USCM EVA Marine"
	desc = "Braaaaaaains"
	equip_path = /datum/equipment_preset/zombie/ua_marine_eva

/obj/effect/landmark/humanaispawner/zombie/bluecollar
	name = "Zombie - Blue-Collar"
	desc = "Braaaaaaaains"
	equip_path = /datum/equipment_preset/zombie/bluecollar

/obj/effect/landmark/humanaispawner/zombie/upp_rifleman
	name = "Zombie - UPP Squad Rifleman"
	desc = "Braaaaaaaaains"
	equip_path = /datum/equipment_preset/zombie/upp_rifleman

/obj/effect/landmark/humanaispawner/zombie/upp_rifleman_eva
	name = "Zombie - UPP EVA Marine"
	desc = "Braaaaaaaaaains"
	equip_path = /datum/equipment_preset/zombie/upp_eva

/obj/effect/landmark/humanaispawner/zombie/upp_colonist
	name = "Zombie - UPP Civilian"
	desc = "Braaaaaaaaaaains"
	equip_path = /datum/equipment_preset/zombie/upp_colonist

/obj/effect/landmark/humanaispawner/zombie/pmc
	name = "Zombie - PMC"
	desc = "Braaaaaaaaaaaaaains"
	equip_path = /datum/equipment_preset/zombie/pmc_standard

/obj/effect/landmark/humanaispawner/zombie/researcher
	name = "Zombie - Researcher"
	desc = "Braaaaaiiins"
	equip_path = /datum/equipment_preset/zombie/researcher

/obj/effect/landmark/humanaispawner/zombie/cmb
	name = "Zombie - CMB"
	desc = "Braaaaaiiiiiins"
	equip_path = /datum/equipment_preset/zombie/cmb

/obj/effect/landmark/humanaispawner/zombie/guard
	name = "Zombie - US Colonial Guard"
	desc = "Braaaaainsssssss"
	equip_path = /datum/equipment_preset/zombie/guard

/obj/effect/landmark/humanaispawner/zombie/canc
	name = "Zombie - CANC"
	desc = "Communist Brains"
	equip_path = /datum/equipment_preset/zombie/canc

/obj/effect/landmark/humanaispawner/zombie/cbrn
	name = "Zombie - USCM CBRN"
	desc = "Uuuggh..."
	equip_path = /datum/equipment_preset/zombie/cbrn
