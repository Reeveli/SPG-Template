/*
 * Author: Reeveli, Brett 
 * Part of Reeveli's Suppressive fire system.
 * Client side function to create necessary eventhandlers to handle the 3D UI elements of suppressive fire.
 * Called from a ZEN context menu action.
 *
 * Arguments:
 * 0: Selected unit <OBJECT>
 *
 * Example:
 * [_objects select 0] call Rev_fnc_suppress;
 *

1.1.1
	Fixed one wrong comment

1.1
	Added 'empty' EH to group to delete target
	Deleted unused _units varibale definition
	Added some additional comments

 */

params [
	["_unit", objNull, [objNull]]
];

if (isNull findDisplay 312) exitWith {diag_log "Rev_fnc_suppress: Function called when not curator!"};

private _display = findDisplay 312;
_display setVariable ["Rev_suppress_unit",_unit];

private _line = addMissionEventHandler ["Draw3D", {
		_thisArgs params ["_unit"];

		// The cursor position in the world
		private _pos = AGLtoASL screenToWorld getMousePosition;
		private _intersections = lineIntersectsSurfaces [getPosASL curatorCamera, _pos];
		if (_intersections isNotEqualTo []) then {
			_pos = _intersections select 0 select 0;
		};

		// Check 0.2 above the cursor to prevent a small object on the terrain blocking the view
		private _posHigh = _pos vectorAdd [0, 0, 0.2];

		//Check if LOS is unobstructed
		private _eyePos = eyePos _unit;
		if (lineIntersectsSurfaces [_eyePos, _pos, _unit, objNull] isEqualTo [] || {lineIntersectsSurfaces [_eyePos, _posHigh, _unit, objNull] isEqualTo []}) then {

			// Draw a line from group leader if no intersections
			drawLine3D [ASLToAGL _eyePos, ASLToAGL _pos, [1,0,0,1]];
		};

		// Marker to indicate final position, could be made confditional of LOS but I decided against
		drawIcon3D [
			"\A3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa",
			[1, 0, 0, 1],
			ASLToAGL _pos,
			1, 1.3, 0,
			"",
			2,
			0.04,
			"PuristaMedium",
			"center"
		];

	},
	[_unit]
];

missionNameSpace setVariable ["Rev_suppress_line",_line,false];

//Small delay since instant exedcution would fire immediately when ZEN context menu was closed
[{
	private _mouseC = (findDisplay 312) displayAddEventHandler ["MouseButtonUp", {
		params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
		if !(_button isEqualTo 0) exitWith {
			removeMissionEventHandler ['Draw3D', missionNameSpace getVariable ["Rev_suppress_line",-1]];
			(findDisplay 312) displayRemoveEventHandler ["MouseButtonUp", missionNameSpace getVariable ["Rev_suppress_mouse",-1]];
			(findDisplay 312) setVariable ["Rev_suppress_unit",nil];
			true;
		};

		private _unit = (findDisplay 312) getVariable ["Rev_suppress_unit",objNull];
		private _pos = screenToWorld getMousePosition;
		private _logic = createGroup [sideLogic,true];
		private _target = _logic createUnit ["Logic",_pos, [], 0, ""];
		//Not added to all curators because of RZ. Solution would be to add a non-player specific varaible to each RZ module that could be used to filter those curator logic from normal ones. Perhaps in the future if additional need for this arises.
		[getAssignedCuratorLogic player,[[_target],true]] remoteExecCall ["addCuratorEditableObjects",2];
		[_logic,["Suppression Target"]] remoteExecCall ["setGroupId", 0];

		//Removing draw EH
		removeMissionEventHandler ['Draw3D', missionNameSpace getVariable ["Rev_suppress_line",-1]];
		(findDisplay 312) displayRemoveEventHandler ["MouseButtonUp", missionNameSpace getVariable ["Rev_suppress_mouse",-1]];

		//Setting group and target varibales
		private _group = group _unit;
		_group setVariable ["Rev_suppression",_target,true];
		_target setVariable ["Rev_suppression_units",_group,true];

		//If target is deleted then set group's suppression var to false (to enable them to suppress something else)
		_target addEventHandler ["Deleted", {
			params ["_entity"];
			private _group = _entity getVariable ["Rev_suppression_units", grpNull];
			if !(isNull _group) then {_group setVariable ["Rev_suppression",nil,true];};	
		}];

		//If group is deleted/killed remove target logic as unnecessary
		_group addEventHandler ["Empty", {
			params ["_group"];
			private _target = _group getVariable ["Rev_suppression", objNull];
			if !(isNull _target) then {deleteVehicle _target};
		}];


		//CBA event for the actual suppression
		["Rev_suppression_event", [_group,_target], _group] call CBA_fnc_targetEvent;

		//removing UI varibale
		(findDisplay 312) setVariable ["Rev_suppress_unit",nil];
		
	}];

	missionNameSpace setVariable ["Rev_suppress_mouse",_mouseC,false];

}, [], 0.5] call CBA_fnc_waitAndExecute;
