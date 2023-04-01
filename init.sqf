if ((!isServer) && (player != player)) then {waitUntil {player == player};};
enableSaving [ false, false ];
enableEnvironment [false,false];

/*
if (isClass (configFile >> "CfgPatches" >> "JNS_CANS")) then
	{
		[] execVM "scripts\klt\throwers\init_throwers.sqf";
	};
*/
call compile preprocessFile "scripts\KLT\Sandstorm\Init_Sandstorm.sqf";		//Killets Sandstorm
[] execVM "scripts\mwd\MWDInit.sqf";										//Military Working Dog


