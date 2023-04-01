/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator placed TRPs for user artillery system.
 *
 * Arguments:
 * 0: Potision <ARRAY>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_position] call Rev_arty_fnc_zeus_trp_dialog
 *
 1.1
	Extra _index removed from "Rev_zeus_trp" CBA_fnc_globalEventJIP call as unnecessary
	_index is set as CBA_missiontime
	unnecessary _index2 varibale removed
	Deleted some old leftover code
 */

params ["_position"];

private _configs = ["mil_destroy","hd_destroy","waypoint","mil_objective","hd_objective","mil_dot","mil_box","mil_triangle"];

private _marker_list = [
	["Target","","\A3\ui_f\data\map\markers\military\destroy_CA.paa"],
	["Target drawn","","\A3\ui_f\data\map\markers\handdrawn\destroy_CA.paa"],
	["X","","\A3\ui_f\data\map\groupicons\waypoint.paa"],
	["Objective","","\A3\ui_f\data\map\markers\military\objective_CA.paa"],
	["Objective drawn","","\A3\ui_f\data\map\markers\handdrawn\objective_CA.paa"],
	["Dot","","\A3\ui_f\data\map\markers\military\dot_CA.paa"],
	["Square","","\A3\ui_f\data\map\markers\military\box_CA.paa"],
	["Triangle","","\A3\ui_f\data\map\markers\military\triangle_CA.paa"]
];

private _colors = [
	["Black","","",[1,1,1,1]],
	["Red","","",[0.9,0,0,1]],
	["Blue","","",[0,0,1,1]],
	["Green","","",[0,0.8,0,1]],
	["Orange","","",[0.85,0.4,0,1]],
	["Yellow","","",[0.85,0.85,0,1]]
];

[
	"Reeveli's Artillery Barrage",
	[
		["EDIT",["Marker text","Marker text visible on the map, make it unique, e.g. TRP 1"],["",{}],false],
		["COMBO",["Marker type",""],[_configs,_marker_list,0],false],
		["COMBO",["Marker color",""],[["ColorBlack","ColorRed","ColorBlue","ColorGreen","ColorOrange","ColorYellow"],_colors],false],
		["SIDES",["Marker side visibility","Which sides can see the marker on their maps"],[WEST],false]
	],
	{
		
		params ["_results","_position"];
		private _text = _results select 0;
		private _type = _results select 1;
		private _color = _results select 2;
		private _sides = _results select 3;

		private _index = str CBA_missiontime;

		["Rev_zeus_trp", [_position select 0,_index,_text,_type,_color,_sides]] call CBA_fnc_globalEventJIP;
		private _group = createGroup [sideLogic,true];
		private _vehicle = _group createUnit ["Logic",_position select 0, [], 0, ""];
		//Not added to all curators because of RZ. Solution would be to add a non-plyare specific varaible to each RZ module that could be used to fillter those curator logic from normal ones. Perhaps in the future if additional need for this arises.
		[getAssignedCuratorLogic player,[[_vehicle],true]] remoteExecCall ["addCuratorEditableObjects",2];




		_vehicle setVariable ["TRP_idx",_index, true];
		_vehicle addEventHandler ["Deleted", {
			params ["_entity"];
			private _index = _entity getVariable ["TRP_idx",-1];
			["Rev_zeus_trp_delete", [_index]] call CBA_fnc_globalEventJIP;
		}];
		
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	],
	"Rev_zeus_Artillery_id"
] call zen_dialog_fnc_create;