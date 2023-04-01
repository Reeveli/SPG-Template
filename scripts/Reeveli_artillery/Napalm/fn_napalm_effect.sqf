/*
 * Author: ALIAS & Reeveli
 * Part of napalm system.
 * Function to create particle effects for naplam hits. Needs to be executed on each client. Execute in scheduled environtment.
 * Called from Rev_fnc_zeus_ordnance
 * Original script AL_napalm\alias_napalm_effect.sqf
 *
 * Arguments:
 * 0: Hit object <OBJECT>
 * 1: X vector <NUMBER> (Default: 0)
 * 2: Y vector <NUMBER> (Default: 0)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [_spot,_dir_x,_dir_y] remoteExec ["Rev_arty_fnc_napalm_effect",0,true];
 *
 */

if (!hasInterface) exitWith {};

params [
	["_source", objNull, [objNull]],
	["_dir_x",0,[0]],
	["_dir_y",0,[0]]
];


[_source] spawn {
	params [
		["_source", objNull, [objNull]]
	];
	
	private _delay_sound = linearConversion [0,2000,player distance _source,0,1.5,false];
	_dist_pitch = linearConversion [0,2000,player distance _source,1,0.01,true];

	sleep _delay_sound;
	if (isTouchingGround player) then {
		enableCamShake true;
		private _power_sh = linearConversion [0,1000,player distance _source,3,0,true];
		addCamShake [_power_sh,2,11]
	};

	_source say3d ["napalm",4000,_dist_pitch];

	private _eko = selectrandom ["eko_1","eko_2","eko_3"];
	sleep (5 + random 3);
	playsound _eko;
};

// scantei
private _ini_flame = "#particlesource" createVehicleLocal getPosATL _source;
_ini_flame setParticleCircle [0,[0,0,0]];
_ini_flame setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0];
_ini_flame setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16,0,32,0],"","Billboard",1,1,[0,0,2],[0,0,0],0,10,8,0,[80],[[1,1,1,1]],[3],0,0,"","",_source];
_ini_flame setDropInterval 100;	

[_ini_flame] spawn {
	private _de_sters = _this select 0;
	sleep 1;
	deleteVehicle _de_sters;
};

// scantei
private _scantei = "#particlesource" createVehicleLocal getPosATL _source;
_scantei setParticleCircle [20,[40,40,50]];
_scantei setParticleRandom [1,[5,5,5],[30,30,20],0,0.1,[0,0,0,0.1],1,0];
_scantei setParticleParams [["\A3\data_f\cl_exp",1,0,1],"","Billboard",1,3,[0,0,5],[_dir_x,_dir_y,0],0,300,10,15,[1.5,0.5],[[1,1,1,1],[1,1,1,1]],[1],1,0,"","",_source,0,false,-1,[[1,0.1,0,1]]];
_scantei setDropInterval 0.005;	

[_scantei] spawn {
	private _de_sters = _this select 0;
	sleep 0.5;
	deleteVehicle _de_sters;
};

// fum alb
private _wave = "#particlesource" createVehicleLocal getPosATL _source;
_wave setParticleCircle [30,[30,30,0]];
_wave setParticleRandom [0.1,[3,3,0],[-20,-20,0],0,0.1,[0,0,0,0.1],0,0];
_wave setParticleParams [["\A3\data_f\cl_basic.p3d",1,0,1],"","Billboard",1,2,[0,0,0],[0,0,0],0,17,13,0,[15,30],[[1,1,1,0.3],[0,0,0,0]],[1],0,0,"","",_source];
_wave setDropInterval 0.005;

[_wave] spawn {
	private _de_sters = _this select 0;
	sleep 0.5;
	deleteVehicle _de_sters;
};

// vapori
private _vapori_nap = "#particlesource" createVehicleLocal getPosATL _source;
_vapori_nap setParticleCircle [0,[0,0,0]];
_vapori_nap setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0];
_vapori_nap setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1,0.6,[0,0,0],[0,0,1],0,10,8,0,[50,100,200],[[1,1,1,0.5],[1,1,1,0.3],[1,1,1,0]],[0],0,0,"","",_source];
_vapori_nap setDropInterval 0.3;

[_vapori_nap] spawn {
	private _de_sters = _this select 0;
	sleep 0.6;
	deleteVehicle _de_sters;
};

// scantei
private _foc = "#particlesource" createVehicleLocal getPosATL _source;
_foc setParticleCircle [10,[1,1,0]];
_foc setParticleRandom [0.1,[5,5,2],[-1,-1,0],3,0.1,[0,0,0,0.1],1,0];
_foc setParticleParams [["\A3\data_f\cl_exp",1,0,1],"","Billboard",1,2,[0,0,1],[_dir_x,_dir_y,0],13,10.1,7,1,[20,25,30],[[1,1,1,1],[1,1,1,0.3],[1,1,1,0]],[1],1,0,"","",_source];
_foc setDropInterval 0.1;	

[_foc] spawn {
	private _de_sters = _this select 0;
	sleep 1;
	deleteVehicle _de_sters;
};

private _fum_alb = "#particlesource" createVehicleLocal getPosATL _source;
_fum_alb setParticleCircle [20,[0,0,0]];
_fum_alb setParticleRandom [0.2,[1,1,2],[0,0,1],2,0.1,[0,0,0,0.1],1,0];
_fum_alb setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1,7,[0,0,0],[_dir_x,_dir_y,3],5,10,7.9,0.1,[10,60,80],[[1,1,1,0.3],[1,1,1,0.2],[1,1,1,0]],[0],1,0,"","",_source];
_fum_alb setDropInterval 0.1;

[_fum_alb] spawn {
	private _de_sters = _this select 0;
	sleep 2;
	deleteVehicle _de_sters;
};

//lumina
private _li_exp = "#lightpoint" createVehicle getPosATL _source;
_li_exp lightAttachObject [_source, [0,0,3]];
_li_exp setLightAttenuation [0,0,0,0,40,600];  
_li_exp setLightIntensity 500;
_li_exp setLightBrightness 10;
_li_exp setLightDayLight true;	
_li_exp setLightUseFlare true;
_li_exp setLightFlareSize 100;
_li_exp setLightFlareMaxDistance 2000;	
_li_exp setLightAmbient[1,0.2,0.1];
_li_exp setLightColor[1,0.2,0.1];

[_li_exp] spawn 
{
	private _lum_sters = _this select 0;
	sleep 1;
	private _u=5;
	while {_u>0} do 
	{
		_lum_sters setLightBrightness _u;
		_u=_u-0.2;
		sleep 0.1;
	};
	sleep 0.5;
	deleteVehicle _lum_sters;
};

//Flying 'spark' particles
fnc_nap_schija = {
	private ["_buc_nap"];
	_buc_nap = _this select 0;
	_fum_buc = "#particlesource" createVehicleLocal getpos _buc_nap;
	_fum_buc setParticleCircle [0,[0,0,0]];
	_fum_buc setParticleRandom [0.1,[0.3,0.3,0.3],[0,0,0],0.3,0.1,[0,0,0,0.1],0,0];
	_fum_buc setParticleParams [["\A3\data_f\cl_basic.p3d",1,0,1],"","Billboard",1, 2+random 3,[0,0,0],[0,0,0.5],0,10.1,7.9,0.01,[1,3,5],[[1,1,1,1],[1,1,1,0.3],[1,1,1,0]],[0],0,0, "", "", _buc_nap];
	_fum_buc setDropInterval 0.02;
};

private _sparks = floor (3+random 7);
while {_sparks>0} do 
{
	private _vit_z = 10+random 50;
	private _vit_x = (selectRandom [1,-1]) * floor (10+random 30);
	private _vit_y = (selectRandom [1,-1])* floor (10+random 30);
	private _buc_nap = "Land_Battery_F" createVehicleLocal [getPosATL _source select 0,getPosATL _source select 1,5];
	[_buc_nap] call fnc_nap_schija;
	_buc_nap setVelocity [_vit_x,_vit_y,_vit_z];
	[{params ["_object"];deleteVehicle _object;}, [_buc_nap], 4] call CBA_fnc_waitAndExecute;
	_sparks = _sparks-1;
};