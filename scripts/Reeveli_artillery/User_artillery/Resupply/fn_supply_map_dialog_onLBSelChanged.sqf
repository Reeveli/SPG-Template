/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, resupply syste,.
 * Client side function to handle list&box selection. Called from 'Rev_arty_supply_map_dialog' dialog's 'Ordnance_list' control's onLBSelChanged event.
 *
 * Arguments:
 * 0: Control <CONTROL>
 * 1: Selected index <NUMBER> (default: 0)
 * 
 * Return Value: NONE
 *
 * Example:
 * [_display,_exitCode] call Rev_arty_fnc_supply_map_dialog_onLBSelChanged
 *
 */

params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",0,[0]]
];

private _size = (lnbSize _control) select 0;;

//remove all pictures
for "_i" from 0 to (_size -1) do
{
	_control lnbSetPicture [[_i, 2], ''];
};

//add picture to selected index
_control lnbSetPicture [[_selectedIndex, 2], 'scripts\Reeveli_artillery\images\check_1.paa'];


//check if direction has been chosen yet
if ((markerAlpha 'Rev_arty_sup_dir') == 1) then {
	private _display = ctrlParent _control;
	private _warning = _display displayCtrl 6072;
	private _ok = _display displayCtrl 6069;
	private _underscore = _display displayCtrl 6071;
	_warning ctrlSetTextColor [0,0,0,0.3];
	_ok ctrlEnable true;
	_underscore ctrlShow true;
};