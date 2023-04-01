/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to create supply crate with items inside. Execute in scheduled environment! I.e. spawn!
 *
 * Arguments:
 * 0: Cargo plane <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_plane] spawn Rev_arty_fnc_supply_create
 *
 1.1.1
	Fixed parachute creation value to be determined by the same value as box altitude
 1.1
 	Rev_arty_sup_smoke renamed to new name Rev_arty_sup_cargo
	Box altitude is now based on value passed in Rev_arty_sup_cargo varibale
 */
 
params [
	["_plane",objNull,[objNull]]
];

////////Radio////////
if ((isMultiplayer) AND (isClass (configFile >> "CfgPatches" >> "tfar_handhelds"))) then 
{
	//Check if user has radio (needed for sideradio command)
	private _condition = {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0};
	private _initial_radio = true;
	if (_condition count assignedItems player == 0) then {
		_initial_radio = false;
		player linkItem "tf_anprc148jem";
		[{params ["_condition","_initial_radio","_killed"];_condition count assignedItems player > 0}, {[_this select 1,"Supply",_this select 2] call Rev_arty_fnc_user_completed}, [_condition,_initial_radio,false],5] call CBA_fnc_waitUntilAndExecute;
	} else {[_initial_radio,"Supply",false] call Rev_arty_fnc_user_completed};
};
/////////////////////


private _attachment = (_plane getVariable "Rev_arty_sup_cargo") select 0;
private _altitude = (_plane getVariable "Rev_arty_sup_cargo") select 1;

//Creating the box
private _box = (attachedObjects _plane) select ( (attachedObjects _plane) findIf {_x isKindOf Rev_arty_SUP_class_box});
private _pos = (getposATL _plane) getPos [15, (direction _plane) + 180];
detach _box;
_box hideObjectGlobal false;
private _vel = velocity _box;
_box setVelocity [(_vel select 0) * -0.05,(_vel select 1) * -0.05,-20];

waitUntil {(getposATL _box select 2 ) < _altitude};
private _para = createVehicle ['Steerable_Parachute_F',  [_pos select 0,_pos select 1,_altitude],[],0,'Fly'];
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