/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Function to create the ordered supplies and the plane to drop them. Arguments are provided by varibales created by the system earlier.
 *
 * Arguments: <NONE>
 *
 * Return Value: NONE
 *
 * Example:
 * [] spawn Rev_arty_fnc_supply_transport
 *
 1.3.1
	Adjusted box attchment point to avoid collisions with some planes
		Old [0,0,-5]
		New [0,10,-10]	
 1.3
	_altitude param default value increased to 300
	plane flying altutude now fixed to 300
	Varibale 'Rev_arty_sup_smoke' renamed to 'Rev_arty_sup_cargo'
		Value is now array, altitude included
 1.2
	BIS_fnc_dirTo replaced with getDir
 1.1
	Plane crew now made captive to adress issues with some RHS radars
 */
 
private _args = player getVariable "Rev_arty_sup_call";

_args params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_attachment","None",[""]],
	["_altitude",300,[0]],
	["_start_pos",[0,0,0],[[]],[2,3]]
];

player setVariable ['Rev_arty_sup_call',nil];

private _class = Rev_arty_SUP_class;

//Update ammo amount to server
["Rev_arty_SUP_regen",[1]] call CBA_fnc_serverEvent;


//Generate params for plane
private _direction = _start_pos getDir _pos;

//End pos
private _fin_pos = _pos getPos [3000,_direction];

//Creating the plane
private _plane = [[_start_pos select 0,_start_pos select 1,300], _direction,_class, side player] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;
private _group = _plane select 2;
_plane_vehicle setPosATL [getPosATL _plane_vehicle select 0, getPosATL _plane_vehicle select 1, 300];
_group setcombatmode "BLUE";
_group setBehaviour "AWARE";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;
{_x setCaptive true} forEach units _group;
_plane_vehicle flyInHeight 300;

_vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin _direction * 120), 
	(cos _direction * 120), 
	(_vel select 2)
];

_plane_vehicle setVariable ['Rev_arty_sup_cargo',[_attachment,_altitude]];

/////Box/////////////
private _box = Rev_arty_SUP_class_box createVehicle [0,0,0];
_box allowdamage false;
clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;
_box attachto [_plane_vehicle,[0,10,-10]];
_box hideObjectGlobal true;

private _list = uiNamespace getVariable ["Rev_supply_list",[]];

private ["_config","_amount"];
{
	_config = _x select 0;
	_amount = (_list select (_list findIf {(_config isEqualto (_x select 0)) OR (_config isEqualto toUpperANSI (_x select 0))})) select 1;

	if (getNumber (configFile >> "CfgVehicles" >> _config >> "isBackpack") == 1) then {
		_box addBackpackCargoGlobal [_config, _amount];
	} else {_box addItemCargoGlobal [_config, _amount];};

} forEach _list;

uiNamespace setVariable ['Rev_supply_list', nil]; 




//Waypoints

private _wp1 = _group addWaypoint [_pos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWayPointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true", "if (local this) then {
										private _plane = vehicle leader this;
										[_plane] spawn Rev_arty_fnc_supply_create;
									};
									"];


private _wp3 = _group addWaypoint [_fin_pos, 0];
_wp3 setWaypointType "MOVE";
_wp3 setWayPointBehaviour "AWARE";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointStatements ["true", "_cleanUpveh = vehicle leader this;
									_cleanUpPos = position (vehicle leader this);									
									[_cleanUpPos] spawn {
										sleep 0.1;
										{deleteVehicle _x} forEach (_this select 0 nearEntities [['rhs_vs1_seat','Car_F'], 25]);
										};
									{deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];
									"];
