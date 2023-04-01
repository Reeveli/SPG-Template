/*
    Author: Dankan37, Reeveli

    TODO:
    AI will target missile: Nearby AA assets will shoot the missile down if possible.
    Seeking missile: The missile will seek the target, and will track moving ones.
    Camera: Missile camera to see where it's going.

    NOTE: You may reuse this script in any of your missions or server, you may tweak this as you please and there's no need to credit me, as long as you don't claim it as yours.

    Modified by Reeveli
    1.8
        Old params scrapped. New params called from variable to work with new dialog system
        Major restucturing to work with the new dialog system
    1.7
        Major restructuring, main loop split off to a new function, script turned into unscheduled compatible function
        Additional parameter to account if laser is lost before tracking begins
    1.6
        Flight tracker values are now rounded        
    1.5
        Crater numerical value harmonized with ZEN dialogs
        New param for missile type    
    1.4
        Added reaction to groups under attack
    1.3
        Named main scope
        Added exit to loop if laser !alive
        Modified script ending to accept loss of laser
    1.2
        Made last hint dependent on _testing
        Removed BIS_fnc_setHeight as unnecessary, modified the creation command instead    
    1.1
        Changed pitch calculation
        Privated variables
        Deleted old code
*/

private _args = player getVariable "Rev_arty_mis_call";
_args params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_tgt",objNull,[objNull]],
	["_type","ammo_Missile_Cruise_01",[""]],
	["_altitude",500,[0]],
	["_startPos",[0,0,0],[[]],[2,3]]
];

player setVariable ['Rev_arty_mis_call',nil];

private _testing = true;

//Update ammo amount to server
switch _type do {
    case "ammo_Missile_Cruise_01": {
        ["Rev_arty_MIS_regen",[1]] call CBA_fnc_serverEvent;
    };
    case "ammo_Missile_Cruise_01_Cluster": {
        ["Rev_arty_CLU_regen",[1]] call CBA_fnc_serverEvent;        
    };
};

//Water check for low altitude spawns
private _start_alt = _altitude;
if (surfaceIsWater _startPos) then {_start_alt = 200};
//Creating the missile entity
private _missile = _type createVehicle [_startPos select 0, _startPos select 1,_start_alt];

private _actual_pos = getPosATL _missile;

//Making the missile point the target
private _dir = _missile getDir _pos;
_missile setDir _dir;

//Giving the missile the desired speed
private _vel = velocity _missile;
_missile setVelocity 
[
    (_vel select 0) + (sin _dir * 300), 
    (_vel select 1) + (cos _dir * 300), 
    (_vel select 2)
];

//Loop starts here, and keeps running untill the explosion
[_missile,_tgt,_pos,_altitude,_testing,_actual_pos,_type] call Rev_arty_fnc_missile_guidance;
