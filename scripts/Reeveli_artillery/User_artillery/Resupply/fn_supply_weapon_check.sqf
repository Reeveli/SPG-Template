/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to detect of weapon compatible items are availabe in the supply list.
 *
 * Arguments:
 * 0: Control <CONTROL> (not used)
 * 1: Lb selected index <NUMBER> (default: 0) (not used)
 *
 * Return Value: NONE
 *
 * Example:
 * [_control,_selectedIndex] call Rev_arty_fnc_supply_weapon_check
 *
 */
 
params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",1,[0]]
];

private _weapon = lnbData [5014,[lnbCurSelRow 5014, 1]];
ctrlEnable [5023, false];
if !(isClass (configFile >> "CfgWeapons" >> _weapon)) exitWith {};
if (count (_weapon call BIS_fnc_compatibleItems) <=0) exitWith {};
if (count ([_weapon] call BIS_fnc_compatibleMagazines) <=0) exitWith {};

ctrlEnable [5023, true];