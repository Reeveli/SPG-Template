//Comments by Reeveli

params ["_enable"];
if !(_enable) exitWith {};
//Added by Reeveli
VcmAI_ActiveList = []; //Leave this alone
Vcm_ArtilleryArray = []; //Leave this alone
VCM_ARTYLST = []; //List of all AI inside of artillery pieces, leave this alone.
VCM_ARTYWT = -(VCM_ARTYDELAY);
VCM_ARTYET = -(VCM_ARTYDELAY);
VCM_ARTYRT = -(VCM_ARTYDELAY);
VCM_CLASSNAMESPECIFIC = false; //Do you want the AI to have classname specific skill settings?
VCM_SIDESPECIFICSKILL = false; //Do you want the AI to have side specific skill settings? This overrides classname specific skills.
VCM_SKILL_CLASSNAMES = []; //Here you can assign certain unit classnames to specific skill levels. This will override the AI skill level above.


VCM_AIDIFSET =
{
	{
		private _unit = _x;
		_unit setSkill 0.9;
		_unit allowFleeing 0;			
		{
			_unit setSkill _x;
		} forEach VCM_AIDIFA;
		
		
		if (VCM_CLASSNAMESPECIFIC && {count VCM_SKILL_CLASSNAMES > 0}) then
		{
			{
				if (typeOf _unit isEqualTo (_x select 0)) exitWith
				{
					_ClassnameSet = true;
					_unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_unit setSkill ["aimingShake",((_x select 1) select 1)];_unit setSkill ["spotDistance",((_x select 1) select 2)];_unit setSkill ["spotTime",((_x select 1) select 3)];_unit setSkill ["courage",((_x select 1) select 4)];_unit setSkill ["commanding",((_x select 1) select 5)];	_unit setSkill ["aimingSpeed",((_x select 1) select 6)];_unit setSkill ["general",((_x select 1) select 7)];_unit setSkill ["endurance",((_x select 1) select 8)];_unit setSkill ["reloadSpeed",((_x select 1) select 9)];
				};
			} foreach VCM_SKILL_CLASSNAMES;
		};			
		
		if (VCM_SIDESPECIFICSKILL) then
		{
			_unit call VCM_AISIDESPEC;
		};
		
	} forEach (units _this);
};

VCM_AIDIFA = [['aimingAccuracy',0.25],['aimingShake',0.15],['aimingSpeed',0.35],['commanding',0.85],['courage',0.5],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];


[] spawn
{

	waitUntil {!(isNil "VCM_AIMagLimit")};
	
	//Mod checks
	//ACE CHECK
	if (!(isNil "ACE_Medical_enableFor") && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;} else {VCM_MEDICALACTIVE = true;};
	//CBA CHECK
	if (isClass(configFile >> "CfgPatches" >> "cba_main")) then {CBAACT = true;} else {CBAACT = false;};
	//ENHANCED MOVEMENT CHECK
	if !(isNil "EM_debug") then {VCOM_EM_ENABLED = true;} else {VCOM_EM_ENABLED = false;};
	
	
	//Global actions compiles
	Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
	Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
	Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
	VCOM_MINEARRAY = [];
	VCM_CoverQueue = [];
	
	//OnEachFrame monitor for mines. Should make them more responsive, without a significant impact on FPS.
	["VCMMINEMONITOR", "onEachFrame", {[] call VCM_fnc_MineMonitor}] call BIS_fnc_addStackedEventHandler;
	
	//Below is loop to check for new AI spawning in to be added to the list
	
	[] spawn
	{
		sleep 2;
		if (hasInterface) then
		{
			//Event handlers for players	
			player addEventHandler ["Fired",{_this call VCM_fnc_HearingAids;}];
			player spawn VCM_fnc_IRCHECK;
			player addEventHandler ["Respawn",{_this spawn VCM_fnc_IRCHECK;}];
			if (Vcm_PlayerAISkills) then {[] spawn VCM_fnc_PLAYERSQUAD;};
		};
		
		[] spawn VCM_fnc_AIDRIVEBEHAVIOR;
		[] spawn VCM_fnc_Scheduler;
	};
};