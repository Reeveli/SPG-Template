/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, type functions.
 * Client side function to handel initial HE support request from artillery dialog_exit.
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
 * [_location,_target,_range,_angle,_number,_caller_pos,"HE",_delay] call Rev_arty_fnc_type_HE
 *
1.7.1
	Fixed wrong warning on exceeding max distance
1.7
	Ammo regen server event is now activated here
1.6
	Max distance warninh updated to use addonoption
1.5
	Added proper header and default params	
1.4
	Server side ammo update changed to CBA event
	Major restructuring, actual barrage split off as its now called from radio dialog
1.3
	Radio dialog only starts in multiplayer due to TFAR requirement
1.2
	Added condition for craters
1.1
	Second half of script spawned in separate scope to allow waituntill command
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

private _ammo_amount = Rev_arty_HE_amount;
private _start_pos = [_location, true] call CBA_fnc_mapGridToPos;

//Check ammunition amount
private _unmodified_number = _number;
if (_number < 0) exitWith {[{playSound "FD_Start_F"; hint "Invalid round count specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;};
if (_number > 20) exitWith {[{playSound "FD_Start_F"; hint "Safety limit exceeded, reduce barrage to max 20 rounds!";}, [], 0.001] call CBA_fnc_waitAndExecute;};
if (_number > _ammo_amount) then {_number = _ammo_amount; [{playSound "FD_Start_F"; params ["_ammo_amount"];hint format ["Maximum available ordance of %1 used!",_ammo_amount];}, [_ammo_amount], 0.001] call CBA_fnc_waitAndExecute;};
if (_number == 0) exitWith {[{playSound "FD_Start_F"; hint "No rounds selected!";}, [], 0.001] call CBA_fnc_waitAndExecute;};
if ((_number <= _ammo_amount) && (_number != 0) && (_number == _unmodified_number)) then {hintSilent "";};

//Check if provided position is reasonable
private _pos = _start_pos getPos [_range,_angle];
if (typeName _target isEqualTo "STRING") then {_pos = getMarkerPos _target};
if ((_caller_pos distance _pos) > Rev_arty_safety_dis) exitWith {[{playSound "FD_Start_F"; hintSilent format ["You must call the fire mission to within %1m of your position!",round Rev_arty_safety_dis];}, [], 0.001] call CBA_fnc_waitAndExecute;};
//Safe distance of 100m relative to reported pos
if ((_start_pos distance _pos) < 100) exitWith {[{playSound "FD_Start_F"; hint "You cannot call barrage to within 100m of observer position!";}, [], 0.001] call CBA_fnc_waitAndExecute;};

//Update ammo amount to server
["Rev_arty_HE_regen",[_number]] call CBA_fnc_serverEvent;

//Radio dialog
if (isMultiplayer) then
{
	Rev_arty_radio_dialog = [_location,_angle,_range,_target,_round_type,_pos,_number,_delay] execVM "scripts\Reeveli_artillery\User_artillery\Radio_dialog\radio_dialog.sqf";
} else {
	[{hint "Radio dialog only works in multiplayer";}, [], 0.001] call CBA_fnc_waitAndExecute;
	[{
		params ["_angle","_range","_pos","_number","_delay"];
		[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_HE;
	}, [_angle,_range,_pos,_number,_delay],5] call CBA_fnc_waitAndExecute;
};
