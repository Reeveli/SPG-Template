/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, resupply system
 * Client side function to handle supply dialog onUnload. Called from the dialog onUnload event.
 *
 * Arguments:
 * 0: Dialog <DISPLAY>
 * 1: Exit code <NUMBER> (default: 0)
 *
 * Exit codes:
 * 0 (only known instance is if win key is pressed)
 * 1 (Message sent/OK)
 * 2 (Esc key used/abort)
 * 3 (Cancel button used)
 * 
 * Return Value: NONE
 *
 * Example:
 * [_display,_exitCode] call Rev_arty_fnc_supply_dialog_onUnload
 *
 1.1
	Added map marker deletion
 */


params [
	["_display",displayNull,[displayNull]],
	["_exitCode",0,[0]]
];

//deleting markers
deleteMarkerLocal 'Rev_arty_sup_tgt';

//Removing flashlight glow
[player, ""] call ace_map_fnc_switchFlashlight;

//If message not sent nil safety varibale
if !(_exitCode == 1) then {player setVariable ['Rev_arty_sup_call',nil];};

//Main dialog position
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

//Getting current map pos and zoom for saving
//Why the Y-axis middle value used to be Y + 24.25 and NOT 29, what was the rationale for that I do not know but I mention it here if the reason ever re-appears
private _map = _display displayCtrl 6061;
private _map_pos = _map ctrlMapScreenToWorld [
	(uiNamespace getvariable ['Rev_arty_dialog_x',safezoneX + (safezoneW * 0.50) - ((64 * pixelGridNoUIScale * pixelW) * 0.5)]) + 47.25 * pixelGridNoUIScale * pixelW,
	(uiNamespace getvariable ['Rev_arty_dialog_y',safezoneY + (safezoneH * 0.50) - ((64 * pixelGridNoUIScale * pixelH) * 0.5)]) + 29 * pixelGridNoUIScale * pixelH
];
private _map_scale = ctrlMapScale _map;
(missionNamespace getVariable "Rev_artillery_dialog_result") set [7,_map_pos];
(missionNamespace getVariable "Rev_artillery_dialog_result") set [8,_map_scale];


//If cancel reopen previous dialog
if (_exitCode == 3) exitWith {	
	[{[] call Rev_arty_fnc_dialog}, [],0.01] call CBA_fnc_waitAndExecute;	
};

//If 'Continue' open supply map dialog
[{[] call Rev_arty_fnc_supply_map_dialog}, [],0.01] call CBA_fnc_waitAndExecute;