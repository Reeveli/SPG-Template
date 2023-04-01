/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to handle custom text search in the supply dialog.
 *
 * Arguments:
 * 0: Control <CONTROL>
 *
 * Return Value: NONE
 *
 * Example:
 * [findDisplay 5013 displayCtrl 5018] call Rev_arty_fnc_filter_search
 *
 */

params [
	["_control",controlNull,[controlNull]]
];

private _text = toUpper (ctrlText _control);

private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _final = [];
private _list_up = [];

private _cfgGlasses   = configFile >> "CfgGlasses";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles  = configFile >> "CfgVehicles";
private _cfgWeapons   = configFile >> "CfgWeapons";

private ["_config","_name"];
{
	_config = _x select 0;
	if (isClass (_cfgWeapons >> _config)) then {
		_name = getText (_cfgWeapons >> _config >> "displayname");
	};	
	if (isClass (_cfgMagazines >> _config)) then {
		_name = getText (_cfgMagazines >> _config >> "displayname");
	};	
	if (isClass (_cfgVehicles >> _config)) then {
		_name = getText (_cfgVehicles >> _config >> "displayname");
	};	
	if (isClass (_cfgGlasses >> _config)) then {
		_name = getText (_cfgGlasses >> _config >> "displayname");
	};
	_list_up pushBack [(toUpper _name),_config];

} forEach _list;

private ["_upName","_config"];
{
	_upName = _x select 0;
	_config = _x select 1;
	if (_text in _upName) then {_final pushBackUnique _config};
} forEach _list_up;

[_final] call Rev_arty_fnc_supply_list;