//Executed locally when player joins mission (includes both mission start and JIP). 				  //
params ["_player", "_didJIP"];																		  //
//player: Object	didJIP: Boolean																	  //							
////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "scripts\KLT\Killets_modules.hpp";  							//Killet's Custom Zeus modules

_player setVariable ["SPGSaved_Loadout",getUnitLoadout _player];

//Add earplugs to inventory if player has none
if !("ACE_EarPlugs" in (vestItems _player + uniformItems _player + backpackItems _player) OR ([ace_player] call ace_hearing_fnc_hasEarPlugsIn) OR ((vehicle _player) isKindOf "VirtualCurator_F")) then {
	if (_player canAdd "ACE_EarPlugs") then { 
	_player addItem "ACE_EarPlugs";
	hint "Earplugs added to inventory"} else {hint "No room for earplugs in inventory!"}
};


