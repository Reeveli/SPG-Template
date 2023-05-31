/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, gunship support.
 * Client side function to handle slider chnage on the loitering radius. Called from the dialog control
 *
 * Arguments:
 * 0: New loitering radius <NUMBER> (default: 1000)
 *
 * Return Value: NONE
 *
 * Example:
 * [_newValue] call Rev_arty_fnc_gunship_loiter
 *
 1.1.1
	Fixed wrong idd on ok button

 1.1
	Added code for directional arrows
	Added additional comments
 */

params [
	["_newValue",1000,[0]]
];

ctrlSetText [6042, format ['Loiterin Radius: %1M',round _newValue]];

//Circle marker
'Rev_arty_gun_area' setMarkerSizeLocal [_newValue, _newValue];


//directional arrows positions
'Rev_arty_gun_arrow_1' setMarkerPosLocal ((getMarkerPos "Rev_arty_gun_tgt") getpos [_newValue,180]);
'Rev_arty_gun_arrow_2' setMarkerPosLocal ((getMarkerPos "Rev_arty_gun_tgt") getpos [_newValue,300]);
'Rev_arty_gun_arrow_3' setMarkerPosLocal ((getMarkerPos "Rev_arty_gun_tgt") getpos [_newValue,60]);

if ((getMarkerPos 'Rev_arty_gun_dir') inArea 'Rev_arty_gun_area') exitWith {
	ctrlEnable [6046, true];ctrlShow [6046, true];ctrlSetText [6046, 'Position is too close to target! Select approach direction from outside the red circle.'];
	playSound 'FD_Start_F';
	'Rev_arty_gun_dir' setMarkerPosLocal [0,0,0];
	"Rev_arty_gun_dir" setMarkerAlphaLocal 0;
	ctrlEnable [6069, false];

	//directional arrows alphas
	'Rev_arty_gun_arrow_1' setMarkerAlphaLocal 0;
	'Rev_arty_gun_arrow_2' setMarkerAlphaLocal 0;
	'Rev_arty_gun_arrow_3' setMarkerAlphaLocal 0;
};