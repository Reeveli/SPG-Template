params /*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, area bombing ordnance.
 * Client side function to toggle the bombing pattern. Called from bom_map_dialog control
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Selected index <NUMBER> (default: 0)
 *
 * Return Value: <BOOL>
 *
 * Example:
 * [_control,_selectedIndex] call Rev_arty_fnc_bomb_pattern
 *
 2.0
	New code to work with new paper UI, source for this function is now listBox and not two buttons
 */

//For reasons beyond my understading the function will throw 'Type Bool, expected Array' without this systemchat
systemChat "";

params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",0,[0]]
];

if !(hasInterface) exitWith {false};
if (isNull _control) exitWith {false};

switch (_selectedIndex) do {
	case 0: {
		(findDisplay 6050) setVariable ["Rev_arty_pattern","Linear"];
		if !(getMarkerColor "Rev_arty_bom_tgt" == "") then {			
			private _relDir = (markerPos "Rev_arty_bom_dir") getDir (markerPos "Rev_arty_bom_tgt");
			"Rev_arty_bom_tgt" setMarkerDirLocal _relDir;
		};
	};
	case 1: {		
		(findDisplay 6050) setVariable ["Rev_arty_pattern","Horizontal"];
		if !(getMarkerColor "Rev_arty_bom_tgt" == "") then {"Rev_arty_bom_tgt" setMarkerDirLocal ((markerDir "Rev_arty_bom_tgt") + 90)};
	};
};
true;