/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to create markers dialog.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_menu_start
 *
 */

if !(hasInterface) exitwith {};

if (!isNull findDisplay 52) then {findDisplay 52 createDisplay "Rev_marker_menu2"};
if (!isNull findDisplay 53) then {findDisplay 53 createDisplay "Rev_marker_menu2"};
if (!isNull findDisplay 12) then {findDisplay 12 createDisplay "Rev_marker_menu2"};

call Rev_markers2_fnc_menu_channels;
call Rev_markers2_fnc_worlds;
call Rev_markers2_fnc_update_menu;

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4023;
private _ctrl2 = _disp displayCtrl 4027;
_ctrl ctrlEnable false;
_ctrl2 ctrlEnable false;
