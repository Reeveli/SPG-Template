//Executed when player is killed in singleplayer or in multiplayer mission. 						 //
params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];										 //							 //
//poldUnit: Object killer: Object respawn: String respawnDelay: Number								 //
///////////////////////////////////////////////////////////////////////////////////////////////////////

//Curator notification
private _name = name player;
private _allCuratorLogics = allCurators;
{
	private _unit = getAssignedCuratorUnit _x;
	[objNull, format ["%1 has died!",_name]] remoteExecCall ["BIS_fnc_showCuratorFeedbackMessage",_unit];
	["FD_Course_Active_F"] remoteExecCall ["playSound",_unit];
} forEach _allCuratorLogics;
