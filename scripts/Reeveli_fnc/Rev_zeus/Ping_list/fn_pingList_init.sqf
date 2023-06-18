/*
 * Author: Reeveli
 * Part of Reeveli's curator ping list system.
 * Global function needed to initialise necessary eventhandlers for ping list system.
 * Run as postinit on all machines.
 *
 * Arguments: NONE
 *
 * Return Value: NONE
 *
 * Example:
 * [] call Rev_fnc_pingList_init
 *
1.2
	Major code rework to fix screenshotmode bug
	featureCamera EH is now savaed as a variable just in case
1.1
	Added for for ping list hide when using screenshot mode

 */


//Setting check
if !(Rev_ping_list_enable) exitWith {};

//Varibale and EH needed on all machines
missionNamespace setVariable ["Rev_pingList",[]];

//Eh to add ping event to curator modules
["ModuleCurator_F", "init", {
	param [0] addEventHandler ["CuratorPinged", {
		params ["_curator", "_player"];
		//Array management
		private _list = missionNamespace getVariable ["Rev_pingList",[]];
		if ((count _list) >= 3) then  {_list deleteAt 0};
		_list pushBack ([_player,daytime]);	
		missionNamespace setVariable ["Rev_pingList",_list];
		//If control open refresh after each ping
		if !(isNull ((findDisplay 312) displayCtrl 6084)) then {[(findDisplay 312) displayCtrl 6084] call Rev_fnc_pingList_onLoad};
	}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

//Only local needed from here
if !(hasInterface) exitWith {};



private _code = {
	if (isNUll (findDisplay 312)) exitWith {};
	if (player getVariable ["Rev_restricted_curator",false]) exitWith {};
	private _control = (findDisplay 312) ctrlCreate ["Rev_ping_list", -1];	

	//Hide pinglist if screenshotmode is active
	if (uiNamespace getVariable ["RscDisplayCurator_screenshotMode", false]) then {
		_control ctrlShow false;
	};

	(findDisplay 312) displayAddEventHandler ["KeyDown",{
		params ["_curatorDisplay", "_key"];
		if (inputAction "curatorToggleInterface" > 0) then {
			private _control = (uiNamespace getVariable ['Rev_ping_list_ctrlGroup',controlNull]);
			
			//general control group visibility
    		_control ctrlShow !(ctrlShown _control);
			//Visibility of three actual list controls as controlled by button
			if (ctrlShown _control) then {
				private _pingBackground= (uiNamespace getVariable ['Rev_Ping_list_bg',controlNull]);
				private _pingListFrame = (uiNamespace getVariable ['Rev_Ping_list_frame',controlNull]);
				private _pingList= (uiNamespace getVariable ['Rev_Ping_list_listbox',controlNull]);
				private _state = uiNamespace getVariable ["Rev_pinglist_visibility",true];
				_pingListFrame ctrlShow _state;
				_pingList ctrlShow _state;
				_pingBackground ctrlShow _state;
			};
		};
	}];
};

private _id = ["featureCamera", _code] call CBA_fnc_addPlayerEventHandler;
missionNamespace setVariable ["Rev_pingList_CBA_eh",_id];