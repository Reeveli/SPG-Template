/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to update various markers menu control based on current inputs.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_update_menu
 *
 */

if !(hasInterface) exitwith {};

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4026;
private _ctrl2 = _disp displayCtrl 4021;
private _ctrl3 = _disp displayCtrl 4025;
private _ctrl4 = _disp displayCtrl 4028;
private _ctrl5 = _disp displayCtrl 4050;
private _ctrl6 = _disp displayCtrl 4024;
private _ctrl7 = _disp displayCtrl 4029;

//Create array
if ((count (allMapMarkers select {"_USER_DEFINED" in _x})) > 0) then {
	_ctrl ctrlEnable true;
	_ctrl4 ctrlEnable true;
	_ctrl3 ctrlEnable true
} else {
	_ctrl ctrlEnable false;
	_ctrl4 ctrlEnable false;
	_ctrl3 ctrlEnable false
};

//Save to profile & load from array
private _name = ctrlText _ctrl2;
if ((count _name >= 1)) then {_ctrl3 ctrlEnable true;_ctrl6 ctrlEnable true;} else {_ctrl3 ctrlEnable false;_ctrl6 ctrlEnable false};

//Delete profile
if ((lbSize _ctrl5) > 0) then {_ctrl7 ctrlEnable true} else {_ctrl7 ctrlEnable false};