/*
 * Author: Reeveli
 * Part of SPG admin console, disbales zeus action for non-whitelisted players. Is run when pause menu is opened.
 * Called from description.ext
 *
 * Arguments:
 * 0: Pause menu <DISPLAY>
 *
 * Return Value:
 * NONE
 *
 */

params [
	["_pauseMenuDisplay",displayNull,[displayNull]]
];

if (isNull _pauseMenuDisplay) exitWith {};

private _control = _pauseMenuDisplay ctrlCreate ["Rev_admin_panel", -1];
