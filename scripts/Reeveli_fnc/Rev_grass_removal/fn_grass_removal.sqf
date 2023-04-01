
/*
 * Author: Reeveli
 * Client side function to add ace action to enable players to cut grass while prone. Called as postinit.
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * call Rev_fnc_grass_removal
 *
 */

if !(hasInterface) exitWith {};

private _grass_action =
["Grass_removal", "Remove foliage", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_deploy_prone_ca.paa",
{private _object = createVehicle ['Land_ClutterCutter_large_F', position _player, [], 0, 'CAN_COLLIDE'];}, {(vehicle _player == _player) && isTouchingGround _player && Rev_foliage_removal && (stance player == "PRONE")}] call ace_interact_menu_fnc_createAction;
["Man", 1, ["ACE_SelfActions"], _grass_action,true] call ace_interact_menu_fnc_addActionToClass;
