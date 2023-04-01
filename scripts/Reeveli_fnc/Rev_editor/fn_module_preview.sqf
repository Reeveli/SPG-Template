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
 * [_this select 0,_this select 1] call Rev_fnc_module_preview
 *
 */

params [
	["_position",nil,[[]],[2,3]],
	["_unit", objNull, [objNull]]
];

if (!hasInterface) exitWith {false};

[
	"Checkbox, color, combo, edit & list controls",
	[
		["CHECKBOX",["Example checkbox","This control will return a boolean"],[true],true],
		["COLOR",["Example color","This control will return a color array"],[0.33,0.66,1,1],true],
		["COMBO",["Example combo box","This control will whatever value is selected"],[[1,2,3],[["Value1","Tooltip 1","\a3\Ui_f\data\GUI\Cfg\Hints\Zeus_ca.paa",[0.2,0.8,1,1]],["Value 2","Tooltip 2"],["Value 3","Tooltip 3"]],0],true],
		["EDIT",["Example edit box","This control has an optional functio being called every keypress"],["Default text",{hintSilent str _this select 0}],true],
		["EDIT:MULTI",["Example multiline edit box","In this example the box size is set to 3 lines"],["Bigger box size for longers texts",{},3],true],
		["EDIT:CODE",["Example multiline edit box with code assist","This control provides scripting autocompletion"],["Try to write some scripting commands",{},3],true],
		["LIST",["Example list box","This control is a variation of the combo box with height argument"],[[1,2,3],[["Value1","Tooltip 1","\a3\Ui_f\data\GUI\Cfg\Hints\Zeus_ca.paa",[0.2,0.8,1,1]],["Value 2","Tooltip 2"],["Value 3","Tooltip 3"]],0,3],true]

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

true;