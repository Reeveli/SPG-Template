
params ["_trgPos", "_trgDist", "_trgDir", "_group", "_trackIndex", "_posIndex"];		
	
// Create a somewhat "unique" ID for triggers and MWD_Debug markers
_triggerId = format ["%1-%2", _group, _trgPos joinString ":"];	
// Create local server trigger only (i.e. false), we only want the server to handle tracking triggers
_trg = createTrigger ["EmptyDetector", _trgPos, false];	
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setVariable ["triggerId", _triggerId];
_trg setVariable ["trackIndex", _trackIndex];
_trg setVariable ["posIndex", _posIndex];
_trg setVariable ["trackedGroup", _group];

_trg setTriggerStatements 
[
	//"this", // Trigger for all units
	"{_x iskindof 'Dog_Base_F'} count thislist > 0",
	"
	{
	  [_x, thisTrigger getVariable 'trackedGroup', thisTrigger getVariable 'trackIndex', thisTrigger getVariable 'posIndex'] remoteExec ['MWD_fnc_triggerActivation', _x];  
	} forEach thisList;
	",
	""
];

_trg setTriggerArea [MWD_TrackWidth, _trgDist, _trgDir, true];

// Create a marker for MWD_Debugging (this is not shown on a dedicated server)
if (!isDedicated && MWD_Debug) then {		
	_marker = createMarkerLocal [_triggerId, _trgPos];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerDirLocal _trgDir;
	_marker setMarkerSizeLocal [MWD_TrackWidth, _trgDist];
};

// Send marker for Curators Clients (so they can follow the track)
{
	[_triggerId, _trgPos, _trgDir, _trgDist] remoteExec ["MWD_fnc_createTrackMarker", getAssignedCuratorUnit _x];
} forEach allCurators;