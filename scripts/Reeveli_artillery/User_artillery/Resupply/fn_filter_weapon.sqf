/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to filters compatible weapon items in the supply dialog.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_arty_fnc_filter_weapon
 *
 */

private _weapon = lnbData [5014,[lnbCurSelRow 5014, 1]];
private _list = uiNamespace getVariable ["Rev_supply_list",[]];
private _weap_items = _weapon call BIS_fnc_compatibleItems;
private _weap_mags = [_weapon] call BIS_fnc_compatibleMagazines;
private _items = [];

private ["_config"];
{
	_config = _x select 0;
	_items pushBackUnique _config;
} forEach _list;


private _comp_items = (_items apply {toUpperANSI _x}) arrayIntersect (_weap_items apply {toUpperANSI _x});
private _comp_mags = (_items apply {toUpperANSI _x}) arrayIntersect (_weap_mags apply {toUpperANSI _x});

[[_weapon] + _comp_items + _comp_mags] call Rev_arty_fnc_supply_list;

