/*
 * Author: Diwako
 * Client side function to create eventhandler for ACE medical text for players.
 *
 * Arguments: <NONE>
 *
 * Return Value: <BOOL>
 *
 * Example:
 * [] call Rev_fnc_treatmentHints
 *
 */

if !(hasInterface) exitWith {false;};

{
    ["ace_medical_treatment_" + _x, {
        if (lifeState ace_player == "INCAPACITATED") then {
            titleText ["Someone is helping you", "PLAIN DOWN", 2, true, true];
        };
    }] call CBA_fnc_addEventHandler;
} foreach ["bandageLocal", "checkBloodPressureLocal", "cprLocal", "fullHealLocal", "ivBagLocal", "medicationLocal", "splintLocal", "tourniquetLocal"];

true;