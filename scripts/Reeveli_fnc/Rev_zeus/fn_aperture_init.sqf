/*
 * Author: Reeveli
 * Clientside function to create CBA event for aperture control.
 * Called as a postinit.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_fnc_aperture_init
 *
 */


if !(hasInterface) exitWith {};

//Aperture event
["Rev_aperture", {
	if !(hasInterface) exitWith {};
	params ["_value"];
	setAperture _value;

	diag_log format ["Rev_aperture, new value: %1", _value];
}] call CBA_fnc_addEventHandler;
