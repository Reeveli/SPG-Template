/*
 * Author: Reeveli
 * Part of SPG admin console, server side process for promoting player to curator. CBA event is defined in fn_admin_init
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Promotion <BOOL> (default: true), false for demotion
 * 2: Player admin state <BOOL> (default: false)
 *
 * Return Value:
 * NONE
 *
 * Example:
 * ["Rev_admin_toggle_zeus", [player, false, true]] call CBA_fnc_serverEvent;
 *
 1.2
	Demotion rewritten to avoid admin being demoted every time
 1.1
	Changes to how curator module is selected in case NON admin promotion:
		Modules are tagged with player names, not UIDs to avoid false negatives
 */


if !(isServer) exitWith {};

params [
	["_unit",objNull,[objNull]],
	["_enableZeus",true,[true]],
	["_isAdmin",false,[true]]
];


//Demotion
if !(_enableZeus) exitWith {

	if (_isAdmin) then {
		//admin module demotion
		{
			if (_x getVariable ["Rev_curator",""] isEqualTo "admin") exitWith {
				unassignCurator _x;
			};
		} forEach (entities "ModuleCurator_F");
	} else {		
		//personal module demotion
		{
			if (_x getVariable ["Rev_curator",""] isEqualTo (name _unit)) exitWith {
				unassignCurator _x;
			};
		} forEach (entities "ModuleCurator_F");
	};
	//Notification of demotion in all cases
	["CuratorUnassign",["Admin Zeus"]] remoteExec ["BIS_fnc_showNotification",_unit];
};

//Promotion
if (_isAdmin) then {
	private _index = (entities "ModuleCurator_F") findIf {_x getVariable ["Rev_curator",""] isEqualTo "admin"};
	private _module = (entities "ModuleCurator_F") select _index;
	unassignCurator _module;
	_unit assignCurator _module;
	_module addCuratorEditableObjects [vehicles+allunits];
	["CuratorAssign",["Admin Zeus",name _unit]] remoteExec ["BIS_fnc_showNotification",_unit];
} else {	
	private _index = (entities "ModuleCurator_F") findIf {_x getVariable ["Rev_curator",""] isEqualTo name _unit};
	private _module = (entities "ModuleCurator_F") select _index;
	unassignCurator _module;
	_unit assignCurator _module;
	_module addCuratorEditableObjects [vehicles+allunits];
	["CuratorAssign",["Admin Zeus",name _unit]] remoteExec ["BIS_fnc_showNotification",_unit];
};

