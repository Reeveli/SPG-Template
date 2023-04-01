/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Client side function to create the briefing tab to launch the mod menu. Run as a postinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_markers2_fnc_diary
 *
 */

if !(hasInterface) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "Rev_marker_system")) exitWith {diag_log "Rev_marker_system: Mod present, briefing from script version not launched"};

player createDiarySubject ["Rev_markers","User Marker System"];
player createDiaryRecord ["Rev_markers", ["User Marker System", 
"
<execute expression='call Rev_markers2_fnc_menu_start;'>Open makers menu.</execute>
"
]];

missionNamespace setVariable ["Rev_markers_counter", 0]; 