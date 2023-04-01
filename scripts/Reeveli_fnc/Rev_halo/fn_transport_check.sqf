/*
 * Author: Reeveli 
 * Part of Reeveli's HALO system.
 * Function to handle check which players around the caller unit can be put into the HALO plane. Called from halo_plane.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value: <ARRAY> (array conrtaining sub array of objects and names of objects that fulfill conditions)
 *
 * Example:
 * [_caller] call Rev_fnc_transport_check
 *
 */

params [
	["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {};

private _list = [];
private _names = [];
private _array = units group _unit;

_array = _array select {(_x distance _unit  <= 7) AND (vehicle _x == _x) AND !(_x getVariable ["ACE_isUnconscious", false]) AND (_x in ([] call CBA_fnc_players))};

{
	_list append [_x];
	_names append [name _x];
} forEach _array;

[_list,_names];
