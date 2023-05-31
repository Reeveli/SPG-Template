/*
 * Author: Reeveli & Killet
 * Part of SPG default scripts.
 * Includes all custom CBA extended preinit calls to keepd escription.ext clean.

1.1
	Added Reeveli's teleportation system settings
*/

class KLT_CBA_Settings_keybinds {init = "call compile preProcessFileLineNumbers 'scripts\KLT\Zeus\zeuscam\CBAKeys.sqf'";};              //Killets Zeus Tools
class Reeveli_artillery {init = "call compile preprocessFileLineNumbers 'scripts\Reeveli_artillery\Rev_arty_settings.sqf'";};
class SPG_settings {init = "call compile preprocessFileLineNumbers 'scripts\SPG\SPG_settings.sqf'";};
class Reeveli_Advanced_gestures {init = " call compile preprocessFileLineNumbers 'scripts\Reeveli_fnc\Rev_gestures\Rev_advanced_gestures_settings.sqf'";};
class Reveli_user_markers {init = " call compile preprocessFileLineNumbers 'scripts\Reeveli_fnc\Rev_markers_script\Rev_marker_settings.sqf'";};
class Reeveli_Rectricted_Zeus {init = " call compile preprocessFileLineNumbers 'scripts\Reeveli_fnc\Rev_restricted_zeus\Rev_RZ_settings.sqf'";};
class Rev_tp_settings {init = "call compile preprocessFileLineNumbers 'scripts\Reeveli_fnc\Rev_teleport\Rev_tp_settings.sqf'";};



//Vcom
VCM_CBASettings = call compile preprocessFileLineNumbers "Vcom\Functions\VCM_Functions\fn_CBASettings.sqf";	//Vcom