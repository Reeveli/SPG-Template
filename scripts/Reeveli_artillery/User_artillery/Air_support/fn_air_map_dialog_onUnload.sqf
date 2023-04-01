/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, air support.
 * Client side function to handle dialog onload. Called from the dialog onUnload event.
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
 * [_display,_exitCode] call Rev_arty_fnc_air_map_dialog_onUnload
 *
 */

params [
	["_display",displayNull,[displayNull]],
	["_exitCode",0,[0]]
];

//Removing flashlight glow
[player, ""] call ace_map_fnc_switchFlashlight;

//If message not sent nil safety varibale
if !(_exitCode == 1) then {player setVariable ['Rev_arty_air_call',nil]};

//Getting Dialog current inputs here because markers need to be deleted early in the script
private _class = lbData [4081, lbCurSel 4081];
private _loadout = lbData [4083, lbCurSel 4083];
private _altitude = sliderPosition 4085;
private _start_pos = getMarkerPos 'Rev_arty_air_dir';

removeMissionEventHandler ['MapSingleClick', missionNameSpace getVariable ['Rev_arty_air_map_event',-1]];
deleteMarkerLocal 'Rev_arty_air_tgt';
deleteMarkerLocal 'Rev_arty_air_area';
deleteMarkerLocal 'Rev_arty_air_dir';
deleteMarkerLocal 'Rev_arty_air_arrow_1';
deleteMarkerLocal 'Rev_arty_air_arrow_2';
deleteMarkerLocal 'Rev_arty_air_arrow_3';

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


private _args = player getVariable "Rev_arty_air_call";

//Values below were extracted at script start
_args pushBack _class;
_args pushBack _loadout;
_args pushBack _altitude;
_args pushBack _start_pos;


private _radio_args = missionNamespace getVariable ['Rev_artillery_call',nil];
if !(isMultiplayer) exitWith {
	hint 'Radio dialog only works in multiplayer';
	[] spawn Rev_arty_fnc_air_start;
	missionNamespace setVariable ['Rev_artillery_call',nil];
};
Rev_arty_radio_dialog = _radio_args execVM 'scripts\Reeveli_artillery\User_artillery\Radio_dialog\radio_dialog.sqf';
missionNamespace setVariable ['Rev_artillery_call',nil];