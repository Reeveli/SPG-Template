params ["_sayWhat", ["_likelihood", 1]];

_dog = player getVariable ["MWD_Dog", objNull];
if (isNull _dog) exitWith {};
if ( random 1 > _likelihood ) exitWith {};

if (MWD_Debug) then {
	systemChat format ["MWD_fnc_dogSay '%1'", _sayWhat];
};

_sound = "";

switch _sayWhat do {

	case "bark": {
		_sound = selectRandomWeighted ["bark_single", 0.1, "barks_double", 0.4, "barks", 0.5];
	};
	
	case "barking": {
		_sound = selectRandomWeighted ["barks_pants", 0.5, "barks_whiney", 0.5];
	};
	
	case "whining": {	
		_sound = selectRandomWeighted ["pants_barks_lite", 0.3, "pants_whines", 0.5, "whine_calling_out", 0.3, "whine_passing_by", 0.5, "whine_pleading_2", 0.2];
	};
	
	default {
		_sound = "barks";
	};
};

playSound3D [getMissionPath format ["scripts\mwd\sfx\%1.ogg", _sound], _dog, false, getPosASL _dog, 5, 1, 100];