/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, air support.
 * Client side function to close the air support dialog. Arguments are called from an externally defined variable.
 *
 * Arguments:
 * 0: Target position <ARRAY> (default: [0,0,0])
 * 1: Selected plane class <STRING> (default: "B_Plane_Fighter_01_F") 
 * 2: Selected plane loadout <STRING> (default: "Default")
 *  : Selected plane skin <ARRAY> (default: ["DarkGrey"]) (not used)
 * 2: Flying altitude of plane <NUMBER> (default: 100)
 * 3: Plane starting position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [] spawn Rev_arty_fnc_air_start
 *
 2.2
	BIS_fnc_dirTo replaced with getDir
 2.1
	Waypoint switched to loitering to enbale usage of two seat aircraft
	Additional variable saved on Rev_air_pilot for waypoint management on fn_air_disconnect 
 2.0
	Skin code disbaled part of air support dialog overhaul. Code left as legacy support
	New params added
	_plane switched to objNull in timer code to fix UAV disconnect bug. Needs testing
	Changes to how remote control object is defined. Should now be consistent preventing control bugs on disconnect.
		Rev_air_pilot is now defined earlier and used on all definitions
	ViewDistance varibales are now saved here to keep commonality with gunship system
	Assigned items are now targeted only to terminal
 */


private _args = player getVariable "Rev_arty_air_call";

_args params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_class","B_Plane_Fighter_01_F",[""]],
	["_loadout","Default",[""]],
	//["_skin",["DarkGrey"],[[]],[1]],
	["_altitude",100,[0]],
	["_start_pos",[0,0,0],[[]],[2,3]]
];


player setVariable ['Rev_arty_air_call',nil];

//Update ammo amount to server
["Rev_arty_AIR_regen",[1]] call CBA_fnc_serverEvent;

//viewDistance varibales to keep commonality with gunship system, not used here
Rev_arty_gun_view = viewDistance;
Rev_arty_gun_viewO = getObjectViewDistance;


//Generate params for plane
private _direction = _start_pos getDir _pos;

//End pos
private _fin_pos = _pos getPos [3000,_direction];

//Creating the plane
private _plane = [[_start_pos select 0,_start_pos select 1,_altitude], _direction,_class, side player] call bis_fnc_spawnvehicle;
private _plane_vehicle = _plane select 0;
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

//Loadout
private _pylons = getArray (configfile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Presets" >> _loadout >> "attachment"); 
private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")}; 
{_plane_vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _plane_vehicle; 
{_plane_vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;

//Skin
//[_plane_vehicle, _skin] remoteExec ["bis_fnc_initVehicle",0,true];


//Waypoints
private _wp1 = _group addWaypoint [_pos, 0];
_wp1 setWaypointType "LOITER";
_wp1 setWaypointLoiterType "CIRCLE_L";
_wp1 setWaypointLoiterRadius 700;
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
Rev_air_pilot = driver _plane_vehicle;
player connectTerminalToUAV Rev_air_pilot; 
player remoteControl Rev_air_pilot; 
Rev_air_pilot switchCamera "INTERNAL";
Rev_air_pilot setVariable ["Rev_air_fin_pos",_fin_pos];


private _start = cba_missiontime;


//CBA stateMachine incase manual disconnect
Rev_air_machine = [[player]] call CBA_statemachine_fnc_create;
[Rev_air_machine, {}, {}, {}, "Controlled"] call CBA_statemachine_fnc_addState;
[Rev_air_machine, {}, {[objNull,Rev_air_machine,false] call Rev_arty_fnc_air_disconnect;}, {}, "NotControlled"] call CBA_statemachine_fnc_addState;
[Rev_air_machine, {}, {[Rev_air_pilot,Rev_air_machine,true] call Rev_arty_fnc_air_disconnect;}, {}, "Killed"] call CBA_statemachine_fnc_addState;

[Rev_air_machine, "Controlled", "NotControlled", {cameraOn isEqualTo player}] call CBA_statemachine_fnc_addTransition;
[Rev_air_machine, "NotControlled", "Controlled", {cameraOn isEqualTo Rev_air_pilot}] call CBA_statemachine_fnc_addTransition;


timer = [{
	params ["_args","_handel"];
	_args params ["_start","_time","_plane","_stateMachine"];
	if (cba_missiontime >= (_start + _time)) then {
		hintSilent "";
		[_handel] call CBA_fnc_removePerFrameHandler;
		[_plane,_stateMachine,false] call Rev_arty_fnc_air_disconnect;
	} else {hintSilent format ["Remaining time %1", round (_time - (cba_missiontime - _start))];};
}, 0, [_start,Rev_arty_AIR_duration,Rev_air_pilot,Rev_air_machine]] call CBA_fnc_addPerFrameHandler;



//EHs pilot
Rev_air_pilot addEventHandler ["Deleted", {
	params ["_entity"];
	[player,Rev_air_machine, "Controlled", "Killed", {}, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
}];

Rev_air_pilot addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	hintSilent format ["The pilot was killed, %1s penalty added to next cooldown",Rev_arty_AIR_penalty];
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
	hintSilent format ["The plane was destroyed, %1s penalty added to next cooldown",Rev_arty_AIR_penalty];
	["Rev_arty_AIR_event_penalty"] call CBA_fnc_serverEvent;
	[player,Rev_air_machine, "Controlled", "Killed", {}, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
}];

//Curator block
Rev_air_curator = (findDisplay 46) displayAddEventHandler ["KeyDown",
{
  params ["_display", "_key", "_shift", "_ctrl", "_alt"];
	if (_key in actionKeys "curatorInterface") then {true;};
}];