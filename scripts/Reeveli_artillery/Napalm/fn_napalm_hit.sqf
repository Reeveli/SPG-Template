/*
 * Author: Alias & Reeveli
 * Part of napalm system.
 * Handels napalm hits. Sever side script. Execute in scheduled environtment.
 * Original script "AL_fire\al_fire_deco.sqf"
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Fire duration <NUMBER> (default: 300)
 * 2: Fire effect diameter <NUMBER> (default: 60)
 * 3: Flame size <NUMBER> (default: 10)
 * 4: Buildign damage <NUMBER> (default: 0.5)
 * 5: Spawn smoke <BOOL> (default: true)
 * 5: Flame brightness <NUMBER> (default: 10)
 *
 * Return Value: <NONE>
 *
 * Example:
 * [_spot,_duration,60,10,0.5,true,10] remoteExec ["Rev_arty_fnc_napalm_hit",2,true];
 *
 */


if (!isServer) exitWith {};

params [
	["_source",objNull,[objNull]],
	["_duration",300,[0]],
	["_diameter",60,[0]],
	["_flame_size",10,[0]],
	["_damage",0.5,[0]],
	["_smoke",true,[false]],
	["_brightness",10,[0]]
];

//emit if source already emitting flames
if (!isNil {_source getVariable "on_alias_fire"}) exitWith {};
_source setVariable ["on_alias_fire",true,true];

//Additional scripts
[_source,_diameter,_flame_size,_brightness] remoteExec ["Rev_arty_fnc_napalm_fire",0,true];

//Vegetation damage
private _list_p = ["TREE","SMALL TREE","BUSH","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","FOREST"];
private _plants = nearestTerrainObjects [position _source,_list_p,5+_diameter/2,false];

if (count _plants >0) then 
{
	{
		[{params ["_plant"];_plant setDamage [1,false]; _plant enableSimulation false;}, [_x], (_duration/(count _plants))*_forEachIndex] call CBA_fnc_waitAndExecute;
	} forEach _plants
};


//Damage to buildings
private _list_b = ["BUILDING","HOUSE","CHURCH","CHAPEL","FUELSTATION","HOSPITAL","RUIN","BUNKER"];
_buildings = nearestObjects [position _source,_list_b,8+_diameter/2,false];
_buildings = _buildings - [_source];
if (count _buildings >0) then {{_x setDamage [(_damage + damage _x),false]} foreach _buildings};

while {(_source getVariable "on_alias_fire")&&(alive _source)} do 
{
		private _near_foc_footmobil = _source nearEntities ["CAManBase",5+_diameter];//"CAManBase" to avoid including animals for performance
		private _vehicles = nearestObjects [position _source,["LandVehicle"],5+_diameter/2,false];
		_vehicles = _vehicles - [_source];
		if (count _vehicles >0) then {{if (alive _x) then {[_x] call Rev_arty_fnc_napalm_vehicles}}foreach _vehicles};
		if (count _near_foc_footmobil >0) then 
		{
			{
				["ACE_fire_burn", [_x, 5]] call CBA_fnc_globalEvent;
			} foreach _near_foc_footmobil
		};
	sleep 5;
};