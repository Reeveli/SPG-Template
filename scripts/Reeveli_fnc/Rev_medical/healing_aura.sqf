
while {true} do {
  array_hospitals = array_hospitals - [objNull];
  {
    {
      [_x] call Rev_fnc_heal; //function, remember to define in description
    }
	forEach (position _x nearEntities ["Man", 10]);
  } 
  
forEach array_hospitals;

sleep 4;
};
