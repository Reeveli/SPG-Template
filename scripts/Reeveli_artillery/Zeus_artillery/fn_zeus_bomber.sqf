/*
 * Author: Reeveli
 * Creates aircraft and ordnance waypoints based on passed ZEN dialog. Called from Rev_arty_fnc_zeus_air_strike.
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Bomb ammo class <STRING> (default: "Bo_Mk82")
 * 2: Bomb amount <SCALAR> (default: 1)
 * 3: Bomb pattern <STRING> (default: "Linear")
 * 4: Plane direction <SCALAR> (default: 0)
 * 5: Plane flying height <SCALAR> (default: 200)
 * 6: Plane class <STRING> (default: "B_Plane_Fighter_01_F")
 * 7: Plane side <SIDE> (default:civilian)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [_position select 0,_bomb_type,_bomb_number,_pattern,_direction,_height_number,_plane_type,_plane_side] remoteExecCall ["Rev_arty_fnc_zeus_bomber",2];
 *
 1.3
	Code for passed pattern parameter
	BIS_fnc_relPos replaced with getpos syntax
 1.2
	Header updated
	Varibales are now privated in 'normal' manner
	_wp2 removed, old _wp2 renamed
	Alot of old direction related variables removed, passed param _direction is now used instead
 1.1
	Bomb amount and type are not longer global varibales, but are tied to object namespace
 */
if (!isServer) exitWith {false};

params [
	["_pos",nil,[[]],[2,3]],
	["_bomb_type","Bo_Mk82",[""]],
	["_bomb_number",1,[0]],	
	["_pattern","Linear",[""]],
	["_direction",0,[0]],
	["_height_number",200,[0]],
	["_plane_type","B_Plane_Fighter_01_F",[""]],
	["_plane_side",civilian,[civilian]]
];

private _run_start_pos = _pos getPos [[(25*(_bomb_number-1)),40] select (_pattern isEqualTo "Horizontal"), _direction - 180];
private _fin_pos = _pos getPos [4000,_direction - 180];

private _plane = [_pos getPos [4000,_direction],_direction - 180,_plane_type, _plane_side] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;
private _group = _plane select 2;
_plane_vehicle setPosATL [getPosATL _plane_vehicle select 0, getPosATL _plane_vehicle select 1, _height_number];
_group setcombatmode "BLUE";
_group setBehaviour "AWARE";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;
_plane_vehicle flyInHeight _height_number;

_vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin (_direction - 180) * 120), 
	(cos (_direction - 180) * 120), 
	(_vel select 2)
];

//Setting variables to unit to carry bomb type and amount data through the waypoint
_plane_vehicle setVariable ["Rev_air_bomb_amount",_bomb_number,true];
_plane_vehicle setVariable ["Rev_air_bomb_type",_bomb_type,true];
_plane_vehicle setVariable ["Rev_air_bomb_pattern",_pattern,true];


private _wp1 = _group addWaypoint [_run_start_pos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWayPointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true", "[this] remoteExecCall ['Rev_arty_fnc_bomb_ordance',2]"];

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