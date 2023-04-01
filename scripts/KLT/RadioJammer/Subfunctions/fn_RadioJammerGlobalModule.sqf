params [["_object",objnull]];
if (_object == objnull) exitwith {["No Object selected!"] call Achilles_fnc_showZeusErrorMessage};


private _dialogResult =
[
	"Create Radio Jammer",
	[
		// The last number is optional! If you want the first selection you can remove the number.
		["Radio Jam Range", "SLIDER", 0.5],
		["Radio Jam duration", "","600"]
	]
] call Ares_fnc_showChooseDialog;
// If the dialog was closed.
if (_dialogResult isEqualTo []) exitWith {};

// Get the selected data
_dialogResult params ["_intensity","_duration"];


if (count (_duration splitString "0123456789.") > 0) exitWith {
		playSound "FD_Start_F";["Invalid duration specified, use numbers only!"] call Achilles_fnc_showZeusErrorMessage
	};

_duration = parseNumber _duration;
if (_duration == 0) exitWith {["No duration selected!"] call Achilles_fnc_showZeusErrorMessage};



private _power = 1 - _intensity;

//Call your script
[_object,_duration,_power] remoteexec ["KLT_fnc_jammer",2];
hint "Starting jammer";


