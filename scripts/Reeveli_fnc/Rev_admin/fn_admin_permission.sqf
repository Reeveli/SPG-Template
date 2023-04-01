/*
 * Author: Reeveli
 * Part of SPG admin console, checks if the player should have access to curator module
 *
 * Arguments:
 * NONE
 *
 * Return: <BOOL>
 *	True: Access allowed
 *	False: Access not allowed
 *
 * Example:
 * call Rev_fnc_admin_permission
 *
 */

if (serverCommandAvailable '#kick') exitWith {true;};

if (getPlayerUID player in KLT_allowed_curators) then {true;} else {false;};
