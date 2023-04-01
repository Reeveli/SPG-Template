/*
 * Author: Reeveli
 * Part of Reeveli's curator ping list system.
 * Client side function to handle selecting a ping list entry from the list.
 * Called from the dialog control's onLBSelChanged eh.
 *
 * Arguments:
 * 0: Ping list control <CONTROL>
 * 1: Ping list control selected index <NUMBER>
 *
 * Return Value: NONE
 *
 * Example:
 * [_control, _lbCurSel] call Rev_fnc_pingList_onLBSelChanged
 *
 */

params [
	["_control",controlNull,[controlNull]],
	["_lbCurSel",-1,[0]]
];

private _unit = (_control lbData _lbCurSel) call BIS_fnc_objectFromNetId;
private _pos = _unit getRelPos [5, 180];
_pos = _pos vectorAdd [0, 0, 5];
[_pos, _unit, 0] spawn BIS_fnc_setCuratorCamera;