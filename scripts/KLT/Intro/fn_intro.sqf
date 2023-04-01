/*
	Script to run intro video on the start of the mission.
*/

////////////////FILL IN THE STRINGS IN THIS SECTION///////////////////////////////////////////////////////////////////////
																														//
//private _introPath = "\media\SPG Flattire.ogv";			//The path to your intro video				
private _introPath = "\media\Snakes Head.ogv";									// Add Introvideo path here
private _introtextActive = true;							//Adds dynamic text with the SPG logo on the top right		//
if (_introtextActive) then {								//Below will only run if the above variable is true..		//
Introtext1 = "Anizay Airfield";					//The first text											//
Introtext2 = "2022-02-10";						//The Second text											//
Introtext3 = "Operation Snakes Head";					//The third text											//
};																														//
_skipallowance = ["76561197982906568"];			//Players who should be allowed to skip the intro
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private _adminState = call BIS_fnc_admin;
if ((getPlayerUID player in _skipallowance) || (_adminState != 0)) then 
{  
skipvid = true;
_SkipvideoState = {missionNamespace setVariable ["BIS_fnc_playVideo_skipVideo", true]; skipvid = false};
_skip = ["Mission Stage","Skip Intro","",_Skipvideostate,{skipvid}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _skip] call ace_interact_menu_fnc_addActionToObject;
};



//Prevent shooting 
_Fireforbid = player addEventHandler ["fired", {deleteVehicle (_this select 6); hint "Do not discharge your rifle during the intro."; player removeEventHandler ["fired", _thisEventHandler];}];


//DO NOT EDIT BELOW
_clientDidJIP = didjip;		
if (_clientDidJIP) then 
	
	{
		[ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_lockSafety;
		player enablesimulation false;
		
		waitUntil {sleep .5; getClientState == "BRIEFING READ"};
		sleep 2;

		
		eventHandler = (findDisplay 46) displayAddEventHandler ["KeyDown",{if ((_this select 1) isEqualTo 1) then
			{
				missionNamespace setVariable ["BIS_fnc_playVideo_skipVideo", true];
				(findDisplay 46) displayRemoveEventHandler ["KeyDown", eventHandler];
			}
		}];


		[ missionNamespace, "BIS_fnc_playVideo_stopped", {
			[ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_unlockSafety;
		}] call BIS_fnc_addScriptedEventHandler;


		[] spawn {
		waitUntil {!isNull (findDisplay 46)};
		(findDisplay 46) displayAddEventHandler ["KeyDown",
		{
		params ["_display", "_key", "_shift", "_ctrl", "_alt"];
			if (_key in actionKeys "showMap") then
			{
				if !((player isKindOf "MAN") ) then
				{
					true;
				} else
				{};};}];
		};


		play = [_introPath] spawn BIS_fnc_PlayVideo; 
		waitUntil {scriptDone play}; 
		sleep 2;
		player enablesimulation true;
		skipvid = true;
	

		

	} else 
		{
		
			player enablesimulation false;
			play = [_introPath] spawn BIS_fnc_PlayVideo;
			waitUntil {scriptDone play}; 
			sleep 2;
			player enablesimulation true;
			skipvid = true;
		};





if (_introtextActive) then {
	
["img\spglogo.paa", [1.3,-0.4,0.4,0.5]] spawn BIS_fnc_textTiles;

[ 
 [ 
  [Introtext1, "<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t><br/>"], 
  [Introtext2, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"], 
  [Introtext3, "<t align = 'center' shadow = '1' size = '0.7'>%1</t>", 15] 
 ], 
 safeZoneY + safeZoneH / 1.3,
 safeZoneY + safeZoneH / 1.2 
] spawn BIS_fnc_typeText;


};

player removeEventHandler ["fired", _Fireforbid];