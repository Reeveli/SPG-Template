/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, shell functions.
 * Client side function to handle shell drops. Called from barrage dialog.
 *
 * Arguments:
 * 0: Target position <ARRAY> (default: [0,0,0])
 * 1: Shell dispersion <NUMBER> (default: 10)
 * 2: Is it end of fire mission <BOOLEAN> (default: false)
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * [_pos,_range,_angle,_radius,_index,_number] call Rev_arty_fnc_shell_CLU
 *
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",10,[0]],
	["_final",false,[false]]
];

if (_final) then {["Shells",false] call Rev_arty_fnc_user_completed};

private _barrage = [_pos, _radius] call CBA_fnc_randPos;
private _smoke_pos = [_barrage select 0, _barrage select 1, 200];
private _h = createVehicle ["#particlesource", _smoke_pos, [], 0, "CAN_COLLIDE"];
private _whistle = selectRandom ["whistle01","whistle02","whistle03","whistle04","whistle05","whistle06","shell1","shell2","shell3","shell4"];

[_h, [_whistle, 2000, 1]] remoteExec ["say3D"];
[_pos] call Rev_arty_fnc_react;

//Extra delay to alow sound to play out first
[{
	params ["_smoke_pos"];
	private _b = createVehicle ["Cluster_155mm_AMOS", _smoke_pos, [], 0, "CAN_COLLIDE"];
	_b setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
	_b setVelocity [0,0,-100];

}, [_smoke_pos], 4] call CBA_fnc_waitAndExecute;


[{
	params ["_h"];
	deleteVehicle _h;
}, [_h], 9] call CBA_fnc_waitAndExecute;