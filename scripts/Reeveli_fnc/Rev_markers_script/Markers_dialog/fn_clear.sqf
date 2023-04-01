/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to clear map of user placed markers. Called from the mod menu.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_clear
 *
 */

if !(hasInterface) exitWith {};
private ["_a"];
{
	_a = toArray _x;
	_a resize 15;
	if (toString _a == "_USER_DEFINED #") then {					
		deleteMarkerLocal _x;
	}
} forEach allMapMarkers;
call Rev_markers2_fnc_update_menu;
systemChat format ["Cleared local markers"];