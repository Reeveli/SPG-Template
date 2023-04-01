if (isServer) then {al_duststorm_on = false;};																				//init default variable


defaultskill = 0.5;																										//The default skill, may take this default value from somewhere later

klt_fnc_sandstorm = 
{
	params [["_time",600],["_Visibility",0.2]];

	if (isDedicated) then {hint "sandstorm started";[] spawn klt_fnc_stormloop; [] spawn klt_fnc_stopstorm;};			//only runs in dedicated enviroment
	if (isServer && !isDedicated) then {hint "sandstorm started";[] spawn klt_fnc_stormloop; [] spawn klt_fnc_stopstorm;};	//For local hosted enviroment.
	if (!isnil "zm1") then {if (player == zm1) exitwith {hint "sandstorm started";};};										//Do not run for zeus entity
	if (!isnil "hq") then {if (player == hq) exitwith {hint "sandstorm started";};};										//Do not run for Commander
	if ((typeOf vehicle player == "B_Helipilot_F") OR (typeOf vehicle player == "B_officer_F")) exitwith {};				//Do not run If officer or pilot
	null = [340,_time,false,false,false,_Visibility] execvm "scripts\klt\sandstorm\AL_dust_storm\al_duststorm.sqf";			//Execute the sandstorm
};



//Reset skill function (Server only)
klt_fnc_stopstorm = 
{	
	waituntil {al_duststorm_on;};
	sleep 0.5;
	waitUntil {!al_duststorm_on;};

	{
		if ((side _x) == east) then
		{
			_x setSkill ["spotDistance", defaultskill];
			_X setSkill ["aimingAccuracy", defaultskill];
			_X setSkill ["aimingShake", defaultskill];
		};	
	} foreach allunits;

{
if ((side _x) == east) then
		
	{
			 private _group = group _x;
			_group setCombatMode "YELLOW";
	}; 
		}forEach allUnits;
};


//While the sandstorm is "ON" a loop will run to update all units to have their detection range set to 0.1 (Server only)
klt_fnc_stormloop = 
{ 
  {
	if ((side _x) == east) then
		{
			 
			 private _group = group _x;
			_group setCombatMode "WHITE";
			
		};
	} forEach allUnits;

	if (!isnil "stormloop_active") exitwith {};
	stormloop_active = true;

	[]spawn 
	{
		waitUntil {!isnil "al_duststorm_on";};
		while {al_duststorm_on;} do 
		{
			{
				if ((side _x) == east) then
				{
					_X setSkill ["spotDistance", 0.01];
					_X setSkill ["aimingAccuracy", 0.01];
					_X setSkill ["aimingShake", 0.01];
					_X setSkill ["spotTime", 0.01];
				};
			} forEach allUnits;
			sleep 15;
		};
	};

};
