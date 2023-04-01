
/*********************************************************************************
* Description: 
* Creates two modules for the MWD script if the Achilles mod is used. 
* Module 1: Make a player a doghandler.
* Module 2: Make a unit group tracked.
* The script should be run from init so that the functions exists on both server and client.
*
* Locality: 
* Global 
*
* Parameters: 
*
* https://zen-mod.github.io/ZEN/#/ 
*
* Author: Beck  
**********************************************************************************/ 

//Checks if ZEN mod is running. if not don't create the functions or modules.
if (!(isnil "zen_custom_modules_fnc_register")) then {

	["MWD", "Make Dog Handler", {[_this select 1] call MWD_SetHandler}] call zen_custom_modules_fnc_register;
	["MWD", "Track Group", {[_this select 1] call MWD_TrackedModule}] call zen_custom_modules_fnc_register;

	//Checks if unit is player, then make the player a doghandler.
	MWD_SetHandler = {
		params ["_unit"];
		
		if (isplayer _unit) then {						
			[] remoteexec ["MWD_MakeHandler", _unit];
			[format ["%1 is now a doghandler", _unit]] call zen_common_fnc_showMessage;
		}
		else {
			["No Player was selected!"] call zen_common_fnc_showMessage;
		};
	};

	//Make the unit a doghandler. This is called only on selected player client.
	MWD_MakeHandler = {		

		systemChat "Setting MWD handler role. Use ACE menu to spawn dog.";
		player setVariable ["MWD_Handler", true];					
		// Add ACE menus
		call MWD_fnc_addACEMenu;
		// Add player event handlers
		call MWD_fnc_addPlayerEventHandlers;	
	};

	//Checks if a unit is a unit, then sets variable to make it "tracked". Also sets the variable according to the multiplayer enviroment, Local or dedicated. 
	MWD_TrackedModule = {
		params ["_unit"];

		if (!isnull _unit) then {						
			[_unit] remoteexec ["MWD_MakeTracked", 2];
			[format ["Group %1 is now tracked", group _unit]] call zen_common_fnc_showMessage;
		} else {
			["No unit was selected!"] call zen_common_fnc_showMessage;
		};
	};

	//Runs only on server. sets variable.
	MWD_MakeTracked = {
		params ["_unit"];
		(group _unit) setVariable ["MWD_Tracked", true, true];
		systemChat format ["Tracking group '%1'", (group _unit)];
	};

};