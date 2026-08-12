/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system.
 * Client side function to set up CBA options. Run on each client. Called as extended preinit eventhandler.
 *
 * Return Value: NONE
 1.3
  Bunch of edit boxes changed to sliders to force correct data type, eliminating need for safety checks
 1.2
  Cluster missile setting re-rolled into cluster artillery
 1.1
  Added setting for max distance from TRP
 */


#define CBA_SETTINGS_REV_ARTY "Reeveli's Artillery System"

/////////////////////////////General settings
[
  "Rev_arty_master_enable"
  ,"CHECKBOX"
  ,["Enable Reeveli's artillery script","Enable/disable the script"]
  ,CBA_SETTINGS_REV_ARTY
  ,false
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_classes"
  ,"EDITBOX"
  ,["Add unit classes as forward observers","Use this to add classnames that can call in artillery. Write in classnames with commas separating them, without quotes (see default value), NO WHITESPACES!"]
  ,CBA_SETTINGS_REV_ARTY
  ,""
  ,1
  ,{
    Rev_arty_classes = Rev_arty_classes splitString ",";
    Rev_arty_classes_whitelist = [];
    {Rev_arty_classes_whitelist pushBackUnique toUpper (_x)} forEach Rev_arty_classes;
  }
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_items"
  ,"EDITBOX"
  ,["Add item classes required for forward observers","Use this to add items that are required to call in artillery. Write in classnames with commas separating them, without quotes (see default value), NO WHITESPACES!"]
  ,CBA_SETTINGS_REV_ARTY
  ,"ACE_maptools"
  ,1
  ,{
    Rev_arty_items = Rev_arty_items splitString ",";
    Rev_arty_items_whitelist = [];
    {Rev_arty_items_whitelist pushBackUnique toUpper (_x)} forEach Rev_arty_items;
  }
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_protocol"
  ,"LIST"
  ,["Radio Language","Select language for the radio dialogs"]
  ,CBA_SETTINGS_REV_ARTY
  ,[[0,1,2,3,4,5,6], ["American English","Greek English","Farsi","French","Chinese","Russian","Polish"], 0]
  ,1
] call CBA_fnc_addSetting;
//Safety distances
[
  "Rev_arty_safety_dis"
  ,"SLIDER"
  ,["Maximum range","What is the max range from observer artillery can be called from"]
  ,CBA_SETTINGS_REV_ARTY
  ,[0, 10000,1500,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_trp_dis"
  ,"SLIDER"
  ,["Maximum range from TRP","What is the max range from TRP artillery can be called from"]
  ,CBA_SETTINGS_REV_ARTY
  ,[0, 10000,300,0,false]
  ,1
] call CBA_fnc_addSetting;


/////////////////////////////Ammo settings
//HE
[
  "Rev_arty_HE_enabled"
  ,"CHECKBOX"
  ,["Allow HE rounds","Allow/prevent players to call in HE rounds"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - HE"]
  ,true
  ,1
] call CBA_fnc_addSetting;
[
  "Rev_arty_HE_type"
  ,"LIST"
  ,["Select artillery type"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - HE"]
  ,[["Sh_155mm_AMOS","Sh_82mm_AMOS"], ["155mm Howitzer","82mm Mortar"], 0]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_HE_amount_sys"
  ,"SLIDER"
  ,["Maximum HE ordnance amount","This is the size of the ammunition pool for HE"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - HE"]
  ,[0,300,12,0,false]
  ,1
  ,{Rev_arty_HE_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_HE_regen"
  ,"SLIDER"
  ,["HE regeneration speed","How fast (in secods) will a new round of HE regenerate into the ammo pool. 0 to disable ammo regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - HE"]
  ,[0,3600,60,0,false]
  ,1
] call CBA_fnc_addSetting;


[
  "Rev_arty_HE_crater"
  ,"CHECKBOX"
  ,["Enable craters on HE rounds","Allow player called artillery to make permanent craters on the map"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - HE"]
  ,false
  ,1
] call CBA_fnc_addSetting;

//Cluster shells
[
  "Rev_arty_CLU_enable"
  ,"CHECKBOX"
  ,["Allow cluster rounds","Allow/prevent players to call in cluster artillery strikes"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Cluster"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_CLU_amount_sys"
  ,"SLIDER"
  ,["Maximum cluster amount","This is the size of the ammunition pool for clusters"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Cluster"]
  ,[0,300,12,0,false]
  ,1
  ,{Rev_arty_CLU_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_CLU_regen"
  ,"SLIDER"
  ,["Cluster regeneration speed","How fast (in secods) will a new cluster round regenerate into the ammo pool. 0 to disable cluster regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Cluster"]
  ,[0,3600,60,0,false]
  ,1
] call CBA_fnc_addSetting;

//Smoke
[
  "Rev_arty_SMK_enable"
  ,"CHECKBOX"
  ,["Allow smoke rounds","Allow/prevent players to call in smoke rounds"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Smoke"]
  ,true
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_SMK_amount_sys"
  ,"SLIDER"
  ,["Maximum smoke ordnance amount","This is the size of the ammunition pool for smoke"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Smoke"]
  ,[0,300,20,0,false]
  ,1
  ,{Rev_arty_SMK_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_SMK_regen"
  ,"SLIDER"
  ,["Smoke regeneration speed","How fast (in secods) will a new round of smoke regenerate into the ammo pool. 0 to disable smoke regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Smoke"]
  ,[0,3600,60,0,false]
  ,1
] call CBA_fnc_addSetting;

//Flares
[
  "Rev_arty_ILM_enable"
  ,"CHECKBOX"
  ,["Allow illumination rounds","Allow/prevent players to call in illumination rounds"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Illumination"]
  ,true
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_ILM_amount_sys"
  ,"SLIDER"
  ,["Maximum illumination ordnance amount","This is the size of the ammunition pool for flares"]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Illumination"]
  ,[0,300,20,0,false]
  ,1
  ,{Rev_arty_ILM_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_ILM_regen"
  ,"SLIDER"
  ,["Illumination regeneration speed","How fast (in secods) will a new round of illumination regenerate into the ammo pool. 0 to disable flare regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Artillery - Illumination"]
  ,[0,3600,60,0,false]
  ,1
] call CBA_fnc_addSetting;






//Tactical missiles
[
  "Rev_arty_MIS_enable"
  ,"CHECKBOX"
  ,["Allow tactical missiles","Allow/prevent players to call in missile strikes"]
  ,[CBA_SETTINGS_REV_ARTY,"Support- Missile"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_MIS_amount_sys"
  ,"SLIDER"
  ,["Maximum missile amount","This is the size of the ammunition pool for missiles"]
  ,[CBA_SETTINGS_REV_ARTY,"Support- Missile"]
  ,[0,30,2,0,false]
  ,1
  ,{Rev_arty_MIS_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_MIS_regen"
  ,"SLIDER"
  ,["Missile regeneration speed","How fast (in secods) will a new missile be regenerate into the ammo pool. 0 to disable missile regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Support- Missile"]
  ,[0,3600,0,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_alias_enabled"
  ,"CHECKBOX"
  ,["Enable alternative missiles","Enable more powerful missiles with custom effects. Will also change the crater if enabled."]
  ,[CBA_SETTINGS_REV_ARTY,"Support- Missile"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_missiles_crater"
  ,"CHECKBOX"
  ,["Enable craters on user missiles","Allow player called missiles to make permanent craters on the map. Clusters will never create craters."]
  ,[CBA_SETTINGS_REV_ARTY,"Support- Missile"]
  ,false
  ,1
] call CBA_fnc_addSetting;








//Air support
[
  "Rev_arty_AIR_enable"
  ,"CHECKBOX"
  ,["Allow air support","Allow/prevent players to call in air strikes"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - CAS"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_AIR_amount_sys"
  ,"SLIDER"
  ,["Maximum air support amount","This is the amount of availbale air strikes"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - CAS"]
  ,[0,30,2,0,false]
  ,1
  ,{Rev_arty_AIR_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_AIR_regen"
  ,"SLIDER"
  ,["Air support regeneration speed","How fast (in secods) will a new air strike be available. 0 to disable regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - CAS"]
  ,[0,3600,0,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_AIR_duration"
  ,"SLIDER"
  ,["Air support duration","How long does the player have to pilot the plane"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - CAS"]
  ,[0,1800,180,0,false]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_AIR_class"
  ,"EDITBOX"
  ,["Plane classes","Write in classnames with commas separating them, without quotes (see default value), NO WHITESPACES!"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - CAS"]
  ,"B_Plane_Fighter_01_F"
  ,1
  ,{Rev_arty_AIR_class = Rev_arty_AIR_class splitString ","}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_AIR_penalty"
  ,"SLIDER"
  ,["Penalty for plane shot down","How much extra time does losing a plane add to the current cooldown"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - CAS"]
  ,[0,1800,300,0,false]
  ,1
] call CBA_fnc_addSetting;








//Resupply
[
  "Rev_arty_SUP_enable"
  ,"CHECKBOX"
  ,["Allow aerial resupply","Allow/prevent players to call in resupply drops"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Resupply"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_SUP_amount_sys"
  ,"SLIDER"
  ,["Maximum resupply amount","This is the amount of availbale supply drops"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Resupply"]
  ,[0,30,2,0,false]
  ,1
  ,{Rev_arty_SUP_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_SUP_regen"
  ,"SLIDER"
  ,["Resupply regeneration speed","How fast (in secods) will a new supply drop be available. 0 to disable regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Resupply"]
  ,[0,3600,0,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_SUP_class"
  ,"EDITBOX"
  ,["Transport class","Write in transport classname without quotes (see default value)."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Resupply"]
  ,"B_Heli_Transport_03_unarmed_F"
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_SUP_class_box"
  ,"EDITBOX"
  ,["Container class","Write in container classname without quotes (see default value)."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Resupply"]
  ,"C_IDAP_supplyCrate_F"
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_SUP_list"
  ,"EDITBOX"
  ,["Item list","List allowed items in ACE arsenal format."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Resupply"]
  ,"[]"
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;








//Gunship
[
  "Rev_arty_GUN_enable"
  ,"CHECKBOX"
  ,["Allow gunship support","Allow/prevent players to call in gunship support."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Gunship"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_GUN_amount_sys"
  ,"SLIDER"
  ,["Maximum gunship amount","This is the amount of availbale gunship calls."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Gunship"]
  ,[0,30,2,0,false]
  ,1
  ,{Rev_arty_GUN_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_GUN_duration"
  ,"SLIDER"
  ,["Gunship support duration","How long does the player have to control the gunship"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Gunship"]
  ,[0,1800,180,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_GUN_regen"
  ,"SLIDER"
  ,["Gunship regeneration speed","How fast (in secods) will a new gunship be available. 0 to disable regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Gunship"]
  ,[0,3600,0,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_GUN_captive"
  ,"CHECKBOX"
  ,["Make gunship captive","Making the gunship captive will prevent AI's from shooting at it."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Gunship"]
  ,true
  ,1
] call CBA_fnc_addSetting;


//Area bombing
[
  "Rev_arty_BOM_enable"
  ,"CHECKBOX"
  ,["Allow area bombing","Allow/prevent players to call in area bombing"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Bombing"]
  ,false
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_BOM_amount_sys"
  ,"SLIDER"
  ,["Maximum area bombing amount","This is the amount of availbale bombing strikes"]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Bombing"]
  ,[0,30,2,0,false]
  ,1
  ,{Rev_arty_BOM_amount = _this}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_arty_BOM_regen"
  ,"SLIDER"
  ,["Area bombing regeneration speed","How fast (in secods) will a new air strike be available. 0 to disable regeneration."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Bombing"]
  ,[0,3600,0,0,false]
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_BOM_class"
  ,"EDITBOX"
  ,["Bomber class","Write in aircraft classname without quotes (see default value)."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Bombing"]
  ,"B_Plane_Fighter_01_F"
  ,1
] call CBA_fnc_addSetting;

[
  "Rev_arty_BOM_captive"
  ,"CHECKBOX"
  ,["Make aircraft captive","Making the aircraft captive will prevent AI's from shooting at it."]
  ,[CBA_SETTINGS_REV_ARTY,"Support - Bombing"]
  ,true
  ,1
] call CBA_fnc_addSetting;