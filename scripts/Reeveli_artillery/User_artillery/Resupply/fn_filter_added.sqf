/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to handle filtering added items in the supply dialog.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_arty_fnc_filter_added
 *
 */

private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _new_list = [];

private ["_config","_amount"];
{
	_config = _x select 0;
	_amount = (_list select (_list findIf {(_config isEqualto (_x select 0)) OR (_config isEqualto toUpperANSI (_x select 0))})) select 1;
	if (_amount > 0) then {_new_list pushBackUnique _config};

} forEach _list;

[_new_list] call Rev_arty_fnc_supply_list;