/*
 * Author: Reeveli
 * Part of Zeus resupply system.
 * Client side function to create resupply box and open its inventory management.
 *
 * Arguments:
 * 0: Box classname <STRING> (default: "B_supplyCrate_F")
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_box_type] call Rev_fnc_resupply_box;
 *
 */

params [
	["_box_class","B_supplyCrate_F",[""]]
];

//creating the box at a safe place
private _box = _box_class createVehicle [0,0,0];
_box allowdamage false;
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
_box hideObjectGlobal true;
uiNamespace setVariable ["Rev_arty_supply_box",[_box,_box_class]];

//Inventory dialog
[_box] call zen_inventory_fnc_configure;
private _display = uiNamespace getVariable ["zen_common_display",displayNull];
_display displayAddEventHandler ["Unload", {
	params ["_display", "_exitCode"];
	if (_exitCode isEqualTo 2) exitWith {playSound "FD_Start_F";[objNull, "Supply Drop Cancelled!"] call BIS_fnc_showCuratorFeedbackMessage;};
	[] spawn Rev_fnc_resupply;
	[objNull, "Supply Drop Inbound!"] call BIS_fnc_showCuratorFeedbackMessage;
}];