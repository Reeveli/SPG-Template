/*
 * Author: Reeveli, Killet 
 * Part of revised rock thrower -system.
 * Function to handle actual throwing action.
 * Called from Rev_fnc_initThrowers 
 *
 * Arguments:
 * 0: Throwing unit <OBJECT>
 * 1: Target unit <OBJECT>
 *
 * Return Value: BOOL
 *
 * Example:
 * [_unit, player] call Rev_fnc_throwRock;
 *
 */

params [
	["_unit", objNull, [objNull]],
	["_target", objNull, [objNull]]
];

if !(isClass (configFile >> "CfgPatches" >> "JNS_CANS")) exitWith {false};
if !(_unit getVariable ["Rev_thrower",false]) exitWith {false};
private _group = group _unit;
_group setCombatMode "BLUE";
_group setBehaviour "SAFE";

_unit doTarget vehicle _target;
//stances are a bit wonky but provide the intended effetc, not just static dudes
_unit playAction "PlayerCrouch";
_unit playAction "PlayerStand"; 

[{ 
	_this #0 addItemToUniform "ROCK_MAG";
	[_this #0, "Rock_Muzzle"] call BIS_fnc_fire; 
}, [_unit], 2] call CBA_fnc_waitAndExecute;

true;
