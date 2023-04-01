/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to get saved markers sets from profile.
 * Arguments: NONE
 *
 * Return Value:
 * Saved marker sets <ARRAY>
 *
 * Example:
 * call Rev_markers2_fnc_get_saved
 *
 */

if !(hasInterface) exitwith {};
private _sets = [];

private ["_var","_saved"];
for "_i" from 0 to 99 do 
{
	_var =  format ["spanx_markers_%1",_i];
	_saved = profileNamespace getVariable [_var,nil];
	if !(isNil {_saved}) then {_sets pushBackUnique _var};

};

_sets;