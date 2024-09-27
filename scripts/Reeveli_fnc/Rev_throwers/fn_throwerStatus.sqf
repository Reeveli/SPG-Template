/*
 * Author: Reeveli
 * Part of revised rock thrower -system.
 * Function flip a rock thrower status on a unit.
 * Called from a custom ZEN module defined in scripts\Reeveli_fnc\Rev_throwers\fn_initThrowers.sqf
 *
 * Arguments:
 * 0: Throwing unit <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_unit] call Rev_fnc_throwerStatus;
 *
 */

params [
	["_unit", objNull, [objNull]]
];


//Removal
if (_unit getVariable ["Rev_thrower",false]) exitWith {
	_unit setVariable ["Rev_thrower",false,true];
	//Curator feedback
	playSound "FD_Start_F";
	[objNull, "Removed thrower"] call BIS_fnc_showCuratorFeedbackMessage;	
};

//Safety checks
if (_unit in (call CBA_fnc_players)) exitWith {
	playSound "FD_Start_F";
	[objNull, "Unable to make thrower!"] call BIS_fnc_showCuratorFeedbackMessage;
};
if !((typeOf vehicle _unit) isKindOf "CAManBase") exitWith {
	playSound "FD_Start_F";
	[objNull, "Unable to make thrower!"] call BIS_fnc_showCuratorFeedbackMessage;
};


//Promotion
[_unit] remoteExecCall ["Rev_fnc_makeThrower",2];
[objNull, "Rock Thrower Added"] call BIS_fnc_showCuratorFeedbackMessage;