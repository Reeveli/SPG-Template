/*
 * Author: Reeveli
 * Return the textual name of the closest location. Function made to be used in conjuction with Rev_fnc_locationRemove.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value: <ARRAY>
 * 0: Was a location found in radius <BOOLEAN>
 * 1: Name of location <STRING>
 *
 * Example:
 * [getpos player] call Rev_fnc_locationName;
 *
 1.1
	Updated header
	Added isNull check
	Return value changed to array
 */


params
[
	["_pos",nil,[[]],[2,3]]
];

private _location = (nearestLocation [_pos,"",75]);

if (isNull _location) exitWith {
	diag_log "Rev_locations_fnc_name: No location found";
	[false,"NULL"];
};

private _text = text _location;
[true,_text];