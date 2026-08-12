/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to handle completed support missions.
 *
 * Arguments:
 * 0: Ordnance type <STRING> (default "Shells")
 * 1: Was player killed <BOOL> (default: false)
 *
 * Return Value: <NONE>
 *
 * Example:
 * ["Shells",false] call Rev_arty_fnc_user_completed
 *
 1.3
	Script rewritten to no longer raquire radio, code and input arguments adjusted
 1.2
	Code for area bombing exit
 1.1
	Added hintSilent to air exit if not killed
 */

params [
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


private _fnc_playMessage = {
	params ["_unit","_root","_protocol"];
	private _sound = format [_root, _protocol];	
	private _text = getText (missionConfigFile >> "CfgRadio" >> _sound >> "title");

	_unit sideChat _text;
	private _source = playSound _sound;
};


switch (_type) do {
	case "Air": {
					if (_killed) then {[_unit,"Rev_%1_air_killed", _protocol] call _fnc_playMessage;}
					else {_unit sideRadio format ["Rev_%1_air_complete", _protocol]; hintSilent "";};
				};
	case "Supply": {[_unit,"Rev_%1_supply_complete", _protocol] call _fnc_playMessage;};
	case "Bombing": {[_unit,"Rev_%1_bomb_complete", _protocol] call _fnc_playMessage;};
	default {[_unit,"Rev_%1_arty_complete", _protocol] call _fnc_playMessage;};	
};

