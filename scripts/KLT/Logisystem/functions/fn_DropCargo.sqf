// ex [heli1,2,100,true,true] call KLT_fnc_DropCargo;
params 
[
	["_obj",objnull],
	["_times",1],
	["_height",100],
	["_isflying",true],
	["_markersys",false],
	["_smoke",false]
];

[_obj,_times,_height,_isflying,_markersys,_smoke] spawn {

	
params 
[
	["_obj",objnull],
	["_times",1],
	["_height",100],
	["_isflying",true],
	["_markersys",false],
	["_smoke",false]
];

if (_isflying) then {_height = -20;};

private _acceptedCargo = 
[
	//"I_EAF_supplyCrate_F",
	"Land_WaterBottle_01_stack_F",
	"CargoNet_01_barrels_F",
	"Land_FoodSacks_01_cargo_brown_F",
	"CargoNet_01_box_F"
	//"B_CargoNet_01_ammo_F"
];



 

for "_i" from _times to 1 STEP -1 do 
{
	_cargo = selectrandom _acceptedCargo;
	[ 
 _cargo, 
 position _obj, 
 _height, 
 [0,0,-1.2], 
 _markersys,
 _smoke
] call KLT_fnc_paraDrop;
	sleep 0.5;
};

};