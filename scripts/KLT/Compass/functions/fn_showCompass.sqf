
["864", "onEachFrame",{
  _sPos = screenToWorld [0.5,0.5];
	_pPos = getPos player;
	_dir = (((((_sPos select 0) - (_pPos select 0)) atan2 ((_sPos select 1) - (_pPos select 1))) + 360) % 360)/100;
  _stripe = 0.96 * safezoneW;
  _calc = ((_stripe/570) * _dir)* 100 + (_stripe/570) * 45;
  (GTX_compImg#0) ctrlSetPosition [_calc - _calc*2,-0.01,_stripe,1.8 * safezoneH];
  (GTX_compImg#0) ctrlSetText UGTX_imgCompImg;
  (GTX_compImg#0) ctrlCommit 0;
}] call BIS_fnc_addStackedEventHandler;
