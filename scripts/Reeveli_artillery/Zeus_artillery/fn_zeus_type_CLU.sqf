/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, Zeus artillery.
 * Client side function to handle cluster artillery. Called from the Zeus ZEN dialog.
 *
 * Arguments:
 * 0: Target position <ARRAY>
 * 1: Barrage dispersion <NUMBER> (default: 150)
 * 2: Amount of rounds <NUMBER> (default: 3)
 * 3: Delay between rounds <NUMBER> (default: 0)
 *
 * Return Value: BOOL
 *
 * Example:
 * [_position select 0, _radius,_number,_delay] spawn Rev_arty_fnc_zeus_type_CLU
 *
 1.1
	Added header, default params
	Added safety exit
	Added return boolean on completion
	Cleaned dead code
 */

params [
	["_pos",[0,0,0],[[]],[2,3]], 
	["_radius",150,[0]], 
	["_number",3,[0]], 
	["_delay",0,[0]]
];

//Start bombarment
for "_i" from 0 to (_number - 1) do {
	[{
		params ["_pos", "_radius","_i"];
		private _barrage = [[[_pos, _radius]],[]] call BIS_fnc_randomPos;
		private _sound_pos = [_barrage select 0, _barrage select 1, 200];
		private _h = createVehicle ["Land_HelipadEmpty_F", _sound_pos, [], 0, "CAN_COLLIDE"];
		private _whistle = selectRandom ["whistle01","whistle02","whistle03","whistle04","whistle05","whistle06"];
		[_h, [_whistle, 1600, 1]] remoteExec ["say3D"];
		[_pos] call Rev_arty_fnc_react;

		[{
			params ["_i","_barrage","_h"];
			private _shell = "Cluster_155mm_AMOS" createVehicle [_barrage select 0,_barrage select 1,200];
			_shell setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; _shell setVelocity [0,0,-100];
			deleteVehicle _h;
		}, [_i,_barrage,_h],3] call CBA_fnc_waitAndExecute;
	
	}, [_pos, _radius,_i], ((_i * _delay) + (random 2))] call CBA_fnc_waitAndExecute;
};

true;