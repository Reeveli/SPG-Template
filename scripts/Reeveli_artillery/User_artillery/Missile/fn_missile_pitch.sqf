/*
Author: Dankan37, Reeveli
Function: Returns pitch needed to aim a target. Return value should be multiplied by -1 to get a downward angle.

USAGE:
[startingPoint, target] call Rev_arty_fnc_missile_pitch

NOTE: You may reuse this script in any of your missions or server, you may tweak this as you please and there's no need to credit me, as long as you don't claim it as yours.

By Reeveli:
1.3
    _altitudeOne changed to use ATL instead of ASL
    _distance is now calculated as distance2D
1.2
    New params, missile changed to last_pos
1.1
    Performance optimisation

*/

params ["_missile","_last_pos"];

//Getting the altitudes
private _altitudeOne = ((getPosATL _missile) select 2);
private _altitudeTwo = (_last_pos select 2);

//Altitude diff.
private _altittudeDiff = abs (_altitudeOne - _altitudeTwo);

//Getting distance
private _distance = _missile distance2D _last_pos;

//Calculating pitch
private _dist3d = sqrt (_distance ^ 2 + _altittudeDiff ^ 2); //Pytagora
private _pitchTgt = acos (_distance / _dist3d); //Returning the angle 
_pitchTgt; //Return value of function
