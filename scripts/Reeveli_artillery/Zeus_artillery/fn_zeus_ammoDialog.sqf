/*
 * Author: Reeveli
 * Initializes ZEN dialog for curator module to adjust current artillery ammunition amounts.
 *
 * Arguments: NONE
 *
 * Return Value: <NONE>
 *
 * Example:
 * call Rev_arty_fnc_zeus_ammoDialog
 *
*/


[
	"Adjust Artillery Ammunition",
	[
		["SLIDER","HE amount",[0,300,Rev_arty_HE_amount,0],false],
		["SLIDER","Smoke amount",[0,300,Rev_arty_SMK_amount,0],false],
		["SLIDER","Illumination amount",[0,300,Rev_arty_ILM_amount,0],false],
		["SLIDER","Cluster amount",[0,300,Rev_arty_CLU_amount,0],false],
		["SLIDER","Missile amount",[0,30,Rev_arty_MIS_amount,0],false],
		["SLIDER","CAS amount",[0,30,Rev_arty_AIR_amount,0],false],
		["SLIDER","Supply drop amount",[0,30,Rev_arty_SUP_amount,0],false],
		["SLIDER","Gunship amount",[0,30,Rev_arty_GUN_amount,0],false],
		["SLIDER","Bomber amount",[0,30,Rev_arty_BOM_amount,0],false]
	],
	{
		params ["_results","_position"];
		_results params ["_HE","_smk","_flares","_cluster","_missile","_CAS","_supply","_gunShip","_bombs"];
		Rev_arty_HE_amount = _HE;
		publicVariable "Rev_arty_HE_amount";

		Rev_arty_SMK_amount = _smk;
		publicVariable "Rev_arty_SMK_amount";

		Rev_arty_ILM_amount = _flares;
		publicVariable "Rev_arty_ILM_amount";

		Rev_arty_CLU_amount = _cluster;
		publicVariable "Rev_arty_CLU_amount";

		Rev_arty_MIS_amount = _missile;
		publicVariable "Rev_arty_MIS_amount";

		Rev_arty_AIR_amount = _CAS;
		publicVariable "Rev_arty_AIR_amount";

		Rev_arty_SUP_amount = _supply;
		publicVariable "Rev_arty_SUP_amount";

		Rev_arty_GUN_amount = _gunShip;
		publicVariable "Rev_arty_GUN_amount";

		Rev_arty_BOM_amount = _bombs;
		publicVariable "Rev_arty_BOM_amount";



		[objNull, "Ammunition amounts adjusted"] call BIS_fnc_showCuratorFeedbackMessage;

	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog Closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[]
] call zen_dialog_fnc_create;