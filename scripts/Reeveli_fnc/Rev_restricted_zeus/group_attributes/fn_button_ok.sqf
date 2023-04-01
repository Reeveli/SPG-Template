/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Button-press function for exit group attributes dialog. Only run when dialog is open.
 *
 * Arguments: <NONE>
 *
 * Return Value <NONE>
 *
 * Example:
 *	call Rev_RZ_fnc_button_ok
 *
 */

private _group = (findDisplay 5050) getVariable "Rev_RZ_group";

private _formation= (findDisplay 5050) getVariable "Rev_RZ_group_formation";
[[_group], _formation] call zen_context_actions_fnc_setFormation;

private _behaviour = (findDisplay 5050) getVariable "Rev_RZ_group_behaviour";
[[_group], _behaviour] call zen_context_actions_fnc_setBehaviour;

private _mode= (findDisplay 5050) getVariable "Rev_RZ_group_mode";
[[_group], _mode] call zen_context_actions_fnc_setCombatMode;

private _speed = (findDisplay 5050) getVariable "Rev_RZ_group_speed";
[[_group], _speed] call zen_context_actions_fnc_setSpeedMode;

private _pos = (findDisplay 5050) getVariable "Rev_RZ_group_pos";
[units _group, _pos] call zen_context_actions_fnc_setStance;


closeDialog 1;

