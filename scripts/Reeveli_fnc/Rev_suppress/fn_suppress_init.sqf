/*
 * Author: Reeveli 
 * Part of Reeveli's Suppressive fire system.
 * Global function to create the necessary CBA eventhandler to be present on all possible clients + server.
 * Called as a post-init function.
 *
 * Arguments: NONE
 *
 * Example:
 * call Rev_fnc_suppress_init
 *
 */

private _id = ["Rev_suppression_event", {
	params ["_group","_target"];
	private _units = units _group;

	if !(alive _target) exitWith {_group setVariable ["Rev_suppression",nil,true];};
	if (isNull _group) exitWith {deleteVehicle _target};
	if (({alive _x} count units _group) < 1) exitWith {deleteVehicle _target;_group setVariable ["Rev_suppression",nil,true];};
	private _group = _target getVariable ["Rev_suppression_units", grpNull];

	private _dir = (leader _group) getDir _target;
  	_group setFormDir _dir;
	
	{ 
		private _vehicle = (vehicle _x);
		_vehicle setEffectiveCommander (gunner _vehicle);
		_vehicle setVehicleAmmo 1;
		_x doSuppressiveFire _target;
	} forEach _units;

	[{["Rev_suppression_event", _this, _this # 0] call CBA_fnc_targetEvent;}, [_group,_target], 3] call CBA_fnc_waitAndExecute;

}] call CBA_fnc_addEventHandler;