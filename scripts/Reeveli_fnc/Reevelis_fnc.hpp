/*
 * Author: Reeveli 
 * Reeveli's custom function definitions.

1.9S
    Added aperture_dialog
    Added aperture_init
1.8S
    Added Sound_browser 
1.7S
    Added function for rock throwers
1.6S
    Removed Rev_smokes functions
1.5
    Rev_fnc_locationDialogRemove removed
    Rev_fnc_locationCuratorRemove added
1.4
    Added map location functions
1.3
    Added Ace moaning function
1.2
    Added new radio freq retention function
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
		class radio_arsenal {};	
		class transferRadiosAcrossRespawn {postInit=1;};	
	};
    class Editor
	{
		file="scripts\Reeveli_fnc\Rev_editor";
        class icon_viewer {};
        class module_preview {};
        class module_preview_2 {};
        class module_preview_3 {};
        class replaceWithAgent {};
        class replaceWithSimple {};
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

    class Locations
	{
		file="scripts\Reeveli_fnc\Rev_locations";
        class locationCuratorRemove {};
        class locationDialogNew {};
        class locationName {};
        class locationNew {};
        class locationRemove {};
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

    class Moaning
	{
		file="scripts\Reeveli_fnc\Rev_moaning";
        class moaning_init {postInit = 1;};	 
	};

    class Sound_browser
	{
		file="scripts\Reeveli_fnc\Rev_soundBrowser"; 
        class soundB_filter {};
        class soundB_init {};
        class soundB_lbSelect {};	
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

    class Throwers
	{
		file ="scripts\Reeveli_fnc\Rev_throwers";
        class initThrowers {preinit = 1;};
        class makeThrower {};
        class throwerStatus {};
        class throwRock {};
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
        class aperture_dialog {};
        class aperture_init {postinit = 1;};
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