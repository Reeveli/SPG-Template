/*
 * Author: Reeveli
 * Part of Reeveli's curator ping list system.
 * Client side function to handle toggling the ping list via the title button.
 * Called from the dialog controls' onButtonClick eh.
 *
 * Arguments:
 * 0: Ping list title control <CONTROL>
 *
 * Return Value: NONE
 *
 * Example:
 * [_control] call Rev_fnc_pingList_onButtonClick
 *
 */

params [
	["_control",controlNull,[controlNull]]
];

private _display = ctrlParent _control;
private _pingListFrame = _display displayCtrl 6083;
private _pingList= _display displayCtrl 6084;
private _pingBackground= _display displayCtrl 6085;

private _state = uiNamespace getVariable ["Rev_pinglist_visibility",true];
_pingListFrame ctrlShow !_state;
_pingList ctrlShow !_state;
_pingBackground ctrlShow !_state;


private _newState = uiNamespace setVariable ["Rev_pinglist_visibility",!_state];