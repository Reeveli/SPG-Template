/*
 * Author: Reeveli
 * Part of restricted zeus framework.
 * Function to configure vehicle vehicle attributes window for restricted zeus. Run only after dialog has been created.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value <NONE>
 *
 * Example:
 *	createDialog "Rev_RZ_vehicle_attributes";
 *	[_entity] call Rev_RZ_fnc_vehicle_dialog;
 *
 */

params [
	["_vehicle",objNull,[objNull]]
];

if !(hasInterface) exitWith {};
if (isNull _vehicle) exitWith {};

//Set control text
private _name =  (getText (configfile >> "CfgVehicles" >> typeof _vehicle >> "displayName"));
ctrlSetText [5081,_name];

//Set varibales for dialog
(findDisplay 5080) setVariable ["Rev_RZ_vehicle",_vehicle];

private _fuel = fuel _vehicle;
((finddisplay 5080) displayCtrl 5082) progressSetPosition _fuel;

private _fuel_text = linearConversion [0,1,_fuel,0,100,true];
((finddisplay 5080) displayCtrl 5082) ctrlSetTooltip (str (round _fuel_text) + "%");


private _ammo = [_vehicle] call zen_common_fnc_getVehicleAmmo;
((finddisplay 5080) displayCtrl 5083) progressSetPosition _ammo;

private _ammo_text = linearConversion [0,1,_ammo,0,100,true];
((finddisplay 5080) displayCtrl 5083) ctrlSetTooltip (str (round _ammo_text) + "%");

private _engine = isEngineOn _vehicle;
(finddisplay 5080) setVariable ["Rev_RZ_vehicle_engine",_engine];

private _lights = isLightOn _vehicle;
(finddisplay 5080) setVariable ["Rev_RZ_vehicle_lights",_lights];


if ((_vehicle getVariable ["Rev_RZ_vehicle_emcom",4]) > 3)  then {
	private _emcom = [2, 1] select isVehicleRadarOn _vehicle;
	(finddisplay 5080) setVariable ["Rev_RZ_vehicle_emcom",_emcom];
} else {
	private _emcom = _vehicle getVariable ["Rev_RZ_vehicle_emcom",0];
	(finddisplay 5080) setVariable ["Rev_RZ_vehicle_emcom",_emcom];
};
private _emcom = (findDisplay 5080) getVariable "Rev_RZ_vehicle_emcom";
((findDisplay 5080) displayCtrl 5088) lbSetCurSel _emcom;


private _data_send = vehicleReportRemoteTargets _vehicle;
(finddisplay 5080) setVariable ["Rev_RZ_vehicle_data_send",_data_send];
((findDisplay 5080) displayCtrl 5089) lbSetCurSel ([0,1] select _data_send);

private _data_receive = vehicleReceiveRemoteTargets _vehicle;
(finddisplay 5080) setVariable ["Rev_RZ_vehicle_data_receive",_data_receive];
((findDisplay 5080) displayCtrl 5090) lbSetCurSel ([0,1] select _data_receive);

private _data_pos = vehicleReportOwnPosition _vehicle;
(finddisplay 5080) setVariable ["Rev_RZ_vehicle_data_pos",_data_pos];
((findDisplay 5080) displayCtrl 5091) lbSetCurSel ([0,1] select _data_pos);

//False call to init colors
[6,0] call Rev_RZ_fnc_vehicle_button;