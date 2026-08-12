/*
 * Author: Bohemia Interactive
 * Modified by Reeveli
 * Handels curator called gun runs
 *
 * Arguments:
 * 0: Target position <ARRAY>
 * 1: Attack direction <NUMBER> (default: 0)
 * 1: Plane class <STRING> (default: "B_Plane_Fighter_01_F")
 * 2: Plane side <SIDE> (default:civilian)
 * 3: Person calling the script, used in backup direction calculation <OBJECT> (default:objNull)
 *
 * Return Value: NONE
 *
 * Example:
 * [_position select 0,_bomb_type,_bomb_number,_pattern,_direction,_height_number,_plane_type,_plane_side] remoteExecCall ["Rev_arty_fnc_zeus_bomber",2];
 *
 */

params [
	["_targetPos",nil,[[]],[2,3]],
	["_direction",0,[0]],
	["_planeClass","B_Plane_CAS_01_dynamicLoadout_F",[""]],
	["_planeSide",civilian,[civilian]],
	["_caller",objNull,[objNull]]
];

if !(isserver) exitwith {false;};


private _group = createGroup [sideLogic, true];
private _logic = _group createUnit ["Logic", [_targetPos#0,_targetPos#1], [], 0, "NONE"];
If !(isNull _caller) then {
	(getAssignedCuratorLogic _caller) addCuratorEditableObjects [[_logic],true];
};

private _dirVar = _caller getDir _logic;
if !(isNull curatorCamera) then {(getPos curatorCamera) getDir _logic;
	_dirVar = (getPos curatorCamera) getDir _logic;
};

_planeCfg = configfile >> "cfgvehicles" >> _planeClass;
_weaponTypesID = 2; // CAS: _logic getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _logic >> "moduleCAStype")];



if !(isclass _planeCfg) exitwith {
	["Vehicle class '%1' not found",_planeClass] remoteExec ["bis_fnc_error",_caller,false];
	false;
};

//--- Detect gun, code left in case more types needed in future
_weaponTypes = switch _weaponTypesID do {
	case 0: {["machinegun"]};
	case 1: {["missilelauncher"]};
	case 2: {["machinegun","missilelauncher","rocketlauncher"]};
	case 3: {["bomblauncher"]};
	default {[]};
};
_weapons = [];
{
	if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
		_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
		if (count _modes > 0) then {
			_mode = _modes select 0;
			if (_mode == "this") then {_mode = _x;};
			_weapons set [count _weapons,[_x,_mode]];
		};
	};
} foreach (_planeClass call bis_fnc_weaponsEntityType);//getarray (_planeCfg >> "weapons");
if (count _weapons == 0) exitwith {["No weapon of types %2 wound on '%1'",_planeClass,_weaponTypes] call bis_fnc_error; false};

_posATL = getposatl _logic;
_pos = +_posATL;
_pos set [2,(_pos select 2) + getterrainheightasl _pos];

_dis = 3000;
_alt = 1000;
_pitch = atan (_alt / _dis);
_speed = 400 / 3.6;
_duration = ([0,0] distance [_dis,_alt]) / _speed;

//--- Create plane
_planePos = [_pos,_dis,_dirVar + 180] call bis_fnc_relpos;
_planePos set [2,(_pos select 2) + _alt];;
_planeArray = [_planePos,_dirVar,_planeClass,_planeSide] call bis_fnc_spawnVehicle;
_planeVehicle = _planeArray select 0;
_planeVehicle setposasl _planePos;
_planeVehicle move ([_pos,_dis,_dirVar] call bis_fnc_relpos);
_planeVehicle disableai "move";
_planeVehicle disableai "target";
_planeVehicle disableai "autotarget";
_planeVehicle setcombatmode "blue";

//Adding plane to editable objects
If !(isNull _caller) then {
	(getAssignedCuratorLogic _caller) addCuratorEditableObjects [[_planeVehicle],true];
};

_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_planeVehicle setvectordir _vectorDir;
[_planeVehicle,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
_vectorUp = vectorup _planeVehicle;

//--- Remove all other weapons;
_currentWeapons = weapons _planeVehicle;
{
	if !(tolower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
		_planeVehicle removeweapon _x;
	};
} foreach _currentWeapons;


_planeVehicle setvariable ["logic",_logic];
_logic setvariable ["plane",_planeVehicle];


//--- Play radio
//[_planeVehicle,"CuratorModuleCAS"] remoteExec ["bis_fnc_curatorSayMessage",_caller,false];


//--- Approach
_fire = [] spawn {waituntil {false}};
_fireNull = true;
_time = time;
_offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
waituntil {
	_fireProgress = _planeVehicle getvariable ["fireProgress",0];

	//--- Update plane position when module was moved / rotated
	if ((getposatl _logic distance _posATL > 0) && _fireProgress == 0) then {
		_posATL = getposatl _logic;
		_pos = +_posATL;
		_pos set [2,(_pos select 2) + getterrainheightasl _pos];
		_dirVar = _planeVehicle getDir _logic;

		_planePos = [_pos,_dis,_dirVar + 180] call bis_fnc_relpos;
		_planePos set [2,(_pos select 2) + _alt];
		_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
		_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
		_planeVehicle setvectordir _vectorDir;
		//[_planeVehicle,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
		_vectorUp = vectorup _planeVehicle;

		_planeVehicle move ([_pos,_dis,_dirVar] call bis_fnc_relpos);
	};

	//--- Set the plane approach vector
	_planeVehicle setVelocityTransformation [
		_planePos, [_pos select 0,_pos select 1,(_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir,_vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_planeVehicle setvelocity velocity _planeVehicle;

	//--- Fire!
	if ((getposasl _planeVehicle) distance _pos < 1000 && _fireNull) then {


		//--- Create laser target
		private _targetType = if (_planeSide getfriend west > 0.6) then {"LaserTargetW"} else {"LaserTargetE"};
		_target = ((position _logic nearEntities [_targetType,250])) param [0,objnull];
		if (isnull _target) then {
			_target = createvehicle [_targetType,position _logic,[],0,"none"];
		};
		_planeVehicle reveal lasertarget _target;
		_planeVehicle dowatch lasertarget _target;
		_planeVehicle dotarget lasertarget _target;

		_fireNull = false;
		terminate _fire;
		_fire = [_planeVehicle,_weapons,_target,_weaponTypesID] spawn {
			_planeVehicle = _this select 0;
			_planeDriver = driver _planeVehicle;
			_weapons = _this select 1;
			_target = _this select 2;
			_weaponTypesID = _this select 3;
			_duration = 3;
			_time = time + _duration;
			waituntil {
				{
					//_planeVehicle selectweapon (_x select 0);
					//_planeDriver forceweaponfire _x;
					_planeDriver fireattarget [_target,(_x select 0)];
				} foreach _weapons;
				_planeVehicle setvariable ["fireProgress",(1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				time > _time || _weaponTypesID == 3 || isnull _planeVehicle //--- Shoot only for specific period or only one bomb
			};
			sleep 1;
		};
	};

	sleep 0.01;
	scriptdone _fire || isnull _logic || isnull _planeVehicle
};
_planeVehicle setvelocity velocity _planeVehicle;
_planeVehicle flyinheight _alt;

//--- Fire CM
if ({_x == "bomblauncher"} count _weaponTypes == 0) then {
	for "_i" from 0 to 1 do {
		driver _planeVehicle forceweaponfire ["CMFlareLauncher","Burst"];
		_time = time + 1.1;
		waituntil {time > _time || isnull _logic || isnull _planeVehicle};
	};
};


if !(isnull _logic) then {
	sleep 1;
	deletevehicle _logic;
	waituntil {_planeVehicle distance _pos > _dis || !alive _planeVehicle};
};

//--- Delete plane
if (alive _planeVehicle) then {
	_group = group _planeVehicle;
	_crew = crew _planeVehicle;
	deletevehicle _planeVehicle;
	{deletevehicle _x} foreach _crew;
	deletegroup _group;
};