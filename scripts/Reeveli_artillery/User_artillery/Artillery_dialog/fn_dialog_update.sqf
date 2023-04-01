/*
 * Author: Reeveli 
 * Part of Reeveli's Artillery system, user artillery.
 * Client side function to update the artillery dialog warning text. Called from onDraw eventhandler of the map control.
 * Called from ACE self-interaction, created in Rev_arty_fnc_player_init
 *
 * Return Value <BOOL>
 *
 * Example:
 * [ctrlText 6062,ctrlText 6063,ctrlText 6064,lbData [6065, lbCurSel 6065],lbCurSel 6065,ctrlText 6066,ctrlText 6067,((findDisplay 6060) displayCtrl 6068) lnbText [lnbCurSelRow 6068,0],lnbCurSelRow 6068,_control] call Rev_arty_fnc_dialog_update;
 *

1.0
	Initial version

Contents

Check selected ammo type
Delay
Amount
Is any TRP selected
Position
Range
Angle
Safety distance
HE
SMK
ILM
MIS + CLU
AIR
SUP
GUN
BOM
Safety check for max ammo expenditure

*/

params [
	["_location","XXXXXYYYYY",[""]],
	["_distance","500",[""]],
	["_bearing","0",[""]],
	["_target","",[""]],
	["_trp_index",0,[0]],
	["_delay","0",[""]],
	["_rounds_selected","3",[""]],
	["_round_type","",[""]],
	["_round_index",0,[0]],
	["_mapControl",controlNull,[controlNull]]
];

if !(hasInterface) exitWith {false};

private _display = findDisplay 6060;
private _ok = _display displayCtrl 6069;
private _warning = _display displayCtrl 6072;
private _underscore = _display displayCtrl 6071;

//Enable warning text color
_warning ctrlSetTextColor [0,0,0,1];


//Check if ammunition type is selected
if (_round_index < 0) exitWith {
	_ok ctrlEnable false;
	//_ok ctrlSetTooltip "Select round type from list";
	ctrlSetText [6072,"Select round type from list."];
	_underscore ctrlShow false;
	false;
};

//Check if delay is valid numbers
if (count (_delay splitString "0123456789") > 0) exitWith {					
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid rounds delay specified";
		ctrlSetText [6072,"Invalid rounds delay specified, use whole numbers only."];
		_underscore ctrlShow false;	
		false;
	};
//Check if delay is not empty
if (count _delay == 0) exitWith {						
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid rounds delay specified";
		ctrlSetText [6072,"Invalid rounds delay specified, must be atlaeast 0 (for instanteneous impacts). Use whole numbers only."];
		_underscore ctrlShow false;	
		false;
	};


//Check if amount is valid numbers
if (count (_rounds_selected splitString "0123456789") > 0) exitWith {						
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid rounds amount specified";
		ctrlSetText [6072,"Invalid rounds amount specified, use whole numbers only."];
		_underscore ctrlShow false;		
		false;
	};
//Check if amount is not empty
if (count _rounds_selected == 0) exitWith {							
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid rounds amount specified";
		ctrlSetText [6072,"Invalid rounds amount specified, use whole numbers only."];
		_underscore ctrlShow false;		
		false;
	};


//TRP Lisr
private _list_trp = [""];
//Get list of pre placed markers
{
	private _currMarker = toArray _x;
	if(count _currMarker >= 3) then 
	{
		_currMarker resize 3;
		_currMarker = toString _currMarker;
		if(_currMarker == "trp") then
			{_list_trp append [_x];}; 
	};
} foreach allMapMarkers;

//Check if any TRP is selected
if (_list_trp find _target == -1) exitWith {
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid designated target, use one from list";
		ctrlSetText [6072,"Invalid target reference point target, use one from list. Select 'None' if you do not wish to use any target reference point."];
		_underscore ctrlShow false;		
		false;
	};

//Set location data to correct form even if TRP is used to pass other checks
if ((_list_trp find _target > -1) AND !(_target isEqualTo "")) then {_location = "000000";};


//Check position
if (((count _location) % 2 != 0) OR (count _location < 6) OR (count _location > 10))
exitWith {		
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid observer location specified, provide 6, 8 or 10 grid reference";
		ctrlSetText [6072,"Invalid observer location specified, use 6, 8 or 10 grid reference."];
		_underscore ctrlShow false;		
		false;
	};	
//Check if position is valid numbers
if (count (_location splitString "0123456789") > 0) exitWith {			
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid observer location specified, use numbers only or TRP";
		ctrlSetText [6072,"Invalid observer location specified, use whole numbers only or select a target reference point."];
		_underscore ctrlShow false;		
		false;
	};


//Check if range is valid numbers
if (count (_distance splitString "0123456789") > 0 && _location != "000000") exitWith {				
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid target distance specified, use numbers only";
		ctrlSetText [6072,"Invalid target distance specified, use whole numbers only."];
		_underscore ctrlShow false;		
		false;
	};
//Check if range is not empty
if (count _distance == 0 && _location != "000000") exitWith {					
		_ok ctrlEnable false;
		_ok ctrlSetTooltip "Invalid target distance specified";
		ctrlSetText [6072,"Invalid target distance specified, use whole numbers only or select a target reference point."];
		_underscore ctrlShow false;		
		false;
	};



//Check if angle is valid numbers
if (count (_bearing splitString "0123456789") > 0 && _location != "000000") exitWith {					
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid target direction specified, use numbers only";
		ctrlSetText [6072,"Invalid target bearing specified, use whole numbers only or select a target reference point."];
		_underscore ctrlShow false;		
		false;
	};
//Check if angle is not empty
if (count _bearing == 0 && _location != "000000" ) exitWith {						
		_ok ctrlEnable false;
		//_ok ctrlSetTooltip "Invalid target direction specified";
		ctrlSetText [6072,"Invalid target bearing specified, use whole numbers only or select a target reference point."];
		_underscore ctrlShow false;		
		false;
	};


private _range = parseNumber _distance;
private _angle = parseNumber _bearing;
private _number = parseNumber _rounds_selected;
_delay = parseNumber _delay;
round _range;
round _angle;
round _number;
round _delay;


//Distance checks
private _start_pos = [_location, true] call CBA_fnc_mapControlGridToPos;
private _pos = _start_pos getPos [_range,_angle];


if !(_target isEqualTo "") then {_pos = getMarkerPos _target};
if (((getpos player) distance _pos) > Rev_arty_safety_dis) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,format ["You must call the fire mission to within %1m of your position.",round Rev_arty_safety_dis]];
	_underscore ctrlShow false;		
	false;
};




//Converting round type to uppercase since all legacy functions use them
_round_type = toUpperANSI _round_type;


//HE checks
//Safe distance of 100m relative to reported position in case of HE
if (((_start_pos distance _pos) < 100) AND (_round_type isEqualTo "HIGH EXPLOSIVE")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"You cannot call HE fire mission to within 100m of observer position."];
	_underscore ctrlShow false;		
	false;
};
//Check HE ammo availability
if ((_number > Rev_arty_HE_amount) AND (_round_type isEqualTo "HIGH EXPLOSIVE")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Selected ammunition usage exeeced availbale ordnanace of that type."];
	_underscore ctrlShow false;		
	false;
};

//Smoke checks
//Safety check for max expenditure amount
if ((_number > 12) AND (_round_type isEqualTo "WHITE SMOKE")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Safety limit exceeded, reduce barrage to maximum usage of 12 rounds!"];
	_underscore ctrlShow false;		
	false;
};
//Check smoke ammo availability
if ((_number > Rev_arty_SMK_amount) AND (_round_type isEqualTo "WHITE SMOKE")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Selected ammunition usage exeeced availbale ordnanace of that type."];
	_underscore ctrlShow false;		
	false;
};

//Illumination checks
//Check illumination ammo availability
if ((_number > Rev_arty_ILM_amount) AND (_round_type isEqualTo "ILLUMINATION")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Selected ammunition usage exeeced availbale ordnanace of that type."];
	_underscore ctrlShow false;		
	false;
};


//Missile checks
//Check Missile ammo availability
if ((Rev_arty_MIS_amount == 0) AND (_round_type isEqualTo "TACTICAL MISSILE")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No tactical missiles availbale."];
	_underscore ctrlShow false;		
	false;
};
//If more than 1 missile called
if ((_number > 1) AND (_round_type in ["TACTICAL MISSILE","CLUSTER MISSILE"])) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Only one missile can be launched at a time."];
	_underscore ctrlShow false;		
	false;
};
//Check if a previous missile is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_mis_call',nil]}) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Previous missile strike is still processing."];
	_underscore ctrlShow false;		
	false;
};
//Check if laser target
if ((count (_pos nearEntities ['LaserTarget', 100]) == 0) AND (_round_type in ["TACTICAL MISSILE","CLUSTER MISSILE"])) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No targeting laser found near the target position. Check your coordinates."];
	_underscore ctrlShow false;		
	false;
};
//Check cluster ammo availability
if ((Rev_arty_CLU_amount == 0) AND (_round_type isEqualTo "CLUSTER MISSILE")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No cluster missiles availbale."];
	_underscore ctrlShow false;		
	false;
};


//Air checks
//Check air ammo availability
if ((Rev_arty_AIR_amount == 0) AND (_round_type isEqualTo "AIR SUPPORT")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No tactical missiles availbale."];
	_underscore ctrlShow false;		
	false;
};
//If more than 1 air called
if ((_number > 1) AND (_round_type isEqualTo "AIR SUPPORT")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Only one air support plane can be called at a time."];
	_underscore ctrlShow false;		
	false;
};
//Check if a previous air support is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_air_call',nil]}) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Previous air strike is still processing."];
	_underscore ctrlShow false;		
	false;
};


//Supply checks
//Check air ammo availability
if ((Rev_arty_SUP_amount == 0) AND (_round_type isEqualTo "RESUPPLY")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No supply drops availbale."];
	_underscore ctrlShow false;		
	false;
};
//If more than 1 air called
if ((_number > 1) AND (_round_type isEqualTo "RESUPPLY")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Only one supply drop can be called at a time."];
	_underscore ctrlShow false;		
	false;
};
//Check if a previous supply drop is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_sup_call',nil]}) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Previous supply request is still processing."];
	_underscore ctrlShow false;		
	false;
};



//Gunship checks
//Check gunship availability
if ((Rev_arty_GUN_amount == 0) AND (_round_type isEqualTo "GUNSHIP")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No gunships available."];
	_underscore ctrlShow false;		
	false;
};
//If more than 1 air called
if ((_number > 1) AND (_round_type isEqualTo "GUNSHIP")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Only one gunship can be called at a time."];
	_underscore ctrlShow false;		
	false;
};
//Check if a previous gunship is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_gun_call',nil]}) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Previous supply request is still processing."];
	_underscore ctrlShow false;		
	false;
};



//Area bombing checks
//Check bombing availability
if ((Rev_arty_GUN_amount == 0) AND (_round_type isEqualTo "AREA BOMBING")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"No bombing runs available."];
	_underscore ctrlShow false;		
	false;
};
//If more than 1 bomber called
if ((_number > 1) AND (_round_type isEqualTo "AREA BOMBING")) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Only one bombing run can be called at a time."];
	_underscore ctrlShow false;		
	false;
};
//Check if a previous bomber is being called to avoid duplicate varibales being used
if !(isNil {player getvariable ['Rev_arty_gun_call',nil]}) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Previous bombing run is still processing."];
	_underscore ctrlShow false;		
	false;
};


//Safety check for max expenditure amount, left here at bottom to account for any ordnanace specific checks that might exists (like smoke)
if (_number > 20) exitWith {
	_ok ctrlEnable false;
	ctrlSetText [6072,"Safety limit exceeded, reduce barrage to maximum usage of 20 rounds!"];
	_underscore ctrlShow false;		
	false;
};


//Enable ok and set tooltip at the end of check
_ok ctrlEnable true;
_ok ctrlSetTooltip "Send support request";
_underscore ctrlShow true;
ctrlSetText [6072,"Ready to send!"];
_warning ctrlSetTextColor [0,0,0,0.3];


//return value
true;