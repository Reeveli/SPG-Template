/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Creates CBA addon option settings for restricted zeus system. Called from description.ext
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 */

#define CBA_SETTINGS_RZ "Restricted Zeus Settings"


//Locality check when selecting units
[
  "Rev_RZ_locality"
  ,"CHECKBOX"
  ,["Enforce locality safety"]
  ,[CBA_SETTINGS_RZ]
  ,false
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;