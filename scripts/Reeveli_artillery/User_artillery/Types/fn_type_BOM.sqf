/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, type functions.
 * Client side function to handel initial area bombing request from artillery dialog_exit.
 *
 * Arguments:
 * 0: Inputted position from artillery dialog in string form <STRING> (default: "000000")
 * 1: Designated target if any <NUMBER|ARRAY> (default: 0)
 * 2: Inputted range from artillery dialog <NUMBER> (default: 100)
 * 3: Inputted bearing from artillery dialog <NUMBER> (default: 0)
 * 4: Selected ammunition amount <NUMBER> (default: 1)
 * 5: Actual caller position <ARRAY> (default: [0,0,0])
 * 6: Selected round type from artillery dialog <STRING> (default: "Bombing")
 * 7: Selected ammunition delay <NUMBER> (default: 0)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_location,_target,_range,_angle,_number,_caller_pos,"Bombing",_delay] call Rev_arty_fnc_type_BOM
 *
1.0
	Initial version
*/

params [
	["_location","000000",[""]],
	["_target",0,["",0]],
	["_range",100,[0]],
	["_angle",0,[0]],
	["_number",1,[0]],
	["_caller_pos",[0,0,0],[[]],[2,3]],
	["_round_type","Bombing",[""]],
	["_delay",0,[0]]
];

private _start_pos = [_location, true] call CBA_fnc_mapGridToPos;

//Check ammunition amount
if (Rev_arty_SUP_amount == 0) exitWith {[{playSound "FD_Start_F"; hint "No bombing runs available!";}, [], 0.001] call CBA_fnc_waitAndExecute;};

//Check if provided position is reasonable
private _pos = _start_pos getPos [_range,_angle];
if (typeName _target isEqualTo "STRING") then {_pos = getMarkerPos _target};
if ((_caller_pos distance _pos) > Rev_arty_safety_dis) exitWith {[{playSound "FD_Start_F"; hintSilent format ["You must call the air support to within %1m of your position!",round Rev_arty_safety_dis];}, [], 0.001] call CBA_fnc_waitAndExecute;};

//Check if a previous supply request is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_bom_call',nil]}) exitWith {[{playSound "FD_Start_F"; hint "Previous bombing request is still processing!";}, [], 0.001] call CBA_fnc_waitAndExecute;};

[{[] call Rev_arty_fnc_bomb_map_dialog},[], 0.001] call CBA_fnc_waitAndExecute;
missionNamespace setVariable ["Rev_artillery_call",[_location,_angle,_range,_target,_round_type,_pos,_number,_delay]];
