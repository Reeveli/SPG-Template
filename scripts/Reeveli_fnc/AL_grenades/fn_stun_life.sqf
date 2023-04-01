/*
 * Author: ALIAS & Reeveli
 * General handling of custom flashbang.
 *
 * Arguments:
 * 0: Grenade <PROJECTILE>
 *
 * Return Value: None
 *
 * Example:
 * [_projectile] spawn AL_fnc_stun_life;
 *
 1.3
	Reworked entire script
	New in-line function
	Removed injured sound effect when AI is affected by the grenade
	ClientID variable removed as unnecessary, object used instead for remote execution
	Variables are privated the 'normal' way
	Flash duration is now hard set here instead of using CBA options due to earlier problems
	New animation for flash exit
 1.2
	Added condition to prevent player surrendering from flashbangs
 1.1
	privated _ClientID
	Added new conditions to final loop to surrender target is players are present and near
 */

params ["_grenade"];

fnc_flash_conditions = {
	params ["_unit"];
	if !(alive _unit) exitWith {false};
	if (_unit in (call CBA_fnc_players)) exitWith {false};
	if !(vehicle _unit == _unit) exitWith {false};
	if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {false};
	if (_unit getVariable ["ace_captives_isSurrendering",false]) exitWith {false};
	if (_unit getVariable ["ace_captives_isHandcuffed",false]) exitWith {false};
	if (_unit getVariable ["ace_captives_isEscorting",false]) exitWith {false};
	true;
};

sleep 2;
private _players = call CBA_fnc_players;
[_grenade] remoteExec ["AL_fnc_stun_grenade",_players];

private _near_units = _grenade nearEntities ["CAManBase",10];
if (count _near_units > 0) then 
{
	{
		if ([_x] call fnc_flash_conditions) then 
		{
			_x disableAI "ALL";
			private _move = selectRandom ["ApanPknlMstpSnonWnonDnon_G02","ApanPknlMstpSnonWnonDnon_G01","ApanPknlMstpSnonWnonDnon_G03"];
			[_x, _move] remoteExec ["switchMove",0];
		}
	} foreach _near_units
};
sleep 0.2;	
deleteVehicle _grenade;
sleep 5;
{
	if ([_x] call fnc_flash_conditions) then
	{
		if (([_x] call Rev_fnc_check_los_players) && ([_x,5] call Rev_fnc_check_distance_players)) then 
		{
			[_x, true] call ACE_captives_fnc_setSurrendered;
		} else {
			[_x, "AmovPknlMstpSlowWrflDnon"] remoteExec ["switchMove",0];
			_x enableAI "ALL";
		};
	};
} foreach _near_units;