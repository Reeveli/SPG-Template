/*
 * Author: Reeveli, based on code by ALIASCartoons
 * Part of Reeveli's Artillery system, alternative missile warhead.
 * Server side function to start the alternative warhead..
 *
 * Arguments:
 * 0: Last position of missile <ARRAY>
 * 1: Are custom craters enabled <BOOL> (default: false)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [[_last_pos,_craters],"scripts\Reeveli_artillery\AL_bomb\alias_bomb_ini.sqf"] remoteExec ["execVM", 2];
 *
1.3
	Added Proper header
	Added default params
	Added additional safety check
1.2
	Total overhaul, script turned into uncheduled function
	Included inline functions separated to external files
1.1
	Cleaned varibale names
	Added params
	General optimisation
 */

params [
	["_last_pos",nil,[[]],[2,3]],
	["_craters",false,[true]]
];

if (!isServer) exitWith {};

private _effect_size = 50;
private _bomb_center = "Land_HelipadEmpty_F" createVehicle [_last_pos select 0,_last_pos select 1,0];


private _veget = nearestTerrainObjects [getPosATL _bomb_center, ["TREE","SMALL TREE","BUSH"],1.5*_effect_size];
private _build = nearestObjects [getPosATL _bomb_center,["building"],1.5*_effect_size];
private _misc = nearestObjects [getPosATL _bomb_center,["man","car","tank","plane","helicopter"],1.5*_effect_size];

//Velocity and damage
{
	if !(_x isKindOf "Land_HelipadEmpty_F") then {
		[{params ["_object"];_object setVelocity [0,0,(30 + (random 30))]; _object setdamage 1}, [_x], (_forEachIndex * 0.01)] call CBA_fnc_waitAndExecute;
	};	
} foreach _misc;

{
	if !(_x isKindOf "Land_HelipadEmpty_F") then {		
		[{params ["_object"]; _object setVelocity [0,0,(30 + (random 30))]; _object setDamage [1,false]}, [_x], (_forEachIndex * 0.01)] call CBA_fnc_waitAndExecute;
		}
} foreach _build;	


{
	[{params ["_object"];_object setdamage 1}, [_x], (_forEachIndex * 0.01)] call CBA_fnc_waitAndExecute;
} foreach _veget;

//GFX
[[_bomb_center, _effect_size],"scripts\Reeveli_artillery\Missile\Warhead\alias_bomb_effect.sqf"] remoteExec ["execVM"];

//Traling particle effects
for "_i" from 0 to floor (3+random 4) do {
	[{params ["_bomb_center"];[_bomb_center,50] call Rev_arty_fnc_warhead_trail;}, [_bomb_center], (_i * 0.01)] call CBA_fnc_waitAndExecute;
};

//Additional 0.3 delay to all calls
//Traling particle effects 2
for "_i" from 0 to floor (3+random 10) do {
	[{params ["_bomb_center"];[_bomb_center,50] call Rev_arty_fnc_warhead_trail_2;}, [_bomb_center], ((_i * 0.01) + 0.3)] call CBA_fnc_waitAndExecute;
};

[_bomb_center,_effect_size,0.01] remoteExecCall ["Rev_arty_fnc_warhead_fire",0,true];

//Additinal 15s delay to all calls
if (_craters) then {
	[{params ["_bomb_center"];[_bomb_center] call Rev_arty_fnc_warhead_crater;}, [_bomb_center], 15.3] call CBA_fnc_waitAndExecute;
};

//Additinal 30s delay to all calls
[{params ["_bomb_center"]; deleteVehicle _bomb_center}, [_bomb_center], 75.3] call CBA_fnc_waitAndExecute;