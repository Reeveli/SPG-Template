/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Recreates the item list in the supply dialog based on a new list, usually after a filter has been added.
 *
 * Arguments:
 * 0: Item list <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_new_list] call Rev_arty_fnc_supply_list;
 *
 */
 
params [
	["_items",nil,[[]]]
];

lnbClear 5014;
private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _cfgGlasses   = configFile >> "CfgGlasses";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles  = configFile >> "CfgVehicles";
private _cfgWeapons   = configFile >> "CfgWeapons";

private ["_config","_amount","_name","_image","_control","_data"];
{
	_config = _x;
	_name = "";
	_image = "";
	if (isClass (_cfgWeapons >> _config)) then {
		_name = getText (_cfgWeapons >> _config >> "displayname");	
		_image = getText (_cfgWeapons >> _config >> "picture");
	};	
	if (isClass (_cfgMagazines >> _config)) then {
		_name = getText (_cfgMagazines >> _config >> "displayname");
		_image = getText (_cfgMagazines >> _config >> "picture");
	};	
	if (isClass (_cfgVehicles >> _config)) then {
		_name = getText (_cfgVehicles >> _config >> "displayname");
		_image = getText (_cfgVehicles >> _config >> "picture");
	};	
	if (isClass (_cfgGlasses >> _config)) then {
		_name = getText (_cfgGlasses >> _config >> "displayname");
		_image = getText (_cfgGlasses >> _config >> "picture");
	};
	
	_amount = (_list select (_list findIf {(_config isEqualto (_x select 0)) OR (_config isEqualto toUpperANSI (_x select 0))})) select 1;
	_control = findDisplay 5013 displayCtrl 5014;
	_control lnbAddRow ["", _name];
	_control lnbSetPicture [[_forEachIndex, 0], _image];
	_control lnbSetData [[_forEachIndex, 1], _x];
	_control lnbSetData [[_forEachIndex, 2], str _amount];
	_data = _control lnbData [_forEachIndex, 2];
	_control lnbSetText [[_forEachIndex, 2], _data];
	
	[Rev_arty_SUP_class_box,_config,_amount] call Rev_arty_fnc_supply_mass;

} forEach _items;

lnbSetCurSelRow [5014, 0];