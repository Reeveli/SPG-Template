/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Configures curator module for restricted zeus. 
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value <BOOL>
 * True if initialized first time, false if module is already prepared.
 *
 * Example:
 * [_unit] remoteExecCall ["Rev_RZ_fnc_init_server",2];
 *
 * 1.7
 *	Disabled camera editing area to enable RZ camera placement on map
 * 1.6
 *	Added setVehicleVarName for module
 * 1.5
 *	Added default value for params and safety check
 *
 * 1.4
 * 	CBA_fnc_waitAndExecute for fn_post_player
 * 	post_player neutered in case module already present
 * 	systemchat confirmation moved to post_player
 *
 * 1.3
 * 	New version to work with ZEN zeus promote module, module params removed. Module is now created here.
 * 	Variables shortened to use _tag
 * 
 * 1.2
 * 	Made setvariable global
 *
 * 1.1
 *	Moved systemchat "initialized" to isnil case fro debugging clarity
 */

params [
	["_unit",objNull,[objNull]]
];

if !(isServer) exitWith {};
if (isNull _unit) exitWith {};

//Unique name for each' players curator module
private _tag = format ["Rev_restricted_zeus_%1",name _unit];

//Create unique module if one doesn't exist
if (isNil _tag) then {

	private _group = createGroup [sideLogic,true];
	private _module = _group createUnit ["ModuleCurator_F",[0,0,0] , [], 0, ""];
	_module setVariable [_tag, true,true];
	_module setVehicleVarName _tag;
	missionNamespace setVariable [_tag,true,true];
	_unit assignCurator _module;
	_group deleteGroupWhenEmpty true;
	_module setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
	_module addCuratorAddons ["ace_zeus","zen_modules"];
	_module setCuratorCoef ["Edit", -1e10];
	_module setCuratorCoef ["Delete", -1e10];
	_module setCuratorCoef ["Destroy", -1e10];
	_module setCuratorCoef ["Synchronize", -1e10];
	_module setCuratorCoef ["Place", 0];
	//_module addCuratorEditingArea [4,[0,0,0],0];
	_module addCuratorPoints 1;
	[{params ["_unit","_module"];[_unit,_module] remoteExec ["Rev_RZ_fnc_post_player",_unit];}, [_unit,_module], 2] call CBA_fnc_waitAndExecute;
	true;
} else {
	private _module = (entities "ModuleCurator_F" select {_x getVariable [_tag ,false];}) select 0;
	unassignCurator _module;
	_unit assignCurator _module;
	["Restricted Zeus interface already existing, reconnecting player"] remoteExecCall ["systemChat",_unit];
	false;
};