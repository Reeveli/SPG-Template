if (!(isnil "zen_custom_modules_fnc_register")) then {

	["Killets Duststorm", "Create duststorm object", {[_this select 0] call klt_fnc_small_Sandstorm}] call zen_custom_modules_fnc_register;
	//["Killets Duststorm", "Create global duststorm", {[_this select 0] call MWD_TrackedModule}] call zen_custom_modules_fnc_register;

	["Killets Duststorm", "Create a globalstorm", {[_this select 0,_this select 1] call klt_fnc_showdialog},"\a3\Ui_f\data\GUI\Cfg\Hints\Use_ca.paa"] call zen_custom_modules_fnc_register;


};