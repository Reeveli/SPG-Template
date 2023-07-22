/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Server side function to start CBA events for ammunition handling. Run as a postinit.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_arty_fnc_server_init
1.8
	Fixed wrong CBA_fnc_serverEvent call preventing ammo regen on following (was 0, should have been -1):
		ILM
		MIS
		CLU
		AIR
		SUP
		GUN
		BOM

1.7
	CBA network function switched to publicvaribale command instead. When info is sent to clients was also taken out if the regen event for faster transmit
	General event restructure to support faster updates to clients (server-side regen event now add ammo via the event itself)
1.6
	Values are now prodcasted to clients on each update for better user experience (no waiting for fetch to complete)
1.5.1
	Added some extra comnents
1.5
	Added code for bombing runs
1.4
	Added code for gunship
1.3
	Added code for resupply
1.2
	Total overhaul to CBA event system
1.1
	Added loops for cluster missiles

*/
if !(isServer) exitWith {};



//HE ammo
Rev_arty_HE_amount = Rev_arty_HE_amount_sys;
Rev_arty_HE_check =  (-1* Rev_arty_HE_regen);

//HE Regen
["Rev_arty_HE_regen", {
	params ["_amount"];
	//Update ammo amount to all clients
	Rev_arty_HE_amount = Rev_arty_HE_amount- _amount;
	publicVariable "Rev_arty_HE_amount";

	//If a previous regeneration is ongoing, exit to prevent double regen
	if (((cba_missiontime - Rev_arty_HE_check) < Rev_arty_HE_regen) or (Rev_arty_HE_regen <= 0)) exitWith {};

	//Update time check to latest new regeneration instance, then update ammo amount
	if (Rev_arty_HE_amount< Rev_arty_HE_amount_sys) then {
		Rev_arty_HE_check = cba_missiontime;
		[
			{
				["Rev_arty_HE_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_HE_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;

//Smoke ammo
Rev_arty_SMK_amount = Rev_arty_SMK_amount_sys;
Rev_arty_SMK_check =  (-1* Rev_arty_SMK_regen);

//Smoke Regen
["Rev_arty_SMK_regen", {
	params ["_amount"];
	Rev_arty_SMK_amount = Rev_arty_SMK_amount - _amount;
	publicVariable "Rev_arty_SMK_amount";
	if (((cba_missiontime - Rev_arty_SMK_check) < Rev_arty_SMK_regen) or (Rev_arty_SMK_regen <= 0)) exitWith {};
	
	if (Rev_arty_SMK_amount < Rev_arty_SMK_amount_sys) then {
		Rev_arty_SMK_check = cba_missiontime;
		[
			{
				["Rev_arty_SMK_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_SMK_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;



//Illumination ammo
Rev_arty_ILM_amount = Rev_arty_ILM_amount_sys;
Rev_arty_ILM_check =  (-1* Rev_arty_ILM_regen);

//Illumination Regen
["Rev_arty_ILM_regen", {
	params ["_amount"];
	Rev_arty_ILM_amount = Rev_arty_ILM_amount - _amount;
	publicVariable "Rev_arty_ILM_amount";
	if (((cba_missiontime - Rev_arty_ILM_check) < Rev_arty_ILM_regen) or (Rev_arty_ILM_regen <= 0)) exitWith {};
	
	if (Rev_arty_ILM_amount < Rev_arty_ILM_amount_sys) then {
		Rev_arty_ILM_check = cba_missiontime;
		[
			{
				["Rev_arty_ILM_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_ILM_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;


//Missile ammo
Rev_arty_MIS_amount = Rev_arty_MIS_amount_sys;
Rev_arty_MIS_check =  (-1* Rev_arty_MIS_regen);

//Missile Regen
["Rev_arty_MIS_regen", {
	params ["_amount"];
	Rev_arty_MIS_amount = Rev_arty_MIS_amount - _amount;
		publicVariable "Rev_arty_MIS_amount";
	if (((cba_missiontime - Rev_arty_MIS_check) < Rev_arty_MIS_regen) or (Rev_arty_MIS_regen <= 0)) exitWith {};
	
	if (Rev_arty_MIS_amount < Rev_arty_MIS_amount_sys) then {
		Rev_arty_MIS_check = cba_missiontime;
		[
			{
				["Rev_arty_MIS_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_MIS_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;


//Cluster ammo
Rev_arty_CLU_amount = Rev_arty_CLU_amount_sys;
Rev_arty_CLU_check =  (-1* Rev_arty_CLU_regen);

//Cluster Regen
["Rev_arty_CLU_regen", {
	params ["_amount"];
	Rev_arty_CLU_amount = Rev_arty_CLU_amount - _amount;
	publicVariable "Rev_arty_CLU_amount";
	if (((cba_missiontime - Rev_arty_CLU_check) < Rev_arty_CLU_regen) or (Rev_arty_CLU_regen <= 0)) exitWith {};
	
	if (Rev_arty_CLU_amount < Rev_arty_CLU_amount_sys) then {
		Rev_arty_CLU_check = cba_missiontime;
		[
			{
				["Rev_arty_CLU_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_CLU_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;

//Air amount
Rev_arty_AIR_amount = Rev_arty_AIR_amount_sys;
Rev_arty_AIR_check =  (-1* Rev_arty_AIR_regen);

//AIR Regen
["Rev_arty_AIR_regen", {
	params ["_amount"];
	Rev_arty_AIR_amount = Rev_arty_AIR_amount - _amount;
	publicVariable "Rev_arty_AIR_amount";
	if (((cba_missiontime - Rev_arty_AIR_check) < Rev_arty_AIR_regen) or (Rev_arty_AIR_regen <= 0)) exitWith {};
	
	if (Rev_arty_AIR_amount < Rev_arty_AIR_amount_sys) then {
		Rev_arty_AIR_check = cba_missiontime;
		[
			{
				["Rev_arty_AIR_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_AIR_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;

//AIR penalty
["Rev_arty_AIR_event_penalty", {
	Rev_arty_AIR_check = Rev_arty_AIR_check + Rev_arty_AIR_penalty;
}] call CBA_fnc_addEventHandler;


//Supply amount
Rev_arty_SUP_amount = Rev_arty_SUP_amount_sys;
Rev_arty_SUP_check =  (-1* Rev_arty_SUP_regen);

//Supply Regen
["Rev_arty_SUP_regen", {
	params ["_amount"];
	Rev_arty_SUP_amount = Rev_arty_SUP_amount - _amount;
	publicVariable "Rev_arty_SUP_amount";
	if (((cba_missiontime - Rev_arty_SUP_check) < Rev_arty_SUP_regen) or (Rev_arty_SUP_regen <= 0)) exitWith {};
	
	if (Rev_arty_SUP_amount < Rev_arty_SUP_amount_sys) then {
		Rev_arty_SUP_check = cba_missiontime;
		[
			{
				["Rev_arty_SUP_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_SUP_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;


//Gunship amount
Rev_arty_GUN_amount = Rev_arty_GUN_amount_sys;
Rev_arty_GUN_check =  (-1* Rev_arty_GUN_regen);

//Gunship Regen
["Rev_arty_GUN_regen", {
	params ["_amount"];
	Rev_arty_GUN_amount = Rev_arty_GUN_amount - _amount;
	publicVariable "Rev_arty_GUN_amount";
	if (((cba_missiontime - Rev_arty_GUN_check) < Rev_arty_GUN_regen) or (Rev_arty_GUN_regen <= 0)) exitWith {};
	
	if (Rev_arty_GUN_amount < Rev_arty_GUN_amount_sys) then {
		Rev_arty_GUN_check = cba_missiontime;
		[
			{
				["Rev_arty_GUN_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_GUN_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;


//Area bombing amount
Rev_arty_BOM_amount = Rev_arty_BOM_amount_sys;
Rev_arty_BOM_check =  (-1* Rev_arty_BOM_regen);

//Area bombing Regen
["Rev_arty_BOM_regen", {
	params ["_amount"];
	Rev_arty_BOM_amount = Rev_arty_BOM_amount - _amount;
	publicVariable "Rev_arty_BOM_amount";
	if (((cba_missiontime - Rev_arty_BOM_check) < Rev_arty_BOM_regen) or (Rev_arty_BOM_regen <= 0)) exitWith {};
	
	if (Rev_arty_BOM_amount < Rev_arty_BOM_amount_sys) then {
		Rev_arty_BOM_check = cba_missiontime;
		[
			{
				["Rev_arty_BOM_regen",[-1]] call CBA_fnc_serverEvent;
			},
			[],
			Rev_arty_BOM_regen
		] call CBA_fnc_waitAndExecute;
	};	
}] call CBA_fnc_addEventHandler;