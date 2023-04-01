
params ["_unit"];

private _return = _unit call Rev_fnc_vehicle_weapons;

//M113
if (["rhsusf_weap_M259"] in _return) exitWith {
	_unit setAmmo ["rhsusf_weap_M259", 8];
	for "_i" from 1 to 8 do { 
	[_unit, "rhsusf_weap_M259"] call BIS_fnc_fire;
	sleep 0.2;
	};
};
//Abrams
if (["rhsusf_weap_M257"] in _return) exitWith {
	for "_i" from 1 to 8 do { 
	[_unit, "rhsusf_weap_M257"] call BIS_fnc_fire;
	sleep 0.2;
	};
};
if (["rhsusf_weap_M250"] in _return) exitWith {
	_unit setAmmo ["rhsusf_weap_M250", 6];
	_unit setAmmo ["rhsusf_weap_M259", 6];
	_unit setAmmo ["rhsusf_weap_M257", 6];
	for "_i" from 1 to 6 do { 
	[_unit, "rhsusf_weap_M250"] call BIS_fnc_fire;
	sleep 0.2;
	};
};

if (["rhs_weap_902a"] in _return) exitWith {
	[_unit, "rhs_weap_902a"] call BIS_fnc_fire;
	_unit setAmmo ["rhs_weap_902a", 6];
};

if (["SmokeLauncher"] in _return) exitWith {	
	[_unit, "SmokeLauncher"] call BIS_fnc_fire;
	_unit setAmmo ["SmokeLauncher", 2];
};