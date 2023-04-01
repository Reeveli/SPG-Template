/*
 * Author: Reeveli
 * Function to surrender Ai squad for a duration. Called from Zen context action or curator module.
 * Needs to be run locally to the target unit/group.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_unit] remoteExec ["Rev_fnc_group_surrender",_unit]
 *
 */

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};

private _soldiers = units _unit;

{  
	vehicle _x engineOn false;
	unassignVehicle _x;
	_x action["Eject", vehicle _x];
	[_x] spawn {
		params ["_unit"];
		waitUntil {vehicle _unit == _unit};
		[_unit, true] call ACE_captives_fnc_setSurrendered;
	};
} forEach _soldiers;