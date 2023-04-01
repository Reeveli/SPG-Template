/*
 * Author: Reeveli
 * Part of Zeus resupply system.
 * Client side function to initialize ZEN dialog for curator called resupply drop.
 *
 * Arguments:
 * 0: Position <ARRAY> (default: nil)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_position] call Rev_fnc_resupply_dialog
 *
 */

params [
	["_position",[],[[]]]
];

if ((count _position) < 2) exitWith {};

private _planes = [
	"B_T_VTOL_01_vehicle_F",
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Transport_01_F",
	"O_T_VTOL_02_vehicle_dynamicLoadout_F",
	"O_Heli_Transport_04_box_F",
	"O_Heli_Light_02_unarmed_F",
	"I_Heli_Transport_02_F",
	"I_Heli_light_03_unarmed_F"
	];
private _plane_names = [
	["V-44 X Blackfish","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["CH-47I Chinook","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["UH-80 Ghost Hawk","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Y-32 Xi'an","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Mi-290 Taru","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["Ka-60 kasatka","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["AW101 Merlin","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"],
	["AW159 Wildcat","","\a3\Ui_f\data\GUI\Cfg\LoadingScreens\A3_LoadingLogo_ca.paa"]
];

private _attachments = [
	"None",
	"SmokeShellBlue",
	"SmokeShellYellow",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellRed",
	"SmokeShellPurple",
	"NVG_TargetC",
	"ACE_G_Chemlight_HiWhite",
	"ACE_G_Chemlight_HiYellow",
	"ACE_G_Chemlight_HiRed",
	"ACE_G_Chemlight_HiGreen",
	"ACE_G_Chemlight_HiBlue",
	"ACE_G_Chemlight_UltraHiOrange"
];

private _attachment_names = [
	["None"],
	["Blue Smoke","","\a3\Modules_F_Curator\Data\portraitSmokeBlue_ca.paa"],
	["Yellow Smoke","","\a3\Modules_F_Curator\Data\portraitSmokeYellow_ca.paa"],
	["Green Smoke","","\a3\Modules_F_Curator\Data\portraitSmokeGreen_ca.paa"],
	["Orange Smoke","","\a3\Modules_F_Curator\Data\portraitSmokeOrange_ca.paa"],
	["Red Smoke","","\a3\Modules_F_Curator\Data\portraitSmokeRed_F_ca.paa"],
	["Purple Smoke","","\a3\Modules_F_Curator\Data\portraitSmokePurple_ca.paa"],
	["IR Grenade","","\A3\Weapons_F_EPB\Ammo\Data\UI\gear_B_IRstrobe_CA.paa"],
	["White Chemlight","","\z\ace\addons\chemlights\UI\ace_chemlight_hiwhite_x_ca.paa"],
	["Yellow Chemlight","","\z\ace\addons\chemlights\UI\ace_chemlight_hiyellow_x_ca.paa"],
	["Red Chemlight","","\z\ace\addons\chemlights\UI\ace_chemlight_hired_x_ca.paa"],
	["Green Chemlight","","\z\ace\addons\chemlights\UI\ace_chemlight_higreen_x_ca.paa"],
	["Blue Chemlight","","\z\ace\addons\chemlights\UI\ace_chemlight_hiblue_x_ca.paa"],
	["Orange Chemlight","","\z\ace\addons\chemlights\UI\ace_chemlight_ultrahiorange_x_ca.paa"]
];

private _index = 2;
if (sunOrMoon <0.1) then {_index = 7};

[
	"Reeveli's Supply Drop",
	[
		["COMBO","Plane Type",[_planes,_plane_names,0],false],
		["SLIDER","Plane Altitude",[50,500,200,0],false],
		["TOOLBOX:WIDE",["Plane Approach Direction","From which direction will the plane fly from"],[0,2,4,["North","North-East","East","South-East","South","South-West","West","North-West"]],false],
		["COMBO","Box Type",[["B_supplyCrate_F","C_IDAP_supplyCrate_F"],["Supply Box NATO","Supply Box IDAP"],0],false],
		["COMBO","Attachment",[_attachments,_attachment_names,_index],false],
		["SIDES","Plane Side",[WEST],false]
	],
	{
		params ["_results","_position"];
		private _plane_type = _results select 0;
		private _height = _results select 1;
		private _direction = _results select 2;
		private _box_type = _results select 3;
		private _attachment_type = _results select 4;
		private _plane_side = _results select 5;

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

		if (count _plane_side > 1) exitWith {playSound "FD_Start_F";[objNull, "Select only one side!"] call BIS_fnc_showCuratorFeedbackMessage;};
		if (count _plane_side == 0) exitWith {playSound "FD_Start_F";[objNull, "Select side!"] call BIS_fnc_showCuratorFeedbackMessage;};
		_plane_side = _plane_side select 0;

		uiNamespace setVariable ["Rev_arty_supply_call",[_position select 0,_plane_type,_height,_direction,_attachment_type,_plane_side]];
		[_box_type] call Rev_fnc_resupply_box;


	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;