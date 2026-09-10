#define get_job_playtime(client, job) (client.player_data? LAZYACCESS(client.player_data.playtimes, job)? client.player_data.playtimes[job].total_minutes MINUTES_TO_DECISECOND : 0 : 0)
#define GET_MAPPED_ROLE(title) (GLOB.RoleAuthority?.role_mappings[title] ? GLOB.RoleAuthority.role_mappings[title] : GLOB.RoleAuthority.roles_by_name[title])
#define GET_DEFAULT_ROLE(title) (GLOB.RoleAuthority?.default_roles[title] ? GLOB.RoleAuthority.default_roles[title] : title)

// Squad name defines
#define SQUAD_MARINE_1 "Sun Riders"
#define SQUAD_MARINE_2 "Sun Riders B-Sct"
#define SQUAD_MARINE_3 "Charlie"
#define SQUAD_MARINE_4 "Delta"
#define SQUAD_MARINE_5 "Echo"
#define SQUAD_MARINE_CRYO "Foxtrot"
#define SQUAD_MARINE_INTEL "Intel"
#define SQUAD_SOF "SOF"
#define SQUAD_CBRN "CBRN"
#define SQUAD_FORECON "FORECON"
#define SQUAD_SOLAR "Solar Devils"
#define SQUAD_ARMY "US Army"
#define SQUAD_UPP "Red Dawn"
#define SQUAD_UPP_2 "Golden Embers"
#define SQUAD_PMCPLT "AZURE-15"
#define SQUAD_PMCPLT_2 "VIRIDIAN-22"
#define SQUAD_PMCPLT_SMALL "AZURE-16"
#define SQUAD_RMC "Gamma Troop"
#define SQUAD_LRRP "Snake Eaters"
#define SQUAD_LRRP_2 "Ocelot Grapplers"

// Job name defines
#define JOB_SQUAD_MARINE "Rifleman"
#define JOB_SQUAD_LEADER "Section Sergeant"
#define JOB_SQUAD_ENGI "Combat Engineer"
#define JOB_SQUAD_MEDIC "Corpsman"
#define JOB_SQUAD_SPECIALIST "Weapons Specialist"
#define JOB_SQUAD_SPOTTER "Spotter"
#define JOB_SQUAD_LOADER "Weapons Loader"
#define JOB_SQUAD_TEAM_LEADER "Squad Leader"
#define JOB_SQUAD_SMARTGUN "Smartgunner"
#define JOB_SQUAD_ROLES /datum/timelock/squad
#define JOB_SQUAD_ROLES_LIST list(JOB_SQUAD_MARINE, JOB_SQUAD_LEADER, JOB_SQUAD_ENGI, JOB_SQUAD_MEDIC, JOB_SQUAD_SPECIALIST, JOB_SQUAD_SMARTGUN, JOB_SQUAD_TEAM_LEADER)

#define JOB_SQUAD_MARINE_UPP "Infantryman"
#define JOB_SQUAD_LEADER_UPP "Platoon Sergeant"
#define JOB_SQUAD_MEDIC_UPP "Platoon Sanitar"
#define JOB_SQUAD_TEAM_LEADER_UPP "Squad Sergeant"
#define JOB_SQUAD_SMARTGUN_UPP "Machinegunner"
#define JOB_SO_UPP "UPP Platoon Commander"

#define JOB_SQUAD_TEAM_LEADER_FORECON "Assistant Recon Squad Leader"
#define JOB_SQUAD_LEADER_FORECON  "Recon Squad Leader"
#define JOB_SQUAD_MEDIC_FORECON "Recon Corpsman"
#define JOB_SQUAD_RTO "Recon Radio Telephone Operator"
#define JOB_SQUAD_MARINE_FORECON "Recon Rifleman"
#define JOB_SQUAD_SMARTGUN_FORECON "Recon Smartgunner"

GLOBAL_LIST_INIT(job_squad_roles, JOB_SQUAD_ROLES_LIST)

#define JOB_COLONIST "Colonist"
#define JOB_PASSENGER "Passenger"
#define JOB_SURVIVOR "Survivor"
#define JOB_SYNTH_SURVIVOR "Synth Survivor"
#define JOB_CO_SURVIVOR "CO Survivor"

#define ANY_SURVIVOR "Any Survivor"
#define CIVILIAN_SURVIVOR "Civilian Survivor"
#define SECURITY_SURVIVOR "Security Survivor"
#define SCIENTIST_SURVIVOR "Scientist Survivor"
#define MEDICAL_SURVIVOR "Medical Survivor"
#define ENGINEERING_SURVIVOR "Engineering Survivor"
#define CORPORATE_SURVIVOR "Corporate Survivor"
#define HOSTILE_SURVIVOR "Hostile Survivor" //AKA Marine Killers assuming they survive. Will do cultist survivor at some point.
#define SURVIVOR_VARIANT_LIST list(ANY_SURVIVOR = "Any", CIVILIAN_SURVIVOR = "Civ", SECURITY_SURVIVOR = "Sec", SCIENTIST_SURVIVOR = "Sci", MEDICAL_SURVIVOR = "Med", ENGINEERING_SURVIVOR = "Eng", CORPORATE_SURVIVOR = "W-Y", HOSTILE_SURVIVOR = "CLF")

//-1 is infinite amount, these are soft caps and can be bypassed by randomization
#define MAX_SURVIVOR_PER_TYPE list(ANY_SURVIVOR = -1, CIVILIAN_SURVIVOR = -1, SECURITY_SURVIVOR = 2, SCIENTIST_SURVIVOR = 2, MEDICAL_SURVIVOR = 3, ENGINEERING_SURVIVOR = 4, CORPORATE_SURVIVOR = 2, HOSTILE_SURVIVOR = 1)

#define SPAWN_PRIORITY_VERY_HIGH 1
#define SPAWN_PRIORITY_HIGH 2
#define SPAWN_PRIORITY_MEDIUM 3
#define SPAWN_PRIORITY_LOW 4
#define SPAWN_PRIORITY_VERY_LOW 5
#define LOWEST_SPAWN_PRIORITY 5

#define JOB_CMO "Chief Medical Officer"
#define JOB_DOCTOR "Doctor"
#define JOB_SURGEON "Surgeon"

#define JOB_NURSE "Nurse"
#define JOB_RESEARCHER "Researcher"
#define JOB_MEDIC_ROLES  /datum/timelock/medic
#define JOB_MEDIC_ROLES_LIST list(JOB_SQUAD_MEDIC, JOB_CMO, JOB_DOCTOR, JOB_NURSE, JOB_RESEARCHER, JOB_SURGEON)

#define JOB_CORPORATE_LIAISON "Corporate Liaison"
#define JOB_COMBAT_REPORTER "Combat Correspondent"
#define JOB_MESS_SERGEANT "Mess Technician"
#define JOB_SYNTH "Synthetic"
#define JOB_WORKING_JOE "Working Joe"

#define JOB_CO "Commanding Officer"
#define JOB_XO "Executive Officer"
#define JOB_SO "Platoon Commander"
#define JOB_COMMAND_ROLES /datum/timelock/command
#define JOB_COMMAND_ROLES_LIST   list(JOB_CO, JOB_XO, JOB_SO)
GLOBAL_LIST_INIT(job_command_roles, JOB_COMMAND_ROLES_LIST)

#define JOB_AUXILIARY_OFFICER "Auxiliary Support Officer"
#define JOB_CAS_PILOT "Gunship Pilot"
#define JOB_DROPSHIP_PILOT "Dropship Pilot"
#define JOB_TANK_CREW "Tank Crew"
#define JOB_DROPSHIP_CREW_CHIEF "Dropship Crew Chief"
#define JOB_INTEL "Intelligence Officer"
#define JOB_DROPSHIP_ROLES   /datum/timelock/dropship
#define JOB_DROPSHIP_ROLES_LIST   list(JOB_DROPSHIP_CREW_CHIEF, JOB_CAS_PILOT, JOB_DROPSHIP_PILOT)
#define JOB_AUXILIARY_ROLES    /datum/timelock/auxiliary
#define JOB_AUXILIARY_ROLES_LIST   list(JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_DROPSHIP_CREW_CHIEF, JOB_INTEL, JOB_TANK_CREW)

#define JOB_POLICE "Military Police"
#define JOB_WARDEN "Military Warden"
#define JOB_CHIEF_POLICE "Chief MP"
#define JOB_POLICE_ROLES /datum/timelock/mp
#define JOB_POLICE_ROLES_LIST    list(JOB_POLICE, JOB_WARDEN, JOB_CHIEF_POLICE)

#define JOB_DI "Drill Instructor"

#define JOB_CHIEF_ENGINEER "Chief Engineer"
#define JOB_MAINT_TECH "Maintenance Technician"
#define JOB_ORDNANCE_TECH "Ordnance Technician"
#define JOB_ENGINEER_ROLES   /datum/timelock/engineer
#define JOB_ENGINEER_ROLES_LIST  list(JOB_SQUAD_ENGI, JOB_MAINT_TECH, JOB_ORDNANCE_TECH, JOB_CHIEF_ENGINEER)

#define JOB_CHIEF_REQUISITION "Logistics Officer"
#define JOB_CARGO_CHIEF "Logistics Chief"
#define JOB_ARMORER "Armorer"
#define JOB_CARGO_TECH "Logistics Specialist"
#define JOB_REQUISITION_ROLES    /datum/timelock/requisition
#define JOB_REQUISITION_ROLES_LIST   list(JOB_CHIEF_REQUISITION, JOB_CARGO_TECH)

#define JOB_MARINE_RAIDER "Marine Raider"
#define JOB_MARINE_RAIDER_SL "Marine Raider Team Lead"
#define JOB_MARINE_RAIDER_CMD "Marine Raider Platoon Lead"
#define JOB_MARINE_RAIDER_ROLES_LIST list(JOB_MARINE_RAIDER, JOB_MARINE_RAIDER_SL, JOB_MARINE_RAIDER_CMD)

#define JOB_HUMAN_ROLES  /datum/timelock/human

#define JOB_XENO_ROLES   /datum/timelock/xeno
#define JOB_DRONE_ROLES /datum/timelock/drone
#define JOB_T3_ROLES /datum/timelock/tier3

#define JOB_STOWAWAY "Stowaway"

#define JOB_MARINE "USCM Marine" //generic marine
#define JOB_COLONEL "USCM Colonel"
#define JOB_USCM_OBSV "USCM Observer"
#define JOB_GENERAL "USCM General"
#define JOB_ACMC "Assistant Commandant of the Marine Corps"
#define JOB_CMC "Commandant of the Marine Corps"
#define JOB_PLT_MED "Platoon Corpsman"
#define JOB_PLT_SL "Platoon Squad Leader"
#define JOB_SQUAD_TECH "Support Technician"

// Used to add a timelock to a job. Will be passed onto derivatives
#define AddTimelock(Path, timelockList) \
##Path/setup_requirements(list/L){\
	L += timelockList;\
	. = ..(L);\
}

// Used to add a timelock to a job. Will be passed onto derivates. Will not include the parent's timelocks.
#define OverrideTimelock(Path, timelockList) \
##Path/setup_requirements(list/L){\
	L = timelockList;\
	. = ..(L);\
}

//-------------WO roles---------------

#define JOB_WO_CO "Ground Commander"
#define JOB_WO_XO "Lieutenant Commander"
#define JOB_WO_CHIEF_POLICE "Honor Guard Squad Leader"
#define JOB_WO_SO "Veteran Honor Guard"
#define JOB_WO_CREWMAN "Honor Guard Weapons Specialist"
#define JOB_WO_POLICE "Honor Guard"

#define JOB_WO_PILOT "Mortar Crew"

#define JOB_WO_CHIEF_ENGINEER "Bunker Crew Master"
#define JOB_WO_ORDNANCE_TECH "Bunker Crew"

#define JOB_WO_CHIEF_REQUISITION "Bunker Quartermaster"
#define JOB_WO_REQUISITION "Bunker Crew Logistics"

#define JOB_WO_CMO "Head Surgeon"
#define JOB_WO_DOCTOR "Field Doctor"
#define JOB_WO_RESEARCHER "Chemist"

#define JOB_WO_CORPORATE_LIAISON "Combat Reporter"
#define JOB_WO_SYNTH "Support Synthetic"

#define JOB_WO_SQUAD_MARINE "Dust Raider Squad Rifleman"
#define JOB_WO_SQUAD_MEDIC "Dust Raider Squad Hospital Corpsman"
#define JOB_WO_SQUAD_ENGINEER "Dust Raider Squad Combat Technician"
#define JOB_WO_SQUAD_SMARTGUNNER "Dust Raider Squad Smartgunner"
#define JOB_WO_SQUAD_SPECIALIST "Dust Raider Squad Weapons Specialist"
#define JOB_WO_SQUAD_LEADER "Dust Raider Squad Leader"

//------------------------------------

//-------- US Army --------//
#define JOB_ARMY_TROOPER "Army Trooper"
#define JOB_ARMY_PROPIPE "Army Grenadier"
#define JOB_ARMY_GUNNER "Army Gunner"
#define JOB_ARMY_SMARTGUNNER "Army Heavy Gunner"
#define JOB_ARMY_MARKSMAN "Army Marksman"
#define JOB_ARMY_ATLOAD "Army AT Loader"
#define JOB_ARMY_ATFIRE "Army AT Gunner"
#define JOB_ARMY_ENGI "Army Combat Engineering Technician"
#define JOB_ARMY_MT "Army Technical Engineer"
#define JOB_ARMY_CT "Army Logistics Specialist"
#define JOB_ARMY_MEDIC "Army Combat Medical Technician"
#define JOB_ARMY_TANK_CREW "Army Vehicle Crewman"
#define JOB_ARMY_NCO "Army Fireteam Lead"
#define JOB_ARMY_SNCO "Army Squad Leader"
#define JOB_ARMY_LT "Army Lieutenant"
#define JOB_ARMY_INTEL "Army Intelligence Officer"
#define JOB_ARMY_RESEARCHER "Army Science Officer"
#define JOB_ARMY_QM "Army Logistics Officer"

//-------- USASF --------//
#define JOB_NAVY_CREWMAN "USASF Crewman"
#define JOB_NAVY_MEDIC "USASF Hospital Corpsman"
#define JOB_NAVY_ENGI "USASF Engineering Technician"
#define JOB_NAVY_SKITTLE "USASF Flight-Deck Crewman"
#define JOB_NAVY_JTAC "USASF Orbital Fire-Support Liason Officer"
#define JOB_NAVY_PARA_TECH "USASF Para-Rescue Support Technician"
#define JOB_NAVY_SYNTH "USASF Support Synthetic"
#define JOB_NAVY_PILOT "USASF Pilot"
#define JOB_NAVY_CHIEF_ENGINEER "USASF Engineering Duty Officer"
#define JOB_NAVY_FLIGHT_BOSS "USASF Flight-Deck Officer"
#define JOB_NAVY_SO "USASF Duty Officer"
#define JOB_NAVY_CO "USASF Commanding Officer"

//-------- PMC --------//
#define JOB_PMC_STANDARD "PMC Operator"
#define JOB_PMC_ENGINEER "PMC Corporate Technician"
#define JOB_PMC_MEDIC "PMC Corporate Medic"
#define JOB_PMC_DOCTOR "PMC Trauma Surgeon"
#define JOB_PMC_INVESTIGATOR "PMC Medical Investigator"
#define JOB_PMC_DETAINER "PMC Security Enforcer"
#define JOB_PMC_CROWD_CONTROL "PMC Crowd Control Specialist"
#define JOB_PMC_GUNNER "PMC Support Weapons Specialist" //Renamed from Specialist to Support Specialist as it only has SG skills.
#define JOB_PMC_SNIPER "PMC Weapons Specialist" //Renamed from Sharpshooter to specialist as it uses specialist skills.
#define JOB_PMC_CREWMAN "PMC Vehicle Crewman"
#define JOB_PMC_XENO_HANDLER "PMC Xeno Handler"
#define JOB_PMC_LEADER "PMC Leader"
#define JOB_PMC_FIELD_OP_LEADER "PMC Field Operations Leader" // Used for Nightmare Solaris CO. (In PVE - a leader equivalent)
#define JOB_PMC_LEAD_INVEST "PMC Lead Investigator"
#define JOB_PMC_DIRECTOR "PMC Site Director"
#define JOB_PMC_SYNTH "PMC Support Synthetic"

#define ROLES_WY_PMC list(JOB_PMC_FIELD_OP_LEADER, JOB_PMC_LEADER, JOB_PMC_SNIPER, JOB_PMC_GUNNER, JOB_PMC_ENGINEER, JOB_PMC_MEDIC, JOB_PMC_STANDARD)
#define ROLES_WY_PMC_AUX list(JOB_PMC_SYNTH, JOB_PMC_CREWMAN, JOB_PMC_XENO_HANDLER, JOB_PMC_DOCTOR)
#define ROLES_WY_PMC_INSPEC list(JOB_PMC_LEAD_INVEST, JOB_PMC_INVESTIGATOR, JOB_PMC_DETAINER, JOB_PMC_CROWD_CONTROL)
#define ROLES_WY_PMC_ALL ROLES_WY_PMC + ROLES_WY_PMC_AUX + ROLES_WY_PMC_INSPEC + ROLES_WY_COMMANDOS

//-------- COMMANDOS --------//
#define JOB_WY_COMMANDO_STANDARD "W-Y Commando"
#define JOB_WY_COMMANDO_LEADER "W-Y Commando Leader"
#define JOB_WY_COMMANDO_GUNNER "W-Y Commando Gunner"
#define JOB_WY_COMMANDO_DOGCATHER "W-Y Commando Dog Catcher"

#define ROLES_WY_COMMANDOS list(JOB_WY_COMMANDO_STANDARD, JOB_WY_COMMANDO_LEADER, JOB_WY_COMMANDO_GUNNER, JOB_WY_COMMANDO_DOGCATHER)

//-------- WY --------//

#define JOB_WY_SEC "W-Y Security Guard"
#define JOB_WY_SEC_SYNTH "W-Y Security Guard Synthetic"
#define JOB_TRAINEE "Corporate Trainee"
#define JOB_JUNIOR_EXECUTIVE "Corporate Junior Executive"
#define JOB_EXECUTIVE "Corporate Executive"
#define JOB_SENIOR_EXECUTIVE "Corporate Senior Executive"
#define JOB_EXECUTIVE_SPECIALIST "Corporate Executive Specialist"
#define JOB_LEGAL_SPECIALIST "Corporate Legal Specialist"
#define JOB_EXECUTIVE_SUPERVISOR "Corporate Executive Supervisor"
#define JOB_LEGAL_SUPERVISOR "Corporate Legal Supervisor"
#define JOB_ASSISTANT_MANAGER "Corporate Assistant Manager"
#define JOB_DIVISION_MANAGER "Corporate Division Manager"
#define JOB_CHIEF_EXECUTIVE "Corporate Chief Executive"
#define JOB_DEPUTY_DIRECTOR "W-Y Deputy Director"
#define JOB_DIRECTOR "W-Y Director"

//-------- WY-DEATHSQUAD --------//
#define JOB_DS_SL "Whiteout Team Leading Unit"
#define JOB_DS_CK "Whiteout Team Cloaker Unit"
#define JOB_DS_SUP "Whiteout Team Support Unit"
#define JOB_DS_CU "Whiteout Team Combat Unit"

#define ROLES_WY_CORPORATE list(JOB_EXECUTIVE_SUPERVISOR, JOB_LEGAL_SUPERVISOR, JOB_EXECUTIVE_SPECIALIST, JOB_LEGAL_SPECIALIST, JOB_SENIOR_EXECUTIVE, JOB_EXECUTIVE, JOB_JUNIOR_EXECUTIVE, JOB_TRAINEE, JOB_WY_SEC_SYNTH, JOB_WY_SEC)
#define ROLES_WY_LEADERSHIP list(JOB_DIRECTOR, JOB_PMC_DIRECTOR, JOB_DEPUTY_DIRECTOR, JOB_CHIEF_EXECUTIVE, JOB_DIVISION_MANAGER, JOB_ASSISTANT_MANAGER)
#define ROLES_WY_WHITEOUT list(JOB_DS_SL, JOB_DS_CK, JOB_DS_SUP, JOB_DS_CU)

#define JOB_CORPORATE_ROLES /datum/timelock/corporate
#define JOB_CORPORATE_ROLES_LIST list(JOB_CORPORATE_LIAISON, JOB_WO_CORPORATE_LIAISON, JOB_DIRECTOR, JOB_PMC_DIRECTOR, JOB_DEPUTY_DIRECTOR, JOB_CHIEF_EXECUTIVE, JOB_DIVISION_MANAGER, JOB_ASSISTANT_MANAGER, JOB_EXECUTIVE_SUPERVISOR, JOB_LEGAL_SUPERVISOR, JOB_EXECUTIVE_SPECIALIST, JOB_LEGAL_SPECIALIST, JOB_SENIOR_EXECUTIVE, JOB_EXECUTIVE, JOB_JUNIOR_EXECUTIVE, JOB_TRAINEE, JOB_WY_SEC_SYNTH, JOB_WY_SEC)

//-------- WY Goons --------//
#define JOB_WY_GOON "WY Corporate Security"
#define JOB_WY_GOON_TECH "WY Corporate Security Technician"
#define JOB_WY_GOON_LEAD "WY Corporate Security Lead"
#define JOB_WY_GOON_RESEARCHER "WY Research Consultant"

#define ROLES_WY_GOONS list(JOB_WY_GOON_LEAD, JOB_WY_GOON_TECH, JOB_WY_GOON)

////-------- PMC PLATOON --------//

#define JOB_PMCPLAT_OW "Overwatch Operator"
#define JOB_PMCPLAT_LEADER "Operations Leader"
#define JOB_PMCPLAT_FTL "Team Leader"
#define JOB_PMCPLAT_SG "Heavy Weapons Specialist"
#define JOB_PMCPLAT_STANDARD "Tactical Unit"
#define JOB_PMCPLAT_MEDIC "Medical Specialist"

///------ PMC SMALL ==== ///
#define JOB_PMCPLAT_SMALL_LEADER "Strike Operations Leader"
#define JOB_PMCPLAT_SMALL_FTL "Strike Team Leader"
#define JOB_PMCPLAT_SMALL_SG "Strike Heavy Weapons Specialist"
#define JOB_PMCPLAT_SMALL_STANDARD "Strike Tactical Unit"
#define JOB_PMCPLAT_SMALL_MEDIC "Strike Medical Specialist"


//---- Contractors ----//
#define JOB_CONTRACTOR "VAIPO Mercenary"
#define JOB_CONTRACTOR_ST "VAIPO Mercenary"
#define JOB_CONTRACTOR_MEDIC "VAIMS Medical Specialist"
#define JOB_CONTRACTOR_ENGI "VAIPO Engineering Specialist"
#define JOB_CONTRACTOR_MG "VAIPO Automatic Rifleman"
#define JOB_CONTRACTOR_TL "VAIPO Team Leader"
#define JOB_CONTRACTOR_SYN "VAIPO Support Synthetic"
#define JOB_CONTRACTOR_COV "VAISO Mercenary"
#define JOB_CONTRACTOR_COVST "VAISO Mercenary"
#define JOB_CONTRACTOR_COVMED "VAIMS Medical Specialist"
#define JOB_CONTRACTOR_COVENG "VAISO Engineering Specialist"
#define JOB_CONTRACTOR_COVMG "VAISO Automatic Rifleman"
#define JOB_CONTRACTOR_COVTL "VAISO Team Leader"
#define JOB_CONTRACTOR_COVSYN "VAISO Support Synthetic"

#define CONTRACTOR_JOB_LIST list(JOB_CONTRACTOR, JOB_CONTRACTOR_ST, JOB_CONTRACTOR_MEDIC, JOB_CONTRACTOR_ENGI, JOB_CONTRACTOR_MG, JOB_CONTRACTOR_TL, JOB_CONTRACTOR_COV, JOB_CONTRACTOR_COVST, JOB_CONTRACTOR_COVMED, JOB_CONTRACTOR_COVENG, JOB_CONTRACTOR_COVTL)

//-------- CMB --------//
#define JOB_CMB "Office of Colonial Marshals Deputy"
#define JOB_CMB_TL "Colonial Marshal"
#define JOB_CMB_SYN "CMB Investigative Synthetic"
#define JOB_CMB_ICC "Interstellar Commerce Commission Liaison"
#define JOB_CMB_OBS "Interstellar Human Rights Observer"

#define CMB_GRUNT_LIST list(JOB_CMB, JOB_CMB_TL)

//-------- FORECON --------//

#define JOB_FORECON_CO "Reconnaissance Commander"
#define JOB_FORECON_SL "Reconnaissance Squad Leader"
#define JOB_FORECON_SYN "Reconnaissance Synthetic"
#define JOB_FORECON_SNIPER "Reconnaissance Sniper"
#define JOB_FORECON_MARKSMAN "Reconnaissance Marksman"
#define JOB_FORECON_SUPPORT "Reconnaissance Support Technician"
#define JOB_FORECON_RIFLEMAN "Reconnaissance Rifleman"
#define JOB_FORECON_SMARTGUNNER "Reconnaissance Smartgunner"

//-------- UPP --------//
#define JOB_UPP "Naval Infantry Rifleman"
#define JOB_UPP_ENGI "Naval Infantry Sapper"
#define JOB_UPP_MEDIC "Naval Infantry Sanitar"
#define JOB_UPP_SPECIALIST "Naval Infantry Sergeant"
#define JOB_UPP_SNIPER "Naval Infantry Marksman"
#define JOB_UPP_LEADER "Naval Infantry Platoon Sergeant"
#define JOB_UPP_POLICE "Politsiya"
#define JOB_UPP_SUPPLY "Logistics Technician"
#define JOB_UPP_LT_OFFICER "Junior Lieutenant"
#define JOB_UPP_LT_DOKTOR "Lieutenant Doctor"
#define JOB_UPP_SRLT_OFFICER "Senior Lieutenant"
#define JOB_UPP_KPT_OFFICER "Captain"
#define JOB_UPP_MAY_OFFICER "Major"
#define JOB_UPP_LTKOL_OFFICER "Lieutenant Colonel"
#define JOB_UPP_KOL_OFFICER "Colonel"
#define JOB_UPP_MAY_GENERAL "Major General"
#define JOB_UPP_LT_GENERAL "Lieutenant General"
#define JOB_UPP_GENERAL "General"

#define JOB_UPP_COMBAT_SYNTH "Combat Synthetic"
#define JOB_UPP_SUPPORT_SYNTH "Support Synthetic"
#define JOB_UPP_JOE "Dzho Automaton"

#define UPP_JOB_LIST list(JOB_UPP, JOB_UPP_ENGI, JOB_UPP_MEDIC, JOB_UPP_SPECIALIST, JOB_UPP_LEADER, JOB_UPP_POLICE, JOB_UPP_LT_OFFICER, JOB_UPP_LT_DOKTOR, JOB_UPP_SRLT_OFFICER, JOB_UPP_KPT_OFFICER, JOB_UPP_KOL_OFFICER, JOB_UPP_COMBAT_SYNTH, JOB_UPP_JOE)
#define UPP_JOB_GRUNT_LIST list(JOB_UPP, JOB_UPP_ENGI, JOB_UPP_MEDIC, JOB_UPP_SPECIALIST, JOB_UPP_LEADER, JOB_UPP_POLICE, JOB_UPP_CREWMAN)

#define JOB_UPP_COMMANDO "Junior Kommando"
#define JOB_UPP_COMMANDO_MEDIC "2nd Kommando"
#define JOB_UPP_COMMANDO_LEADER "1st Kommando"

#define UPP_COMMANDO_JOB_LIST list(JOB_UPP_COMMANDO, JOB_UPP_COMMANDO_MEDIC, JOB_UPP_COMMANDO_LEADER)

#define JOB_UPP_REPRESENTATIVE "UPP Representative"

#define JOB_UPP_CREWMAN "Tank Crewman"

#define JOB_UPP_COMMISSAR "Political Commissar"

//-------- CLF --------//
#define JOB_CLF "CLF Guerilla"
#define JOB_CLF_ENGI "CLF Field Technician"
#define JOB_CLF_MEDIC "CLF Field Medic"
#define JOB_CLF_SPECIALIST "CLF Field Specialist"
#define JOB_CLF_LEADER "CLF Cell Leader"
#define JOB_CLF_COMMANDER "CLF Cell Commander"
#define JOB_CLF_SYNTH "CLF Multipurpose Synthetic"

#define CLF_JOB_LIST list(JOB_CLF, JOB_CLF_ENGI, JOB_CLF_MEDIC, JOB_CLF_SPECIALIST, JOB_CLF_LEADER, JOB_CLF_COMMANDER, JOB_CLF_SYNTH)

//-------- TWE --------//
#define JOB_TWE_REPRESENTATIVE "TWE Representative"

//-------- RMC --------//
#define JOB_TWE_RMC_RIFLEMAN "Marine Commando"
#define JOB_TWE_RMC_MEDIC "Medical Assistant"
#define JOB_TWE_RMC_ENGI "Assault Engineer"
#define JOB_TWE_RMC_MARKSMAN "Scout Sniper"
#define JOB_TWE_RMC_SMARTGUNNER "GPMG Gunner"
#define JOB_TWE_RMC_BREACHER "Bombardment Specialist"
#define JOB_TWE_RMC_TEAMLEADER "Team Leader"
#define JOB_TWE_RMC_SECTIONLEADER "Section Leader"
#define JOB_TWE_RMC_TROOPLEADER "Troop Sergeant"
#define JOB_TWE_RMC_LIEUTENANT "Troop Commander"
#define JOB_TWE_RMC_COMMANDER "Squadron Commander"

#define TWE_COMMANDO_JOB_LIST list(JOB_TWE_RMC_RIFLEMAN, JOB_TWE_RMC_MEDIC, JOB_TWE_RMC_ENGI, JOB_TWE_RMC_BREACHER, JOB_TWE_RMC_SMARTGUNNER, JOB_TWE_RMC_MARKSMAN ,JOB_TWE_RMC_TEAMLEADER, JOB_TWE_RMC_SECTIONLEADER, JOB_TWE_RMC_TROOPLEADER, JOB_TWE_RMC_LIEUTENANT, JOB_TWE_RMC_COMMANDER,)

//-------- PROVOST --------//
#define JOB_PROVOST_ENFORCER "Provost Enforcer"
#define JOB_PROVOST_TML "Provost Team Leader"
#define JOB_PROVOST_ADVISOR "Provost Advisor"
#define JOB_PROVOST_INSPECTOR "Provost Inspector"
#define JOB_PROVOST_CINSPECTOR "Provost Chief Inspector"
#define JOB_PROVOST_UNDERCOVER "Provost Undercover Inspector"

#define JOB_PROVOST_DMARSHAL "Provost Deputy Marshal"
#define JOB_PROVOST_MARSHAL "Provost Marshal"
#define JOB_PROVOST_SMARSHAL "Provost Sector Marshal"
#define JOB_PROVOST_CMARSHAL "Provost Chief Marshal"

#define PROVOST_JOB_LIST list(JOB_PROVOST_ENFORCER, JOB_PROVOST_TML, JOB_PROVOST_ADVISOR, JOB_PROVOST_INSPECTOR, JOB_PROVOST_CINSPECTOR, JOB_PROVOST_DMARSHAL, JOB_PROVOST_MARSHAL, JOB_PROVOST_SMARSHAL, JOB_PROVOST_CMARSHAL)

#define JOB_RIOT "Riot Control"
#define JOB_RIOT_CHIEF "Chief Riot Control"

#define RIOT_JOB_LIST list(JOB_RIOT, JOB_RIOT_CHIEF)
//-------- CIA --------//
#define JOB_CIA "Intelligence Analyst"
#define JOB_CIA_LIAISON "Intelligence Liaison Officer"

//-------- BD MERCS --------//
#define JOB_MERCENARY "BD Grunt"
#define JOB_MERCENARY_PILOT "BD Pilot"
#define JOB_MERCENARY_SENTINEL "BD Sentinel"
#define JOB_MERCENARY_SUPERVISOR "BD Supervisor"
#define JOB_MERCENARY_BULWARK "BD Bulwark"
#define JOB_MERCENARY_SYNTH "BD Synth"
#define JOB_MERCENARY_INFILTRATOR "BD Infiltrator"
#define JOB_MERCENARY_OFFICER "BD Officer"

#define BD_MERCS_JOB_LIST list(JOB_MERCENARY_GRUNT, JOB_MERCENARY_PILOT, JOB_MERCENARY_SENTINEL, JOB_MERCENARY_SUPERVISOR, JOB_MERCENARY_BULWARK, JOB_MERCENARY_SYNTH, JOB_MERCENARY_INFILTRATOR, JOB_MERCENARY_OFFICER)

//-------- UACG -------//
#define JOB_UACG_RIFLE "Colonial Militiaman"
#define JOB_UACG_TECH "Colonial Militiaman Technician"
#define JOB_UACG_MEDIC "Colonial Militiaman Medic"
#define JOB_UACG_LEAD "Colonial Militiaman Unit Leader"
#define JOB_UACG_OFFICER "Colonial Militiaman Officer"

#define UACG_JOB_LIST list(JOB_UACG_RIFLE, JOB_UACG_TECH, JOB_UACG_MEDIC, JOB_UACG_LEAD, JOB_UACG_OFFICER)
//-------- DUTCH'S DOZEN --------//
#define JOB_DUTCH_ARNOLD "Dutch's Dozen - Dutch"
#define JOB_DUTCH_RIFLEMAN "Dutch's Dozen - Rifleman"
#define JOB_DUTCH_MINIGUNNER "Dutch's Dozen - Minigunner"
#define JOB_DUTCH_FLAMETHROWER "Dutch's Dozen - Flamethrower"
#define JOB_DUTCH_MEDIC "Dutch's Dozen - Medic"

#define DUTCH_JOB_LIST list(JOB_DUTCH_ARNOLD, JOB_DUTCH_RIFLEMAN, JOB_DUTCH_MINIGUNNER, JOB_DUTCH_FLAMETHROWER, JOB_DUTCH_MEDIC)

#define JOB_PREDATOR "Predator"
#define JOB_XENOMORPH    "Xenomorph"
#define JOB_XENOMORPH_QUEEN  "Queen"

// For coloring the ranks in the statistics menu
#define JOB_PLAYTIME_TIER_0  (0 HOURS)
#define JOB_PLAYTIME_TIER_1  (10 HOURS)
#define JOB_PLAYTIME_TIER_2  (25 HOURS)
#define JOB_PLAYTIME_TIER_3  (70 HOURS)
#define JOB_PLAYTIME_TIER_4  (175 HOURS)

#define XENO_NO_AGE  -1
#define XENO_NORMAL 0
#define XENO_MATURE 1
#define XENO_ELDER 2
#define XENO_ANCIENT 3
#define XENO_PRIME 4

/// For monthly time tracking
#define JOB_OBSERVER "Observer"
#define TIMELOCK_JOB(role_id, hours) new/datum/timelock(role_id, hours, role_id)

//For displaying groups of jobs. Used by new player's latejoin menu and by crew manifest.
#define FLAG_SHOW_CIC 1
#define FLAG_SHOW_AUXIL_SUPPORT 2
#define FLAG_SHOW_MISC 4
#define FLAG_SHOW_POLICE 8
#define FLAG_SHOW_ENGINEERING 16
#define FLAG_SHOW_REQUISITION 32
#define FLAG_SHOW_MEDICAL 64
#define FLAG_SHOW_MARINES 128
#define FLAG_SHOW_ALL_JOBS FLAG_SHOW_CIC|FLAG_SHOW_AUXIL_SUPPORT|FLAG_SHOW_MISC|FLAG_SHOW_POLICE|FLAG_SHOW_ENGINEERING|FLAG_SHOW_REQUISITION|FLAG_SHOW_MEDICAL|FLAG_SHOW_MARINES

///For denying certain traits being applied to people. ie. bad leg
///'Grunt' lists are for people who wouldn't logically get the bad leg trait, ie. UPP marine counterparts.
#define JOB_ERT_GRUNT_LIST list(DUTCH_JOB_LIST, RIOT_JOB_LIST, PROVOST_JOB_LIST, CMB_GRUNT_LIST, CLF_JOB_LIST, UPP_JOB_GRUNT_LIST, UPP_COMMANDO_JOB_LIST, CONTRACTOR_JOB_LIST, ROLES_WY_GOONS, ROLES_WY_PMC_ALL)
