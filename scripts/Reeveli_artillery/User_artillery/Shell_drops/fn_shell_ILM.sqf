/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, shell functions.
 * Client side function to handle shell drops.
 * Called from Rev_arty_fnc_zeus_type_ILM and Rev_arty_fnc_barrage_ILM
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
 * [_pos,_radius,_final] call Rev_arty_fnc_shell_ILM;
 *
 1.2
	Removed unused params (angle,range)
	Consolidated _index and _number for a single new param _final
	Renamed _dispersion to radius for consistency across functions
 1.1
	Replaced BIS_fnc_randomPos with CBA_fnc_randPos
	Removed code accounting for radio
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",10,[0]],
	["_final",false,[false]]
];

if (_final) then {["Shells",false] call Rev_arty_fnc_user_completed};

private _barrage = [_pos, _radius] call CBA_fnc_randPos;
private _sound_pos = [_barrage select 0, _barrage select 1, 100];
private _h = createVehicle ["#particlesource", _sound_pos, [], 0, "CAN_COLLIDE"];
private _whistle = selectRandom ["whistle01","whistle02","whistle03","whistle04","whistle05","whistle06","shell1","shell2","shell3","shell4"];

[_h, [_whistle, 2000, 1]] remoteExec ["say3D"];


//Extra delay to alow sound to play out first
[{
	params ["_barrage","_h"];
	private _shell = "F_40mm_White_Infinite" createVehicle [_barrage select 0,_barrage select 1,260];
	_shell setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
	[_shell, "howitzer", false] remoteExec ["Rev_arty_fnc_flare_effect",0,true];
	[_shell, ["sound_flare", 2000, 1]] remoteExec ["say3D"];
	deleteVehicle _h;

	// Handle constant falling speed
	_shell spawn {
		sleep 1;
		_this setVelocity [0,0,-4];
	};

	[{
		params ["_shell"];
		deleteVehicle _shell;
	}, [_shell], 60] call CBA_fnc_waitAndExecute;



}, [_barrage,_h], 4] call CBA_fnc_waitAndExecute;
