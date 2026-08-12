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
 * [_finalPos,_radius,_number,_delay] spawn Rev_arty_fnc_barrage_ILM;
 *
1.2.2
	Reverted changes to number calcs to correctly NOT apply delay on first round
1.2.1
	Fixed wrong calc never sending correct param for final call
1.2
	Removed unused params (angle,range)
	Renamed _dispersion to radius for consistency across functions
1.1
	Ammo regen event moved to type_ILM
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",10,[0]],
	["_number",1,[0]],
	["_delay",0,[0]]
];


//Start bombarment
for "_i" from 0 to (_number -1) do {
	[
		{
			params ["_pos","_radius","_index","_number"];
			private _final = false;
			if (_index == (_number -1)) then {_final = true};
			[_pos,_radius,_final] call Rev_arty_fnc_shell_ILM;
		},
		[_pos,_radius,_i,_number],
		_i * _delay
	] call CBA_fnc_waitAndExecute;
};