/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to create world list for markers dialog.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_worlds
 *
 */

if !(hasInterface) exitwith {};

private _saved = call Rev_markers2_fnc_get_saved;

private _worlds = [];
private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4050;
lbClear _ctrl;
private _add = -1;
private _current = 0;

private ["_world","_name"];
{
	_world = (profileNamespace getVariable _x) select 0;
	_name = "-Map not found-";
	if !(isclass (configFile >> "CfgWorlds" >> _world)) then {_name = _world} else
	{_name = getText (configFile >> "CfgWorlds" >> _world >> "description")};
	

	if !(_name in _worlds) then 
	{
		_worlds pushBackUnique _name;
		_ctrl lbAdd _name;
		_add = _add +1;
		_ctrl lbSetData [_add, _world];
		if (worldName isEqualTo _world) then {_current = _add};
		diag_log format ["Rev_marker_system: World loaded: %1",_name];
	}
} forEach _saved;

_ctrl lbSetCurSel _current;