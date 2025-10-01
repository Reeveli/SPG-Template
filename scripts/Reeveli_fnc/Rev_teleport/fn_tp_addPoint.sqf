/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Server function to create a teleport point to an object.
 * Must be run on server, so use either global object init fields or remoteexecute on server. Global execution works also.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Display name <STRING>
 * 2: Side <SIDE>
 * 3: Enable action on point, if false then point acts only as destination <BOOLEAN> (default: true)
 *
 * Return Value: NONE
 *
 * Example:
 * [this,"My teleportation point",west] call Rev_fnc_tp_addPoint;
 *
 1.1
	Added parameter and check if point is two-way
 */

params [
	["_object", objNull, [objNull]],
	["_name","",[""]],
	["_side",west,[civilian]],
	["_action", true, [true]]
];

//Safetychecks
if !(isServer) exitWith {false;};
if (isNull _object) exitWith {false;};

if (([_object] call Rev_fnc_tp_listCheck) > -1) exitWith {
	diag_log "Rev_fnc_tp_addPoint: Teleport point already exists on selected object";
	false;
};

//Updating and propagating new list
private _list = missionNamespace getVariable ["Rev_tp_list",[]];
private _new = _this;
_list append [_new];
missionNamespace setVariable ["Rev_tp_list",_list,true];

//Ehs to remove point if killed/deleted
_object addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[_unit] call Rev_fnc_tp_deletePoint;
}];

_object addEventHandler ["Deleted", {
	params ["_entity"];
	[_entity] call Rev_fnc_tp_deletePoint;
}];

//Adding action to players
if !(_action) exitWith {};
[_object,_side] remoteExecCall ["Rev_fnc_tp_addAction",0,true];