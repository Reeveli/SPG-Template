params ["_move"];

_dog = player getVariable ["MWD_Dog", objNull];
if (isNull _dog) exitWith {};

if (_move == _dog getVariable ["MWD_CurrentMove", ""]) exitWith {};

_dog playMoveNow _move;
_dog setVariable ["MWD_CurrentMove", _move];