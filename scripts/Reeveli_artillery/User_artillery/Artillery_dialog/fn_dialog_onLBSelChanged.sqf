/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, artillery dialog.
 * Client side function to handle center map on selected TRP.
 * Called from TRP list control onLBSelChanged event
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Selected index <NUMBER>
 *
 * Return Value: NONE
 *
 * Example:
 * [_control, _lbCurSel, _lbSelection] call Rev_arty_fnc_dialog_onLBSelChanged";
 *
 */

params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",-1,[0]]
];

private _marker = _control lbData _selectedIndex;
private _pos = getMarkerPos _marker;

if (_pos isEqualto [0,0,0]) exitWith {};

private _mapDisplay = findDisplay 6060;
private _mapControl = _mapDisplay displayCtrl 6061;
private _map_scale = ctrlMapScale _mapControl;

_mapControl ctrlMapAnimAdd [0, _map_scale, getMarkerPos _marker];
ctrlMapAnimCommit _mapControl;