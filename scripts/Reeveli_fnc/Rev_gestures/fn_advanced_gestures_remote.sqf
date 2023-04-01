/*
 * Author: Reeveli 
 * Part of Reeveli's Advanced Gestures system.
 * Client side function to start create remote eventhandler when a gesture is made by another player. Called as a postinit function.
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * call Rev_fnc_advanced_gestures_remote
 *
 */

if !(hasInterface) exitWith {};
if !(Rev_advanced_gestures_enable) exitWith {};

//Code block for remote eventhandler
private _code2 = {
	params ["_unit","_hint"];
	if (isNull _unit) exitWith {diag_log "Rev_advanced_gestures_remote, exit: objNull as param";};
	if (count _hint < 1) exitWith {diag_log "Rev_advanced_gestures_remote, exit: No string as as param";};
	diag_log format ["Rev_advanced_gestures_remote, 3d text shown: %1", _hint];
	
	//Removing EH incase previous one is still active
	removeMissionEventHandler ["Draw3D", missionNameSpace getVariable ["Rev_advanced_gestures_EH",-1]];

	//PerFrame EH to draw hint text	
	private _id = addMissionEventHandler ["Draw3D",
		{
			drawIcon3D ["", Rev_advanced_gestures_color, (_thisArgs select 0) modelToWorldVisual [0,0,Rev_advanced_gestures_offset], 0, 0, 0, (_thisArgs select 1), 0, Rev_advanced_gestures_size_3d, Rev_advanced_gestures_font,"center",true];
			
		},
		[_unit,_hint]
	];
	//Store id for later removal
	missionNameSpace setVariable ["Rev_advanced_gestures_EH",_id,false];

	//Remove PF EH after 5s
	[{
		removeMissionEventHandler ["Draw3D", param [0]];
	}, [_id], Rev_advanced_gestures_duration] call CBA_fnc_waitAndExecute;


};

//Remote eventhandler
["Rev_advanced_gestures_remote", _code2] call CBA_fnc_addEventHandler;
