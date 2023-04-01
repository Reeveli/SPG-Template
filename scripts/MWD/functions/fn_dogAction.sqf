/**
* Action loop for the dog. Depending on status, the dog will behave accordingly.
*/
params ["_dog"];

[_dog] spawn { 
	params ["_dog"]; 			

	// Start walking on spawn
	"Dog_Walk" call MWD_fnc_dogPlayMove;
	
	while { sleep 2.5; alive _dog } do { 
						
		_dogAction = _dog getVariable ["MWD_Status", ""];
		
		if (MWD_Debug) then {
			//systemChat format ["MWD_fnc_dogAction: %1", _dogAction];			
		};								
								
		// Check nearby men, see if the dog reacts to people that are not members of the handlers group
		_nearestObjects = nearestObjects [_dog, ["CAManBase"], 40];
		_nearbyStranger = objNull;
		scopeName "nearbyCheck";
		{
			// Check if someone outside the handlers group is nearby
			if !(group _x isEqualTo group player) then {
										
				_trackedGroup = _dog getVariable ["MWD_TrackedGroup", objNull];
				
				switch true do {	
				
					case (_dogAction == "TRACKING" && (group _x isEqualTo _trackedGroup)) : {
						// Tracked group is close, let the dog react to that
						_dogAction = "WINDSOUND";
						_nearbyStranger = _x;
						breakTo "nearbyCheck";
					};
				};										
			};					
		} forEach _nearestObjects;												
		
		_distanceToHandler = _dog distance player;
		// Stop and wait for handler if distance is more than 30 meters (the dog is in a virtual leach)
		_waitForHandler = _distanceToHandler > 30;		
		
		switch (_dogAction) do {
			
			case "SEARCH_EXPLOSIVES": {
				//_mines = [ nearestObject [ player, "MineBase" ], nearestObject [ player, "TimeBombCore" ] ];
				//_nearest = [ +_mines, [], { _x distanceSqr player }, "ASCEND", { !isNull _x } ] call BIS_fnc_sortBy select 0;
				
			};

			case "WINDSOUND": {										
				// Tracked group is close, let the dog walk slowly, step by step in that direction
				if (MWD_Debug) then {											
					systemChat format ["Wind/sound mark: %1", _nearbyStranger];								
				};					
				_dog setVariable ["MWD_MoveToBreak", true];
				"Dog_Idle_Growl" call MWD_fnc_dogPlayMove;
				sleep 1;
				_dog setDestination [getPosATL _nearbyStranger, "LEADER DIRECT", false];
				["barking", 1] call MWD_fnc_dogSay;
				sleep 3;
				"Dog_Walk" call MWD_fnc_dogPlayMove;												
			};
			
			case "TRACKING": {
			
				// Check for "animation locks", often happens if dog is sprinting downhills
				if (_dog getVariable ["MWD_AnimationLockDetected", false]) exitWith {
					
					// Dog might have stopped to let handler catch up, check that first
					if (_waitForHandler) exitWith {};

					if (MWD_Debug) then {
						systemChat format ["Speed: %1 - Animation lock (or waited for handler to catch up)", speed _dog]; 
					};
					// We need to empty the animation queue (switchMove), can't use run or sprint, it will cause the animation to "lock" again					
					_dog switchMove "Dog_Walk";
					_dog setVariable ["MWD_AnimationLockDetected", false];										
					
				};
				
				_trackedGroup = _dog getVariable "MWD_TrackedGroup";				
				_tracks = _trackedGroup getVariable "MWD_Tracks";
				_trackIndex = _dog getVariable "MWD_TrackIndex";
				_positions	= _tracks select _trackIndex;
				_trackPosIndex = _dog getVariable "MWD_TrackPosIndex";
				_trackEndPos = _positions select _trackPosIndex;
				_distToTrackingPos = _dog distance _trackEndPos;
				_trackDir = _dog getDir _trackEndPos;
				_distToTrackedGroup = _dog distance leader _trackedGroup;				
				
				if (MWD_Debug) then {											
					systemChat format ["Tracking index (T:P): %1:%2 (of %3)", _trackIndex, _trackPosIndex, count _positions - 1];
					systemChat format ["Near %1", _nearestObjects];
					systemChat format ["DH: %1, DEP: %2", _distanceToHandler, _distToTrackingPos];						
				};
								
				// Use custom move function using the same path a human would take, for some reason dogs (agents) will not take the shortest path to target by default
				[_trackEndPos] call MWD_fnc_dogMoveTo;				
				
				switch true do {										
					case (_distToTrackingPos <= 6) : {					
						if (_trackPosIndex == count _positions - 1) then {
							
							// Reached end of track, stop and whine
							"Dog_Walk" call MWD_fnc_dogPlayMove;
							
							["whining", 0.3] call MWD_fnc_dogSay;
							
							if (!([_trackedGroup, _trackIndex] in (_dog getVariable ["MWD_CompletedTracks", []]))) then {
								// Add in-game lost track marker
								_dog getVariable ["MWD_Markers3D", []] pushBack [getPos _dog, "Trace Lost"];
								// Add automarker on handlers map
								[getPos _dog, _dog getDir _trackEndPos] call MWD_fnc_autoMarker;
								// Add this track [trackedGroup, trackIndex] to completed tracks array
								_dog getVariable "MWD_CompletedTracks" pushBack [_trackedGroup, _trackIndex];																
							
								if (MWD_Debug) then {
									systemChat format ["Reached end of track"];																
								};
							};							
						}
						else {
							// Ok, close enough to current track position, switch to the next track position
							_dog setVariable ["MWD_TrackPosIndex", _trackPosIndex + 1];
							// Quick fix to tell moveTo function (spawn loop) that a new target has been set (see MWD_fnc_moveTo)
							_dog setVariable ["MWD_MoveToBreak", true];							
							// Add automarker on handlers map
							[getPos _dog, _dog getDir _trackEndPos] call MWD_fnc_autoMarker;
							// Add 3D marker for in-game positions (used in eventhandler "Draw3D", see MWD_fnc_triggerActivation)
							_nextTrackEndPos = _positions select _trackPosIndex + 1;
							_dog getVariable ["MWD_Markers3D", []] pushBack [getPos _dog, format ["%1 °", round (_dog getDir _nextTrackEndPos)]];
						};
					};
					case (_waitForHandler) : {
						// Stop and wait for handler to catch up
						"Dog_Stop" call MWD_fnc_dogPlayMove;
						["whining", 0.3] call MWD_fnc_dogSay;
					};						
					case (_distanceToHandler < 10) : {
						// Use random move to "un-lock" animation locks
						selectRandomWeighted ["Dog_Sprint", 0.8, "Dog_Run", 0.2] call MWD_fnc_dogPlayMove;
						// TODO: Play panting sound every now and then, need to find good sounds
						//["panting", 0.05] call MWD_fnc_dogSay;
					};
					default {
						// Use random move to "un-lock" animation locks						
						selectRandomWeighted ["Dog_Sprint", 0.8, "Dog_Run", 0.2] call MWD_fnc_dogPlayMove;
					};						
				};										
			};																
			
			case "HEEL": {										
				switch true do {						
					case (_distanceToHandler > 10) : {
						// Sprint in handler direction
						_dog setDestination [getPos player, "LEADER DIRECT", false];
						"Dog_Sprint" call MWD_fnc_dogPlayMove;						
					};												
					default {
						// Try to stay at left side of handler
						_dog setDestination [player getRelPos [2, 280], "LEADER DIRECT", false];
						"Dog_Walk" call MWD_fnc_dogPlayMove;						
						["whining", 0.05] call MWD_fnc_dogSay;
					};						
				};										
			};
			
			case "STAY": {						
				"Dog_Sit" call MWD_fnc_dogPlayMove;
				_dog lookAt player;
				["whining", 0.1] call MWD_fnc_dogSay;
				// TODO: make the dog turn smoothly towards the player whilst sitting down
				// setDir is not good enough
			};
			
			case "DISMISS": {														
				// Dismiss the dog with a whining				
				["whining", 1] call MWD_fnc_dogSay;
				sleep 1;
				// Delete dog and reset player dog variable so a new one can be respawned
				deleteVehicle _dog;	
				player setVariable ["MWD_Dog", objNull];
			};
			
			default {
				// Free search mode, stick around, close and in front of the handler. If the dog finds a track, it will start tracking directly
				_dog setDestination [player getPos [15, direction player], "LEADER DIRECT", false];
				"Dog_Run" call MWD_fnc_dogPlayMove;				
			};
			
		}; // end switch
	}; // end while
}; // end spawn