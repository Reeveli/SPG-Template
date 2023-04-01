/**
* Adds military working dog (MWD) and related features to the game.
* An MWD handler role can spawn a dog that is able to follow tracks laid by tracked groups.
* The dog can also be used to patrol an area to mark smell- and hearing observations (to be implemented).
*
* See Readme.txt for setup and usage of this script.
*
* @author Beck [ASE] - (Discord: Beck#1679)
* @co-author Killet [SPG] - (Discord: Killet#5653) - Specific features, testing, gfx, code review and bug finding/fixing
*/
if !(Enable_MWD) exitWith {}; //Startup function from SPG CBA Settings
//
// MWD Global Settings
// 
MWD_Debug = false;				// print MWD_Debug info or not
MWD_Automark = true;      		// automagically mark track detection arrows on handlers local map
MWD_TrackCheckInterval = 3;	    // server position check interval for tracked groups
MWD_TriggerDistance = 50;    	// rough distance between trigger positions i.e. distance between two saved group positions
MWD_TrackWidth = 3;	      	    // track width in meters
MWD_Respawn = 300;              // time until the dog allowed to respawn again (if it has been killed), set on player object

// Compile all functions 
#include "compile.sqf";

// Add Dog Handler ACE menu
call MWD_fnc_addACEMenu;
// Add player event handlers
call MWD_fnc_addPlayerEventHandlers;
// Add ZEN modules for Zeus
call MWD_fnc_ZeusModule;

// Call on server only, server is in charge of handling tracking triggers etc.
if (isServer) then {
	call MWD_fnc_trackGroups;
};