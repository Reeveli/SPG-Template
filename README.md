# SPG Default Scripts

By Killet & Reeveli. Default scripts for SPG Arma 3 missions. Drag and drop all included files into your mission folder.

## Major Systems

 - Reeveli's User Marker System: **Do NOT** use the standalone Workshop version in addition to these default scripts! See [mod documentation](https://docs.google.com/document/d/1v2NwtL5S1k7O54kIimPlOhjQqLtxF0DVTB81fbSFIBk) for instructions
 - Reeveli's User Artillery System: See the [SPG artillery manual](https://docs.google.com/document/d/1BdlAftkMrQUzYFo9iGOmSjMFkSRXW_wHvGLC8H2S5rc) for instructions
 - Reeveli's Resticted Zeus framework: Experimental feature. No documentation as of yet, ask Reeveli for details if you are interested
 - [Reeveli's Advamced Gestures](https://steamcommunity.com/sharedfiles/filedetails/?id=2809634827): **Do NOT** use the standalone Workshop version in addition to these default scripts!

## SPG Addon Settings

 - Enhanced flashbang: Define which (or any) cladd of grenades will act as enhanced flashbangs.
 
 	- Flashbangs are now omidirectional
	-	Custom effects for players
	-	Grenades will stun AIs for 5 seconds
	-	AI's will surrender after flashbang if a player standing right next to them AND can see them (no walls ot other obstructions between them)
	
 - Enforce SPG tag: Enable/disable SPG unit tag enforcement
 - Post processing: Select color theme
 - Enable foliage removal self-interaction. If enabled ACE self-intercation is available for players when prone
 - Enable player pinglist for curators. If enabled curators have a list where they can see the latest three player curators pings. Clicking on en entry will move curator camera to the selected player position
 - Player face type: Select what fenotype player avatars take. No more European avatars when playing CSAT! Additional option to force remove player face wear items
 - Enable offroad speed restrictions for player vehicles. Additional option to set max speed. Non-offroad capably vehicles (mostly wheeled) will suffer speed penalty when not driving on a road
 - Enable usage of the military working dog. See additional readme file in \scripts\MWD\ folder
 - Admin Panel: List players by Steam UID to have automatic access to curator during mission. Logged in admin is always allowed

## General Features

 - Players will now get automatic earplugs when leaving the arsenal if they have none
 - Players will no longer lose TFAR radios when exiting arsenal
 - If players use the custom "save loadout" option at arsenal loadout will be restored on respawn
 
 
## Curator Features

 - Custom keybind to toggle curator camera hearing: Only useful if not playing as virtual curator. Set keybind in Toggle curator camera hearing keybind options
 
 - Pinglist: Enbaled from SPG addon settings
 
## Curator Modules
Zeus Enhanced -mod is required
 - Add HALO jump terminal: Set an object to act as terminal for players to perform Liberation style HALO jumps. Can be also started locally on a player by `["insert_plane_class"] Rev_fnc_halo_start function`
 
 - Killet´s dust storm: You can now enable a small or a global sandstorm
 - Icon viewer: In-game browser for .paa files. Good for finding icons for scripts etc.
 
 - Reeveli's fire support
	 - Available on position, access to all Zeus fire support features (missiles, artillery, airstrike)
	 - Option to add TRPs that hook into player artillery system
 
 - Order a supply drop (curator version of user artillery system supply drop with a full arsenal)
 - Injure unit: Available for units, found under "heal". Recreates the old Achilles functionality where you can set specific injuries on body parts
 - AI surrender squad: Make the whole squad surrender
 - End mission: End mission, custom endings from `\scripts\KLT\Endings\Endings.hpp` supported
 - Blackout: Create power blackout around and area, partial restoration of power possible afterward
 - Promote/remove spectator: Available for players
 - ZEN showcase modules: Showcase modules for all ZEN dynamic dialog options, are only visible when in editor preview (so not during actual missions)
 - Change post processing effects for all players (effect as found in SPG addon options)
 - Reeveli's Rectricted Zeus: Promote player to RZ. Part of the experimental RZ system. Do not use unless you know what you are doing


## Curator Context Actions
Zeus Enhanced -mod is required

 - Improved group surrender: Found under "captives". Unlike the vanilla ZEN or ACE actions this also surrender units inside vehicles
 
 - Injure unit: Available for units, found under "heal". Recreates the old Achilles functionality where you can set specific injuries on body parts
 - Promote/remove spectator: Available for players
 - Suppress squads: Available for groups and units, duration 20s
 - Reeveli's fire support
	 - Available on position, access to all Zeus fire support features (missiles, artillery, airstrike)
	 - Option to add TRPs that hook into player artillery system
 - Legacy suppressive fire: Port of old Achilles suppressive fire system. Before using this place a virtual target from Zeus modules (Fire support >> Create Target)
 - New suppressive fire system. Context menu from a unit, drag and left click on position to engage. See the [comparison video](https://youtu.be/JEYg0frZupA) for full demonstration.

## Included Other Scripts & Functions

 - SPG admin menu: Available in ESC menu during game. Shows current fps, mission run time and button to enable curator if player is whitelisted (in SPG options) or logged in curator
 - Killet's Data terminal
 - Killet's Forceflashlight
 - Killet's Intel
 - Killet's Subtitle: This will look alike subtitle from Apex. To run: `["Killet","I am awesome",1]] spawn KLTSUB_fnc_showSubtitle_EXP;`
 - Killet´s Save respawn loadout system: Add `[this] call KLT_A_fnc_KLTSaveLoadout;` to the init field of an object to be able to save your respawn loadout from it
 - VCOM: Can be enabled and tweaked in VCOM addon settings
 - Icon viewer function: Can be run from editor. Good for finding icons for scripts etc. `[] call Rev_fnc_icon_viewer`
 - Area heal function: `[_target] call Rev_fnc_heal_area`
 - Disable vehicle info panels: If you aim to disable vanilla GPS panel make sure to disable it both for the players themselves (individually) and to each vehicle. `[vehicle player,false,["MinimapDisplayComponent"]] call Rev_fnc_info_panel;`



## License
Scripts and files included are only to be used in SPG's Arma 3 missions, please do not distribute this package or parts of it around the internet without our permission. Feel free to ask from Reeveli and Killet about usage of any scripts/functions, we are always happy to help fellow coders.
