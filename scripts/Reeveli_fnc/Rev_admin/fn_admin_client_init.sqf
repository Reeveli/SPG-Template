/*
 * Author: Reeveli
 * Part of SPG admin console, creates curator module if client is whitelisted
 * Called as a postinit function
 *
 * Arguments:
 * NONE
 *
 * Return: <BOOL>
 *	True: Curator module created
 *	False: Curator module not created
 *
 * Example:
 * call Rev_fnc_client_init
 *
 1.1.1
	Whitelist condition changed to use SPG option one
 1.1
	Added EH to make all units editable when entering the interface
 */


//Exit if not whitelisted
if !(getPlayerUID player in KLT_allowed_curators) exitWith {

	diag_log "Rev_fnc_client_init: Player not whitelisted, curator module not created";
	false;
};

//Exit if module exists
if (((entities "ModuleCurator_F") findIf {_x getVariable ["Rev_curator",""] isEqualTo name player}) > -1) exitWith {
	
	diag_log "Rev_fnc_client_init: Player curator module already exists";
	false;
};

//Create new module for player
private _group = createGroup sideLogic;
_group deleteGroupWhenEmpty true;
private _module = _group createUnit ["ModuleCurator_F",[0,0,0] , [], 0, ""]; 
_module setVariable ["Rev_curator",name player,true];

//Setting module vehicle var name for debugging
[_module,format ["Rev_curator_%1",name player]] remoteExecCall ["setVehicleVarName", 0];

//EH for editable objects        
_module addEventHandler ["CuratorObjectRegistered", {
	params ["_curator", "_input"];
	_curator addCuratorEditableObjects [vehicles+allunits];
}];


diag_log "Rev_fnc_client_init: Player whitelisted, curator module created";
true;