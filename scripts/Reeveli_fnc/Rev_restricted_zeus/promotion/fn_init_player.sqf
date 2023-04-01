/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Client side function that initializes the restricted zeus interface.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value <BOOL>
 * False if not run
 *
 * Example:
 * [player] call Rev_RZ_fnc_init_player;
 *
 * 2.3
 *	CBA_state_machines are now integral part, not called as a function
 *	New safety check is player is already RZ (in case of douple promotions)
 *
 * 2.2
 *	Added default value for params and safety check
 *
 * 2.1
 * 	Removed waituntill
 *
 * 2.0
 * 	Removed all references to _module param
 * 	Half of function moved to fn_post_player to account for module being present
 */

params [
	["_unit",objNull,[objNull]]
];


if !(hasInterface) exitWith {false};
if !(local _unit) exitWith {false};
if (isNull _unit) exitWith {false};
//Safety check if already promoted
if (player getVariable ["Rev_restricted_curator",false]) exitWith {
	playSound "FD_Start_F";
	hintSilent "You cannot be promoted to Restricted Zeus as you already are one!";
	false;
};

//Warning if ACE of ZEN is missing
if !(isClass (configFile >> "CfgPatches" >> "zen_context_menu")) exitWith {
	playSound "FD_Start_F";
	hintSilent "ZEN -mod not detected, Restricted Zeus unavailable!";
};
if !(isClass (configFile >> "CfgPatches" >> "ace_common")) exitWith {
	playSound "FD_Start_F";
	hintSilent "ACE 3 -mod not detected, Restricted Zeus unavailable!";
};

//TFAR curator hearing set here as well for safety
missionNamespace setVariable ['TFAR_curatorCamEars',false];

//CBA statemachine
Resticted_Zeus_Machine = [[player]] call CBA_statemachine_fnc_create;

[Resticted_Zeus_Machine, {}, {{_x hideObject false;} forEach (allUnits + vehicles)}, {}, "NormalView"] call CBA_statemachine_fnc_addState;
[Resticted_Zeus_Machine, {}, {["RZ_update",[]] call CBA_fnc_localEvent;}, {}, "CuratorView"] call CBA_statemachine_fnc_addState;
[Resticted_Zeus_Machine, "NormalView", "CuratorView", {!isNull findDisplay 312}] call CBA_statemachine_fnc_addTransition;
[Resticted_Zeus_Machine, "CuratorView", "NormalView", {isNull findDisplay 312}, {}] call CBA_statemachine_fnc_addTransition;

[Resticted_Zeus_Machine, {}, {{_x hideObject false;} forEach (allUnits + vehicles)}, {}, "NumEnterView"] call CBA_statemachine_fnc_addState;
[Resticted_Zeus_Machine, "CuratorView", "NumEnterView", {cameraOn != vehicle player}, {}] call CBA_statemachine_fnc_addTransition;
[Resticted_Zeus_Machine, "NumEnterView", "CuratorView", {cameraOn == vehicle player && {!isNull findDisplay 312}}, {}] call CBA_statemachine_fnc_addTransition;
[Resticted_Zeus_Machine, "NumEnterView", "NormalView", {isNull findDisplay 312}, {}] call CBA_statemachine_fnc_addTransition;

//start server side
[_unit] remoteExecCall ["Rev_RZ_fnc_init_server",2];
true;