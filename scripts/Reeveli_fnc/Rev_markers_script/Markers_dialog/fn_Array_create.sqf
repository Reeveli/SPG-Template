/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to create array of player placed map markers. Called from the mod menu.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_Array_create
 *
 */

if !(hasInterface) exitWith {};
private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4021;

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

_ctrl ctrlSetText (str _markers);

if (isServer) then {
	copyToClipboard str _markers;
	systemChat "Array copied to clipboard";
};
systemChat "Array created";