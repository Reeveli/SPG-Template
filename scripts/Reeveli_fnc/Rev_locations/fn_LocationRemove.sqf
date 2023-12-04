/*
 * Author: Reeveli
 * Remove closest location (most relevant types searched). Must be run globally on all clients.
 * One trick is to use this from the editor via logic object.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value: BOOLEAN
 *
 * Example:
 * [_pos] call Rev_fnc_locationRemove;
 *
 */

params
[
	["_pos",nil,[[]],[2,3]]
];



private _location = nearestLocation [_pos, ["NameCity","NameCityCapital","NameLocal","NameMarine","NameVillage"]];	
_location setType "Invisible";								
private _invisible = createLocation [_location];		
_invisible setType "Invisible";	

true;