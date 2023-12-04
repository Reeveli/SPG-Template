/*
 * Author: Reeveli 
 * Part of Reeveli's Advanced Gestures system.
 * Client side function to create initialy eventhandler when a gesture is made by the player. Called as a postinit function.
 *
 * Arguments: <NONE>
 *
 * Return Value: <NONE>
 *
 * Example:
 * call Rev_fnc_advanced_gestures
 *
 2.0
	Gesture notifications are now localised using the the ACE gesture -addon stringtable.
 */


if !(hasInterface) exitWith {};
if !(Rev_advanced_gestures_enable) exitWith {};

//Code block for the main eventhandler
private _code = {
	params [
		["_unit", objNull, [objNull]],
		["_gesture","",[""]]
	];

	if (isNull _unit) exitWith {diag_log "Rev_advanced_gestures, exit: objNull as param";};
	if (count _gesture < 1) exitWith {diag_log "Rev_advanced_gestures, exit: No string as as param";};

	private _name = name _unit;
	private _hint = "";
	if ((_gesture find "StandLowered") > -1) then {
			private _string = count _gesture;
			_gesture = [_gesture,0,(_string  - 1) - (count "StandLowered")] call BIS_fnc_trimString;
		};
	_gesture = toLowerANSI _gesture;
	diag_log format ["Rev_advanced_gestures, animation called: %1", _gesture];
	
	switch (_gesture) do
	{
		case 'gestureadvance' : {_hint = localize 'STR_ACE_Gestures_Advance';};
		case 'gesturego' : {_hint = localize 'STR_ACE_Gestures_Go';};
		case 'gesturegob' : {_hint = localize 'STR_ACE_Gestures_Go';};
		case 'gesturefollow' : {_hint = localize 'STR_ACE_Gestures_Follow';};
		case 'gestureup' : {_hint = localize 'STR_ACE_Gestures_Up';};
		case 'gestureceasefire' : {_hint = localize 'STR_ACE_Gestures_CeaseFire';};
		case 'gesturefreeze' : {_hint = localize 'STR_ACE_Gestures_Stop';};
		case 'ace_gestures_forward' : {_hint = localize 'STR_ACE_Gestures_Forward';};
		case 'ace_gestures_regroup' : {_hint = localize 'STR_ACE_Gestures_Regroup';};
		case 'ace_gestures_freeze' : {_hint = localize 'STR_ACE_Gestures_Freeze';};
		case 'ace_gestures_cover' : {_hint = localize 'STR_ACE_Gestures_Cover';};
		case 'ace_gestures_point' : {_hint = localize 'STR_ACE_Gestures_Point';};
		case 'ace_gestures_engage' : {_hint = localize 'STR_ACE_Gestures_Engage';};
		case 'ace_gestures_hold' : {_hint = localize 'STR_ACE_Gestures_Hold';};
		case 'ace_gestures_warning' : {_hint = localize 'STR_ACE_Gestures_Warning';};
	};
	diag_log format ["Rev_advanced_gestures, text shown: %1", _hint];
	
	private _text = format [ "<t size='%4' color='%2' font='%3' shadow=2>%1</t>", _hint,Rev_advanced_gestures_color call BIS_fnc_colorRGBAtoHTML,Rev_advanced_gestures_font,Rev_advanced_gestures_size];
	[_text, 0, 0.1*safeZoneH+safeZoneY, Rev_advanced_gestures_duration, 0, 0, 800] spawn BIS_fnc_dynamicText;

	//Play remote Eh for other players
	private _players = (call CBA_fnc_players) select {(side _x isEqualTo side _unit) AND ((_x distance _unit) <= 15) AND !(_x getVariable ["ACE_isUnconscious", false]) AND (([objNull, "VIEW"] checkVisibility [eyePos _x, eyePos _unit]) > 0)};
	_players = _players - [_unit];
	["Rev_advanced_gestures_remote", [_unit,_hint],_players] call CBA_fnc_targetEvent;
};

//Main eventhandler
["ace_common_playActionNow", _code] call CBA_fnc_addEventHandler;