/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Client side function to handle actual teleportation.
 * Called from Rev_fnc_tp_onButtonClick or ZEn curator module
 *
 * Arguments:
 * 2: Unit <OBJECT>
 * 1: Object <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [player, _object] call Rev_fnc_tp_teleport
 *
 1.2
	Increased text size
 1.1
	Player placement radius increased to 12 meters
 */

params [
	["_unit", player, [objNull]],
	["_object", objNull, [objNull]]
];

if !(hasInterface) exitWith {};
if !(player isEqualTo _unit) exitWith {
	diag_log "Rev_fnc_tp_teleport: Selected unit is not the local player running function";
	false;
};

//Into
cutText ["<t size='2'>You are being moved.</t>","BLACK",1,true,true];
player enableSimulation false;

[
	{
		player setPos ([_this # 0, 12] call CBA_fnc_randPos)
	},
	[_object],
	(Rev_tp_action_time * 0.5)
] call CBA_fnc_waitAndExecute;

//Out of
[
	{
        cutText["", "BLACK IN" , 2, true];
		player enableSimulation true;
	},
	[],
	Rev_tp_action_time
] call CBA_fnc_waitAndExecute;