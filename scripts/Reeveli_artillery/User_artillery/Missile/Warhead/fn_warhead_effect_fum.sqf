/*
 * Author: ALIASCartoons, header by Reeveli
 * Function to create particle effect originating from missile impact
 *
 * Arguments:
 * 0: Center object <OBJECT>

 * Return Value: None
 *
 * Example:
 * [_bomb_center] call Rev_arty_fnc_warhead_effect_fum;
 *
 1.1
	BIS_fnc_selectRandom replaced with selectRandom
 */

if (!hasInterface) exitWith {};

params ["_source"];

private _effect_size = floor (5 + random 5);
private _color = selectRandom [0,0.1,0.15,0.2];

private _fum_rest = "#particlesource" createVehicleLocal getPosATL _source;
_fum_rest setParticleCircle [0, [0, 0, 0]];
_fum_rest setParticleRandom [1,[0.2,0.2,0.5],[0.175, 0.175, 0],0, 0.25,[0, 0, 0, 0.1],0, 0];
_fum_rest setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7,48,1], "", "Billboard", 1,5,[0,0,0],[0,0,5],30, 85, 7.9, 1, [_effect_size, 100], [[0, 0, 0, 1], [_color, _color, _color, 0.4],[_color, _color, _color, 0]], [0.08], 1, 0, "", "", _source];
_fum_rest setDropInterval 0.01;