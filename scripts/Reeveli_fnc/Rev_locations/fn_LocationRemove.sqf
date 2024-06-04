/*
 * Author: Reeveli
 * Remove closest location (all types searched). Must be run globally on all clients.
 * One trick is to use this from the editor via logic object.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value: BOOLEAN
 *
 * Example:
 * [_pos] call Rev_fnc_locationRemove;
 *
 1.2
	Search radius increased to 150m
	Fixed wrong header info
 1.1
	Function re-written to match mod version 1.1
 */

params
[
	["_pos",nil,[[]],[2,3]]
];

private _location = nearestLocation [_pos,"",150];

if (isNull _location) exitWith {
	diag_log "Rev_fnc_locationRemove: No location found";
	false;
};

diag_log format ["Rev_fnc_locationRemove: %1", _location];
							
private _invisible = createLocation [_location];		
_invisible setType "Invisible";	

true;