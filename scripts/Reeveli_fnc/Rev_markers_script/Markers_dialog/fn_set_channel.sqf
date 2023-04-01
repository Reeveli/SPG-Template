/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to set current channel to correspond to channels menu in markers dialog. Called from Rev_markers2_fnc_set_channel.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_set_channel
 *
 */

if !(hasInterface) exitwith {};
private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4022;
private _index = lbCurSel 4022;
private _text = _ctrl lbData _index;
setCurrentChannel (parseNumber _text);