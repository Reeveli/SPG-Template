/*
 * Author: Reeveli
 * Script side to create blackout by destroying light sources on buildings and objects. Function supports partial restoration of power after a blackout.
 * Note that not all lights can be restored, some are destroyed permanently during the blackout.
 * Function needs to be run globally (on server and each client).
 *
 * Arguments:
 * 0: Power state <BOOLEAN> (default: false) False to turn off lights. True to restore lights.
 * 1: Radius <NUMBER> (default: 1000) Range of the effect from origin point.
 * 2: Origin position <ARRAY> Origin point in 2d or 3d position format.
 *
 * Return Value: NONE
 *
 * Example:
 * [false,1000,getMarkerpos "blackout_pos"] remoteExec ["Rev_fnc_blackout",0,true]		- This example will cause a 1km radius blackout around map marker named 'example_marker'.
 * 
 * Uncompiled script:
 * [[true,1000,getpos example_object,"scripts\Reeveli_fnc\Rev_zeus\fn_blackout.sqf"] remoteExec ["execVM",0,true]		- This example will RESTORE lights (after the script has bene run previously) in 500m radius around object named 'example_object'.
 *
 * Notes:	
 * The object list on line 62 is by no means exhaustive. If you are placing down some objects in the editor that are not affected by the script you will have to add their classes yourself.
 * 

Changelog:

1.4
	Added server condition
	Removed unnecessary old _pos safety check (now handeled by parameter array size)
	Added diag_log print calling to client just in case
	Function header is now standard form
	Turned off damage effects insetHitIndex for some performance gains

1.3
	Added default params

1.2
	Turned into uncheduled environment compatible form with the use of CBA_fnc_waitAndExecute 

1.1
	Fixed some typos
	Better example line (forgot to mention remoteexec)
*/


params [
	["_power", false, [true]],
	["_range",1000,[0]],
	["_pos",nil,[[]],[2,3]]
];


private _damage = 1;
if (_power) then {_damage = 0} else {_damage = 0.95};




///////Some light objects that are not structures///////
//Since setDamage is global effect only needs to be run on server
if (isServer) then 
{
	private _types = ["Land_PortableHelipadLight_01_F","Land_Camping_Light_F","TentLamp_01_base_F","Land_PortableLight_single_F","Land_PortableLight_02_base_F","SearchLight_Base"];

	for [{_i=0},{_i < (count _types)},{_i=_i+1}] do
	{
		private _lamps = _pos nearObjects [_types select _i, _range];
		[{params ["_lamps"];{_x setDamage 1} forEach _lamps;}, [_lamps], 0.1] call CBA_fnc_waitAndExecute;   
	};
};

//Interface condition here as lightsources are local to each client, non-interface ones or not necessary
if !(hasInterface) exitWith {};

///////Main script for buildings with integral lightsources///////
//All possible buildings on range
private _structures = nearestObjects [_pos, ["house"], _range];

//Generating diag_log data to send back to caller
private _text = format ["Rev_fnc_blackout: %1 structures affected",(count _structures)];
diag_log _text;


//Internal functions
//Get light sources of a stucture
fnc_get_lights = {
	params ["_object"];
	private _return = ((getAllHitPointsDamage _object) select 0) select {"#" in _x};
	_return;
};

//Get hitPoint index for a light
fnc_get_index = {
	params ["_object","_light"];
	private _return = ((getAllHitPointsDamage _object) select 0) find _light;
	_return;
};

fnc_blackout = {
	params ["_structure","_damage"];

	//Safety check for dummy 'buildings'
	if (count (getAllHitPointsDamage _structure) isEqualTo 0) exitWith {};

	//Get light sources of a stucture
	private _lights = [_structure] call fnc_get_lights;

	//Safety check for buildings without lights
	if (count _lights isEqualTo 0) exitWith {};

	//Deal damage to lights
	{
		private _index = [_structure,_x] call fnc_get_index;
		for "_i" from 0 to (_index + 1) do {_structure setHitIndex [_i, _damage,false]};
	} forEach _lights;
};


//Main execution
{
	[{params ["_source","_damage"];[_source,_damage] call fnc_blackout;}, [_x,_damage], (_forEachIndex * 0.001)] call CBA_fnc_waitAndExecute;
} forEach _structures;

