/*
 * Author: Reeveli
 * Function to fully heal a player with GUI indication and custom sound. Does NOT have to be run locally to the unit being healed!
 *
 * Arguments:
 * 0: Unit being healed <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_target] call Rev_fnc_heal
 *
 1.1
	Added default param, safety exit
 */

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {diag_log "Rev_fnc_heal: No unit params passed!";};

//AI check
private _players = call CBA_fnc_players;

if !(_unit in _players) exitWith {};

private _condition = false;
fnc_condition_check = {
	private _bleeding = _this select 0 call ace_medical_blood_fnc_isBleeding;
	private _blood_pressure = _this select 0 call ace_medical_status_fnc_getBloodPressure;
	private _diastolic = (_blood_pressure select 0 !=80) OR (_blood_pressure select 1 !=120);
	private _fractures = _this select 0 call ACE_medical_ai_fnc_isInjured;

	if (_bleeding OR _diastolic OR _fractures) then {_condition = true} else {_condition = false};
};

[_unit] call fnc_condition_check;

if (_condition) then {
	["Rev_heal"] remoteExec ["playsound", _unit];

	["scripts\Reeveli_fnc\Rev_medical\heal.paa", [1.3,-0.23,0.4,0.5],[10,10],2] remoteExec ["BIS_fnc_textTiles", _unit];
	//["scripts\Reeveli_fnc\Rev_medical\apothecarium4.paa", [0,0,1,1],5,2] spawn BIS_fnc_textTiles;
	[true, 45] remoteExec ["ace_medical_feedback_fnc_effectPain",_unit];
	};

[objNull, _unit] remoteExec ["ace_medical_treatment_fnc_fullHeal",_unit];
_unit setDamage 0;