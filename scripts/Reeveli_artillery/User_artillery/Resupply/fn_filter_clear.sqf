/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to clear all filters in the supply dialog.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_arty_fnc_filter_clear
 *
 */

lnbClear 5014;

private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _items = [];

private ["_iteration","_amount"];
{
	_iteration = _x select 0;
	_iteration = _x select 1;
	_items pushBackUnique (_x select 0);
	_x set [1, 0]
} forEach _list;

uiNamespace setVariable ["Rev_supply_list",_list];
[_items] call Rev_arty_fnc_supply_list;