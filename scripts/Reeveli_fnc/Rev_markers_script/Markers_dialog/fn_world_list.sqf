/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to populate selected world with saved markers. Called when markers dialog world list selection is changed.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_world_list
 *
 */

if !(hasInterface) exitwith {};

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4050;
private _ctrl2 = _disp displayCtrl 4051;
private _ctrl3 = _disp displayCtrl 4023;
private _ctrl4 = _disp displayCtrl 4027;

lbClear _ctrl2;

private _saved = call Rev_markers2_fnc_get_saved;


private _index = lbCurSel _ctrl;
private _world = _ctrl lbData _index;

private _add = -1;
private ["_name","_set"];
{
	if (((profileNamespace getVariable _x) select 0) isEqualTo _world) then {
		_name = (profileNamespace getVariable _x) select 1;
		_set = (profileNamespace getVariable _x) select 2;
		_ctrl2 lbAdd _name;
		_add = _add +1;
		_ctrl2 lbSetData [_add, str [_x,_set]];
	};
} forEach _saved;

if ((lbSize _ctrl2) <= 0) then {_ctrl3 ctrlEnable false;_ctrl4 ctrlEnable false;};
call Rev_markers2_fnc_update_menu;