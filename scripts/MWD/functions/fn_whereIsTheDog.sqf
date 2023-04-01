
_dog = player getVariable ["MWD_Dog", objNull];
if (isNull _dog) exitWith {};
_dir = player getDir _dog;
_dist = player distance _dog;
player groupChat format ["Riktning: %1 Avstånd: %2", round _dir, round _dist];