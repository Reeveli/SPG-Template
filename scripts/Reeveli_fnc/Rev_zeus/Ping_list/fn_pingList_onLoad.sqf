/*
 * Author: Reeveli
 * Part of Reeveli's curator ping list system.
 * Client side function to handle the onLoad EH of the ping list control.
 *
 * Arguments:
 * 0: Ping list control <CONTROL>
 *
 * Return Value: NONE
 *
 * Example:
 * [_control] call Rev_fnc_pingList_onLoad
 *
 */

params [
	["_control",controlNull,[controlNull]]
];


lbClear _control;

private _list = missionNamespace getVariable ["Rev_pingList",[]];
reverse _list;

{
	_control lbAdd (name (_x # 0));
	_control lbSetTextRight [_forEachIndex, [(_x # 1),"HH:MM"] call BIS_fnc_timeToString];
	_control lbSetData [_forEachIndex,(_x # 0) call BIS_fnc_netId];
	_control lbSetColor [_forEachIndex, [1,1,1,1-(_forEachIndex * 1/3)]];
	_control lbSetColorRight [_forEachIndex, [1,1,1,1-(_forEachIndex * 1/3)]];
} forEach _list;




