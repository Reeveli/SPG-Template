/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, gunship support.
 * Client side function to handle the gunship support start. Called from radio_dialog. Arguments are called from an externally defined variable.
 *
 * Arguments:
 * 0: Target position <ARRAY> (default: [0,0,0])
 * 1: Gunship class <STRING> (default: "B_T_VTOL_01_armed_F") 
 * 2: Loitering radius <NUMBER> (default: 1000)
 * 3: Loitering altitude <NUMBER> (default: 1000)
 * 4: View distance while using the gunship <NUMBER> (default: 5000)
 * 5: Starting position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [] spawn Rev_arty_fnc_gunship_start
 *
 1.2
	BIS_fnc_dirTo replaced with getDir
 1.1
	Switch objNull on controlled disconnect to Rev_air_pilot to enable waypoint management on manual disconnect
	Additional variable saved on Rev_air_pilot for waypoint management on fn_air_disconnect 
 */

private _args = player getVariable "Rev_arty_gun_call";

_args params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_class","B_T_VTOL_01_armed_F",[""]],
	["_loiter",100,[0]],
	["_altitude",100,[0]],
	["_view_distance",5000,[0]],
	["_start_pos",[0,0,0],[[]],[2,3]]
];

player setVariable ['Rev_arty_gun_call',nil];


//Update ammo amount to server
["Rev_arty_GUN_regen",[1]] call CBA_fnc_serverEvent;

//Saving and setting viewDistance
Rev_arty_gun_view = viewDistance;
Rev_arty_gun_viewO = getObjectViewDistance;
setViewDistance _view_distance;
setObjectViewDistance _view_distance;

//Generate params for plane
private _direction = _start_pos getDir _pos;

//End pos
private _fin_pos = _pos getPos [ 1.5 * _loiter,_direction];

//Creating the plane
private _plane = [[_start_pos select 0,_start_pos select 1,_altitude], _direction,_class, side player] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;

//Gunship specific
_plane_vehicle setCaptive Rev_arty_GUN_captive;
_plane_vehicle lockTurret [[0],true];
_plane_vehicle lockTurret [[1],true];
_plane_vehicle lockDriver true;

//Adding the 105mm
_plane_vehicle addWeaponTurret ["cannon_105mm_VTOL_01", [2]];
_plane_vehicle addMagazineTurret ["20Rnd_105mm_HEAT_MP_T_Red",[2]];

private _group = _plane select 2;
_group setcombatmode "BLUE";
_group setBehaviour "AWARE";
{_x disableAI "TARGET"} forEach units _group;
{_x disableAI "AUTOTARGET"} forEach units _group;
_plane_vehicle flyInHeight _altitude;

_vel = velocity _plane_vehicle;
_plane_vehicle setVelocity [
	(sin _direction* 120), 
	(cos _direction* 120), 
	(_vel select 2)
];

//Waypoints
private _wp1 = _group addWaypoint [_pos, 0];
_wp1 setWaypointType "LOITER";
_wp1 setWaypointLoiterType "CIRCLE_L";
_wp1 setWaypointLoiterRadius _loiter;
_wp1 setWayPointBehaviour "AWARE";
_wp1 setWaypointSpeed "NORMAL";

//saving variables for later use
player setVariable ["Rev_air_unit",driver _plane_vehicle];
player setVariable ["Rev_air_rating",rating player];


switch (side player) do {

	case WEST: {if !("B_UavTerminal" in (assignedItems player)) then {player linkItem "B_UavTerminal";player setVariable ["Rev_air_items","B_UavTerminal"]}};
	case EAST: {if !("O_UavTerminal" in (assignedItems player)) then {player linkItem "O_UavTerminal";player setVariable ["Rev_air_items","O_UavTerminal"]}};
	case INDEPENDENT: {if !("I_UavTerminal" in (assignedItems player)) then {player linkItem "I_UavTerminal";player setVariable ["Rev_air_items","I_UavTerminal"]}};
	case CIVILIAN: {if !("C_UavTerminal" in (assignedItems player)) then {player linkItem "C_UavTerminal";player setVariable ["Rev_air_items","C_UavTerminal"]}};
};

if (visibleMap) then {openMap false;};
Rev_air_pilot = _plane_vehicle turretUnit [2];
player connectTerminalToUAV Rev_air_pilot; 
player remoteControl Rev_air_pilot; 
Rev_air_pilot switchCamera "INTERNAL";
Rev_air_pilot setVariable ["Rev_air_fin_pos",_fin_pos];


private _start = cba_missiontime;


//CBA stateMachine incase manual disconnect
Rev_air_machine = [[player]] call CBA_statemachine_fnc_create;
[Rev_air_machine, {}, {}, {}, "Controlled"] call CBA_statemachine_fnc_addState;
[Rev_air_machine, {}, {[Rev_air_pilot,Rev_air_machine,false] call Rev_arty_fnc_air_disconnect;}, {}, "NotControlled"] call CBA_statemachine_fnc_addState;
[Rev_air_machine, {}, {[Rev_air_pilot,Rev_air_machine,true] call Rev_arty_fnc_air_disconnect;}, {}, "Killed"] call CBA_statemachine_fnc_addState;

[Rev_air_machine, "Controlled", "NotControlled", {cameraOn isEqualTo player}] call CBA_statemachine_fnc_addTransition;
[Rev_air_machine, "NotControlled", "Controlled", {cameraOn isEqualTo Rev_air_pilot}] call CBA_statemachine_fnc_addTransition;

timer = [{
	params ["_args","_handel"];
	_args params ["_start","_time","_plane","_stateMachine","_group","_fin_pos"];
	if (cba_missiontime >= (_start + _time)) then {
		hintSilent "";
		[_handel] call CBA_fnc_removePerFrameHandler;
		[_plane,_stateMachine,false] call Rev_arty_fnc_air_disconnect;
	} else {hintSilent format ["Remaining time %1", round (_time - (cba_missiontime - _start))];};
}, 0, [_start,Rev_arty_GUN_duration,Rev_air_pilot,Rev_air_machine,_group,_fin_pos]] call CBA_fnc_addPerFrameHandler;


//EHs pilot
Rev_air_pilot addEventHandler ["Deleted", {
	params ["_entity"];
	[player,Rev_air_machine, "Controlled", "Killed", {}, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
}];

Rev_air_pilot addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	hintSilent "The pilot was killed!";
	["Rev_arty_AIR_event_penalty"] call CBA_fnc_serverEvent;
	[player,Rev_air_machine, "Controlled", "Killed", {}, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
}];

//EHs plane
_plane_vehicle addEventHandler ["Deleted", {
	params ["_entity"];
	hintSilent "";
	[player,Rev_air_machine, "Controlled", "Killed", {}, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
}];

_plane_vehicle addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	hintSilent "The plane was destroyed!";
	[player,Rev_air_machine, "Controlled", "Killed", {}, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
}];


//Curator block
Rev_air_curator = (findDisplay 46) displayAddEventHandler ["KeyDown",
{
  params ["_display", "_key", "_shift", "_ctrl", "_alt"];
	if (_key in actionKeys "curatorInterface") then {true;};
}];