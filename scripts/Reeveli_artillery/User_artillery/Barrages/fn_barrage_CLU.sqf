/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, barrage functions.
 * Client side function to start the artillery barrage. Called from radio_dialog.
 *
 * Arguments:
 * 0: Target position <ARRAY>
 * 1: Shell dispersion <NUMBER> (default: 10)
 * 3: Amount of rounds fired <NUMBER> (default: 1)
 * 4: Delay between rounds <NUMBER> (default: 0)
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * [_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_CLU;
 *
1.2.2
	Reverted changes to number calcs to correctly NOT apply delay on first round
1.2.1
	Fixed wrong calc never sending correct param for final call
1.2
	Function rewritten for simplified params
1.1
	Ammo regen event moved to type_SMK
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",150,[0]], 
	["_number",3,[0]], 
	["_delay",0,[0]]
];

//Start bombarment
for "_i" from 0 to (_number -1) do {
	[
		{
			params ["_pos","_radius","_index","_number"];
			private _final = false;
			if (_index == (_number - 1)) then {_final = true};	
			[_pos, _radius,_final] call Rev_arty_fnc_shell_CLU;
		},
		[_pos, _radius,_i,_number],
		((_i * _delay) + (random 2))
	] call CBA_fnc_waitAndExecute;
};