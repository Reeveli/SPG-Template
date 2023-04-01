class Rev_markers2
{
    class Markers
	{
		file="scripts\Reeveli_fnc\Rev_markers_script";
        class control {};
        class diary {postinit = 1;};
		class removal {postinit = 1;};
	};

    class Markers_dialog
	{
		file="scripts\Reeveli_fnc\Rev_markers_script\Markers_dialog";
		class Array_create {};
		class Array_load {};
		class clear {};
        class delete_all {};
        class delete {};
        class get_saved {};
        class load {};
        class menu_channels {};
        class menu_start {};
        class save {};     
		class set_channel {};   
		class update_menu {};   
        class world_list {};
		class worlds {};
	};
};