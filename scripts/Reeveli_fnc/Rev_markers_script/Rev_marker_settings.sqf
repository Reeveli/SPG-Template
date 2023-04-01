/*
 * Author: Reeveli 
 * Part of Reeveli's User Marker System.
 * Function to create the CBA addon options. Run as an extended preinit function.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 */

////////////////General settings////////////////
//Enable Briefing
[
  "Rev_marker_briefing"
  ,"CHECKBOX"
  ,["Only allow during briefing","When this option is enabled players will be able to place markers ONLY while the pre-mission map screen is open."]
  ,["Reeveli's User Marker System","Briefing"]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;
//Channel master
[
  "Rev_marker_CBA"
  ,"CHECKBOX"
  ,["Enable channel CBA options","If you are using other methods like server config or scripts to enable/disable chat channels leave this option turned off."]
  ,["Reeveli's User Marker System","Briefing"]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;


////////////////Channel options////////////////
//Global channel
[
  "Rev_marker_global"
  ,"CHECKBOX"
  ,["Disable global channel","Prevent players from using global channel (admin will always have access to global channel)."]
  ,["Reeveli's User Marker System","Channels"]
  ,false
  ,1
  ,{if (Rev_marker_CBA) then {0 enableChannel [!Rev_marker_global, !Rev_marker_global];};}
  ,true
] call CBA_fnc_addSetting;
//Side channel
[
  "Rev_marker_side"
  ,"CHECKBOX"
  ,["Disable side channel","Prevent players from using side channel."]
  ,["Reeveli's User Marker System","Channels"]
  ,false
  ,1
  ,{if (Rev_marker_CBA) then {1 enableChannel [!Rev_marker_side, !Rev_marker_side];};}
  ,true
] call CBA_fnc_addSetting;
//Command channel
[
  "Rev_marker_command"
  ,"CHECKBOX"
  ,["Disable command channel","Prevent players from using command channel."]
  ,["Reeveli's User Marker System","Channels"]
  ,false
  ,1
  ,{if (Rev_marker_CBA) then {2 enableChannel [!Rev_marker_command, !Rev_marker_command];};}
  ,true
] call CBA_fnc_addSetting;
//Group channel
[
  "Rev_marker_group"
  ,"CHECKBOX"
  ,["Disable group channel","Prevent players from using group channel."]
  ,["Reeveli's User Marker System","Channels"]
  ,false
  ,1
  ,{if (Rev_marker_CBA) then {3 enableChannel [!Rev_marker_group, !Rev_marker_group];};}
  ,true
] call CBA_fnc_addSetting;
//Vehicle channel
[
  "Rev_marker_vehicle"
  ,"CHECKBOX"
  ,["Disable vehicle channel","Prevent players from using vehicle channel."]
  ,["Reeveli's User Marker System","Channels"]
  ,false
  ,1
  ,{if (Rev_marker_CBA) then {4 enableChannel [!Rev_marker_vehicle, !Rev_marker_vehicle];};}
  ,true
] call CBA_fnc_addSetting;
//Direct channel
[
  "Rev_markers_direct"
  ,"CHECKBOX"
  ,["Disable direct channel","Prevent players from using direct channel."]
  ,["Reeveli's User Marker System","Channels"]
  ,false
  ,1
  ,{if (Rev_marker_CBA) then {5 enableChannel [!Rev_markers_direct, !Rev_markers_direct];};}
  ,true
] call CBA_fnc_addSetting;
