/*
 * Author: Reeveli
 * Server side function to create aircraft and ordnance waypoints based on passed ZEN dialog.
 * Called from Rev_arty_fnc_zeus_air_strike and Rev_arty_fnc_bomb_plane
 * Next function in chain is Rev_arty_fnc_bomb_ordance
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Bomb ammo class <STRING> (default: "Bo_Mk82")
 * 2: Bomb amount <SCALAR> (default: 1)
 * 3: Plane direction <SCALAR> (default: 0)
 * 4: Plane class <STRING> (default: "B_Plane_Fighter_01_F")
 * 5: Plane side <SIDE> (default:civilian)
 * 6: Caller player <OBJECT> (default:objNull)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [_targetPos,_bomb_type,_bomb_amount,_direction,_plane_type,_plane_side,player] remoteExecCall ["Rev_arty_fnc_zeus_bomber",2];
 *
 2.0
	Adjusted direction to conform with new param
	Reduced spawn and despawn distance to 3km
	Plane is now automatically editable to player passed along in a new param
	Increased default altitude to 300
	Ordanance drop is now spawned to reduce desynch
	Height is now fixed 300
	Pattern code eliminated
	Added object variable to pass target pos
	Added object variable to pass target direction
	Passed variables are no longer public
	Bomb release pos is now fixed
	New cleanup EHs for target logic
	Pushed ejection seat deletion to same EH that handels logic deletion
	Crew group is now deleted when empty
	Disabled aircraft lights
	Ordnance script is now spawned
 */

if (!isServer) exitWith {false};

params [
	["_pos",nil,[[]],[2,3]],
	["_bomb_type","Bo_Mk82",[""]],
	["_bomb_number",1,[0]],
	["_direction",0,[0]],
	["_plane_type","B_Plane_Fighter_01_F",[""]],
	["_plane_side",civilian,[civilian]],
	["_caller",objNull,[objNull]]
];


private _run_start_pos = _pos getPos [500, _direction - 180];
private _fin_pos = _pos getPos [3000,_direction];

private _plane = [_pos getPos [3000,_direction - 180],_direction,_plane_type, _plane_side] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;
private _group = _plane select 2;
_group deleteGroupWhenEmpty true;

private _height_number = 300;
_plane_vehicle setPosATL [getPosATL _plane_vehicle select 0, getPosATL _plane_vehicle select 1, _height_number];
_plane_vehicle flyInHeight _height_number;

//Adding plane to editable objects
If !(isNull _caller) then {
	(getAssignedCuratorLogic _caller) addCuratorEditableObjects [[_plane_vehicle],true];
};

_group setcombatmode "BLUE";
_group setBehaviour "AWARE";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;

//Lights
_plane_vehicle disableAI "LIGHTS"; // override AI
_plane_vehicle setCollisionLight false; // force switch collision lights off

private _vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin (_direction) * 120), 
	(cos (_direction) * 120), 
	(_vel select 2)
];

//Setting variables to unit to carry bomb type and amount data through the waypoint
_plane_vehicle setVariable ["Rev_air_bomb_caller",_caller,false];
_plane_vehicle setVariable ["Rev_air_bomb_target",_pos,false];
_plane_vehicle setVariable ["Rev_air_bomb_amount",_bomb_number,false];
_plane_vehicle setVariable ["Rev_air_bomb_type",_bomb_type,false];
_plane_vehicle setVariable ["Rev_air_bomb_direction",_direction,false];


private _wp1 = _group addWaypoint [_run_start_pos, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWayPointBehaviour "CARELESS";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true", "[this] spawn Rev_arty_fnc_bomb_ordance"];

private _wp2 = _group addWaypoint [_fin_pos, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWayPointBehaviour "CARELESS";
_wp2 setWaypointSpeed "NORMAL";
_wp2 setWaypointStatements ["true", "_cleanUpveh = vehicle leader this;
							{deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];"];


//Cleanup after completion
_plane_vehicle addEventHandler ["Deleted", {
	params ["_entity"];
	//Target logic
	private _logic = _entity getVariable ["Rev_air_bomb_logic",objNull];
	deleteVehicle _logic;
	//RHS ejection seat
	[{
		{deleteVehicle _x} forEach (_this select 0 nearEntities [['rhs_vs1_seat','Car_F'], 25]);
	}, [position _entity]] call CBA_fnc_execNextFrame;									
}];

//Cleanup after killed
_plane_vehicle addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects", "_shot", "_real"];
	//Target logic
	private _logic = _unit getVariable ["Rev_air_bomb_logic",objNull];
	deleteVehicle _logic;
}];


true;