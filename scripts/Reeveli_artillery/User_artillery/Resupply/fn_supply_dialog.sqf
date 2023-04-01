/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, aerial resupply ordnance.
 * Client side function to start the supply dialog, creating necessary item list from CBA options.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_arty_fnc_supply_dialog
 *
 1.1
	Added code to create map marker where the target area is. Will be deled via onUnload function
 */

//Setting markers on map
private _args = missionNamespace getVariable ['Rev_artillery_call',nil];
private _target = _args select 3;
private _pos = _args select 5;

private _alpha = 1;
if (typeName _target isEqualTo "STRING") then {_alpha = 0};

//Target marker
private _target_pos = createMarkerLocal ["Rev_arty_sup_tgt",_pos];
"Rev_arty_sup_tgt" setMarkerTextLocal "Supply Drop";
"Rev_arty_sup_tgt" setMarkerShapeLocal "ICON";
"Rev_arty_sup_tgt" setMarkerTypeLocal "hd_end";
"Rev_arty_sup_tgt" setMarkerColorLocal "ColorBlue";
"Rev_arty_sup_tgt" setMarkerAlphaLocal _alpha;




//Populating the rets of dialog
uiNamespace setVariable ["Rev_supply_list", nil]; 
private _list = parseSimpleArray Rev_arty_SUP_list;
private _items = parseSimpleArray Rev_arty_SUP_list;
  
{  
	_items set [_forEachindex,[_x,0]];  
} forEach _items;  
  
 
uiNamespace setVariable ["Rev_supply_list", _items];  
createDialog "Rev_arty_supply_dialog";  
[_list] call Rev_arty_fnc_supply_list;

ctrlEnable [5023, false];

//preliminary night time check for dialog color inherited from main arty dialog
//Set night time image if needed
private _display =  findDisplay 5013;
private _case = _display displayCtrl 6074;
private _mapControl = _display displayCtrl 6061;

if (((([player] call ACE_map_fnc_determineMapLight) select 1) select 3) > 0.55) then {
	_case ctrlSetText "scripts\Reeveli_artillery\images\case_n_5.paa";

	//Automatically start flaslight if present
	if ((count (player call ace_map_fnc_getUnitFlashlights)) < 1) exitWith {};
	private _flashlight = (player call ace_map_fnc_getUnitFlashlights) select 0;
	[player, _flashlight] call ace_map_fnc_switchFlashlight;
};

//Restore map position
if !(isNil {Rev_artillery_dialog_result}) then
{
	Rev_artillery_dialog_result params ["_location","_distance","_bearing","_trp_index","_delay","_rounds_selected","_round_index","_map_pos","_map_scale"];
	//Map pos and zoom
	_mapControl ctrlMapAnimAdd [0, _map_scale,_map_pos];
	ctrlMapAnimCommit _mapControl;
};