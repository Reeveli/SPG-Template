/*
	author: 10Dozen, modified by Reeveli
	description: Process flare illumination effect on given round and type
	input: 	0: OBJECT - projectile to attach
			1: STRING - round type ("Mortar" or "Howitzer" shell)
			2: BOOLEAN - is flare star needed (for fnc_spawnShell call)
	returns: nothing
*/

params["_object","_type","_star"];

private _enabled = true;
private _color = [1,1,1];
private _range = 0;
private _intensity = 0;
private _deviation = 0;

switch toLower(_type) do {
	case "mortar": {
		_range = 400;
		_intensity = 10;
		_deviation = 25;
		_color = [1,1,0.5];
	};
	case "howitzer": {
		_range = 600;
		_intensity = 10;
		_deviation = 25;
		_color = [1,1,0.5];
	};
};

if !(_enabled) exitWith {};

if (!_star) then {
	waitUntil { velocity _object select 2 < 0 };
};

private _flareStars = [];
if (_star) then {	
	private _flareStar = objNull;
	for "_i" from 1 to (if (_type == "mortar") then { 0 } else { 1 }) do {
		_flareStar = "F_40mm_White_Infinite" createVehicleLocal [0,0,0];
		_flareStar attachTo [_object, [0,0,0]];
		_flareStars pushBack _flareStar;
	};
};

private _flare = "#lightpoint" createVehicleLocal (getPosVisual _object);
_flare setLightAmbient _color;
_flare setLightColor _color;
_flare setLightIntensity _intensity;
_flare setLightUseFlare true;
_flare setLightAttenuation [_range, 1, 100, 0, 50, (_range - 10)];
_flare setLightDayLight false;
_flare attachTo [_object, [0,0,0]];

private _h = getPos _object select 2;
_range = _range / 2 / 240;

while { _h > 1  } do {
	sleep ((random 0.01) + 0.05);
	_flare setLightIntensity (_intensity + random (_intensity*_deviation/100));
	_flare setLightAttenuation [2.5*_h*_range, 1, 0, 4.31918e-005, 50, 2.5*_h*_range + 50];

	_h = getPos _object select 2;
	if (_h <= 1) exitWith { deleteVehicle _flare; };
};

{ deleteVehicle _x } forEach _flareStars;
deleteVehicle _flare;