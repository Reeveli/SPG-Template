//Killet's custom Zeus modules
if (isClass (configFile >> "CfgPatches" >> "achilles_data_f_ares")) then
{
	//Small Sandstorm Module
	["Killet's Modules", "Create Sandstorm", {[_this select 0] call klt_fnc_sandstormMod}] call Ares_fnc_RegisterCustomModule;						// Create Sandstorm
		call compile preprocessFile "scripts\KLT\Small_Sandstorm_Module\klt_fnc_Sandstrom.sqf";														//Compiles the function


		//Radio Jammer Module
	["Killet's Modules", "Create Radio Jammer", {[_this select 1] call KLT_fnc_RadioJammerGlobalModule;}] call Ares_fnc_RegisterCustomModule;		//Killets Jamming Module	
		[_this select 1] execVM "scripts\klt\RadioJammer\init_RadioJammer.sqf"; 																	//Init the jammer for clients.	
						
};	






