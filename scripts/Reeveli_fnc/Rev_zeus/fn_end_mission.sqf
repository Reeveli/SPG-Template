/*
 * Author: Reeveli
 * Client side function to start dynamic ZEn dialog to end mission. Mission endings are pulled from mission config.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_fnc_end_mission
 *
 */

private _config_list = [];
private _name_list = [];


private _count = (count ("true" configClasses (missionconfigfile >> "CfgDebriefing"))) - 1;


for "_i" from 0 to _count do {
	private _name = configName ((missionconfigfile >> "CfgDebriefing") select _i);
	_config_list pushBack _name;
	private _title = getText (missionconfigfile >> "CfgDebriefing" >> _name >> "title");
	_name_list pushBack _title;
};


[
	"End scenario",
	[
		//["TOOLBOX","Select ending",_config_list,false],
		["COMBO","Select ending",[_config_list,_name_list,0],true],
		["CHECKBOX",["Is victory","If checked counts as a victory"],[true],true]
	],
	{
		params ["_results","_passed_arguments"];		
		private _ending = _results select 0;
		private _type = _results select 1;
		private _players = [] call CBA_fnc_players;
		[_ending, _type] remoteExec ["BIS_fnc_endMission",_players];
		[objNull, "Scenario ended"] call BIS_fnc_showCuratorFeedbackMessage;

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_config_list
	]
] call zen_dialog_fnc_create;