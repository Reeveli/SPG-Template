/*
By Reeveli

Script to handle radio discussion between the player and battery.
Must be executed in scheduled environment, hence script format and not compiled function.
Called from "Type" functions

3.2
	Bearings are no longer called out if range < 50m
3.1.1
	< 50m distances are no longer called out
3.1
	Added code for cluster arty

3.0 (2026 overhaul)
	All sideRAdio commands pruned, script is no longer requires radio item in inventory
	Grid is now single chat line, voices still separate
	Code simplified with new in-line function for sound and chat execution


Arguments:
0: Inputted position from artillery dialog in string form <STRING> (default: "000000")
1: Inputted bearing from artillery dialog <NUMBER> (default: 0)
2: Inputted range from artillery dialog <NUMBER> (default: 100)
3: Designated target if any <NUMBER|ARRAY> (default: 0)
4: Selected round type from artillery dialog <STRING> (default: "HE")
5: Actual caller position <ARRAY> (default: [0,0,0])
6: Selected ammunition amount <NUMBER> (default: 1)
7: Selected ammunition delay <NUMBER> (default: 0)
8: Laser target for tactical missile <OBJECT> (default: objNull)

*/
if !(hasInterface) exitWith {};

params [
	["_location","000000",[""]],
	["_angle",0,[0]],
	["_range",100,[0]],
	["_target",0,["",0]],
	["_round_type","HE",[""]],
	["_finalPos",[0,0,0],[[]],[2,3]],
	["_number",1,[0]],
	["_delay",0,[0]],
	["_tgt", objNull, [objNull]]
];

private _players = (call CBA_fnc_players) - [player];

//Create speaker for radio
private _side = side player;
private _group = createGroup [_side, true];
_group setGroupId ["Battery"];
private _unit = _group createUnit ["Logic", [0,0,0], [], 0, "NONE"];
private _name = format ["Rev_battery_%1", player];
_unit setVariable [_name, true];

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

private _fnc_playMessage = {
	params ["_unit","_root","_protocol","_players",["_type",""],["_chat",true],["_3d",true]];
	private _sound = format [_root, _protocol,_type];
	
	if (_chat) then {
	private _text = getText (missionConfigFile >> "CfgRadio" >> _sound >> "title");
	_unit sideChat _text;
	};

	private _source = playSound _sound;
	localNamespace setVariable ["Rev_arty_dialog_sound",_source];
	if (_3d) then {[_unit,[_sound,45]] remoteExec ["say3D",_players,"",true];};

	waitUntil {isNull (localNamespace getVariable ["Rev_arty_dialog_sound",objNull])};
};

//Begin coversation
switch (_round_type) do {
	case "HE": {
		[player,"Rev_%1_%2_request", _protocol,_players,"arty"] call _fnc_playMessage;
	};
	case "Cluster": {
		[player,"Rev_%1_%2_request", _protocol,_players,"arty"] call _fnc_playMessage;
	};
	case "Smoke": {
		[player,"Rev_%1_%2_request", _protocol,_players,"arty"] call _fnc_playMessage;
	};
	case "Flare": {
		[player,"Rev_%1_%2_request", _protocol,_players,"arty"] call _fnc_playMessage;
	};
	case "Missile": {
		[player,"Rev_%1_%2_request", _protocol,_players,"arty"] call _fnc_playMessage;
	};
	case "Air": {
		_group setGroupId ["Air Control"];
		[player,"Rev_%1_%2_request", _protocol,_players,"air"] call _fnc_playMessage;
	};
	case "Supply": {
		_group setGroupId ["Air Control"];
		[player,"Rev_%1_%2_request", _protocol,_players,"supply"] call _fnc_playMessage;
	};
	case "Gunship": {
		_group setGroupId ["Air Control"];
		[player,"Rev_%1_%2_request", _protocol,_players,"air"] call _fnc_playMessage;
	};
	case "Bombing": {
		_group setGroupId ["Air Control"];
		[player,"Rev_%1_%2_request", _protocol,_players,"bomb"] call _fnc_playMessage;
	};
	default {};
};


//Create grid lines
private _list = _location splitString "";
private _first = _list select 0;
_list deleteRange [0, 1];
parsenumber _first;

//First line
player sideChat ("Grid " + _location);
[player,"Rev_%1_grid_1_%2", _protocol,_players,_first,false] call _fnc_playMessage;


//Grid lines
{
	parsenumber _x;
	[player,"Rev_%1_grid_%2",_protocol,_players,_x,false] call _fnc_playMessage;
	waitUntil {isNull (localNamespace getVariable ["Rev_arty_dialog_sound",objNull])};
} forEach _list;

//Create distance
private _distance = _range;
private _vaihtoehdot2 = [100,200,300,400,500,600,700,800,900,1000];
private _distance_a = _vaihtoehdot2 select {(abs (_range - _x)) < 51};
if (_range < 50) then {_distance = 0} else {_distance = _distance_a select 0;};
if (_range > 1000) then {_distance = 1000};


//Create angle
private _vaihtoehdot = [000,015,030,045,060,075,090,105,120,135,150,165,180,195,210,225,240,255,270,285,300,315,330,345,360];
private _bearing_a = _vaihtoehdot select {(abs (_angle - _x)) < 8};
private _bearing = _bearing_a select 0;
private _switch = 0;

if (_bearing < 15) then {_switch = 0};
if ((_bearing >= 15) && (_bearing < 100)) then {_switch = 1};
if (_bearing >= 100) then {_switch = 2};
if (_range < 50) then {_switch = 3}; //we are skipping bearings on short ranges

//Playing bearing call
switch (_switch) do {
	case 0: {[player,"Rev_%1_bear_000",_protocol,_players] call _fnc_playMessage;};
	case 1: {[player,"Rev_%1_bear_0%2",_protocol,_players,_bearing] call _fnc_playMessage;};
	case 2: {[player,"Rev_%1_bear_%2",_protocol,_players,_bearing] call _fnc_playMessage;};
	case 3: {};
};

//Distance calculated above so that it can be used to skip bearings if needed, but called here bc I believe that is more 'realistic'
//Small ranges left out
if !(_distance == 0) then {[player,"Rev_%1_dis_%2",_protocol,_players,_distance] call _fnc_playMessage;};



//Fire call
switch (_round_type) do {
	case "HE": {
		[player,"Rev_%1_arty_fire1",_protocol,_players] call _fnc_playMessage;
		[player,"Rev_%1_arty_fire1",_protocol,_players,"",false] call _fnc_playMessage;
		[player,"Rev_%1_arty_fire1",_protocol,_players,"",false] call _fnc_playMessage;
	};
	case "Cluster": {
		[player,"Rev_%1_arty_fire1",_protocol,_players] call _fnc_playMessage;
		[player,"Rev_%1_arty_fire1",_protocol,_players,"",false] call _fnc_playMessage;
		[player,"Rev_%1_arty_fire1",_protocol,_players,"",false] call _fnc_playMessage;
	};
	case "Smoke": {[player,"Rev_%1_arty_fire1",_protocol,_players] call _fnc_playMessage;};
	case "Flare": {[player,"Rev_%1_arty_flares",_protocol,_players] call _fnc_playMessage;};
	case "Missile": {[player,"Rev_%1_arty_call_missiles",_protocol,_players] call _fnc_playMessage;};
};

private _aika = count _list;
sleep (_aika * 1.5);

//Radio acknowledge
switch (_round_type) do {
	case "Missile": {[_unit,"Rev_%1_arty_missiles",_protocol,_players,"",true,false] call _fnc_playMessage;};
	case "Air": {[_unit,"Rev_%1_air_roger",_protocol,_players,"",true,false] call _fnc_playMessage;};
	case "Supply": {[_unit,"Rev_%1_supply_roger",_protocol,_players,"",true,false] call _fnc_playMessage;};
	case "Gunship": {[_unit,"Rev_%1_air_roger",_protocol,_players,"",true,false] call _fnc_playMessage;};
	case "Bombing": {[_unit,"Rev_%1_bomb_roger",_protocol,_players,"",true,false] call _fnc_playMessage;};
	default {[_unit,"Rev_%1_arty_roger",_protocol,_players,"",true,false] call _fnc_playMessage;};	
};


//Execute barrage function
sleep 7;
switch (_round_type) do {
	case "HE": {[_finalPos,(_number * 10),_number,_delay] call Rev_arty_fnc_barrage_HE;};
	case "Cluster": {[_finalPos,(_number * 20),_number,_delay] call Rev_arty_fnc_barrage_CLU;};
	case "Flare": {[_finalPos,(_number * 10),_number,_delay] call Rev_arty_fnc_barrage_ILM;};
	case "Smoke": {[_finalPos,(_number * 10),_number,_delay] call Rev_arty_fnc_barrage_SMK;};
	case "Missile": {[] spawn Rev_arty_fnc_missile_launch;};
	case "Air": {[] spawn Rev_arty_fnc_air_start};
	case "Supply": {[] spawn Rev_arty_fnc_supply_transport;};
	case "Gunship": {[] spawn Rev_arty_fnc_gunship_start;};
	case "Bombing": {[] spawn Rev_arty_fnc_bomb_plane};
};


//Delete radio speaker
deleteVehicle _unit;