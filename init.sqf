if ((!isServer) && (player != player)) then {waitUntil {player == player};};
enableSaving [ false, false ];



call compile preprocessFile "scripts\KLT\Sandstorm\Init_Sandstorm.sqf";		//Killets Sandstorm
[] execVM "scripts\mwd\MWDInit.sqf";										//Military Working Dog


