/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to add necessary eventhandeler to manage marker deletion. Run as a postinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_removal
 *
 1.2
	Added additional code filtering only for user placed markers to prevent any future script incompabilities
 1.1
	Added to check if a dialog is open that requires markers to work
 */

if !(hasInterface) exitWith {};

addMissionEventHandler ["MarkerCreated", {
	params ["_marker", "_channelNumber", "_owner"];
	private _check = false;
	{if !(isNull (findDisplay _x)) then {_check = true;}} forEach [4060,4080,6020,6030,6040,6050];
	if (_check) exitWith {};
	
	private _a = toArray _marker;
	_a resize 15;

	if ((getClientStateNumber > 9) && Rev_marker_briefing && (toString _a == "_USER_DEFINED #")) exitWith {_marker spawn {deleteMarker _this};};
	private _list = call Rev_markers2_fnc_control;
	if (_channelNumber in _list && (toString _a == "_USER_DEFINED #")) then {
		_marker spawn {deleteMarker _this};
	};

}];