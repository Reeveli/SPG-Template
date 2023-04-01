/*
Author: Belbo
Modified by Reeveli

Enables or disables info components on a vehicle

Arguments:
0: name of vehicle - <OBJECT>
1: enable/disable component - <BOOL>
2: Info component to include - <ARRAY> of <STRINGS>

Component types:
"MineDetectorDisplayComponent","MinimapDisplayComponent","CrewDisplayComponent","TransportFeedDisplayComponent","SensorsDisplayComponent","SlingLoadDisplayComponent"

Example:
_hiddenComponents = [vehicle player,false,["MinimapDisplayComponent"]] call Rev_fnc_info_panel;

*/

params [
	["_target",objNull,[objNull,[]]]
	,["_enable",false,[true]]
	,["_included",[],[[]]]
];

fnc_unit = {
	params ["_unit","_enable","_list"];
	{_unit enableInfoPanelComponent ["left",_x,_enable];} forEach _list;
	{_unit enableInfoPanelComponent ["right",_x,_enable];} forEach _list;
};

fnc_vehicle = {
	params ["_unit","_enable","_list","_turret"];
	{[_unit, _turret] enableInfoPanelComponent ["Right", _x, _enable]} forEach _list;
	{[_unit, _turret] enableInfoPanelComponent ["Left", _x, _enable]} forEach _list;
};


if (_target isKindof "CAManBase") then {[_target,_enable,_included] call fnc_unit;} else {
	
	private _turretPaths = [[-1]] + allTurrets _target;
	{[_target,_enable,_included,_x] call fnc_vehicle} forEach _turretPaths;
};