/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to clear all saved marker sets from user profile. Called from the mod menu.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_delete_all
 *
 */

if !(hasInterface) exitwith {};

private ["_var"];
for "_i" from 0 to 99 do 
{
	_var =  format ["spanx_markers_%1",_i];
	profileNamespace setVariable [_var,nil];
};

saveProfileNamespace;
(uiNamespace getVariable ['Rev_marker_confirm', DisplayNull]) closeDisplay 1;
call Rev_markers2_fnc_menu_start;