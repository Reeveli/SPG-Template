/*
 * Author: Reeveli
 * Replace unit with an agent. Optionally sets ZEN ambient animation to agent. Execute on server. Can be used from editor.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Optional: ZEN animation number <NUMBER>
 * 2: Optional: Is animation combat ready <BOOL> (default: false)
 *
 * Return Value <BOOL>
 *
 * Example:
 * [this,7] spawn Rev_fnc_replaceWithagent;
 *
 * Animation list:
 * 1: SIT_LOW_1, SIT_LOW_2, SIT_LOW_3, SIT_LOW_4, SIT_LOW_5, SIT_LOW_6
 * 2: SIT_ARMED_1, SIT_ARMED_2, SIT_ARMED_3, SIT_ARMED_4
 * 3: SQUAT
 * 4: SQUAT_ARMED
 * 5: LEAN
 * 6: WATCH_1, WATCH_2
 * 7: STAND_1, STAND_2e 8: STAND_NO_WEAP_1, STAND_NO_WEAP_2, STAND_NO_WEAP_3, STAND_NO_WEAP_4, STAND_NO_WEAP_5
 * 9: STAND_PISTOL_1, STAND_PISTOL_2, STAND_PISTOL_3, STAND_PISTOL_4
 * 10: GUARD
 * 11: GUARD_KNEEL
 * 12: LISTEN_BRIEFING
 * 13: BRIEFING
 * 14: BRIEFING_INTERACTIVE_1, BRIEFING_INTERACTIVE_2
 * 15: LISTEN_CIV
 * 16: TALK_CIV
 * 17: LISTEN_TO_RADIO
 * 18: SHIELD_FROM_SUN
 * 19: NAVIGATE
 * 20: SHOWING_THE_WAY
 * 21: KNEEL_TREAT_1, KNEEL_TREAT_2
 * 22: PRONE_INJURED
 * 23: PRONE_INJURED_NO_WEAP_1, PRONE_INJURED_NO_WEAP_2
 * 24: LEAN_INJURED
 * 25: INJURY_HEAD
 * 26: INJURY_CHEST
 * 27: INJURY_ARM
 * 28: INJURY_LEG
 * 29: CIV_SHOCK
 * 30: CIV_HIDE
 * 31: SURRENDER
 * 32: CAPTURED_SIT
 * 33: REPAIR_VEH_STAND
 * 34: REPAIR_VEH_KNEEL
 * 35: REPAIR_VEH_PRONE
 * 36: DEAD_1, // DEAD_2, // DEAD_3, // DEAD_4, // DEAD_5, // DEAD_6, // DEAD_7, // DEAD_8, // DEAD_9
 * 37: DEAD_LEAN_1, DEAD_LEAN_2
 * 38: DEAD_SIT_1, DEAD_SIT_2, DEAD_SIT_3
 * 39: TABLE
 * 40: BINOCS
 * 41: SALUTE

 */
if !(isServer) exitWith {false};
params
[
	["_unit", objNull, [objNull]],
	["_animation", 0, [0]],
	["_combatReady", false, [false]]
];

params ["_unit"];

private _class = typeOf _unit;
private _pos = getposATL _unit;
private _direction = getDir _unit;

deleteVehicle _unit;

private _agent = createAgent [_class, _pos, [], 0, "CAN_COLLIDE"];
_agent setDir _direction;

if (_animation > 0) then {	
	if !(isClass (configFile >> "CfgPatches" >> "zen_modules")) exitWith {
		false;
		diag_log "Rev_fnc_replaceWithagent: Unable to use ZEN anmation, ZEN is not loaded!"
	};

	[_agent,_animation, _combatReady] spawn { 
		params ["_unit","_animation","_combatReady"];
		sleep 0.1; 
		[_unit, _animation, _combatReady] call zen_modules_fnc_moduleAmbientAnimStart; 
	};
	true;
};