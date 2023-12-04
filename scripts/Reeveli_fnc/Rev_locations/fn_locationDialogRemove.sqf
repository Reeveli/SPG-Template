/*
 * Author: Reeveli 
 * Client side function to start dynamic ZEN dialog for map location removal.
 * Called from Rev_fnc_zeus_init
 *
 * Arguments:
 * 0: Selected position <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 0] call Rev_fnc_locationDialogRemove
 *
 */


if (!hasInterface) exitWith {false};

params [
	["_position",nil,[[]],[2,3]]
];


private _name = [_position] call Rev_fnc_locationName;
private _string = "Remove: " + _name;

[
	"Remove map location",
	[
		["CHECKBOX",[_string,"If checked this location will be removed from the map"],[true],true]
	],
	{
		params ["_results","_passed_arguments"];

		_results params [
			["_remove", false, [true]]
		];
		private _position = _passed_arguments select 0;

		if !(_remove) exitWith {};
		[_position] remoteExec ["Rev_fnc_locationRemove",0,true];		
		[objNull, "Location removed"] call BIS_fnc_showCuratorFeedbackMessage;

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;