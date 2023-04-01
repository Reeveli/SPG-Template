/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to delete selected marker set from user profile. Called from the mod menu.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_delete
 *
 */

if !(hasInterface) exitwith {};

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4051;
private _index = lbCurSel _ctrl;
if (_index isEqualTo -1) exitWith {playSound "FD_Start_F";systemChat "No marker set selected!"};

private _var = (parseSimpleArray (_ctrl lbData _index)) select 0;
systemChat "Marker set deleted from profile";
_ctrl lbDelete _index;
profileNamespace setVariable [_var, nil];
saveProfileNamespace;
call Rev_markers2_fnc_worlds;