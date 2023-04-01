/*
 * Author: Reeveli, some code ported from Achilles mod
 * Client side function to start Zen dynamic dialog for legacy suppressive fire. Called from Zen context action.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value: NONE
 *
 * Example:
 * [_objects select 0] call Rev_fnc_gui_suppressive_fire
 *
 */

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};

//Check if is player group
private _group = group _unit;
if (((units _group) findIf {_x in call CBA_fnc_players}) >= 0) exitWith
{
	playSound "FD_Start_F";
	[objNull, "Cannot be applied to gropus with players"] call BIS_fnc_showCuratorFeedbackMessage;
};

// Get list of possible targets
if !(["zen_modules_moduleCreateTarget"] call zen_position_logics_fnc_exists) exitWith
{
	playSound "FD_Start_F";
	[objNull, "No target logics available"] call BIS_fnc_showCuratorFeedbackMessage;
};
private _allTargetsData = ["zen_modules_moduleCreateTarget"] call zen_position_logics_fnc_get;
private _allTargetNames = [["Random","","\x\zen\addons\position_logics\ui\random_ca.paa"],["Nearest","","\x\zen\addons\position_logics\ui\nearest_ca.paa"],["Farhest","","\x\zen\addons\position_logics\ui\farthest_ca.paa"]];
private _allTargetsIndex = [-3,-2,-1];

{
	private _name = name _x;
	_allTargetNames pushBack [_name,"","\x\zen\addons\modules\ui\target_ca.paa"];
	_allTargetsIndex pushback _forEachIndex;
} forEach _allTargetsData;


// get available weapons, muzzles, magazines
private _weaponsAndMuzzlesAndMagazines = [_unit] call Rev_fnc_getWeaponsMuzzlesMagazines;
if (_weaponsAndMuzzlesAndMagazines isEqualTo []) exitWith
{
	playSound "FD_Start_F";
	[objNull, "No valid weapons available!"] call BIS_fnc_showCuratorFeedbackMessage;
};

private _weaponMuzzleMagazineIdxList = [];
private _weaponNames = [];
{
	private _weapIdx = _forEachIndex;
	_x params ["_weaponAndTurret","_muzzlesAndMagazines"];
	_weaponAndTurret params ["_weapon", "_turret"];
	private _weaponName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
	_weaponNames append [_weaponName];
	{
		private _muzzleIdx = _forEachIndex;
		_x params ["_muzzle","_magazines"];
		{
			private _magazine = _x;
			private _magIdx = _forEachIndex;
			_weaponMuzzleMagazineIdxList pushBack [_weapIdx, _muzzleIdx, _magIdx];
		} forEach _magazines;
	} forEach _muzzlesAndMagazines;
} forEach _weaponsAndMuzzlesAndMagazines;

private _fireModes = [["Automatic"],["Burst"],["Single"]];

// talking guns is only available for more than a single unit
if (count (units _unit) > 1) then {_fireModes pushBack "Talking guns"};

[
	"Reeveli's legacy suppression",
	[
		["COMBO","Targets",[_allTargetsIndex,_allTargetNames,0],true],
		["COMBO","Unit stance",[[0,1,2],[["Prone"],["Crouch"],["Stand"]],0],false],
		["TOOLBOX:YESNO","Line up",[false],false],
		["COMBO","Weapon to fire",[_weaponMuzzleMagazineIdxList,_weaponNames,0],false],
		["COMBO","Fire mode",[[0,1,2,3],_fireModes,0],false],
		["EDIT","Duration",["20"],false]	
	],
	{
		params ["_results","_passed_arguments"];
		[objNull, "Suppressing"] call BIS_fnc_showCuratorFeedbackMessage;

		_results params
		[
			"_allTargetsIndex",
			"_stanceIndex",
			"_doLineUp",
			"_weaponsToFireIdx",
			"_fireModeIndex",
			"_duration"
		];

		private _weaponMuzzleMagazineIdxList = _passed_arguments select 1;
		(_weaponMuzzleMagazineIdxList select _weaponsToFireIdx) params ["_weapIdx", "_muzzleIdx", "_magIdx"];
		_duration = parseNumber _duration;

		private _unit = _passed_arguments select 0;

		// Choose a target to fire at
		private _selectedTargetLogic = ["zen_modules_moduleCreateTarget", _allTargetsIndex, position _unit] call zen_position_logics_fnc_select;

		//Make sure the group is local
		private _group = _passed_arguments select 2;
		if (not local _group) then {[_group,clientOwner] remoteExecCall ["setGroupOwner",2]};
		if (isNull _group or {{alive _x} count units _group == 0}) exitWith {
			playSound "FD_Start_F";
			[objNull, "No alive units selected"] call BIS_fnc_showCuratorFeedbackMessage;
		};
		private _target = 
		// Executing with call because we are in a suspension-enabled environment
		[_unit,_selectedTargetLogic, _weapIdx, _muzzleIdx, _magIdx, _fireModeIndex, _stanceIndex, _doLineUp, _duration] spawn Rev_fnc_suppressiveFire;
		[objNull, "Suppressing"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_unit,
		_weaponMuzzleMagazineIdxList,
		_group
	]
	
] call zen_dialog_fnc_create;