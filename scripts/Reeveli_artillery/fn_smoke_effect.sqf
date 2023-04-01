/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system.
 * Creates airburst smoke cloud when firing smoke artillery. Must be run locally for all clients.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_smoke_pos] remoteExec ["Rev_arty_fnc_smoke_effect",0,true];
 *
 */

params [
	["_smoke_pos",[0,0,0],[[]],[2,3]]
];

private ["_emitters","_source1","_source2","_light"];
_emitters = [];

_source1 = createVehicle [ "#particlesource", _smoke_pos, [], 0, "CAN_COLLIDE" ];
_source1 setParticleClass "GrenadeExp";
_source1 setParticleParams [
	[
		"\A3\data_f\ParticleEffects\Universal\Universal",
		16,
		0,
		32,
		0
	],
	"",
	"Billboard",
	0.3,
	0.3,
	[ 0,0,0 ],
	[ 0,1,0 ],
	0,
	10,
	7.9,
	0.1,
	[ 0.0125 * 0.3 + 4, 0.0125 * 0.3 + 1 ],
	[ [1,1,1,-6],[1,1,1,0] ],
	[ 1 ],
	0.2,
	0.2,
	"",
	"",
	_this,
	0,
	false,
	0.6,
	[ [ 30,30,30,0 ],[ 0,0,0,0 ] ]
];
_source1 setParticleRandom [
	0,
	[ 0.4,0.1,0.4 ],
	[ 0.2,0.5,0.2 ],
	90,
	0.5,
	[ 0,0,0,0 ],
	0,
	0,
	1,
	0.0
];
_source1 setParticleCircle [
	0,
	[ 0,0,0 ]
];
_source1 setParticleFire [1,15,0.1];
_emitters pushBack [ _source1, 0.3 ];

_light = createVehicle [ "#lightPoint", _smoke_pos, [], 0, "CAN_COLLIDE" ];
_light setLightAmbient [ 0,0,0 ];
_light setLightBrightness 10;
_light setLightColor [ 1,0.6,0.4 ];
_light setLightIntensity 10000;
_light setLightAttenuation [
	0,
	0,
	0,
	2.2,
	500,
	1000
];
_emitters pushBack [ _light, 0.3 ];

private _time = diag_tickTime;
while{ count _emitters > 0 } do {
	{
		_x params[ "_source", "_length" ];
		if ( diag_tickTime > _time + _length ) then {
			deleteVehicle _source;
			_emitters set[ _forEachIndex, objNull ];
		};
	}forEach _emitters;
	_emitters = _emitters - [ objNull ];
};
