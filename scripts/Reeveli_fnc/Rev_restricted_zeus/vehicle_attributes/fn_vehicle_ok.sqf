/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Button-press function for exit vehicle attributes dialog. Only run when dialog is open.
 *
 * Arguments: <NONE>
 *
 * Return Value <NONE>
 *
 * Example:
 *	call Rev_RZ_fnc_vehicle_ok
 *
 */

private _vehicle = (findDisplay 5080) getVariable "Rev_RZ_vehicle";

private _engine = (findDisplay 5080) getVariable "Rev_RZ_vehicle_engine";
//[[_vehicle],_engine] remoteExec ["engineOn",_vehicle];
//_vehicle engineOn _engine;
["ZEN_common_engineOn", [_vehicle, _engine], _vehicle] call CBA_fnc_targetEvent;

private _lights = (findDisplay 5080) getVariable "Rev_RZ_vehicle_lights";

["ZEN_common_setPilotLight", [_vehicle, _lights], _vehicle] call CBA_fnc_targetEvent;
["ZEN_common_setCollisionLight", [_vehicle, _lights], _vehicle] call CBA_fnc_targetEvent;

// Prevent AI from switching forced lights state
private _driver = driver _vehicle;

if !(isNull _driver || {isPlayer _driver}) then {
	["ZEN_common_disableAI", [_vehicle, "LIGHTS"], _vehicle] call CBA_fnc_targetEvent;
};

private _emcom = (findDisplay 5080) getVariable "Rev_RZ_vehicle_emcom";
_vehicle setVariable ["Rev_RZ_vehicle_emcom",_emcom];
//_vehicle setVehicleRadar _emcom;
["ZEN_common_setVehicleRadar", [_vehicle, _emcom], _vehicle] call CBA_fnc_targetEvent;

private _data_send = [false,true] select (lbCurSel 5089);
//_vehicle setVehicleReportRemoteTargets _data_send;
["ZEN_common_setVehicleReportRemoteTargets", [_vehicle, _data_send], _vehicle] call CBA_fnc_targetEvent;

private _data_receive = [false,true] select (lbCurSel 5090);
//_vehicle setVehicleReceiveRemoteTargets _data_receive;
["ZEN_common_setVehicleReceiveRemoteTargets", [_vehicle, _data_receive], _vehicle] call CBA_fnc_targetEvent;

private _data_pos = [false,true] select (lbCurSel 5091);
//_vehicle setVehicleReportOwnPosition _data_pos;
["ZEN_common_setVehicleReportOwnPosition", [_vehicle, _data_pos], _vehicle] call CBA_fnc_targetEvent;

closeDialog 1;