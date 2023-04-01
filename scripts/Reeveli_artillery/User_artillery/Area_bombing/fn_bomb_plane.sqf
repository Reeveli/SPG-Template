/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, area bombing ordnance.
 * Function to create the bomber plane. Arguments are provided by varibales created by the system earlier.
 *
 * Arguments: <NONE>
 *
 * Return Value: NONE
 *
 * Example:
 * [] spawn Rev_arty_fnc_bomb_plane
 *
 1.2
	Removed _pattern from params
	Neutered other mentions
 1.1.1
	Server ammo update is now calculated based on ordnance amount, not sortie
 1.1
	Drop point pos now takes bomb pattern into account
 1.0
	Initial version
 */
 
private _args = player getVariable "Rev_arty_bom_call";

_args params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_attachment","",[""]],
	["_amount",3,[0]],
	["_start_pos",[0,0,0],[[]],[2,3]]
];

player setVariable ['Rev_arty_bom_call',nil];
if (visibleMap) then {openMap false;};

//Update ammo amount to server
["Rev_arty_BOM_regen",[_amount]] call CBA_fnc_serverEvent; //Use 1 if tracking is to be done on sortie basis instead of ordnance


//Generate params for plane
private _direction = _start_pos getDir _pos;


//Creating the plane
//Old selct condition if pattern is still enabled (_pattern isEqualTo "Horizontal")
private _run_start_pos = _pos getPos [[(25*(_amount-1)),40] select (false), _direction - 180];
private _fin_pos = _pos getPos [4000,_direction];

private _plane = [_start_pos, _direction,Rev_arty_BOM_class, side player] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;
private _group = _plane select 2;
_plane_vehicle setPosATL [getPosATL _plane_vehicle select 0, getPosATL _plane_vehicle select 1, 300];
_group setcombatmode "BLUE";
_group setBehaviour "AWARE";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;
_plane_vehicle flyInHeight 300;
_plane_vehicle setCaptive Rev_arty_BOM_captive;

private _vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin _direction * 120), 
	(cos _direction * 120), 
	(_vel select 2)
];

//Setting variables to unit to carry bomb type and amount data through the waypoint
_plane_vehicle setVariable ["Rev_air_bomb_amount",_amount,true];
_plane_vehicle setVariable ["Rev_air_bomb_type",_attachment,true];
//_plane_vehicle setVariable ["Rev_air_bomb_pattern",_pattern,true];


private _wp1 = _group addWaypoint [_run_start_pos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWayPointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true", "[this,true] remoteExecCall ['Rev_arty_fnc_bomb_ordance',2]"];

private _wp2 = _group addWaypoint [_fin_pos, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWayPointBehaviour "AWARE";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setWaypointStatements ["true", "_cleanUpveh = vehicle leader this;
									_cleanUpPos = position (vehicle leader this);
									[_cleanUpPos] spawn {
										sleep 0.1;
										{deleteVehicle _x} forEach (_this select 0 nearEntities [['rhs_vs1_seat','Car_F'], 25]);
										};
									{deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];
									"];

true;