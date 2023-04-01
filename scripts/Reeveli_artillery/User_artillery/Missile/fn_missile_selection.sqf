/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, tactical missile ordnance.
 * Client side function to handel missile class selection. Called from dialog control.
 *
 * Arguments:
 * 0: Dialog control <CONTROL>
 * 1: Dialog control index <NUMBER> (default: 0)
 *
 * Return Value: NONE
 *
 * Example:
 * [_control,_selectedIndex] call Rev_arty_fnc_missile_selection;
 *
 1.1.1
	Removing left over (accident?) min altitude code from this function
 1.1
	Minimum altitude is now 100m for all missile for additional safety margin, code related to his removed
 */

params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",0,[0]]
];

//Marker text
'Rev_arty_mis_dir' setMarkerTextLocal (_control lnbText [_selectedIndex,0]);


//Updating altitude slider
sliderSetRange [6035, 100, 800];
sliderSetPosition [6035, 500];
//Updating text
ctrlSetText [6034, format ['Flying Altitude: %1M',500]];