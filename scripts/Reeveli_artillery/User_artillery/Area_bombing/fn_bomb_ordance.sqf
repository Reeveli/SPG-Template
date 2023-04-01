/*
 * Author: Reeveli
 * Create bombs relative to plane position, bomb type defined by global variable Rev_air_bomb_type
 *
 * Arguments:
 * 0: Group leader <OBJECT>
 * 1: Exit radio callout <BOOLEAN> (default: false)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [_groupLeader] remoteExecCall ['Rev_arty_fnc_bomb_ordance',2]
 *
 1.5
	Linear pattren is now neutered, left as legacy
 1.4.1
	New param and code to add completion radio callout if from user artillery system
 1.4
	(Re)added code for napalm
 1.3
	Removed randomness from bomb dispersal sleep for consistency
	Pattern spread added
 1.2
	Code cleanup
	Some varibales are now extracted from objectNameSpace
 1.1
	_bank removed as unnecessary
	Added alternative code for bomb velocity, legacy left as backup
 */


if (!isServer) exitWith {false};

params [
	["_groupLeader",objNull,[objNull]],
	["_radio",false,[false]]
];

if (isNull _groupLeader) exitWith {diag_log "Rev_arty_fnc_bomb_ordance: objNull as param";false;};

private _plane = vehicle _groupLeader;
private _class = _plane getVariable ["Rev_air_bomb_type","Bo_Mk82"];
private _amount = _plane getVariable ["Rev_air_bomb_amount",2];
//private _pattern = _plane getVariable ["Rev_air_bomb_pattern","Linear"];



////////Radio////////
if ((isMultiplayer) AND (isClass (configFile >> "CfgPatches" >> "tfar_handhelds")) AND _radio) then 
{
	//Check if user has radio (needed for sideradio command)
	private _condition = {getNumber (configfile >> "CfgWeapons" >> _x >> "tf_radio") != 0};
	private _initial_radio = true;
	if (_condition count assignedItems player == 0) then {
		_initial_radio = false;
		player linkItem "tf_anprc148jem";
		[{params ["_condition","_initial_radio","_killed"];_condition count assignedItems player > 0}, {[_this select 1,"Bombing",_this select 2] call Rev_arty_fnc_user_completed}, [_condition,_initial_radio,false],5] call CBA_fnc_waitUntilAndExecute;
	} else {[_initial_radio,"Bombing",false] call Rev_arty_fnc_user_completed};
};
/////////////////////





//Master value for napalm duration
private _duration = 255;


//Case horizontal pattern
//Old condition (_pattern isEqualTo "Horizontal")
if (false) then
{
	//Spread, add some randomness to bomb bank for horizontal spread
	private _spread = 20;
	private ["_bomb","_dir"];
	for "_i" from 0 to (_amount - 1) do
	{
		//Setting bomb class
		_bomb = (["Bo_Mk82","BombCluster_01_Ammo_F"] select (_class isEqualTo "BombCluster_01_Ammo_F")) createvehicle ([getPosATL _plane select 0,getPosATL _plane select 1,(getPosATL _plane select 2)-5]);
		//if even nuber of bombs
		if (_amount % 2 == 0) then {
			_dir = ((_amount - 1 ) * (_spread/2)) - (_i * _spread);
			_bomb setdir ((getDir _plane) + _dir);
		} else
		//if odd number of bombs
		{
			_dir = ((floor (_amount/2)) * _spread) - (_i * _spread);
			_bomb setdir ((getDir _plane) + _dir);
		};		
		[_bomb, random [-40, -45, -50], 0] call BIS_fnc_setPitchBank;
		_bomb setVelocity [10, 0, -150];

		//Case napalm
		if (_class == "napalm") then 
		{			
			[
				{((getposATL (_this select 1)) select 2) < 15},
				{
					params [
						["_groupLeader",objNull,[objNull]],
						["_bomb",objNull,[objNull]],
						["_duration",300,[0]]
					];
					//create impact object
					private _impact = [(getPos _bomb) select 0, (getPos _bomb) select 1];
					private _spot = "Land_HelipadEmpty_F" createVehicle [_impact select 0,_impact select 1,0];
					private _flow = (getposasl _spot vectorFromTo getposasl _groupLeader) vectorMultiply 5;
					private _dir_x = 5*(_flow select 0);
					private _dir_y = 5*(_flow select 1);

					//delete bomb model
					deletevehicle _bomb;

					//effect and SFX scripts
					[_spot,_duration,60,10,0.5,true,10] remoteExec ["Rev_arty_fnc_napalm_hit",2,false];
					[_spot,_dir_x,_dir_y] remoteExec ["Rev_arty_fnc_napalm_effect",0,true];
					
					//delete helipad in the future to remove fire effects
					[{deletevehicle (_this select 0)}, [_spot], _duration+(random 120)] call CBA_fnc_waitAndExecute;

				},
				[_groupLeader,_bomb,_duration],
				10
			] call CBA_fnc_waitUntilAndExecute;
		};
	};
} else
//case linear pattern
{
	private ["_bomb"];
	for "_i" from 0 to _amount -1 do
	{
		[
			{
				params ["_plane","_class","_groupLeader","_duration"];
				//Setting bomb class
				_bomb = (["Bo_Mk82","BombCluster_01_Ammo_F"] select (_class isEqualTo "BombCluster_01_Ammo_F")) createvehicle ([getPosATL _plane select 0,getPosATL _plane select 1,(getPosATL _plane select 2)-5]);
				_bomb setdir getDir _plane;
				[_bomb, -45, 0] call BIS_fnc_setPitchBank;
				_bomb setVelocity [10, 0, -150];
				
				//Case napalm
				if (_class == "napalm") then 
				{
					[
						{((getposATL (_this select 1)) select 2) < 15},
						{
							params [
								["_groupLeader",objNull,[objNull]],
								["_bomb",objNull,[objNull]],
								["_duration",300,[0]]
							];
							//create impact object
							private _impact = [(getPos _bomb) select 0, (getPos _bomb) select 1];
							private _spot = "Land_HelipadEmpty_F" createVehicle [_impact select 0,_impact select 1,0];
							private _flow = (getposasl _spot vectorFromTo getposasl _groupLeader) vectorMultiply 5;
							private _dir_x = 5*(_flow select 0);
							private _dir_y = 5*(_flow select 1);

							//delete bomb model
							deletevehicle _bomb;
							
							//effect and SFX scripts
							[_spot,_duration,60,10,0.5,true,10] remoteExec ["Rev_arty_fnc_napalm_hit",2,false];
							[_spot,_dir_x,_dir_y] remoteExec ["Rev_arty_fnc_napalm_effect",0,true];
							
							//delete helipad in the future
							[{deletevehicle (_this select 0)}, [_spot], _duration+(random 120)] call CBA_fnc_waitAndExecute;

						},
						[_groupLeader,_bomb,_duration],
						10
					] call CBA_fnc_waitUntilAndExecute;
				};
			},
			[_plane,_class,_groupLeader,_duration],
			0.35 * _i
		] call CBA_fnc_waitAndExecute;
	};
};

true;