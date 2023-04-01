/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to load markers from array. Called from the markers menu.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_Array_load
 *
 */
 
if !(hasInterface) exitWith {};
private _strID = getPlayerID player;
private _person = player;
private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4021;
if ((count (ctrlText _ctrl) < 1)) exitWith {systemChat "No valid array inputted"};

private _markers = parseSimpleArray (ctrlText _ctrl);
if ((count _markers < 1)) exitWith {systemChat "No valid array inputted"};

private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl2 = _disp displayCtrl 4022;
private _index_c = lbCurSel _ctrl2;
private _channel = _ctrl2 lbData _index_c;
private ["_num"];
{
	_x params ["_pos", "_type", "_dir", "_color", "_text", "_size", "_alpha", "_shape", "_data"];
	_num = str _forEachIndex;
	private _id = "_USER_DEFINED #" + _strID + "/" + _num + "/" + _channel;
	private _m = createMarker [_id, _pos, parsenumber _channel, _person];
	_m setMarkerType _type;
	_m setMarkerDir _dir;
	_m setMarkerColor _color;
	_m setMarkerText _text;
	_m setMarkerSize _size;
	_m setMarkerAlpha _alpha;
	_m setMarkerShape _shape;				

	if (_shape == "POLYLINE") then {
		_m setMarkerPolyline _data;
	};

} forEach _markers;

systemChat "Loaded markers from array";
call Rev_markers2_fnc_set_channel;
