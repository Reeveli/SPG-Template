/*
 * Author: Reeveli
 * Part of Reeveli's teleport system.
 * Preinit function to set up CBA settings for teleportation system.
 * Called from description.ext'
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 */


#define REV_TP_SETTINGS "Reeveli's teleportation system"

//Action radius
[
  "Rev_tp_action_radius"
  ,"SLIDER"
  ,["Action visibility radius","What is the radius (in meters) around a teleportation object the action should be shown"]
  ,REV_TP_SETTINGS
  ,[5, 30, 5, 0]
  ,1
  ,{}
  ,true
] call CBA_fnc_addSetting;

//Action time
[
  "Rev_tp_action_time"
  ,"SLIDER"
  ,["Teleportation time","How long does the teleportation (and accompanying effect) last in seconds"]
  ,REV_TP_SETTINGS
  ,[1, 120, 6, 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;