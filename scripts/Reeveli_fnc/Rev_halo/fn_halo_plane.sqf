/*
 * Author: Reeveli 
 * Part of Reeveli's HALO system.
 * Client side function to handle HALO dialog closure. Called from the dialog control.
 *
 * Arguments: <NONE> Plane class is defined in a global variable. 
 *
 * Return Value: <BOOL>
 * True: Function run succesfully
 * False: Function safety cancel due to locality
 *
 * Example:
 * call Rev_fnc_halo_plane
 *
 1.1
	Defined z coordinate for final waypoint pos
 */

if (!hasInterface) exitWith {false};

private _plane_type = Rev_halo_plane_class;

private _pos = getMarkerPos "Rev_drop_zone";
private _caller = player;
private _plane_side = side player;
private _height = 1800;
private ["_run_start_pos","_jump_pos","_direction","_origin_pos","_fin_pos","_plane","_plane_vehicle","_group","_wp1","_wp2","_wp3","_vel"];

_direction = round (random 360);

_origin_pos = _pos getPos [-3000, _direction];
_run_start_pos = _pos getPos [-1500, _direction];
_jump_pos = _pos getPos [200, _direction];
_fin_pos = _pos getPos [3000, _direction];

_plane = [_origin_pos, _direction,_plane_type, _plane_side] call bis_fnc_spawnvehicle;
_plane_vehicle = _plane select 0;
_plane_vehicle allowDamage false;
_group = _plane select 2;
_plane_vehicle setPosATL [getPosATL _plane_vehicle select 0, getPosATL _plane_vehicle select 1, _height];
_group setcombatmode "BLUE";
_group setBehaviour "CARELESS";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;
{_x allowDamage false} forEach units _group;
{_x setCaptive true} forEach units _group;

_plane_vehicle flyInHeight _height;
_plane_vehicle lockDriver true;
_plane_vehicle lockTurret [[0],true];

_vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin _direction * 120), 
	(cos _direction * 120), 
	(_vel select 2)
];

_wp5 = _group addWaypoint [_run_start_pos , 0, 1];
_wp5 setWaypointType "MOVE";
_wp5 setWayPointBehaviour "CARELESS";
_wp5 setWaypointSpeed "NORMAL";
_wp5 setWaypointStatements ["true",
"
	if (local this) then {
		vehicle this animate ['ramp_top',1];
		vehicle this animate ['ramp_bottom',1];
		private _jumpers = (crew (vehicle this)) select {_x in ([] call CBA_fnc_players)};
		[vehicle this,'Approaching the LZ. Get ready.'] remoteExec ['vehicleChat',_jumpers,false];			
	};
"
];


_wp2 = _group addWaypoint [_jump_pos, 0, 2];
_wp2 setWaypointType "MOVE";
_wp2 setWayPointBehaviour "CARELESS";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setWaypointStatements ["true",
"
	if (local this) then {
		private _jumpers = (crew (vehicle this)) select {_x in ([] call CBA_fnc_players)};
		[vehicle this,'JUMP, JUMP, JUMP!'] remoteExec ['vehicleChat',_jumpers,false];	

		{
			[_x] remoteExecCall ['Rev_fnc_jump',_x,false];
		} forEach _jumpers;		
	};
"
];

_wp3 = _group addWaypoint [[_fin_pos select 0, _fin_pos select 1, _height], 0, 3];
_wp3 setWaypointType "MOVE";
_wp3 setWayPointBehaviour "CARELESS";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointStatements ["true", "_cleanUpveh = vehicle leader this;{deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];"];

deleteMarkerLocal 'Rev_drop_zone';

private _pasengers = ([_caller] call Rev_fnc_transport_check) select 0;
private _cargoIndex = 1;
{
	[_plane_vehicle,_cargoIndex] remoteExec ['Rev_fnc_embark',_x,false];
	_cargoIndex = _cargoIndex + 1;
} forEach _pasengers;

Rev_halo_plane_class = nil;
true;