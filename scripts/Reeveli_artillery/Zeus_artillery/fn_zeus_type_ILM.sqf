/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, Zeus artillery.
 * Client side function to handle illumination artillery. Called from the Zeus ZEN dialog.
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
 * [_position select 0, _radius,_number,_delay] spawn Rev_arty_fnc_zeus_type_ILM
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
		params ["_pos", "_range","_angle","_dispersion"];[_pos, _range,_angle,_dispersion] call Rev_arty_fnc_shell_ILM;}, [_pos,0,0,_radius], _i * _delay] call CBA_fnc_waitAndExecute;
};

true;