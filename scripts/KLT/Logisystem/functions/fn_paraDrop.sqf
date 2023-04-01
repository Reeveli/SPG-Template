
params [
	["_object", "CargoNet_01_box_F", [""]],
	["_centre", [0, 0, 0], ["", objNull, taskNull, locationNull, [], grpNull], [3]],
	["_height", 100, [0]],
	["_attachTo", [0, 0, -1.2], [[]], [3]],
	["_markerSys",false],
	["_attachSmoke", true]
	
];

_centre = _centre call {
	if (_this isEqualType objNull) exitWith {getPosASL _this};
	if (_this isEqualType grpNull) exitWith {getPosASL (leader _this)};
	if (_this isEqualType "") exitWith {getMarkerPos _this};
	if (_this isEqualType locationNull) exitWith {locationPosition _this};
	if (_this isEqualType taskNull) exitWith {taskDestination  _this};
	if (_this isEqualType []) exitWith {_this};
	[0, 0, 0]
};

if (!(isClass (configfile >> "cfgVehicles" >> _object)) || _centre isEqualTo [0, 0, 0]) exitWith {
	objNull
};

private _obj = createVehicle [_object, _centre vectorAdd [0, 0, _height], [], 0, "NONE"]; 
private _para = createVehicle ["B_parachute_02_F", [0,0,0], [], 0, "FLY"];

_para setDir getDir _obj;
_para setPos getPos _obj;
_obj lock false;
_obj attachTo [_para, _attachTo];

[_obj, _para, _markersys] spawn 
{
	params ["_obj","_para","_markersys","_i"];
		
	waitUntil {
		sleep 0.01;
		((position _obj) select 2) < 2 
		|| 
		isNull _para 
		|| 
		(count (lineIntersectsWith [getPosASL _obj, (getPosASL _obj) vectorAdd [0, 0, -0.5], _obj, _para])) > 0
	};
		
	_para disableCollisionWith _obj;
	_obj setVectorUp [0,0,1];
	_obj setVelocity [0,0,0];
	detach _obj;
		
	if (!isNull _para) then {deleteVehicle _para};

	(format ["A supply drop has touched down, grid %1.", mapGridPosition getPosATL _obj]) remoteExec ["systemChat", west, false]; 
	("SmokeShellBlue" createVehicle (position _obj));
	_pos = mapGridPosition getPosATL _obj;
	if (_markerSys) then {
		_m1 = createMarker[str _pos + str _obj ,position _obj];
		_m1 setMarkerShape "ICON";
		_m1 setMarkerType "hd_dot";
		_m1 setMarkerColor "colorCivilian";
		_m1 setMarkerPos (position _obj);

		//Make marker invisible for resistance Needtest
		[_m1,0] remoteexec ["setMarkerAlphaLocal",resistance,true];
	};
	
 	
};





_obj 