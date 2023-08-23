/*
 * Author: Reeveli 
 * Main function for Reeveli's ACE unconscious moaning.
 * Client side function to create all necessary events and variables. Run as a postinit.

 1.1
	Added code to account for no voice during the initial check of each loop
 */

if (!hasInterface) exitWith {};
if !(Rev_moaning_enable) exitWith {};

//Setting voice profile at mission start to avoid extra calculations later, also for simplicity. Could be defied for each event loop but decided against
if (isNil {missionNamespace getVariable ["Rev_moaning_profile",nil]}) then {
	missionNamespace setVariable ["Rev_moaning_profile",selectRandom ["Person0","Person1","Person2","Person3"]];
};


//Hooking into ACE medical
["ace_unconscious", {
	params ["_unit"];
	if !(_unit == player) exitWith {};
	["Rev_moaning",[_unit,true]] call CBA_fnc_localEvent;

}] call CBA_fnc_addEventHandler;



//Main EH
["Rev_moaning", {
	params [
		["_unit", objNull, [objNull]],
		["_initial_call", false, [true]]
	];

	if !(_unit == player) exitWith {};
	if !(_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

	//Check for incoming double loops
	if ((cba_missiontime - (player getVariable ["Rev_moaning_check",0])) < Rev_moaning_time) exitWith {};


	//Voice randomisation
    private _randomVoice = missionNamespace getVariable ["Rev_moaning_profile","Person0"];
	private _person = switch _randomVoice do {
		case "Person0" : { "P0" };
		case "Person1" : { "P1" };
		case "Person2" : { "P2" };
		case "Person3" : { "P3" };
		default { "P0" };
	};
	private _array = ["01.wss","02.wss","03.wss","04.wss","05.wss","06.wss","07.wss","08.wss","09.wss"];

	switch _person do {
		case "P0" : {
						_array append ["10.wss","11.wss","12.wss"];
						if (Rev_moaning_speech) then {_array append ["13_words.wss","14_words.wss","15_words.wss","16_words.wss","17_words.wss","18_words.wss","19_words.wss","20_words.wss"];};
					};

		case "P1" : {
						_array append ["10.wss","11.wss","12.wss","13.wss","14.wss","15.wss","16.wss","17.wss","18.wss"];
						if (Rev_moaning_speech) then  {_array append ["19_words.wss","20_words.wss","21_words.wss","22_words.wss","23_words.wss","24_words.wss","25_words.wss","26_words.wss","27_words.wss","28_words.wss","29_words.wss","30_words.wss","31_words.wss","32_words.wss","33_words.wss"];};
					};

		case "P2" : {
						_array append ["10.wss","11.wss","12.wss","13.wss"];
						if (Rev_moaning_speech) then  {_array append ["14_words.wss","15_words.wss","16_words.wss","17_words.wss","18_words.wss","19_words.wss","20_words.wss","21_words.wss"];};
					};

		case "P3" : {
						if (Rev_moaning_speech) then {_array append ["13_words.wss","14_words.wss","15_words.wss","16_words.wss","17_words.wss","18_words.wss","19_words.wss","20_words.wss"];};						
					};
	};

	private _N = selectRandom _array;

	if ((random 100 <= Rev_moaning_probability) AND !(_initial_call)) then {
		//Playing sound
		playSound3D ["A3\Sounds_F\Characters\human-sfx\" + _randomVoice + "\" + _person + "_moan_" + _N, _unit, false, getPosASL _unit, 20, 1, Rev_moaning_range]; 
	};
	
	//Setting safety variable to prevent double loops
	player setVariable ["Rev_moaning_check",cba_missiontime];
	

	//Event looping
	[
		{
			params ["_unit"];
			["Rev_moaning",[_unit,false]] call CBA_fnc_localEvent;
		},
		[_unit],
		Rev_moaning_time
	] call CBA_fnc_waitAndExecute;

}] call CBA_fnc_addEventHandler;