/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Function to configure custom group attributes window for restricted zeus. Run only after dialog has been created.
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value <NONE>
 *
 * Example:
 *	createDialog "Rev_RZ_group_attributes";
 *	[_group] call Rev_RZ_fnc_group_dialog;
 *
 */

params [
	["_group",grpNull,[grpNull]]
];

if !(hasInterface) exitWith {};
if (isNull _group) exitWith {};

//Set varibales for dialog
(findDisplay 5050) setVariable ["Rev_RZ_group",_group];

private _formation = formation _group;
(finddisplay 5050) setVariable ["Rev_RZ_group_formation",_formation];

private _behaviour = behaviour (leader _group);
(finddisplay 5050) setVariable ["Rev_RZ_group_behaviour",_behaviour];

private _mode = combatMode _group;
(finddisplay 5050) setVariable ["Rev_RZ_group_mode",_mode];

private _formation = formation _group;
(finddisplay 5050) setVariable ["Rev_RZ_group_formation",_formation];

private _speed = speedMode _group;
(finddisplay 5050) setVariable ["Rev_RZ_group_speed",_speed];

private _pos = unitPos (leader _group);
(finddisplay 5050) setVariable ["Rev_RZ_group_pos",_pos];

//Set control text
private _name = groupId _group;
ctrlSetText [5051,_name];

//False call to init colors
[5,0] call Rev_RZ_fnc_group_button;