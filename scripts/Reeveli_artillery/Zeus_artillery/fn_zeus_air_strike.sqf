/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator called air stike
 *
 * Arguments:
 * 0: Potision <ARRAY>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [position _unit] call Rev_arty_fnc_zeus_air_strike
 *
2.3
	Added code for bomb pattern dialog option
2.2
	All dialog options made to retain last used inputs
2.1
	Added function header
	Added default value to param, testing reveals that trying to exit here is pointless due to ZEN dialog
2.0
	Zen update
	Debug info removed, can still be found in Achilles version
*/

params [
	["_position",nil,[[]]]
];

private _planes = ["B_Plane_CAS_01_dynamicLoadout_F","B_Plane_Fighter_01_F","I_Plane_Fighter_04_F","O_Plane_Fighter_02_F","B_UAV_05_F","O_Plane_CAS_02_dynamicLoadout_F","O_UAV_02_dynamicLoadout_F"];
private _plane_names = [
	["A-10D Thunderbolt II","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["F/A-181 Black Wasp II","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["JAS 39 Gripen","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["To-201 Shikra","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["UCAV Sentinel","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Yak-130","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["YABHON-R3","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"]
];


//RHS
if (isclass (configfile >> "CfgVehicles" >> "RHS_A10")) then {
	_planes append ["RHS_A10"];
	_plane_names append [["A-10A","","rhsusf\addons\rhsusf_main\data\rhs_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "rhs_l159_CDF")) then {
	_planes append ["rhs_l159_CDF"];
	_plane_names append [["L-159 ALCA","","rhsgref\addons\rhsgref_main\data\rhs_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "rhs_mig29sm_vvs")) then {
	_planes append ["rhs_mig29sm_vvs"];
	_plane_names append [["MiG-29SM","","rhsafrf\addons\rhs_main\data\rhs_logo_ca.paa"]];
	};

if (isclass (configfile >> "CfgVehicles" >> "RHS_Su25SM_vvs")) then {
	_planes append ["RHS_Su25SM_vvs"];
	_plane_names append [["Su-25","","rhsafrf\addons\rhs_main\data\rhs_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "RHS_TU95MS_vvs_old")) then {
	_planes append ["RHS_TU95MS_vvs_old"];
	_plane_names append [["TU-95MS6 Bear","","rhsafrf\addons\rhs_main\data\rhs_logo_ca.paa"]];
	};


//CUP
if (isclass (configfile >> "CfgVehicles" >> "CUP_B_L39_CZ_GREY")) then {
	_planes append ["CUP_B_L39_CZ_GREY"];
	_plane_names append [["L-39ZA","","\CUP\AirVehicles\CUP_AirVehicles_Core\ui\logo_cup_ca_small.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "CUP_B_A10_DYN_USA")) then {
	_planes append ["CUP_B_A10_DYN_USA"];
	_plane_names append [["A-10A Thunderbolt II","","\CUP\AirVehicles\CUP_AirVehicles_Core\ui\logo_cup_ca_small.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "CUP_B_AV8B_DYN_USMC")) then {
	_planes append ["CUP_B_AV8B_DYN_USMC"];
	_plane_names append [["AV-8B Harrier II","","\CUP\AirVehicles\CUP_AirVehicles_Core\ui\logo_cup_ca_small.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "CUP_B_F35B_USMC")) then {
	_planes append ["CUP_B_F35B_USMC"];
	_plane_names append [["F-35B Lightning II","","\CUP\AirVehicles\CUP_AirVehicles_Core\ui\logo_cup_ca_small.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "CUP_O_Su25_Dyn_RU")) then {
	_planes append ["CUP_O_Su25_Dyn_RU"];
	_plane_names append [["Su-25T Frogfoot","","\CUP\AirVehicles\CUP_AirVehicles_Core\ui\logo_cup_ca_small.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "CUP_O_SU34_RU")) then {
	_planes append ["CUP_O_SU34_RU"];
	_plane_names append [["Su-34","","\CUP\AirVehicles\CUP_AirVehicles_Core\ui\logo_cup_ca_small.paa"]];
	};

//IFA3_LITE
if (isclass (configfile >> "CfgVehicles" >> "LIB_FW190F8_2")) then {
	_planes append ["LIB_FW190F8_2"];
	_plane_names append [["FW-190","","\WW2\Core_t\IF_Decals_t\German\flag_GER_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_FW190F8_2_w")) then {
	_planes append ["LIB_FW190F8_2_w"];
	_plane_names append [["FW-190 Winter","","\WW2\Core_t\IF_Decals_t\German\flag_GER_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_DAK_FW190F8_Desert")) then {
	_planes append ["LIB_DAK_FW190F8_Desert"];
	_plane_names append [["FW-190 Desert","","\WW2\Core_t\IF_Decals_t\German\flag_GER_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_Ju87")) then {
	_planes append ["LIB_Ju87"];
	_plane_names append [["JU-87","","\WW2\Core_t\IF_Decals_t\German\flag_GER_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_Ju87_w")) then {
	_planes append ["LIB_Ju87_w"];
	_plane_names append [["JU-87 Winter","","\WW2\Core_t\IF_Decals_t\German\flag_GER_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_DAK_Ju87_2")) then {
	_planes append ["LIB_DAK_Ju87_2"];
	_plane_names append [["JU-87 Desert","","\WW2\Core_t\IF_Decals_t\German\flag_GER_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_P39")) then {
	_planes append ["LIB_P39"];
	_plane_names append [["P-39","","\WW2\Core_t\IF_Decals_t\Ussr\flag_SU_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_P39_w")) then {
	_planes append ["LIB_P39_w"];
	_plane_names append [["P-39 Winter","","\WW2\Core_t\IF_Decals_t\Ussr\flag_SU_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_Pe2")) then {
	_planes append ["LIB_Pe2"];
	_plane_names append [["Pe-2","","\WW2\Core_t\IF_Decals_t\Ussr\flag_SU_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_Pe2_w")) then {
	_planes append ["LIB_Pe2_w"];
	_plane_names append [["Pe-2 Winter","","\WW2\Core_t\IF_Decals_t\Ussr\flag_SU_co.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "LIB_P47")) then {
	_planes append ["LIB_P47"];
	_plane_names append [["P-47 D-Day","","\WW2\Core_t\IF_Decals_t\US\flag_USA_co.paa"]];
	};



//FOW
if (isclass (configfile >> "CfgVehicles" >> "fow_va_a6m_white")) then {
	_planes append ["fow_va_a6m_white"];
	_plane_names append [["A6M Zero White","","\fow\fow_ui\data\logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "fow_va_a6m_green")) then {
	_planes append ["fow_va_a6m_green"];
	_plane_names append [["A6M Zero Green","","\fow\fow_ui\data\logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "fow_va_f6f_faa")) then {
	_planes append ["fow_va_f6f_faa"];
	_plane_names append [["UK F6F Hellcat","","\fow\fow_ui\data\logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "fow_va_f6f")) then {
	_planes append ["fow_va_f6f"];
	_plane_names append [["US F6F Hellcat","","\fow\fow_ui\data\logo_ca.paa"]];
	};



private _bombs = ["Bo_Mk82","Bo_GBU12_LGB","BombCluster_01_Ammo_F","napalm"];
private _bomb_names = [
	["Mk 82 Iron Bomb","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["GBU-12 LGB","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["GBU-85 Cluster","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Incendiary","","images\SPGlogo.paa"]
];

if (isclass (configfile >> "CfgAmmo" >> "rhs_ammo_rbk500_spbed")) then {
	_bombs append ["rhs_ammo_rbk500_spbed"];
	_bomb_names append [["RBK-500 SPBED AT Cluster","","rhsafrf\addons\rhs_main\data\rhs_logo_ca.paa"]];
	};
if (!isNil "damage_playeron_fire") then {
	_bombs append ["napalm"];
	_bomb_names append [["Custom Incendiary","","images\SPGlogo.paa"]];
	};



[
	"Reeveli's Air Strike",
	[
		["COMBO","Ordnance Type",[_bombs,_bomb_names,0],false],
		["EDIT","Ordnance Amount",["1"],false],
		["TOOLBOX",["Drop pattern","Select desired bomb pattern"],[0,1,2,["Linear","Horizontal"]],false],
		["TOOLBOX:WIDE","Plane Approach Direction",[0,2,4,["North","North-East","East","South-East","South","South-West","West","North-West"]],false],
		["EDIT","Flying Height",["200"],false],
		["COMBO","Plane Type",[_planes,_plane_names,0],false],
		["SIDES","Plane Side",[WEST],false]
	],
	{
		params ["_results","_position"];
		private _bomb_type = _results select 0;
		private _bomb_amount = _results select 1;
		private _pattern = ["Linear","Horizontal"] select (_results select 2);
		private _direction = _results select 3;
		private _height = _results select 4;
		private _plane_type = _results select 5;
		private _plane_side = _results select 6;

		private _bomb_number = parseNumber _bomb_amount;
		round _bomb_number;
		if (_bomb_number == 0) exitWith {playSound "FD_Start_F";[objNull, "No Bomb Amount Specified!"] call BIS_fnc_showCuratorFeedbackMessage;};

		switch _direction do {			
		case 0: {_direction = 0};
		case 1: {_direction = 45};
		case 2: {_direction = 90};
		case 3: {_direction = 135};
		case 4: {_direction = 180};
		case 5: {_direction = 225};
		case 6: {_direction = 270};
		case 7: {_direction = 315};
		};

		private _height_number = parseNumber _height;
		round _height_number;
		if (_height_number == 0) exitWith {playSound "FD_Start_F";[objNull, "No Fly Height Specified!"] call BIS_fnc_showCuratorFeedbackMessage;};

		if (count _plane_side > 1) exitWith {playSound "FD_Start_F";[objNull, "Select only one side!"] call BIS_fnc_showCuratorFeedbackMessage;};
		if (count _plane_side == 0) exitWith {playSound "FD_Start_F";[objNull, "Select side!"] call BIS_fnc_showCuratorFeedbackMessage;};
		_plane_side = _plane_side select 0;

		[objNull, "Strike Package Inbound!"] call BIS_fnc_showCuratorFeedbackMessage;
		[_position select 0,_bomb_type,_bomb_number,_pattern,_direction,_height_number,_plane_type,_plane_side] remoteExecCall ["Rev_arty_fnc_zeus_bomber",2];

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;