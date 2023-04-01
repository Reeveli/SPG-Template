/*
By Reeveli 
This function forces a face from the selected list onto the player. No more Europeans playing as Asian dudes.
Called by [2] call Rev_fnc_camofaces, with the param being the list of faces.
Function must be called both when joining the server (handled by CBA addon settings) and after respawn (onPlayerRespawn)!

Params: 0 - Face type (list below)

0:  Disabled
1:  Caucasian fenotype
2:  Caucasian fenotype with camopaint
3:  Persian fenotype
4:  Persian fenotype with camopaint
5:  Asian fenotype
6:  Asian fenotype with camopaint
7:  African fenotype
8:  African fenotype with camopaint
9:  Greek fenotype
10: Greek fenotype with camopaint
11: Tanoan fenotype
12: Russian fenotype
13: Young Caucasian faces - Requires BabyFaces mod to be present

1.7
    Added code for respawn eventhandler, system is now self contained in this function
    Function description fixed
1.6
    Added Russian fenotype
1.5
    Added option for Baby Faces mod caucasians
1.4
    Added check for facewear removal, description updated
1.3
    Added Russian faces to caucasian list
1.2
    Changed OR to AND in line 53 
1.1
    Facelist now selected via param
*/


if (!hasInterface) exitWith {};
params [
	["_type",0,[0]]
];

private _handle = missionNamespace getVariable ["Rev_camofaces_eh",-1];
player removeEventHandler ["Respawn", _handle];

if (_type == 0) exitWith {};
private _unit = player;
private _face_list = [];


switch (_type) do {
    case 1: {_face_list = ["WhiteHead_01","WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10","RussianHead_1","RussianHead_2","RussianHead_3","RussianHead_4","RussianHead_5"]};
    case 2: {_face_list = ["CamoHead_White_01_F","CamoHead_White_02_F","CamoHead_White_03_F","CamoHead_White_04_F","CamoHead_White_05_F","CamoHead_White_06_F","CamoHead_White_07_F","WhiteHead_22_l","CamoHead_White_19_F","CamoHead_White_04_F"]};
    case 3: {_face_list = ["PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03"]};
    case 4: {_face_list = ["CamoHead_Persian_01_F","CamoHead_Persian_02_F","CamoHead_Persian_03_F"]};
    case 5: {_face_list = ["AsianHead_A3_01","AsianHead_A3_02","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_05","AsianHead_A3_06","AsianHead_A3_07"]};
    case 6: {_face_list = ["CamoHead_Asian_01_F","CamoHead_Asian_02_F","CamoHead_Asian_03_F"]};
    case 7: {_face_list = ["AfricanHead_01","AfricanHead_02","AfricanHead_03"]};
    case 8: {_face_list = ["CamoHead_African_01_F","CamoHead_African_02_F","CamoHead_African_03_F"]};
    case 9: {_face_list = ["GreekHead_A3_01","GreekHead_A3_02","GreekHead_A3_03","GreekHead_A3_04","GreekHead_A3_05","GreekHead_A3_06","GreekHead_A3_07","GreekHead_A3_08","GreekHead_A3_09"]};
    case 10: {_face_list = ["CamoHead_Greek_01_F","CamoHead_Greek_02_F","CamoHead_Greek_03_F","CamoHead_Greek_04_F","CamoHead_Greek_05_F","CamoHead_Greek_06_F","CamoHead_Greek_07_F","CamoHead_Greek_08_F","CamoHead_Greek_09_F"]};
    case 11: {_face_list = ["TanoanHead_A3_01","TanoanHead_A3_02","TanoanHead_A3_03","TanoanHead_A3_04"]};
    case 12: {_face_list = ["RussianHead_1","RussianHead_2","RussianHead_3","RussianHead_4","RussianHead_5"]};
    case 13: {_face_list = ["Bayh_Young","Burr_Young","Coburn_Young","Collins_Young","Campbell_Young","Dayton_Young","Dorgan_Young","Halliwell_Young","Johnson_Young","Martinez_Young","Kirby_Young","Reed_Young","Santorum_Young","Smith_Young","Snowe_Young","Kelly_Young","OConnor_Young","Byrne_Young","OBrien_Young","Walsh_Young","OSullivan_Young","Athanasiadis_Young","Baros_Young","Doukas_Young","Gikas_Young","Christou_Young","Kanelloupou_Young","Savalas_Young","Kerry_A_Young","Miller_Young"]};
    default {_face_list = ["WhiteHead_01","WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10"]};
};

if (!(face _unit in _face_list) AND !(_unit isKindOf "VirtualCurator_F")) then {
    [_unit, selectRandom _face_list] remoteExec ["setFace", 0, true]
};

private _index =  _unit addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
    [{[Rev_camofaces] call Rev_fnc_camofaces;}, [], 1] call CBA_fnc_waitAndExecute;
}];

missionNamespace setVariable ["Rev_camofaces_eh",_index,false];