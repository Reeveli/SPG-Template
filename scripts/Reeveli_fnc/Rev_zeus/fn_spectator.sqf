/*
 * Author: Reeveli
 * Function to promote player to ACE spectator status. Called from Zen context action or custom module
 * Needs to be run locally to the target unit/group.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 1] call Rev_fnc_spectator
 *
 */

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitwith
{
	playSound "FD_Start_F";
	[objNull, "No object was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
};


[true,false,true] remoteExec ["ace_spectator_fnc_setSpectator",_unit,false];
private _players = [] call CBA_fnc_players;
private _viewable = _players select {isNull (getAssignedCuratorLogic _x)};

[_viewable, [_unit]] remoteExec ["call ace_spectator_fnc_updateUnits",_unit,false];

private _string = name _unit + " promoted to spectator";
[objNull, _string] call BIS_fnc_showCuratorFeedbackMessage;