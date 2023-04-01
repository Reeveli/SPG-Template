/*
 * Author: Reeveli 
 * Client side function to initialize eventhandler required for controlling vehicle offroad speed.
 * Called from CBA settings.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_fnc_vehicles_offRoad_init
 *
 */


if !(hasInterface) exitWith {};

//Remove eventhandler is setting disabled
private _mount = vehicle player;
if !(Rev_offroad_enable) exitWith {

		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_eh1",-1];
		["vehicle",_handle] call CBA_fnc_removePlayerEventHandler;

		private _handle2 = missionNamespace getVariable ["Rev_vehicles_offRoad_eh2",-1];
		["turret",_handle2] call CBA_fnc_removePlayerEventHandler;
		
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;

		//Delay to account for any ongoing pfeh
		[{(_this # 0) setCruiseControl [0, false]}, [_mount], 3] call CBA_fnc_waitAndExecute;
};


//Initial checks incase a player is in a vehicle when the settings is changed
if ((driver _mount isEqualTo player) AND (_mount isKindOf "LandVehicle") AND !(getNumber (configFile >> "CfgVehicles" >> typeof _mount >> "preferRoads") isEqualTo 0)) then {
	[] call Rev_fnc_vehicles_offRoad;
};




//Eventhandlers
private _id = ["vehicle", {
	params ["_player","_newVehicle","_oldVehicle"];	

	if !(driver _newVehicle isEqualTo player) exitWith {
		_newVehicle setCruiseControl [0, false];
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	if !(_newVehicle isKindOf "LandVehicle") exitWith {
		_newVehicle setCruiseControl [0, false];
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	if (getNumber (configFile >> "CfgVehicles" >> typeof _newVehicle >> "preferRoads") isEqualTo 0) exitWith {
		_newVehicle setCruiseControl [0, false];
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	[] call Rev_fnc_vehicles_offRoad

}] call CBA_fnc_addPlayerEventHandler;


private _id2 = ["turret", {
	params ["_player","_newPos","_oldPos"];
	private _newVehicle = vehicle player;

	if !(driver _newVehicle isEqualTo player) exitWith {
		_newVehicle setCruiseControl [0, false];
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	if !(_newVehicle isKindOf "LandVehicle") exitWith {
		_newVehicle setCruiseControl [0, false];
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	if (getNumber (configFile >> "CfgVehicles" >> typeof _newVehicle >> "preferRoads") isEqualTo 0) exitWith {
		_newVehicle setCruiseControl [0, false];
		private _handle = missionNamespace getVariable ["Rev_vehicles_offRoad_pfeh",-1];
		[_handle] call CBA_fnc_removePerFrameHandler;
		missionNamespace setVariable ["Rev_vehicles_offRoad_hint", false, false];
	};

	[] call Rev_fnc_vehicles_offRoad

}] call CBA_fnc_addPlayerEventHandler;

missionNamespace setVariable ["Rev_vehicles_offRoad_eh1",_id,false];
missionNamespace setVariable ["Rev_vehicles_offRoad_eh2",_id2,false];