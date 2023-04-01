class Rev_RZ
{
    class Resticted_zeus
	{
		file="scripts\Reeveli_fnc\Rev_restricted_zeus";
		class modules_init {postInit=1;};
	};
    class group_attributes
	{
		file="scripts\Reeveli_fnc\Rev_restricted_zeus\group_attributes";
        class button_ok {};
        class group_button {};
        class group_dialog {};
	};
	class promotion
	{
		file="scripts\Reeveli_fnc\Rev_restricted_zeus\promotion";
        class init_player {};
		class init_server {};
		class post_player {};
	};
    class vehicle_attributes
	{
		file="scripts\Reeveli_fnc\Rev_restricted_zeus\vehicle_attributes";
        class vehicle_ok {};
        class vehicle_button {};
        class vehicle_dialog {};
	};
};