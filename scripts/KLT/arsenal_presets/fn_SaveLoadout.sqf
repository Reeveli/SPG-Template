//Attaches an action to the object to save your respawn loadout
// Parameters: object 
//example [this] call KLT_fnc_KLTSaveloadout;

params ["_arsenal"];

//This creates an action to your arsenal that gives you the ability to save your respawn loadout
RespawnSavingSystem_Active = True;
[
	_arsenal,											// Object the action is attached to
	"Save respawn loadout",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3",						// Condition for the action to be shown
	"_caller distance _target < 3",						// Condition for the action to progress
	{hint "Loadout is being saved, Standby";},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 
		player setVariable["SPGSaved_Loadout",getUnitLoadout player];
		hint "Respawn loadout saved"; 
	},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	1,													// Action duration [s]
	10,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
