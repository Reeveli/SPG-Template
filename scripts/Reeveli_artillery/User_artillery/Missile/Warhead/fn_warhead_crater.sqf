/*
 * Author: Reeveli, based on code by ALIASCartoons
 * Function to create a traling particle effect originating from missile impact
 *
 * Arguments:
 * 0: Bomb center object <OBJECT>

 * Return Value: None
 *
 * Example:
 * [_bomb_center] call Rev_arty_fnc_warhead_crater;
 *
 */
params ["_bomb_center"];

private _objectsArray = [
	["Land_W_sharpRock_monolith",[-14.27,-16.4739,-13.6498],321.461,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[-23.4419,2.38379,-13.4566],352.82,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[4.27637,-25.9929,-12.877],280.397,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[-15.7915,20.5464,-12.8097],56.3615,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[1.97412,26.1787,-12.942],99.8636,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[20.9126,16.5122,-11.835],141.99,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[27.7241,-4.4563,-12.577],185.264,1,0,[],"","",true,false], 
	["Land_W_sharpRock_monolith",[20.334,-20.6758,-12.45],231.27,1,0,[],"","",true,false]
];


[getpos _bomb_center, 0, _objectsArray] call BIS_fnc_ObjectsMapper;

private _crater_obj = nearestObjects[_bomb_center,[],100];
{[_x, 0, -20] call BIS_fnc_setPitchBank} foreach _crater_obj;