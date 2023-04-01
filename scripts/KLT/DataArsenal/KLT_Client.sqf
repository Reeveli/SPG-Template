KLT_fnc_addDataEH = {

//Close down arsenal eventhandler
  		["ace_arsenal_displayClosed", {
		[ "Close", player ] remoteExec [ "KLT_fnc_useTerminal", 2 ];
		hint "Arsenal Closed"; //Debug
	    }] call CBA_fnc_addEventHandler;
};


//Action to open arsenal
[
	DataTerminal,																			// Object the action is attached to
	"Open Arsenal",																			// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",							// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",							// Progress icon shown on screen
	"_this distance _target < 3",															// Condition for the action to be shown
	"_caller distance _target < 3",															// Condition for the action to progress
	{hint "Opening Arsenal...";},															// Code executed when action starts
	{},																						// Code executed on every progress tick
	{ 
		[ "Open", player ] remoteExec [ "KLT_fnc_useTerminal", 2 ];
		[ player, player ] remoteExec [ "KLT_fnc_openarsenal", player ];
	 },																						// Code executed on completion
	{hint "You let go of the space key.";},													// Code executed on interrupted
	[],																						// Arguments passed to the scripts as _this select 3
	1,																						// Action duration [s]
	10,																						// Priority
	false,																					// Remove on completion
	false																					// Show in unconscious state 
] remoteExec ["BIS_fnc_holdActionAdd", player, DataTerminal];								// MP compatible implementation

[] call compile preprocessFile "scripts\KLT\DataArsenal\KLT_DataArsenal.sqf";