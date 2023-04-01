/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to populate channels drop down menu.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_menu_channels
 *
 */

if !(hasInterface) exitwith {};

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4022;
private _current = 0;

private _add = -1;
if ((channelEnabled 0) select 0) then {
	_ctrl lbAdd "Global";
	_add = _add +1;
	_ctrl lbSetData [_add, "0"];
	if (currentChannel isEqualTo 0) then {_current = _add};
};
if ((channelEnabled 1) select 0) then {
	_ctrl lbAdd "Side";
	_add = _add +1;
	_ctrl lbSetColor [_add, [0,0.8,1,1]];
	_ctrl lbSetSelectColor [_add, [0,0.8,1,1]];
	_ctrl lbSetData [_add, "1"];
	if (currentChannel isEqualTo 1) then {_current = _add};
};
if ((channelEnabled 2) select 0) then {
	_ctrl lbAdd "Command";
	_add = _add +1;
	_ctrl lbSetColor [_add, [0.9,0.91,0.38,1]];
	_ctrl lbSetSelectColor [_add, [0.9,0.91,0.38,1]];
	_ctrl lbSetData [_add, "2"];
	if (currentChannel isEqualTo 2) then {_current = _add};
};
if ((channelEnabled 3) select 0) then {
	_ctrl lbAdd "Group";
	_add = _add +1;
	_ctrl lbSetColor [_add, [0.75,0.93,0.49,1]];
	_ctrl lbSetSelectColor [_add, [0.75,0.93,0.49,1]];
	_ctrl lbSetData [_add, "3"];
	if (currentChannel isEqualTo 3) then {_current = _add};
};
if ((channelEnabled 4) select 0) then {
	_ctrl lbAdd "Vehicle";
	_add = _add +1;
	_ctrl lbSetColor [_add, [0.98,0.83,0.04,1]];
	_ctrl lbSetSelectColor [_add, [0.98,0.83,0.04,1]];
	_ctrl lbSetData [_add, "4"];
	if (currentChannel isEqualTo 4) then {_current = _add};
};
if ((channelEnabled 5) select 0) then {
	_ctrl lbAdd "Direct";
	_add = _add +1;
	_ctrl lbSetColor [_add, [0.85,0.85,0.85,1]];
	_ctrl lbSetSelectColor [_add, [0.85,0.85,0.85,1]];
	_ctrl lbSetData [_add, "5"];
	if (currentChannel isEqualTo 5) then {_current = _add};
};

_ctrl lbSetCurSel _current;
