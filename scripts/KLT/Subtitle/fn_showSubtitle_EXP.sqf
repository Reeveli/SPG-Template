/*
	Author: Thomas Ryan

	Description:
	Display the given subtitles at the correctly defined moments.

	Parameters:
		_this: ARRAY -
			_this select 0: STRING - Name of the person speaking.
			_this select 1: STRING - Subtitle to display.
			_this select 2: NUMBER - Time at which to display the subtitle.

	Returns:
	True if successful, false if not.
*/

// Global variable for terminating subtitles before they finish
BIS_fnc_EXP_camp_playSubtitles_terminate = false;

// Log the time at which the subtitles were called
private _start = time;

{
	_x params [
		["_name", "", [""]],
		["_subtitle", "", [""]],
		["_time", 1, [1]]
	];

	// Localize name and subtitle if necessary
	_name = _name call BIS_fnc_localize;
	_subtitle = _subtitle call BIS_fnc_localize;

	waitUntil {
		// Wait for the correct timestamp
		time - _start >= _time
		||
		// Or for the subtitles to be terminated
		BIS_fnc_EXP_camp_playSubtitles_terminate
	};

	// If necessary, terminate the loop and clear the subtitles
	if (BIS_fnc_EXP_camp_playSubtitles_terminate) exitWith {titleText ["", "PLAIN"]};

	// Display subtitle
	[_name, _subtitle, true] call KLT_fnc_showSubtitle;
} forEach _this;

true