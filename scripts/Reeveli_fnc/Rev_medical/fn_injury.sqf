/*
 * Author: Reeveli
 * Client side function to create ZEN dynamic dialog to injure a unit
 *
 * Arguments:
 * 0: Unit being injured <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_objects select 0] call Rev_fnc_injury
 *
 1.1
	Added default param, safety exit
 */

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {
				playSound "FD_Start_F";
				[objNull, "No unit was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
			};

private _injury_types = ["bullet", "grenade", "explosive", "shell", "stab", "vehiclecrash"];
private _blood_pressure	= [100, 70, 40];
private _severity_options = [[0,round (random 2),1,2],[["None"],["Random"],["Moderate"],["Severe"]],0];


[
	"Injure a unit",
	[
		["LIST","Injury type",[_injury_types,[["Bullet"],["Grenade"],["Explosive"],["Shell"],["Stab"],["Vehicle crash"]],0],true],
		["COMBO","Head",_severity_options,true],
		["COMBO","Torso",_severity_options,true],
		["COMBO","Right arm",_severity_options,true],
		["COMBO","Left arm",_severity_options,true],
		["COMBO","Right leg",_severity_options,true],
		["COMBO","Left leg",_severity_options,true],
		["SLIDER:PERCENT","Pain level",[0,1,0],true],
		["COMBO","Blood amount",[[6,5,4],["Normal","Low","Very low"],0],true],
		["TOOLBOX:YESNO","Force unconscious",[false],true]	
	],
	{
		params ["_results","_passed_arguments"];
		[objNull, "Injury inflicted"] call BIS_fnc_showCuratorFeedbackMessage;

		private _injury_type = (_results select 0);
		_injury_value_list = [];
		for "_i" from 1 to 6 do
		{
			private _value = _results select _i;
			_injury_value_list pushBack _value;
		};
		private _pain = 100 * (_results select 7);
		_injury_value_list pushBack _pain;
		private _blood_pressure = _results select 8;
		_injury_value_list pushBack _blood_pressure;
		private _unconscious = _results select 9;
		_injury_value_list pushBack _unconscious;

		private _unit = _passed_arguments select 0;
		[_unit,_injury_type,_injury_value_list] remoteExec ["Rev_fnc_set_ACE_injury",_unit];

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_unit
	]
	
] call zen_dialog_fnc_create;