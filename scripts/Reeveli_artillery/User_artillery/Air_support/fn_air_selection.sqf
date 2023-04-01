/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, air support.
 * Client side function to handle air support dialog plane loadout and skins.
 *
 * Arguments:
 * 0: Selected plane class <STRING> (default: "B_Plane_Fighter_01_F")
 *
 * Return Value: NONE
 *
 * Example:
 * [_control lbData _selectedIndex] call Rev_arty_fnc_air_selection;
 *
 3.0
	Rewrite for new UI, listbox command chamged to list&box
	Old skin related code deleted
 2.0
	Rewrite to work with new dialog. Skin selection left as dead code for archival purposes
 */

params [
	["_class","B_Plane_Fighter_01_F",[""]]
];

private _img = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
ctrlSetText [6075, _img];



//Loadout list
lnbClear 4083;
private _lo_list = [configfile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Presets"] call BIS_fnc_getCfgSubClasses;
private ["_lo_name","_ammo_list"];
{
	_lo_name = getText (configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Presets" >> _x >> "displayName");
	_control = findDisplay 4080 displayCtrl 4083;
	_control lbAdd _lo_name;
	_control lbSetData [_forEachIndex, _x];

} forEach _lo_list;

lbSetCurSel [4083, 0];


//Map marker
private _marker = "b_plane";
if (_class isKindOf "Helicopter") then {_marker = "b_air"};
if (_class isKindOf "UAV") then {_marker = "b_uav"};

"Rev_arty_air_dir" setMarkerTypeLocal _marker;
private _name = getText (configFile >> "CfgVehicles" >> _class >> "displayname");
"Rev_arty_air_dir" setMarkerTextLocal _name;