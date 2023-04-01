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
		private _formation = ["WEDGE","VEE","LINE","COLUMN","FILE","STAG COLUMN","ECH LEFT","ECH RIGHT","DIAMOND"] select _button;
		(findDisplay 5050) setVariable ["Rev_RZ_group_formation",_formation];
	};
	case 1: {
		private _behaviour = ["SAFE","AWARE","COMBAT","STEALTH","CARELESS"] select _button;
		(findDisplay 5050) setVariable ["Rev_RZ_group_behaviour",_behaviour];
	};
	case 2: {
		private _mode = ["BLUE","GREEN","WHITE","YELLOW","RED"] select _button;
		(findDisplay 5050) setVariable ["Rev_RZ_group_mode",_mode];
	};
	case 3: {
		private _speed = ["LIMITED","NORMAL","FULL"] select _button;
		(findDisplay 5050) setVariable ["Rev_RZ_group_speed",_speed];
	};
	case 4: {
		private _pos = ["Down","Middle","Up","Auto"] select _button;
		(findDisplay 5050) setVariable ["Rev_RZ_group_pos",_pos];
	};
};

private _group = (findDisplay 5050) getVariable "Rev_RZ_group";

fnc_set_color = {
	params ["_idc","_alpha"];
	private _control = (findDisplay 5050) displayCtrl _idc;
	private _color = ctrlTextColor _control;
	_control ctrlSetTextColor [_color select 0,_color select 1,_color select 2,_alpha];
};


private _formation= (findDisplay 5050) getVariable "Rev_RZ_group_formation";
{[_x,0.3] call fnc_set_color} forEach [5052,5053,5054,5055,5056,5057,5058,5059,5060];
(findDisplay 5050) setVariable ["Rev_RZ_group_formation",_formation];
switch (_formation) do {
	case "WEDGE": {[5052,1] call fnc_set_color};
	case "VEE": {[5053,1] call fnc_set_color};
	case "LINE": {[5054,1] call fnc_set_color};
	case "COLUMN": {[5055,1] call fnc_set_color};
	case "FILE": {[5056,1] call fnc_set_color};
	case "STAG COLUMN": {[5057,1] call fnc_set_color};
	case "ECH LEFT": {[5058,1] call fnc_set_color};
	case "ECH RIGHT": {[5059,1] call fnc_set_color};
	case "DIAMOND": {[5060,1] call fnc_set_color};
	default {};
};

private _behaviour = (findDisplay 5050) getVariable "Rev_RZ_group_behaviour";
{[_x,0.3] call fnc_set_color} forEach [5062,5063,5064,5065,5066];
(findDisplay 5050) setVariable ["Rev_RZ_group_behaviour",_behaviour];
switch (_behaviour) do {
	case "SAFE": {[5062,1] call fnc_set_color};
	case "AWARE": {[5063,1] call fnc_set_color};
	case "COMBAT": {[5064,1] call fnc_set_color};
	case "STEALTH": {[5065,1] call fnc_set_color};
	case "CARELESS": {[5066,1] call fnc_set_color};
	default {};
};

private _mode = (findDisplay 5050) getVariable "Rev_RZ_group_mode";
{[_x,0.3] call fnc_set_color} forEach [5067,5068,5069,5070,5071];
(findDisplay 5050) setVariable ["Rev_RZ_group_mode",_mode];
switch (_mode) do {
	case "BLUE": {[5067,1] call fnc_set_color};
	case "GREEN": {[5068,1] call fnc_set_color};
	case "WHITE": {[5069,1] call fnc_set_color};
	case "YELLOW": {[5070,1] call fnc_set_color};
	case "RED": {[5071,1] call fnc_set_color};
	default {};
};

private _speed = (findDisplay 5050) getVariable "Rev_RZ_group_speed";
{[_x,0.3] call fnc_set_color} forEach [5072,5073,5074];
(findDisplay 5050) setVariable ["Rev_RZ_group_speed",_speed];
switch (_speed) do {
	case "LIMITED": {[5072,1] call fnc_set_color};
	case "NORMAL": {[5073,1] call fnc_set_color};
	case "FULL": {[5074,1] call fnc_set_color};
	default {};
};

private _pos = (findDisplay 5050) getVariable "Rev_RZ_group_pos";
{[_x,0.3] call fnc_set_color} forEach [5075,5076,5077,5078];
(findDisplay 5050) setVariable ["Rev_RZ_group_pos",_pos];
switch (_pos) do {
	case "Down": {[5075,1] call fnc_set_color};
	case "Middle": {[5076,1] call fnc_set_color};
	case "Up": {[5077,1] call fnc_set_color};
	case "Auto": {[5078,1] call fnc_set_color};
	default {};
};