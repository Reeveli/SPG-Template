


klt_fnc_MakeThrower =
{
	Params ["_unit"]; 
    [_unit] spawn 
 {
      Params ["_unit"]; 
    If (isServer) then  
    { 
       
        
        while {alive _unit} do 
        {
        
            private _headlessClients = entities "HeadlessClient_F"; 
            private _humanPlayers = allPlayers - _headlessClients; 
            _switch = false; 
                while {!_switch} do  
                { 
                    {if ((_x distance2d _unit) < 10) then {_switch = true;}} foreach _humanPlayers; 
                    sleep 1; 
                }; 
                
                Waituntil {_switch}; 
            
            [_unit] spawn klt_throwRock; 
            sleep 10;
        };
    };
 };
};



