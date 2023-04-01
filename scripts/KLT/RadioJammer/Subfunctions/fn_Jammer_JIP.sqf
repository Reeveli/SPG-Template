private _checker = CURRENT_JAMMERS findIf { _x == 0 } > -1;			//Checks if any jammers or anything at all is located in the CURRENT_JAMMERS array, if it is then something will happen. 
	if (_checker) then 
	
	{
		//Needs Fixing
		_object = CURRENT_JAMMERS select 0;


		private _Timerstate = _object getVariable ["Jamming_timerSwitch", false];		//Get the variablename from the object, returns false if undefined.
		if (_Timerstate) then 
		{
			[_object] call KLT_fnc_Start_Jammer;	
		};

	};