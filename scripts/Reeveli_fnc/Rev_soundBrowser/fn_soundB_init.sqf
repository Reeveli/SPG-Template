/*
 * Author: Rydygier & Reeveli
 * Part of Simple Sound Browser.
 * Client side function to create dialog.
 * Can called from 3den (e.g. from console) or from curator module while in 3den preview game.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_fnc_soundB_init;
 *
 */


if !(hasInterface) exitWith {};
if !(is3DEN|| is3DENPreview) exitWith {
	playSound "FD_Start_F";
	systemchat "Sound Browser can only be opened in editor or in editor preview!"
};

private _initDisplay = findDisplay 46;
if ((findDisplay 313) in alldisplays) then {_initDisplay = findDisplay 313;};

private _display = _initDisplay createDisplay "RscDisplayEmpty";
if (isNull _display) exitWith {};

_display ctrlCreate ["RscSoundBrowser", -1];

//We only need list if not already made in session
if (isNil "RYD_SB_AllTheSounds") then {RYD_SB_AllTheSounds = []};

//Config sounds
private _cfgSounds = configFile >> "CfgSounds";
for "_i" from 0 to ((count _cfgSounds) - 1) do
{
	private _class = _cfgSounds select _i;
	if (isClass _class) then
	{
		private _class = configName _class;
		private _sound = _cfgSounds >> _class >> "sound";
		if (isArray _sound) then {RYD_SB_AllTheSounds pushBack _class}
	}
};
//mission sounds
private _cfgMission = missionConfigFile >> "CfgSounds";
for "_i" from 0 to ((count _cfgMission) - 1) do
{
	private _class = _cfgMission select _i;
	if (isClass _class) then
	{
		private _class = configName _class;
		private _sound = _cfgMission >> _class >> "sound";
		if (isArray _sound) then {RYD_SB_AllTheSounds pushBack _class}
	}
};

//createDialog ["RscSoundBrowser",false];
private _copy = localNameSpace getVariable ['Rev_soundB_copy',controlNull];
_copy ctrlEnable false;

//Populating list
private _list = localNameSpace getVariable ['Rev_soundB_list',controlNull];
{
	private _index = _list lbAdd _x;
	private _name = configFile >> "CfgSounds" >> _x >> "titles";

	if (isArray _name) then {
		if (count _name <= 0) exitWith {};
		private _n = (getArray _name) select 0;
		if (_n isEqualType "") then {_list lbSetTooltip [_index,_n]};
	};
} foreach RYD_SB_AllTheSounds;

lbSort [_list,"ASC"]; 