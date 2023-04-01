/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system.
 * Client side initializition necessary ACE actions, eventhandlers and ZEN curator modules. Called as a postinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_arty_fnc_player_init
 *
 1.2.1
	sideLogic made to array in Rev_zeus_trp CBA EH
	Cleaned function header
 1.2
	Added CBA event for curator placed TRPs.
	Added curator module for TRP placement
	Note: This function is now called as a PREINIT
 1.1
	Filepaths updated to new artillery folder
	Air strike and tactical missile ZEN module creation moved here from Rev_fnc_zeus_init
	All fire support context menu actions moved here from Rev_fnc_zeus_init
 */

if !(hasInterface) exitWith {};

//ZEN modules
if (isClass (configFile >> "CfgPatches" >> "zen_custom_modules")) then
{
	["Reeveli's ZEN Fire Support", "Artillery Barrage", {[_this select 0] call Rev_arty_fnc_zeus_artillery},"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Fire Support", "Air Strike", {[_this select 0] call Rev_arty_fnc_zeus_air_strike},"\a3\Modules_F_Curator\Data\portraitCAS_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Fire Support", "Tactical Missile", {[_this select 0] call Rev_arty_fnc_zeus_missile},"\a3\Modules_F_Curator\Data\portraitOrdnanceRocket_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Fire Support", "Add TRP", {[_this select 0] call Rev_arty_fnc_zeus_trp_dialog},"\A3\ui_f\data\map\markers\military\destroy_CA.paa"] call zen_custom_modules_fnc_register;
};

//Icon for ACE action
private _path = "";
switch (Rev_arty_HE_type) do
{
	case "Sh_82mm_AMOS": {_path = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\mortar_ca.paa"};
    default {_path = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa"};
};

//ACE action
private _arty_action =
["Reevelis_FO", "Open support planner", _path,
{[] call Rev_arty_fnc_dialog}, Rev_arty_fnc_user_condition] call ace_interact_menu_fnc_createAction;
["Man", 1, ["ACE_SelfActions"], _arty_action,true] call ace_interact_menu_fnc_addActionToClass;

//EHs to cancel artillery radio dialog
["ace_unconscious", {
	params ["_unit", "_state"];
	if !(_unit == player) exitWith {};
	if (_state && !(scriptDone (missionNamespace getVariable ["Rev_arty_radio_dialog", scriptNull]))) then {
		terminate Rev_arty_radio_dialog;
		private _battery = entities "Logic" select {_x getVariable [format ["Rev_battery_%1", player],false];};
		{deletevehicle _x} forEach _battery;
	};
	if !(isNil {player getVariable ["Rev_air_unit",nil]}) then {
		private _entity = player getVariable ["Rev_air_unit",nil];
		hintSilent "";
		[_entity,Rev_air_machine,true] call Rev_arty_fnc_air_disconnect;
	};
}] call CBA_fnc_addEventHandler;

player addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	terminate Rev_arty_radio_dialog;
	private _battery = entities "Logic" select {_x getVariable [format ["Rev_battery_%1", player],false];};
	{deletevehicle _x} forEach _battery;
		
	if !(isNil {player getVariable ["Rev_air_unit",nil]}) then {
		private _entity = player getVariable ["Rev_air_unit",nil];
		hintSilent "";
		[_entity,Rev_air_machine,true] call Rev_arty_fnc_air_disconnect;
	};
}];

//Local events to handle markers for curator placed TRPs
["Rev_zeus_trp", {
	params ["_position","_index", "_text","_type","_color","_sides"];
	if !(hasInterface) exitWith {};
	_sides pushBackUnique [sideLogic];
	if !(side player in _sides) exitWith {diag_log format ["Rev_zeus_trp: Player not in correct side, CBA event aborted"]};
	private _marker = createMarkerLocal [format ["trp_Rev_zeus_#%1",_index],_position];
	_marker setMarkerTextLocal _text;
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal _type;
	_marker setMarkerColorLocal _color;
}] call CBA_fnc_addEventHandler;

["Rev_zeus_trp_delete", {
	params ["_index"];
	if !(hasInterface) exitWith {};
	private _marker = format ["trp_Rev_zeus_#%1",_index];
	deleteMarkerLocal _marker;
}] call CBA_fnc_addEventHandler;

////////Context menu actions/////////
if (isClass (configFile >> "CfgPatches" >> "zen_context_menu")) then
{
	private _fire_support = [
		"Rev_fire_support",
		"Fire support",
		"\a3\Modules_F_Curator\Data\iconOrdnance_ca.paa",
		{
		},
		{true},
		[],
		{
				private _artillery_strike = [
					"Rev_arty_strike",
					"Artillery strike",
					"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\artillery_ca.paa",
					{[_position] call Rev_arty_fnc_zeus_artillery},
					{true}
				] call zen_context_menu_fnc_createAction;
				
				private _air_strike = [
					"Rev_air_strike",
					"Air strike",
					"\a3\Modules_F_Curator\Data\portraitCAS_ca.paa",
					{[_position] call Rev_arty_fnc_zeus_air_strike},
					{true}
				] call zen_context_menu_fnc_createAction;

				private _missile_strike = [
					"Rev_missile_strike",
					"Tactical missile",
					"\a3\Modules_F_Curator\Data\portraitOrdnanceRocket_ca.paa",
					{[_position] call Rev_arty_fnc_zeus_missile},
					{true}
				] call zen_context_menu_fnc_createAction;

				private _trp = [
					"Rev_arty_trp",
					"Add TRP",
					"\A3\ui_f\data\map\markers\military\destroy_CA.paa",
					{[_position] call Rev_arty_fnc_zeus_trp_dialog},
					{true}
				] call zen_context_menu_fnc_createAction;

				[[_artillery_strike,[],3],[_air_strike,[],2],[_missile_strike,[],1],[_trp,[],0]];
				
		}
	] call zen_context_menu_fnc_createAction;

	[_fire_support, [], 0] call zen_context_menu_fnc_addAction;
};