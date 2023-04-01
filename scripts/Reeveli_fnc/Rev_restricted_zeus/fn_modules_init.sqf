/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Client side function that add RZ promotion ZEN curator module for a normal game master so that he can promote RZ. Is run as a postinit function on all players.
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * call Rev_RZ_fnc_module_init;
 *
 */


//ZEN modules
if (isClass (configFile >> "CfgPatches" >> "zen_custom_modules")) then
{	
	//RZ Promotion
	["Reeveli's Restricted Zeus", "Promote player to RZ", {
		params ["_pos","_unit"];
		if !(_unit in ([] call CBA_fnc_players)) exitWith {
			playSound "FD_Start_F";
			[objNull, "No player was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
		};
		[_unit] remoteExec ["Rev_RZ_fnc_init_player",(_unit)];
		[objNull, format ["%1 was promoted to RZ", name _unit]] call BIS_fnc_showCuratorFeedbackMessage;		
	},"\a3\ui_f_curator\Data\Logos\arma3_curator_eye_64_ca.paa"] call zen_custom_modules_fnc_register;
};