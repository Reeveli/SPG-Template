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
		[] call Rev_fnc_postProcessing;		
		[objNull, "Postprocess effect added"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_oldValue
	]
	
] call zen_dialog_fnc_create;