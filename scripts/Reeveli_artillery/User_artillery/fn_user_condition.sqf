/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to check if player is allowed to use artillery.
 *
 * Arguments: NONE
 *
 * Return Value: <BOOL>
 *
 * Example:
 * call Rev_arty_fnc_user_condition
 *
 1.2
	Added condition to check if any dialog is open
 1.1
	Added condition for surrendering
	Added condition for escorting prisoners
 */

if !(hasInterface) exitWith {false};
if (player getVariable ["ace_captives_isSurrendering",false]) exitWith {false};
if (player getVariable ["ace_captives_isHandcuffed",false]) exitWith {false};
if (player getVariable ["ace_captives_isEscorting",false]) exitWith {false};
if (dialog) exitWith {false};

fnc_item_check = {
	if ({(toUpper _x) in Rev_arty_items_whitelist} count (vestItems player + uniformItems player + backpackItems player + assignedItems player + [backpack player] + [uniform player] + [vest player]) >= 1)
	then {true;} else {false};
};

fnc_role_check = {
	if (toUpper typeOf player in Rev_arty_classes_whitelist) then {true} else {false};
};



	
if !(Rev_arty_master_enable) exitwith {false};

if (count Rev_arty_classes_whitelist > 0 && count Rev_arty_items_whitelist > 0) exitwith {
	if (call fnc_role_check && call fnc_item_check) then {true} else {false};
};

if (count Rev_arty_classes_whitelist > 0 && count Rev_arty_items_whitelist == 0) exitwith {
	call fnc_role_check
};

if (count Rev_arty_classes_whitelist == 0 && count Rev_arty_items_whitelist > 0) exitwith {
	call fnc_item_check
};

if (count Rev_arty_classes_whitelist == 0 && count Rev_arty_items_whitelist == 0) exitwith {
	true;
};
