/*
 * Author: Reeveli
 * Create a new map location. Must be run globally.
 * One trick is to use this from the editor via logic object.
 *
 * Common name types:
	"NameCity"
	"NameCityCapital"
	"NameLocal"
	"NameMarine"
	"NameVillage"

	Full list: https://community.bistudio.com/wiki/Location#Arma_3
 *	
 * Arguments:
 * 0: Type <STRNG> (default: "NameVillage")
 * 1: Position <ARRAY>
 * 2: Location name <STRING> (default: "")
 *
 * Return Value: Created location <LOCATION>
 *
 * Example:
 * ["NameCity",_pos,"My New City"] call Rev_fnc_locationNew;
 *
 1.1
	Added rpt printout
 */


params
[
	["_type","NameVillage",[""]],
	["_pos",nil,[[]],[2,3]],
	["_name","",[""]]
];


private _location = createLocation [_type, _pos, 30, 30];
_location setText _name;

diag_log format ["Rev_fnc_locationNew: %1", _name];

_location;