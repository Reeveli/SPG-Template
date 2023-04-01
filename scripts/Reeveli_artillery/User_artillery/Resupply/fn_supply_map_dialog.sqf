/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to handle supply map dialog creation.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_arty_fnc_supply_map_dialog
 *
 1.4.1
	Target and arrow markers updated to drawn style
 1.4
	Code overhaul for new UI
 1.3
	Added additional comments
	Added code for directional arrows
	Safety area marker brush changed to border
	Removed area marker transparency
 1.2
	Minimum altitude raised to 100m
 1.1
	Added map closure on dialog start
 */
 
private _args = missionNamespace getVariable ['Rev_artillery_call',nil];
private _target = _args select 3;
private _pos = _args select 5;


//Variables for artillery call later
player setVariable ["Rev_arty_sup_call",[_pos]];


private _alpha = 1;
if (typeName _target isEqualTo "STRING") then {_alpha = 0};

//Target marker
private _target_pos = createMarkerLocal ["Rev_arty_sup_tgt",_pos];
"Rev_arty_sup_tgt" setMarkerTextLocal "Supply Drop";
"Rev_arty_sup_tgt" setMarkerShapeLocal "ICON";
"Rev_arty_sup_tgt" setMarkerTypeLocal "hd_end";
"Rev_arty_sup_tgt" setMarkerColorLocal "ColorBlue";
"Rev_arty_sup_tgt" setMarkerAlphaLocal _alpha;

//Area marker
private _target_area = createMarkerLocal ["Rev_arty_sup_area",_pos];
"Rev_arty_sup_area" setMarkerShapeLocal "ELLIPSE";
"Rev_arty_sup_area" setMarkerBrush "Border";
"Rev_arty_sup_area" setMarkerColorLocal "ColorRed";
"Rev_arty_sup_area" setMarkerSizeLocal [3000, 3000];

//Plane marker
private _plane_dir = createMarkerLocal ["Rev_arty_sup_dir",_pos];
"Rev_arty_sup_dir" setMarkerShapeLocal "ICON";
"Rev_arty_sup_dir" setMarkerAlphaLocal 0;
"Rev_arty_sup_dir" setMarkerTypeLocal "b_support";

private _name = getText (configFile >> "CfgVehicles" >> Rev_arty_SUP_class >> "displayname");
"Rev_arty_sup_dir" setMarkerTextLocal _name;

//Direction arrow markers
private _arrow1 = createMarkerLocal ["Rev_arty_sup_arrow_1",_pos];
"Rev_arty_sup_arrow_1" setMarkerShapeLocal "ICON";
"Rev_arty_sup_arrow_1" setMarkerTypeLocal "hd_arrow";
"Rev_arty_sup_arrow_1" setMarkerColorLocal "ColorBlack";
"Rev_arty_sup_arrow_1" setMarkerAlphaLocal 0;

private _arrow2 = createMarkerLocal ["Rev_arty_sup_arrow_2",_pos];
"Rev_arty_sup_arrow_2" setMarkerShapeLocal "ICON";
"Rev_arty_sup_arrow_2" setMarkerTypeLocal "hd_arrow";
"Rev_arty_sup_arrow_2" setMarkerColorLocal "ColorBlack";
"Rev_arty_sup_arrow_2" setMarkerAlphaLocal 0;

private _arrow3 = createMarkerLocal ["Rev_arty_sup_arrow_3",_pos];
"Rev_arty_sup_arrow_3" setMarkerShapeLocal "ICON";
"Rev_arty_sup_arrow_3" setMarkerTypeLocal "hd_arrow";
"Rev_arty_sup_arrow_3" setMarkerColorLocal "ColorBlack";
"Rev_arty_sup_arrow_3" setMarkerAlphaLocal 0;

//Creating and populating dialog
if (visibleMap) then {openMap false;};
createDialog "Rev_arty_supply_map_dialog";

//getting arguments to be passed into map EH
private _display = findDisplay 6020;
private _warning = _display displayCtrl 6072;
private _ok = _display displayCtrl 6069;
private _underscore = _display displayCtrl 6071;

//EH for map click
private _id = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	_thisArgs params ["_warning","_ok","_underscore"];

	//Display warning if clicked inside minimum area
	if (_pos inArea "Rev_arty_sup_area") exitWith {
		ctrlSetText [6036, "Position is too close to target! Select approach direction from outside the red circle."];
		_warning ctrlSetTextColor [0,0,0,1];
		playSound "FD_Start_F";
	};
	
	//If position is outside safety area
	//disable warning, enable OK button and set plane marker alpha + pos, target area marker alpha
    ctrlSetText [6036,"Ready to send!"];
	_warning ctrlSetTextColor [0,0,0,0.3];
    "Rev_arty_sup_dir" setMarkerPosLocal _pos;
    "Rev_arty_sup_dir" setMarkerAlphaLocal 1;
	_ok ctrlEnable true;
	_underscore ctrlShow true;

	
	//Set direction arrow facing and position
	private _relDir = (markerPos "Rev_arty_sup_dir") getDir (markerPos "Rev_arty_sup_tgt");

	"Rev_arty_sup_arrow_1" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_sup_arrow_1" setMarkerPosLocal ((markerPos "Rev_arty_sup_tgt") getpos [750,_relDir - 180]);
	"Rev_arty_sup_arrow_1" setMarkerAlphaLocal 1;

	"Rev_arty_sup_arrow_2" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_sup_arrow_2" setMarkerPosLocal ((markerPos "Rev_arty_sup_tgt") getpos [1500,_relDir - 180]);
	"Rev_arty_sup_arrow_2" setMarkerAlphaLocal 1;

	"Rev_arty_sup_arrow_3" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_sup_arrow_3" setMarkerPosLocal ((markerPos "Rev_arty_sup_tgt") getpos [2250,_relDir - 180]);
	"Rev_arty_sup_arrow_3" setMarkerAlphaLocal 1;

},[_warning,_ok,_underscore]];

missionNameSpace setVariable ["Rev_arty_sup_map_event",_id,false];


//preliminary night time check for dialog color inherited from main arty dialog
//Set night time image if needed
private _case = _display displayCtrl 6074;

if (((([player] call ACE_map_fnc_determineMapLight) select 1) select 3) > 0.55) then {
	_case ctrlSetText "scripts\Reeveli_artillery\images\case_n_5.paa";

	//Automatically start flaslight if present
	if ((count (player call ace_map_fnc_getUnitFlashlights)) < 1) exitWith {};
	private _flashlight = (player call ace_map_fnc_getUnitFlashlights) select 0;
	[player, _flashlight] call ace_map_fnc_switchFlashlight;
};

//Plane image
private _img = getText (configFile >> "CfgVehicles" >> Rev_arty_SUP_class >> "editorPreview");
ctrlSetText [6075, _img];

//Attachment
lnbClear 6023;
private _list = [
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

private _names = [
	["None","",[0,0,0,0]],
	["Blue Smoke","\a3\Modules_F_Curator\Data\portraitSmokeBlue_ca.paa"],
	["Yellow Smoke","\a3\Modules_F_Curator\Data\portraitSmokeYellow_ca.paa"],
	["Green Smoke","\a3\Modules_F_Curator\Data\portraitSmokeGreen_ca.paa"],
	["Orange Smoke","\a3\Modules_F_Curator\Data\portraitSmokeOrange_ca.paa"],
	["Red Smoke","\a3\Modules_F_Curator\Data\portraitSmokeRed_F_ca.paa"],
	["Purple Smoke","\a3\Modules_F_Curator\Data\portraitSmokePurple_ca.paa"],
	["IR Grenade","\A3\Weapons_F_EPB\Ammo\Data\UI\gear_B_IRstrobe_CA.paa"],
	["White Chemlight","\z\ace\addons\chemlights\UI\ace_chemlight_hiwhite_x_ca.paa"],
	["Yellow Chemlight","\z\ace\addons\chemlights\UI\ace_chemlight_hiyellow_x_ca.paa"],
	["Red Chemlight","\z\ace\addons\chemlights\UI\ace_chemlight_hired_x_ca.paa"],
	["Green Chemlight","\z\ace\addons\chemlights\UI\ace_chemlight_higreen_x_ca.paa"],
	["Blue Chemlight","\z\ace\addons\chemlights\UI\ace_chemlight_hiblue_x_ca.paa"],
	["Orange Chemlight","\z\ace\addons\chemlights\UI\ace_chemlight_ultrahiorange_x_ca.paa"]
];

private _control = findDisplay 6020 displayCtrl 6023;

{
	_control lnbAddRow ["", (_names select _forEachIndex) select 0];
	_control lnbSetPicture [[_forEachIndex, 0], (_names select _forEachIndex) select 1];
	_control lnbSetData [[_forEachIndex, 1], _x];
} forEach _list;

private _index = 2;
if (sunOrMoon <0.1) then {_index = 7};

lbSetCurSel [6023,_index];


//Altitude
sliderSetRange [6025, 20, 300];
sliderSetPosition [6025, 50];
sliderSetSpeed [6025, 10, 10];
ctrlSetText [6024, format ['Chute opening altitude: %1M',round (sliderPosition 6025)]];
