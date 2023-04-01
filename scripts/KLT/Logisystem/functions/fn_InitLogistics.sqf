if ((isserver) && (!isdedicated) ) then {
    systemchat "Logisystem Active";
};
 

[] spawn 
{
	private ["_Actioncheck","_managed_trucks", "_managed_boxes", "_managed_areas", "_next_truck", "_next_box", "_truck_load", "_checked_trucks", "_checked_boxes", "_action_id","_action_id2","_action_id3","_action_id4","_b_action_id1","_b_action_id2","_b_action_id3","_b_action_id4"];
	//Set class Variables
	[] call compileFinal preprocessFileLineNumbers "scripts\klt\Logisystem\CONFIG.sqf";

	//Make Objects Carryable
	{
		[_x, "init", KLT_fnc_DragCarry, true, [], true] call CBA_fnc_addClassEventHandler;
	} forEach klt_logistics_crates;


	// Misc
	klt_logistics_transports                      = klt_logistics_transports                    select {[_x select 0] call KLT_fnc_checkClass};
	KLT_transport_classes                         = klt_logistics_transports                    apply {toLower (_x select 0)};

	KLT_Logi_crates            					  = klt_logistics_crates;
	KLT_Logi_crates            					  = KLT_Logi_crates              				apply {toLower _x};

	_managed_trucks = [];
	_managed_boxes = [];


	while {Activate_Logisystem} do 
	
	{
		//General variables
		_nearammoboxes = ((getpos player) nearEntities [KLT_Logi_crates, 5]);
        _neartransporttrucks = ((getpos player) nearEntities [KLT_transport_classes, 10]);

		_checked_trucks = [];

		if (((count _neartransporttrucks) > 0) ) then {
			_trucksDistance = player distance2d (_neartransporttrucks select 0); 
			if (_trucksDistance < 8) then {Actioncheck = true};
		} else {Actioncheck = false};
		

		//Trucks 
		{
			
            _next_truck = _x;
            _truck_load = _next_truck getVariable ["KLT_ammo_truck_load", 0];

            if (!(_next_truck in _managed_trucks) && (_truck_load > 0)) then {

					//Old Action
                    //_action_id = _next_truck addAction ["<t color='#FFFF00'>" + "Unload Crate" + "</t>","scripts\KLT\Logisystem\scripts\do_unload_truck.sqf","",-500,true,true,"","(_this distance _target < 8) && (vehicle player == player)"];

					_action_id = 
					[_next_truck,
 					"Unload Crate",
  					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
   					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa",
    				"(_this distance _target < 8) && (vehicle player == player) && (Activate_Logisystem)",									// Condition for the action to be shown
	 				"(_this distance _target < 8) && (vehicle player == player) && (Activate_Logisystem)", 								// Condition for the action to progress
	  				{ hint "Unloading Crate" }, 		// Code executed when action starts
	   				{},  								// Code executed on every progress tick
	    			{[_this select 0] spawn KLT_fnc_do_unload_truck},								// Code executed on completion
		 			{hint "Action aborted!";  },								// Code executed on interrupted
		  			[],								// Arguments passed to the scripts as _this select 3
		   			2, 								// Action duration [s]
		   			-501,								// Priority
		    		false,							// Remove on completion
			 		false							// Show in unconscious state 
			 		] call BIS_fnc_holdActionAdd;

                    _next_truck setVariable [ "KLT_ammo_truck_action", _action_id, false ];
                    _managed_trucks pushback _next_truck;
            };

            if ((_next_truck in _managed_trucks) && _truck_load == 0) then {
                //_next_truck removeAction (_next_truck getVariable ["KLT_ammo_truck_action", -1]);
				[ _next_truck,(_next_truck getVariable ["KLT_ammo_truck_action", -1]) ] call BIS_fnc_holdActionRemove;
                _managed_trucks = _managed_trucks - [_next_truck];
            };

            _checked_trucks pushback _next_truck;

        } foreach _neartransporttrucks;

		

		//Crates 
		_checked_boxes = [];

        {
            _next_box = _x;
            if (!(_next_box in _managed_boxes) && ( isNull  attachedTo _next_box )) then {
                
				//Old Action
				//_b_action_id1 = _next_box addAction ["<t color='#FFFF00'>" + "Load Crate" + "</t>",{[_this select 0] call KLT_fnc_do_load_box;},"",-501,true,true,"","(_this distance _target < 5) && (vehicle player == player)"];
               _b_action_id1 = 
					[_next_box,
 					"Load Crate",
  					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loaddevice_ca.paa",
   					"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_loaddevice_ca.paa",
    				"(_this distance _target < 3) && (vehicle player == player) && (Activate_Logisystem) && (Actioncheck)",									// Condition for the action to be shown
	 				"(_this distance _target < 3) && (vehicle player == player) && (Activate_Logisystem) && (Actioncheck)", 								// Condition for the action to progress
	  				{ hint "Loading Crate" }, 																	// Code executed when action starts
	   				{},  																						// Code executed on every progress tick
	    			{[_this select 0] spawn KLT_fnc_do_load_box;},												// Code executed on completion
		 			{hint "Action aborted!";  },																// Code executed on interrupted
		  			[],																							// Arguments passed to the scripts as _this select 3
		   			2, 																							// Action duration [s]
		   			10,																							// Priority
		    		false,																						// Remove on completion
			 		false																						// Show in unconscious state 
			 		] call BIS_fnc_holdActionAdd;

                _next_box setVariable ["KLT_ammo_box_action", _b_action_id1, false];
               

                _managed_boxes pushback _next_box;
            };

            _checked_boxes pushback _next_box;
        } foreach _nearammoboxes;

        {
            _next_box = _x;
            if (!(_next_box in _managed_boxes) || !( isNull  attachedTo _next_box )) then {
                _managed_boxes = _managed_boxes - [_next_box];
               // _next_box removeAction (_next_box getVariable ["KLT_ammo_box_action", -1]);
				[ _next_box,(_next_box getVariable ["KLT_ammo_box_action", -1]) ] call BIS_fnc_holdActionRemove;
                
            }
        } foreach _managed_boxes;
sleep 2;

	};

};