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
 1.1.2
	Fixed typos in header
 1.1.1
	Fixed type in curatorHint
 1.1
	Notification about label visiblity changed to curatorHint type.
	Changed the default name string to empty
		Empty name is also now forced as default
	Added new location type options to dialog
		Also cleaned up the array from leftover code for empty type
 */


if (!hasInterface) exitWith {false};

params [
	["_position",nil,[[]],[2,3]]
];

[
	"Create new map location",
	[
		[
			"LIST",
			["Location types","Select the new location's type from the list"],
			[
				["City","Capital City","Village","Local","Marine","Safety Zone","Strategic","Rock Area","Hill","View Point"],
				[["NameCity"],["NameCityCapital"],["NameVillage"],["NameLocal"],["NameMarine"],["SafetyZone"],["Strategic"],["RockArea"],["Hill"],["ViewPoint"]],
				0,
				5
			],
			false
		],
		["EDIT",["New location's name","The map name of the new location"],[""],true]
	],
	{
		params ["_results","_passed_arguments"];

		_results params [
			["_type","NameCity",[""]],
			["_name","",[""]]
		];

		private _position = _passed_arguments select 0;

		if (_type isEqualTo "Empty") exitWith {};
		[_type, _position,_name] remoteExec ["Rev_fnc_locationNew",0,true];
		playSound "FD_Finish_F";
		[_name, "Location created, the label will NOT BE VISIBLE IN CURATOR VIEW. Only on 'normal' map", 8] call BIS_fnc_curatorHint;
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position
	]
] call zen_dialog_fnc_create;