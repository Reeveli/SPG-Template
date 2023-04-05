/*
 * Author: Reeveli
 * Part of Reeveli's HALO system.
 * Client side function to embark a player to the HALO plane.
 * Called from scripts\Reeveli_fnc\Rev_halo\fn_halo_plane.sqf
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_plane_vehicle,_cargoIndex] remoteExec ['Rev_fnc_embark',_x,false];
 *

1.1
	Updated function header and params

 */



if !(hasInterface) exitWith {};

params [
	["_plane", objNull, [objNull]],
	["_cargoIndex", 1, [0]]
];


private _unit = player;
private _loadout = getUnitLoadout _unit;

_unit addHeadgear "H_PilotHelmetFighter_B";
_unit addVest "V_RebreatherB";
removeBackpack _unit;
_unit addBackpack "B_Parachute";
_unit linkItem "ACE_Altimeter";
_unit action ["SwitchWeapon", _unit, _unit, 100];

[_unit,_plane,_cargoIndex,_loadout] spawn { 
	params ["_unit","_plane","_cargoIndex","_loadout"];
	cutText ["","black out",1];
	playsound "echipare_toxic";
	sleep 3;
	cutText ["","black in",1];
	cutRsc ["Halo_mask","PLAIN", 1, false];
	_unit moveInCargo [_plane,_cargoIndex];

	waitUntil {(!(isNull objectParent _unit))};

	while {!((vehicle _unit == _unit) AND (isTouchingGround _unit))} do {
		if !(alive _unit) exitWith {};
		sleep 2;
		playSound "breath";
		sleep 2;
	};
	waitUntil {isTouchingGround _unit};
	cutText ["", "PLAIN",1];
	playSound "dezechipare_toxic";
	_unit setUnitLoadout _loadout;
};