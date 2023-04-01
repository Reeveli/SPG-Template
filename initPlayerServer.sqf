//Executed only on server when a player joins mission (includes both mission start and JIP).		  //
params ["_playerUnit", "_didJIP"];																	  //
//playerUnit: Object didJIP: Boolean																  //
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Description: Unassign zeus slots when not ready on the server.
{
	if (!isnull (getassignedcuratorunit _x)) then {
		_unit = getassignedcuratorunit _x;
		if (isnull (getassignedcuratorlogic _unit)) then {
			unassignCurator _x;
			sleep 1;
			_unit assignCurator _x;
			if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
				_unit call TFAR_fnc_isForcedCurator;
			};
		};
	};
} foreach allcurators;