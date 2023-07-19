/*
 * Author: Reeveli
 * Adds eventhandler to fix TFAR radios disppearing when leaving arsenal. Earplug autocheck also included. Called from SPG CBA settings.
 * Know issues: If you switch your Sw radio and immediately exith the arsenal the game isn't fast enough to register the change you you will still have the radio you had before the change.
 *
 * Arguments:
 * 0: Enable <BOOL>
 *
 * Return Value: <BOOL>
 *
 * Example:
 * [true] call Rev_fnc_radio_arsenal;
 *
 1.2
 	Save radio settings event modified to deconflict with new standalone function
	Restore Sw settings event removed to deconflict with new standalone function
 1.1
	Added additional safety exit if TFAR is not loaded
 */



params ["_enable_fix"];

if !(_enable_fix) exitWith {false};
if ((isMultiplayer) AND !(isClass (configFile >> "CfgPatches" >> "tfar_handhelds"))) exitWith {false};

//EHs for radio retention at arsenal
private _radio = missionNamespace setVariable ["MyRadio", ""];

//Save radio
["ace_arsenal_displayOpened", {	
	missionNamespace setVariable ["MyRadio", (call TFAR_fnc_activeSwRadio)];
}] call CBA_fnc_addEventHandler;

//Earplugs + Sw radio
["ace_arsenal_displayClosed", {
	
	//Add earplugs to inventory if player has none
	if !("ACE_EarPlugs" in (vestItems player + uniformItems player + backpackItems player) OR ([ace_player] call ace_hearing_fnc_hasEarPlugsIn)) then {
		if (player canAdd "ACE_EarPlugs") then { 
		player addItem "ACE_EarPlugs";
		hint "Earplugs added to inventory"} else {hint "No room for earplugs in inventory!"}
	};

	//Sw radio retention
	private _pocket_radio = missionNamespace getVariable "MyRadio";
	private _condition = {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0};
	if (_condition count assignedItems player == 0) then {
		player linkItem _pocket_radio;};
}] call CBA_fnc_addEventHandler;


true;