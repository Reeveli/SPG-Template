call compile preprocessFile "scripts\KLT\Sandstorm\KLT_fnc_startsand.sqf";

if(!isDedicated) then {[] call klt_fnc_registerDustModules}; 