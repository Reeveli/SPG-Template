//Function to be run locally on all units being prepared for HALO jump
if !(hasInterface) exitWith {};
params ["_plane","_cargoIndex"];
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