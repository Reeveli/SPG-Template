/*
 * Author: Reeveli 
 * Part of Reeveli's Advanced Gestures system.
 * File containing CAB addon option settings for the advanced gestures.
 */


[
  "Rev_advanced_gestures_enable"
  ,"CHECKBOX"
  ,["Enable Reeveli's Advanced Gestures","Enable/disable the functionality"]
  ,"Reeveli's Advanced Gestures"
  ,true
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_advanced_gestures_color"
  ,"COLOR"
  ,["Notification color","Set color of notification texts"]
  ,"Reeveli's Advanced Gestures"
  ,[1,1,1,1]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_advanced_gestures_font"
  ,"LIST"
  ,["Notification font","Set font of notification texts"]
  ,"Reeveli's Advanced Gestures"
  ,[
	  ["Caveat","EtelkaMonospacePro","EtelkaMonospaceProBold","EtelkaNarrowMediumPro","LCD14","LucidaConsoleB","PuristaBold","PuristaLight","PuristaMedium","PuristaSemibold","RobotoCondensed","RobotoCondensedBold","RobotoCondensedLight","TahomaB"],
	  ["Caveat","EtelkaMonospacePro","EtelkaMonospaceProBold","EtelkaNarrowMediumPro","LCD14","LucidaConsoleB","PuristaBold","PuristaLight","PuristaMedium","PuristaSemibold","RobotoCondensed","RobotoCondensedBold","RobotoCondensedLight","TahomaB"],
	  10
	]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_advanced_gestures_size"
  ,"SLIDER"
  ,["Notification size","Set size of notification texts of your own gestures"]
  ,"Reeveli's Advanced Gestures"
  ,[0.00, 3.00, 1.00, 2]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_advanced_gestures_offset"
  ,"SLIDER"
  ,["3D notification offset","Offset of the 3d notification text above ground level"]
  ,"Reeveli's Advanced Gestures"
  ,[0, 3, 2.3, 1]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_advanced_gestures_size_3d"
  ,"SLIDER"
  ,["3D notification size","Set size of 3d notification texts"]
  ,"Reeveli's Advanced Gestures"
  ,[0.01, 0.10, 0.05, 2]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;

[
  "Rev_advanced_gestures_duration"
  ,"SLIDER"
  ,["Notification duration","How many seconds do gesture notofications last"]
  ,"Reeveli's Advanced Gestures"
  ,[0, 10, 5, 0]
  ,1
  ,{}
  ,false
] call CBA_fnc_addSetting;





