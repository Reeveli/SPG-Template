//My custom Zeus modules
if (isClass (configFile >> "CfgPatches" >> "achilles_data_f_ares")) then
{
	
	["Killet's Modules", "Rock Thrower", {[_this select 1] remoteexec ["klt_fnc_MakeThrower",2];}] call Ares_fnc_RegisterCustomModule;
	
};