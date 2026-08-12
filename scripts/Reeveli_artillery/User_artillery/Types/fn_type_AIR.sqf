/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, type functions.
 * Client side function to handel initial air support request from artillery dialog_exit.
 * Next function in chain is Rev_arty_fnc_air_map_dialog
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
 * [_location,_target,_range,_angle,_number,_caller_pos,"Air",_delay] call Rev_arty_fnc_type_AIR
 *
1.5
	TRPs can now be used as relative positions with angle + distance
	Removed max distance check as that is now done in main dialog	
1.4
	Safety checks on number streamlined
1.3
	Max distance hint updated to use addonoption
1.2
	Air dialog call cleaned of unnecessary params
	Added proper header and default params
1.1.1
	Added additional param for dialog opening to account for TRP in dialog map
1.1
	Code for new air call in system
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
	["_round_type","HE",[""]],
	["_delay",0,[0]]
];

//Check ammunition amount
private _unmodified_number = _number;
if (Rev_arty_AIR_amount == 0) exitWith {[{playSound "FD_Start_F"; hint "No air support available!";}, []] call CBA_fnc_execNextFrame;};
if !(_number == 1) exitWith {[{playSound "FD_Start_F"; hint "Select 1 as the round amount!";}, []] call CBA_fnc_execNextFrame;};
if ((_number <= Rev_arty_AIR_amount) && (_number != 0) && (_number == _unmodified_number)) then {hintSilent "";};

private _start_pos = [_location, true] call CBA_fnc_mapGridToPos;
if (typeName _target isEqualTo "STRING") then {
	_start_pos = getMarkerPos _target;
	_location = mapGridPosition _start_pos;
};
private _finalPos = _start_pos getPos [_range,_angle];

//Check if a previous air strike is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_air_call',nil]}) exitWith {[{playSound "FD_Start_F"; hint "Previous air strike is still processing!";}, []] call CBA_fnc_execNextFrame;};

[{_this call Rev_arty_fnc_air_map_dialog},[_target,_finalPos]] call CBA_fnc_execNextFrame;
missionNamespace setVariable ["Rev_artillery_call",[_location,_angle,_range,_target,_round_type,_finalPos,_number,_delay]];
