//Keeps tracks of players located inside the arsenal

DataTerminal setVariable [ "Users", [] ];
DataTerminal setVariable [ "Wait", false ];

KLT_fnc_useTerminal = {
	params[ "_state", "_user" ];

	waitUntil { !( DataTerminal getVariable [ "Wait", false ] ) };
	DataTerminal setVariable [ "Wait", true ];
	_users = DataTerminal getVariable [ "Users", [] ];

	switch ( _state ) do {
		case "Open" : {
			_isInUse = count _users > 0;
			_nul = _users pushBack _user;
			DataTerminal setVariable [ "Users", _users ];

			if !( _isInUse ) then {
				[ DataTerminal, 3 ] call BIS_fnc_dataTerminalAnimate;
				waitUntil{ DataTerminal animationPhase "Wifi_cover_fakehide_1" isEqualTo 3 };
			};
			
		};
		case "Close" : {
			_users = _users - [ _user ];
			DataTerminal setVariable [ "Users", _users ];
			_isInUse = count _users > 0;

			if !( _isInUse ) then {
				[ DataTerminal, 0 ] call BIS_fnc_dataTerminalAnimate;
				waitUntil{ DataTerminal animationPhase "Wifi_cover_fakehide_1" isEqualTo 0 };
			};
		};
	};

	DataTerminal setVariable [ "Wait", false ];

};


