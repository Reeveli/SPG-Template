
/*
 * Author: Reeveli
 * Part of SPG admin console, preinit function to prepare necessary preinit module for something in CBA not to break. Module is used for admin access via the admin console.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call Rev_fnc_admin_preinit
 *
 1.2
	Added EH to make all units editable when entering the interface
 1.1
	setVehicleVarName is now remote executed for all machines
	Added rpt dumb for debugging
 */

if !(isServer) exitWith {};

private _group = createGroup sideLogic;
_group deleteGroupWhenEmpty true;

private _module = _group createUnit ["ModuleCurator_F",[0,0,0] , [], 0, ""];
_module setVariable ["Rev_curator","admin",true];
[_module,"Rev_curator_admin"] remoteExecCall ["setVehicleVarName", 0];
diag_log "Rev_fnc_admin_preinit: Serverside admin module created";

_module setVariable ["Addons", 3, true];
_module setVariable ["BIS_fnc_initModules_disableAutoActivation", false];
_module setCuratorCoef ["Place", 0];
_module setCuratorCoef ["Delete", 0];
_group deleteGroupWhenEmpty true;        
_module addEventHandler ["CuratorObjectRegistered", {
	params ["_curator", "_input"];
	_curator addCuratorEditableObjects [vehicles+allunits];
}];

//addons if used in singleplayer (i.e. testing from editor)
if (!isMultiplayer) then {
	private _addons = ('true' configClasses (configFile >> "CfgPatches")) apply {configName _x};
	activateAddons _addons;
	removeAllCuratorAddons _module;
	_module addCuratorAddons _addons;
};