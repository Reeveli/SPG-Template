/*
 * Author: Reeveli 
 * Client side function to remove map location via ZEN module.
 * Called from Rev_fnc_zeus_init
 *
 * Arguments:
 * 0: Selected position <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 0] call Rev_fnc_locationCuratorRemove
 *
 */


if (!hasInterface) exitWith {false};

params [
	["_position",nil,[[]],[2,3]]
];

private _name = [_position] call Rev_fnc_locationName;
if !(_name select 0) exitWith
{
	playSound "FD_Start_F";
	[objNull, "No location found!"] call BIS_fnc_showCuratorFeedbackMessage;
};

playSound "3DEN_notificationDefault";
["Location Removed", _name select 1, 8] call BIS_fnc_curatorHint;
[_position] remoteExec ["Rev_fnc_locationRemove",0,true];	
