/*
 * Author: Reeveli
 * Client side function to create curator dialog for choosing post processing effects.
 * Called from a curator module
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [] call Rev_fnc_postProcessing;
 *
 1.2.1
	Fixed wrong control title and tooltip
 1.2
	Added EH for instantaneous preview
	Dialog is now closed and not reopened on exit, as the new preview makes this unnecessary
 1.1
	Added feeedback message on closure
	Dialog is now reopened on use
 */

if (!hasInterface) exitWith {false};
private _oldValue = KLT_enviro;


[
	"Select post processing effect",
	[
		[
			"TOOLBOX:WIDE",
			"Select any option",
			[
				_oldValue,
				4,
				4,
				["Disabled","Realistic color correction","Post apocalyptic","Nightstalkers","OFP gamma","Golden autumn","Africa","Afghanistan","Middle East","Real is brown","Gray tone","Cold tone","Winter blue","Winter white","Mediterranean Theme"]
			],
			false]
	],
	{
		params ["_results","_passed_arguments"];
		[_results # 0] remoteExecCall ["KLT_fnc_enviro",0,true];
		KLT_enviro = _results # 0;
		publicVariable "KLT_enviro";	
		[objNull, "Postprocess effect added"] call BIS_fnc_showCuratorFeedbackMessage;
		closeDialog 1;
	},
	{
		[KLT_enviro] call KLT_fnc_enviro;
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_oldValue
	]
	
] call zen_dialog_fnc_create;

//EH for instantaneous preview
private _display = uiNamespace getVariable "zen_common_display";
private _controlGroup = _display displayCtrl 30;
private _toolBox = _controlGroup controlsGroupCtrl 1006;
_toolBox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_control", "_selectedIndex"];
	[_selectedIndex] call KLT_fnc_enviro;
}];