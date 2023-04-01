//Author: Killet 
//Description: Makes a check of the unit tag active on the player. will kick the player if the correct tag not is worn.
//Last Changed: 2019-09-05 by Killet

[] spawn {
if (isdedicated) exitwith {}; //Deactivate this line for debug. Makes sure the script doesn´t run while you edit your mission.
if (hasInterface) then {	//Runs the script on all clients but not headless clients.
private _unitTag = ["-SPG-"];		//The Unit tags that are allowed.

private ["_unit","_SPG_member"];
waitUntil { alive player };
sleep 1;
if !(Enforce_SPG_tag) exitWith {};
_unit = player;
_SPG_member = false;

		if ( !isNil "_unitTag" ) then {
			if ( count (squadParams _unit) != 0 ) then {
				if ( ((squadParams _unit select 0) select 0) in _unitTag) then {
					_SPG_member = true;
					systemchat "Welcome SPG member!";
				};};};

		if ( !(_SPG_member) ) then {
			sleep 1;
			if ( alive _unit ) then {
				endMission "End_spg";
			};
		};	
};
};






