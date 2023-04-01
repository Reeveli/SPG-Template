params ["_value"];

/*
0. FULL
1. Disabled
2. Syndicate Arsenal
3. Swedish winter
4. AOR 1 Desert (MLO)
5. MTP UK 
6. RHS UCP 
7. Vanilla Arma Nato 
8. RHS Woodland 
9. RHS Russia Gorka
10. Desert Marpat
11. US Multicam
*/


//No need to change below 
switch (_value) do {

case 0: {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\Killtes_arsenal_FULL.sqf";};
case 1:  {/*Disabled*/ };
case 2:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\Killets_Arsenal_Syndicat.sqf";};
case 3:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_winter_swe.sqf";};
case 4:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_Desert_AOR1.sqf";};
case 5:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_Desert_MTP.sqf";};
case 6:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_Desert_UCP.sqf";};
case 7:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_vanilla.sqf";};
case 8:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_rhswoodland.sqf";};
case 9:  {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_Russia_Gorka.sqf";};
case 10: {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_Desert_Marpat.sqf";};
case 11: {call compile preprocessFileLineNumbers "scripts\klt\arsenal_presets\killets_arsenal_Desert_Multicam.sqf";};
};


