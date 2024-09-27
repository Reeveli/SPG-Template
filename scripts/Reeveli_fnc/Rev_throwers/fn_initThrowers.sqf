/*
 * Author: Reeveli, Killet 
 * Part of revised rock thrower -system.
 * Server side function to create the necessary CBA eventhandler.
 * Called as a pre-init function.
 * REQUIRES CANS -- Civilian Throwables {Cans stones Bottles} -MOD!
 *
 * Arguments: NONE
 *
 * Return Value: <BOOL>
 *
 * Example:
 * call Rev_fnc_initThrowers
 *
 */


if !(isClass (configFile >> "CfgPatches" >> "JNS_CANS")) exitWith {false};

//Zeus modules
if (isClass (configFile >> "CfgPatches" >> "zen_custom_modules")) then {
	["Reeveli's ZEN Modules", "Toggle rock thower", {[_this select 1] call Rev_fnc_throwerStatus;},"CAN\pic_rocks_ca.paa"] call zen_custom_modules_fnc_register;
};

private _throwCheck = ["Rev_throwCheck", {
	params [["_unit", objNull, [objNull]]];
	if (isNull _unit) exitWith {};
	if !(alive _unit) exitWith {};
	if !(_unit getVariable ["Rev_thrower",false]) exitWith {};
	
	if (vehicle _unit != _unit) exitWith {
		[{["Rev_throwCheck", [_this # 0]] call CBA_fnc_serverEvent;}, [_unit], random [7, 10, 15]] call CBA_fnc_waitAndExecute;
	};

	if (surfaceIsWater position _unit) exitWith {
		[{["Rev_throwCheck", [_this # 0]] call CBA_fnc_serverEvent;}, [_unit], random [7, 10, 15]] call CBA_fnc_waitAndExecute;
	};
	
	private _players = [] call CBA_fnc_players;
	private _inRange = [];
	{
		if ((_x distance _unit) < 20) then {_inRange pushBackUnique _x};
	} foreach _players;

	if (count _inRange > 0) then {
		[_unit, selectRandom _inRange] call Rev_fnc_throwRock;
	};
	[{["Rev_throwCheck", [_this # 0]] call CBA_fnc_serverEvent;}, [_unit], random [7, 10, 15]] call CBA_fnc_waitAndExecute;

}] call CBA_fnc_addEventHandler;


private _removal = ["Rev_removeThrower", {
	params [["_unit", objNull, [objNull]]];
	_unit setVariable ["Rev_thrower",false];
}] call CBA_fnc_addEventHandler;












true;