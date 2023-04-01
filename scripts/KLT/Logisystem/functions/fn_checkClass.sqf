
params [
    ["_classname", "", [""]]
];

if (_classname isEqualTo "") exitWith {["Empty string given"] call BIS_fnc_error; false};

if (isClass (configFile >> "CfgVehicles" >> _classname)) then {
    true
} else {
    if (isServer) then {[format ["%1 not found in CfgVehicles", _classname], "PRESETS"] call KLT_fnc_log;};
    false
};
