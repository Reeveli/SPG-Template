/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Function to handle onLBSelChanged EH.
 * Called from dialog 'Rev_tp_dialog'
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: ListBox current selection <NUMBER>
 *
 * Return Value: NONE
 *
 * Example:
 * [_control, _lbCurSel] call Rev_fnc_tp_onLBSelChanged
 *
 1.1
	Map zoom stays now constant
 */

params [
	["_control",controlNull,[controlNull]],
	["_lbCurSel",-1,[0]]
];

if (_lbCurSel < 0) exitWith {
	playSound "FD_Start_F";
	[objNull, "No teleportation point was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
};

private _name = _control lbData _lbCurSel;

private _list = missionNamespace getVariable ["Rev_tp_list",[]];
private _index = _list findIf {(_x # 1) isEqualTo _name};
private _object = (_list # _index) # 0;

private _map = uiNamespace getVariable ['Rev_tp_map', controlNull];
_map ctrlMapAnimAdd [0, ctrlMapScale _map, (getPos _object)];
ctrlMapAnimCommit _map;

"Rev_tp_marker" setMarkerPosLocal (getpos _object);
"Rev_tp_marker" setMarkerAlphaLocal 1;