/*
 * Author: Reeveli, Killet 
 * Part of revised rock thrower -system.
 * SERVER SIDE function to create the necessary CBA loop for a thrower. Intended starting point of the system.
 * REQUIRES CANS -- Civilian Throwables {Cans stones Bottles} -MOD!
 *
 * Arguments:
 * 0: Throwing unit <OBJECT>
 *
 * Return Value: <BOOL>
 *
 * Example:
 * [this] call Rev_fnc_makeThrower
 *
 */

params [
	["_unit", objNull, [objNull]]
];

if !(isClass (configFile >> "CfgPatches" >> "JNS_CANS")) exitWith {false};
if !(isServer) exitWith {false};

_unit setVariable ["Rev_thrower",true,true];
["Rev_throwCheck", [_unit]] call CBA_fnc_serverEvent;
true;