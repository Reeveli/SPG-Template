//====================================================================================================================================================

params[ "_mode", "_object" ];

switch ( toUpper _mode ) do {
	
	//Initialise holdAction
	case "POSTINIT" : {
		if !( isServer ) exitWith {};
		//Add Intel names
		[ "TASKCALLONE", computer] remoteExec [ "KLT_fnc_handleHoldAction", [ 0, -2 ] select isDedicated, "intelActionJIP_ID" ];
		//[ "TASKCALLTWO", inteldoc] remoteExec [ "KLT_fnc_handleHoldAction", [ 0, -2 ] select isDedicated, "intelActionJIP_ID_TWO" ];
		//[ "TASKCALLTHREE", HVT ] remoteExec [ "KLT_fnc_handleHoldAction", [ 0, -2 ] select isDedicated, "intelActionJIP_ID_THREE" ];
		//[ "TASKCALLFOUR", Laptop_jankos ] remoteExec [ "KLT_fnc_handleHoldAction", [ 0, -2 ] select isDedicated, "intelActionJIP_ID_FOUR" ]; //Door Terminal
		//[ "TASKCALLFIVE", nikos ] remoteExec [ "KLT_fnc_handleHoldAction", [ 0, -2 ] select isDedicated, "intelActionJIP_ID_FIVE" ]; //Nikos
		//[ "TASKCALLSIX", Arty_LAP ] remoteExec [ "KLT_fnc_handleHoldAction", [ 0, -2 ] select isDedicated, "intelActionJIP_ID_FIVE" ]; //Artillery Laptop
	};
	





	//TASK 1 LAPTOP ============================================================================================================================================
	case "TASKCALLONE" : {
		
		private _holdActionID = [
		    _object, // Name of the object
		    "Start data transfer", //Title of Action
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // The Icon Shown on screen (Check Description for this Icon!)
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //Progress Icon shown on screen (Changes Icon when you start the Action)
		    "_this distance _target < 5", //The Condition for the Action to be Shown
		    "_this distance _target < 5", //The Condition for the Action to Progress
		    {
			}, // The Code executed when the action starts (We will not use this right now)
		    {}, // The code executed on every Progress tick (We will not use this right now)
		    //The code executed on Completion
		    {
		        //Object action is attach to
		        params ["_intelObject"];
		
		        //Remove intel holdAction from JIP queue
		        remoteExec[ "", "intelActionJIP_ID" ];
		        [ "REM", _intelObject ] remoteExec[ "KLT_fnc_handleHoldAction", 0 ];
			
			[ [], {
		    null = [device] execVM "AL_gravity\gravity_generator.sqf";
			sleep 30;
			[device] call klt_fnc_killDevice;
			sleep 5; 
			null = [device] execVM "AL_gravity\gravity_ray.sqf";
        	}] remoteExec ["BIS_fnc_spawn", 0, true];


			sleep 40;
		
		[ [], {
		   20 setFog 0.2;
        	}] remoteExec ["BIS_fnc_spawn", 2, true];
			


			
		    },
		    {hint "You let go of the action Key!"}, // The code Executed when the player is Interrupted (Player Lets go of key)
		    [], // Arguments Passed to script ( We will not use this right now)
		    5, // The Duration (How long will it take for the Action to be Completed in Seconds)
		    10, //Priority
		    true, // Remove the Action when the Action has been Complete (True or false)
		    false // Show in Unconscious State (Unsure about this too but false works:)
		] call BIS_fnc_holdActionAdd;
		
		//Store holdActionID on object for each client
		_object setVariable[ "intelActionID", _holdActionID ];
	};



//==========================================================================================================================================
	
	//Remove holdAction 1
	case "REM" : {
		
		//Get holdAction ID from object
		_holdActionID = _object getVariable[ "intelActionID", -1 ];
		
		//If we have a valid ID
		if ( _holdActionID >= 0 ) then {
			//Remove the holdAction
			[ _object, _holdActionID ] call BIS_fnc_holdActionRemove;
		};
	};



//=========================================================================================================================================
/*	//INTEL 2
	//TASK 2 ENEMY BASE ======================================================================================================================================
	case "TASKCALLTWO" : {
		
		private _holdActionID = [
		    _object, // Name of the object
		    "Hack Laptop", //Title of Action
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // The Icon Shown on screen (Check Description for this Icon!)
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //Progress Icon shown on screen (Changes Icon when you start the Action)
		    "_this distance _target < 5", //The Condition for the Action to be Shown
		    "_this distance _target < 5", //The Condition for the Action to Progress
		    {
			}, // The Code executed when the action starts (We will not use this right now)
		    {}, // The code executed on every Progress tick (We will not use this right now)
		    //The code executed on Completion
		    {
		        //Object action is attach to
		        params ["_intelObject"];
		        //Remove intel holdAction from JIP queue
		        remoteExec[ "", "intelActionJIP_ID_TWO" ];
		        //Remove holdAction from current connected clients
		        [ "REM_TWO", _intelObject ] remoteExec[ "KLT_fnc_handleHoldAction", 0 ];
		
		        [ [], {
            hint "Intel collected see Diary Intel entry";
            
		player createDiarySubject ["Intel","Intel"];
            player createDiaryRecord ["Intel", ["Documents",
                "<br/> According to theese documents the warlord
				<br/> Sebastian Nikos is in the province. 
				<br/> Some of the smuggler hideouts have been marked on the map.
				<br/> <marker name= 'Hideout_1_marker'>Hideout</marker>
				<br/>
				<br/><img image='img\intel7.jpg' />
				
				 "
            ]];
        }] remoteExec ["BIS_fnc_spawn", 0, true]; 

			["taskName2","SUCCEEDED",true] call BIS_fnc_taskSetState;
			taskstate2 = "taskName1" call BIS_fnc_taskCompleted;
			publicvariable "taskstate2";

			sleep 2; 
			//[] call KLT_fnc_task_3;
		
		
		    },
		    {
				hint "You let go of the action Key!";
			
			}, // The code Executed when the player is Interrupted (Player Lets go of key)
		    [], // Arguments Passed to script ( We will not use this right now)
		   20, // The Duration (How long will it take for the Action to be Completed in Seconds)
		    10, //Priority
		    true, // Remove the Action when the Action has been Complete (True or false)
		    false // Show in Unconscious State (Unsure about this too but false works:)
		] call BIS_fnc_holdActionAdd;
		
		//Store holdActionID on object for each client
		_object setVariable[ "intelActionID_TWO", _holdActionID ];
	};


	//Remove holdAction 2
	case "REM_TWO" : {
		
		//Get holdAction ID from object
		_holdActionID = _object getVariable[ "intelActionID_TWO", -1 ];
		
		//If we have a valid ID
		if ( _holdActionID >= 0 ) then {
			//Remove the holdAction
			[ _object, _holdActionID ] call BIS_fnc_holdActionRemove;
		};
	};



//======================

//=========================================================================================================================================
//TASK 3 ======================================================================================================================================
	case "TASKCALLTHREE" : {
		
		private _holdActionID = [
		    _object, // Name of the object
		    "Interrogate", //Title of Action
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // The Icon Shown on screen (Check Description for this Icon!)
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //Progress Icon shown on screen (Changes Icon when you start the Action)
		    "_this distance _target < 5", //The Condition for the Action to be Shown
		    "_this distance _target < 5", //The Condition for the Action to Progress
		    {

				
 


			}, // The Code executed when the action starts (We will not use this right now)
		    {}, // The code executed on every Progress tick (We will not use this right now)
		    //The code executed on Completion
		    {
		        //Object action is attach to
		        params ["_intelObject"];
		        //Remove intel holdAction from JIP queue
		        remoteExec[ "", "intelActionJIP_ID_THREE" ];
		        //Remove holdAction from current connected clients
		        [ "REM_THREE", _intelObject ] remoteExec[ "KLT_fnc_handleHoldAction", 0 ];
		
		   
		      




[]spawn {   
[HVT,"Acts_ExecutionVictim_Loop" 
] remoteExec ["switchMove", 0,true]; 
 
 
 
_player = [HVT] call KLT_fnc_findNearest; 
[HVT] remoteExecCall ["disableCollisionWith", 0, _player];
[_player] remoteExecCall ["disableCollisionWith", 0,HVT];
 HVT attachTo [_player, [0, 0.3, 0] ]; 
_dir = HVT getDir _player; 
HVT setFormDir 300;
_pos = player modelToWorld [0,0.2,0];

HVT setpos _pos;
 
[_player,"Acts_Executioner_Squat" 
] remoteExec ["playmove", 0,true]; 
 
sleep 15; 
[HVT,"Acts_ExecutionVictim_Backhand"  
] remoteExec ["playmove", 0,true]; 
 
[_player,"Acts_Executioner_Backhand"  
] remoteExec ["playmove", 0,true]; 

_players = [HVT] call KLT_fnc_findClosestPlayers;
 		[ [], {
			[ ["Unknown Man","Alright, fuck that hurts..",0],["Interrogator","Where is Sebastian Nikos!?",3],["Unknown Man","I don´t know man, but I know that something is gonna go down in Hööpakka",6],["Unknown Man","Nikos said that there where a family there that needs to be eliminated.. thats all I know man..",10]  ] call KLT_fnc_showSubtitle_EXP;

        }] remoteExec ["BIS_fnc_spawn",  _players, true];
 
[HVT,"Acts_ExecutionVictim_Forehand"  
] remoteExec ["playmove", 0,true]; 
 
[_player,"Acts_Executioner_Forehand"  
] remoteExec ["playmove", 0,true]; 
 
sleep 10; 
 
 
  detach HVT; 
[_player,""  
] remoteExec ["switchMove", 0,true]; 
 HVT setFormDir 180;
[HVT,"" 
] remoteExec ["switchMove", 0,true]; 


[HVT] remoteExecCall ["enableCollisionWith", 0, _player];
[_player] remoteExecCall ["enableCollisionWith", 0, HVT];



[] remoteexec ["KLT_fnc_task_7",2];

};



		    },
		    {hint "You let go of the action Key!"}, // The code Executed when the player is Interrupted (Player Lets go of key)
		    [], // Arguments Passed to script ( We will not use this right now)
		    1, // The Duration (How long will it take for the Action to be Completed in Seconds)
		    10, //Priority
		    true, // Remove the Action when the Action has been Complete (True or false)
		    false // Show in Unconscious State (Unsure about this too but false works:)
		] call BIS_fnc_holdActionAdd;
		
		//Store holdActionID on object for each client
		_object setVariable[ "intelActionID_THREE", _holdActionID ];
	};


	//Remove holdAction 3
	case "REM_THREE" : {
		
		//Get holdAction ID from object
		_holdActionID = _object getVariable[ "intelActionID_THREE", -1 ];
		
		//If we have a valid ID
		if ( _holdActionID >= 0 ) then {
			//Remove the holdAction
			[ _object, _holdActionID ] call BIS_fnc_holdActionRemove;
		};
	};





//TASK 4 ======================================================================================================================================
	case "TASKCALLFOUR" : {
		
		private _holdActionID = [
		    _object, // Name of the object
		    "Hack Laptop", //Title of Action
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // The Icon Shown on screen (Check Description for this Icon!)
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //Progress Icon shown on screen (Changes Icon when you start the Action)
		    "_this distance _target < 5", //The Condition for the Action to be Shown
		    "_this distance _target < 5", //The Condition for the Action to Progress
		    {}, // The Code executed when the action starts (We will not use this right now)
		    {}, // The code executed on every Progress tick (We will not use this right now)
		    //The code executed on Completion
		    {
		        //Object action is attach to
		        params ["_intelObject"];
		        //Remove intel holdAction from JIP queue
		        remoteExec[ "", "intelActionJIP_ID_FOUR" ];
		        //Remove holdAction from current connected clients
		        [ "REM_FOUR", _intelObject ] remoteExec[ "KLT_fnc_handleHoldAction", 0 ];


				Hint "You found some intel regarding Nikos";
				[]remoteExec ["KLT_fnc_task_8",2];
		
		    },
		    {hint "You let go of the action Key!"}, // The code Executed when the player is Interrupted (Player Lets go of key)
		    [], // Arguments Passed to script ( We will not use this right now)
		    10, // The Duration (How long will it take for the Action to be Completed in Seconds)
		    10, //Priority
		    true, // Remove the Action when the Action has been Complete (True or false)
		    false // Show in Unconscious State (Unsure about this too but false works:)
		] call BIS_fnc_holdActionAdd;
		
		//Store holdActionID on object for each client
		_object setVariable[ "intelActionID_FOUR", _holdActionID ];
	};


	//Remove holdAction 4
	case "REM_FOUR" : {
		
		//Get holdAction ID from object
		_holdActionID = _object getVariable[ "intelActionID_FOUR", -1 ];
		
		//If we have a valid ID
		if ( _holdActionID >= 0 ) then {
			//Remove the holdAction
			[ _object, _holdActionID ] call BIS_fnc_holdActionRemove;
		};
	};





	case "TASKCALLFIVE" : { //CHANGE
		
		private _holdActionID = [
		    _object, 
		    "Capture", //Object
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // The Icon Shown on screen (Check Description for this Icon!)
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //Progress Icon shown on screen (Changes Icon when you start the Action)
		    "_this distance _target < 5", //The Condition for the Action to be Shown
		    "_this distance _target < 5", //The Condition for the Action to Progress
		    {}, // The Code executed when the action starts (We will not use this right now)
		    {}, // The code executed on every Progress tick (We will not use this right now)
		    //The code executed on Completion
		    {
		       
		         //Object action is attach to
		        params ["_intelObject"];
		        //Remove intel holdAction from JIP queue
		        remoteExec[ "", "intelActionJIP_ID_FIVE" ];
		        //Remove holdAction from current connected clients
		        [ "REM_FIVE", _intelObject ] remoteExec[ "KLT_fnc_handleHoldAction", 0 ];
		
		_players = [nikos] call KLT_fnc_findClosestPlayers;
		[ [], {
			[ ["Nikos","Hey, No need to get pissed, I surrender...",0]  ] call KLT_fnc_showSubtitle_EXP;
        }] remoteExec ["BIS_fnc_spawn",  _players, true];

		
		[]remoteexec ["klt_fnc_taskhandler8",2];

	

		
        		["ace_captives_setSurrendered",[nikos,true]] call CBA_fnc_globalEvent;
		
		    },
		    {hint "You let go of the action Key!"}, // The code Executed when the player is Interrupted (Player Lets go of key)
		    [], // Arguments Passed to script ( We will not use this right now)
		    1, // The Duration (How long will it take for the Action to be Completed in Seconds)
		    10, //Priority
		    true, // Remove the Action when the Action has been Complete (True or false)
		    false // Show in Unconscious State (Unsure about this too but false works:)
		] call BIS_fnc_holdActionAdd;
		
		//Store holdActionID on object for each client
		_object setVariable[ "intelActionID_FIVE", _holdActionID ]; //Change
	};


	//Remove holdAction 5
	case "REM_FIVE" : {
		
		//Get holdAction ID from object
		_holdActionID = _object getVariable[ "intelActionID_FIVE", -1 ];
		
		//If we have a valid ID
		if ( _holdActionID >= 0 ) then {
			//Remove the holdAction
			[ _object, _holdActionID ] call BIS_fnc_holdActionRemove;
		};
	};

	
//==============================================================================================




case "TASKCALLSIX" : { //CHANGE
		
		private _holdActionID = [
		    _object, 
		    "Hack Laptop", //Object
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", // The Icon Shown on screen (Check Description for this Icon!)
		    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", //Progress Icon shown on screen (Changes Icon when you start the Action)
		    "_this distance _target < 5", //The Condition for the Action to be Shown
		    "_this distance _target < 5", //The Condition for the Action to Progress
		    {}, // The Code executed when the action starts (We will not use this right now)
		    {}, // The code executed on every Progress tick (We will not use this right now)
		    //The code executed on Completion
		    {
		       
		         //Object action is attach to
		        params ["_intelObject"];
		        //Remove intel holdAction from JIP queue
		        remoteExec[ "", "intelActionJIP_ID_SIX" ];
		        //Remove holdAction from current connected clients
		        [ "REM_SIX", _intelObject ] remoteExec[ "KLT_fnc_handleHoldAction", 0 ];
		
		
				_imag  = "<img color='#ff0000' size='2' image='img\arty.jpg' align='center'/>";
				_text = "<t color='#ff0000' size='1.2' align='center'>You have found some special intel</t><br/><br/>";
				hint parseText (_imag + _text);


			 [ [], {
        
            
		player createDiarySubject ["Intel","Intel"];
            player createDiaryRecord ["Intel", ["Artillery Position",
                "<br/> According to previous communications from the radar base 
				<br/> found on a laptop.
				<br/> the criminals have got their hands on some serious equipment.
				<br/> we are talking about the 2S3M1 Artillery tank.
				<br/> This is not a priority task but if we can we should definetly 
				<br/> make sure theese vehicles cannnot be used against us.
				<br/> <marker name= 'arty_marker'>Artillery Position</marker>
				<br/>
				<br/><img image='img\arty.jpg' />
				
				 "
            ]];
        }] remoteExec ["BIS_fnc_spawn", 0, true]; 
				



		
		    },
		    {hint "You let go of the action Key!"}, // The code Executed when the player is Interrupted (Player Lets go of key)
		    [], // Arguments Passed to script ( We will not use this right now)
		    15, // The Duration (How long will it take for the Action to be Completed in Seconds)
		    10, //Priority
		    true, // Remove the Action when the Action has been Complete (True or false)
		    false // Show in Unconscious State (Unsure about this too but false works:)
		] call BIS_fnc_holdActionAdd;
		
		//Store holdActionID on object for each client
		_object setVariable[ "intelActionID_SIX", _holdActionID ]; //Change
	};


	//Remove holdAction 6
	case "REM_SIX" : {
		
		//Get holdAction ID from object
		_holdActionID = _object getVariable[ "intelActionID_SIX", -1 ];
		
		//If we have a valid ID
		if ( _holdActionID >= 0 ) then {
			//Remove the holdAction
			[ _object, _holdActionID ] call BIS_fnc_holdActionRemove;
		};
	};

	*/
};



