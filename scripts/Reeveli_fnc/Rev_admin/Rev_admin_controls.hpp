class Rev_admin_panel: ctrlControlsGroupNoScrollbars
{	
	x = 1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX);
	y = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY);
	w = 15 * (((safezoneW / safezoneH) min 1.2) / 40);
	h = 17 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
	
	class controls
	{
		class Rev_admin_title: RscText
		{
			moving = false;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			text = "SPG Admin Panel";
			x = 0;
			y = 0;
			w = 10 * (((safezoneW / safezoneH) min 1.2) / 40);
			h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
		};
		class Rev_admin_bg: Rev_admin_title
		{
			text = "";
			colorBackground[] = {0,0,0,0.7};
			y = 1.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			h = 5.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
		};
		class Rev_admin_version: Rev_admin_title
		{	
			onLoad = "params ['_control','_config']; _control ctrlSetText format ['SPG Script Version: %1',getText (missionConfigFile >> 'scriptVersion')];";
			text = "";
			colorBackground[] = {0,0,0,0};
			y = 1.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
		};
		class Rev_admin_server_fps: Rev_admin_title
		{	
			onLoad = "params ['_control','_config']; localNamespace setVariable ['Rev_admin_s_fps_pfeh',[{params ['_control'];[_control] spawn {params ['_control'];_control ctrlSetText format ['Server FPS: %1',[missionNamespace, 'Rev_admin_server_fps', nil] call BIS_fnc_getServerVariable];};}, 5, _control] call CBA_fnc_addPerFrameHandler];";
			onDestroy = "private _eh = localNamespace getVariable ['Rev_admin_s_fps_pfeh', -1]; [_eh] call CBA_fnc_removePerFrameHandler;";
			text = "Server FPS: Fetching value";
			colorBackground[] = {0,0,0,0};
			y = 2.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
		};
		class Rev_admin_client_fps: Rev_admin_server_fps
		{	
			onLoad = "params ['_control','_config']; localNamespace setVariable ['Rev_admin_c_fps_pfeh',[{params ['_control'];_control ctrlSetText format ['Client FPS: %1',round diag_fps];}, 5, _control] call CBA_fnc_addPerFrameHandler];";
			onDestroy = "private _eh = localNamespace getVariable ['Rev_admin_c_fps_pfeh', -1]; [_eh] call CBA_fnc_removePerFrameHandler;";
			colorBackground[] = {0,0,0,0};
			y = 3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
		};
		class Rev_admin_time: Rev_admin_server_fps
		{	
			onLoad = "params ['_control','_config']; localNamespace setVariable ['Rev_admin_time_pfeh',[{params ['_control'];_control ctrlSetText format ['Mission Runtime: %1',[CBA_missionTime] call CBA_fnc_formatElapsedTime];}, 0, _control] call CBA_fnc_addPerFrameHandler];";
			onDestroy = "private _eh = localNamespace getVariable ['Rev_admin_time_pfeh', -1]; [_eh] call CBA_fnc_removePerFrameHandler;";
			colorBackground[] = {0,0,0,0};
			y = 4.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
		};
		class Rev_admin_button_curator: RscButtonMenu
		{
			idc = 6001;
			onLoad = "params ['_control','_config']; if !(call Rev_fnc_admin_permission) then {_control ctrlEnable false};";
			text = "Toggle Zeus";
			action = "call Rev_fnc_admin_zeus_button;";
			x = 0.2 * (((safezoneW / safezoneH) min 1.2) / 40);
			y = 5.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			w = 9.6 * (((safezoneW / safezoneH) min 1.2) / 40);
			h = 1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			colorBackground[] = {0,0,0,1};
		};
	};
};