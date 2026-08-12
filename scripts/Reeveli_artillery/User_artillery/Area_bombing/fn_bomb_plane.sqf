/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, area bombing ordnance.
 * Function to create the bomber plane. Arguments are provided by varibales created by the system earlier.
 *
 * Arguments: <NONE>
 *
 * Return Value: NONE
 *
 * Example:
 * [] spawn Rev_arty_fnc_bomb_plane
 *
 2.0
	Function substantiallu trunkated to unify zeus and curator functions
	Hashmap usage
 */
 

if (visibleMap) then {openMap false;};

private _targetPos = Rev_arty_bombData get "TargetPos";
private _bomb_type = Rev_arty_bombData get "BombType";
private _bomb_number = Rev_arty_bombData get "BombAmount";
private _direction = Rev_arty_bombData get "TargetDirection";
private _plane_type = Rev_arty_bombData get "PlaneClass";
private _plane_side = Rev_arty_bombData get "PlaneSide";
private _caller = Rev_arty_bombData get "Caller";


//Update ammo amount to server
["Rev_arty_BOM_regen",[_bomb_number]] call CBA_fnc_serverEvent; //Use 1 if tracking is to be done on sortie basis instead of ordnance


//Merge into same fnctions as zeus air strikes here
[_targetPos,_bomb_type,_bomb_number,_direction,_plane_type,_plane_side,_caller] remoteExec ["Rev_arty_fnc_zeus_bomber",2];

player setVariable ['Rev_arty_bom_call',nil];