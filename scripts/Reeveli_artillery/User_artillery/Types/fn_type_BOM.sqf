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
1.1
	TRPs can now be used as relative positions with angle + distance	
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

//Check ammunition amount
if (Rev_arty_SUP_amount == 0) exitWith {[{playSound "FD_Start_F"; hint "No bombing runs available!";}, []] call CBA_fnc_execNextFrame;};

private _start_pos = [_location, true] call CBA_fnc_mapGridToPos;
if (typeName _target isEqualTo "STRING") then {
	_start_pos = getMarkerPos _target;
	_location = mapGridPosition _start_pos;
};
private _finalPos = _start_pos getPos [_range,_angle];

//Check if a previous supply request is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_bom_call',nil]}) exitWith {[{playSound "FD_Start_F"; hint "Previous bombing request is still processing!";}, []] call CBA_fnc_execNextFrame;};

[{[] call Rev_arty_fnc_bomb_map_dialog},[]] call CBA_fnc_execNextFrame;
missionNamespace setVariable ["Rev_artillery_call",[_location,_angle,_range,_target,_round_type,_finalPos,_number,_delay]];
