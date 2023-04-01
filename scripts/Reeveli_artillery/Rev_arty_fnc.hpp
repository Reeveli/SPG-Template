
class Rev_arty
{  

    class Air_support
    {
        file="scripts\Reeveli_artillery\User_artillery\Air_support";
        class air_disconnect {};
        class air_loadout_parse {};
        class air_map_dialog_onUnload {};
        class air_map_dialog {};
        class air_selection {};
        class air_start {};
    };

    class Area_bombing
    {
        file="scripts\Reeveli_artillery\User_artillery\Area_bombing";
        class bomb_map_dialog_onUnload {};
        class bomb_map_dialog {};
        class bomb_ordance {};
        class bomb_pattern {};
        class bomb_plane {};
    }; 
    class Artillery
    {
        file="scripts\Reeveli_artillery";
        class flare_effect {};
        class player_init {preInit=1;};
        class react {};
        class smoke_effect {};
    };

    class Artillery_dialog
    {
        file="scripts\Reeveli_artillery\User_artillery\Artillery_dialog";
        class dialog {};
        class dialog_gps {};
        class dialog_light {};
        class dialog_onUnload {};
        class dialog_pen {};
        class dialog_update {};
    };

    class Barrages
    {
        file="scripts\Reeveli_artillery\User_artillery\Barrages";
        class barrage_HE {};
        class barrage_ILM {};
        class barrage_SMK {};
    };

    class Briefing
    {
        file="scripts\Reeveli_artillery\User_artillery\Briefing";
        class dynamic_briefing {postInit=1;};
    };

    class Gunship
    {
        file="scripts\Reeveli_artillery\User_artillery\Gunship";
        class gunship_end {};
        class gunship_loiter {};
        class gunship_map_dialog_onUnload {};
        class gunship_map_dialog {};
        class gunship_start {};
    };

    class Missile
    {
        file="scripts\Reeveli_artillery\User_artillery\Missile";
        class missile_guidance {};
        class missile_impact {};
        class missile_launch {};
        class missile_map_dialog_onUnload {};
        class missile_map_dialog {};
        class missile_pitch {};
        class missile_selection {};
    };

    class Napalm
    {
        file="scripts\Reeveli_artillery\Napalm";
        class napalm_effect {};
        class napalm_fire {};
        class napalm_hit {};
        class napalm_vehicles {};
    };

    class Resupply
	{
		file="scripts\Reeveli_artillery\User_artillery\Resupply";
        class filter_added {};
        class filter_clear {};
        class filter_search {};
        class filter_weapon {};
        class filter {};
        class supply_add {};
        class supply_create {};
        class supply_dialog_onUnload {};
        class supply_dialog {};
        class supply_list {};
        class supply_map_dialog_onLBSelChanged {};
        class supply_map_dialog_onUnload {};
        class supply_map_dialog {};
        class supply_mass {};
        class supply_sort_amount {};
        class supply_sort_name {};
        class supply_transport {};
        class supply_weapon_check {};
	};

    class Shell_drops
    {
        file="scripts\Reeveli_artillery\User_artillery\Shell_drops";
        class shell_HE {};
        class shell_ILM {};
        class shell_SMK {};
    };

    class Types
    {
        file="scripts\Reeveli_artillery\User_artillery\Types";
        class type_AIR {};
        class type_BOM {};
        class type_GUN {};
        class type_HE {};
        class type_ILM {};
        class type_MIS {};
        class type_SMK {};
        class type_SUP {};
    };

    class User_artillery
    {
        file="scripts\Reeveli_artillery\User_artillery";
        class user_completed {};
        class user_condition {};
        class server_init {postInit=1;};
    };

    class Warhead
    {
        file="scripts\Reeveli_artillery\User_artillery\Missile\Warhead";
        class warhead_crater {};        
        class warhead_effect_buc {};        
        class warhead_effect_fum {};
        class warhead_fire {};
        class warhead_init {};
        class warhead_trail {};
        class warhead_trail_2 {};
    };

    class Zeus_artillery
    {
        file="scripts\Reeveli_artillery\Zeus_artillery";
        class zeus_air_strike {};
        class zeus_artillery {};
        class zeus_bomber {};
        class zeus_missile {};
        class zeus_trp_dialog {};
        class zeus_type_CLU {};
        class zeus_type_HE {};
        class zeus_type_ILM {};
        class zeus_type_SMK {};
    };    
};

