/*
 * Author: ALIAS & Reeveli 
 * Part of Reeveli's Artillery system, alternative missile warhead.
 * Client side script to handle particle effects. Run on all clients.
 *
 * Arguments:
 * 0: Source object <OBJECT>
 * 1: Effect radius size <NUMBER> (default: 50)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [[_bomb_center, _effect_size],"scripts\Reeveli_artillery\AL_bomb\alias_bomb_effect.sqf"] remoteExec ["execVM"];
 *
 1.1
	Added Header
	Added default params
	Added additional safety check
	Privated variables
	Cleaned code
*/

params [
	["_bombix",objNull,[objNull],[]],
	["_size_rad",50,[0]]
];

if (!hasInterface) exitWith {};
if (isNull _bombix) exitWith {};

private _jdam_bomb = "Land_HelipadEmpty_F" createVehicleLocal getPosATL _bombix;

// splash foc
private _splash_hot = "#particlesource" createVehicleLocal getPosATL _jdam_bomb;
_splash_hot setParticleCircle [0,[0,0,0]];
_splash_hot setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,16,1], "", "Billboard", 1, 0.3, [0,0,10], [0,0,0],5,10,7,0.1, [100,80], [[1,1,1,1],[1,1,1,0]], [1], 1, 0, "", "",_jdam_bomb];
_splash_hot setDropInterval 0.1;
[_splash_hot] spawn {
	private _de_sters = _this select 0;
	sleep 0.5;
	deleteVehicle _de_sters;
};

// vapori
private _vapori_bmb = "#particlesource" createVehicleLocal getPosATL _jdam_bomb;
_vapori_bmb setParticleCircle [0, [0, 0, 0]];
_vapori_bmb setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_vapori_bmb setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1,0.5,[0,0,0],[0,0,3],0,10,7.9, 0, [10,200], [[1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 0, 0, "", "", _jdam_bomb];
_vapori_bmb setDropInterval 500;
[_vapori_bmb] spawn {
	private _de_sters = _this select 0;
	sleep 0.5;
	deleteVehicle _de_sters;
};

//lumina
private  _li_exp = "#lightpoint" createVehicle getPosATL _jdam_bomb;
_li_exp lightAttachObject [_jdam_bomb, [0,0,3]];
_li_exp setLightAttenuation [/*start*/ 0, /*constant*/0, /*linear*/ 0, /*quadratic*/ 0, /*hardlimitstart*/_size_rad,800];  
_li_exp setLightIntensity 1000;
_li_exp setLightBrightness _size_rad;
_li_exp setLightDayLight true;	
_li_exp setLightFlareSize 150;
_li_exp setLightFlareMaxDistance 2000;	
_li_exp setLightAmbient[1,0.2,0.1];
_li_exp setLightColor[1,0.2,0.1];

sleep 0.1;
private  _val_fum = "#particlesource" createVehicleLocal getPosATL _jdam_bomb;
_val_fum setParticleCircle [_size_rad/2, [10,10,0]];
_val_fum setParticleRandom [3,[0,0,30],[-60,-60,10],0,0.5,[0, 0, 0, 0.1],1,0];
_val_fum setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,24,1], "", "Billboard", 1, 6, [0,0,25],[0,0,0],5,30,7,0.1, [30,40,50], [[0, 0, 0, 1],[0.349,0.231,0.122,0.5],[0.349,0.231,0.122,0]], [1], 1, 0, "", "",_jdam_bomb];
_val_fum setDropInterval 0.0001;
[_val_fum] spawn {
	private _de_sters_v = _this select 0;
	sleep 2;
	deleteVehicle _de_sters_v;
};

[_jdam_bomb] spawn {
	private  _jdam_bomb = _this select 0;
	_delay_sound = linearConversion [0,2000,player distance _jdam_bomb,0,1.5,false];
	sleep _delay_sound;
	_jdam_bomb say3d ["bombix",2000];
};

if ((player distance _bombix < 2000)and((getPosATL player select 2) < 50)) then 
{
	enableCamShake true;
	_power_sh = linearConversion [0,2000,player distance _bombix,15,0.1,true];
	addCamShake [_power_sh,5, 50];
};

// scantei
private _scantei = "#particlesource" createVehicleLocal getPosATL _jdam_bomb;
_scantei setParticleCircle [_size_rad/2, [0, 0, 10]];
_scantei setParticleRandom [4, [1,1,0], [30,20,80], 0, 0.25, [0, 0, 0,1], 0, 0];
_scantei setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1,3,[0, 0, 0], [0,0,20],0,200,5,0, [1.5, 1.5, 0.5], [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _jdam_bomb];
_scantei setDropInterval 0.001;	
[_scantei] spawn {
	private _de_sters = _this select 0;
	sleep 0.3;
	deleteVehicle _de_sters
};

sleep 0.5;

_li_exp setLightBrightness 10;
[_li_exp,_jdam_bomb] spawn {
	private _lum_sters = _this select 0;
	private _j_bomb = _this select 1;
	sleep 1;
	_u=20;
	while {_u>0} do {
	_lum_sters setLightBrightness _u;
	_lum_sters lightAttachObject [_j_bomb, [random 200,random 200,random 200]];
	_u=_u-0.1;
	sleep 0.01;
	};
	sleep 0.01;
	deleteVehicle _lum_sters;
};
private _delay_ecko = linearConversion [0,2000,player distance _bombix,1,6,true];
sleep _delay_ecko;
playsound "bombix_echo";
enableCamShake false;
sleep 20;
deleteVehicle _jdam_bomb;