/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system.
 * Sets combat mode of nearby groups to combat when under artillery fire.
 *
 * Arguments:
 * 0: Position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [getPosATL _this] call Rev_arty_fnc_react
 *
 1.2
	Behaviour is now set via ZEN function
	Changed _pos default param
 1.1
	Possible fix for wrong remoteexec bug
 */

params [
	["_pos",[0,0,0],[[]],[2,3]]
];

private _list = allGroups select {((leader _x) distance _pos) < 50};
[_list, "COMBAT"] call zen_context_actions_fnc_setBehaviour;