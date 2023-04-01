/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, air support.
 * Client side function to start the air support dialog. Called from fn_type_AIR
 *
 * Arguments:
 * 0: Target TRP <STRING|NUMBER> (default: 0)
 * 1: Indicated target position (not true) caller position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [_target,_pos] call Rev_arty_fnc_air_map_dialog
 *
 2.4.2
	Header example call updated
 2.4.1
	Arrows and target markers updated
 2.4
	New code for night time UI additions
	Added interface safety condition
 2.3
	Area marker changed to border instead of solid
	Added additional comments
	Added code for directional arrows
 2.2
	Minimum altitude raised to 50m
 2.1
	Added map closure on dialog start
 2.0
	Complete overhaul to accomodate new UI
 */

if !(hasInterface) exitWith {false};

params [
	["_target",0,["",0]],
	["_pos",[0,0,0],[[]],[2,3]]
];

//Variables for artillery call later
player setVariable ["Rev_arty_air_call",[_pos]];


private _alpha = 1;
if (typeName _target isEqualTo "STRING") then {_alpha = 0};

//Target marker
private _target_pos = createMarkerLocal ["Rev_arty_air_tgt",_pos];
"Rev_arty_air_tgt" setMarkerTextLocal "Target";
"Rev_arty_air_tgt" setMarkerShapeLocal "ICON";
"Rev_arty_air_tgt" setMarkerTypeLocal "waypoint";
"Rev_arty_air_tgt" setMarkerColorLocal "ColorRed";
"Rev_arty_air_tgt" setMarkerAlphaLocal _alpha;

//Area marker
private _target_area = createMarkerLocal ["Rev_arty_air_area",_pos];
"Rev_arty_air_area" setMarkerShapeLocal "ELLIPSE";
"Rev_arty_air_area" setMarkerBrush "Border";
"Rev_arty_air_area" setMarkerColorLocal "ColorRed";
"Rev_arty_air_area" setMarkerSizeLocal [3000, 3000];

//Plane marker
private _plane_dir = createMarkerLocal ["Rev_arty_air_dir",_pos];
"Rev_arty_air_dir" setMarkerShapeLocal "ICON";
"Rev_arty_air_dir" setMarkerAlphaLocal 0;

//Direction arrow markers
private _arrow1 = createMarkerLocal ["Rev_arty_air_arrow_1",_pos];
"Rev_arty_air_arrow_1" setMarkerShapeLocal "ICON";
"Rev_arty_air_arrow_1" setMarkerTypeLocal "hd_arrow";
"Rev_arty_air_arrow_1" setMarkerColorLocal "ColorBlack";
"Rev_arty_air_arrow_1" setMarkerAlphaLocal 0;

private _arrow2 = createMarkerLocal ["Rev_arty_air_arrow_2",_pos];
"Rev_arty_air_arrow_2" setMarkerShapeLocal "ICON";
"Rev_arty_air_arrow_2" setMarkerTypeLocal "hd_arrow";
"Rev_arty_air_arrow_2" setMarkerColorLocal "ColorBlack";
"Rev_arty_air_arrow_2" setMarkerAlphaLocal 0;

private _arrow3 = createMarkerLocal ["Rev_arty_air_arrow_3",_pos];
"Rev_arty_air_arrow_3" setMarkerShapeLocal "ICON";
"Rev_arty_air_arrow_3" setMarkerTypeLocal "hd_arrow";
"Rev_arty_air_arrow_3" setMarkerColorLocal "ColorBlack";
"Rev_arty_air_arrow_3" setMarkerAlphaLocal 0;

//Creating and populating dialog
if (visibleMap) then {openMap false;};
createDialog "Rev_arty_air_map";

//getting arguments to be passed into map EH
private _display = findDisplay 4080;
private _warning = _display displayCtrl 6072;
private _ok = _display displayCtrl 6069;
private _underscore = _display displayCtrl 6071;

//Setting up onMapclick EH
private _id = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	_thisArgs params ["_warning","_ok","_underscore"];
	
	//Display warning if clicked inside minimum area
	if (_pos inArea "Rev_arty_air_area") exitWith {
		ctrlSetText [6072, "Position is too close to target! Select approach direction from outside the red circle."];
		_warning ctrlSetTextColor [0,0,0,1];
		playSound "FD_Start_F";
	};
	
	//If position is outside safety area
	//disable warning, enable OK button and set plane marker alpha + pos, target area marker alpha
	ctrlSetText [6072,"Ready to send!"];
	_warning ctrlSetTextColor [0,0,0,0.3];
    "Rev_arty_air_dir" setMarkerPosLocal _pos;
    "Rev_arty_air_dir" setMarkerAlphaLocal 1;	
	_ok ctrlEnable true;
	_underscore ctrlShow true;
	
	//Set direction arrow facing and position
	private _relDir = (markerPos "Rev_arty_air_dir") getDir (markerPos "Rev_arty_air_tgt");

	"Rev_arty_air_arrow_1" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_air_arrow_1" setMarkerPosLocal ((markerPos "Rev_arty_air_tgt") getpos [750,_relDir - 180]);
	"Rev_arty_air_arrow_1" setMarkerAlphaLocal 1;

	"Rev_arty_air_arrow_2" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_air_arrow_2" setMarkerPosLocal ((markerPos "Rev_arty_air_tgt") getpos [1500,_relDir - 180]);
	"Rev_arty_air_arrow_2" setMarkerAlphaLocal 1;

	"Rev_arty_air_arrow_3" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_air_arrow_3" setMarkerPosLocal ((markerPos "Rev_arty_air_tgt") getpos [2250,_relDir - 180]);
	"Rev_arty_air_arrow_3" setMarkerAlphaLocal 1;
},[_warning,_ok,_underscore]];

missionNameSpace setVariable ["Rev_arty_air_map_event",_id,false];


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



private ["_name","_control","_text"];
{
	_name = getText (configFile >> "CfgVehicles" >> _x >> "displayname");

	_control = findDisplay 4080 displayCtrl 4081;
	_control lbAdd _name;
	_control lbSetData [_forEachIndex, _x];

} forEach Rev_arty_AIR_class;

lbSetCurSel [4081, 0];

sliderSetRange [4085, 100, 800];
sliderSetPosition [4085, 300];
sliderSetSpeed [4085, 10, 10];
ctrlSetText [4084, format ['Flying Altitude: %1M',round (sliderPosition 4085)]];