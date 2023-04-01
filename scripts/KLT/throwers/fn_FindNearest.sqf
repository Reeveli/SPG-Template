KLT_fnc_findNearest = 
{
	private ["_target","_nearestUnit","_players","_sorted"];
	_target = _this select 0;
	_players = [];

	// Get array of actual players
		{
		if (isplayer _x) then
			{
			_players set [count _players,_x];
			};
		} foreach playableunits;

	// Sort
	_sorted = [_players,[],{_x distance _target},"ASCEND"] call BIS_fnc_sortBy;
	_nearestunit = _sorted select 0;
	_nearestunit
};