params ["_restrict"];
//No need to change below 
switch (_restrict) do {
case 0: {/*Disabled*/};
case 1: {[] spawn KLT_fnc_KLTRestrict;};
};