/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to hande allowed channels based on addon options. Called as from CBA addon options code.
 *
 * Arguments: NONE
 *
 * Return Value: BOOLEAN
 *
 * Example:
 * call Rev_markers_fnc_channels
 *
 2.0
	Function rewritten with Arma 2.22 update commands
	Also improved diag_log prints readability
 */



if !(Rev_marker_CBA) exitWith {
	
    diag_log text "Rev_markers_fnc_channels INFO: Function closure, mod CBA settings not being used";
	false;
};

params [
	["_channel",0,[0]],
	["_chat",0,[0]],
	["_markers",0,[0]]
];

switch _chat do {
	case 0: {_chat = [true,false]};
	case 1: {_chat = [false,true]};
	case 2: {_chat = [true,true]};
	default {_chat = [false,false]};
};

switch _markers do {
	case 0: {_chat append [true,false]};
	case 1: {_chat append [false,true]};
	case 2: {_chat append [true,true]};
	default {_chat append [false,false]};
};

_channel enableChannel _chat;
diag_log text (format ["Rev_markers_fnc_channels INFO: [%1,%2]",_channel,_chat]);
_chat