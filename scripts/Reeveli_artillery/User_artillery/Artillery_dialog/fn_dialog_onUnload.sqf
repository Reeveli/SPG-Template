/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, artillery dialog.
 * Client side function to handle dialog onload. Called from the dialog onUnload event.
 *
 * Arguments:
 * 0: Dialog <DISPLAY>
 * 1: Exit code <NUMBER> (default: 3)
 *
 * Exit codes:
 * 0 (default value for unknown cause, e.g. if win key is pressed)
 * 1 (Message sent/OK)
 * 2 (Esc key used/abort)
 * 3 (Cancel button used)
 *
 * Return Value: NONE
 *
 * Example:
 * [_display,_exitCode] call Rev_arty_fnc_dialog_onUnload
 *
 */


params [
	["_display",displayNull,[displayNull]],
	["_exitCode",3,[0]]
];

//Removing flashlight glow
[player, ""] call ace_map_fnc_switchFlashlight;

//Main dialog
private _case = _display displayCtrl 6074;
private _pos = ctrlPosition _case;
_pos params ["_xCor", "_yCor", "_w", "_h"];

uiNamespace setVariable ['Rev_arty_dialog_x',_xCor];
uiNamespace setVariable ['Rev_arty_dialog_y',_yCor];


//GPS
private _gps = _display displayCtrl 913589;
private _posGps = ctrlPosition _gps;
_posGps params ["_xCor", "_zCor","_yCor"];

uiNamespace setVariable ['Rev_arty_gps_x',_xCor];
uiNamespace setVariable ['Rev_arty_gps_y',_yCor];

//If esc key
if (_exitCode == 2) exitWith {};
//If unknown cause
if (_exitCode == 0) exitWith {};


//Current dialog results for saving
private _location = ctrlText 6062;
private _distance = ctrlText 6063;
private _bearing = ctrlText 6064;
private _target = lbData [6065, lbCurSel 6065];
private _trp_index = lbCurSel 6065;
private _delay = ctrlText 6066;
private _rounds_selected = ctrlText 6067; 
private _round_type = (_display displayCtrl 6068) lnbText [lnbCurSelRow 6068,0];
private _round_index = lnbCurSelRow 6068;

//Getting current map pos and zoom for saving
//Why the Y-axis middle value used to be Y + 24.25 and NOT 29, what was the rationale for that I do not know but I mention it here if the reason ever re-appears
private _map = _display displayCtrl 6061;
private _map_pos = _map ctrlMapScreenToWorld [
	(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 47.25 * pixelGridNoUIScale * pixelW,
	(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 29 * pixelGridNoUIScale * pixelH
];
private _map_scale = ctrlMapScale _map;

//Saving current dialog inputs for next usage
missionNamespace setVariable ["Rev_artillery_dialog_result",[_location,_distance,_bearing,_trp_index,_delay,_rounds_selected,_round_index,_map_pos,_map_scale]];

//If cancel button
if (_exitCode == 3) exitWith {};


private _corrected_location = _location;

//TRP Lisr
private _list_trp = [""];
//Get list of pre placed markers
{
	private _currMarker = toArray _x;
	if(count _currMarker >= 3) then 
	{
		_currMarker resize 3;
		_currMarker = toString _currMarker;
		if(_currMarker == "trp") then
			{_list_trp append [_x];}; 
	};
} foreach allMapMarkers;

//Check if TRP is used
if (_list_trp find _target == -1) exitWith {
		[{playSound "FD_Start_F"; hint "Invalid designated target!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};
if !(count _target == 0) then {_corrected_location  = "000000";} else {_target = 0};

//Check position
if (((count _corrected_location ) % 2 != 0) OR (count _corrected_location  < 6) OR (count _corrected_location  > 10))
exitWith {		
		[{playSound "FD_Start_F"; hint "Invalid observer location specified, provide 6, 8 or 10 grid reference!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};	
//Check if position is valid numbers
if (count (_corrected_location  splitString "0123456789") > 0) exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid observer location specified, use numbers only!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};


//Check if range is valid numbers
if (count (_distance splitString "0123456789") > 0 && _corrected_location  != "000000") exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid target distance specified, use numbers only!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};
//Check if range is not empty
if (count _distance == 0 && _corrected_location  != "000000") exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid target distance specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};



//Check if angle is valid numbers
if (count (_bearing splitString "0123456789.") > 0 && _corrected_location  != "000000") exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid target direction specified, use numbers only!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};
//Check if angle is not empty
if (count _bearing == 0 && _corrected_location  != "000000" ) exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid target direction specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};


//Check if delay is valid numbers
if (count (_delay splitString "0123456789.") > 0) exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid rounds delay specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};
//Check if delay is not empty
if (count _delay == 0) exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid rounds delay specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};


//Check if amount is valid numbers
if (count (_rounds_selected splitString "0123456789.") > 0) exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid round count specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};
//Check if amount is not empty
if (count _rounds_selected == 0) exitWith {	
		[{playSound "FD_Start_F"; hint "Invalid round count specified!";}, [], 0.001] call CBA_fnc_waitAndExecute;
	};


private _range = parseNumber _distance;
private _angle = parseNumber _bearing;
private _number = parseNumber _rounds_selected;
_delay = parseNumber _delay;
round _range;
round _angle;
round _number;
round _delay;


//Converting round type to uppercase since all legacy functions use them
_round_type = toUpperANSI _round_type;

//Caller true position for cheat prevention
private _caller_pos = getpos player;
switch _round_type do {
			
	case ("HIGH EXPLOSIVE"): {[_location,_target,_range,_angle,_number,_caller_pos,"HE",_delay] call Rev_arty_fnc_type_HE};
	case ("WHITE SMOKE"): {[_location,_target,_range,_angle,_number,_caller_pos,"Smoke",_delay] call Rev_arty_fnc_type_SMK};
	case ("ILLUMINATION"): {[_location,_target,_range,_angle,_number,_caller_pos,"Flare",_delay] call Rev_arty_fnc_type_ILM};
	case ("TACTICAL MISSILE"): {[_location,_target,_range,_angle,_number,_caller_pos,"Missile",_delay] call Rev_arty_fnc_type_MIS};
	case ("CLUSTER MISSILE"): {[_location,_target,_range,_angle,_number,_caller_pos,"Missile",_delay] call Rev_arty_fnc_type_MIS};
	case ("AIR SUPPORT"): {[_location,_target,_range,_angle,_number,_caller_pos,"Air",_delay] call Rev_arty_fnc_type_AIR};
	case ("SUPPLY DROP"): {[_location,_target,_range,_angle,_number,_caller_pos,"Supply",_delay] call Rev_arty_fnc_type_SUP};
	case ("GUNSHIP SUPPORT"): {[_location,_target,_range,_angle,_number,_caller_pos,"Gunship",_delay] call Rev_arty_fnc_type_GUN};
	case ("AREA BOMBING"): {[_location,_target,_range,_angle,_number,_caller_pos,"Bombing",_delay] call Rev_arty_fnc_type_BOM};
	default {playSound "FD_Start_F"; [{playSound "FD_Start_F"; hint "Invalid ordance request!";}, [], 0.001] call CBA_fnc_waitAndExecute;};
};