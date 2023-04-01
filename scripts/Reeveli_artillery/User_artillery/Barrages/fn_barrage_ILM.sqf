/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, barrage functions.
 * Client side function to start the artillery barrage. Called from radio_dialog.
 *
 * Arguments:
 * 0: Target angle <NUMBER> (default: 0) (not used)
 * 1: Target range <NUMBER> (default: 0) (not used)
 * 2: Target position <ARRAY>
 * 3: Amount of rounds fired <NUMBER> (default: 1)
 * 4: Delay between rounds <NUMBER> (default: 0)
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * [_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_ILM;
 *
1.1
	Ammo regen event moved to type_ILM
 */

params [
	["_angle",0,[0]],
	["_range",0,[0]],
	["_pos",[0,0,0],[[]],[2,3]],
	["_number",1,[0]],
	["_delay",0,[0]]
];


private _dispersion = _number * 10;
//Start bombarment
for "_i" from 0 to (_number - 1) do {
	[{params ["_pos", "_range","_angle","_dispersion","_index","_number"];[_pos, _range,_angle,_dispersion,_index,_number] call Rev_arty_fnc_shell_ILM;}, [_pos, _range,_angle,_dispersion,_i,_number], _i * _delay] call CBA_fnc_waitAndExecute;
};