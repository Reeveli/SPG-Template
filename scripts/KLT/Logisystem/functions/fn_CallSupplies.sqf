params ["_caller"];
[_caller] spawn {
  params ["_caller"];
_group = createGroup civilian; 
private _result = [getPos spawnPoint, 180, "B_T_VTOL_01_vehicle_F",_group] call BIS_fnc_spawnVehicle; 
private _vehicle = _result select 0; 
 //  RHS_CH_47F_10_cargo
 
_pos = position _caller;
_pos set [2, + 400];
//hint str _pos;


_wpheli = _group addWaypoint [(position _caller) vectorAdd [0, 0, 200], 20]; 

 


_wpheli setWaypointBehaviour "CARELESS"; 
_group setBehaviourStrong "CARELESS";
_wpheli setWaypointCombatMode "BLUE"; 
_wpheli setWaypointSpeed "FULL"; 
_vehicle flyInHeight 200;
waitUntil { (currentWaypoint (_wpheli select 0)) > (_wpheli select 1) }; 
//hint"unit is in place"; 

//==========================================================
// Mission Specific function
["bluetask4","SUCCEEDED",false] call BIS_fnc_taskSetState;
//==========================================================

[_vehicle,3,100,true,true] call KLT_fnc_DropCargo;
_wpheli = _group addWaypoint [[0,0,500], 20]; 
_wpheli setWaypointBehaviour "CARELESS"; 
_group setBehaviourStrong "CARELESS";
_wpheli setWaypointCombatMode "BLUE"; 
_wpheli setWaypointSpeed "FULL"; 
_vehicle flyInHeight 500;
waitUntil { (currentWaypoint (_wpheli select 0)) > (_wpheli select 1) }; 
deleteVehicle _vehicle;

{
  deletevehicle _x;
} forEach units _group;




};