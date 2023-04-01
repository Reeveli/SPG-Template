/*
 * Author: ACE3, Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to update the artillery dialog map night time effect layer. Based on ACE3 mod code.
 * Called from the map dialog control onDraw event.
 *
 * Arguments:
 * 0: Map control <CONTROL>
 *
 * Return Value: NONE
 *
 * Example:
 * [_control] call Rev_arty_fnc_dialog_light;
 *
*/

params [
	["_map",controlNull,[controlNull]]
];

//If daytime
if (((([player] call ACE_map_fnc_determineMapLight) select 1) select 3) <= 0.55) exitWith {};

//initial flashlight pos
private _mapScale = ctrlMapScale _map;
private _mapCentre = _map ctrlMapScreenToWorld [0.5,0.5];

//Setting the global variable determening flashlight beam pos
Ace_map_mousePos = _map ctrlMapScreenToWorld getMousePosition;


[_map, _mapScale, _mapCentre, [0.06,0.08,0.14,0.85]] call ace_map_fnc_simulateMapLight;
