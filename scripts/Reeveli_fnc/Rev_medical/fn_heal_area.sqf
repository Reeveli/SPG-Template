/*
 * Author: Reeveli
 * Client side function to start area healing operation.
 *
 * Arguments:
 * 0: Unit doing the area healing <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_target] call Rev_fnc_heal_area
 *
 1.1
	Added default param, safety exit
 */


params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {diag_log "Rev_fnc_heal_area: No unit params passed!";};

private _allPlayers = call CBA_fnc_players select {alive _x};
private _inArea = _allPlayers select {(_x distance _unit) < 12};

fnc_condition_check = {
	private _bleeding = _this select 0 call ace_medical_blood_fnc_isBleeding;
	private _blood_pressure = _this select 0 call ace_medical_status_fnc_getBloodPressure;
	private _diastolic = (_blood_pressure select 0 !=80) OR (_blood_pressure select 1 !=120);
	private _fractures = _this select 0 call ACE_medical_ai_fnc_isInjured;

	if (_bleeding OR _diastolic OR _fractures) then {true} else {false};
};

private _patients = _inArea select {[_x] call fnc_condition_check;};

if ((count _patients) == 0 ) exitWith {hintSilent "No patients to treat in radius"};

private _success = {		
  params ["_patients"];
  {[_x] call Rev_fnc_heal;} forEach _patients;
};

private _time = 3 * (count _patients);
private _enemySides = [side _unit] call BIS_fnc_enemySides;
private _radius = 500;
private _nearEnemies = allUnits select {_x distance player < _radius AND side _x in _enemySides};
if (count _nearEnemies > 1) then {_time = _time + 15};

[_time, _patients, _success, {hint "Operation canceled"}, "Treating: " + ((_patients apply {name _x}) joinString ",")] call ace_common_fnc_progressBar;