/*
 * Author: Reeveli 
 * Part of Zeus resupply system.
 * Client side function to handle the resupply box detaching and attachments.
 * Cannot be run as its onw function, need varibales defined earlier in the system.
 *
 * Arguments:
 * 0: Plane <OBJECT> (default: objNull)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_plane] spawn Rev_fnc_resupply_drop;
 *
 */

params [
	["_plane",objNull,[objNull]]
];

private _attachment = uiNamespace getVariable ["Rev_arty_supply_call",[]];
private _box_class = (uiNamespace getVariable ["Rev_arty_supply_box",[]]) select 1; 

//Detaching the box
private _box = (attachedObjects _plane) select ( (attachedObjects _plane) findIf {_x isKindOf _box_class});
private _pos = (getposATL _plane) getPos [15, (direction _plane) + 180];
detach _box;
_box hideObjectGlobal false;
private _vel = velocity _box;
_box setVelocity [(_vel select 0) * -0.05,(_vel select 1) * -0.05,-30];

waitUntil {(getposATL _box select 2 ) < 50};
private _para = createVehicle ['Steerable_Parachute_F',  [_pos select 0,_pos select 1,50],[],0,'Fly'];
_para setPosATL (getposATL _box);
private _vel = velocity _para;
_para setVelocity [
	(_vel select 0), 
	(_vel select 1), 
	20
];
_box attachto [_para,[0,0,0]];


//Box attachements
if !(_attachment isEqualTo "None") then {
	private _smoke1 = _attachment createVehicle [0,0,0];
	_smoke1 attachto [_box,[0,0,0]];
	
};

//Deleting variables
uiNamespace setVariable ["Rev_arty_supply_call", nil];
uiNamespace setVariable ["Rev_arty_supply_box", nil];  

waitUntil {(getposATL _box select 2 )< 3};
detach _box;
{
	if (_x isKindOf _attachment) then {deleteVehicle _x};
} forEach attachedObjects _box;


//Second attachment once the box hits the ground
if !(_attachment isEqualTo "None") then {
	private _smoke3 = _attachment createVehicle [0,0,0];
	_smoke3 attachto [_box,[0,0,0]];
	private _remove_smoke =	
	["Rev_supply_smoke", "Remove Attachment", "\x\zen\addons\modules\ui\smoke_pillar_ca.paa",
	{
		params ["_target", "_player", "_params"];
		deleteVehicle (_params select 0);[_target,0,["ACE_MainActions","Rev_supply_smoke"]] remoteExecCall ["ace_interact_menu_fnc_removeActionFromObject",0,true];
	},{true},{},[_smoke3]] call ace_interact_menu_fnc_createAction;
	
	[_box, 0, ["ACE_MainActions"], _remove_smoke] remoteExecCall ["ace_interact_menu_fnc_addActionToObject",0,true];
};