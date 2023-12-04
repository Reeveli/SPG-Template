/*
 * Author: Reeveli 
 * Client side function to start dynamic ZEN dialog for adding new map location.
 * NOTE: New map locations will NOT BE VISIBLE IN THE CURATOR INTERFACE for reasons unknown.
 * Exit curator mode and look at your normal map to confirm new location creation.
 * Called from Rev_fnc_zeus_init
 *
 * Arguments:
 * 0: Selected position <ARRAY>
 *
 * Return Value: NONE
 *
 * Example:
 * [_this select 0] call Rev_fnc_locationDialogNew
 *
 */


if (!hasInterface) exitWith {false};

params [
	["_position",nil,[[]],[2,3]]
];

[
	"Create new map location",
	[
		["LIST",["Location types","Select the new location's type from the list"],[["NameCity","NameCityCapital","NameVillage","NameLocal","NameMarine"],[["NameCity"],["NameCityCapital"],["NameVillage"],["NameLocal"],["NameMarine"],["Do not cretae new location","this option will not create any new map locations"]],0,5],false],
		["EDIT",["New location's name","The map name of the new location"],["New location"],false]


	],
	{
		params ["_results","_passed_arguments"];

		_results params [
			["_type","NameCity",[""]],
			["_name","New location",[""]]
		];

		private _position = _passed_arguments select 0;

		if (_type isEqualTo "Empty") exitWith {};
		[_type, _position,_name] remoteExec ["Rev_fnc_locationNew",0,true];

		[] spawn
		{
			private _ok = ["I understand the new location IS NOT VISIBLE in curator mode.","",true,false,findDisplay 312] spawn BIS_fnc_guiMessage;
		};
	

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;