/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, in-game briefing.
 * Client side function to create briefing entries for players. Called as a postinit function
 *
 * Arguments: <NONE>
 *
 * Return Value: NONE
 *
 * Example:
 * call Rev_fnc_dynamic_briefing
 *
 1.2
 	Deleted all refences to old dynamic webpage, iclusinf taking entire brieing put of spawn scope
	Added clustermissile, supplydrop, gunship support, area bombing to briefing
 1.1
	Removed outdated brieing page concerning the main UI
 */

if !( hasInterface ) exitWith {};
if !(Rev_arty_master_enable) exitWith {};

player createDiarySubject ["Rev_Arty","Reeveli's Artillery"];
private _b_text = "Available ordnance at mission start:<br/><br/>";
private _regen_text = "";

if ((
		Rev_arty_HE_regen +
		Rev_arty_SMK_regen +
		Rev_arty_ILM_regen +
		Rev_arty_MIS_regen +
		Rev_arty_CLU_regen +
		Rev_arty_AIR_regen +
		Rev_arty_SUP_regen +
		Rev_arty_GUN_regen +
		Rev_arty_BOM_regen
	) > 0) then {
	_regen_text = "<br/><br/>Regeneration times (in seconds):<br/><br/>";
};

//Processes to generate right hint text + choice option in dialog for all available ammo types
if (Rev_arty_HE_enabled) then {
		_b_text = _b_text + "High explosive: " + str Rev_arty_HE_amount_sys + "<br/>";

		if (Rev_arty_HE_regen > 0) then {
			_regen_text = _regen_text + "High explosive: " + str Rev_arty_HE_regen + "<br/>";
		};
	};

if (Rev_arty_SMK_enable) then {
		_b_text = _b_text + "White smoke: " + str Rev_arty_SMK_amount_sys + "<br/>";

		if (Rev_arty_SMK_regen > 0) then {
			_regen_text = _regen_text + "White smoke: " + str Rev_arty_SMK_regen + "<br/>";
		};
	};

if (Rev_arty_ILM_enable) then {
		_b_text = _b_text + "Illumination: " + str Rev_arty_ILM_amount_sys + "<br/>";

		if (Rev_arty_ILM_regen > 0) then {
			_regen_text = _regen_text + "Illumination: " + str Rev_arty_ILM_regen + "<br/>";
		};
	};

if (Rev_arty_MIS_enable) then {
		_b_text = _b_text + "Tactical missile: " + str Rev_arty_MIS_amount_sys + "<br/>";

		if (Rev_arty_MIS_regen > 0) then {
			_regen_text = _regen_text + "Tactical missile: " + str Rev_arty_MIS_regen + "<br/>";
		};
	};

if (Rev_arty_CLU_enable) then {
		_b_text = _b_text + "Cluster missile: " + str Rev_arty_CLU_amount_sys + "<br/>";

		if (Rev_arty_CLU_regen > 0) then {
			_regen_text = _regen_text + "Cluster missile: " + str Rev_arty_CLU_regen + "<br/>";
		};
	};

if (Rev_arty_AIR_enable) then {
		_b_text = _b_text + "Air support: " + str Rev_arty_AIR_amount_sys + "<br/>";

		if (Rev_arty_AIR_regen > 0) then {
			_regen_text = _regen_text + "Air support: " + str Rev_arty_AIR_regen + "<br/>";;
		};
		
	};

if (Rev_arty_SUP_enable) then {
		_b_text = _b_text + "Resupply drops: " + str Rev_arty_SUP_amount_sys + "<br/>";

		if (Rev_arty_SUP_regen > 0) then {
			_regen_text = _regen_text + "Resupply drops: " + str Rev_arty_SUP_regen + "<br/>";;
		};
		
	};

if (Rev_arty_GUN_enable) then {
		_b_text = _b_text + "Gunship support: " + str Rev_arty_GUN_amount_sys + "<br/>";

		if (Rev_arty_GUN_regen > 0) then {
			_regen_text = _regen_text + "Gunship support: " + str Rev_arty_GUN_regen + "<br/>";;
		};
		
	};

if (Rev_arty_BOM_enable) then {
		_b_text = _b_text + "Area bombing: " + str Rev_arty_BOM_amount_sys + "<br/>";

		if (Rev_arty_BOM_regen > 0) then {
			_regen_text = _regen_text + "Area bombing: " + str Rev_arty_BOM_regen + "<br/>";;
		};
		
	};


_b_text = _b_text + _regen_text;

player createDiaryRecord ["Rev_Arty", ["Available ordance", 
_b_text
]];
