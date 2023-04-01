/*
 * Author: Reeveli 
 * Client side function to control vehicle offroad speed by creating a per-frame eventhandler
 * Called from Rev_fnc_vehicles_offRoad_init.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_fnc_vehicles_offRoad
 *
 */

private _id = [{
	private _vehicle = vehicle player;
	//Safety exits
	if (isOnRoad _vehicle) exitWith {
		_vehicle setCruiseControl [0, false];
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	(getCruiseControl _vehicle) params ["_speedLimit", "_cruiseControlActive"];
	if ((_speedLimit <= Rev_offroad_speed) AND (_speedLimit > 0)) exitWith {};

	//Set speed limiter
	_vehicle setCruiseControl [Rev_offroad_speed, false];

	//Hint for first iteration
	private _hint = missionNamespace getVariable ["Rev_vehicles_offRoad_hint",false];
	if !(_hint) then {
		hint "Poor offroad conditions limit vehicle speed";
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", true, false];
	};

	
}, 2, []] call CBA_fnc_addPerFrameHandler;


missionNamespace setVariable ["Rev_vehicles_offRoad_pfeh",_id,false];