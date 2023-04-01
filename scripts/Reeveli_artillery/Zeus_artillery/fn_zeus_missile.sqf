/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator called tactical missile
 *
 * Arguments:
 * 0: Potision <ARRAY>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_position] call Rev_arty_fnc_zeus_missile
 *
 1.1
	Altitude switched to slider
	Deleted unused _startspeed definition
 */
params ["_position"];

[
	"Reeveli's Missile Strike",
	[
		["COMBO","Missile type",[["ammo_Missile_Cruise_01","ammo_Missile_Cruise_01_Cluster"],[["HE"],["Cluster"]],0],false],
		["TOOLBOX:WIDE","Missile Approach Direction",[0,4,2,["North","North-East","East","South-East","South","South-West","West","North-West"]],false],
		["SLIDER","Flight altitude",[50,1500,200,0],false],
		["TOOLBOX:YESNO","Spawn craters",[false],true],
		["TOOLBOX:YESNO","Show Flight Tracker",[false],false]
	],
	{
		params ["_results","_position"];
		_results params ["_type","_direction", "_altitude","_craters","_tracker"];
		switch _direction do {			
			case 0: {_direction = 0};
			case 1: {_direction = 45};
			case 2: {_direction = 90};
			case 3: {_direction = 135};
			case 4: {_direction = 180};
			case 5: {_direction = 225};
			case 6: {_direction = 270};
			case 7: {_direction = 315};
		};

		if ((_altitude > 1000) OR (_altitude < 0)) then {_altitude = 500};

		private _distance = 4000;

		[_type,_position select 0,_direction, _altitude,_distance,_craters,_tracker] execVM "scripts\Reeveli_artillery\Zeus_artillery\zeus_cruisemissile.sqf";
		[objNull, "Missile Incoming!"] call BIS_fnc_showCuratorFeedbackMessage;

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]

] call zen_dialog_fnc_create;