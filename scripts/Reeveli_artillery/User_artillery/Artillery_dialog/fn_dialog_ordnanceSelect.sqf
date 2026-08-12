/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to handle ammo type selection.
 * Called from main artillery dialog ammo list control itself.
 *
 * Arguments:
 * 0: Control affected <CONTROL>
 * 1: Control index <NUMBER> (default: -1)
 *
 * Return Value: NONE
 *
 * Example:
 * [_control,_selectedIndex] call Rev_arty_fnc_ordnanceSelect
 *
 1.1
	Delay is now also toggled if calling air ops
 */


params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",-1,[0]]
];

private _display = ctrlParent _control;
private _delayField = _display displayCtrl 6066;
private _ammoField = _display displayCtrl 6067;

//Resetting defaults
_delayField ctrlEnable true;
_delayField ctrlSetTooltip "Delay between rounds (seconds)";

_ammoField ctrlEnable true;
_ammoField ctrlSetTooltip "Amount of ammunition to be expended (whole numbers)";

//If air op lock amount and delay to 1
if ((_control lnbText [_selectedIndex,0]) in ["Tactical missile","Cluster missile","Air support","Supply drop","Gunship support","Area bombing"]) then {
	_delayField ctrlSetText "0";
	_delayField ctrlEnable false;
	_delayField ctrlSetTooltip "No delay in this kind of ordnance";

	_ammoField ctrlSetText "1";
	_ammoField ctrlEnable false;
	_ammoField ctrlSetTooltip "Only one air operation can be  called at a time";
};
