/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to check which channles have been allowed by the addon options. Called from Rev_markers2_fnc_removal.
 *
 * Arguments: NONE
 *
 * Return Value:
 * Allowed channels <ARRAY>
 *
 * Example:
 * call Rev_markers2_fnc_control
 *
 */

if !(hasInterface) exitWith {};

private _marker_control = [];

if (Rev_marker_global) then {_marker_control pushBackUnique 0};
if (Rev_marker_side) then {_marker_control pushBackUnique 1};
if (Rev_marker_command) then {_marker_control pushBackUnique 2};
if (Rev_marker_group) then {_marker_control pushBackUnique 3};
if (Rev_marker_vehicle) then {_marker_control pushBackUnique 4};

_marker_control;