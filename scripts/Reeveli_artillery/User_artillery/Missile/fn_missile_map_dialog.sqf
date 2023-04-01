/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, tactical missile ordnance.
 * Client side function to handel missile map dialog creation and population. Called from fn_type_MIS
 *
 * Arguments:
 * 0: Designated target <NUMBER|STRING> (default: 0)
 * 1: Laser target <OBJECT>
 * 2: Indicated target position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [_target,_tgt,_pos] call Rev_arty_fnc_missile_map_dialog
 *
 1.3.2
	Arrows and target markers updated
	Rev_arty_mis_laser maker creation removed
 1.3.1
	Rev_arty_mis_tgt is now a 'waypoint' marker, code for marker tilting removed
		Marker text is now 'Laser detected'
 1.3
	New code for new UI
	Old BIS_fnc_addStackedEventHandler replaced with with missionEventhandler
 1.2
	Area marker changed to border instead of solid
	Added additional comments
	Added code for directional arrows
	Missile list code changed to include pictures
 1.1
	Added map closure in dialog start
 */

params [
	["_target",0,["",0]],
	["_tgt",objNull,[objNull]],
	["_pos",[0,0,0],[[]],[2,3]]
];

//Variables for artillery call later
player setVariable ["Rev_arty_mis_call",[_pos,_tgt]];


private _alpha = 1;
if (typeName _target isEqualTo "STRING") then {_alpha = 0};

//Target marker
private _target_pos = createMarkerLocal ["Rev_arty_mis_tgt",_pos];
"Rev_arty_mis_tgt" setMarkerTextLocal "Laser detected";
"Rev_arty_mis_tgt" setMarkerShapeLocal "ICON";
"Rev_arty_mis_tgt" setMarkerTypeLocal "waypoint";
"Rev_arty_mis_tgt" setMarkerColorLocal "ColorRed";
"Rev_arty_mis_tgt" setMarkerAlphaLocal _alpha;

//Area marker
private _target_area = createMarkerLocal ["Rev_arty_mis_area",_pos];
"Rev_arty_mis_area" setMarkerShapeLocal "ELLIPSE";
"Rev_arty_mis_area" setMarkerBrush "Border";
"Rev_arty_mis_area" setMarkerColorLocal "ColorRed";
"Rev_arty_mis_area" setMarkerSizeLocal [4000, 4000];

//Missile launcher marker
private _plane_dir = createMarkerLocal ["Rev_arty_mis_dir",_pos];
"Rev_arty_mis_dir" setMarkerShapeLocal "ICON";
"Rev_arty_mis_dir" setMarkerAlphaLocal 0;
"Rev_arty_mis_dir" setMarkerTypeLocal "b_Ordnance";

//Direction arrow markers
private _arrow1 = createMarkerLocal ["Rev_arty_mis_arrow_1",_pos];
"Rev_arty_mis_arrow_1" setMarkerShapeLocal "ICON";
"Rev_arty_mis_arrow_1" setMarkerTypeLocal "hd_arrow";
"Rev_arty_mis_arrow_1" setMarkerColorLocal "ColorBlack";
"Rev_arty_mis_arrow_1" setMarkerAlphaLocal 0;

private _arrow2 = createMarkerLocal ["Rev_arty_mis_arrow_2",_pos];
"Rev_arty_mis_arrow_2" setMarkerShapeLocal "ICON";
"Rev_arty_mis_arrow_2" setMarkerTypeLocal "hd_arrow";
"Rev_arty_mis_arrow_2" setMarkerColorLocal "ColorBlack";
"Rev_arty_mis_arrow_2" setMarkerAlphaLocal 0;

private _arrow3 = createMarkerLocal ["Rev_arty_mis_arrow_3",_pos];
"Rev_arty_mis_arrow_3" setMarkerShapeLocal "ICON";
"Rev_arty_mis_arrow_3" setMarkerTypeLocal "hd_arrow";
"Rev_arty_mis_arrow_3" setMarkerColorLocal "ColorBlack";
"Rev_arty_mis_arrow_3" setMarkerAlphaLocal 0;




//Creating and populating dialog
if (visibleMap) then {openMap false;};
createDialog "Rev_arty_fnc_missile_map";
private _count = 0;

if (Rev_arty_MIS_enable) then {
	lnbAddRow [6033,["Tactical Missile",str Rev_arty_MIS_amount]];
	lnbSetData [6033,[_count, 1], "ammo_Missile_Cruise_01"];
	_count = _count + 1;
};

if (Rev_arty_CLU_enable) then {
	lnbAddRow [6033,["Cluster Missile",str Rev_arty_MIS_amount]];
	lnbSetData [6033,[_count, 1], "ammo_Missile_Cruise_01_Cluster"];
	_count = _count + 1;
};

lnbSetCurSelRow [6033, 0];

sliderSetSpeed [6035, 100, 100];
ctrlSetText [6034, format ['Flying Altitude: %1M',round (sliderPosition 6035)]];

//getting arguments to be passed into map EH
private _display = findDisplay 6030;
private _warning = _display displayCtrl 6072;
private _ok = _display displayCtrl 6069;
private _underscore = _display displayCtrl 6071;

//EH for map click
private _id = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	_thisArgs params ["_warning","_ok","_underscore"];

	//Display warning if clicked inside minimum area
	if (_pos inArea "Rev_arty_mis_area") exitWith {
		ctrlSetText [6036, "Position is too close to target! Select approach direction from outside the red circle."];
		_warning ctrlSetTextColor [0,0,0,1];
		playSound "FD_Start_F";
	};
	
	//If position is outside safety area
	//disable warning, enable OK button and set plane marker alpha + pos, target area marker alpha
    ctrlSetText [6036,"Ready to send!"];
	_warning ctrlSetTextColor [0,0,0,0.3];
    "Rev_arty_mis_dir" setMarkerPosLocal _pos;
    "Rev_arty_mis_dir" setMarkerAlphaLocal 1;	
	_ok ctrlEnable true;
	_underscore ctrlShow true;


	//Set direction arrow facing and position
	private _relDir = (markerPos "Rev_arty_mis_dir") getDir (markerPos "Rev_arty_mis_tgt");

	"Rev_arty_mis_arrow_1" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_mis_arrow_1" setMarkerPosLocal ((markerPos "Rev_arty_mis_tgt") getpos [1000,_relDir - 180]);
	"Rev_arty_mis_arrow_1" setMarkerAlphaLocal 1;

	"Rev_arty_mis_arrow_2" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_mis_arrow_2" setMarkerPosLocal ((markerPos "Rev_arty_mis_tgt") getpos [2000,_relDir - 180]);
	"Rev_arty_mis_arrow_2" setMarkerAlphaLocal 1;

	"Rev_arty_mis_arrow_3" setMarkerDirLocal (_relDir + 8);
	"Rev_arty_mis_arrow_3" setMarkerPosLocal ((markerPos "Rev_arty_mis_tgt") getpos [3000,_relDir - 180]);
	"Rev_arty_mis_arrow_3" setMarkerAlphaLocal 1;

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

