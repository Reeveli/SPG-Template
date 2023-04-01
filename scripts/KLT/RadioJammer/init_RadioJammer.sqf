//Register Modules on clients and check if they are JIP
if (hasinterface) then 
{
	if (didJIP) exitwith {[] call KLT_fnc_Jammer_JIP;};
};

//Init Variables  on the server
if (isServer) then 
{
	CURRENT_JAMMERS = [];
	publicvariable "CURRENT_JAMMERS";
};
 






