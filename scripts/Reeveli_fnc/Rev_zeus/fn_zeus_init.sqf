/*
 * Author: Reeveli
 * Client side function to create custom ZEN modules and context actions for curators. Called as a postinit.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_fnc_zeus_init
 *
 1.7s
    Added Aperture control module
 1.6S
	Added Sound Browser module
 1.5.2S
	Removed mission code module	(probably copied over by accident from Rev branch)
	Removed old legacy code for Achilles smoke launcher module
 1.5.1
	Remove map location -module function updated
 1.5
	Added map location modules
 1.4
	Added teleportation system module
 1.3
	New curator module for post processing
	Injure action renamed for clarity
 1.2.2
	New editor module for icon viewer
 1.2.1
	New suppressive fire is now called as function, not script (leftover from testing)
 1.2
	New suppressive fire context actionIDs added
	Slight updated to legacy system name
 1.1
	Air strike and tactical missile moved to Rev_arty_fnc_player_init
	All fire support context menu actins moved to Rev_arty_fnc_player_init
 */

if !(hasInterface) exitWith {};

//ZEN modules
if (isClass (configFile >> "CfgPatches" >> "zen_custom_modules")) then
{
	//Editor preview modules
	if (is3DENPreview) then {
		["Reeveli's ZEN Showcase", "Check, color, combo, edit & list", {[_this select 0,_this select 1] call Rev_fnc_module_preview},"\a3\Ui_f\data\GUI\Cfg\Hints\Zeus_ca.paa"] call zen_custom_modules_fnc_register;
		["Reeveli's ZEN Showcase", "Owner,side & slider controls", {[_this select 0,_this select 1] call Rev_fnc_module_preview_2},"\a3\Ui_f\data\GUI\Cfg\Hints\Use_ca.paa"] call zen_custom_modules_fnc_register;
		["Reeveli's ZEN Showcase", "Toolbox and vector controls", {[_this select 0,_this select 1] call Rev_fnc_module_preview_3},"\a3\Ui_f\data\GUI\Cfg\Hints\ActionMenu_ca.paa"] call zen_custom_modules_fnc_register;
		["Reeveli's Editor Modules", "Icon viewer", {[] call Rev_fnc_icon_viewer}] call zen_custom_modules_fnc_register;
		["Reeveli's Editor Modules", "Sound Browser", {call Rev_fnc_soundB_init},"a3\ui_f\data\igui\rscingameui\rscunitinfoairrtdfull\ico_cpt_music_on_ca.paa"] call zen_custom_modules_fnc_register;
	};	
	//Misc modules
	["Reeveli's ZEN Modules", "AI Surrender Squad", {
			params ["_pos","_unit"];
			if (isNull _unit) exitwith
			{
				playSound "FD_Start_F";
				[objNull, "No unit was selected!"] call BIS_fnc_showCuratorFeedbackMessage;
			};
			[objNull, "Squad Surrendered"] call BIS_fnc_showCuratorFeedbackMessage;			
			[_unit] remoteExec ["Rev_fnc_group_surrender",_unit];
		}, "\z\ace\addons\captives\ui\Surrender_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Blackout", {[_this select 0] call Rev_fnc_blackout_dialog},"\A3\Ui_f\data\IGUI\Cfg\Actions\beacons_OFF_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "End Mission", {call Rev_fnc_end_mission}] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Injure Unit", {[_this select 1] call Rev_fnc_injury},"\x\zen\addons\context_actions\ui\medical_cross_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Make Spectator", {[_this select 1] call Rev_fnc_spectator},"\a3\ui_f_curator\Data\Logos\arma3_curator_eye_64_ca.paa"] call zen_custom_modules_fnc_register;	
	["Reeveli's ZEN Modules", "Suppress Squad", {[_this select 1, 20] spawn Rev_fnc_group_suppress},"\a3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Add HALO Terminal", {[_this select 1] call Rev_fnc_halo_module},"scripts\Reeveli_fnc\Rev_halo\images\plp_icon_parachute.pac"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Supply Drop", {[_this select 0] call Rev_fnc_resupply_dialog},"\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Post Processing", {[] call Rev_fnc_postProcessing},"a3\modules_f_curator\data\portraitpostprocess_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's ZEN Modules", "Aperture control", {[] call Rev_fnc_aperture_dialog},"a3\weapons_f_orange\reticle\data\camera_ca.paa"] call zen_custom_modules_fnc_register;

	//Teleportation system
	["Reeveli's Teleportation system","Add teleport point",{[_this select 1] call Rev_fnc_tp_ZEN_dialog},"a3\ui_f_curator\data\cfgwrapperui\cursors\curatormove_ca.paa"] call zen_custom_modules_fnc_register;

	//Map location manipulation
	
	["Reeveli's Map locations", "Add map location", {[_this select 0] call Rev_fnc_locationDialogNew},"a3\ui_f\data\igui\cfg\simpletasks\types\map_ca.paa"] call zen_custom_modules_fnc_register;
	["Reeveli's Map locations", "Remove map location", {[_this select 0] call Rev_fnc_locationCuratorRemove},"a3\ui_f\data\igui\cfg\simpletasks\types\map_ca.paa"] call zen_custom_modules_fnc_register;
};


////////Context menu actions/////////
if (isClass (configFile >> "CfgPatches" >> "zen_context_menu")) then
{
	//Surrender squad action
	private _surrender_action = [
		"Rev_surrender",
		"Improved squad surrender",
		"\z\ace\addons\captives\UI\Surrender_ca.paa",
		{
			private _unit = _objects select 0;
			[_unit] remoteExec ["Rev_fnc_group_surrender",_unit];
		},
		{
			(count _objects) > 0;
		}
	] call zen_context_menu_fnc_createAction;

	[_surrender_action, ["Captives"], 0] call zen_context_menu_fnc_addAction;

	//Injury action
	private _injure_action = [
		"Rev_injure",
		"Injure (single) unit",
		["\x\zen\addons\context_actions\ui\medical_cross_ca.paa",[0.9,0,0,1]],
		{
			[_objects select 0] call Rev_fnc_injury
		},
		{
			(count _objects) isEqualTo 1;
		}
	] call zen_context_menu_fnc_createAction;

	[_injure_action, ["HealUnits"], 0] call zen_context_menu_fnc_addAction;

	//Spectator action
	private _spectator_action = [
		"Rev_spectator",
		"Make spectator",
		"\a3\ui_f_curator\Data\CfgHints\entitySelect_object_ca.paa",
		{
			[_objects select 0] call Rev_fnc_spectator
		},
		{
			private _unit = _objects select 0;
			(((count _objects) > 0) && (_unit in (call CBA_fnc_players)));
		},
		[],
		{},
		{
			params ["_action","_parameters"];
			private _unit = (_parameters select 1) select 0;
			if (_unit in (call ace_spectator_fnc_players)) then {			
				_action set [1, "Remove spectator"];
				_action set [4, {[false] remoteExec ["ace_spectator_fnc_setSpectator",(_objects select 0),false]}];
			};
		}
	] call zen_context_menu_fnc_createAction;

	[_spectator_action, [], 0] call zen_context_menu_fnc_addAction;

	//Suppress action
	private _suppress_action = [
		"Rev_suppress",
		"Suppress squad",
		"\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_deploy_prone_ca.paa",
		{
			[_objects select 0, 20] spawn Rev_fnc_group_suppress
		},
		{
			(count _objects) > 0;
		}
	] call zen_context_menu_fnc_createAction;

	[_suppress_action, [], 0] call zen_context_menu_fnc_addAction;

	//Suppressive fire
	private _suppressive_fire = [
		"Rev_suppressive_fire",
		"Legacy suppresive fire",
		"\x\zen\addons\modules\ui\target_ca.paa",
		{
			[_objects select 0] call Rev_fnc_gui_suppressive_fire;
		},
		{
			(count _objects) > 0;
		}
	] call zen_context_menu_fnc_createAction;

	[_suppressive_fire, [], 0] call zen_context_menu_fnc_addAction;	


	//New suppressive fire
	private _suppress_new = [
		"Rev_suppress",
		"Suppressive fire",
		"\x\zen\addons\modules\ui\target_ca.paa",
		{
			[_objects select 0] call Rev_fnc_suppress;
		},
		{
			(count _objects) > 0;
		},
		[],
		{},
		{
			params ["_action","_parameters"];
			private _unit = (_parameters select 1) select 0;
			private _group = group _unit;
			if (!isNil {_group getVariable ["Rev_suppression",nil]}) then {
				_action set [1, "Stop suppressive fire"];
				_action set [4, {private _target = (group (_objects # 0) getVariable ["Rev_suppression",nil]); deleteVehicle _target}];
			};
		}
	] call zen_context_menu_fnc_createAction;

	[_suppress_new, [], 0] call zen_context_menu_fnc_addAction;
};



