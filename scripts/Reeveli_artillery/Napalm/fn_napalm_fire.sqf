/*
 * Author: ALIAS, Reeveli
 * Function to create particle effects for fire created by naplam hits.
 * Needs to be executed on each client. Execute in scheduled environtment.
 * Called from Rev_arty_fnc_napalm_hit
 *
 * Arguments:
 * 0: Hit object <OBJECT>
 * 1: Diamater value <NUMBER> (Default: 60) Not the real diamater but a larger value used for calculations
 * 2: Flame size <NUMBER> (Default: 10)
 * 3: Brightness <NUMBER> (Default: 10)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [_source,_diameter,_flame_size,_brightness] remoteExec ["Rev_arty_fnc_napalm_fire",0,true];
 *
 */

if (!hasInterface) exitWith {};

params [
	["_source", objNull, [objNull]],
	["_diameter",60,[0]],
	["_flame_size",10,[0]],
	["_brightness",10,[0]]
];


//inline function
fnc_fire_deco_SFX = {
	params [
		["_source", objNull, [objNull]],
		["_diameter",60,[0]],
		["_flame_size",10,[0]]
	];
	
	private _fum_mare = "#particlesource" createVehicleLocal (getPosATL _source);
	_fum_mare setParticleCircle [0,[0,0,0]];
	_fum_mare setParticleRandom [7,[_diameter/4,_diameter/4,0],[-2,-2,0],5,0.5,[0,0,0,0.1],1,0];
	_fum_mare setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,30,[0,0,-5],[1,1,4],13,10,7.9,0.1,[10,15,30,40,60],[[0,0,0,0.1],[0,0,0,0.5],[0.2,0.2,0.2,0.2],[0.5,0.5,0.5,0.1],[0.5,0.5,0.5,0]],[0.5],1, 0, "", "", _source];
	_fum_mare setDropInterval 0.1;

	private _fum_foc = "#particlesource" createVehicleLocal (getPosATL _source);
	_fum_foc setParticleCircle [0,[0,0,0]];
	_fum_foc setParticleRandom [0.1,[_diameter/2.5,_diameter/2.5,2],[0,0,0],11,0.1,[0,0,0,0],0,0];
	_fum_foc setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard",1,10,[0,0,0],[0,0,0],7,10,7.9,0,[_flame_size*2,_flame_size,_flame_size*3],[[1,0.3,0.01,0],[0.5,0,0,1],[0.5,0.1,0,0]],[1], 1, 0, "", "", _source];
	_fum_foc setDropInterval 0.1;

	// flama
	private _flama = "#particlesource" createVehicleLocal (getPosATL _source);
	_flama setParticleCircle [0,[0,0,0]];
	_flama setParticleRandom [1,[_diameter/2,_diameter/2,0],[0,0,0],0.1,0.1,[0,0,0,0.1],1,0];
	_flama setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",1,30,[0,0,0],[0,0,0],0,10.07,7.9,0,[_flame_size,_flame_size,_flame_size],[[1,1,1,0],[1,1,1,1],[1,1,1,0]],[0.8],0, 0, "", "", _source,0,true];
	_flama setDropInterval 0.5;

	// refrct
	private _caldura = "#particlesource" createVehicleLocal (getPosATL _source);
	_caldura setParticleCircle [0,[0,0,0]];
	_caldura setParticleRandom [0,[_diameter/3,_diameter/3,0],[0.175,0.175,0],0,0.25,[0,0,0,0.1],0,0];
	_caldura setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1],"","Billboard",1,10,[0,0,0],[0,0,0.75],30,10.2,7.9,0.1,[_flame_size*2,_flame_size*2,_flame_size*2],[[1,1,1,0],[1,1,1,0.5],[1,1,1,0]],[0.08],1,0,"","",_source];
	_caldura setDropInterval 0.5;

	waitUntil {isNil{_source getVariable "on_alias_fire"} or (!alive _source)};
	deleteVehicle _flama;
	deleteVehicle _caldura;
	deleteVehicle _fum_foc;
	deleteVehicle _fum_mare;
};




//If source is already emitting effect
if (isNil {_source getVariable "on_alias_fire"}) exitWith {};

//creating lightpoint
private _luminafoc = "#lightpoint" createVehicleLocal (getposATL _source); 
_luminafoc lightAttachObject [_source,[0,0,10]];
_luminafoc setLightAttenuation [/*start*/0.2,/*constant*/0,/*linear*/50, /*quadratic*/0, /*hardlimitstart*/_diameter/8,/* hardlimitend*/_diameter*5];
_luminafoc setLightBrightness _brightness;
_luminafoc setLightAmbient [1,0.1,0];
_luminafoc setLightColor [1,0.1,0];
_luminafoc setLightDayLight true;


[_luminafoc,_source,_diameter,_brightness] spawn 
{
	_luminafoc_tmp	= _this select 0;
	_source_tmp		= _this select 1;
	_diameter_tmp	= _this select 2;
	_brightness		= _this select 3;
	
	private _radius_curr = _diameter_tmp/2;
	while {(_source_tmp getVariable "on_alias_fire")&&(alive _source_tmp)} do 
	{
		_luminafoc_tmp setLightBrightness _brightness+(random 1);
		_luminafoc_tmp setLightAttenuation [0.1,0,0,0,0,_radius_curr*10];
		if (player distance _source_tmp < _radius_curr+8) then {player setVariable ["set_on_fire",true,true]};
		sleep 0.5;
	};
	private _brit = 3;
	while {_brit>0} do 
	{
		_luminafoc_tmp setLightBrightness _brit;
		_brit = _brit-0.13;
		sleep 0.1;
	};
	deleteVehicle _luminafoc_tmp;	
};


[_source,_diameter] spawn 
{
	_source_tmp		= _this select 0;
	_diameter_tmp	= _this select 1;
	while {(_source_tmp getVariable "on_alias_fire")&&(alive _source_tmp)} do 
	{
		_source_tmp say3D ["furnal",_diameter_tmp*10];
		sleep 4;
	};
};
	
[_source,_diameter,_flame_size] call fnc_fire_deco_SFX;