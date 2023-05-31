/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Client side function to create teleport action to an object.
 * Called from Rev_fnc_tp_addPoint
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Side <SIDE>
 *
 * Return Value: Action id <NUMBER>
 *
 * Example:
 * [_object,_side] remoteExecCall ["Rev_fnc_tp_addAction",0,true];
 *
 */

params [
	["_object", objNull, [objNull]],
	["_side",west,[civilian]]
];


if !(hasInterface) exitWith {false};

_object setVariable ["Rev_tp_side",_side,false];

//_object addAction 
private _text = "<t align='center'><img image='a3\ui_f_curator\data\cfgwrapperui\cursors\curatormove_ca.paa' size='2' /><br/></t><t align='center'>Teleport</t>";

private _id = _object addAction 
[
	_text
	,{params ["_target", "_caller", "_actionId", "_arguments"];createDialog "Rev_tp_dialog"}
	,[_object]
	,12
	,true
	,false
	,""
	,"(side _this isEqualTo (_originalTarget getVariable ['Rev_tp_side',sideEnemy]))"
	,Rev_tp_action_radius
	,false
	,""
	,""
];
