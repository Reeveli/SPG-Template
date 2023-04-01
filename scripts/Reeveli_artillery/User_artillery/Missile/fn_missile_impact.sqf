/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, tactical missile ordnance.
 * Handels tactical missile impact
 *
 * Arguments:
 * 0: Transmitted target position/Last known laser target position <ARRAY>
 * 1: Missile class <STRING> (default: "ammo_Missile_Cruise_01")
 * 2: Flight tracker <BOOLEAN> (default: true)
 * 3: Current missile position <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_last_pos,_class,_testing,_actual_pos] call Rev_arty_fnc_missile_impact
 *
 */

params [
	["_last_pos",nil,[[]],[2,3]],    
	["_type","ammo_Missile_Cruise_01",[""]],
	["_testing",true,[true]],
	["_actual_pos",nil,[[]],[2,3]]
];

//Custom scripted warhead
if (Rev_arty_alias_enabled && (_type isEqualTo "ammo_Missile_Cruise_01")) then {
    [_actual_pos,Rev_arty_missiles_crater] remoteExecCall ["Rev_arty_fnc_warhead_init",2];
    [_actual_pos] call Rev_arty_fnc_react;
};

//Normal warhead
if (!(Rev_arty_alias_enabled) && (Rev_arty_missiles_crater) && (_type isEqualTo "ammo_Missile_Cruise_01")) then
{
    private _c = createVehicle ["Land_ShellCrater_02_large_F", _actual_pos, [], 0, "CAN_COLLIDE"];[_c, false] remoteExec ["enableSimulationGlobal", 2];
    [_actual_pos] call Rev_arty_fnc_react;
};

if(_testing) then {
    hintSilent "MODE: NO SIGNAL";
};

//Kill flight tracker
[{hintSilent "";},[], 10] call CBA_fnc_waitAndExecute;