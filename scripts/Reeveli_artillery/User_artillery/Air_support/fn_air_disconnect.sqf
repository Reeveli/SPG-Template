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

[timer] call CBA_fnc_removePerFrameHandler;
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

//Check if user has radio (needed for sideradio command)
private _condition = {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0};
private _initial_radio = true;
if (_condition count assignedItems player == 0) then {
	_initial_radio = false;
	player linkItem "TFAR_anprc148jem";
	[{params ["_condition","_initial_radio","_killed"];_condition count assignedItems player > 0}, {[_this select 1,"Air",_this select 2] call Rev_arty_fnc_user_completed}, [_condition,_initial_radio,_killed],5] call CBA_fnc_waitUntilAndExecute;
} else {[_initial_radio,"Air",_killed] call Rev_arty_fnc_user_completed};
