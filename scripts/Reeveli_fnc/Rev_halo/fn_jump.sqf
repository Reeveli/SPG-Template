/*
 * Author: Reeveli 
 * Part of Reeveli's HALO system.
 * Function to handle units ejecting out of HALO plane. Called from halo_plane.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value: <BOOL>
 * True: Function run succesfully
 * False: Function safety cancel
 *
 * Example:
 * [vehicle this,'JUMP, JUMP, JUMP!'] remoteExec ['vehicleChat',_jumpers,false]
 *
 1.1
	Added damage protection during eject action
 */

params [
	["_unit",objNull,[objNull]]
];

if (isNull _unit) exitWith {false};

_unit action ['Eject', vehicle _unit];
_unit allowdamage false;

[_unit] spawn {
	params ["_unit"];
	sleep 1.5;
	_unit setVelocity [0, 0, -10];
	_unit allowdamage true;
};

true;