//Compass position switch by Reeveli

if (UGTX_posTop) then {
	{
		_x ctrlSetPosition [(ctrlPosition _x) select 0, 0.93 * safezoneH + safezoneY, (ctrlPosition _x) select 2, (ctrlPosition _x) select 3];
		_x ctrlCommit 0.1;
	} forEach [(GTX_ctrlGrp#0), (GTX_compNeed#0), (GTX_grpBg#0)];
	UGTX_posTop = false;
} else {
	{
		_x ctrlSetPosition [(ctrlPosition _x) select 0, 0.01111 * safezoneH + safezoneY, (ctrlPosition _x) select 2, (ctrlPosition _x) select 3];
		_x ctrlCommit 0.1;
	} forEach [(GTX_ctrlGrp#0), (GTX_compNeed#0), (GTX_grpBg#0)];
	UGTX_posTop = true;
};