////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 11/5/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_checkLineOfFire2D.sqf
//  DESCRIPTION: Returns false if one obstalce of a given list is too close to the line of fire; true otherwise
//				 Only considers a 2D problem, z-components are neglected
//
//	ARGUMENTS:
//	_this select 0:		OBJECT	- shooter
//	_this select 1:		OBJECT	- target to shoot
//	_this select 2:		ARRAY	- obstacles in format OBJECT
//  _this select 3:		SCALAR	- minimal distance between obstacle and line of fire
//
//	RETURNS:
//	_this:				BOOL	- Returns false if one obstalce of a given list is too close to the line of fire; true otherwise
//
//	Example:
//	[_shooter,_target,[_obstacle_1,_obstacle_2],2] call Achilles_fnc_checkLineOfFire2D; //returns true or false
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_shooter", "_target", "_obstacles", "_minimal_radius"];

private _shooter_pos = position _shooter;
private _fire_line_vec = (position _target) vectorDiff _shooter_pos;

private _free_line_of_fire = true;
{
	private _obstacle_pos = position _x;
	private _shooter_obstacle_vec = _obstacle_pos vectorDiff _shooter_pos;
	private _obstacle_fire_line_dist = vectorMagnitude (_fire_line_vec vectorCrossProduct _shooter_obstacle_vec) / (vectorMagnitude _fire_line_vec);
	private _projection_product = _fire_line_vec vectorDotProduct _shooter_obstacle_vec;
	if ((_projection_product > 0) and (_obstacle_fire_line_dist < _minimal_radius)) exitWith {_free_line_of_fire = false;};

} forEach _obstacles;

_free_line_of_fire