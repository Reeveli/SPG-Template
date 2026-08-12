/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Function to create the CBA addon options. Run as an extended preinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
2.0
  Settings rewritten to take advantage of 2.22 game update

 */


////////////////General settings////////////////
//Channel master
[
  "Rev_marker_CBA"
  ,"CHECKBOX"
  ,["Enable channel CBA options","If you are using other methods like server config or scripts to enable/disable chat channels leave this option turned off."]
  ,["Reeveli's User Marker System","Base settings"]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;
//Enable Briefing
[
  "Rev_marker_briefing"
  ,"CHECKBOX"
  ,["Only allow during briefing","When this option is enabled players will be able to place markers ONLY while the pre-mission map screen is open."]
  ,["Reeveli's User Marker System","Base settings"]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;


////////////////Channel options////////////////
//Global channel
[
  "Rev_marker_globalChat"
  ,"LIST"
  ,["Global chat","Global chat options (admin will always have access to global channel)"]
  ,["Reeveli's User Marker System","Global"]
  ,[[0,1,2,3], ["Only chat", "Only VoN","Chat + VoN","Disabled"], 0]
  ,1
  ,{[0,Rev_marker_globalChat,Rev_marker_globalMarkers] call Rev_markers2_fnc_channels}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_marker_globalMarkers"
  ,"LIST"
  ,["Global markers","Global markers options (admin will always have access to global channel)"]
  ,["Reeveli's User Marker System","Global"]
  ,[[0,1,2,3], ["Only markers", "Only drawings","Markers + drawings","Disabled"], 2]
  ,1
  ,{[0,Rev_marker_globalChat,Rev_marker_globalMarkers] call Rev_markers2_fnc_channels}
  ,false
] call CBA_fnc_addSetting;



//Side channel
[
  "Rev_marker_sideChat"
  ,"LIST"
  ,["Side chat","Side chat options"]
  ,["Reeveli's User Marker System","Side"]
  ,[[0,1,2,3], ["Only chat", "Only VoN","Chat + VoN","Disabled"], 0]
  ,1
  ,{[1,Rev_marker_sideChat,Rev_marker_sideMarkers] call Rev_markers2_fnc_channels}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_marker_sideMarkers"
  ,"LIST"
  ,["Side markers","Side marker options"]
  ,["Reeveli's User Marker System","Side"]
  ,[[0,1,2,3], ["Only markers", "Only drawings","Markers + drawings","Disabled"], 2]
  ,1
  ,{[1,Rev_marker_sideChat,Rev_marker_sideMarkers] call Rev_markers2_fnc_channels}
  ,false
] call CBA_fnc_addSetting;


//Command channel
[
  "Rev_marker_commandChat"
  ,"LIST"
  ,["Command chat","Command chat options"]
  ,["Reeveli's User Marker System","Command"]
  ,[[0,1,2,3], ["Only chat", "Only VoN","Chat + VoN","Disabled"], 0]
  ,1
  ,{[2,Rev_marker_commandChat,Rev_marker_commandMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;

[
  "Rev_marker_commandMarkers"
  ,"LIST"
  ,["Command markers","Command marker options"]
  ,["Reeveli's User Marker System","Command"]
  ,[[0,1,2,3], ["Only markers", "Only drawings","Markers + drawings","Disabled"], 2]
  ,1
  ,{[2,Rev_marker_commandChat,Rev_marker_commandMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;


//Group channel
[
  "Rev_marker_groupChat"
  ,"LIST"
  ,["Group chat","Group chat options"]
  ,["Reeveli's User Marker System","Group"]
  ,[[0,1,2,3], ["Only chat", "Only VoN","Chat + VoN","Disabled"], 0]
  ,1
  ,{[3,Rev_marker_groupChat,Rev_marker_groupMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;

[
  "Rev_marker_groupMarkers"
  ,"LIST"
  ,["Group markers","Group marker options"]
  ,["Reeveli's User Marker System","Group"]
  ,[[0,1,2,3], ["Only markers", "Only drawings","Markers + drawings","Disabled"], 2]
  ,1
  ,{[3,Rev_marker_groupChat,Rev_marker_groupMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;


//Vehicle channel
[
  "Rev_marker_vehicleChat"
  ,"LIST"
  ,["Vehicle chat","Vehicle chat options"]
  ,["Reeveli's User Marker System","Vehicle"]
  ,[[0,1,2,3], ["Only chat", "Only VoN","Chat + VoN","Disabled"], 0]
  ,1
  ,{[4,Rev_marker_vehicleChat,Rev_marker_vehicleMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;

[
  "Rev_marker_vehicleMarkers"
  ,"LIST"
  ,["Vehicle markers","Vehicle marker options"]
  ,["Reeveli's User Marker System","Vehicle"]
  ,[[0,1,2,3], ["Only markers", "Only drawings","Markers + drawings","Disabled"], 2]
  ,1
  ,{[4,Rev_marker_vehicleChat,Rev_marker_vehicleMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;


//Direct channel
[
  "Rev_marker_directChat"
  ,"LIST"
  ,["Direct chat","Direct chat options"]
  ,["Reeveli's User Marker System","Direct"]
  ,[[0,1,2,3], ["Only chat", "Only VoN","Chat + VoN","Disabled"], 0]
  ,1
  ,{[5,Rev_marker_directChat,Rev_marker_directMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;

[
  "Rev_marker_directMarkers"
  ,"LIST"
  ,["Direct markers","Direct marker options"]
  ,["Reeveli's User Marker System","Direct"]
  ,[[0,1,2,3], ["Only markers", "Only drawings","Markers + drawings","Disabled"], 2]
  ,1
  ,{[5,Rev_marker_directChat,Rev_marker_directMarkers] call Rev_markers2_fnc_channels}
  ,true
] call CBA_fnc_addSetting;