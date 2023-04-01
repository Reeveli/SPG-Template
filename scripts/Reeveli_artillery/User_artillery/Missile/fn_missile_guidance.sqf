/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, tactical missile ordnance.
 * Looping guidance function for the tactical missile
 *
 * Arguments:
 * 0: Missile <OBJECT>
 * 1: Laser target <OBJECT>
 * 2: Transmitted target position/Last known laser target position <ARRAY>
 * 3: Flight altitude <NUMBER> (default: 500)
 * 4: Flight tracker <BOOLEAN> (default: true)
 * 5: Current missile position <ARRAY>
 * 6: Missile class <STRING> (default: "ammo_Missile_Cruise_01")
 *
 * Return Value: NONE
 *
 * Example:
 * [_missile,_tgt,_pos,_altitude,_testing,_actual_pos,_type] call Rev_arty_fnc_missile_guidance;
 *
 1.2
	Removed _pitchMis as unused variable
	Duplicate _pitchOne definition removed. Is now only defined if in terminal mode

 1.1
	Missile distance is now calculated as distance2D
	Terminal phase is now relative to altitude
	Removed unused private varibale _downSpeed
	Removed unused private varibale _velocity
	Removed unused private varibale _altitudeMissileASL
	Missile will use ASL altitude when over water
	Flymode if conditions merged
	Flight tracker now in uniform CAPS
 */

params [
	["_missile",objNull,[objNull]],
	["_tgt",objNull,[objNull]],
	["_last_pos",nil,[[]],[2,3]],
	["_altitude",500,[0]],
	["_testing",true,[true]],
	["_actual_pos",nil,[[]],[2,3]],
	["_class","ammo_Missile_Cruise_01",[""]]
];

//Collecting all the values for testing/debugging/operating
if (alive _tgt) then {_last_pos = getPosATL _tgt};
if (alive _missile) then {_actual_pos = getPosATL _missile;};
private _flyMode = "TRANSIT";
private _speed = speed _missile;
private _altitudeMissileATL = (getPosATL _missile) select 2;
private _distance = _missile distance2D _last_pos;

private _dir2 = _missile getDir _last_pos;
_missile setDir _dir2;


//While the missile is far away
if (_distance > _altitude) then
{
	private _mode = "ATL";
	if (surfaceIsWater (getpos _missile)) then {_mode = "ASL"};
	
	//Keeping the missile at a costant altitude
	[_missile,_altitude,nil,_mode] call BIS_fnc_setHeight;
} else
{
	_flyMode = "TERMINAL";
	private _pitchOne = -1 * ([_missile,_last_pos] call Rev_arty_fnc_missile_pitch);
	[_missile, _pitchOne , 0] call BIS_fnc_setPitchBank;
};

private _guidance = "LASER";
if !(alive _tgt) then {_guidance = "INERTIAL"};
//In case of testing
if(_testing) then
{hintSilent format ["GUIDANCE: %1\n MODE: %2\n SPEED: %3\n DISTANCE: %4\n ALTITUDE: %5",_guidance,_flyMode,round _speed,round _distance,round _altitudeMissileATL];};


if !(alive _missile) exitWith {[_last_pos,_class,_testing,_actual_pos] call Rev_arty_fnc_missile_impact};

if !(alive _tgt) then {[{call Rev_arty_fnc_missile_guidance;},[_missile,objNull,_last_pos,_altitude,_testing,_actual_pos,_class], 0.005] call CBA_fnc_waitAndExecute;}
else {[{call Rev_arty_fnc_missile_guidance;},[_missile,_tgt,_last_pos,_altitude,_testing,_actual_pos,_class], 0.005] call CBA_fnc_waitAndExecute;};
