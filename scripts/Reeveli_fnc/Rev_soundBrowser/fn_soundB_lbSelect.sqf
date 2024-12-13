/*
 * Author: Rydygier & Reeveli
 * Part of Simple Sound Browser.
 * Client side function to handle listbox selection.
 * Called from 'RscSoundBrowser' dialog 'RscList_SB' control.
 *
 * Arguments:
 * 0: Listbox control <CONTROL>
 * 1: Currently selected index <NUMBER> (default: -1)
 *
 * Return Value: NONE
 *
 * Example:
 * [_control, _selectedIndex] call Rev_fnc_soundB_lbSelect;
 *
 */

params [
	["_control",controlNull,[controlNull]],
	["_lbCurSel",-1,[0]]	
];

private _list = localNameSpace getVariable ['Rev_soundB_list',controlNull];
private _current = _list lbText _lbCurSel;

private _sound = [0,0,0] nearestObject "#soundonvehicle";
deleteVehicle _sound;
playSound _current;


private _copy = localNameSpace getVariable ['Rev_soundB_copy',controlNull];
_copy ctrlEnable true;

//Setting current value for debug
localNameSpace setVariable ['Rev_soundB_current',_current];