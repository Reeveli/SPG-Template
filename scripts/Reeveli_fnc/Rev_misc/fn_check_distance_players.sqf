/*
 * Author: Reeveli
 * Function to check if ANY players are at a specified distance away from a unit.
 * Can be called either server or clientside.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Distance <NUMBER>
 *
 * Return Value: BOOL
 * True: One or more players are in range
 * False: Unit is not in range of any players
 *
 * Example:
 * [_unit,_range] call Rev_fnc_check_distance_players;
 *
 */

params [
	["_unit",objNull,[objNull]],
	["_range",5,[0]]
];

private _return = false;
private _players = call CBA_fnc_players;

{
	if ((_x distance _unit) < _range) exitWith {_return = true};	    
} forEach _players;

_return;