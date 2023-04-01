/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Button-press function for group attributes dialog. Only run when dialog is open
 *
 * Arguments:
 * 0: Button type <NUMBER>
 * 1: Button number <NUMBER>
 *
 * Return Value <NONE>
 *
 * Example:
 *	[4,0] call Rev_RZ_fnc_group_button
 *
 */

params [
	["_type",-1,[0]],
	["_button",-1,[0]]
];

switch (_type) do {
	case 0: {
		private _engine = [false,true] select _button;
		(findDisplay 5080) setVariable ["Rev_RZ_vehicle_engine",_engine];
	};
	case 1: {
		private _lights = [false,true] select _button;
		(findDisplay 5080) setVariable ["Rev_RZ_vehicle_lights",_lights];
	};
	case 2: {
		(findDisplay 5080) setVariable ["Rev_RZ_vehicle_emcom",_button];
	};
};

private _vehicle = (findDisplay 5080) getVariable "Rev_RZ_vehicle";

fnc_set_color = {
	params ["_idc","_alpha"];
	private _control = (findDisplay 5080) displayCtrl _idc;
	private _color = ctrlTextColor _control;
	_control ctrlSetTextColor [_color select 0,_color select 1,_color select 2,_alpha];
};


private _engine = (findDisplay 5080) getVariable "Rev_RZ_vehicle_engine";
{[_x,0.3] call fnc_set_color} forEach [5084,5085];

switch (_engine) do {
	case false: {[5084,1] call fnc_set_color};
	case true: {[5085,1] call fnc_set_color};
	default {};
};

private _lights = (findDisplay 5080) getVariable "Rev_RZ_vehicle_lights";
{[_x,0.3] call fnc_set_color} forEach [5086,5087];
switch (_lights) do {
	case false: {[5086,1] call fnc_set_color};
	case true: {[5087,1] call fnc_set_color};
	default {};
};
