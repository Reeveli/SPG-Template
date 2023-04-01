	
_dog = player getVariable ["MWD_Dog", objNull];
if (isNull _dog) exitWith {};

if (!isNull _dog) then {
	_dog setVariable ["MWD_Status", "DISMISS"];		

	// Reset dog tracking variables
	_dog setVariable ["MWD_TrackedGroup", objNull];		
		
	// Remove any eventhandlers 
	evId = _dog getVariable ["MWD_Draw3DEventHandlerId", -1];
	if (evId > -1) then {
		removeMissionEventHandler ["Draw3D", evId];
		_dog setVariable ["MWD_Draw3DEventHandlerId", -1];
	};
	
	// Dismiss the dog with a whining
	["whining", 1] call MWD_fnc_dogSay;
	deleteVehicle _dog;
	
};