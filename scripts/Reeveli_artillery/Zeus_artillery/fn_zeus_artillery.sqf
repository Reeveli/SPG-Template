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
2.0
	Dialog controls changed to that outpust are always correct data types, eliminating need for safety checks which are now removed
	Added mortars as reduced lethality option
 */

params ["_position"];

[
	"Reeveli's Artillery Barrage",
	[
		["SLIDER","Ordnance Amount",[1,40,12,0],false],
		["COMBO","Ordance type",[["Sh_155mm_AMOS","Sh_82mm_AMOS","Smoke_120mm_AMOS_White","Flares","Cluster_155mm_AMOS"],["155 mm Howitzer","82 mm Mortar","White smoke","Illumination","Cluster"],0],false],
		["SLIDER:RADIUS",["Radius","Artillery dispersion in meters"],[0,500,150,0,_position,[1,0,0,1]],false],
		["TOOLBOX:YESNO","Spawn craters (Only HE)",[false],false],
		["SLIDER","Delay between rounds (seconds)",[0,300,0,0],false]
	],
	{
		
		params ["_results","_position"];
		_results params ["_number","_type","_radius","_craters","_delay"];

		[objNull, "Barrage Incoming!"] call BIS_fnc_showCuratorFeedbackMessage;
		switch (_type) do {
					
			case "Sh_155mm_AMOS": {[_position select 0, _radius,_number,_delay,_craters,_type] call Rev_arty_fnc_zeus_type_HE};
			case "Sh_82mm_AMOS": {[_position select 0, _radius,_number,_delay,_craters,_type] call Rev_arty_fnc_zeus_type_HE};
			case "Smoke_120mm_AMOS_White": {[_position select 0, _radius,_number,_delay] call Rev_arty_fnc_zeus_type_SMK};
			case "Flares": {[_position select 0, _radius,_number,_delay] call Rev_arty_fnc_zeus_type_ILM};
			case "Cluster_155mm_AMOS": {[_position select 0, _radius,_number,_delay] call Rev_arty_fnc_zeus_type_CLU};

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