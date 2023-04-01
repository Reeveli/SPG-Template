	params ["_position"];
	_sandpos = "Land_ClutterCutter_small_F" createVehicle _position;
	[_sandpos, -1, 0.8, false] call BIS_fnc_sandstorm;