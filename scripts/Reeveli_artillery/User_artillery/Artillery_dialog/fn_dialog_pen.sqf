/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to generate pencil circle effect on a dialog.
 * Called from affected dialogs themselves.
 *
 * Arguments:
 * 0: Control affected <CONTROL>
 * 1: Control index <NUMBER> (default: -1)
 *
 * Return Value: <BOOL>
 *
 * Example:
 * [_control,_selectedIndex] call Rev_arty_fnc_dialog_pen
 *
 1.1
	_pen text is now randomised using Contact marker textures
 */


params [
	["_control",controlNull,[controlNull]],
	["_selectedIndex",-1,[0]]
];

//If none was selected last time keep control hidden
if (_selectedIndex == -1) exitWith {false};

private _posx = ((ctrlPosition _control) select 0) - 1 * pixelGridNoUIScale * pixelW;
private _posy = ((ctrlPosition _control)  select 1) + ((_selectedIndex * 2) - 1) * pixelGridNoUIScale * pixelH;

private _display = ctrlParent _control;
private _pen = _display displayCtrl 6070;

private _text = format ['\a3\UI_F_Enoch\Data\CfgMarkers\circle%1_ca.paa',(selectRandom [1,4])];

_pen ctrlSetPosition [_posx, _posy];
_pen ctrlCommit 0;
_pen ctrlSetText _text;
_pen ctrlShow true;

true;