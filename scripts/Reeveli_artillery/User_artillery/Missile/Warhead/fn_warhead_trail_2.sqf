/*
By Reeveli, based on code by ALIASCartoons
Function to create a traling particle effect origanitng from missile impact

1.1
	BIS_fnc_selectRandom replaced with selectRandom
*/

params ["_bomb_center","_effect_size"];

private _vel_x = (selectRandom [1,-1])* floor (10+random 30);
private _vel_y = (selectRandom [1,-1])* floor (10+random 30);
private _vel_z = 10+random 50;

private _trail = createVehicle ["Land_Battery_F", getPosATL _bomb_center, [], floor (_effect_size/3), "CAN_COLLIDE"];
[_trail] remoteExecCall ["Rev_arty_fnc_warhead_effect_buc",0,true];
_trail setVelocity [_vel_x,_vel_y,_vel_z];

[{deleteVehicle (_this select 0)},[_trail], (5 + random 10)] call CBA_fnc_waitAndExecute;