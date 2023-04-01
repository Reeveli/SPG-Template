/*
 * Author: Reeveli 
 * Part of Reeveli's HALO system.
 * Client side function to start the HALO dialog.
 *
 * Arguments:
 * 0: HALO transport plane classname <STRING> (default: "B_T_VTOL_01_infantry_F")
 *
 * Return Value: <NONE>
 *
 * Example:
 * ["B_T_VTOL_01_infantry_F"] call Rev_fnc_halo_start;
 *
 1.1
	Old BIS_fnc_addStackedEventHandlers replaced with with missionEventhandlers    
 */

params [
	["_class","B_T_VTOL_01_infantry_F",[""]]
];


Rev_halo_plane_class = _class;
createdialog "Rev_halo_map";

private _spot = createMarkerLocal ["Rev_drop_zone",position player];
"Rev_drop_zone" setMarkerTextLocal "Drop zone";
"Rev_drop_zone" setMarkerShapeLocal "ICON";
"Rev_drop_zone" setMarkerTypeLocal "mil_end";
"Rev_drop_zone" setMarkerColorLocal "ColorBlue";
"Rev_drop_zone" setMarkerAlphaLocal 0;

private _id = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
    "Rev_drop_zone" setMarkerPosLocal _pos;
    "Rev_drop_zone" setMarkerAlphaLocal 1;
	ctrlEnable [4068, true];
}];
missionNameSpace setVariable ["halo_map_event",_id,false];


private _id2 = addMissionEventHandler ["EachFrame", {
    private _text = (([player] call Rev_fnc_transport_check) select 1) joinString "<br/>";
    private _disp = uiNamespace getVariable ["Rev_halo_list", DisplayNull]; 
    _disp ctrlSetStructuredText parseText _text;
}];
missionNameSpace setVariable ["halo_player_list",_id2,false];


private _name = getText (configFile >> "CfgVehicles" >> _class >> "displayname");
ctrlSetText [4061, _name];
private _plane_img = getText (configFile >> "CfgVehicles" >> _class >> "editorPreview");
ctrlSetText [4062, _plane_img];

private _img = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\cloudly_ca.paa";
if (overcast < 0.33) then {_img = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\clear_ca.paa"};
if (overcast > 0.66) then {_img = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\overcast_ca.paa"};
ctrlSetText [4063, _img];

private _temp = str (round (0 call ace_weather_fnc_calculateTemperatureAtHeight)) + " C";
private _wind_spd = str (round call ace_kestrel4500_fnc_measureWindSpeed) + " m/s";
private _wind_dir = str (round windDir) + " deg";

ctrlSetText [4064, ("Temperature: " + _temp)];
ctrlSetText [4065, ("Wind speed: " + _wind_spd)];
ctrlSetText [4066, ("Wind direction: " + _wind_dir)];
