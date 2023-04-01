/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to handle sorting items by name the supply dialog.
 *
 * Arguments:
 * 0: Control (not used) <CONTROL>
 * 1: Column <NUMBER> (default: 1)
 * 3: Reverse <BOOL> (not used) (default: false)
 *
 * Return Value: NONE
 *
 * Example:
 * [_control,1,false] call Rev_arty_fnc_supply_sort_name
 *
 */
 
params [
	["_control",controlNull,[controlNull]],
	["_column",1,[0]],
	["_reverse",false,[true]]
];

//[5014, _column] lnbSortBy ["TEXT", _reverse]; available only for dev branch at this time, wait for 2.06 release

if ((ctrlText 5019) isEqualTo "a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_up_ca.paa") then {
	ctrlSetText [5019, "a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_down_ca.paa"];
	lnbSort [5014, _column, false];
} else {
	ctrlSetText [5019, "a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_up_ca.paa"];
	lnbSort [5014, _column, true];
};






