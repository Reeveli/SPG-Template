/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator called air stike
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [position _unit] call Rev_arty_fnc_zeus_air_strike
 *
2.4
	Removed unnecessary checks for napalm. I don't think it is needed as script is present at all times(?)
	Removed plane direction options, that is now calculated based on curator camera or player position in relation to target
	Added player to passed params to enable automatic curator object registration
	Increased default altitude to 300
	Removed UAV from planes list to account for new gunrun script
	Removed Tu95 due to ewar splitting countermeasures
	Deleted IFA planes in favour of SPE 44 planes
	Added SOGPF napalm as ammo options
	Added CDLC and 3CB planes
	Pruned extra FAW plane options
	Bomb amount is now a slider
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

private _planes = ["B_Plane_CAS_01_dynamicLoadout_F","B_Plane_Fighter_01_F","I_Plane_Fighter_04_F","O_Plane_Fighter_02_F","O_Plane_CAS_02_dynamicLoadout_F","O_UAV_02_dynamicLoadout_F"];
private _plane_names = [
	["A-10D Thunderbolt II","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["F/A-181 Black Wasp II","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["JAS 39 Gripen","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["To-201 Shikra","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
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

//3CB
if (isclass (configfile >> "CfgVehicles" >> "UK3CB_ARD_O_Antonov_AN2_Armed_Rockets")) then {
	_planes append ["UK3CB_ARD_O_Antonov_AN2_Armed_Rockets"];
	_plane_names append [["Antonov AN2","","UK3CB_Factions\addons\UK3CB_Factions_Common\editor\logo_3cb_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "UK3CB_CW_SOV_O_EARLY_MIG21_CAS")) then {
	_planes append ["UK3CB_CW_SOV_O_EARLY_MIG21_CAS"];
	_plane_names append [["Mig-21","","UK3CB_Factions\addons\UK3CB_Factions_Common\editor\logo_3cb_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "UK3CB_B_Mystere_HIDF_CAS1")) then {
	_planes append ["UK3CB_B_Mystere_HIDF_CAS1"];
	_plane_names append [["MD-454 'Mystere'","","UK3CB_Factions\addons\UK3CB_Factions_Common\editor\logo_3cb_ca.paa"]];
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

//SOGPF
if (isclass (configfile >> "CfgVehicles" >> "vn_b_air_f4b_navy_cas")) then {
	_planes append ["vn_b_air_f4b_navy_cas"];
	_plane_names append [["F-4B Phantom II","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "vn_b_air_f100d_cas")) then {
	_planes append ["vn_b_air_f100d_cas"];
	_plane_names append [["F-100D","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "vn_o_air_mig19_cas")) then {
	_planes append ["vn_o_air_mig19_cas"];
	_plane_names append [["Mig-19 S","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "vn_o_air_mig21_hcas")) then {
	_planes append ["vn_o_air_mig21_hcas"];
	_plane_names append [["Mig-21 PFM","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};

//SPE 44
if (isclass (configfile >> "CfgVehicles" >> "SPE_FW190F8")) then {
	_planes append ["SPE_FW190F8"];
	_plane_names append [["Fw 190 F-8","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "SPE_P47")) then {
	_planes append ["SPE_P47"];
	_plane_names append [["P-47D","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};

//FOW
if (isclass (configfile >> "CfgVehicles" >> "fow_va_a6m_green")) then {
	_planes append ["fow_va_a6m_green"];
	_plane_names append [["A6M Zero Green","","\fow\fow_ui\data\logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgVehicles" >> "fow_va_f6f")) then {
	_planes append ["fow_va_f6f"];
	_plane_names append [["US F6F Hellcat","","\fow\fow_ui\data\logo_ca.paa"]];
	};



private _bombs = ["Rockets","Bo_Mk82","BombCluster_01_Ammo_F","napalm"];
private _bomb_names = [
	["Rockets/Gun Run","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Mk 82 Iron Bomb","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["GBU-85 Cluster","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Custom Incendiary","","images\SPGlogo.paa"]
];

if (isclass (configfile >> "CfgAmmo" >> "rhs_ammo_rbk500_spbed")) then {
	_bombs append ["rhs_ammo_rbk500_spbed"];
	_bomb_names append [["RBK-500 SPBED AT Cluster","","rhsafrf\addons\rhs_main\data\rhs_logo_ca.paa"]];
	};
if (isclass (configfile >> "CfgAmmo" >> "vn_bomb_500_blu1b_fb_ammo")) then {
	_bombs append ["vn_bomb_500_blu1b_fb_ammo"];
	_bomb_names append [["Mk 77 500lb Napalm","","a3\ui_f\data\logos\arma3_bundle_logo_ca.paa"]];
	};

[
	"Reeveli's Air Strike",
	[
		["COMBO","Ordnance Type",[_bombs,_bomb_names,0],false],
		["SLIDER",["Ordnance Amount","Use caution with clusters and incendiary"],[1,6,2,0],false],
		["COMBO","Plane Type",[_planes,_plane_names,0],false],
		["SIDES","Plane Side",[WEST],false]
	],
	{
		params ["_results","_position"];
		private _bomb_type = _results select 0;
		private _bomb_amount = _results select 1;
		private _plane_type = _results select 2;
		private _plane_side = _results select 3;


		if (count _plane_side > 1) exitWith {playSound "FD_Start_F";[objNull, "Select only one side!"] call BIS_fnc_showCuratorFeedbackMessage;};
		if (count _plane_side == 0) exitWith {playSound "FD_Start_F";[objNull, "Select side!"] call BIS_fnc_showCuratorFeedbackMessage;};
		_plane_side = _plane_side select 0;

		private _targetPos = _position select 0;
		private _direction = player getDir _targetPos;
		if !(isNull curatorCamera) then {(getPos curatorCamera) getDir _targetPos;
			_direction = (getPos curatorCamera) getDir _targetPos;
		};


		[objNull, "Strike Package Inbound!"] call BIS_fnc_showCuratorFeedbackMessage;

		//Exit to rocket script
		if (_bomb_type == "Rockets") exitWith {
			[_targetPos,_direction,_plane_type,_plane_side,player] remoteExec ["Rev_arty_fnc_zeus_gunRun",2];
		};

		[_targetPos,_bomb_type,_bomb_amount,_direction,_plane_type,_plane_side,player] remoteExecCall ["Rev_arty_fnc_zeus_bomber",2];


	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;