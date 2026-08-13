/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to facilitate briefing only markers. Run as a postinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_removal
 *
2.0
	Function rewritten with Arma 2.22 update commands
 */

if !(Rev_marker_briefing) exitWith {};
if !(hasInterface) exitWith {};

[
	{
		getClientStateNumber > 9
	},
	{
		{
			private _status = channelEnabled _x;
			_status params ["_chat","_von","_markers","_drawings"];
			_x enableChannel [_chat,_von,false,false];
		} forEach [0,1,2,3,4,5];
		diag_log text "Rev_markers_fnc_removal INFO: All markers disabled post-briefing";
	},
	[],
	-1
] call CBA_fnc_waitUntilAndExecute;