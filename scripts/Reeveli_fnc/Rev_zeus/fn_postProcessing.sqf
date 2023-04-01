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
 */

if (!hasInterface) exitWith {false};
private _oldValue = KLT_enviro;


[
	"Select post processing effect",
	[
		[
			"TOOLBOX:WIDE",
			["Example toolbox wide","Select any defined option"],
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
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_oldValue
	]
	
] call zen_dialog_fnc_create;

/*
private _display = uiNamespace getVariable ["zen_common_display",displayNull];
private _controlGroup = _display displayCtrl 30;
private _toolbox = _controlGroup controlsGroupCtrl 1006;

Code for the toolbox left as legacy archive in case future need (I was unable to attach EHs to the toolbox for intanteneous postprocessing effects)
*/