

//Force Flashlights
[] spawn {
while {true} do {
{
   if(side _x == east) then
   {
        _x unassignItem "NVGoggles";
        _x removeItem "NVGoggles";
        _x unassignItem "NVGoggles_OPFOR";
        _x removeItem "NVGoggles_OPFOR";
        _x unassignItem "NVGoggles_INDEP";
        _x removeItem "NVGoggles_INDEP";

        _x RemovePrimaryWeaponItem "acc_pointer_IR";
        _x addPrimaryWeaponItem "acc_flashlight";
        _x enableGunLights "forceon";
      
   };
} foreach (allUnits);

sleep 35;
};
};


