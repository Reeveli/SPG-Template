/*
 * Author: Reeveli 
 * Client side function to start dynamic ZEN dialog to for curator blackout function.
 *
 * Arguments:
 * 0: Selected position <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 0] call Rev_fnc_blackout_dialog
 *
 1.1
	Toolbox default value changed to boolean
	Toolbox renamed
 */

params [
	["_position",nil,[[]],[2,3]]
];

if (count _position < 2) exitWith {};

[
	"Enable/disable power",
	[
		["TOOLBOX:ENABLED",["Power state",""],[false],false],
		["SLIDER:RADIUS",["Radius","Effect radius in meters"],[0,3000,500,0,_position,[1,0,0,1]],false]


	],
	{
		params ["_results","_passed_arguments"];
		private _state = _results select 0;
		private _radius = _results select 1;

		[_state,_radius,_passed_arguments select 0] remoteExec ["Rev_fnc_blackout",0,true];
		[objNull, "Power state altered"] call BIS_fnc_showCuratorFeedbackMessage;

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;