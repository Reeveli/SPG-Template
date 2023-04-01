/*
 * Author: Reeveli
 * Part of SPG admin console, adds serverside eventhandler for tracking FPS and zeus promotion
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call Rev_fnc_admin_init
 *
1.1
	fpr variable is no longer public to save network traffic
 */

if !(isServer) exitWith {};

//EH for server side FPS
[
	{
		Rev_admin_server_fps = round(diag_fps);	
	},
	5
] call CBA_fnc_addPerFrameHandler;

//EH for zeus promotion
["Rev_admin_toggle_zeus", {_this call Rev_fnc_admin_zeus}] call CBA_fnc_addEventHandler;
