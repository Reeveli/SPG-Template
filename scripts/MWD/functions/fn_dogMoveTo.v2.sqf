params ["_moveToPosition"];	

_dog = player getVariable ["MWD_Dog", objNull];
if (isNull _dog) exitWith {};

// If the dog is currently following a path, just exit and let it finish
_scriptHandle = _dog getVariable ["MWD_MoveToScriptHandle", objNull];
if (!isNull _scriptHandle) exitWith {};

// Calculate a path that a normal human would take
private _agent = createAgent [typeOf player, getPosATL _dog, [], 0, "NONE"];
_agent addEventHandler ["PathCalculated", { 
	params ["_agent", "_path"];

	systemChat "fn_dogMoveTo: calculating path";
	_dog = player getVariable ["MWD_Dog", objNull];
	if (isNull _dog) exitWith {};
	
	if (MWD_Debug) then {		
		{								
			_markerName = str _forEachIndex;
			deleteMarker _markerName;
			_marker = createMarker [_markerName, _x]; 
			_marker setMarkerType "mil_dot"; 
			_marker setMarkerText str _forEachIndex;				
		} forEach _path;
	};

	_scriptHandle = [_dog, _path] spawn {				
		params ["_dog", "_path"];
		
		//_lastPathPos = _path select count _path - 1;
		
		{	
			if (MWD_Debug) then {
				systemChat "fn_DogMoveTo";
				_markerName = "currentPosMarker";
				deleteMarker _markerName;
				_marker = createMarker [_markerName, _x]; 
				_marker setMarkerType "mil_dot"; 
				_marker setMarkerColor "ColorRed"; 				
			};
					
			_dog setDestination [_x, "LEADER DIRECT", false];						
			
			waitUntil {								
				// Check for reasons to stop (external scripts/logic use this variable)
				if (_dog getVariable ["MWD_MoveToBreak", false]) exitWith {
					_dog setVariable ["MWD_MoveToBreak", false];
					terminate _thisScript;
					true
				};
				// Check for animation locks, speed is 0 when this happens. 
				// Terminate script and start over
				if (speed _dog < 1) exitWith {
					_dog setVariable ["MWD_AnimationLockDetected", true];	
					_dog setVariable ["MWD_MoveToBreak", true];
					true
				};
				// Are we still alive?
				if (!alive _dog) exitWith {true};
				// Are we still tracking?
				if (_dog getVariable ["MWD_Status", ""] != "TRACKING") exitWith {true};
				// Wait until agent is close to current position before moving on to the next
				_dog distance2D _x <= 5				
			};			
			
		} forEach _path;				
		
	};	
	_dog setVariable ["MWD_MoveToScriptHandle", _scriptHandle];

}];
// Let the agent simulate the path
_agent setDestination [_moveToPosition, "LEADER PLANNED", true];
// Shall we remove the agent?
deleteVehicle _agent;