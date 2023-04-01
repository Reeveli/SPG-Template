/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator called artillery strikes
 *
 * Arguments:
 * 0: Potision <ARRAY>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_position] call Rev_arty_fnc_zeus_artillery
 *
 1.1
	Added custom id to have used results be saved
 */

params ["_position"];

[
	"Reeveli's Artillery Barrage",
	[
		["EDIT","Ordnance Amount",["3"],false],
		["SLIDER:RADIUS",["Radius","Artillery dispersion in meters"],[0,500,150,0,_position,[1,0,0,1]],false],
		["EDIT","Delay between rounds (seconds)",["0"],false],
		["TOOLBOX:YESNO","Spawn craters (Only HE)",[1],false],
		["COMBO","Ordance type",[[0,1,2,3],["High explosive","White smoke","Illumination","Cluster"],0],false]
	],
	{
		
		params ["_results","_position"];
		private _rounds_selected = _results select 0;
		private _radius = _results select 1;
		private _delay = _results select 2;
		private _craters = _results select 3;
		private _type = _results select 4;

		private _number = parseNumber _rounds_selected;
		_delay = parseNumber _delay;
		if (_delay < 0) then {_delay = 0};

		if (_number == 0) exitWith {playSound "FD_Start_F";[objNull, "No rounds selected!"] call BIS_fnc_showCuratorFeedbackMessage;};
		if (_number > 20) exitWith {playSound "FD_Start_F";[objNull, "Safety limit exceeded!"] call BIS_fnc_showCuratorFeedbackMessage;};
		if (_radius == 0) exitWith {playSound "FD_Start_F";[objNull, "No radius selected!"] call BIS_fnc_showCuratorFeedbackMessage;};
		round _number;
		round _radius;

		[objNull, "Barrage Incoming!"] call BIS_fnc_showCuratorFeedbackMessage;
		switch _type do {
					
			case 0: {[_position select 0, _radius,_craters,_number,_delay] spawn Rev_arty_fnc_zeus_type_HE};
			case 1: {[_position select 0, _radius,_number,_delay] spawn Rev_arty_fnc_zeus_type_SMK};
			case 2: {[_position select 0, _radius,_number,_delay] spawn Rev_arty_fnc_zeus_type_ILM};
			case 3: {[_position select 0, _radius,_number,_delay] spawn Rev_arty_fnc_zeus_type_CLU};

		};		
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	],
	"Rev_zeus_Artillery_id"
] call zen_dialog_fnc_create;