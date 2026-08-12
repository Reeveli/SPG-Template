/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, Zeus artillery.
 * Client side function to handle HE artillery. Called from the Zeus ZEN dialog.
 *
 * Arguments:
 * 0: Target position <ARRAY>
 * 1: Barrage dispersion <NUMBER> (default: 150)
 * 2: Amount of rounds <NUMBER> (default: 3)
 * 3: Delay between rounds <NUMBER> (default: 0)
 * 4: Craters <BOOLEAN> (default: false)
 *
 * Return Value: BOOL
 *
 * Example:
 * [_position select 0, _radius,_number,_delay,_craters] call Rev_arty_fnc_zeus_type_HE
 *
 1.3
	Code rewritten for simplified params
 1.2
	Replaced BIS_fnc_randomPos with CBA_fnc_randPos
	Added base game sounds to whistle pool
	Increased whistle sound range by 400
 1.1
	Added header, default params
	Added safety exit
	Added return boolean on completion
 */

params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_radius",150,[0]], 
	["_number",3,[0]], 
	["_delay",0,[0]], 
	["_craters",false,[false]],
	["_type","Sh_155mm_AMOS",[""]]

];

//Start bombarment
for "_i" from 1 to _number do {
	[{
		params ["_pos", "_radius","_craters","_type"];		
		[_pos,_radius,false,_craters,_type] call Rev_arty_fnc_shell_HE;
	
	}, [_pos, _radius,_craters,_type], ((_i * _delay) + (random 2))] call CBA_fnc_waitAndExecute;
};

true;