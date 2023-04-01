/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, shell functions.
 * Client side function to handle shell drops. Called from barrage dialog.
 *
 * Arguments:
 * 0: Target position <ARRAY> (default: [0,0,0])
 * 1: Target range <NUMBER> (default: 0) (not used)
 * 2: Target angle <NUMBER> (default: 0) (not used)
 * 3: Shell dispersion <NUMBER> (default: 10)
 * 4: Round index <NUMBER> (default: 0)
 * 5: Total round number <NUMBER> (default: 1)
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * [_pos,_range,_angle,_dispersion,_index,_number] call Rev_arty_fnc_shell_HE
 *
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_range",0,[0]],
	["_angle",0,[0]],
	["_dispersion",10,[0]],
	["_index",10,[0]],
	["_number",1,[0]]
];


if (_index == (_number - 1)) then 
{
	//Check if user has radio (needed for sideradio command)
	private _condition = {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0};
	private _initial_radio = true;
	if (_condition count assignedItems player == 0) then {
		_initial_radio = false;
		player linkItem "tf_anprc148jem";
		[{params ["_condition","_initial_radio","_killed"];_condition count assignedItems player > 0}, {[_this select 1,"Shells",_this select 2] call Rev_arty_fnc_user_completed}, [_condition,_initial_radio,false],5] call CBA_fnc_waitUntilAndExecute;
	} else {[_initial_radio,"Shells",false] call Rev_arty_fnc_user_completed};
};

private _barrage = [[[_pos, _dispersion]],[]] call BIS_fnc_randomPos;
private _sound_pos = [_barrage select 0, _barrage select 1, 100];
private _h = createVehicle ["Land_HelipadEmpty_F", _sound_pos, [], 0, "CAN_COLLIDE"];
private _whistle = selectRandom ["whistle01","whistle02","whistle03","whistle04","whistle05","whistle06"];

[_h, [_whistle, 1600, 1]] remoteExec ["say3D"];
[_pos] call Rev_arty_fnc_react;


[{
	params ["_barrage"];
	private _b = createVehicle [Rev_arty_HE_type, _barrage, [], 0, "CAN_COLLIDE"];
	_b setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
	_b setVelocity [0,0,-100];

}, [_barrage], 4] call CBA_fnc_waitAndExecute;


[{
	params ["_barrage","_h"];
	if (Rev_arty_HE_crater) then {
		private _c = createVehicle ["Land_ShellCrater_02_large_F", _barrage, [], 0, "CAN_COLLIDE"];
		[_c, false] remoteExec ["enableSimulationGlobal", 2];
	};

	deleteVehicle _h;

}, [_barrage,_h], 4.1] call CBA_fnc_waitAndExecute;

