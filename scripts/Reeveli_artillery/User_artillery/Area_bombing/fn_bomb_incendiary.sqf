/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, area bombing.
 * Function to handle custom incendiary bombs.
 * Called from Rev_arty_fnc_bomb_ordance
 *
 * Arguments:
 * 0: Bomb object <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * _this # 1 spawn Rev_arty_fnc_bomb_incendiary
 *
 */



params [
	["_bomb",objNull,[objNull]]
];

waitUntil {((getPos _bomb) select 2) < 15};

//Master value for napalm duration
private _duration = 255;

//Create impact object
private _impact = getPosATL _bomb;
private _spot = "Land_HelipadEmpty_F" createVehicle (getPosATL _bomb);
private _flow = (getposasl _spot vectorFromTo getposasl _bomb) vectorMultiply 5;
private _dir_x = 5*(_flow select 0);
private _dir_y = 5*(_flow select 1);

//Delete bomb model
deletevehicle _bomb;

//Effect and SFX scripts
[_spot,_duration,60,10,0.5,true,10] remoteExec ["Rev_arty_fnc_napalm_hit",2,false];
[_spot,_dir_x,_dir_y] remoteExec ["Rev_arty_fnc_napalm_effect",0,true];

//Delete effect
[{deletevehicle (_this select 0)}, [_spot], _duration+(random 120)] call CBA_fnc_waitAndExecute;