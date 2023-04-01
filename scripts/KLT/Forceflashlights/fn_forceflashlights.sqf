   params ["_unit"];

   _unit unassignItem "NVGoggles";
   _unit removeItem "NVGoggles";
   _unit unassignItem "NVGoggles_OPFOR";
   _unit removeItem "NVGoggles_OPFOR";
   _unit unassignItem "NVGoggles_INDEP";
   _unit removeItem "NVGoggles_INDEP";

   _unit RemovePrimaryWeaponItem "acc_pointer_IR";
   _unit addPrimaryWeaponItem "acc_flashlight";
   _unit enableGunLights "forceon";