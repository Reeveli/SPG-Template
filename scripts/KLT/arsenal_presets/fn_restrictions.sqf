/*
Author: Quiksilver
Last modified: 31/10/2018 by -Killet-
Description:
	Restricts certain weapon systems to different roles
_________________________________________________*/

private ["_opticsAllowed","_specialisedOptics","_optics","_basePos","_firstRun","_insideSafezone","_outsideSafezone"];


//Autorifleman
#define MG_MSG "Only Autoriflemen may use this weapon system. LMG removed."
#define AUTOTUR_MSG "You are not allowed to use this weapon system, Backpack removed."
//UAV Operator 
#define UAV_MSG "Only UAV operator or Scouts may use this Item, UAV terminal removed."
//AT 
#define AT_MSG "Only AT Soldiers may use this weapon system. Launcher removed."
//Officer 
#define Officer_msg "You need to be a Officer to wear this Beret. Headgear removed."
#define Officeruni_msg "You need to be a Officer to wear this Uniform. Uniform removed."
//Sniper
#define Ghillie_msg "You need to be a Sniper or a Spotter to wear the Ghillie uniform. Uniform removed."
#define SNIPER_MSG "Only Snipers may use this weapon system. Sniper rifle removed."
#define OPTICS_MSG "Thermal optics such as TWS and Nightstalker are currently restricted."
#define SOPT_MSG "Sniper sights are designated for Snipers, marksman and Spotters only. Optic removed."
//Pilot 
#define pilotheadgear_msg "You need to be a pilot to wear this helmet. Helmet removed."
#define pilotuniform_msg "You need to be a pilot to wear this uniform. uniform removed."
#define pilotvest_msg "You need to be a Pilot to wear this vest. Vest removed."
//Squadleader 
#define lasermarker_msg "You need to be a Squadleader, Spotter or Jtac to carry a Laser Designator. Laser removed."
//Marksman 
#define marksman_msg "You need to be a Marksman to use this Weapon. Weapon removed."
//Jtac
#define Jtac_MSG "You need to be a Jtac, Spotter or Officer to use this Item. SatCom removed."
//Opfor units
#define opfor_MSG "Only the enemy forces do know how to use this item."


//===== Officer
_officer = 
[
"B_officer_F"
];

_officerRestricted = 
[
	"H_Beret_Colonel"
];


//===== Officeruniform
_officeruni = 
[
"B_officer_F"
];

_officeruniRestricted = 
[
	"U_I_OfficerUniform"
];
	



//===== Jtac
_Jtac = 
[
"B_recon_JTAC_F",
"B_officer_F",
"B_recon_F"
];

_JtacRestricted = 
[
	"tfw_rf3080Item"
];

//===== marksman
_marksman = 
[
"B_soldier_M_F"
];

_marksmanRestricted = 
[
	"rhs_weap_m14ebrri",
	"rhs_weap_sr25_d",
	"rhs_weap_sr25",
	"hlc_rifle_psg1",
	"hlc_rifle_PSG1A1_RIS",
	"hlc_rifle_psg1A1",
	"rhs_weap_sr25_ec",
	"arifle_SPAR_03_blk_F",
	"srifle_DMR_03_F",
	"srifle_DMR_06_olive_F",
	"srifle_DMR_06_camo_F",
	"srifle_EBR_F",
	"srifle_DMR_03_woodland_F",
	"srifle_DMR_04_F"

];


//===== Pilotheadgear
_pilotheadgear = 
[
"B_Helipilot_F"
];

_pilotheadgearRestricted = 
[
	"H_PilotHelmetHeli_B",
	"H_CrewHelmetHeli_B",
	"BWA3_Knighthelm",
	"H_PilotHelmetFighter_B",
	"H_PilotHelmetHeli_B",
	"H_PilotHelmetHeli_O",
	"H_CrewHelmetHeli_B",
	"H_CrewHelmetHeli_O",
	"rhsusf_ihadss",
	"rhsusf_hgu56p_white",
	"rhsusf_hgu56p_visor_white",
	"H_CrewHelmetHeli_I",
	"H_PilotHelmetHeli_I",
	"UK3CB_BAF_H_PilotHelmetHeli_A"

];


//===== Pilotuniform
_pilotuniform = 
[
"B_Helipilot_F"
];

_pilotuniformRestricted = 
[
	"BWA3_Uniform_Crew_Fleck",
	"BWA3_Uniform_Helipilot",
	"U_B_HeliPilotCoveralls",
	"U_B_PilotCoveralls",
	"UK3CB_BAF_U_HeliPilotCoveralls_RN",
	"UK3CB_BAF_U_HeliPilotCoveralls_RAF",
	"U_I_HeliPilotCoveralls",
	"UK3CB_BAF_U_HeliPilotCoveralls_Army"
];

//===== Pilotvest
_pilotvest = 
[
"B_Helipilot_F"
];

_pilotvestRestricted = 
[
	"V_TacVest_blk",
	"UK3CB_BAF_V_Pilot_A"
];


//===== Ghillie
_Ghillie = 
[
"B_sniper_F",
"B_recon_F"

];

_GhillieRestricted = 
[
	"U_B_GhillieSuit",
	"U_I_FullGhillie_ard",
	"U_O_FullGhillie_ard",
	"U_B_FullGhillie_ard",
	"U_B_FullGhillie_sard",
	"U_B_T_FullGhillie_tna_F"
];


//===== UAV TERMINAL
_uavOperator = 
[
"B_soldier_UAV_F",
"B_support_AMort_F",
"B_recon_F",
"B_officer_F"
];

_uavRestricted = 
[
	"B_UavTerminal",
	"O_UavTerminal",
	"I_UavTerminal"
];


//===== Laser Designator
_laserOperator = 
[
"B_soldier_UAV_F",
"B_Soldier_SL_F",
"B_recon_F",
"B_recon_JTAC_F",
"B_officer_F"
];

_laserRestricted = 
[
	"Laserdesignator"
];

//===== LAUNCHERS (excl RPG)

_missileSoldiers = 
[
	"B_soldier_LAT_F",
	"B_soldier_AA_F",
	"B_soldier_AT_F",
	"B_recon_LAT_F"
];


_missileSpecialised = 
[
	//rhs
	"rhs_weap_maaws",
	"rhs_weap_smaw",
	"rhs_weap_smaw_green",
	"rhs_weap_fgm148",
	"rhs_weap_fim92",
	
	//vanilla
	"launch_B_Titan_F",
	"launch_MRAWS_green_F",
	"launch_MRAWS_green_rail_F",
	"launch_I_Titan_short_F",
	"launch_B_Titan_F",
	"launch_O_Titan_F",
	"launch_I_Titan_F",
	"launch_B_Titan_short_F",
	"launch_O_Titan_short_F",
	"launch_I_Titan_short_F",
	"launch_NLAW_F",

	"IP_launch_O_Titan_short_snw_F",
	"IP_launch_O_Titan_snw_F",
	
	//ger
	"BWA3_Fliegerfaust",
	"BWA3_CarlGustaf",
	"BWA3_Pzf3",
	"BWA3_RGW90",
	//baf
	"UK3CB_BAF_Javelin_Launcher",
	"UK3CB_BAF_Javelin_Slung_Tube",
	"UK3CB_BAF_NLAW_Launcher"

];


//===== SNIPER RIFLES
_snipers = 
[
"B_sniper_F", 
"Recon_Sharpshooter_F"
];


_sniperSpecialised = 
[
	//rhs
	"rhs_weap_M107",
	"rhs_weap_M107_d",
	"rhs_weap_M107_w",
	"rhs_weap_XM2010_d",
	"rhs_weap_XM2010_sa",
	"rhs_weap_XM2010_wd",
	"rhs_weap_m24sws",
	"rhs_weap_m24sws_blk",
	"rhs_weap_m24sws_ghillie",
	"rhs_weap_m40a5",
	"rhs_weap_m40a5_d",
	"rhs_weap_m40a5_wd",
	"rhs_weap_XM2010",
	"rhs_weap_m24sws_wd",

	//ger
	"BWA3_G82",
	"BWA3_G28_Standard",
	"BWA3_G28_Assault",

	//Vanilla
	"srifle_GM6_F",
	"srifle_GM6_LRPS_F",
	"srifle_GM6_SOS_F",
	"srifle_LRR_F",
	"srifle_LRR_LRPS_F",
	"srifle_LRR_SOS_F",
	"srifle_GM6_camo_F",
	"srifle_GM6_camo_LRPS_F",
	"srifle_GM6_camo_SOS_F",
	"srifle_LRR_camo_F",
	"srifle_LRR_camo_LRPS_F",
	"srifle_LRR_camo_SOS_F",
	"srifle_DMR_05_tan_f",
	"srifle_DMR_05_blk_F",
	"srifle_LRR_tna_F",
	"srifle_DMR_02_F",
	"srifle_DMR_02_camo_F",
	"srifle_DMR_02_sniper_F",
	



	
	

	//swe
	"sfp_ag90_base",
	"sfp_psg90_base",
	"sfp_psg90_camo",

	//BAF
	"UK3CB_BAF_L135A1",
	"UK3CB_BAF_L115A3",
	"UK3CB_BAF_L115A3_BL",
	"UK3CB_BAF_L115A3_DE",
	"UK3CB_BAF_L115A3_Ghillie",
	"UK3CB_BAF_L115A3_DE_Ghillie",
	"UK3CB_BAF_L115A3_BL_Ghillie",
	"UK3CB_BAF_L118A1_Covert",
	"UK3CB_BAF_L118A1_Covert_BL",
	"UK3CB_BAF_L118A1_Covert_DE"


];

//===== LMG
_autoRiflemen = 
[

"B_soldier_AR_F"

];
_autoSpecialised = 
[
	//RHS
	"rhs_weap_m240B",
	"rhs_weap_m240B_CAP",
	"rhs_weap_m240G",
	"rhs_weap_m249",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m249",
	"rhs_weap_m249_pip_L",
	"rhs_weap_m249_pip_L_para",
	"rhs_weap_m249_pip_L_vfg",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m249_pip_S_para",
	"rhs_weap_m249_pip_S_vfg",
	"rhs_weap_m249_pip",


	//Vanilla
	"LMG_Mk200_F",
	"MMG_02_black_F",
	"LMG_03_F",

	//Special MGL
	"rhs_weap_m32",

	//SMA
	"sma_minimi_mk3_762tlb",
	"sma_minimi_mk3_762tlb_des",
	"sma_minimi_mk3_762tlb_wdl",
	"sma_minimi_mk3_762tsb",
	"sma_minimi_mk3_762tsb_des",
	"sma_minimi_mk3_762tsb_wdl",

	//Vanilla	
	"LMG_03_F",
	"LMG_Mk200_F",
	"MMG_02_black_F",
	"MMG_01_tan_F",
	"arifle_SPAR_02_blk_F",
	"arifle_SPAR_02_snd_F",
	"MMG_02_sand_F",

	//German
	"BWA3_G36_LMG",
	"BWA3_MG3",
	"BWA3_MG4",
	"BWA3_MG5",
	"BWA3_MG5_Tan",

	//Swedish
	"sfp_ksp90c",
	"sfp_ksp90b",
	"sfp_ksp58B2",

	//Finnish
	"ffp_kk_pkm",

	//Norwegian
	"hlc_lmg_mk48mod1",
	"hlc_lmg_mk48",
	"hlc_lmg_mk46mod1",
	"hlc_lmg_mk46",
	"hlc_lmg_m249para",
	"hlc_m249_pip2",
	"hlc_lmg_M249E2",
	"hlc_lmg_M249E1",
	"hlc_m249_pip3",
	"hlc_m249_pip4",
	"hlc_m249_pip1",
	"hlc_m249_SQuantoon",


	//UK BAF
	"UK3CB_BAF_L7A2",
	"UK3CB_BAF_L7A2_FIST",
	"UK3CB_BAF_L110A1",
	"UK3CB_BAF_L110A2",
	"UK3CB_BAF_L110A2RIS",
	"UK3CB_BAF_L110A3",
	"UK3CB_BAF_L110_762",
	"UK3CB_BAF_L110A2_FIST"

];

//OPFOR UNITS
//================================================================
//===== OPHEADGEAR
_ophead = 
[
"O_V_Soldier_LAT_hex_F"
];

_opheadRestricted = 
[
	"H_HelmetO_ViperSP_hex_F",
	"H_HelmetO_ViperSP_ghex_F"
];

//===== OPWEAPONS
_opweap = 
[
"O_V_Soldier_LAT_hex_F"

];

_opweapRestricted = 
[
	"arifle_ARX_hex_F",
	"arifle_ARX_blk_F",
	"arifle_CTARS_hex_F",
	"arifle_CTARS_ghex_F",
	"arifle_CTARS_blk_F",
	"arifle_CTAR_GL_hex_F",
	"arifle_CTAR_GL_ghex_F",
	"arifle_CTAR_GL_blk_F",
	"arifle_CTAR_hex_F",
	"arifle_CTAR_ghex_F",
	"arifle_CTAR_blk_F",
	"srifle_DMR_07_hex_F",
	"srifle_DMR_07_ghex_F",
	"srifle_DMR_07_blk_F",
	"arifle_ARX_ghex_F"
];

//=====================================================================

//===== BACKPACKS
_backpackRestricted = ["I_AA_01_weapon_F"];

//===== THERMAL OPTICS
_opticsAllowed = [""];
_specialisedOptics = ["optic_Nightstalker","optic_tws","optic_tws_mg"];

//===== SNIPER OPTICS
_sniperTeam = 
[

"B_sniper_F",
"B_recon_F",
"B_soldier_M_F",
"B_spotter_F"

];
_sniperOpt = 
[
	"RKSL_optic_PMII_312",
	"RKSL_optic_PMII_312_sunshade",
	"RKSL_optic_PMII_312_wdl",
	"RKSL_optic_PMII_312_sunshade_wdl",
	"RKSL_optic_PMII_312_des",
	"RKSL_optic_PMII_312_sunshade_des",
	"RKSL_optic_PMII_525",
	"RKSL_optic_PMII_525_wdl",
	"RKSL_optic_PMII_525_des",
	"optic_NVS",
	"rhsusf_acc_ACOG_MDO",
	"ACE_optic_SOS_PIP",
	"optic_SOS",
	"rhsusf_acc_LEUPOLDMK4_2_d",
	"rhsusf_acc_LEUPOLDMK4_d",
	"rhsusf_acc_LEUPOLDMK4_2",
	"rhsusf_acc_premier",
	"rhsusf_acc_premier_anpvs27",
	"rhsusf_acc_premier_low",
	"rhsusf_acc_M8541_low",
	"rhsusf_acc_M8541",
	"optic_KHS_blk",


	//Norway
	"hlc_optic_PVS4G3",
	"HLC_Optic_ZFSG1",
	"hlc_optic_accupoint_g3"

];









//=======================================Other=================================================
//=============================================================================================

_basePos = getMarkerPos "startbase_marker";

_szmkr = getMarkerPos "safezone_marker";
#define SZ_RADIUS 50

_EHFIRED = {
	deleteVehicle (_this select 6);
	hintC "You are discharging your weapon at base without approval.  Cease your actions Immediately!";
	
	hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
		0 = _this spawn {
			_this select 0 displayRemoveEventHandler ["unload", hintC_EH];
			hintSilent "";
		};
	}];
};

_firstRun = TRUE;
if (_firstRun) then {
	_firstRun = FALSE;
	if ((player distance _szmkr) <= SZ_RADIUS) then {
		_insideSafezone = TRUE;
		_outsideSafezone = FALSE;
		EHFIRED = player addEventHandler ["Fired",_EHFIRED];
	} else {
		_outsideSafezone = TRUE;
		_insideSafezone = FALSE;
	};
};

restrict_Thermal = true;
restrict_LMG = true;
restrict_sOptics = true;

while {true} do {

	//------------------------------------- UAV
	
    _assignedItems = assignedItems player;

	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",3];
		};
	};
	
	sleep 1;


	//------------------------------------- Jtac
	
    _inventoryItems = (uniformItems player) + (vestItems player);
  	_backpackItems = (backpackItems player);
	
	if (({player isKindOf _x} count _Jtac) < 1) then {
		if (({"tfw_rf3080Item" == _x} count _backpackItems) > 0) then {
			player removeItemFromBackpack "tfw_rf3080Item";
			titleText [Jtac_MSG,"PLAIN",3];
		};
		if (({"tfw_rf3080Item" == _x} count _inventoryItems) > 0) then {
			player removeItem "tfw_rf3080Item";
			titleText [Jtac_MSG,"PLAIN",3];
		};
	};

	sleep 1;

	//------------------------------------- Laser Designator
	
    _assignedItems = assignedItems player;

	if (({"Laserdesignator" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _laserOperator) < 1) then {
			player unassignItem "Laserdesignator";
			player removeWeapon "Laserdesignator";
			titleText [lasermarker_msg,"PLAIN",3];
		};
	};
	
	sleep 1;
	
	//------------------------------------- Commander
	
    if (headgear player in _officerRestricted) then {
	if (({player isKindOf _x} count _Officer) < 1) then {
		removeHeadgear player;
		titleText [Officer_msg,"PLAIN",3];
	};
	};
	
	sleep 1;

	//------------------------------------- officeruniform
	
    if (uniform player in _officeruniRestricted) then {
	if (({player isKindOf _x} count _Officeruni) < 1) then {
		removeUniform player;
		titleText [Officeruni_msg,"PLAIN",3];
	};
	};
	
	sleep 1;
	
	//------------------------------------- Pilotheadgear
	
    if (headgear player in _pilotheadgearRestricted) then {
	if (({player isKindOf _x} count _pilotheadgear) < 1) then {
		removeHeadgear player;
		titleText [pilotheadgear_msg,"PLAIN",3];
	};
	};
	
	sleep 1;
	
	
	//------------------------------------- Pilotuniform
	
    if (uniform player in _pilotuniformRestricted) then {
	if (({player isKindOf _x} count _pilotuniform) < 1) then {
		removeUniform player;
		titleText [pilotuniform_msg,"PLAIN",3];
	};
	};
	
	sleep 1;

	//------------------------------------- pilotvest
	
    if (vest player in _pilotvestRestricted) then {
	if (({player isKindOf _x} count _pilotvest) < 1) then {
		removeVest player;
		titleText [pilotvest_msg,"PLAIN",3];
	};
	};
	
	sleep 1;
	
	//------------------------------------- Ghillie
	
    if (uniform player in _GhillieRestricted) then {
	if (({player isKindOf _x} count _Ghillie) < 1) then {
		removeUniform player;
		titleText [Ghillie_msg,"PLAIN",3];
	};
	};
	
	sleep 1;
	
	
	
	//------------------------------------- Launchers
	
	if (({player hasWeapon _x} count _missileSpecialised) > 0) then {
		if (({player isKindOf _x} count _missileSoldiers) < 1) then {
			player removeWeapon (secondaryWeapon player);
			titleText [AT_MSG,"PLAIN",3];
		};
	};
	
	sleep 1;
	
	//------------------------------------- Sniper Rifles

	if (({player hasWeapon _x} count _sniperSpecialised) > 0) then {
		if (({player isKindOf _x} count _snipers) < 1) then {
			player removeWeapon (primaryWeapon player);
			titleText [SNIPER_MSG,"PLAIN",3];
		};
	};

	sleep 1;


	//------------------------------------- Marksman

	if (({player hasWeapon _x} count _marksmanRestricted) > 0) then {
		if (({player isKindOf _x} count _marksman) < 1) then {
			player removeWeapon (primaryWeapon player);
			titleText [marksman_msg,"PLAIN",3];
		};
	};

	sleep 1;

	//------------------------------------- LMG

	
	if (({player hasWeapon _x} count _autoSpecialised) > 0) then {
		if (({player isKindOf _x} count _autoRiflemen) < 1) then {
			player removeWeapon (primaryWeapon player);
			titleText [MG_MSG,"PLAIN",3];
		};
	};
		sleep 1;
	

	//------------------------------------- OPFORweap

	
	if (({player hasWeapon _x} count _opweap) > 0) then {
		if (({player isKindOf _x} count _opweapRestricted) < 1) then {
			player removeWeapon (primaryWeapon player);
			titleText [opfor_MSG,"PLAIN",3];
		};
	};
		sleep 1;

		//------------------------------------- OPforheadgear
	
    if (headgear player in _opheadRestricted) then {
	if (({player isKindOf _x} count _ophead) < 1) then {
		removeHeadgear player;
		titleText [opfor_MSG,"PLAIN",3];
	};
	};
	
	sleep 1;

	//------------------------------------- Turret backpacks

	if ((backpack player) in _backpackRestricted) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 3];
	};
	
	//------------------------------------- Thermal optics
	
	if (restrict_Thermal) then {
		_optics = primaryWeaponItems player;	
		if (({_x in _optics} count _specialisedOptics) > 0) then {
			if (({player isKindOf _x} count _opticsAllowed) < 1) then {
				{player removePrimaryWeaponItem  _x;} count _specialisedOptics;
				titleText [OPTICS_MSG,"PLAIN",3];
			};
		};
		sleep 1;
	};
	
	//------------------------------------- Sniper optics
	
	if (restrict_sOptics) then {
		_optics = primaryWeaponItems player;	
		if (({_x in _optics} count _sniperOpt) > 0) then {
			if (({player isKindOf _x} count _sniperTeam) < 1) then {
				{player removePrimaryWeaponItem  _x;} count _sniperOpt;
				titleText [SOPT_MSG,"PLAIN",3];
			};
		};
		sleep 1;
	};


	//===================================== SAFE ZONE MANAGER
	
	_szmkr = getMarkerPos "safezone_marker";
	if (_insideSafezone) then {
		if ((player distance _szmkr) > SZ_RADIUS) then {
			_insideSafezone = FALSE;
			_outsideSafezone = TRUE;
			player removeEventHandler ["Fired",EHFIRED];
		};
	};
	sleep 2;
	if (_outsideSafezone) then {
		if ((player distance _szmkr) < SZ_RADIUS) then { 
			_outsideSafezone = FALSE;
			_insideSafezone = TRUE;
			EHFIRED = player addEventHandler ["Fired",_EHFIRED];
		};
	};
	
	//----- Sleep 
	
	_basePos = getMarkerPos "startbase_marker";
	if ((player distance _basePos) <= 500) then {
		sleep 1;
	} else {
		sleep 20;
	};
};