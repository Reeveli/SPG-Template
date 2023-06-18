/*
 * Author: Reeveli
 * Function to create a terminal for Reeveli's custom Halo action. Terminal will have HALO useraction for all players.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 1] call Rev_fnc_halo_module
 *
 */

params [
	["_object", objNull, [objNull]]
];

if (isNull _object) exitWith {
	playSound "FD_Start_F";
	[objNull, "No object was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
};

if (_object isKindOf "Man") exitWith {
	playSound "FD_Start_F";
	[objNull, "Module cannot be placed on a unit!"] call BIS_fnc_showCuratorFeedbackMessage;
};

if (_object getVariable ["Halo_action",false]) exitWith {
	playSound "FD_Start_F";
	[objNull, "Object is already HALO terminal!"] call BIS_fnc_showCuratorFeedbackMessage;
};

private _text = "<t align='center'><img image='scripts\Reeveli_fnc\Rev_halo\images\plp_icon_parachute.pac' size='2' /><br/></t><t align='center'>HALO jump</t>";
//_object addAction 


[_object,[
_text
,{params ["_target", "_caller", "_actionId", "_arguments"];["B_T_VTOL_01_infantry_F"] call Rev_fnc_halo_start;}
,nil
,6
,true
,true
,""
,"true"
,4
,false
,""
,""
]] remoteExec ["addAction",0,true];

[objNull, "Action added"] call BIS_fnc_showCuratorFeedbackMessage;

_object setVariable ["Halo_action",true,true];