/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator to remove a TRP.
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * call Rev_arty_fnc_zeus_removeTRP_dialog
 *
 */

//List for target selection
private _list_trp = [];
private _list_names = [];
//Get list of pre placed markers
{
	private _currMarker = toArray _x;
	if(count _currMarker >= 3) then 
	{
		_currMarker resize 3;
		_currMarker = toString _currMarker;
		if(_currMarker == "trp") then {
			_list_trp append [_x];
			_list_names append [markerText _x];
		};
			
	};
} foreach allMapMarkers;

if (count _list_trp < 1) exitWith {	
		playSound "FD_Start_F";
		[objNull, "No TRP available!"] call BIS_fnc_showCuratorFeedbackMessage;
};

private _count = (count _list_trp);
private _width = ceil (sqrt _count);
private _height = ceil (((_count - _width) / _width) + 1);

[
	"Remove TRP",
	[
		["TOOLBOX:WIDE","Current TRPs",[0,_width,_height,_list_names],false],
		["CHECKBOX","Delete selected TRP",[false],false]

	],
	{
		params ["_results","_passed_arguments"];
		private _marker = _passed_arguments select (_results # 0);
		if (_results # 1) then {
			deleteMarker _marker;			
			[objNull, "TRP removed"] call BIS_fnc_showCuratorFeedbackMessage;
		};
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	_list_trp
] call zen_dialog_fnc_create;