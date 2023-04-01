/*
2.1
	Added code for TF_fnc_position
*/
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

[
	"Killet's Zeus Tools",
	"KLT_MilsimTools - Zeus",
	["Toggle curator camera hearing","Toggle hearing between curator camera and player character"],
	{
		if (isNull findDisplay 312) exitWith {false};
		if (player getVariable ["Rev_restricted_curator",false]) exitWith {false};
		private _var = missionNamespace getVariable 'TFAR_curatorCamEars';
		missionNamespace setVariable ['TFAR_curatorCamEars',!_var];
		[objNull, format ["Hearing from curator camera: %1",str !(_var)]] call BIS_fnc_showCuratorFeedbackMessage;
		if !(_var) then {
			player setVariable ["TF_fnc_position", {private _pctw = positionCameraToWorld [0,0,0]; [ATLToASL _pctw, (positionCameraToWorld [0,0,1]) vectorDiff _pctw]}];
		} else {
			player setVariable ["TF_fnc_position", nil];
			call TFAR_fnc_updateSpeakVolumeUI;
		};
	},
	{},
	[DIK_INSERT, [false, false, false]]
] call CBA_fnc_addKeybind;