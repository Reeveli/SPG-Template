/*
 * Author: Reeveli
 * Object with simple object with scale. Can be used from editor.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Optional: setScale number <NUMBER>
 *
 * Return Value NONE
 *
 * Example:
 * [this,1] call Rev_fnc_replaceWithSimple;
 *
 1.1.1
	Changed argument in header example
	
 1.1
	Changed default scale value to 1
 */

if !(isServer) exitWith {false};
params
[
	["_object", objNull, [objNull]],
	["_scale", 1, [0]]
];


private _class = typeOf _object;
private _pos = getposASL _object;
private _dir = vectorDir _object;
private _up = vectorUp _object;


_new = createSimpleObject [_class, _pos];
_new setVectorDirAndUp [_dir, _up];

deleteVehicle _object;

_new setObjectScale _scale;