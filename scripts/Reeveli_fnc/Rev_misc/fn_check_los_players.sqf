/*
 * Author: Reeveli
 * Function to check if an infantry unit is visible for ANY player. Visibility from Curator camera does not count. Returns false for virtual entities.
 * Can be called either server or clientside.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value: BOOL
 * True: Unit is visible to one or more players
 * False: Unit is not visible to any players
 *
 * Example:
 * [_unit] call Rev_fnc_check_los_players;
 *
 */

params [
	["_unit",objNull,[objNull]]
];

private _return = false;
private _players = call CBA_fnc_players;

{
	if (([objNull, "VIEW"] checkVisibility [eyePos _x, eyePos _unit]) > 0) exitWith {_return = true};	    
} forEach _players;

_return;