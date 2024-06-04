/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Configures restricted zeus interface for player. 
 * Called from Rev_RZ_fnc_init_player
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Curator Module <OBJECT>
 *
 * Return Value <NONE>
 *
 * Example:
 * [_unit,_module] remoteExec ["Rev_RZ_fnc_post_player",_unit];}, [_unit,_module];
 *
 * 1.7.1
 *	Updated header
 *
 * 1.7
 * 	Removed call Rev_RZ_fnc_state_machine fom RZ reconnect ACE action (function doesn't exists, was a legacy feature)
 *	Main CBA EH id is now stored in uiNamespace variable, deletion index is now defined via it
 * 1.6
 *	Added new eventhadler to delete placed units (part of solution for map camera problem)
 * 1.5
 * 	Locality safety feature made toggleable from CBA options to investigate network problems..
 * 1.4
 *	Disabled flashlight and IR laser modules due to their global effect. Might do custom ports of these modules later if needed.
 * 1.3
 *	missionvaribale RZ_update was being set every frame, not on Eh init as was supposed to
 * 1.2
 *	Context action are now #included not called as a function
 *	
 * 1.1
 *	Added internal comments
 *	Added alive condition for main CBA event
 */

params [
	["_unit",objNull,[objNull]],
	["_module",objNull,[objNull]]
];

if !(hasInterface) exitWith {};
if (isNull _unit) exitWith {};
if (isNull _module) exitWith {};

//Notification so player is aware of promotion
["CuratorAssign",["Restricted Zeus",name player]] call BIS_fnc_showNotification;

//Ace self-interaction for reactivation after respawn, bugs etc.
private _action = [
	"RZ",
	"Reconnect RZ",
	"\a3\ui_f_curator\Data\Logos\arma3_curator_eye_64_ca.paa",    
	{
		params ["_unit","_module"];
		[_unit,_module] remoteExecCall ["Rev_RZ_fnc_init_server",2];
	},
	{true},
	{},
	[_unit,_module]
	] call ace_interact_menu_fnc_createAction;     
["CAManBase", 1, ["ACE_SelfActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;




//Managing ZEN context actionKeysNames
#include "context_action.hpp"

//Set player local variable that can be used to track if player is RZ.
//This varibale is NOT unssigned anywhere at the time of writing so it will remin for the game session.
player setVariable ["Rev_restricted_curator",true];

//Remove all custom ZEN curator modules
zen_custom_modules_modulesList resize 0;

//Enabling only selected curator modules
_module removeAllEventHandlers "CuratorObjectRegistered";
_module addEventHandler [
	"CuratorObjectRegistered",
	{
		params ["_curator", "_input"];
		[_curator,[-1,-2]] call BIS_fnc_setCuratorVisionModes;
		[player,Resticted_Zeus_Machine, "NormalView", "CuratorView", {}] call CBA_statemachine_fnc_manualTransition;

		private _allowed_modules = [
			"zen_modules_moduleConvoyParameters",
			"zen_modules_moduleCreateTarget",
			"zen_modules_moduleCrewToGunner",
			"zen_modules_moduleFlyHeight",
			"zen_modules_modulePatrolArea",
			"zen_modules_moduleSearchBuilding",
			//"zen_modules_moduleSuicideBomber",
			"zen_modules_moduleSuppressiveFire",
			"zen_modules_moduleFireMission",
			//"zen_modules_moduleToggleFlashlights",
			//"zen_modules_moduleToggleIRLasers",
			"ace_zeus_moduleSuppressiveFire",
			"ace_zeus_moduleGarrison",
			"ace_zeus_moduleUnGarrison"
		];
		private _classes = _this select 1;
		private _costs = [];
		{
			private _cost = if (_x in _allowed_modules) then {[true,0]} else {[false,1]};
			_costs pushBack _cost;
		} forEach _classes; // go through all classes and assign cost for each of them
		_costs
	}
];

//Preventing use of group view, use custom one instead
_module removeAllEventHandlers "CuratorGroupDoubleClicked";
_module addEventHandler ["CuratorGroupDoubleClicked", { 
	params ["_curator", "_group"];
	(findDisplay -1) closeDisplay 2;
	createDialog "Rev_RZ_group_attributes";
	[_group] call Rev_RZ_fnc_group_dialog;
}];

//Preventing use of unit view, custom dialog for vehicles
_module removeAllEventHandlers "CuratorObjectDoubleClicked";
_module addEventHandler ["CuratorObjectDoubleClicked", { 
	params ["_curator", "_entity"];
	(findDisplay -1) closeDisplay 2;
	if ((_entity isKindOf "LandVehicle") OR (_entity isKindOf "Air") OR (_entity isKindOf "Ship")) then {
		createDialog "Rev_RZ_vehicle_attributes";
		[_entity] call Rev_RZ_fnc_vehicle_dialog;
	};
}];

//Preventing placements of markers
_module removeAllEventHandlers "CuratorMarkerPlaced";
_module addEventHandler ["CuratorMarkerPlaced", {
	params ["_curator", "_marker"];
	deleteMarker _marker;
}];


//Optional locality safety in MP
_module removeAllEventHandlers "CuratorGroupSelectionChanged";
_module addEventHandler ["CuratorGroupSelectionChanged", {
	params ["_curator", "_group"];
	if (isMultiplayer && Rev_RZ_locality) then {
		if (local _group && !(player in (units _group))) then {
			[_group, 2] remoteExec ["setGroupOwner",2];
			systemChat format ["Group: %1 ownership transferred to server. Units cannot be local to curator!",_group];
		};
	};
}];

//EH to prevent placing/copying units other than logics
_module addEventHandler ["CuratorObjectPlaced", {
	params ["_curator", "_entity"];
	if !(_entity isKindOf "Logic") exitWith {{deleteVehicle _x} forEach crew _entity; deleteVehicle (vehicle _entity);deleteVehicle _entity};
}];

//Function to check if a unit being remote controlled by another curator
fnc_check_control = {
	params ["_unit"];
	private _controlled = false;
	private _name = "";
	private _tempOwner = _unit getvariable ["bis_fnc_moduleRemoteControl_owner", objnull];
    if (!isnull _tempOwner && {_tempOwner in call CBA_fnc_players}) then {_controlled = true; _name = name _tempOwner};

	[_controlled,_name];
};

//Removing old EH is present, changing roles in lobby or other instances
["RZ_update", uiNameSpace getVariable ["Rev_RZ_EH",-1]] call CBA_fnc_removeEventHandler;

//Where the magic happens, addCuratorCameraArea line can be commented out to enable free flying camera
private _id = ["RZ_update", {
	private _module = (entities "ModuleCurator_F" select {_x getVariable [format ["Rev_restricted_zeus_%1",name player],false];}) select 0;	
	//[_module,[3,getpos player,100]] remoteExecCall ["addCuratorCameraArea",2];	
	private _state = [player, Resticted_Zeus_Machine] call CBA_statemachine_fnc_getCurrentState;
	switch (_state) do {
		case "NormalView": {{_x hideObject false;} forEach (allUnits + vehicles + allDead)};

		case "NumEnterView": {{_x hideObject false;} forEach (allUnits + vehicles + allDead)};

		case "CuratorView": {	
			{
				if (((_x getVariable ["RZ_allowed_edit", false]) OR ((vehicle _x) getVariable ["RZ_allowed_edit", false])) AND (alive _x)) then {
					[_module,[[_x],true]] remoteExecCall ["addCuratorEditableObjects",2];
					_x hideObject false;
					private _curator = ([_x] call fnc_check_control) select 0;
					private _name = ([_x] call fnc_check_control) select 1;

					if (_curator) then 
						{
						drawIcon3D [
							"\a3\ui_f_curator\Data\Logos\arma3_curator_eye_64_ca.paa",
							[1,1,1,1],
							_x modelToWorldVisual [0,0,2],
							1,
							1,
							0,
							_name,
							0,
							0.03,
							"RobotoCondensed"
							];
						}
				} else {
					[_module,[[_x],true]] remoteExecCall ["removeCuratorEditableObjects",2];
					_x hideObject false;
					if !(side _x == side player) then {_x hideObject true;};				
				};
			} forEach (allUnits + vehicles + allDead);					
    		
		};
	};

}] call CBA_fnc_addEventHandler;

//Storing id for future removal if necessary
uiNameSpace setVariable ["Rev_RZ_EH",_id,false];

//Variable check if the EachFrame Eh has been added on this session
if !(missionNamespace getVariable ["RZ_update",false]) then
{
	missionNamespace setVariable ["RZ_update",true,false];
	addMissionEventHandler ["EachFrame", {
		["RZ_update",[]] call CBA_fnc_localEvent;
	}];
};
