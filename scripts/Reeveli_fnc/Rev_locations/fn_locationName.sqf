/*
 * Author: Reeveli
 * Return the textual name of the closest location (most relevant types searched). Function made to be used in conjuction with Rev_fnc_locationRemove.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value: Closest location name <STRING>
 *
 * Example:
 * [getpos player] call Rev_fnc_locationName;
 *
 */


params
[
	["_pos",nil,[[]],[2,3]]
];

private _location = (nearestLocation [_pos, ["NameCity","NameCityCapital","NameLocal","NameMarine","NameVillage"]]);
private _text = text _location;

_text;