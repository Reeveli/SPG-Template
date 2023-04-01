/*
 * Author: ACE3 Mod, slight modifications by Reeveli.
 * Based on ACE_maptools_fnc_openMapGpsUpdate
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to enable GPS object in artillery dialog. Called from the gps dialog control itself.
 *
 * Arguments:
 * 0: Control <CONTROL>
 *
 * Return Value <BOOL>
 *
 * Example:
 * [_control] call Rev_arty_fnc_dilaog_gps;
 *
 1.1
	Deleted unused arrays _arr1 & _arr2, not sure why they were left as active code
 */

params [
	["_control",controlNull,[controlNull]]
];

private _assigned_items = (assignedItems player);
private _items = ["ItemGPS","I_UavTerminal","C_UavTerminal","O_UavTerminal","I_E_UavTerminal","B_UavTerminal"];
if ((count (_assigned_items arrayIntersect _items)) < 1) exitWith {false};

private _mapDisplay = ctrlParent _control;

_control ctrlShow true;

private _heading = _mapDisplay displayCtrl 913590;
_heading ctrlSetText str (round (getDir ACE_player));  // Set Heading
private _altitude = _mapDisplay displayCtrl 913591;
_altitude ctrlSetText str (round ((getPosASL ACE_player) select 2) + (missionNamespace getVariable ["ACE_common_mapAltitude",0]));
private _gps = _mapDisplay displayCtrl 913592;
_gps ctrlSetText mapGridPosition ACE_player; // Set grid cords

true;

