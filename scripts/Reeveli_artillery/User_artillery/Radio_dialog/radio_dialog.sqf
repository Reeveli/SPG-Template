/*
By Reeveli

Script to handle radio discussion between the player and battery when calling artillery in multiplayer.
Must be executed in scheduled environment, hence script format and not compiled function.

2.2.2
	Updared header, argument listing had old legacy mention of missile type, this is no longer passed into the script
2.2.1
	Rev_fnc_barrage_BOM replaced with Rev_arty_fnc_bomb_plane
2.2
	Added code for area bombing ordnance type
	Added more general comments
2.1
	Added new line to define distance if its over 1000 as that would cause no voice line being available
2.0
	Removed params from spawn Rev_arty_fnc_supply_transport as they are now longer needed since the supply system rewrite
	Removed missile_type param as obsolete
	Fixed missing radio protocol bit in initial missile call
	Added code for gunship support
1.9.1
	Added two seconds to last sleep to prevent air callout from being cut out
1.9
	Added missing _delay param
1.8
	Default values for params
	Added interface safety condition
1.7.1
	Tripled 3d voice range 
1.7
	Another stab at remoteExec problems
1.6
	Fixed (hopefully) all remoteExec problems
1.5
	Code for resupply
	Begin conversation changed from if-statement to switch do-block
	Removed unnecessary arguments being passed into supply_transport
	supply_transport is now spawned instead of called

	Changed code for air support to allow the radio dialof to run afger the dialog
1.4
	Code for new air selection system
1.3
	New commands for 3d voice lines
	Increased pverral time multiplier by 1
	Added varibale to battery logic to facilitate removal frm ACE unconscious and killed EHs
	New params for missile type
	Massive changes otherwise to fix missile lasre loss issues
	Incorporated code for air
1.2
	Added code for temporary radio if player had none (needed for sideradio command)
1.1
	Fixed missile acknowledgement in line 103


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
	["_pos",[0,0,0],[[]],[2,3]],
	["_number",1,[0]],
	["_delay",0,[0]],
	["_tgt", objNull, [objNull]]
];

private _players = (call CBA_fnc_players) - [player];

//Check if user has radio (needed for sideradio command)
private _condition = {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0};
private _initial_radio = true;
if (_condition count assignedItems player == 0) then {
	_initial_radio = false;
	player linkItem "TFAR_anprc148jem";
	waitUntil {_condition count assignedItems player > 0};
};

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


//Begin coversation
switch (_round_type) do {
	case "HE": {	
		player sideRadio format ["Rev_%1_arty_request", _protocol];
		[player,[format ["Rev_%1_arty_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Smoke": {	
		player sideRadio format ["Rev_%1_arty_request", _protocol];
		[player,[format ["Rev_%1_arty_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Flare": {	
		player sideRadio format ["Rev_%1_arty_request", _protocol];
		[player,[format ["Rev_%1_arty_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Missile": {	
		player sideRadio format ["Rev_%1_arty_request", _protocol];
		[player,[format ["Rev_%1_arty_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Air": {
		_group setGroupId ["Air Control"];
		player sideRadio format ["Rev_%1_air_request", _protocol];
		[player,[format ["Rev_%1_air_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Supply": {
		_group setGroupId ["Air Control"];
		player sideRadio format ["Rev_%1_supply_request", _protocol];
		[player,[format ["Rev_%1_supply_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Gunship": {
		_group setGroupId ["Air Control"];
		player sideRadio format ["Rev_%1_air_request", _protocol];
		[player,[format ["Rev_%1_air_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	case "Bombing": {
		_group setGroupId ["Air Control"];
		player sideRadio format ["Rev_%1_bomb_request", _protocol];
		[player,[format ["Rev_%1_bomb_request", _protocol],45]] remoteExec ["say3D",_players,true];
	};
	default { };
};


//Case TRP
if (typeName _target isEqualTo "STRING") exitWith {
	player sideRadio format ["Rev_%1_arty_target", _protocol];
	[player,[format ["Rev_%1_arty_target", _protocol],45]] remoteExec ["say3D",_players,true];


	switch (_round_type) do {
	case "HE": {
		player sideRadio format ["Rev_%1_arty_fire1", _protocol];
		[player,[format ["Rev_%1_arty_fire1", _protocol],45]] remoteExec ["say3D",_players,true];
		player sideRadio format ["Rev_%1_arty_fire1", _protocol];
		[player,[format ["Rev_%1_arty_fire1", _protocol],45]] remoteExec ["say3D",_players,true];
		player sideRadio format ["Rev_%1_arty_fire2", _protocol];
		[player,[format ["Rev_%1_arty_fire2", _protocol],45]] remoteExec ["say3D",_players,true];
		};
	case "Smoke": {player sideRadio format ["Rev_%1_arty_fire1", _protocol];[player,[format ["Rev_%1_arty_fire1", _protocol],45]] remoteExec ["say3D",_players,true];};
	case "Flare": {player sideRadio format ["Rev_%1_arty_flares", _protocol];[player,[format ["Rev_%1_arty_flares", _protocol],45]] remoteExec ["say3D",_players,true];};
	case "Missile": {player sideRadio format ["Rev_%1_arty_call_missiles", _protocol];[player,[format ["Rev_%1_arty_call_missiles", _protocol],45]] remoteExec ["say3D",_players,true];};
	};
	sleep 10;

	switch (_round_type) do {
		case "Missile": {
				if !(alive _tgt) exitWith {playSound "FD_Start_F"; hint "No target designated with laser. Check your coordinates.";};
				_unit sideRadio format ["Rev_%1_arty_missiles", _protocol];
			};
		case "Air": {_unit sideRadio format ["Rev_%1_air_roger", _protocol]};
		case "Supply": {_unit sideRadio format ["Rev_%1_supply_roger", _protocol]};
		case "Gunship": {_unit sideRadio format ["Rev_%1_air_roger", _protocol]};
		case "Bombing": {_unit sideRadio format ["Rev_%1_bomb_roger", _protocol]};
		default {_unit sideRadio format ["Rev_%1_arty_roger", _protocol];};	
	};

	sleep 5;
	switch (_round_type) do {
		case "HE": {[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_HE;};
		case "Flare": {[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_ILM;};
		case "Smoke": {[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_SMK;};
		case "Missile": {
				if !(alive _tgt) exitWith {hint "No target designated with laser. Check your coordinates.";};
				[] spawn Rev_arty_fnc_missile_launch;
			};
		case "Air": {[] spawn Rev_arty_fnc_air_start};
		case "Supply": {[] spawn Rev_arty_fnc_supply_transport;};
		case "Gunship": {[] spawn Rev_arty_fnc_gunship_start;};
		case "Bombing": {[] spawn Rev_arty_fnc_bomb_plane};
		
	};

	//Remove generated radio if had none before
	if (!_initial_radio) then {
		player unlinkItem ((assignedItems player) select {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0} select 0);
	};

	deleteVehicle _unit;

};

//Create grid lines
private _list = _location splitString "";
private _first = _list select 0;
_list deleteRange [0, 1];
parsenumber _first;
player sideRadio format ["Rev_%1_grid_1_%2", _protocol,_first];
[player,[format ["Rev_%1_grid_1_%2", _protocol,_first],45]] remoteExec ["say3D",_players,true];

{
	parsenumber _x;
	player sideRadio format ["Rev_%1_grid_%2", _protocol,_x];
	[player,[format ["Rev_%1_grid_%2", _protocol,_x],45]] remoteExec ["say3D",_players,true];
	
} forEach _list;

//Create angle
private _vaihtoehdot = [000,015,030,045,060,075,090,105,120,135,150,165,180,195,210,225,240,255,270,285,300,315,330,345,360];
private _bearing_a = _vaihtoehdot select {(abs (_angle - _x)) < 8};
private _bearing = _bearing_a select 0;
private _switch = 0;

if (_bearing < 15) then {_switch = 0};
if ((_bearing >= 15) && (_bearing < 100)) then {_switch = 1};
if (_bearing >= 100) then {_switch = 2};

switch (_switch) do {
	case 0: {player sideRadio format ["Rev_%1_bear_000", _protocol];[player,[format ["Rev_%1_bear_000", _protocol],45]] remoteExec ["say3D",_players,true];};
	case 1: {player sideRadio format ["Rev_%1_bear_0%2", _protocol,_bearing];[player,[format ["Rev_%1_bear_0%2", _protocol,_bearing],45]] remoteExec ["say3D",_players,true]};
	case 2: {player sideRadio format ["Rev_%1_bear_%2", _protocol,_bearing];[player,[format ["Rev_%1_bear_%2", _protocol,_bearing],45]] remoteExec ["say3D",_players,true]};
};

//Create distance
private _distance = _range;
private _vaihtoehdot2 = [100,200,300,400,500,600,700,800,900,1000];
private _distance_a = _vaihtoehdot2 select {(abs (_range - _x)) < 51};
if (_range < 50) then {_distance = 100} else {_distance = _distance_a select 0;};
if (_range > 1000) then {_distance = 1000};
player sideRadio format ["Rev_%1_dis_%2",_protocol,_distance];
[player,[format ["Rev_%1_dis_%2", _protocol,_distance],45]] remoteExec ["say3D",_players,true];

//Fire call
switch (_round_type) do {
	case "HE": {
		player sideRadio format ["Rev_%1_arty_fire1", _protocol];
		[player,[format ["Rev_%1_arty_fire1", _protocol],45]] remoteExec ["say3D",_players,true];
		player sideRadio format ["Rev_%1_arty_fire1", _protocol];
		[player,[format ["Rev_%1_arty_fire1", _protocol],45]] remoteExec ["say3D",_players,true];
		player sideRadio format ["Rev_%1_arty_fire2", _protocol];
		[player,[format ["Rev_%1_arty_fire2", _protocol],45]] remoteExec ["say3D",_players,true];
		};
	case "Smoke": {player sideRadio format ["Rev_%1_arty_fire1", _protocol];[player,[format ["Rev_%1_arty_fire1", _protocol],45]] remoteExec ["say3D",_players,true];};
	case "Flare": {player sideRadio format ["Rev_%1_arty_flares", _protocol];[player,[format ["Rev_%1_arty_flares", _protocol],45]] remoteExec ["say3D",_players,true];};
	case "Missile": {player sideRadio format ["Rev_%1_arty_call_missiles", _protocol];[player,[format ["Rev_%1_arty_call_missiles", _protocol],45]] remoteExec ["say3D",_players,true];};
	};

private _aika = count _list;
sleep (_aika * 1.5);

//Radio acknowledge
switch (_round_type) do {
	case "Missile": {_unit sideRadio format ["Rev_%1_arty_missiles", _protocol];};
	case "Air": {_unit sideRadio format ["Rev_%1_air_roger", _protocol]};
	case "Supply": {_unit sideRadio format ["Rev_%1_supply_roger", _protocol]};
	case "Gunship": {_unit sideRadio format ["Rev_%1_air_roger", _protocol]};
	case "Bombing": {_unit sideRadio format ["Rev_%1_bomb_roger", _protocol]};
	default {_unit sideRadio format ["Rev_%1_arty_roger", _protocol];};	
};

//Execute barrage function
sleep 7;
switch (_round_type) do {
	case "HE": {[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_HE;};
	case "Flare": {[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_ILM;};
	case "Smoke": {[_angle,_range,_pos,_number,_delay] spawn Rev_arty_fnc_barrage_SMK;};
	case "Missile": {[] spawn Rev_arty_fnc_missile_launch;};
	case "Air": {[] spawn Rev_arty_fnc_air_start};
	case "Supply": {[] spawn Rev_arty_fnc_supply_transport;};
	case "Gunship": {[] spawn Rev_arty_fnc_gunship_start;};
	case "Bombing": {[] spawn Rev_arty_fnc_bomb_plane};
};

//Remove generated radio if had none before
if (!_initial_radio) then {
	player unlinkItem ((assignedItems player) select {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0} select 0);
};

//Delete radio speaker
deleteVehicle _unit;