/*
 * Author: Reeveli
 * Client side function to ACE injure a unit. Has to be run locally to the unit being injured. Called from Rev_fnc_injury
 *
 * Arguments:
 * 0: Unit being injured <OBJECT>
 * 1: Injury type <STRING> (default: "bullet")
 * 2: List of damage values <ARRAY> (default: [0,0,0,0,0,0,0,6,false])
 *
 * Return Value: NONE
 *
 * Example:
 * [_unit,_injury_type,_injury_value_list] remoteExec ["Rev_fnc_set_ACE_injury",_unit]
 *
 1.1
	Added default params, safety exit
 */

params [
	["_unit", objNull, [objNull]],
	["_injury_type","bullet",[""]],
	["_injury_value_list",[0,0,0,0,0,0,0,6,false],[[]],[9]]
];

if (isNull _unit) exitWith {};

(_injury_value_list select [6,3]) params ["_pain","_blood_pressure","_unconscious"];

{
	private _value = _injury_value_list select _forEachIndex;
	[_unit, _value, _x, _injury_type] call ace_medical_fnc_addDamageToUnit;
} forEach ["head", "body", "hand_r", "hand_l","leg_r", "leg_l"];

_unit setVariable ["ace_medical_pain", _pain, true];
_unit setVariable ["ace_medical_bloodVolume", _blood_pressure, true];
[_unit, _unconscious, 10e10, true] call ace_medical_fnc_setUnconscious;