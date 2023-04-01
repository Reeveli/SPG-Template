// Executed locally when player respawns in a multiplayer mission. This event script will also fire at the beginning of a mission if respawnOnStart is 0 or 1, oldUnit will be objNull in this instance. This script will not fire at mission start if respawnOnStart equals -1.
params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
//newUnit: Object oldUnit: Object respawn: String respawnDelay: Number

if ( isNil "SPGSaved_Loadout" ) then {
	removeAllWeapons player;
	removeAllItems player;
	removeAllAssignedItems player;
	removeVest player;
	clearAllItemsFromBackpack player;
	removeBackpack player;
	removeHeadgear player;
	removegoggles player;
	player setUnitLoadout(player getVariable["SPGSaved_Loadout",[]]);
	hintsilent "RespawnLoadout Loaded"
} else {
	hintsilent "StartingLoadout Loaded";
};

//Add earplugs to inventory if player has none
if !("ACE_EarPlugs" in (vestItems player + uniformItems player + backpackItems player) OR ([ace_player] call ace_hearing_fnc_hasEarPlugsIn)) then {
	if (player canAdd "ACE_EarPlugs") then { 
	player addItem "ACE_EarPlugs";
	hint "Earplugs added to inventory"} else {hint "No room for earplugs in inventory!"}
};