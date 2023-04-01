/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to save marker set to profile.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_save
 *
 1.1
	Added diag_log to function end for debugging purposes
 */

if !(hasInterface) exitwith {};

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4021;
private _name = ctrlText _ctrl;

if (_name isEqualTo "") exitWith {playSound "FD_Start_F";systemChat "Name marker set in the text field!"};
if ((_name select [0, 1]) isEqualTo "[") exitWith {playSound "FD_Start_F";systemChat "Properly name marker set!"};

private _key = "full";
private ["_var"];
for "_i" from 0 to 99 do 
{
	_var =  format ["spanx_markers_%1",_i];
	if (isNil {profileNamespace getVariable [_var,nil]}) exitWith {_key = format ["spanx_markers_%1", _i];};
};
if (_key isEqualTo "full") exitWith {playSound "FD_Start_F"; systemChat "User profile is full! You can only have 99 marker sets saved at any time."};

private _markers = [];

private ["_a","_pos","_type","_dir","_color","_text","_size","_alpha","_shape","_data","_marker"];

{
	_a = toArray _x;
	_a resize 15;
	if (toString _a == "_USER_DEFINED #") then {			

		_pos = getMarkerPos _x;
		_type = getMarkerType _x;
		_dir = markerDir _x;
		_color = getMarkerColor _x;				
		_text = markerText _x;
		_size = getMarkerSize _x;
		_alpha = markerAlpha _x;
		_shape = markerShape _x;
		_data = "";
		if (_shape == "POLYLINE") then {
			_data = markerPolyline _x;
		};
		_marker = [_pos, _type, _dir, _color, _text, _size, _alpha, _shape, _data];
		_markers pushBack _marker;	
	}	
} forEach allMapMarkers;

private _master = [worldName,_name,_markers];

profileNamespace setVariable [_key,_master];				
saveProfileNamespace;
call Rev_markers2_fnc_worlds;

systemChat "Markers saved to profile";
diag_log "Rev_marker_system: Marker set saved to profile";
diag_log format ["Rev_marker_system: Saved set key: %1",_key];