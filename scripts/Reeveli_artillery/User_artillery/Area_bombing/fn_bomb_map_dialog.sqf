/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, area bombing ordnance.
 * Client side function to start the bomb dialog, populating the dialog. Arguments are called from an externally defined variable.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_arty_fnc_bomb_map_dialog
 *
 1.4
	Adjusted amount slider start value calculation
	Code adjusted for new hashmap usage
 1.3
	Target marker is now deleted if <50m from TRP to prevent marker overlap
	Target circle marker is now 50m radius (was 100)
	Approach arrows are now spaced more evenly on flight path
	Approach arrows are now mil triangles and not drawn arrows
 1.2
	Pattern list neutered
 1.1
	Arrow, target and target circle updated
	Target marker alpha is now set same way as in other types (1 unless TRP used)
	Target marker is no longer rotated relative to the plane/drop pattern (left as legacy dead code)
 */

private _args = missionNamespace getVariable ['Rev_artillery_call',nil];
_args params ["_location","_angle","_range","_target","_round_type","_finalPos","_number","_delay"];



private _alpha = 1;
if (typeName _target isEqualTo "STRING") then {
	private _markerPos = getMarkerPos _target;
	if ((_finalPos distance _markerPos) < 50) then {_alpha = 0;};	
};


//Target marker
private _target_pos = createMarkerLocal ["Rev_arty_bom_tgt",_finalPos];

"Rev_arty_bom_tgt" setMarkerTextLocal "Target";
"Rev_arty_bom_tgt" setMarkerShapeLocal "ICON";
"Rev_arty_bom_tgt" setMarkerTypeLocal "waypoint";
"Rev_arty_bom_tgt" setMarkerColorLocal "ColorRed";
"Rev_arty_bom_tgt" setMarkerAlphaLocal _alpha;


//Target circle marker
private _target_circle = createMarkerLocal ["Rev_arty_bom_circle",_finalPos];
"Rev_arty_bom_circle" setMarkerShapeLocal "ELLIPSE";
"Rev_arty_bom_circle" setMarkerBrush "Border";
"Rev_arty_bom_circle" setMarkerColorLocal "ColorRed";
"Rev_arty_bom_circle" setMarkerSizeLocal [50,50];
"Rev_arty_bom_tgt" setMarkerAlphaLocal _alpha;

//Area marker
private _target_area = createMarkerLocal ["Rev_arty_bom_area",_finalPos];
"Rev_arty_bom_area" setMarkerShapeLocal "ELLIPSE";
"Rev_arty_bom_area" setMarkerBrush "Border";
"Rev_arty_bom_area" setMarkerColorLocal "ColorRed";
"Rev_arty_bom_area" setMarkerSizeLocal [3000, 3000];

//Plane marker
private _plane_dir = createMarkerLocal ["Rev_arty_bom_dir",_finalPos];
"Rev_arty_bom_dir" setMarkerShapeLocal "ICON";
"Rev_arty_bom_dir" setMarkerAlphaLocal 0;
//Updating plane maker type based on class
private _marker = "b_plane";
if (Rev_arty_bom_class isKindOf "Helicopter") then {_marker = "b_air"};
if (Rev_arty_bom_class isKindOf "UAV") then {_marker = "b_uav"};

"Rev_arty_bom_dir" setMarkerTypeLocal _marker;
private _name = getText (configFile >> "CfgVehicles" >> Rev_arty_bom_class >> "displayname");
"Rev_arty_bom_dir" setMarkerTextLocal _name;

//Direction arrow markers
private _arrow1 = createMarkerLocal ["Rev_arty_bom_arrow_1",_finalPos];
"Rev_arty_bom_arrow_1" setMarkerShapeLocal "ICON";
"Rev_arty_bom_arrow_1" setMarkerTypeLocal "mil_triangle";
"Rev_arty_bom_arrow_1" setMarkerColorLocal "ColorWEST";
"Rev_arty_bom_arrow_1" setMarkerSizeLocal [1,2];
"Rev_arty_bom_arrow_1" setMarkerAlphaLocal 0;

private _arrow2 = createMarkerLocal ["Rev_arty_bom_arrow_2",_finalPos];
"Rev_arty_bom_arrow_2" setMarkerShapeLocal "ICON";
"Rev_arty_bom_arrow_2" setMarkerTypeLocal "mil_triangle";
"Rev_arty_bom_arrow_2" setMarkerColorLocal "ColorWEST";
"Rev_arty_bom_arrow_2" setMarkerSizeLocal [1,2];
"Rev_arty_bom_arrow_2" setMarkerAlphaLocal 0;

private _arrow3 = createMarkerLocal ["Rev_arty_bom_arrow_3",_finalPos];
"Rev_arty_bom_arrow_3" setMarkerShapeLocal "ICON";
"Rev_arty_bom_arrow_3" setMarkerTypeLocal "mil_triangle";
"Rev_arty_bom_arrow_3" setMarkerColorLocal "ColorWEST";
"Rev_arty_bom_arrow_3" setMarkerSizeLocal [1,2];
"Rev_arty_bom_arrow_3" setMarkerAlphaLocal 0;


//Creating and populating dialog
if (visibleMap) then {openMap false;};
createDialog "Rev_arty_bomb_dialog";

//getting arguments to be passed into map EH
private _display = findDisplay 6050;
private _warning = _display displayCtrl 6072;
private _ok = _display displayCtrl 6069;
private _underscore = _display displayCtrl 6071;

//EH for map click
private _id = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_finalPos", "_alt", "_shift"];
	_thisArgs params ["_warning","_ok","_underscore"];

	//Display warning if clicked inside minimum area
	if (_finalPos inArea "Rev_arty_bom_area") exitWith {
		ctrlSetText [6072, "Position is too close to target! Select approach direction from outside the red circle."];
		_warning ctrlSetTextColor [0,0,0,1];
		playSound "FD_Start_F";
	};
	
	//If position is outside safety area
	//disable warning, enable OK button and set plane marker alpha + pos, target area marker alpha
	ctrlSetText [6072,"Ready to send!"];
	_warning ctrlSetTextColor [0,0,0,0.3];
    "Rev_arty_bom_dir" setMarkerPosLocal _finalPos;
    "Rev_arty_bom_dir" setMarkerAlphaLocal 1;
	_ok ctrlEnable true;
	_underscore ctrlShow true;
	
	private _relDir = (markerPos "Rev_arty_bom_dir") getDir (markerPos "Rev_arty_bom_tgt");
	private _relDistance = (markerPos "Rev_arty_bom_dir") distance (markerPos "Rev_arty_bom_tgt");

	//Set direction arrow facing and position
	"Rev_arty_bom_arrow_1" setMarkerDirLocal (_relDir);
	"Rev_arty_bom_arrow_1" setMarkerPosLocal ((markerPos "Rev_arty_bom_dir") getpos [(_relDistance / 6),_relDir]);
	"Rev_arty_bom_arrow_1" setMarkerAlphaLocal 1;

	"Rev_arty_bom_arrow_2" setMarkerDirLocal (_relDir);
	"Rev_arty_bom_arrow_2" setMarkerPosLocal ((markerPos "Rev_arty_bom_dir") getpos [(_relDistance / 6) * 3,_relDir]);
	"Rev_arty_bom_arrow_2" setMarkerAlphaLocal 1;

	"Rev_arty_bom_arrow_3" setMarkerDirLocal (_relDir);
	"Rev_arty_bom_arrow_3" setMarkerPosLocal ((markerPos "Rev_arty_bom_dir") getpos [(_relDistance / 6) * 5,_relDir]);
	"Rev_arty_bom_arrow_3" setMarkerAlphaLocal 1;

	//Target cicrle marker alpha
	"Rev_arty_bom_circle" setMarkerAlphaLocal 1;

	
	//Exit if ordnanace type is not selected
	if ((lbCurSel 6052) == -1) exitWith {
		ctrlSetText [6072, "No ordnance type selected!"];
		_warning ctrlSetTextColor [0,0,0,1];
		_ok ctrlEnable false;
		_underscore ctrlShow false;
	};

},[_warning,_ok,_underscore]];

missionNameSpace setVariable ["Rev_arty_bom_event",_id,false];

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
private _img = getText (configFile >> "CfgVehicles" >> Rev_arty_bom_class >> "editorPreview");
ctrlSetText [6075, _img];

//Attachment
lnbClear 6052;
private _list = [
	"Bo_Mk82",
	"BombCluster_01_Ammo_F",
	"napalm"
];

private _names = [
	["Conventional","scripts\Reeveli_artillery\User_artillery\Area_bombing\images\bomb.paa"],
	["Clusters","scripts\Reeveli_artillery\User_artillery\Area_bombing\images\cluster.paa"],
	["Incendiary","scripts\Reeveli_artillery\User_artillery\Area_bombing\images\napalm.paa"]
];

private _control = findDisplay 6050 displayCtrl 6052;

{
	_control lnbAddRow [(_names select _forEachIndex) select 0,str Rev_arty_BOM_amount];
	//_control lnbSetPicture [[_forEachIndex, 0], (_names select _forEachIndex) select 1];
	_control lnbSetData [[_forEachIndex, 1], _x];
} forEach _list;


//Ordnance amount
sliderSetRange [6054, 1, Rev_arty_BOM_amount];
sliderSetPosition [6054, floor (Rev_arty_BOM_amount / 2)];
sliderSetSpeed [6054, 1, 1];
ctrlSetText [6053, format ['Ordnance amount: %1',round (sliderPosition 6054)]];




//hashmap for later data use
Rev_arty_bombData set ["TargetPos", _finalPos];
Rev_arty_bombData set ["BombType", _round_type];
Rev_arty_bombData set ["BombAmount", _number];
Rev_arty_bombData set ["TargetDirection", _angle];
Rev_arty_bombData set ["PlaneClass", Rev_arty_bom_class];
Rev_arty_bombData set ["PlaneSide", side player];
Rev_arty_bombData set ["Caller", player];

//Variable set to check for double loops
player setVariable ["Rev_arty_bom_call",true,false];

/* //Pattern list neutered, left as legacy. Possible reuse for gun runs in the future
private _patternList = _display displayCtrl 6057;
//Drop pattern
{
	_patternList lbAdd _x;
} foreach ["Linear","Horizontal"];

_patternList lbSetCurSel 0;
*/