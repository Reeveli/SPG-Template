/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, gunship support.
 * Client side function to start the gunship support dialog.
 *
 * Arguments:
 * 0: Target TRP <STRING|NUMBER> (default: 0)
 * 1: Indicated target position (not true) caller position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [_range,_angle,_pos] call Rev_arty_fnc_gunship_map_dialog
 *
 1.3.2
	Fixed wrong idd on ok button
 1.3.1
	Arrows and target markers updated
 1.3
	Code updated for new UI
 1.2
	Added additional comments
	Added code for directional arrows	
 1.1
	Added map closure on dialog start
 */

params [
	["_target",0,["",0]],
	["_pos",[0,0,0],[[]],[2,3]]
];

//Variables for artillery call later
player setVariable ["Rev_arty_gun_call",[_pos]];



private _alpha = 1;
if (typeName _target isEqualTo "STRING") then {_alpha = 0};

//Target marker
private _target_pos = createMarkerLocal ["Rev_arty_gun_tgt",_pos];
"Rev_arty_gun_tgt" setMarkerTextLocal "Target";
"Rev_arty_gun_tgt" setMarkerShapeLocal "ICON";
"Rev_arty_gun_tgt" setMarkerTypeLocal "waypoint";
"Rev_arty_gun_tgt" setMarkerColorLocal "ColorRed";
"Rev_arty_gun_tgt" setMarkerAlphaLocal _alpha;

//Area marker
private _target_area = createMarkerLocal ["Rev_arty_gun_area",_pos];
"Rev_arty_gun_area" setMarkerShapeLocal "ELLIPSE";
"Rev_arty_gun_area" setMarkerBrush "Border";
"Rev_arty_gun_area" setMarkerColorLocal "ColorRed";
"Rev_arty_gun_area" setMarkerSizeLocal [2000, 2000];



//Plane marker
private _plane_dir = createMarkerLocal ["Rev_arty_gun_dir",[0,0,0]];
"Rev_arty_gun_dir" setMarkerShapeLocal "ICON";
"Rev_arty_gun_dir" setMarkerAlphaLocal 0;
"Rev_arty_gun_dir" setMarkerTypeLocal "b_air";

private _name = getText (configFile >> "CfgVehicles" >> "B_T_VTOL_01_armed_F" >> "displayname");
"Rev_arty_gun_dir" setMarkerTextLocal _name;

//Direction arrow markers
private _arrow1 = createMarkerLocal ["Rev_arty_gun_arrow_1",_pos getpos [2000,180]];
"Rev_arty_gun_arrow_1" setMarkerShapeLocal "ICON";
"Rev_arty_gun_arrow_1" setMarkerTypeLocal "hd_arrow";
"Rev_arty_gun_arrow_1" setMarkerColorLocal "ColorBlack";
"Rev_arty_gun_arrow_1" setMarkerAlphaLocal 0;
"Rev_arty_gun_arrow_1" setMarkerDirLocal 98; //Added +8 to account for hand drawn weirdness

private _arrow2 = createMarkerLocal ["Rev_arty_gun_arrow_2",_pos getpos [2000,300]];
"Rev_arty_gun_arrow_2" setMarkerShapeLocal "ICON";
"Rev_arty_gun_arrow_2" setMarkerTypeLocal "hd_arrow";
"Rev_arty_gun_arrow_2" setMarkerColorLocal "ColorBlack";
"Rev_arty_gun_arrow_2" setMarkerAlphaLocal 0;
"Rev_arty_gun_arrow_2" setMarkerDirLocal 218;

private _arrow3 = createMarkerLocal ["Rev_arty_gun_arrow_3",_pos getpos [2000,60]];
"Rev_arty_gun_arrow_3" setMarkerShapeLocal "ICON";
"Rev_arty_gun_arrow_3" setMarkerTypeLocal "hd_arrow";
"Rev_arty_gun_arrow_3" setMarkerColorLocal "ColorBlack";
"Rev_arty_gun_arrow_3" setMarkerAlphaLocal 0;
"Rev_arty_gun_arrow_3" setMarkerDirLocal 338;

//Creating and populating dialog
if (visibleMap) then {openMap false;};
createDialog "Rev_arty_gun_map_dialog";
private _img = getText (configFile >> "CfgVehicles" >> "B_T_VTOL_01_armed_F" >> "editorPreview");
ctrlSetText [6075, _img];

//Getting arguments to be passed into map EH
private _display = findDisplay 6040;
private _ok = _display displayCtrl 6069;
private _underscore = _display displayCtrl 6071;
private _warning = _display displayCtrl 6072;

//EH for map click
private _id = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	_thisArgs params ["_warning","_ok","_underscore"];

	//Display warning if clicked inside minimum area
	if (_pos inArea "Rev_arty_gun_area") exitWith {
		_warning ctrlSetText "Position is too close to target! Select approach direction from outside the red circle.";
		_warning ctrlSetTextColor [0,0,0,1];
		playSound "FD_Start_F";
	};
	
	//If position is outisde safety area
	//Disable warning, enable OK button and set plane marker alpha + pos, target area marker alpha
	ctrlSetText [6072,"Ready to send!"];
	_warning ctrlSetTextColor [0,0,0,0.3];
    "Rev_arty_gun_dir" setMarkerPosLocal _pos;
    "Rev_arty_gun_dir" setMarkerAlphaLocal 1;	
	_ok ctrlEnable true;
	_underscore ctrlShow true;

	//set directional arrow alphas
	"Rev_arty_gun_arrow_1" setMarkerAlphaLocal 1;
	"Rev_arty_gun_arrow_2" setMarkerAlphaLocal 1;
	"Rev_arty_gun_arrow_3" setMarkerAlphaLocal 1;

},[_warning,_ok,_underscore]];

missionNameSpace setVariable ["Rev_arty_gun_map_event",_id,false];

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


//Loiter slider
sliderSetRange [6043, 1000, 3000];
sliderSetPosition [6043, 2000];
sliderSetSpeed [6043, 100, 100];
ctrlSetText [6042, format ['Loiterin Radius: %1M',round (sliderPosition 6043)]];

//Alt slider
sliderSetRange [6045, 500, 1500];
sliderSetPosition [6045, 1000];
sliderSetSpeed [6045, 100, 100];
ctrlSetText [6044, format ['Loiterin Altitude: %1M',round (sliderPosition 6045)]];

//View slider
sliderSetRange [6049, 2000, 8000];
sliderSetPosition [6049, 5000];
sliderSetSpeed [6049, 100, 100];
ctrlSetText [6048, format ['View Distance: %1M',round (sliderPosition 6049)]];