/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, shell functions.
 * Client side function to handle shell drops.
 * Called from Rev_arty_fnc_zeus_type_HE and Rev_arty_fnc_barrage_HE
 *
 * Arguments:
 * 0: Target position <ARRAY> (default: [0,0,0])
 * 1: Shell dispersion <NUMBER> (default: 10)
 * 2: Is it end of fire mission <BOOLEAN> (default: false)
 * 3: Shell craters <BOOLEAN> (default: false)
 * 4: Ammo type used <STRING> (default: "Sh_155mm_AMOS")
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * [_pos,_radius,false,_craters,"Sh_155mm_AMOS"] call Rev_arty_fnc_shell_HE
 *
 1.2
	Code rewritten for simplified params and unified use by Zeus and user arty
	
 1.1
	Replaced BIS_fnc_randomPos with CBA_fnc_randPos
	Removed code accounting for radio
	Added base game sounds to whistle pool
	Increased whistle sound range by 400
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",10,[0]],
	["_final",false,[false]],
	["_craters",false,[false]],
	["_ammoType","Sh_155mm_AMOS",[""]]
];


if (_final) then {["Shells",false] call Rev_arty_fnc_user_completed};

private _barrage = [_pos, _radius] call CBA_fnc_randPos;
private _sound_pos = [_barrage select 0, _barrage select 1, 100];
private _h = createVehicle ["#particlesource", _sound_pos, [], 0, "CAN_COLLIDE"];
private _whistle = selectRandom ["whistle01","whistle02","whistle03","whistle04","whistle05","whistle06","shell1","shell2","shell3","shell4"];

[_h, [_whistle, 2000, 1]] remoteExec ["say3D"];
[_pos] call Rev_arty_fnc_react;

//Extra delay to alow sound to play out first
[{
	params ["_barrage","_h","_ammo"];
	private _b = createVehicle [_ammo, _barrage, [], 0, "CAN_COLLIDE"];
	_b setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
	_b setVelocity [0,0,-100];
	deleteVehicle _h;

}, [_barrage,_h,_ammoType], 4] call CBA_fnc_waitAndExecute;

//Crater creation
if !(_craters) exitWith {};
[{
	params ["_barrage"];
		private _c = createVehicle ["Land_ShellCrater_02_large_F", _barrage, [], 0, "CAN_COLLIDE"];
		[_c, false] remoteExec ["enableSimulationGlobal", 2];
}, [_barrage], 4.1] call CBA_fnc_waitAndExecute;

