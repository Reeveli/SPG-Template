/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Function to check if teleportation point already exists for that object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value: Index <NUMBER>
 *
 * Example:
 * [_object] call Rev_fnc_tp_listCheck
 *
 */

params [
	["_object", objNull, [objNull]]
];

if (isNull _object) exitWith {false;};

private _list = missionNamespace getVariable ["Rev_tp_list",[]];
private _index = _list findIf {(_x # 0) isEqualTo _object};

_index;