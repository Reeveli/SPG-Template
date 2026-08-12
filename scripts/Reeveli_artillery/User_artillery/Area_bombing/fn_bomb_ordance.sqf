/*
 * Author: Reeveli
 * Part of Reeveli's Artillery system, area bombing.
 * Server side function to handle actual bomb creation.
 * Called from waypoint created in Rev_arty_fnc_zeus_bomber
 *
 * Arguments:
 * 0: Group leader <OBJECT>
 * 1: Exit radio callout <BOOLEAN> (default: false)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [this] spawn Rev_arty_fnc_bomb_ordance
 *
2.0
	Compeltely new code for linear pattern
 */


if (!isServer) exitWith {false};

params [
	["_groupLeader",objNull,[objNull]],
	["_radio",false,[false]]
];

if (isNull _groupLeader) exitWith {diag_log "Rev_arty_fnc_bomb_ordance: objNull as param";false;};

private _plane = vehicle _groupLeader;
private _caller = _plane getVariable ["Rev_air_bomb_caller",objNull];
private _targetPos = _plane getVariable ["Rev_air_bomb_target",nil];
private _class = _plane getVariable ["Rev_air_bomb_type","Bo_Mk82"];
private _amount = _plane getVariable ["Rev_air_bomb_amount",2];
private _direction = _plane getVariable ["Rev_air_bomb_direction",0];

if (_plane isNil "Rev_air_bomb_target") exitWith {diag_log "Rev_arty_fnc_bomb_ordance: No target!";false;};

//Radio call on exit for player
if !(isNull _caller) then {
	["Bombing",false] remoteExec ["Rev_arty_fnc_user_completed",_caller];
};

private _group = createGroup [sideLogic, true];
private _logic = _group createUnit ["Logic", [_targetPos # 0,_targetPos # 1], [], 0, "NONE"];
_logic setdir _direction;
_plane setVariable ["Rev_air_bomb_logic",_logic,false];


//case linear pattern
private ["_bomb"];
for "_i" from 0 to _amount -1 do
{
	[
		{
			params ["_plane","_class","_caller","_groupLeader","_targetPos","_direction","_index","_amount","_logic"];

			private _code = "";
			//Case napalm
			if (_class == "napalm") then {
				_class = "Bo_Mk82";
				_code = "_this # 1 spawn Rev_arty_fnc_bomb_incendiary";
			};

			//Spread pattern
			private _spacing = 50;
			private _offSet = (_index * _spacing) + -1 * (((_amount - 1)* _spacing) / 2);
		
			// Spawn the bomb
			private _bomb = createVehicle [_class, _plane modelToWorld [0, 0, -3], [], 0, "FLY"];		
			// Align the bomb with the plane and give it the plane's exact forward momentum
			_bomb setVectorDirAndUp [vectorDir _plane, vectorUp _plane];
			_bomb setVelocity (velocity _plane);
			_bomb setShotParents [_caller, _caller];

			//Guidance
			private _pos = _plane modelToWorld [0, 0, -3];
			[
				_pos,
				_bomb,
				_logic,
				(3.6 * ((velocityModelSpace _plane select 1) / 4)),
				false,
				[0,_offSet,0],
				50,
				_code,
				false
			] spawn BIS_fnc_exp_camp_guidedProjectile;

		},
		[_plane,_class,_caller,_groupLeader,_targetPos,_direction,_i,_amount,_logic],
		0.35 * _i
	] call CBA_fnc_waitAndExecute;
};


true;