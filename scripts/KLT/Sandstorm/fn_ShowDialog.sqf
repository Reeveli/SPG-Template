params ["_position","_unit"];


[
	"Create Sandstorm",
	[
		
		["SLIDER:PERCENT",["Intensity","Select intensity value between the defined min and max"],[0,1,0.5],false],
		["SLIDER",["Timer","Select the time in minutes the sandstorm should be active"],[0,180,5,0],false]
	],
	{
		params ["_results","_passed_arguments"];
		
		
		if ((isserver) && (!isdedicated)) then
			{
				[objNull, "Return copied to clipboard!"] call BIS_fnc_showCuratorFeedbackMessage;
				copyToClipboard str _results;
				systemChat str _passed_arguments;
			};

		private _time = 60 * (round (_results select 1));
		
		[_time,_results select 0] remoteexec ["klt_fnc_sandstorm",2];
	},
	{
		playSound "FD_Start_F";
		[objNull, "Dialog closed"] call BIS_fnc_showCuratorFeedbackMessage;
	},
	[
		_position,
		_unit
	]
] call zen_dialog_fnc_create;
