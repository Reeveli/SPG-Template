/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Function to handle onButtonClick EH.
 * Called from dialog 'Rev_tp_dialog'
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_fnc_tp_onButtonClick
 *
 */

if !(hasInterface) exitWith {};

private _listing = uiNamespace getVariable ['Rev_tp_list', controlNull];
private _name = _listing lbData (lbCurSel _listing);

private _list = missionNamespace getVariable ["Rev_tp_list",[]];
private _index = _list findIf {(_x # 1) isEqualTo _name};
private _object = (_list # _index) # 0;

[player, _object] call Rev_fnc_tp_teleport;

closeDialog 1;