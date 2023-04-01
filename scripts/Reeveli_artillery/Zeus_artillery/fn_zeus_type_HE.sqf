/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, Zeus artillery.
 * Client side function to handle HE artillery. Called from the Zeus ZEN dialog.
 *
 * Arguments:
 * 0: Target position <ARRAY>
 * 1: Barrage dispersion <NUMBER> (default: 150)
 * 2: Craters <NUMBER> (default: 1 true, 0 false)
 * 3: Amount of rounds <NUMBER> (default: 3)
 * 4: Delay between rounds <NUMBER> (default: 0)
 *
 * Return Value: BOOL
 *
 * Example:
 * [_position select 0, _radius,_craters,_number,_delay] spawn Rev_arty_fnc_zeus_type_HE
 *
 1.1
	Added header, default params
	Added safety exit
	Added return boolean on completion
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",150,[0]],  
	["_craters",1,[0]], 
	["_number",3,[0]], 
	["_delay",0,[0]]
];

//Start bombarment
for "_i" from 0 to (_number - 1) do {
	[{
		params ["_pos", "_radius","_craters","_i"];
		private _barrage = [[[_pos, _radius]],[]] call BIS_fnc_randomPos;
		private _sound_pos = [_barrage select 0, _barrage select 1, 100];
		private _h = createVehicle ["Land_HelipadEmpty_F", _sound_pos, [], 0, "CAN_COLLIDE"];
		private _whistle = selectRandom ["whistle01","whistle02","whistle03","whistle04","whistle05","whistle06"];
		[_h, [_whistle, 1600, 1]] remoteExec ["say3D"];
		[_pos] call Rev_arty_fnc_react;

		[{
			params ["_i","_barrage","_craters","_h"];
			private _type = "";
			if (_i % 3 == 0) then {_type = "Sh_155mm_AMOS"} else {_type = "Bo_GBU12_LGB"};
			private _b = createVehicle [_type, _barrage, [], 0, "CAN_COLLIDE"];
			_b setVectorDirandUp [[0,0,-1],[0.1,0.1,1]]; _b setVelocity [0,0,-500];
			[_b,true] remoteExecCall ["hideObjectGlobal",2];

			[{isNull (_this select 0)}, {
				params ["_b","_barrage","_craters","_h"];
				if (_craters == 1) then {
					private _c = createVehicle ["Land_ShellCrater_02_large_F", [_barrage select 0, _barrage select 1, 0], [], 0, "CAN_COLLIDE"];
					[_c, false] remoteExec ["enableSimulationGlobal", 2];
					};
				deleteVehicle _h;
			}, [_b,_barrage,_craters,_h]] call CBA_fnc_waitUntilAndExecute;

		}, [_i,_barrage,_craters,_h],3] call CBA_fnc_waitAndExecute;
	
	}, [_pos, _radius,_craters,_i], ((_i * _delay) + (random 2))] call CBA_fnc_waitAndExecute;
};

true;