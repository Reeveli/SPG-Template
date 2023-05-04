/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to load and create selected marker set from profile. Called from the mod menu.
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_get_load
 *
 1.1
	Added default value to Rev_markers_counter
 */

if !(hasInterface) exitwith {};
private _disp = uiNamespace getVariable ["Rev_marker_menu", DisplayNull];
private _ctrl = _disp displayCtrl 4051;
private _ctrl2 = _disp displayCtrl 4022;

private _strID = getPlayerID player;
private _person = player;

private _index = lbCurSel _ctrl;
if (_index isEqualTo -1) exitWith {playSound "FD_Start_F";systemChat "No marker set selected!"};


private _markers = (parseSimpleArray (_ctrl lbData _index)) select 1;;
private _index_c = lbCurSel _ctrl2;
private _channel = _ctrl2 lbData _index_c;

private _counter = missionNamespace getVariable ["Rev_markers_counter",0];

private ["_num","_id","_m"];
{
	_x params ["_pos", "_type", "_dir", "_color", "_text", "_size", "_alpha", "_shape", "_data"];
	_num = (str _counter) + (str _forEachIndex);
	_id = "_USER_DEFINED #" + _strID + "/" + _num + "/" + _channel;
	_m = createMarker [_id, _pos, parsenumber _channel, _person];
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


missionNamespace setVariable ["Rev_markers_counter", _counter +1];
systemChat "Selected marker set loaded from profile"