//Called by Call KLT_fnc_jammer;

	//Serverside
	params ["_object","_duration","_intensity"];
	if (!alive _object) exitwith {};

	CURRENT_JAMMERS pushback _object;														//Adds the Jammer to an list of other jammers.
	publicvariable "CURRENT_JAMMERS";


	_object setVariable ["Jamming_timerSwitch", true, true];
	private _Timerstate = _object getVariable ["Jamming_timerSwitch", false];


	[_object,_intensity] remoteexec ["KLT_fnc_Start_Jammer"];




	//Timer 
	[_duration, _object] spawn 
	{	
		params ["_duration", "_object"];
		private _Timerstate = _object getVariable ["Jamming_timerSwitch", false];		//Get the variablename from the object, returns false if undefined.

		if (alive _object) then 
		{
			waituntil {_Timerstate};
			sleep _duration;
			if (alive _object) exitwith 
			{
				[_object] remoteexec ["KLT_fnc_Terminate_Jammer",0]; 
				_object setVariable ["Jamming_timerSwitch", false, true];
				[_object] call KLT_fnc_Jammer_DeletefromArray;

			};
		};
	};


	//Loop To check if the Jammer is alive, if it isn´t it will terminate the Jamming.
	while {_Timerstate} do 
	{
		if (!alive _object) exitwith 
		{
			[_object] remoteexec ["KLT_fnc_Terminate_Jammer",0];
			_object setVariable ["Jamming_timerSwitch", false, true];
			[_object] call KLT_fnc_Jammer_DeletefromArray;
		};
		sleep 1;
	};