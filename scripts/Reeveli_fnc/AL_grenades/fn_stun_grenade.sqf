/*
 * Author: ALIAS, modified by Reeveli
 * Particle and postprocess effects of custom flashbang.
 *
 * Arguments:
 * 0: Grenade <PROJECTILE>
 *
 * Return Value: <BOOL>
 *
 * Example:
 * [_grenade] remoteExec ["AL_fnc_stun_grenade",-2];
 *
 1.2
	BIS_fnc_selectRandom replaced with selectRandom
 1.1
	BIS_fnc_dirTo replaced with getDir
 */

if (!hasInterface) exitWith {false};
params ["_blow_obj"];

private _poc = selectRandom ["stun_grenade_1","stun_grenade_2"];

private _sparks_ini = "#particlesource" createVehicleLocal (getPos _blow_obj);
_sparks_ini setParticleCircle [0,[-10,-10,-10]];
_sparks_ini setParticleRandom [0.2,[0,0,0],[10,10,10],0,0.1,[0,0,0,0.1],1,0];
_sparks_ini setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1],"","Billboard",1,2,[0,0,0],[0,0,0],0,10,1,0,[0.05],[[1,1,1,1]],[1],1,0,"","",_blow_obj];
_sparks_ini setDropInterval 0.001;
[_sparks_ini] spawn {_de_sters = _this select 0;sleep 0.2;deleteVehicle _de_sters};

_fum_ini = "#particlesource" createVehicleLocal getPosATL _blow_obj;
_fum_ini setParticleCircle [0,[2,2,0]];
_fum_ini setParticleRandom [0.1,[0.1,0.1,0.1],[-2,-2,0],3,0.5,[0,0,0,0.1],1,0];
_fum_ini setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard",1,2,[0,0,0],[0,0,0],5,9,7,0.5,[5,1,10],[[1,1,1,0.5],[1,1,1,0.3],[1,1,1,0]],[1], 1, 0, "", "",_blow_obj];
_fum_ini setDropInterval 0.01;
[_fum_ini] spawn {_de_sters = _this select 0;sleep 0.5;deleteVehicle _de_sters};

private _li_exp = "#lightpoint" createVehicle getPosATL _blow_obj;
_li_exp lightAttachObject [_blow_obj, [0,0,0.5]];
_li_exp setLightAttenuation [/*start*/1, /*constant*/0, /*linear*/50, /*quadratic*/2000, /*hardlimitstart*/10,/* hardlimitend*/50]; 
_li_exp setLightIntensity 1000;
_li_exp setLightDayLight true;
_li_exp setLightUseFlare true;
_li_exp setLightFlareMaxDistance 2000;
_li_exp setLightFlareSize 1;
_li_exp setLightAmbient[1,1,1];
_li_exp setLightColor[1,1,1];
[_li_exp] spawn {_de_sters = _this select 0;sleep 0.2;deleteVehicle _de_sters};

_blow_obj say3D [_poc,500];

sleep 0.1;

private _li_sec = "#lightpoint" createVehicle getPosATL _blow_obj;
_li_sec lightAttachObject [_blow_obj, [1,1,2]];
_li_sec setLightAttenuation [0,0,0,2000,1,50]; 
_li_sec setLightBrightness 100;
_li_sec setLightDayLight true;
_li_sec setLightAmbient[1,1,1];
_li_sec setLightColor[1,1,1];
[_li_sec] spawn {_de_sters = _this select 0;sleep 0.2;deleteVehicle _de_sters};

if (player distance _blow_obj < 12) then 
{
	addCamShake [5,2,9];
	[] spawn {
			private _tiuit = selectRandom ["tinnitus_1","tinnitus_2"];
			sleep 1;
			playsound _tiuit;
			0 fadeSound 0.2
		};
	if ((player distance _blow_obj < 15)) then
	{
		private _dir_rel = player getDir _blow_obj;
		private _cam_dir = [0,0,0] getdir getCameraViewDirection player;	
		if ((abs(_dir_rel - _cam_dir) <= 46) or (abs(_dir_rel - _cam_dir) >= 314)) then 
		{
			private _plos = [objNull, "VIEW"] checkVisibility [eyePos player, getposasl _blow_obj];
			if (_plos >0) then 
			{
				cutText ["", "WHITE OUT", 1];
				sleep 0.3;
				titleCut ["", "WHITE IN",10];
				"RadialBlur" ppEffectEnable true;
				"RadialBlur" ppEffectAdjust[1,0,0,0];
				"RadialBlur" ppEffectCommit 2;
				sleep 2;
				"RadialBlur" ppEffectAdjust[0,1,0,0];
				"RadialBlur" ppEffectCommit 2;
				sleep 2;
				"RadialBlur" ppEffectAdjust[1,0,0,0];
				"RadialBlur" ppEffectCommit 2;
				sleep 7;
				"RadialBlur" ppEffectAdjust[0,0,0,0];
				"RadialBlur" ppEffectCommit 2;
				sleep 3;
				"RadialBlur" ppEffectEnable false;
			};
		};
	};
	sleep 15;
	60 fadeSound 1;
};

true;