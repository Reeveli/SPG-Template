/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, air support.
 * Client side function to handle air support ending.
 *
 * Arguments:
 * 0: Plane <OBJECT>
 * 1: CBA statemachine <CBA statemachine>
 * 2: Was player killed <BOOL>
 *
 * Return Value: NONE
 *
 * Example:
 * [_plane,_stateMachine,false] call Rev_arty_fnc_air_disconnect
 *
 1.3
	Removed code and input params requiring radio
	Updated _timer loading method
 1.2.1
	TFAR_spg_radio_beta item requirement removed (not sure when it was inserted)
 1.2
	Item (re)assigment made targeted to the terminal if needed
 1.1
	Proper header and default params
 */

if !(hasInterface) exitWith {};
params ["_entity","_stateMachine","_killed"];

[_stateMachine] call CBA_statemachine_fnc_delete;

//viwDistance variables
setViewDistance Rev_arty_gun_view;
setObjectViewDistance Rev_arty_gun_view;
Rev_arty_gun_view = nil;


findDisplay 46 displayRemoveEventHandler ["keyDown",Rev_air_curator];

private _timer = missionNamespace getVariable ["Rev_arty_timer_air",-1];
[_timer] call CBA_fnc_removePerFrameHandler;
player connectTerminalToUAV objNull;
objNull remoteControl _entity;
player disableUAVConnectability [_entity, true];
player switchCamera "INTERNAL";

{player unlinkItem (player getVariable ["Rev_air_items",""])};
private _set_rate = player getVariable ["Rev_air_rating",0];
player addRating (_set_rate - (rating player));
player setVariable ["Rev_air_items",nil];
player setVariable ["Rev_air_unit",nil];
player setVariable ["Rev_air_rating",nil];

private _list = [vehicle _entity] + crew (vehicle _entity);
{
	_x removeAllEventHandlers "Killed";
	_x removeAllEventHandlers "Deleted";
} forEach _list;


//Waypoint management for group
if (!isNull Rev_air_pilot && (alive Rev_air_pilot)) then {
	private _group = group Rev_air_pilot;
	private _fin_pos = Rev_air_pilot getVariable ["Rev_air_fin_pos",[0,0,0]];
	[_group,_fin_pos] call Rev_arty_fnc_gunship_end;
};


Rev_air_pilot = nil;
if !(alive player) exitWith {};

["Air",_killed] call Rev_arty_fnc_user_completed
