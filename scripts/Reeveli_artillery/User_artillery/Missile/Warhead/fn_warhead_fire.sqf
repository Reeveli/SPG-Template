/* By ALIAS & Reeveli

1.1
	ACE damage changed to new fire event
1.0
	Added ACE damage to effetcts
*/

if (!hasInterface) exitWith {};

params ["_bomb_center","_effect_size","_damage"];

[_bomb_center,_effect_size,_damage] spawn 
{
	params ["_bomb_center","_effect_size","_damage"];
	while {!isNull _bomb_center} do 
	{
		if((player distance _bomb_center) <= _effect_size) then 
		{
			enableCamShake true;
			addCamShake [5,1,17];
			["ACE_fire_burn", [player, 5]] call CBA_fnc_globalEvent;
		};
		_bomb_center say3d ["furnal",1000];
		enableCamShake false;
		sleep 3.5;
	};
};

if (((player distance _bomb_center) <= _effect_size) && (!isNull _bomb_center)) then {
	enableCamShake true;
	addCamShake [5,1,17];
	["ACE_fire_burn", [player, 5]] call CBA_fnc_globalEvent;
};
_bomb_center say3d ["furnal",1000];




















_lite= [_bomb_center,_effect_size] spawn 
{
	private ["_effect_sizet"];
	_bomb_centert = _this select 0;
	_effect_sizet = _this select 1;
	_luminafoc = "#lightpoint" createVehicleLocal ([1,1,1]); 
	_luminafoc lightAttachObject [_bomb_centert, [0,0,10]];
	_luminafoc setLightBrightness 10;
	_luminafoc setLightAmbient [1,0.1,0];
	_luminafoc setLightColor [1,0,0];
	_luminafoc setLightDayLight true;
	_lum=50;
	while {_lum>0} do 
	{
		_luminafoc setLightBrightness 10;
		_luminafoc setLightAttenuation [_effect_sizet/2,20,20,0,_effect_sizet+random 100,500];
		_lum = _lum-0.1;
		sleep 0.1;
	};
	_lum = 10;
	for "_i" from 1 to 100 do
	{
		_luminafoc setLightBrightness _lum;
		_luminafoc setLightAttenuation [_effect_sizet/2,20,20,0,_effect_sizet+100,500];
		sleep 0.1;
		_lum = _lum-0.1;
	};
	deletevehicle _luminafoc;
};

_fum = "#particlesource" createVehicleLocal (getPosATL _bomb_center);
_fum setParticleCircle [_effect_size/2, [0,0,0]];
_fum setParticleRandom [10,[_effect_size/3,_effect_size/3,40],[-2,-2,10],2,0.5,[0,0,0,0.1],1,0.3];
_fum setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard",1,30,[0,0,0],[0,0,0],3,8,7,0.5,[_effect_size/3,_effect_size/2,_effect_size,_effect_size*2],[[0.5,0.5,0.5,0.5],[0.349,0.231,0.122,0.4],[0.349,0.231,0.122,0.1],[0,0,0,0]],[0.5],1,0, "", "",_bomb_center];
_fum setDropInterval 0.01;

_caldura = "#particlesource" createVehicleLocal (getPosATL _bomb_center);
_caldura setParticleCircle [_effect_size/2, [0, 0, 0]];
_caldura setParticleRandom [0,[0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_caldura setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 7,[0,0,0],[0,0,0.75],0,10.5,7.9,0,[_effect_size/2,_effect_size/2+2,_effect_size/2-1], [[1,1,1,1],[1,1,1,1],[1,1,1,1]], [0.08], 1, 0, "", "", _bomb_center];
_caldura setDropInterval 0.1;

[_fum] spawn { 
	_de_sters = _this select 0;
	sleep 80;
	deletevehicle _de_sters;
};

[_caldura] spawn { 
	_de_sters = _this select 0;
	sleep 70;
	deletevehicle _de_sters;
};