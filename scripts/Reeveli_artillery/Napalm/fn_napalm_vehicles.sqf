/*
 * Author: Reeveli 
 * Part of napalm system
 * Handels vehicle damage from napalm fire. Server side script.
 * Called from Rev_arty_fnc_napalm_hit
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_x] spawn Rev_arty_fnc_napalm_vehicles}
 *
 */


if (!isServer) exitWith {};

params [
	["_vehicle",objNull,[objNull]]
];

if (isNull _vehicle) exitWith {diag_log "Rev_arty_fnc_napalm_vehicles: No object provided"};

//setting damage on engine
private _currentDamage = _vehicle getHitPointDamage "hitengine";
[_vehicle, [getText (configFile >> "cfgVehicles" >> typeof _vehicle >> "HitPoints" >> "HitEngine" >> "name"), _currentDamage + 0.46]] remoteExec ["setHit", _vehicle];
if ((_vehicle getHitPointDamage "hitengine") <= 0.9) exitwith {};

//Set engine on fire 
_vehicle call ace_cookoff_fnc_engineFire;

//Setting crew on fire if high damage on vehicle
private _crew = fullCrew _vehicle;
if (count _crew  > 0) then 
{
	{
		["ACE_fire_burn", [_x select 0, 5]] call CBA_fnc_globalEvent;
	} forEach _crew ;
};

//Set cookoff
[_vehicle, 0.5, 3] call ace_vehicle_damage_fnc_handleCookoff;