/*
 * Author: Reeveli 
 * ZEN dynamic dialog showcase function.
 * These dynamic dialog functions includes all possible control types and subtypes.
 * This example module will COPY TO CLIPBOARD the return value that you can then refrence.
 * Documentation on each argument/section can be found here: https://zen-mod.github.io/ZEN/#/frameworks/dynamic_dialog?id=creating-a-dialog
 * Function is called from a custom zeus module defined in Rev_fnc_zeus_init
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Unit <OBJECT>
 *
 * Example:
 * [_this select 0,_this select 1] call Rev_fnc_module_preview2
 *
 1.0.1
 	Fixed some typos
	Fixed wrong function in header example
	Fixed wrong tooltip on SLIDER:RADIUS
 */

params [
	["_position",nil,[[]],[2,3]],
	["_unit", objNull, [objNull]]
];

if (!hasInterface) exitWith {false};


[
	"Owner,side & slider controls",
	[
		["OWNERS",["Example Owners control","Select sides, groups with players, or players"],[[WEST,EAST],allGroups,allPlayers,0],true],
		["OWNERS:NOTITLE","This argument is ignored",[[WEST,EAST],allGroups,allPlayers,0],true], //Subvariant of OWNERS without title bar at top
		["SIDES",["Side selection","Select example side"],[EAST],true],
		["SLIDER",["Example slider","Select value between the defined min and max"],[0,6,3,2],false],
		["SLIDER:PERCENT",["Example percent slider","Select value between the defined min and max"],[0,1,0.5],false],
		["SLIDER:RADIUS",["Example radius slider","See the radius indicators in the 3D world when using this slider"],[0,400,200,0,_position,[1,0,0,1]],false]
	],
	{
		params ["_results","_passed_arguments"];
		[objNull, "Return copied to clipboard!"] call BIS_fnc_showCuratorFeedbackMessage;
		copyToClipboard str _results;
		systemChat str _passed_arguments;
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position,
		_unit
	]
] call zen_dialog_fnc_create;
