/*
 * Author: Reeveli 
 * Client side function to start dynamic ZEN dialog to for aperture control.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_fnc_aperture_dialog
 *
 */

if (!hasInterface) exitWith {false};

private _current = apertureParams select 0;
missionNamespace setVariable ["Rev_zeus_aperture",_current];


[
	"Set aperture",
	[
		["CHECKBOX","Restore default",[false],true],
		["SLIDER","Set aperture",[0,100,_current,2],true]
	],
	{
		params ["_results","_passed_arguments"];
		[objNull, "Aperture changed"] call BIS_fnc_showCuratorFeedbackMessage;
		if (_results#0) exitWith {["Rev_aperture",-1] call CBA_fnc_globalEventJIP;};
		private _new = _results # 1;
		["Rev_aperture",_new] call CBA_fnc_globalEventJIP;
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
		private _old = missionNamespace getVariable ["Rev_zeus_aperture",-1];
		["Rev_aperture",_old] call CBA_fnc_localEvent;		
	},
	[
		_current
	]
	
] call zen_dialog_fnc_create;



//EHs for instantaneous preview
private _display = uiNamespace getVariable "zen_common_display";
private _controlGroup = _display displayCtrl 30;
private _checkBox = _controlGroup controlsGroupCtrl 1002;
private _slider = _controlGroup controlsGroupCtrl 1005;

_checkBox ctrlAddEventHandler ["CheckedChanged", {
    params ["_control", "_checked"];
	private _display = uiNamespace getVariable "zen_common_display";
	private _controlGroup = _display displayCtrl 30;
	private _edit = _controlGroup controlsGroupCtrl 1004;
	private _slider = _controlGroup controlsGroupCtrl 1005;

	if (_checked isEqualTo 1) then {
		["Rev_aperture",-1] call CBA_fnc_localEvent;
		_slider sliderSetPosition 0;
		ctrlSetText [1004, "-1"];
	};
}];

_slider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_control", "_newValue"];
	["Rev_aperture",_newValue] call CBA_fnc_localEvent;
	private _display = uiNamespace getVariable "zen_common_display";
	private _controlGroup = _display displayCtrl 30;
	private _checkBox = _controlGroup controlsGroupCtrl 1002;
	_checkBox cbSetChecked false;
}];