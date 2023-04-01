/*

    Author: Dankan37
    Function: This will call in a cruise missile where the player is watching, cruise missile has a 5+ meters miss radius, this is because of a simple math operation, I will update it soon.

    USAGE:
    Params:
    [speed, direction, height, distance, restriction] spawn Dan_fnc_CruiseMissile / or ExecVM "fn_cruiseMissile.sqf";

    -speed is the missile starting speed.
    -direction is the where the missile is gonna come from.
    -height is traver altitude ASL.
    -distance is how far away the missile will spawn.
    -restriction is used if you want the missile only to target objects (cars, apcs, men)...
    -radius is search radius from watched point.

    They are optional, as the missile has already some set up, in order to make it work under the best enviroment.


    TODO:
    Heigh following missile: Missile will follow a determined altitude, ie: fly over a mountain and then lower down.
    AI will target missile: Nearby AA assets will shoot the missile down if possible.
    Seeking missile: The missile will seek the target, and will track moving ones.
    Camera: Missile camera to see where it's going.
    Better missile math: Improve the math, in order to increase accuracy.


    NOTE: You may reuse this script in any of your missions or server, you may tweak this as you please and there's no need to credit me, as long as you don't claim it as yours.

    Modified by Reeveli
    1.7
        Missile distance is now calculated as distance2D
        Terminal phase is now relative to altitude
        Removed unused private varibale _downSpeed
        Removed unused private varibale _velocity
        Removed unused private varibale _altitudeMissileASL
        Missile spawning is now done at 200m when over water
        Missile will use ASL altitude when over water
        Flymode if conditions merged
        Warhead initilaisation now uses the same function(s) as user artillery
        Flight tracker now in uniform CAPS
    1.6
        Added _last pos variable for more accurate missile crater placement
            Artillery react now uses _last_pos
        Removed first unused params
        Fixed flight tracker not working
        Deleted some dead code
        Made impact reaction to fire in all cases (warhead/crater)
    1.5
        Flight tracker values are now rounded
    1.4
        New param for missile type
        Added conditions to only fire craters on Alias if HE missile
        Removed all references to _start_speed

    1.3
        New parameter to enable tracking

    1.2
        Made last hint dependent on _testing
        Removed BIS_fnc_setHeight as unnecessary, modified the creation command instead
        Moved delete _target after crater creation
    
    1.1
        Changed pitch calculation in line 118
        Privated variables
        Deleted old code
*/
params [["_type","ammo_Missile_Cruise_01_Cluster"],"_pos","_direction", "_altitude","_distance","_craters","_tracker"];

//Setting up ASL mode
private _flyMode = "TRANSIT";


private _target = createAgent ["Logic", _pos, [], 0, "FORM"];
private _last_pos = _pos;  

//Setting up the starting pos for the missile.
private _startPos =  _pos getPos [_distance, _direction];  

//Water check for low altitude spawns
private _start_alt = _altitude;
if (surfaceIsWater _startPos) then {_start_alt = 200};
//Creating the missile entity
private _missile = _type createVehicle [_startPos select 0, _startPos select 1,_start_alt];

//Making the missile point the target
private _dir = _missile getDir _target;
_missile setDir _dir;

//Giving the missile the desired speed
private _vel = velocity _missile;
_missile setVelocity 
[
    (_vel select 0) + (sin _dir * 250), 
    (_vel select 1) + (cos _dir * 250), 
    (_vel select 2)
];
//Loop starts here, and keeps running untill the explosion
while {Alive _missile} do
{
    //Collecting all the values for testing/debugging/operating
    private _speed = speed _missile;
    private _altitudeMissileATL = (getPosATL _missile) select 2;
    private _distance = _missile distance2D _target;
    private  _pitchMis = (_missile call BIS_fnc_getPitchBank) select 0;
    _last_pos = getPosATL _missile; 

    private _dir2 = _missile getDir _target;
    _missile setDir _dir2;

    private _pitchOne = [_missile,getPosATL _target] call Rev_arty_fnc_missile_pitch;

    //While the missile is far away
    if (_distance > _altitude) then
    {
        private _mode = "ATL";
        if (surfaceIsWater (getpos _missile)) then {_mode = "ASL"};
        
        //Keeping the missile at a costant altitude
        [_missile,_altitude,nil,_mode] call BIS_fnc_setHeight;
    } else
    {
        _flyMode = "TERMINAL";
        _pitchOne = -1 * ([_missile,getPosATL _target] call Rev_arty_fnc_missile_pitch);
        [_missile, _pitchOne , 0] call BIS_fnc_setPitchBank;
    };
    sleep 0.005;

    //In case of testing
    if(_tracker) then {
        hintSilent format ["MODE: %1 \n SPEED: %2 \n DISTANCE: %3 \n ALTITUDE: %4",_flyMode,round _speed,round _distance,round _altitudeMissileATL];
    };
    
};
waitUntil {!Alive _missile};
[_last_pos] call Rev_arty_fnc_react;

if (Rev_arty_alias_enabled && (_type isEqualTo "ammo_Missile_Cruise_01")) then {
    [_last_pos,_craters] remoteExecCall ["Rev_arty_fnc_warhead_init",2];
};

sleep 0.1;

if (!(Rev_arty_alias_enabled) && (_craters) && (_type isEqualTo "ammo_Missile_Cruise_01")) then {
    private _c = createVehicle ["Land_ShellCrater_02_large_F", _last_pos, [], 0, "CAN_COLLIDE"];
    [_c, false] remoteExec ["enableSimulationGlobal", 2];
};
deleteVehicle _target;
if(_tracker) then {hintSilent "MODE: NO SIGNAL"};
sleep 10;
hintSilent "";
