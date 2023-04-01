/*
By Reeveli, based on code by ALIASCartoons
Function to create a traling particle effect origanitng from missile impact.

1.1
	BIS_fnc_selectRandom replaced with selectRandom
*/

params ["_bomb_center","_effect_size"];

private _vel_x = (selectRandom [1,-1])* floor (50+random 50);
private _vel_y = (selectRandom [1,-1])* floor (50+random 50);
private _vel_z = floor (60+random 300);

private _trail = createVehicle ["Land_Battery_F", getPosATL _bomb_center, [], floor (_effect_size/3), "CAN_COLLIDE"];
[_trail] remoteExecCall ["Rev_arty_fnc_warhead_effect_fum",0,true];
_trail setVelocity [_vel_x,_vel_y,_vel_z];

[{deleteVehicle (_this select 0)},[_trail], (1 + random 2)] call CBA_fnc_waitAndExecute;