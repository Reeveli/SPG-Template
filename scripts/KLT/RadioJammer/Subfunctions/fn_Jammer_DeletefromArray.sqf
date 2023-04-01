//called by call KLT_fnc_Jammer_Deletefromarray;
	params ["_object"];
		//Find the _object in array and deletes it.
		private _objectString = str _object;
		private _Jamindex = CURRENT_JAMMERS find _objectString;
		CURRENT_JAMMERS deleteAT _Jamindex;
		publicvariable "CURRENT_JAMMERS";