/*
 * Author: Reeveli
 * Client side function to suppress Ai squad for a duration. Called from Zen context action or curator module.
 * Needs to be run scheduled environment.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Duration <NUMBER> (default: 10)
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 1, 20] spawn Rev_fnc_group_suppress
 *
 */

params [
	["_unit", objNull, [objNull]],
	["_duration",10,[0]]
];

if (isNull _unit) exitwith
	{
		playSound "FD_Start_F";
		[objNull, "No object was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
	};

private _soldiers = units _unit;
private _stance = stance _unit;
private _ryhma = group _unit;
private _mode = combatMode group _unit;
[objNull, "Squad Suppressed"] call BIS_fnc_showCuratorFeedbackMessage;


{_x setUnitPos "DOWN"} foreach  (units _unit select {vehicle _x == _x});
_ryhma setCombatMode "GREEN";
sleep _duration;
{_x setUnitPos "AUTO"} foreach  (units _unit select {vehicle _x == _x});
_ryhma setCombatMode _mode;