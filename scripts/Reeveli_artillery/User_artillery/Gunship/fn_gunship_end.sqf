/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, gunship support.
 * Function to handle final waypoint creating for gunship after the loitering ends.
 *
 * Arguments:
 * 0: Gunship crew group <GROUP>
 * 1: Final waypoint position <ARRAY> (default: [0,0,0])
 *
 * Return Value: NONE
 *
 * Example:
 * [_group,_fin_pos] call Rev_arty_fnc_gunship_end
 *
 */
params [
	["_group",grpNull,[grpNull]],
	["_fin_pos",[0,0,0],[[]],[2,3]]
];

//Deleting old waypoint(s)
for "_i" from count waypoints _group - 1 to 0 step -1 do
{
	deleteWaypoint [_group, _i];
};

//Adding end waypoint
private _wp3 = _group addWaypoint [_fin_pos, 0];
_wp3 setWaypointType "MOVE";
_wp3 setWayPointBehaviour "AWARE";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointStatements ["true", "_cleanUpveh = vehicle leader this;
									_cleanUpPos = position (vehicle leader this);
									(leader this) removeAllEventHandlers 'Killed';
									(leader this) removeAllEventHandlers 'Deleted';
									(vehicle leader this) removeAllEventHandlers 'Killed';
									(vehicle leader this) removeAllEventHandlers 'Deleted';
									
									[_cleanUpPos] spawn {
										sleep 0.1;
										{deleteVehicle _x} forEach (_this select 0 nearEntities [['rhs_vs1_seat','Car_F'], 25]);
										};
									{deleteVehicle _x} forEach crew _cleanUpveh + [_cleanUpveh];
									"];