/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Function to remove teleport point from dialog list.
 * Can be run on any machine, the actual listing variable is propagated across network anyway. Avoid global execution for network performance.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [this] call Rev_fnc_tp_deletePoint
 *
 */

params [
	["_object", objNull, [objNull]]
];

//Safetychecks
if (isNull _object) exitWith {false;};

private _list = missionNamespace getVariable ["Rev_tp_list",[]];
private _index = ([_object] call Rev_fnc_tp_listCheck);

_list deleteAt _index;
missionNamespace setVariable ["Rev_tp_list",_list,true];