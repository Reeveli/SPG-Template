/*
 * Author: Reeveli 
 * Part of Zeus resupply system.
 * Client side function to create the plane carrying the resupply box, execute in scheduled environment.
 * Cannot be run as its onw function, need varibales defined earlier in the system.
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [] spawn Rev_fnc_resupply;
 *
 */

//Generate params for plane
private _args = uiNamespace getVariable ["Rev_arty_supply_call",[]]; 
_args params [
	["_pos",nil,[[]],[2,3]],
	["_class","B_Heli_Transport_03_unarmed_F",[""]],
	["_altitude",100,[0]],
	["_direction",0,[0]],
	["_attachment","SmokeShellYellow",[""]],
	["_side",WEST,[WEST]]
];

uiNamespace setVariable ["Rev_arty_supply_call", _attachment]; 

private _distance = 3000;
if ((_distance > 10000) OR (_distance < 1000)) then {_distance = 4000};



//Setting up the starting pos for the plane
private _startPos =  _pos getPos [_distance, _direction];
private _fly_direction = [_startPos,_pos] call BIS_fnc_dirTo;

//End pos
private _fin_pos = _pos getPos [_distance,_fly_direction];

private _plane = [[_startPos select 0,_startPos select 1,_altitude], _fly_direction,_class, _side] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;
private _group = _plane select 2;
_group setcombatmode "BLUE";
_group setBehaviour "AWARE";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;
_plane_vehicle flyInHeight _altitude;

private _vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin _fly_direction * 120), 
	(cos _fly_direction * 120), 
	(_vel select 2)
];

//Getting the box
private _box = (uiNamespace getVariable ["Rev_arty_supply_box",[]]) select 0;
_box attachto [_plane_vehicle,[0,0,-5]];

//Waypoints
private _wp1 = _group addWaypoint [_pos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWayPointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true", "if (local this) then {
										private _plane = vehicle leader this;
										[_plane] spawn Rev_fnc_resupply_drop;
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
