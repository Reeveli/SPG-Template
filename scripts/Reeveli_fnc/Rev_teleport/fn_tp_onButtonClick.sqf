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
 1.1
	Eliminated ldData, _lbCurSel now used instead	
 */

if !(hasInterface) exitWith {};

private _listing = uiNamespace getVariable ['Rev_tp_list', controlNull];
private _index = lbCurSel _listing;

private _list = missionNamespace getVariable ["Rev_tp_list",[]];
private _object = (_list # _index) # 0;

[player, _object] call Rev_fnc_tp_teleport;

closeDialog 1;