/*
 * Author: Reeveli 
 * ZEN dynamic dialog showcase function.
 * These dynamic dialogs includes all possible control types and subtypes.
 * This example module will COPY TO CLIPBOARD the return value that you can then refrence.
 * Documentation on each argument/section can be found here: https://zen-mod.github.io/ZEN/#/frameworks/dynamic_dialog?id=creating-a-dialog
 * Function is called from a custom zeus modile defines in Rev_fnc_zeus_init
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Unit <OBJECT>
 *
 * Example:
 * [_this select 0,_this select 1] call Rev_fnc_module_preview_3
 *
 */

params [
	["_position",nil,[[]],[2,3]],
	["_unit", objNull, [objNull]]
];

if (!hasInterface) exitWith {false};

[
	"Toolbox and vector controls",
	[
		["TOOLBOX",["Example toolbox","Select any defined option"],[0,3,3,["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India"]],false],
		["TOOLBOX:WIDE",["Example toolbox wide","Select any defined option"],[0,3,3,["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India"]],false],
		["TOOLBOX:YESNO",["Example toolbox yes/no","Select either option"],[1],true],
		["TOOLBOX:ENABLED",["Example toolbox enable","Select either option"],[0],true],
		["VECTOR",["Example vector","Example tooltip"],[0,1,0],true]
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
