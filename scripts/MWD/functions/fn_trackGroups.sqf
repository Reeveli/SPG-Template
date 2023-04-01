/**
* Server function to handle all "tracked" groups. 
* It places a "track trigger" at given intervals/distances between a groups positions.
*
*/
[] spawn {		
				
	while { sleep MWD_TrackCheckInterval; true } do { 
	
		_trackedGroups =  allGroups select {(_x getVariable ["MWD_Tracked", false])};						
		{
			_group = _x;												
			
			// Add trigger if someone in the tracked group is still alive
			if ({ alive _x } count units _group > 0) then {				
					
				_currentPosition = getPosATL leader _group; // current position of this tracked group						

				// Initalize tracks array if it does not exist, need to save it here since we only update it when new positions/triggers are placed
				_tracks = _group getVariable ["MWD_Tracks", []];
				if (count _tracks == 0) then {
					// All tracks laid by this group, defaults to an array with starting position
					_group setVariable ["MWD_Tracks", [[_currentPosition]]];					
					_tracks = _group getVariable "MWD_Tracks"; 
				};				
				
				_startNewTrack = false; // defaults to false, below logic might change that
				_stopCondition = false; // defaults to false, below logic might change that
				
				// Check if this group is on foot, or has entered a vehicle?				
				_isOnFoot = isNull objectParent leader _group;
				_wasOnFoot = _group getVariable ["MWD_OnFoot", true];
				if (!_isOnFoot && _wasOnFoot) then {
					// Unit has entered a vehicle, stop tracking until they disembark
					_group setVariable ["MWD_OnFoot", false];
					if (MWD_Debug) then {systemChat "Unit has entered a vechile, stop tracking";};
					_stopCondition = true;
				};				
				if (!_isOnFoot && !_wasOnFoot) exitWith {
					// Unit is still in the vehicle
					if (MWD_Debug) then {systemChat "Unit still in vehicle";};
				};												
				if (_isOnFoot && !_wasOnFoot) then {
					// Unit has exited the vehicle, start a new track
					if (MWD_Debug) then {systemChat "Unit exited the vehicle, start new track";};
					_group setVariable ["MWD_OnFoot", true];
					_startNewTrack = true;
				};
				
				// Check if this group is in water
				_isInWater = surfaceIsWater getPos leader _group;
				_wasInWater = _group getVariable ["MWD_InWater", false];
				if (_isInWater && !_wasInWater) then {
					if (MWD_Debug) then {systemChat "Unit is in water, stop tracking";};
					_group setVariable ["MWD_InWater", true];
					_stopCondition = true;
				};				
				if (_isInWater && _wasInWater) exitWith {
					// Unit is still in water
					if (MWD_Debug) then {systemChat "Unit still in water";};
				};				
				if (!_isInWater && _wasInWater) then {
					// Unit is now on land again, start a new track
					if (MWD_Debug) then {systemChat "Unit exited the water, start new track";};
					_group setVariable ["MWD_InWater", false];
					_startNewTrack = true;
				};

				// We need these calculations down below
				_positions = _tracks select (count _tracks - 1); // the current track (last in track array)
				_prevPosition = _positions select (count _positions - 1);
				_timer = _group getVariable ["MWD_LastPosTimer", 0];
				_distance = _currentPosition distance _prevPosition;
				// Check for un-normal move. If distance is to far (and unit didn't just exit a vehicle), maybe a curator moved the group?
				_movedToFar = _distance > (MWD_TriggerDistance * 2);

				// Start a new track
				if (_startNewTrack || _movedToFar) exitWith {						

					// Un-normal move, maybe a curator moved the group?
					if (_movedToFar && MWD_Debug) then {systemChat "Moved to far (curator move?)";};

					// Check if current track only contains two point that are close together, 
					// it could mean that the group is getting in and out of a vehicle on the same spot
					if (count _positions == 2) then {
						 _dist = (_positions select 0) distance (_positions select 1);
						 if (_dist <= 5 && MWD_Debug) then {
							 systemChat "Previous track contains two close points only, getting in and out of the vehicle?";
						 	//_tracks deleteAt (count _tracks - 1);
						};
					};											
					
					// New track, current position is the first in the array
					if (MWD_Debug) then {systemChat "Starting New Track";};
					_tracks pushBack [_currentPosition];
					_group setVariable ["MWD_Tracks", _tracks, true];					
				};
												
				// If the group has moved more than MWD_TriggerDistance meters since last check
				_distanceCondition = _distance > MWD_TriggerDistance;			
				// If the group has stopped and has moved more than 10 meters since last trigger
				_timerCondition =  _timer > 60 && _distance > 10 && (speed leader _group) == 0;																																
					
				// Finally, create a track trigger if one of the conditions are met
				if (_stopCondition || _distanceCondition || _timerCondition) then {
										
					// Add current position to positions array
					_positions pushBack _currentPosition;						
					// Reset timer when last position was recorded
					_timer = 0;
					// Add a trigger between the previous and current position
					_trgDist = (_prevPosition distance _currentPosition) / 2;
					_trgDir = _prevPosition getDir _currentPosition;
					_trgPos = _prevPosition getPos [_trgDist, _trgDir];
					[_trgPos, _trgDist, _trgDir, _group, count _tracks - 1, count _positions - 1] call MWD_fnc_createTrackTrigger;					
					
					// TODO: Remove tracks that contains only two points that are close together. When tracked units gets in and out of vechicles
					// on the same spot, tracks with two points close together gets created.					
					
					// Send track updates to all clients, hence "true" (so the dog client can act on them)					
					_group setVariable ["MWD_Tracks", _tracks, true];
				};
				
				if (MWD_Debug) then {
					//systemChat format ["(%1) T:%2, P:%3, D:%4", _group, count _tracks, count _positions, round _distance];
				};
				
				// Update track timer
				_group setVariable ["MWD_LastPosTimer", _timer + MWD_TrackCheckInterval];
				
			}; // end if
			
		} forEach _trackedGroups;
				
	}; // end while
}; // end spawn