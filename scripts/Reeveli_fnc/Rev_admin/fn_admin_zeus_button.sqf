/*
 * Author: Reeveli
 * Part of SPG admin console, runs when admin console zeus button is pressed. Runs zeus promotion on server and closes the display.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call Rev_fnc_admin_zeus_button
 *
 */

if !(hasInterface) exitwith {};

private _isAdmin = serverCommandAvailable "#kick";

if (isNull (getAssignedCuratorLogic player)) then {
	//disable existing curators first in case of crashes etc
	["Rev_admin_toggle_zeus", [player, false,_isAdmin]] call CBA_fnc_serverEvent;	
	[{
		params ["_unit","_promotion","_isAdmin"];
		["Rev_admin_toggle_zeus", [_unit, _promotion,_isAdmin]] call CBA_fnc_serverEvent;
	}, [player,true,_isAdmin], 1] call CBA_fnc_waitAndExecute;;
} else {
	["Rev_admin_toggle_zeus", [player, false,_isAdmin]] call CBA_fnc_serverEvent;
};

(findDisplay 49) closeDisplay 1;