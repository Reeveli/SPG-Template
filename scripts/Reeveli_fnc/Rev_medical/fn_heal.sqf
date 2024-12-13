/*
 * Author: Reeveli
 * Client side function to fully heal a player with GUI indication and custom sound. 
 *
 * Arguments:
 * 0: Unit being healed <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_unit] remoteExecCall ["Rev_fnc_heal",_unit]
 *
2.0
	Function rewitten to be fully client side
 1.1.1
	Adjusted blood pressure check values
 1.1
	Added default param, safety exit
 */


if !(hasInterface) exitWith {};

//ZEN healing accounts for vanilla, ACE and advanced medicals
[player] call zen_common_fnc_healUnit;
//Graphic and sound effects
playSound "Rev_heal";
["scripts\Reeveli_fnc\Rev_medical\heal.paa", [1.3,-0.23,0.4,0.5],[10,10],2] spawn BIS_fnc_textTiles;
[true, 45] call ace_medical_feedback_fnc_effectPain;