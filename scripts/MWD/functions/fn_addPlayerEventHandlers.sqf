/**
* Add player eventhandlers.
*/

// Dismiss the dog if the player gets killed
player addEventHandler ["Killed", {								
	_dog = player getVariable ["MWD_Dog", objNull];
	if (!isNull _dog) then {					
		// TODO: make the dog whine over the handlers dead body? :)
		// dismiss the dog
		"DISMISS" call MWD_fnc_setDogAction;			
	};	
	// Reset dog respawn timer
	player setVariable ["MWD_RespawnTimer", 0];
}];	
	
// Dismiss the dog if the player moves into a vehicle
player addEventHandler ["GetInMan", {
	_dog = player getVariable ["MWD_Dog", objNull];
	if (!isNull _dog) then {		
		"DISMISS" call MWD_fnc_setDogAction;			
	};
}];