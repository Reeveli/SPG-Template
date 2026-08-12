/*
 * Author: Reeveli 
 * Main function for Reeveli's ACE unconscious moaning.
 * Client side function to create all necessary events and variables. Run as a postinit.

2.0
	Function rewritten to enable side and language selection support
1.3
	Added alive check to prevent loop while waiting for respawn
1.2
	_soundSource is now vehicle _unit
	Fixed overly large volume value to 5

1.1
	Added code to account for no voice during the initial check of each loop
 */

if (!hasInterface) exitWith {};
if (!Rev_moaning_enable) exitWith {};

//Setting voice profile at mission start to avoid extra calculations later, also for simplicity. Could be defined for each event loop but decided against

//Voice randomisation
private _randomVoice = selectRandom ["Person0","Person1","Person2"];
private _person = switch _randomVoice do {
	case "Person0" : { ["P0","Male01","Person0"] };
	case "Person1" : { ["P1","Male02","Person1"] };
	case "Person2" : { ["P2","Male03","Person2"] };
	default { ["P0","Male01","Person1"] };
};
//Base moaning sounds
private _array_sounds = ["01.wss","02.wss","03.wss","04.wss","05.wss","06.wss","07.wss","08.wss","09.wss"];


//Assigning correct language protocol
private _language = switch (side player) do {
	case west : {Rev_moaning_speech_WEST};
	case east : {Rev_moaning_speech_EAST};
	case independent : {Rev_moaning_speech_IND};
	case civilian : {Rev_moaning_speech_CIV};
	default {Rev_moaning_speech_WEST};
};

//Adding person-randomised moans to pool + English callouts if used
switch _randomVoice do {
	case "Person0" : 	{
						_array_sounds append ["10.wss","11.wss","12.wss"];
						if (_language == "english") then  {_array_sounds append ["13_words.wss","14_words.wss","15_words.wss","16_words.wss","17_words.wss","18_words.wss","19_words.wss","20_words.wss"];};
						};

	case "Person1" : 	{
							_array_sounds append ["10.wss","11.wss","12.wss","13.wss","14.wss","15.wss","16.wss","17.wss","18.wss"];
							if (_language == "english") then  {_array_sounds append ["19_words.wss","20_words.wss","21_words.wss","22_words.wss","23_words.wss","24_words.wss","25_words.wss","26_words.wss","27_words.wss","28_words.wss","29_words.wss","30_words.wss","31_words.wss","32_words.wss","33_words.wss"];};
						};

	case "Person2" :	{
							_array_sounds append ["10.wss","11.wss","12.wss","13.wss"];
							if (_language == "english") then  {_array_sounds append ["14_words.wss","15_words.wss","16_words.wss","17_words.wss","18_words.wss","19_words.wss","20_words.wss","21_words.wss"];};
						};

};

//Setting non-English callout filepath
private _callout_path = "";
switch _language do {
	case "greek": {
		private _p = format ["%1gre",_person # 1];
		_callout_path = format ["A3\Dubbing_Radio_F\data\gre\%1\radioprotocolgre\Normal\140_Com_Status\",_p];
	};
	case "farsi": {
		private _p = format ["%1per",_person # 1];
		_callout_path = format ["A3\Dubbing_Radio_F\data\per\%1\radioprotocolper\Normal\140_Com_Status\",_p];
	};
	case "french": {
		private _p = format ["%1fre",_person # 1];
		_callout_path = format ["A3\Dubbing_Radio_F_EXP\data\FRE\%1\radioprotocolfre\Normal\140_Com_Status\",_p];
	};
	case "chinese": {
		private _p = format ["%1chi",_person # 1];
		_callout_path = format ["A3\Dubbing_Radio_F_EXP\data\CHI\%1\radioprotocolchi\Normal\140_Com_Status\",_p];
	};
	case "russian": {
		private _p = format ["%1rus",_person # 1];
		_callout_path = format ["A3\Dubbing_Radio_F_Enoch\data\RUS\%1\normal\140_Com_Status\",_p];
	};
	case "polish": {
		private _p = format ["%1pol",_person # 1];
		_callout_path = format ["A3\Dubbing_Radio_F_Enoch\data\POL\%1\normal\140_Com_Status\",_p];
	};
};

//Setting variables to be used in sound loops
missionNamespace setVariable ["Rev_moaning_sounds",_array_sounds,false];
missionNamespace setVariable ["Rev_moaning_filePath",_callout_path,false];
missionNamespace setVariable ["Rev_moaning_profile",_person,false];
missionNamespace setVariable ["Rev_moaning_language",_language,false];

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
	if !(alive player) exitWith {};
	if !(_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

	//Check for incoming double loops
	if ((cba_missiontime - (player getVariable ["Rev_moaning_check",0])) < Rev_moaning_time) exitWith {};

	private _array_sounds = missionNamespace getVariable ["Rev_moaning_sounds",["01.wss","02.wss","03.wss","04.wss","05.wss","06.wss","07.wss","08.wss","09.wss"]];
	private _filePath = missionNamespace getVariable ["Rev_moaning_filePath",""];
	private _profile = missionNamespace getVariable ["Rev_moaning_profile",["P1","Male01","Person0"]];
	private _language = missionNamespace getVariable ["Rev_moaning_language","none"];
	
	//Main probability and language checks
	if ((random 100 <= Rev_moaning_probability) AND !(_initial_call)) then {
		
			//1/3 chance for (non-english) medic call
			private _medicCallChance = [0, 2] call BIS_fnc_randomInt;
			if ((_medicCallChance == 2) AND !(_language in ["none","english"])) then {
				//Non-english medic call
				private _callout = selectRandom ["HealthIAmBadlyHurt.ogg","HealthIAmWounded.ogg","HealthINeedHelpNow.ogg","HealthInjured.ogg","HealthMedic.ogg","HealthNeedMedicNow.ogg","HealthSomebodyHelpMe.ogg"];
				playSound3D [Rev_moaning_filePath + _callout, vehicle _unit, false, getPosASL _unit, 5, 1, Rev_moaning_range]; 

			} else {		
				//moan sound, English callouts have been added to sound pool at init, other languages has only moans in pool
				private _N = selectRandom _array_sounds;
				playSound3D ["A3\Sounds_F\Characters\human-sfx\" + (_profile # 2) + "\" + (_profile # 0) + "_moan_" + _N, vehicle _unit, false, getPosASL _unit, 5, 1, Rev_moaning_range]; 
			};
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