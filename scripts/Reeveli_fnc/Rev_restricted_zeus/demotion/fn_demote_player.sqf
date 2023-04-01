//Development ceased for now, this function is not defined anywhere to avoid it being run

params [
	["_unit",objNull,[objNull]]
];

if !(hasInterface) exitWith {false};
if !(local _unit) exitWith {false};
if (isNull _unit) exitWith {false};

//Deleting stateMachine
[Resticted_Zeus_Machine] call CBA_statemachine_fnc_delete;

//Remove debugging ACE action
["CAManBase", 1,["ACE_SelfActions","RZ"]] call ace_interact_menu_fnc_removeActionFromClass;

//Context actions, no suitable way of restoring them has yet to be developed