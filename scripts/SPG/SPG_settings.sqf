/*
SPG settings
1.5.1_SPG
		Fixed wrong tooltip on MWD option
    Curator list option was removed by accident at some point, re-enabled
1.5_SPG
  Added missing setting for MWD
  Added setting for pinglist
  Corrected wrong tooltip for "Rev_offroad_speed" slider setting
1.4
  Player reset rating option removed as unnecessary
1.3
  Added vehicle offroad control settings
1.2
  Al_flash_time is no longer parsenumber'ed here but in functions that use the value instead
1.1
  Chat and marker commands ported from Default SPG scripts
V.0.1
	Initial test run
*/
#define CBA_SETTINGS_SPG "SPG Settings"


////////////////Enhanced flashbang////////////////
//Ammo class
[
  "Al_flash_classes"
  ,"EDITBOX"
  ,["Flashbang class","Write in weapon classnames with commas separating them, NO WHITESPACES! If left empty function is disabled."]
  ,[CBA_SETTINGS_SPG,"Enhanced flashbang"]
  ,"ACE_G_M84"
  ,1
  ,{
    Al_flash_classes = Al_flash_classes splitString ",";
    Al_flash_classes_whitelist = [];
    {Al_flash_classes_whitelist pushBackUnique toUpper (_x)} forEach Al_flash_classes;
  }
  ,true
] call CBA_fnc_addSetting;


////////////////Misc settings////////////////
//Tag Enforcement
[
  "Enforce_SPG_tag"
  ,"CHECKBOX"
  ,["Enforce SPG-tag requirement"]
  ,[CBA_SETTINGS_SPG,"Miscellaneous"]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;
//Post processing
[
  "KLT_enviro"
  ,"LIST"
  ,["Select post-processing effect"]
  ,[CBA_SETTINGS_SPG,"Miscellaneous"]
  ,[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], ["Disabled","Realistic color correction","Post apocalyptic","Nightstalkers","OFP gamma","Golden autumn","Africa","Afghanistan","Middle East","Real is brown","Gray tone","Cold tone","Winter blue","Winter white","Mediterranean Theme"], 0]
  ,1
  ,{[KLT_enviro] call KLT_fnc_enviro;}
  ,false
] call CBA_fnc_addSetting;
//Foliage removal
[
  "Rev_foliage_removal"
  ,"CHECKBOX"
  ,["Enable foliage removal self-interaction"]
  ,[CBA_SETTINGS_SPG,"Miscellaneous"]
  ,true
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;
//Pinglist
[
  "Rev_ping_list_enable"
  ,"CHECKBOX"
  ,["Enable player pinglist for curators"]
  ,[CBA_SETTINGS_SPG,"Miscellaneous"]
  ,true
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;




////////////////Player face settings////////////////
//Player faces
[
  "Rev_camofaces"
  ,"LIST"
  ,["Select player face type"]
  ,[CBA_SETTINGS_SPG,"Player faces"]
  ,[[0,1,2,3,4,5,6,7,8,9,10,11,12], ["Disabled","Caucasian","Caucasian with camopaint","Persian","Persian with camopaint","Asian","Asian with camopaint","African","African with camopaint","Greek","Greek with camopaint","Tanoan", "BF Caucasian Young"], 0]
  ,1
  ,{[Rev_camofaces] call Rev_fnc_camofaces;}
  ,false
] call CBA_fnc_addSetting;


////////////////Vehicle offroad control////////////////
//Master control
[
  "Rev_offroad_enable"
  ,"CHECKBOX"
  ,["Enable offroad speed restrictions for player vehicles"]
  ,[CBA_SETTINGS_SPG,"Vehicle control"]
  ,false
  ,1
  ,{[] call Rev_fnc_vehicles_offRoad_init}
  ,false
] call CBA_fnc_addSetting;

//Speed limit
[
  "Rev_offroad_speed"
  ,"SLIDER"
  ,["Max offroad speed","Set maximum allowed kph speed for affected vehicles"]
  ,[CBA_SETTINGS_SPG,"Vehicle control"]
  ,[5, 50, 10, 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;


////////////////MWD////////////////
//Master control
[
  "Enable_MWD"
  ,"CHECKBOX"
  ,["Enable usage of the military working dog"]
  ,[CBA_SETTINGS_SPG,"Military working dog"]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;

////////////////Curator settings////////////////
//Allow curator access to specific players
[
  "KLT_allowed_curators"
  ,"EDITBOX"
  ,["Players who are allowed to acces admin panel","Steam UIDs of allowed curator players. Write in UIDs with commas separating them, NO WHITESPACES!"]
  ,[CBA_SETTINGS_SPG,"Admin Panel"]
  ,"76561197982906568,76561197993413919"
  ,1
  ,{
    KLT_allowed_curators = KLT_allowed_curators splitString ",";
  }
  ,true
] call CBA_fnc_addSetting;