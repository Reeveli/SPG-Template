/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to handle completed support missions.
 *
 * Arguments:
 * 0: Did player have radio on call <BOOL> (default: false)
 * 1: Ordnance type <STRING> (default "Shells")
 * 2: Was player killed <BOOL> (default: false)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [false,"Shells",false] call Rev_arty_fnc_user_completed
 *
 1.2
	Code for area bombing exit
 1.1
	Added hintSilent to air exit if not killed
 */

params [
	["_initial_radio",false,[false]],
	["_type","Shells",[""]],
	["_killed",false,[false]]
];

if !(alive player) exitWith {};

//Speaker
private _battery = entities "Logic" select {_x getVariable [format ["Rev_arty_completed_%1", player],false];};
{deletevehicle _x} forEach _battery;

//Speaker language
private _protocol = "eng";
switch (Rev_arty_protocol) do {
	case 0: {_protocol = "eng";};
	case 1: {_protocol = "gre";};
	case 2: {_protocol = "far";};
	case 3: {_protocol = "fre";};
	case 4: {_protocol = "chi";};
	case 5: {_protocol = "rus";};
	case 6: {_protocol = "pol";};
	default {_protocol = "eng";};
	};

//Create speaker for radio
private _side = side player;
private _group = createGroup [_side, true];

switch (_type) do {
	case "Missile": {_group setGroupId ["Battery"];};
	case "Air": {_group setGroupId ["Air Control"]};
	case "Supply": {_group setGroupId ["Air Control"]};
	case "Bombing": {_group setGroupId ["Air Control"]};
	default {_group setGroupId ["Battery"];};	
};

private _unit = _group createUnit ["Logic", [0,0,0], [], 0, "NONE"];
private _name = format ["Rev_arty_completed_%1", player];
_unit setVariable [_name, true];


switch (_type) do {
	case "Air": {
					if (_killed) then {_unit sideRadio format ["Rev_%1_air_killed", _protocol];}
					else {_unit sideRadio format ["Rev_%1_air_complete", _protocol]; hintSilent "";};
				};
	case "Supply": {_unit sideRadio format ["Rev_%1_supply_complete", _protocol];};
	case "Bombing": {_unit sideRadio format ["Rev_%1_bomb_complete", _protocol];};
	default {_unit sideRadio format ["Rev_%1_arty_complete", _protocol]};	
};



//Radio removal
[{
	params["_unit","_initial_radio"];
	if (!_initial_radio) then {
		player unlinkItem ((assignedItems player) select {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0} select 0);
	};
	deleteVehicle (_this select 0);
}, [_unit,_initial_radio], 5] call CBA_fnc_waitAndExecute;