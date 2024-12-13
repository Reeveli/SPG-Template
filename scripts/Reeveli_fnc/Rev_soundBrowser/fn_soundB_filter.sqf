/*
 * Author: Rydygier & Reeveli
 * Part of Simple Sound Browser.
 * Client side function to handle listbox filtering.
 * Called from 'RscSoundBrowser' dialog 'RscEdit_SB_Filter' control.
 *
 * Arguments:
 * 0: Filter control <CONTROL>
 * 1: Current filter string <STRING> (default: "")
 *
 * Return Value: NONE
 *
 * Example:
 * [_control,_key] call Rev_fnc_soundB_filter
 *
 */
	
params [
	["_control",controlNull,[controlNull]],
	["_key","",[""]]	
];

private _txt = toLower (ctrlText _control);
private _list = localNameSpace getVariable ['Rev_soundB_list',controlNull];
lbClear _list;

private _cfgSounds = configFile >> "CfgSounds";

{
	if !(((toLower _x) find _txt) < 0) then {
		private _index = _list lbAdd _x;
		_name = _cfgSounds >> _x >> "titles";
		
		if (isArray _name) then {			
			private _n = (getArray _name) select 0;
			if (_n isEqualType "") then {_list lbSetTooltip [_index,_n]};
		};
	};
} foreach RYD_SB_AllTheSounds;

lbSort [_list,"ASC"];

private _copy = localNameSpace getVariable ['Rev_soundB_copy',controlNull];
_copy ctrlEnable false;