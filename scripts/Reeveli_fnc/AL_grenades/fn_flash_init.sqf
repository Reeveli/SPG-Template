/*
 * Author: Reeveli
 * Add eventhandler for registering custom flasbang throws by players. Called automatically as postinit function.
 *
 * Arguments: NONE
 *
 * Return Value: <BOOL>
 *
 * Example:
 * call AL_fnc_flash_init
 *
 1.1
	Added interface safety condition
 */

if !(hasInterface) exitWith {};

if ((count Al_flash_classes_whitelist)>0) then {
	
	["ace_firedPlayer", {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];
		if ((toUpper (typeOf _projectile)) in Al_flash_classes_whitelist) then {
			[_projectile] spawn AL_fnc_stun_life;
		};
	}] call CBA_fnc_addEventHandler;
	true;
} else {false};

