/**
	Spawns and returns a new dog instance.

	Dog internal variables used by script logic:
	
	MWD_Status - used to determine dog behaviour/actions
	MWD_TrackedGroup - ref to currently tracked group	
	MWD_TrackIndex - ref to current track index
	MWD_TrackPosIndex - ref to current track position
	MWD_CurrentMove - the current move animation
	MWD_Markers3D - array of custom track markers for in-game 3D drawing
	MWD_Draw3DEventHandlerId - handle to event handler so we can delete it when we don't need it anymore
	MWD_CompletedTracks - array of [trackedGroup, trackIndex] i.e tracks that has been followed to the end
	                      the dog should not be interested in picking up old tracks again	
*/

_dog = player getVariable ["MWD_Dog", objNull];

if (isNull _dog) then {	

	// Check if respawn is allowed yet
	_respawnTime = player getVariable ["MWD_RespawnTimer", 0];
	_respawnAllowed = time >= _respawnTime;
	if (!_respawnAllowed) exitWith {
		_respawnMsg = format ["Dog respawn allowed in %1 seconds", round (_respawnTime - time)];
		titleText ["\n\n"+_respawnMsg, "PLAIN"];
		titleFadeOut 7;
		systemChat _respawnMsg;
	};

	// Spawn dog 	
	_dogType = player getVariable ["MWD_DogType", ""];
	if (_dogType == "") then {
		_dogType = selectRandomWeighted ["Alsatian_Black_F", 0.5, "Alsatian_Sandblack_F", 0.5, "Alsatian_Sand_F", 0.3];
	};

	_playersFrontPos = player getRelPos [2, 360];
	_dog = createAgent [_dogType, _playersFrontPos, [], 0, "CAN_COLLIDE"];	
	// Set object name of the dog (just for better debug transcripts)
	_dog setVehicleVarName format ["%1's dog", name player];
	// Disable animal behaviour 
	_dog setVariable ["BIS_fnc_animalBehaviour_disable", true]; 
	_dog setBehaviour "CARELESS";
	_dog disableAI "FSM";
	
	// Face the same direction as player on spawn
	_dog setDir direction player;
	
	// Initialize dog internal variables
	_dog setVariable ["MWD_CompletedTracks", []];
	_dog setVariable ["MWD_CurrentMove", ""];
	
	// Reset dog variable on handler if it gets killed
	_dog addEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		
		player setVariable ["MWD_Dog", objNull];
		player setVariable ["MWD_DogType", ""];
		
		// If the dog handler kills her/his dog, double the respawn timer
		if (_killer isEqualTo player) then {
			_respawnMsg = format ["You killed your dog, respawntime extended."];
			titleText ["\n\n"+_respawnMsg, "PLAIN"];
			titleFadeOut 7;
			systemChat _respawnMsg;
			player setVariable ["MWD_RespawnTimer", time + (MWD_Respawn * 2)];
		} 
		else {
			// Set respawn timer i.e. when the dog is allowed to respawn again
			player setVariable ["MWD_RespawnTimer", time + MWD_Respawn];
		};						
		
		// Remove any eventhandlers 
		evId = _unit getVariable ["MWD_Draw3DEventHandlerId", -1];
		if (evId > -1) then {
			removeMissionEventHandler ["Draw3D", evId];
			_dog setVariable ["MWD_Draw3DEventHandlerId", -1];
		};
	}];
		
	// Save dog on player's variables
	player setVariable ["MWD_Dog", _dog];
	player setVariable ["MWD_DogType", _dogType];
	player setVariable ["MWD_RespawnTimer", 0];
	
	// Start in HEEL mode
	_dog setVariable ["MWD_Status", "HEEL"];
	// Start action loop - let it live!
	_dog call MWD_fnc_dogAction;
};	
_dog;