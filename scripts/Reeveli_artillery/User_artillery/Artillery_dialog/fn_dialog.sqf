/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to start the artillery dialog, creating and populating the dialog.
 * Called from ACE self-interaction, created in Rev_arty_fnc_player_init
 *
 * Arguments: NONE
 *
 * Return Value:
 * Return Value <BOOL>
 *
 * Example:
 * [] call Rev_arty_fnc_dialog
 *
 2.0.1
	Fixed wrong value used for area bombing
 2.0
	Complete rewrite to support new UI
 */

if !(hasInterface) exitWith {false};

//Preliminary night time check for dialog controls
if (((([player] call ACE_map_fnc_determineMapLight) select 1) select 3) > 0.55) then {
	//Setting night time colors: [frames alpha, shadow alpha, listBox color,lisbox color 2, slider alpha, list&box picture color]
	missionNamespace setvariable ['Rev_arty_n_alpha',[0.1,0.85,0.15,0.15,0.6,0.4],false];
} else {missionNamespace setvariable ['Rev_arty_n_alpha',[1,0,0.98,0.95,1,1],false];};

//Create main dialog
if (visibleMap) then {openMap false;};
createdialog "Rev_arty_dialog";

//Set night time image if needed
private _display = findDisplay 6060;
private _case = _display displayCtrl 6074;
private _trp_control = _display displayCtrl 6065;

if (((([player] call ACE_map_fnc_determineMapLight) select 1) select 3) > 0.55) then {
	_case ctrlSetText "scripts\Reeveli_artillery\images\case_n_5.paa";
	
	//Automatically start flaslight if present
	if ((count (player call ace_map_fnc_getUnitFlashlights)) < 1) exitWith {};
	private _flashlight = (player call ace_map_fnc_getUnitFlashlights) select 0;
	[player, _flashlight] call ace_map_fnc_switchFlashlight;
};


//List for target selection
private _list_trp = [["None",""]];
//Get list of pre placed markers
{
	private _currMarker = toArray _x;
	if(count _currMarker >= 3) then 
	{
		_currMarker resize 3;
		_currMarker = toString _currMarker;
		if(_currMarker == "trp") then
			{_list_trp append [[markerText _x,_x]];}; 
	};
} foreach allMapMarkers;

//Add to trp list in dialog
{
	private _name = (_x select 0);
	_trp_control lbAdd _name;
	_trp_control lbSetData [_forEachIndex, (_x select 1)];
} foreach _list_trp;

_trp_control lbSetCurSel 0;


//Centering map on screen
private _mapDisplay = findDisplay 6060;
private _mapControl = _mapDisplay displayCtrl 6061;

_mapControl ctrlMapAnimAdd [0, 1, [worldSize/2, worldSize/2]];
ctrlMapAnimCommit _mapControl;

//Setting up listNbox for available ordnance options
private _ordnance_control = findDisplay 6060 displayCtrl 6068;
if (Rev_arty_HE_enabled) then {
		_ordnance_control lnbAddRow ["High explosive",str Rev_arty_HE_amount];
	};

if (Rev_arty_SMK_enable) then {
		_ordnance_control lnbAddRow ["White smoke",str Rev_arty_SMK_amount];
	};

if (Rev_arty_ILM_enable) then {
		_ordnance_control lnbAddRow ["Illumination",str Rev_arty_ILM_amount];
	};

if (Rev_arty_MIS_enable) then {
		_ordnance_control lnbAddRow ["Tactical missile",str Rev_arty_MIS_amount];
	};

if (Rev_arty_CLU_enable) then {
		_ordnance_control lnbAddRow ["Cluster missile",str Rev_arty_CLU_amount];
	};

if (Rev_arty_AIR_enable) then {
		_ordnance_control lnbAddRow ["Air support",str Rev_arty_AIR_amount];
	};	

if (Rev_arty_SUP_enable) then {
		_ordnance_control lnbAddRow ["Supply drop",str Rev_arty_SUP_amount];
	};	

if (Rev_arty_GUN_enable) then {
		_ordnance_control lnbAddRow ["Gunship support",str Rev_arty_GUN_amount];
	};

if (Rev_arty_BOM_enable) then {
		_ordnance_control lnbAddRow ["Area bombing",str Rev_arty_BOM_amount];
	};



//Restore inputs from previous dialog
if !(isNil {Rev_artillery_dialog_result}) then
{
	Rev_artillery_dialog_result params ["_location","_distance","_bearing","_trp_index","_delay","_rounds_selected","_round_index","_map_pos","_map_scale"];
	//Pos
	ctrlSetText [6062,_location];
	//Distance
	ctrlSetText [6063,_distance];
	//Direction
	ctrlSetText [6064,_bearing];
	//TRP
    lbSetCurSel [6065,_trp_index];	
	//Delay
	ctrlSetText [6066,_delay];
	//Amount
	ctrlSetText [6067,_rounds_selected];	
	//Ammo type
    lnbSetCurSelRow [6068,_round_index];
	//Map pos and zoom
	_mapControl ctrlMapAnimAdd [0, _map_scale,_map_pos];
	ctrlMapAnimCommit _mapControl;
};


//return value
true;