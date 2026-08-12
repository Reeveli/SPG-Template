/*
 * Author: Reeveli 
 * Part of Reeveli's ACE unconscious moaning.
 * File containing CBA addon option settings for ACE moaning.
 
 1.1
  Added settings for side specific languages
 */

[
  "Rev_moaning_enable"
  ,"CHECKBOX"
  ,["Enable Mod","Master to select if the mod is active or not, mission restart needed for effect"]
  ,"Reeveli's ACE Moaning"
  ,true
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;


[
  "Rev_moaning_speech_WEST"
  ,"LIST"
  ,["BLUFOR medic callouts","If enabled selected language medic callouts are added to the random sound pool"]
  ,"Reeveli's ACE Moaning"
  ,[["none","english","greek","farsi","french","chinese","russian","polish"], ["None","American English","Greek English","Farsi","French","Chinese","Russian","Polish"], 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_moaning_speech_EAST"
  ,"LIST"
  ,["REDFOR medic callouts","If enabled selected language medic callouts are added to the random sound pool"]
  ,"Reeveli's ACE Moaning"
  ,[["none","english","greek","farsi","french","chinese","russian","polish"], ["None","American English","Greek English","Farsi","French","Chinese","Russian","Polish"], 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_moaning_speech_IND"
  ,"LIST"
  ,["INDFOR medic callouts","If enabled selected language medic callouts are added to the random sound pool"]
  ,"Reeveli's ACE Moaning"
  ,[["none","english","greek","farsi","french","chinese","russian","polish"], ["None","American English","Greek English","Farsi","French","Chinese","Russian","Polish"], 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_moaning_speech_CIV"
  ,"LIST"
  ,["Civilian medic callouts","If enabled selected language medic callouts are added to the random sound pool"]
  ,"Reeveli's ACE Moaning"
  ,[["none","english","greek","farsi","french","chinese","russian","polish"], ["None","American English","Greek English","Farsi","French","Chinese","Russian","Polish"], 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_moaning_range"
  ,"SLIDER"
  ,["Sound range","Sound max range as set by playSound3D distance"]
  ,"Reeveli's ACE Moaning"
  ,[1, 100, 50, 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_moaning_time"
  ,"SLIDER"
  ,["Sound interval","How often in secods is a check made for sound"]
  ,"Reeveli's ACE Moaning"
  ,[1, 600, 10, 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_moaning_probability"
  ,"SLIDER"
  ,["Sound probability","Upon every check what is the probability for a sound"]
  ,"Reeveli's ACE Moaning"
  ,[1, 100, 50, 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;