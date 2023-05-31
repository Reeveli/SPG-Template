/*
 * Author: Reeveli 
 * Reeveli's custom function definitions.

1.1 SPG
    Added teleportation system functions
 */



class Rev
{
    class Old_Achilles
	{
		file="scripts\Reeveli_fnc\Old_Achilles";
        class checkLineOfFire2D {};
        class forceWeaponFire {};
        class getWeaponsMuzzlesMagazines {};
        class SuppressiveFire {};

	};    
    class admin
	{
		file="scripts\Reeveli_fnc\Rev_admin";
        class admin_client_init {postInit=1;};
        class admin_init {postInit=1;};
        class admin_permission {};
        class admin_preinit {preInit=1;};
        class admin_zeus {};
        class admin_zeus_button {};
	}; 
    class Arsenal
	{
		file="scripts\Reeveli_fnc\Rev_arsenal";
		class ACE_arsenal {postInit=1;};		
		class radio_arsenal {};		
	};
    class Editor
	{
		file="scripts\Reeveli_fnc\Rev_editor";
        class icon_viewer {};
        class module_preview {};
        class module_preview_2 {};
        class module_preview_3 {};
        class replaceWithAgent {};
	};

    class Gestures
	{
		file="scripts\Reeveli_fnc\Rev_gestures";
		class advanced_gestures_remote {postInit = 1;};	
		class advanced_gestures {postInit = 1;};	
	};

    class Grass_removal
	{
		file="scripts\Reeveli_fnc\Rev_grass_removal";
		class grass_removal {postInit = 1;};	
	};

    class Halo
	{
		file="scripts\Reeveli_fnc\Rev_halo";
		class embark {};
		class jump {};
		class halo_plane {};
        class halo_start {};
		class transport_check {};
	};

    class Medical
	{
		file="scripts\Reeveli_fnc\Rev_medical";
		class heal {};
        class heal_area {};
        class injury {};
        class set_ACE_injury {};	
        class treatmentHints {postInit = 1;};	
	};

    class Miscellaneous
	{
		file="scripts\Reeveli_fnc\Rev_misc";
        class camofaces {};
        class check_distance_players {};
        class check_los_players {};
        class info_panel {};
	};

    class Smokes
	{
		file="scripts\Reeveli_fnc\Rev_smokes";
        class vehicle_weapons {};
        class smoke_launcher {};
	};

    class Supperssion
	{
		file ="scripts\Reeveli_fnc\Rev_suppress";
        class suppress_init {postinit = 1;};
        class suppress {};
	};

    class Teleport
	{
		file ="scripts\Reeveli_fnc\Rev_teleport";
        class tp_addAction {};
        class tp_addPoint {};
        class tp_deletePoint {};
        class tp_listCheck {};
		class tp_onButtonClick {};
		class tp_onLBSelChanged {};
        class tp_onLoad {};
        class tp_teleport {};
        class tp_ZEN_dialog {};
	};

    class Vehicles
	{
		file ="scripts\Reeveli_fnc\Rev_vehicles";
        class vehicles_offRoad_init {};
        class vehicles_offRoad {};
	};

    class Zeus
    {
        file="scripts\Reeveli_fnc\Rev_zeus";
        class blackout_dialog {};
        class blackout {};
        class gui_suppressive_fire {};
        class end_mission {}; 
        class group_suppress {};
        class group_surrender {}; 
        class halo_module {};  
		class postProcessing {};         
        class spectator {};
		class zeus_init {postinit = 1;};

    };

    class Ping_list {
        file ="scripts\Reeveli_fnc\Rev_zeus\Ping_list";
        class pingList_init {postinit = 1;};
        class pingList_onButtonClick {};
        class pingList_onLBSelChanged {};
        class pingList_onLoad {};
    };

    class Zeus_Resupply {
        file ="scripts\Reeveli_fnc\Rev_zeus_resupply";
        class resupply_box {};
        class resupply_dialog {};
        class resupply_drop {};
        class resupply {};
    };

};
///////////////Flashbang///////////////
class AL 
{
    class flashbang
	{
		file="scripts\Reeveli_fnc\AL_grenades";
        class flash_init {postInit=1;};
        class stun_grenade {};
        class stun_life {};

	};
};