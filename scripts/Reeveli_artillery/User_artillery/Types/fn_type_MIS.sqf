/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, type functions.
 * Client side function to handel initial missile request from artillery dialog_exit.
 *
 * Arguments:
 * 0: Inputted position from artillery dialog in string form <STRING> (default: "000000")
 * 1: Designated target if any <NUMBER|ARRAY> (default: 0)
 * 2: Inputted range from artillery dialog <NUMBER> (default: 100)
 * 3: Inputted bearing from artillery dialog <NUMBER> (default: 0)
 * 4: Selected ammunition amount <NUMBER> (default: 1)
 * 5: Actual caller position <ARRAY> (default: [0,0,0])
 * 6: Selected round type from artillery dialog <STRING> (default: "HE")
 * 7: Selected ammunition delay <NUMBER> (default: 0)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_location,_target,_range,_angle,_number,_caller_pos,"Missile",_delay] call Rev_arty_fnc_type_MIS
 *
1.7
	Safety checks on number streamlined
1.6.1
	Added proper header and default params
1.6
	passed argument _type removed as obsolete
	Ammo counter event removed
	radio dialog call removed
	Added new call to map dialog
	Artillery_call variable is now set here
	Round count now combiens HE and cluster missiles for amount check

1.5
	Server side ammo update changed to CBA event
	Major restruturing, missile launch separated to its own function
1.4
	Added new param for missile type
	Removed unnecessary start speed definitions and arg passings

1.3
	Radio dialog only starts in multiplayer due to TFAR requirement
1.2
	Second half of script spawned in separate scope to allow waituntill command
1.1
	Removed range bug prevention as nonsensical
		This was also the cause of the laser not being found
*/

params [
	["_location","000000",[""]],
	["_target",0,["",0]],
	["_range",100,[0]],
	["_angle",0,[0]],
	["_number",1,[0]],
	["_caller_pos",[0,0,0],[[]],[2,3]],
	["_round_type","HE",[""]],
	["_delay",0,[0]]
];

private _start_pos = [_location, true] call CBA_fnc_mapGridToPos;

//Check ammunition amount
private _unmodified_number = _number;
if (Rev_arty_MIS_amount + Rev_arty_CLU_amount == 0) exitWith {[{playSound "FD_Start_F"; hint "No missiles available!";}, [], 0.001] call CBA_fnc_waitAndExecute;};
if !(_number == 1) exitWith {[{playSound "FD_Start_F"; hint "Select 1 as the round amount!";}, [], 0.001] call CBA_fnc_waitAndExecute;};
if ((_number <= Rev_arty_MIS_amount) && (_number != 0) && (_number == _unmodified_number)) then {hintSilent "";};

//Check if laser target
private _pos = _start_pos getPos [_range,_angle];
if (typeName _target isEqualTo "STRING") then {_pos = getMarkerPos _target};
if (count (_pos nearEntities ['LaserTarget', 100]) == 0) exitWith {[{playSound "FD_Start_F"; hint "No target designated with laser. Check your coordinates.";}, [], 0.001] call CBA_fnc_waitAndExecute;};
private _tgt = (_pos nearEntities ['LaserTarget', 100] ) select 0;

//Check if a previous missile is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_mis_call',nil]}) exitWith {[{playSound "FD_Start_F"; hint "Previous missile strike is still processing!";}, [], 0.001] call CBA_fnc_waitAndExecute;};


[{[param [0],param [1],param [2]] call Rev_arty_fnc_missile_map_dialog},[_target,_tgt,_pos], 0.001] call CBA_fnc_waitAndExecute;
missionNamespace setVariable ["Rev_artillery_call",[_location,_angle,_range,_target,_round_type,_pos,_number,_delay,_tgt]];