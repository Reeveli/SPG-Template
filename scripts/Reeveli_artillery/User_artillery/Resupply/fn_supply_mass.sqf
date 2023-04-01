/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to calculate if its possible to add new item(s) to the supply box (if its full) and to update the progres sbar showing the available box space.
 *
 * Arguments:
 * 0: Box class name <STRING>
 * 1: Item class name <STRING>
 * 2: Amount <Number> (default: 1)
 *
 * Return Value: <BOOL>
 * True: There is enough room in the box to add item.
 * False: There is not enouhg room in the box.
 *
 * Example:
 * [Rev_arty_SUP_class_box,_config,_amount] call Rev_arty_fnc_supply_mass
 *
 */
 
params [
	["_box","",[""]],
	["_item","",[""]],
	["_value",1,[0]]
];

private _maxLoad = getNumber (configfile >> "CfgVehicles" >> _box >> "maximumLoad");
private _current = 0;
private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _cfgGlasses   = configFile >> "CfgGlasses";
private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgVehicles  = configFile >> "CfgVehicles";
private _cfgWeapons   = configFile >> "CfgWeapons";

//Calculating old cargo
private ["_config","_amount"];

////////////////////////////////////////////////////////////////////////

{
	_config = _x select 0;
	_amount = (_list select (_list findIf {(_config isEqualto (_x select 0)) OR (_config isEqualto toUpperANSI (_x select 0))})) select 1;
	private _configItemInfo = _cfgWeapons >> _config >> "ItemInfo";
	private _configWeaponsInfo = _cfgWeapons >> _config >> "WeaponSlotsInfo";

	switch true do {
		case (isClass (_cfgWeapons >> _config)): {
			if (isClass (_configWeaponsInfo)) then {_current = _current + getNumber (_configWeaponsInfo >> "mass") * _amount;}
			else {_current = _current + getNumber (_configItemInfo >> "mass") * _amount;}
		};
	
		case (isClass (_cfgMagazines >> _config)): {
			_current = _current + getNumber (_cfgMagazines >> _config >> "mass") * _amount;
		};
		case (isClass (_cfgVehicles >> _config)): {
			_current = _current + getNumber (_cfgVehicles >> _config >> "mass") * _amount;
		};
		case (isClass (_cfgGlasses >> _config)): {
			_current = _current + getNumber (_cfgGlasses >> _config >> "mass") * _amount;
		};
	};

} foreach _list;


//Adding new item
if (isClass (configFile >> "CfgWeapons" >> _item)) then {
	if (isClass (_cfgWeapons >> _item >> "WeaponSlotsInfo")) then {_current = _current + getNumber (_cfgWeapons >> _item >> "WeaponSlotsInfo" >> "mass") * _value;}
			else {_current = _current + getNumber (_cfgWeapons >> _item >> "ItemInfo" >> "mass") * _value;}
};	
if (isClass (configFile >> "CfgMagazines" >> _item)) then {
	_current = _current + getNumber (_cfgMagazines >> _item >> "mass") * _value;
};
if (isClass (configFile >> "CfgVehicles" >> _item)) then {
	_current = _current + getNumber (_cfgVehicles >> _item >> "mass") * _value;
};
if (isClass (configFile >> "CfgGlasses" >> _item)) then {
	_current = _current + getNumber (_cfgGlasses >> _item >> "mass") * _value;
};

//If overloaded
if (_current >= _maxLoad) exitWith {false};


//Update UI
private _progress = linearConversion [0, _maxLoad, _current, 0, 1, true];
private _control = findDisplay 5013 displayCtrl 5017;
_control progressSetPosition _progress;

true;

