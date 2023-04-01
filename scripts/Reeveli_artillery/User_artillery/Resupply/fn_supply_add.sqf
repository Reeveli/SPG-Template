/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to handle increase or decreasing item amount in the supply dialog.
 *
 * Arguments:
 * 0: Value <NUMBER> (default: 1)
 *
 * Return Value: NONE
 *
 * Example:
 * [1] call Rev_arty_fnc_supply_add
 *
 */
 
params [
	["_value",1,[0]]
];

private _config = lnbData [5014,[lnbCurSelRow 5014, 1]];
private _list = uiNamespace getVariable ["Rev_supply_list",[]];



//Add new value
if (uiNamespace getVariable ['Rev_supply_shift', false]) then {_value = _value * 5};
//Check if overburdened
if !([Rev_arty_SUP_class_box,_config,_value] call Rev_arty_fnc_supply_mass) exitWith {};

private _new_value = ((_list select (_list findIf {(_config isEqualto (_x select 0)) OR (_config isEqualto toUpperANSI (_x select 0))})) select 1) + _value;
if (_new_value < 0) then {_new_value = 0};

//Data not actually used for anything, left as a legacy feature --> Sorting perhaps?
lnbSetData [5014,[lnbCurSelRow 5014, 2], str _new_value];
lnbSetText [5014,[lnbCurSelRow 5014, 2], str _new_value];

_list set [_list findIf {(_config isEqualto (_x select 0)) OR (_config isEqualto toUpperANSI (_x select 0))},[_config,_new_value]];
uiNamespace setVariable ["Rev_supply_list", _list];