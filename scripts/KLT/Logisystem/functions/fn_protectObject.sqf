params [
    ["_obj", objNull, [objNull]],
    ["_enable", true, [false]]
];

if (isNull _obj) exitWith {["Null object given"] call BIS_fnc_error; false};

_obj allowDamage _enable;
_obj enableSimulation _enable;

true