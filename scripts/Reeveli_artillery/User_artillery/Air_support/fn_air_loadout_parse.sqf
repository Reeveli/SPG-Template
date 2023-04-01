/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, air supprt dialog.
 * Client side function to generate a string listing all weapons of a config loadout preset.
 * Called from 'Rev_arty_air_map' dialog 'Loadout_selection' control.
 *
 * Arguments:
 * 0: Vehicle class <STRING>
 * 1: Loadout preset config name <STRING>
 * 2: Dialog control <CONTROL> (optional)
 *
 * Return Value:
 * List of loadout weapons <STRING>
 *
 * Example:
 * [lbData  [4081, lbCurSel 4081],_control lbData _selectedIndex,_control] call Rev_arty_fnc_air_loadout_parse;
 *
 TODO:
	Develop some way of passing the descriptions of each wepon as tooltip to listNbox (some dead code left as legacy for this feature, no solution found yet)
 */

params [
	["_class","",[""]],
	["_displayName","",[""]],
	["_control",controlNull,[controlNull]]
];

private _magazines = getArray (configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Presets" >> _displayName >> "attachment");

private _uniques = _magazines arrayIntersect _magazines;
private _weaponList = [];
private _mag_list = [];
private _tooltips = [];


//Getting pair arrays of all different mags and their combined ammo
private ["_amount","_weapon","_prettyName","_tooltip"];
{
	if (_x isEqualTo "") then {continue};
	_amount = getNumber (configFile >> "CfgMagazines" >> _x >> "count");
	_weapon = getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");
	_prettyName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
	//_tooltip = getText (configFile >> "CfgMagazines" >> _x >> "descriptionShort");
	[_weaponList,_prettyName,_amount,false] call BIS_fnc_addToPairs;
	//[_weaponList,_prettyName,_tooltip,false] call BIS_fnc_addToPairs;

} forEach _magazines;



lnbClear 4086;
private ["_amount","_prettyName"];
{
	_prettyName = _x select 0;
	_amount = format ["%1x",str (_x select 1)];
	lnbAddRow [4086, [_amount,_prettyName]];
	//_control lnbSetTooltip [[_forEachIndex, 1], _x select 2];
} forEach _weaponList;

