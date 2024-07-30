 /*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Client side function to create ZEN dynamic dialog for placing teleportation points.
 * Called as from Rev_fnc_tp_addZen_modules
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_object] call Rev_fnc_tp_ZEN_dialog
 *
 1.0.1
	Fixed typo
 */

params [
	["_object", objNull, [objNull]]
];

if (!hasInterface) exitWith {false};

if (isNull _object) exitWith {
	playSound "FD_Start_F";
	[objNull, "No object was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
};


if (([_object] call Rev_fnc_tp_listCheck) > -1) exitWith {
	playSound "FD_Start_F";
	[objNull, "Object is already teleportation point"] call BIS_fnc_showCuratorFeedbackMessage;
};

[
	"Add teleportation point to object",
	[
		["EDIT",["Display name","What is the display name of this teleport point"],["Teleportation point"],true],
		["SIDES",["Side selection","Select which side can use this teleport point"],[west],true]
	],
	{
		params ["_results","_passed_arguments"];
		_results params ["_name","_side"];
		_passed_arguments params ["_object"];

		_side = _side # 0;
		[_object,_name,_side] remoteExec ["Rev_fnc_tp_addPoint",2];
		[objNull, "Teleport point created"] call BIS_fnc_showCuratorFeedbackMessage;

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_object
	]
] call zen_dialog_fnc_create;
